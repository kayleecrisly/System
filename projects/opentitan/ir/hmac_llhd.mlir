module {
  hw.module private @prim_buf(in %in_i : i59, out out_o : i59) {
    hw.output %in_i : i59
  }
  hw.module private @prim_buf_16(in %in_i : i2, out out_o : i2) {
    hw.output %in_i : i2
  }
  hw.module private @prim_buf_18(in %in_i : i1, out out_o : i1) {
    hw.output %in_i : i1
  }
  hw.module private @prim_flop_2sync(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
  hw.module private @prim_flop_2sync_17(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %d_i_0 = llhd.sig name "d_i" %false : i1
    %d_o = llhd.sig %false : i1
    %1 = llhd.prb %d_o : i1
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_23(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_23(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
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
  hw.module private @prim_flop_23(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
    %u_prim_buf_in_req.out_o = hw.instance "u_prim_buf_in_req" @prim_sec_anchor_buf_11(in_i: %alert_req_i: i1) -> (out_o: i1) {sv.namehint = "alert_req"}
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
    %gen_async.i_sync_n.q_o = hw.instance "gen_async.i_sync_n" @prim_flop_2sync_17(clk_i: %2: i1, rst_ni: %3: i1, d_i: %diff_ni: i1) -> (q_o: i1)
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
  hw.module private @prim_fifo_sync_cnt(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %incr_wptr_i : i1, in %incr_rptr_i : i1, out wptr_o : i5, out rptr_o : i5, out full_o : i1, out empty_o : i1, out depth_o : i6, out err_o : i1) {
    %c1_i6 = hw.constant 1 : i6
    %c-1_i5 = hw.constant -1 : i5
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i6 = hw.constant 0 : i6
    %c0_i5 = hw.constant 0 : i5
    %false = hw.constant false
    %c-32_i6 = hw.constant -32 : i6
    %true = hw.constant true
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %clr_i_2 = llhd.sig name "clr_i" %false : i1
    %incr_wptr_i_3 = llhd.sig name "incr_wptr_i" %false : i1
    %incr_rptr_i_4 = llhd.sig name "incr_rptr_i" %false : i1
    %wptr_o = llhd.sig %c0_i5 : i5
    %rptr_o = llhd.sig %c0_i5 : i5
    %wptr_wrap_cnt_q = llhd.sig %c0_i6 : i6
    %wptr_wrap_set_cnt = llhd.sig %c0_i6 : i6
    %rptr_wrap_cnt_q = llhd.sig %c0_i6 : i6
    %rptr_wrap_set_cnt = llhd.sig %c0_i6 : i6
    %wptr_wrap_msb = llhd.sig %false : i1
    %rptr_wrap_msb = llhd.sig %false : i1
    %wptr_wrap_set = llhd.sig %false : i1
    %rptr_wrap_set = llhd.sig %false : i1
    %4 = llhd.prb %wptr_wrap_cnt_q : i6
    %5 = comb.extract %4 from 0 : (i6) -> i5
    llhd.drv %wptr_o, %5 after %1 : i5
    %6 = llhd.prb %rptr_wrap_cnt_q : i6
    %7 = comb.extract %6 from 0 : (i6) -> i5
    llhd.drv %rptr_o, %7 after %1 : i5
    %8 = comb.extract %4 from 5 : (i6) -> i1
    llhd.drv %wptr_wrap_msb, %8 after %1 : i1
    %9 = comb.extract %6 from 5 : (i6) -> i1
    llhd.drv %rptr_wrap_msb, %9 after %1 : i1
    %10 = llhd.prb %incr_wptr_i_3 : i1
    %11 = llhd.prb %wptr_o : i5
    %12 = comb.icmp eq %11, %c-1_i5 : i5
    %13 = comb.and %10, %12 : i1
    llhd.drv %wptr_wrap_set, %13 after %1 : i1
    %14 = llhd.prb %incr_rptr_i_4 : i1
    %15 = llhd.prb %rptr_o : i5
    %16 = comb.icmp eq %15, %c-1_i5 : i5
    %17 = comb.and %14, %16 : i1
    llhd.drv %rptr_wrap_set, %17 after %1 : i1
    %18 = llhd.prb %wptr_wrap_msb : i1
    %19 = comb.xor %18, %true : i1
    %20 = comb.concat %19, %c0_i5 : i1, i5
    llhd.drv %wptr_wrap_set_cnt, %20 after %1 : i6
    %21 = llhd.prb %rptr_wrap_msb : i1
    %22 = comb.xor %21, %true : i1
    %23 = comb.concat %22, %c0_i5 : i1, i5
    llhd.drv %rptr_wrap_set_cnt, %23 after %1 : i6
    %24 = comb.xor %6, %c-32_i6 : i6
    %25 = comb.icmp eq %4, %24 : i6
    %26 = comb.icmp eq %4, %6 : i6
    %27 = comb.icmp eq %18, %21 : i1
    %28 = comb.concat %false, %11 : i1, i5
    %29 = comb.concat %false, %15 : i1, i5
    %30 = comb.sub %28, %29 : i6
    %31 = comb.sub %c-32_i6, %29 : i6
    %32 = comb.add %31, %28 : i6
    %33 = comb.mux %27, %30, %32 : i6
    %34 = comb.mux %25, %c-32_i6, %33 : i6
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
      llhd.drv %wptr_wrap_cnt_q, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %46 = llhd.prb %clr_i_2 : i1
      cf.cond_br %46, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %wptr_wrap_cnt_q, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %47 = llhd.prb %wptr_wrap_set : i1
      cf.cond_br %47, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %48 = llhd.prb %wptr_wrap_set_cnt : i6
      llhd.drv %wptr_wrap_cnt_q, %48 after %0 : i6
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %49 = llhd.prb %incr_wptr_i_3 : i1
      cf.cond_br %49, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %50 = llhd.prb %wptr_wrap_cnt_q : i6
      %51 = comb.add %50, %c1_i6 : i6
      llhd.drv %wptr_wrap_cnt_q, %51 after %0 : i6
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
      llhd.drv %rptr_wrap_cnt_q, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %46 = llhd.prb %clr_i_2 : i1
      cf.cond_br %46, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %rptr_wrap_cnt_q, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %47 = llhd.prb %rptr_wrap_set : i1
      cf.cond_br %47, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %48 = llhd.prb %rptr_wrap_set_cnt : i6
      llhd.drv %rptr_wrap_cnt_q, %48 after %0 : i6
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %49 = llhd.prb %incr_rptr_i_4 : i1
      cf.cond_br %49, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %50 = llhd.prb %rptr_wrap_cnt_q : i6
      %51 = comb.add %50, %c1_i6 : i6
      llhd.drv %rptr_wrap_cnt_q, %51 after %0 : i6
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %clr_i_2, %clr_i after %1 : i1
    llhd.drv %incr_wptr_i_3, %incr_wptr_i after %1 : i1
    llhd.drv %incr_rptr_i_4, %incr_rptr_i after %1 : i1
    hw.output %11, %15, %25, %26, %34, %false : i5, i5, i1, i1, i6, i1
  }
  hw.module private @prim_fifo_sync(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i36, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i36, out full_o : i1, out depth_o : i6, out err_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36] : !hw.array<32xi36>
    %c0_i5 = hw.constant 0 : i5
    %c0_i36 = hw.constant 0 : i36
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %wdata_i_2 = llhd.sig name "wdata_i" %c0_i36 : i36
    %gen_normal_fifo.fifo_wptr = llhd.sig %c0_i5 : i5
    %gen_normal_fifo.fifo_incr_wptr = llhd.sig %false : i1
    %gen_normal_fifo.under_rst = llhd.sig %false : i1
    %gen_normal_fifo.storage = llhd.sig %2 : !hw.array<32xi36>
    %gen_normal_fifo.storage_rdata = llhd.sig %c0_i36 : i36
    %gen_normal_fifo.rdata_int = llhd.sig %c0_i36 : i36
    %5 = llhd.prb %gen_normal_fifo.fifo_incr_wptr : i1
    %gen_normal_fifo.u_fifo_cnt.wptr_o, %gen_normal_fifo.u_fifo_cnt.rptr_o, %gen_normal_fifo.u_fifo_cnt.full_o, %gen_normal_fifo.u_fifo_cnt.empty_o, %gen_normal_fifo.u_fifo_cnt.depth_o, %gen_normal_fifo.u_fifo_cnt.err_o = hw.instance "gen_normal_fifo.u_fifo_cnt" @prim_fifo_sync_cnt(clk_i: %3: i1, rst_ni: %4: i1, clr_i: %clr_i: i1, incr_wptr_i: %5: i1, incr_rptr_i: %11: i1) -> (wptr_o: i5, rptr_o: i5, full_o: i1, empty_o: i1, depth_o: i6, err_o: i1) {sv.namehint = "gen_normal_fifo.fifo_rptr"}
    llhd.drv %gen_normal_fifo.fifo_wptr, %gen_normal_fifo.u_fifo_cnt.wptr_o after %1 : i5
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
    %12 = llhd.prb %gen_normal_fifo.storage : !hw.array<32xi36>
    %13 = hw.array_get %12[%gen_normal_fifo.u_fifo_cnt.rptr_o] : !hw.array<32xi36>, i5
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
      %29 = llhd.prb %gen_normal_fifo.fifo_wptr : i5
      %30 = llhd.sig.array_get %gen_normal_fifo.storage[%29] : <!hw.array<32xi36>>
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
    hw.output %9, %21, %23, %gen_normal_fifo.u_fifo_cnt.full_o, %gen_normal_fifo.u_fifo_cnt.depth_o, %gen_normal_fifo.u_fifo_cnt.err_o : i1, i1, i36, i1, i6, i1
  }
  hw.module private @prim_fifo_sync_1(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i16, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i16, out full_o : i1, out depth_o : i1, out err_o : i1) {
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
  hw.module private @prim_fifo_sync_2(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i5, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i5, out full_o : i1, out depth_o : i1, out err_o : i1) {
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
  hw.module private @prim_fifo_sync_3(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i40, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i40, out full_o : i1, out depth_o : i1, out err_o : i1) {
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
  hw.module private @prim_fifo_sync_19(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i94, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i94, out full_o : i1, out depth_o : i1, out err_o : i1) {
    %true = hw.constant true
    %false = hw.constant false
    hw.output %rready_i, %wvalid_i, %wdata_i, %true, %false, %false : i1, i1, i94, i1, i1, i1
  }
  hw.module private @prim_fifo_sync_20(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i14, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i14, out full_o : i1, out depth_o : i1, out err_o : i1) {
    %true = hw.constant true
    %false = hw.constant false
    hw.output %rready_i, %wvalid_i, %wdata_i, %true, %false, %false : i1, i1, i14, i1, i1, i1
  }
  hw.module private @prim_fifo_sync_21(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i51, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i51, out full_o : i1, out depth_o : i1, out err_o : i1) {
    %true = hw.constant true
    %false = hw.constant false
    hw.output %rready_i, %wvalid_i, %wdata_i, %true, %false, %false : i1, i1, i51, i1, i1, i1
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
  func.func private @"prim_mubi_pkg::mubi4_test_false_loose"(%arg0: i4) -> i1 {
    %c6_i4 = hw.constant 6 : i4
    %0 = comb.icmp ne %arg0, %c6_i4 : i4
    return %0 : i1
  }
  hw.module private @prim_onehot_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i59, in %addr_i : i6, in %en_i : i1, out err_o : i1) {
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
    %962 = comb.extract %oh_i from 0 : (i59) -> i1
    llhd.drv %961, %962 after %0 : i1
    %963 = llhd.sig.extract %and_tree from %c63_i7 : <i127> -> <i1>
    llhd.drv %963, %962 after %0 : i1
    %964 = llhd.sig.extract %err_tree from %c63_i7 : <i127> -> <i1>
    llhd.drv %964, %false after %0 : i1
    %965 = llhd.sig.extract %or_tree from %c-64_i7 : <i127> -> <i1>
    %966 = comb.extract %oh_i from 1 : (i59) -> i1
    llhd.drv %965, %966 after %0 : i1
    %967 = llhd.sig.extract %and_tree from %c-64_i7 : <i127> -> <i1>
    llhd.drv %967, %966 after %0 : i1
    %968 = llhd.sig.extract %err_tree from %c-64_i7 : <i127> -> <i1>
    llhd.drv %968, %false after %0 : i1
    %969 = llhd.sig.extract %or_tree from %c-63_i7 : <i127> -> <i1>
    %970 = comb.extract %oh_i from 2 : (i59) -> i1
    llhd.drv %969, %970 after %0 : i1
    %971 = llhd.sig.extract %and_tree from %c-63_i7 : <i127> -> <i1>
    llhd.drv %971, %970 after %0 : i1
    %972 = llhd.sig.extract %err_tree from %c-63_i7 : <i127> -> <i1>
    llhd.drv %972, %false after %0 : i1
    %973 = llhd.sig.extract %or_tree from %c-62_i7 : <i127> -> <i1>
    %974 = comb.extract %oh_i from 3 : (i59) -> i1
    llhd.drv %973, %974 after %0 : i1
    %975 = llhd.sig.extract %and_tree from %c-62_i7 : <i127> -> <i1>
    llhd.drv %975, %974 after %0 : i1
    %976 = llhd.sig.extract %err_tree from %c-62_i7 : <i127> -> <i1>
    llhd.drv %976, %false after %0 : i1
    %977 = llhd.sig.extract %or_tree from %c-61_i7 : <i127> -> <i1>
    %978 = comb.extract %oh_i from 4 : (i59) -> i1
    llhd.drv %977, %978 after %0 : i1
    %979 = llhd.sig.extract %and_tree from %c-61_i7 : <i127> -> <i1>
    llhd.drv %979, %978 after %0 : i1
    %980 = llhd.sig.extract %err_tree from %c-61_i7 : <i127> -> <i1>
    llhd.drv %980, %false after %0 : i1
    %981 = llhd.sig.extract %or_tree from %c-60_i7 : <i127> -> <i1>
    %982 = comb.extract %oh_i from 5 : (i59) -> i1
    llhd.drv %981, %982 after %0 : i1
    %983 = llhd.sig.extract %and_tree from %c-60_i7 : <i127> -> <i1>
    llhd.drv %983, %982 after %0 : i1
    %984 = llhd.sig.extract %err_tree from %c-60_i7 : <i127> -> <i1>
    llhd.drv %984, %false after %0 : i1
    %985 = llhd.sig.extract %or_tree from %c-59_i7 : <i127> -> <i1>
    %986 = comb.extract %oh_i from 6 : (i59) -> i1
    llhd.drv %985, %986 after %0 : i1
    %987 = llhd.sig.extract %and_tree from %c-59_i7 : <i127> -> <i1>
    llhd.drv %987, %986 after %0 : i1
    %988 = llhd.sig.extract %err_tree from %c-59_i7 : <i127> -> <i1>
    llhd.drv %988, %false after %0 : i1
    %989 = llhd.sig.extract %or_tree from %c-58_i7 : <i127> -> <i1>
    %990 = comb.extract %oh_i from 7 : (i59) -> i1
    llhd.drv %989, %990 after %0 : i1
    %991 = llhd.sig.extract %and_tree from %c-58_i7 : <i127> -> <i1>
    llhd.drv %991, %990 after %0 : i1
    %992 = llhd.sig.extract %err_tree from %c-58_i7 : <i127> -> <i1>
    llhd.drv %992, %false after %0 : i1
    %993 = llhd.sig.extract %or_tree from %c-57_i7 : <i127> -> <i1>
    %994 = comb.extract %oh_i from 8 : (i59) -> i1
    llhd.drv %993, %994 after %0 : i1
    %995 = llhd.sig.extract %and_tree from %c-57_i7 : <i127> -> <i1>
    llhd.drv %995, %994 after %0 : i1
    %996 = llhd.sig.extract %err_tree from %c-57_i7 : <i127> -> <i1>
    llhd.drv %996, %false after %0 : i1
    %997 = llhd.sig.extract %or_tree from %c-56_i7 : <i127> -> <i1>
    %998 = comb.extract %oh_i from 9 : (i59) -> i1
    llhd.drv %997, %998 after %0 : i1
    %999 = llhd.sig.extract %and_tree from %c-56_i7 : <i127> -> <i1>
    llhd.drv %999, %998 after %0 : i1
    %1000 = llhd.sig.extract %err_tree from %c-56_i7 : <i127> -> <i1>
    llhd.drv %1000, %false after %0 : i1
    %1001 = llhd.sig.extract %or_tree from %c-55_i7 : <i127> -> <i1>
    %1002 = comb.extract %oh_i from 10 : (i59) -> i1
    llhd.drv %1001, %1002 after %0 : i1
    %1003 = llhd.sig.extract %and_tree from %c-55_i7 : <i127> -> <i1>
    llhd.drv %1003, %1002 after %0 : i1
    %1004 = llhd.sig.extract %err_tree from %c-55_i7 : <i127> -> <i1>
    llhd.drv %1004, %false after %0 : i1
    %1005 = llhd.sig.extract %or_tree from %c-54_i7 : <i127> -> <i1>
    %1006 = comb.extract %oh_i from 11 : (i59) -> i1
    llhd.drv %1005, %1006 after %0 : i1
    %1007 = llhd.sig.extract %and_tree from %c-54_i7 : <i127> -> <i1>
    llhd.drv %1007, %1006 after %0 : i1
    %1008 = llhd.sig.extract %err_tree from %c-54_i7 : <i127> -> <i1>
    llhd.drv %1008, %false after %0 : i1
    %1009 = llhd.sig.extract %or_tree from %c-53_i7 : <i127> -> <i1>
    %1010 = comb.extract %oh_i from 12 : (i59) -> i1
    llhd.drv %1009, %1010 after %0 : i1
    %1011 = llhd.sig.extract %and_tree from %c-53_i7 : <i127> -> <i1>
    llhd.drv %1011, %1010 after %0 : i1
    %1012 = llhd.sig.extract %err_tree from %c-53_i7 : <i127> -> <i1>
    llhd.drv %1012, %false after %0 : i1
    %1013 = llhd.sig.extract %or_tree from %c-52_i7 : <i127> -> <i1>
    %1014 = comb.extract %oh_i from 13 : (i59) -> i1
    llhd.drv %1013, %1014 after %0 : i1
    %1015 = llhd.sig.extract %and_tree from %c-52_i7 : <i127> -> <i1>
    llhd.drv %1015, %1014 after %0 : i1
    %1016 = llhd.sig.extract %err_tree from %c-52_i7 : <i127> -> <i1>
    llhd.drv %1016, %false after %0 : i1
    %1017 = llhd.sig.extract %or_tree from %c-51_i7 : <i127> -> <i1>
    %1018 = comb.extract %oh_i from 14 : (i59) -> i1
    llhd.drv %1017, %1018 after %0 : i1
    %1019 = llhd.sig.extract %and_tree from %c-51_i7 : <i127> -> <i1>
    llhd.drv %1019, %1018 after %0 : i1
    %1020 = llhd.sig.extract %err_tree from %c-51_i7 : <i127> -> <i1>
    llhd.drv %1020, %false after %0 : i1
    %1021 = llhd.sig.extract %or_tree from %c-50_i7 : <i127> -> <i1>
    %1022 = comb.extract %oh_i from 15 : (i59) -> i1
    llhd.drv %1021, %1022 after %0 : i1
    %1023 = llhd.sig.extract %and_tree from %c-50_i7 : <i127> -> <i1>
    llhd.drv %1023, %1022 after %0 : i1
    %1024 = llhd.sig.extract %err_tree from %c-50_i7 : <i127> -> <i1>
    llhd.drv %1024, %false after %0 : i1
    %1025 = llhd.sig.extract %or_tree from %c-49_i7 : <i127> -> <i1>
    %1026 = comb.extract %oh_i from 16 : (i59) -> i1
    llhd.drv %1025, %1026 after %0 : i1
    %1027 = llhd.sig.extract %and_tree from %c-49_i7 : <i127> -> <i1>
    llhd.drv %1027, %1026 after %0 : i1
    %1028 = llhd.sig.extract %err_tree from %c-49_i7 : <i127> -> <i1>
    llhd.drv %1028, %false after %0 : i1
    %1029 = llhd.sig.extract %or_tree from %c-48_i7 : <i127> -> <i1>
    %1030 = comb.extract %oh_i from 17 : (i59) -> i1
    llhd.drv %1029, %1030 after %0 : i1
    %1031 = llhd.sig.extract %and_tree from %c-48_i7 : <i127> -> <i1>
    llhd.drv %1031, %1030 after %0 : i1
    %1032 = llhd.sig.extract %err_tree from %c-48_i7 : <i127> -> <i1>
    llhd.drv %1032, %false after %0 : i1
    %1033 = llhd.sig.extract %or_tree from %c-47_i7 : <i127> -> <i1>
    %1034 = comb.extract %oh_i from 18 : (i59) -> i1
    llhd.drv %1033, %1034 after %0 : i1
    %1035 = llhd.sig.extract %and_tree from %c-47_i7 : <i127> -> <i1>
    llhd.drv %1035, %1034 after %0 : i1
    %1036 = llhd.sig.extract %err_tree from %c-47_i7 : <i127> -> <i1>
    llhd.drv %1036, %false after %0 : i1
    %1037 = llhd.sig.extract %or_tree from %c-46_i7 : <i127> -> <i1>
    %1038 = comb.extract %oh_i from 19 : (i59) -> i1
    llhd.drv %1037, %1038 after %0 : i1
    %1039 = llhd.sig.extract %and_tree from %c-46_i7 : <i127> -> <i1>
    llhd.drv %1039, %1038 after %0 : i1
    %1040 = llhd.sig.extract %err_tree from %c-46_i7 : <i127> -> <i1>
    llhd.drv %1040, %false after %0 : i1
    %1041 = llhd.sig.extract %or_tree from %c-45_i7 : <i127> -> <i1>
    %1042 = comb.extract %oh_i from 20 : (i59) -> i1
    llhd.drv %1041, %1042 after %0 : i1
    %1043 = llhd.sig.extract %and_tree from %c-45_i7 : <i127> -> <i1>
    llhd.drv %1043, %1042 after %0 : i1
    %1044 = llhd.sig.extract %err_tree from %c-45_i7 : <i127> -> <i1>
    llhd.drv %1044, %false after %0 : i1
    %1045 = llhd.sig.extract %or_tree from %c-44_i7 : <i127> -> <i1>
    %1046 = comb.extract %oh_i from 21 : (i59) -> i1
    llhd.drv %1045, %1046 after %0 : i1
    %1047 = llhd.sig.extract %and_tree from %c-44_i7 : <i127> -> <i1>
    llhd.drv %1047, %1046 after %0 : i1
    %1048 = llhd.sig.extract %err_tree from %c-44_i7 : <i127> -> <i1>
    llhd.drv %1048, %false after %0 : i1
    %1049 = llhd.sig.extract %or_tree from %c-43_i7 : <i127> -> <i1>
    %1050 = comb.extract %oh_i from 22 : (i59) -> i1
    llhd.drv %1049, %1050 after %0 : i1
    %1051 = llhd.sig.extract %and_tree from %c-43_i7 : <i127> -> <i1>
    llhd.drv %1051, %1050 after %0 : i1
    %1052 = llhd.sig.extract %err_tree from %c-43_i7 : <i127> -> <i1>
    llhd.drv %1052, %false after %0 : i1
    %1053 = llhd.sig.extract %or_tree from %c-42_i7 : <i127> -> <i1>
    %1054 = comb.extract %oh_i from 23 : (i59) -> i1
    llhd.drv %1053, %1054 after %0 : i1
    %1055 = llhd.sig.extract %and_tree from %c-42_i7 : <i127> -> <i1>
    llhd.drv %1055, %1054 after %0 : i1
    %1056 = llhd.sig.extract %err_tree from %c-42_i7 : <i127> -> <i1>
    llhd.drv %1056, %false after %0 : i1
    %1057 = llhd.sig.extract %or_tree from %c-41_i7 : <i127> -> <i1>
    %1058 = comb.extract %oh_i from 24 : (i59) -> i1
    llhd.drv %1057, %1058 after %0 : i1
    %1059 = llhd.sig.extract %and_tree from %c-41_i7 : <i127> -> <i1>
    llhd.drv %1059, %1058 after %0 : i1
    %1060 = llhd.sig.extract %err_tree from %c-41_i7 : <i127> -> <i1>
    llhd.drv %1060, %false after %0 : i1
    %1061 = llhd.sig.extract %or_tree from %c-40_i7 : <i127> -> <i1>
    %1062 = comb.extract %oh_i from 25 : (i59) -> i1
    llhd.drv %1061, %1062 after %0 : i1
    %1063 = llhd.sig.extract %and_tree from %c-40_i7 : <i127> -> <i1>
    llhd.drv %1063, %1062 after %0 : i1
    %1064 = llhd.sig.extract %err_tree from %c-40_i7 : <i127> -> <i1>
    llhd.drv %1064, %false after %0 : i1
    %1065 = llhd.sig.extract %or_tree from %c-39_i7 : <i127> -> <i1>
    %1066 = comb.extract %oh_i from 26 : (i59) -> i1
    llhd.drv %1065, %1066 after %0 : i1
    %1067 = llhd.sig.extract %and_tree from %c-39_i7 : <i127> -> <i1>
    llhd.drv %1067, %1066 after %0 : i1
    %1068 = llhd.sig.extract %err_tree from %c-39_i7 : <i127> -> <i1>
    llhd.drv %1068, %false after %0 : i1
    %1069 = llhd.sig.extract %or_tree from %c-38_i7 : <i127> -> <i1>
    %1070 = comb.extract %oh_i from 27 : (i59) -> i1
    llhd.drv %1069, %1070 after %0 : i1
    %1071 = llhd.sig.extract %and_tree from %c-38_i7 : <i127> -> <i1>
    llhd.drv %1071, %1070 after %0 : i1
    %1072 = llhd.sig.extract %err_tree from %c-38_i7 : <i127> -> <i1>
    llhd.drv %1072, %false after %0 : i1
    %1073 = llhd.sig.extract %or_tree from %c-37_i7 : <i127> -> <i1>
    %1074 = comb.extract %oh_i from 28 : (i59) -> i1
    llhd.drv %1073, %1074 after %0 : i1
    %1075 = llhd.sig.extract %and_tree from %c-37_i7 : <i127> -> <i1>
    llhd.drv %1075, %1074 after %0 : i1
    %1076 = llhd.sig.extract %err_tree from %c-37_i7 : <i127> -> <i1>
    llhd.drv %1076, %false after %0 : i1
    %1077 = llhd.sig.extract %or_tree from %c-36_i7 : <i127> -> <i1>
    %1078 = comb.extract %oh_i from 29 : (i59) -> i1
    llhd.drv %1077, %1078 after %0 : i1
    %1079 = llhd.sig.extract %and_tree from %c-36_i7 : <i127> -> <i1>
    llhd.drv %1079, %1078 after %0 : i1
    %1080 = llhd.sig.extract %err_tree from %c-36_i7 : <i127> -> <i1>
    llhd.drv %1080, %false after %0 : i1
    %1081 = llhd.sig.extract %or_tree from %c-35_i7 : <i127> -> <i1>
    %1082 = comb.extract %oh_i from 30 : (i59) -> i1
    llhd.drv %1081, %1082 after %0 : i1
    %1083 = llhd.sig.extract %and_tree from %c-35_i7 : <i127> -> <i1>
    llhd.drv %1083, %1082 after %0 : i1
    %1084 = llhd.sig.extract %err_tree from %c-35_i7 : <i127> -> <i1>
    llhd.drv %1084, %false after %0 : i1
    %1085 = llhd.sig.extract %or_tree from %c-34_i7 : <i127> -> <i1>
    %1086 = comb.extract %oh_i from 31 : (i59) -> i1
    llhd.drv %1085, %1086 after %0 : i1
    %1087 = llhd.sig.extract %and_tree from %c-34_i7 : <i127> -> <i1>
    llhd.drv %1087, %1086 after %0 : i1
    %1088 = llhd.sig.extract %err_tree from %c-34_i7 : <i127> -> <i1>
    llhd.drv %1088, %false after %0 : i1
    %1089 = llhd.sig.extract %or_tree from %c-33_i7 : <i127> -> <i1>
    %1090 = comb.extract %oh_i from 32 : (i59) -> i1
    llhd.drv %1089, %1090 after %0 : i1
    %1091 = llhd.sig.extract %and_tree from %c-33_i7 : <i127> -> <i1>
    llhd.drv %1091, %1090 after %0 : i1
    %1092 = llhd.sig.extract %err_tree from %c-33_i7 : <i127> -> <i1>
    llhd.drv %1092, %false after %0 : i1
    %1093 = llhd.sig.extract %or_tree from %c-32_i7 : <i127> -> <i1>
    %1094 = comb.extract %oh_i from 33 : (i59) -> i1
    llhd.drv %1093, %1094 after %0 : i1
    %1095 = llhd.sig.extract %and_tree from %c-32_i7 : <i127> -> <i1>
    llhd.drv %1095, %1094 after %0 : i1
    %1096 = llhd.sig.extract %err_tree from %c-32_i7 : <i127> -> <i1>
    llhd.drv %1096, %false after %0 : i1
    %1097 = llhd.sig.extract %or_tree from %c-31_i7 : <i127> -> <i1>
    %1098 = comb.extract %oh_i from 34 : (i59) -> i1
    llhd.drv %1097, %1098 after %0 : i1
    %1099 = llhd.sig.extract %and_tree from %c-31_i7 : <i127> -> <i1>
    llhd.drv %1099, %1098 after %0 : i1
    %1100 = llhd.sig.extract %err_tree from %c-31_i7 : <i127> -> <i1>
    llhd.drv %1100, %false after %0 : i1
    %1101 = llhd.sig.extract %or_tree from %c-30_i7 : <i127> -> <i1>
    %1102 = comb.extract %oh_i from 35 : (i59) -> i1
    llhd.drv %1101, %1102 after %0 : i1
    %1103 = llhd.sig.extract %and_tree from %c-30_i7 : <i127> -> <i1>
    llhd.drv %1103, %1102 after %0 : i1
    %1104 = llhd.sig.extract %err_tree from %c-30_i7 : <i127> -> <i1>
    llhd.drv %1104, %false after %0 : i1
    %1105 = llhd.sig.extract %or_tree from %c-29_i7 : <i127> -> <i1>
    %1106 = comb.extract %oh_i from 36 : (i59) -> i1
    llhd.drv %1105, %1106 after %0 : i1
    %1107 = llhd.sig.extract %and_tree from %c-29_i7 : <i127> -> <i1>
    llhd.drv %1107, %1106 after %0 : i1
    %1108 = llhd.sig.extract %err_tree from %c-29_i7 : <i127> -> <i1>
    llhd.drv %1108, %false after %0 : i1
    %1109 = llhd.sig.extract %or_tree from %c-28_i7 : <i127> -> <i1>
    %1110 = comb.extract %oh_i from 37 : (i59) -> i1
    llhd.drv %1109, %1110 after %0 : i1
    %1111 = llhd.sig.extract %and_tree from %c-28_i7 : <i127> -> <i1>
    llhd.drv %1111, %1110 after %0 : i1
    %1112 = llhd.sig.extract %err_tree from %c-28_i7 : <i127> -> <i1>
    llhd.drv %1112, %false after %0 : i1
    %1113 = llhd.sig.extract %or_tree from %c-27_i7 : <i127> -> <i1>
    %1114 = comb.extract %oh_i from 38 : (i59) -> i1
    llhd.drv %1113, %1114 after %0 : i1
    %1115 = llhd.sig.extract %and_tree from %c-27_i7 : <i127> -> <i1>
    llhd.drv %1115, %1114 after %0 : i1
    %1116 = llhd.sig.extract %err_tree from %c-27_i7 : <i127> -> <i1>
    llhd.drv %1116, %false after %0 : i1
    %1117 = llhd.sig.extract %or_tree from %c-26_i7 : <i127> -> <i1>
    %1118 = comb.extract %oh_i from 39 : (i59) -> i1
    llhd.drv %1117, %1118 after %0 : i1
    %1119 = llhd.sig.extract %and_tree from %c-26_i7 : <i127> -> <i1>
    llhd.drv %1119, %1118 after %0 : i1
    %1120 = llhd.sig.extract %err_tree from %c-26_i7 : <i127> -> <i1>
    llhd.drv %1120, %false after %0 : i1
    %1121 = llhd.sig.extract %or_tree from %c-25_i7 : <i127> -> <i1>
    %1122 = comb.extract %oh_i from 40 : (i59) -> i1
    llhd.drv %1121, %1122 after %0 : i1
    %1123 = llhd.sig.extract %and_tree from %c-25_i7 : <i127> -> <i1>
    llhd.drv %1123, %1122 after %0 : i1
    %1124 = llhd.sig.extract %err_tree from %c-25_i7 : <i127> -> <i1>
    llhd.drv %1124, %false after %0 : i1
    %1125 = llhd.sig.extract %or_tree from %c-24_i7 : <i127> -> <i1>
    %1126 = comb.extract %oh_i from 41 : (i59) -> i1
    llhd.drv %1125, %1126 after %0 : i1
    %1127 = llhd.sig.extract %and_tree from %c-24_i7 : <i127> -> <i1>
    llhd.drv %1127, %1126 after %0 : i1
    %1128 = llhd.sig.extract %err_tree from %c-24_i7 : <i127> -> <i1>
    llhd.drv %1128, %false after %0 : i1
    %1129 = llhd.sig.extract %or_tree from %c-23_i7 : <i127> -> <i1>
    %1130 = comb.extract %oh_i from 42 : (i59) -> i1
    llhd.drv %1129, %1130 after %0 : i1
    %1131 = llhd.sig.extract %and_tree from %c-23_i7 : <i127> -> <i1>
    llhd.drv %1131, %1130 after %0 : i1
    %1132 = llhd.sig.extract %err_tree from %c-23_i7 : <i127> -> <i1>
    llhd.drv %1132, %false after %0 : i1
    %1133 = llhd.sig.extract %or_tree from %c-22_i7 : <i127> -> <i1>
    %1134 = comb.extract %oh_i from 43 : (i59) -> i1
    llhd.drv %1133, %1134 after %0 : i1
    %1135 = llhd.sig.extract %and_tree from %c-22_i7 : <i127> -> <i1>
    llhd.drv %1135, %1134 after %0 : i1
    %1136 = llhd.sig.extract %err_tree from %c-22_i7 : <i127> -> <i1>
    llhd.drv %1136, %false after %0 : i1
    %1137 = llhd.sig.extract %or_tree from %c-21_i7 : <i127> -> <i1>
    %1138 = comb.extract %oh_i from 44 : (i59) -> i1
    llhd.drv %1137, %1138 after %0 : i1
    %1139 = llhd.sig.extract %and_tree from %c-21_i7 : <i127> -> <i1>
    llhd.drv %1139, %1138 after %0 : i1
    %1140 = llhd.sig.extract %err_tree from %c-21_i7 : <i127> -> <i1>
    llhd.drv %1140, %false after %0 : i1
    %1141 = llhd.sig.extract %or_tree from %c-20_i7 : <i127> -> <i1>
    %1142 = comb.extract %oh_i from 45 : (i59) -> i1
    llhd.drv %1141, %1142 after %0 : i1
    %1143 = llhd.sig.extract %and_tree from %c-20_i7 : <i127> -> <i1>
    llhd.drv %1143, %1142 after %0 : i1
    %1144 = llhd.sig.extract %err_tree from %c-20_i7 : <i127> -> <i1>
    llhd.drv %1144, %false after %0 : i1
    %1145 = llhd.sig.extract %or_tree from %c-19_i7 : <i127> -> <i1>
    %1146 = comb.extract %oh_i from 46 : (i59) -> i1
    llhd.drv %1145, %1146 after %0 : i1
    %1147 = llhd.sig.extract %and_tree from %c-19_i7 : <i127> -> <i1>
    llhd.drv %1147, %1146 after %0 : i1
    %1148 = llhd.sig.extract %err_tree from %c-19_i7 : <i127> -> <i1>
    llhd.drv %1148, %false after %0 : i1
    %1149 = llhd.sig.extract %or_tree from %c-18_i7 : <i127> -> <i1>
    %1150 = comb.extract %oh_i from 47 : (i59) -> i1
    llhd.drv %1149, %1150 after %0 : i1
    %1151 = llhd.sig.extract %and_tree from %c-18_i7 : <i127> -> <i1>
    llhd.drv %1151, %1150 after %0 : i1
    %1152 = llhd.sig.extract %err_tree from %c-18_i7 : <i127> -> <i1>
    llhd.drv %1152, %false after %0 : i1
    %1153 = llhd.sig.extract %or_tree from %c-17_i7 : <i127> -> <i1>
    %1154 = comb.extract %oh_i from 48 : (i59) -> i1
    llhd.drv %1153, %1154 after %0 : i1
    %1155 = llhd.sig.extract %and_tree from %c-17_i7 : <i127> -> <i1>
    llhd.drv %1155, %1154 after %0 : i1
    %1156 = llhd.sig.extract %err_tree from %c-17_i7 : <i127> -> <i1>
    llhd.drv %1156, %false after %0 : i1
    %1157 = llhd.sig.extract %or_tree from %c-16_i7 : <i127> -> <i1>
    %1158 = comb.extract %oh_i from 49 : (i59) -> i1
    llhd.drv %1157, %1158 after %0 : i1
    %1159 = llhd.sig.extract %and_tree from %c-16_i7 : <i127> -> <i1>
    llhd.drv %1159, %1158 after %0 : i1
    %1160 = llhd.sig.extract %err_tree from %c-16_i7 : <i127> -> <i1>
    llhd.drv %1160, %false after %0 : i1
    %1161 = llhd.sig.extract %or_tree from %c-15_i7 : <i127> -> <i1>
    %1162 = comb.extract %oh_i from 50 : (i59) -> i1
    llhd.drv %1161, %1162 after %0 : i1
    %1163 = llhd.sig.extract %and_tree from %c-15_i7 : <i127> -> <i1>
    llhd.drv %1163, %1162 after %0 : i1
    %1164 = llhd.sig.extract %err_tree from %c-15_i7 : <i127> -> <i1>
    llhd.drv %1164, %false after %0 : i1
    %1165 = llhd.sig.extract %or_tree from %c-14_i7 : <i127> -> <i1>
    %1166 = comb.extract %oh_i from 51 : (i59) -> i1
    llhd.drv %1165, %1166 after %0 : i1
    %1167 = llhd.sig.extract %and_tree from %c-14_i7 : <i127> -> <i1>
    llhd.drv %1167, %1166 after %0 : i1
    %1168 = llhd.sig.extract %err_tree from %c-14_i7 : <i127> -> <i1>
    llhd.drv %1168, %false after %0 : i1
    %1169 = llhd.sig.extract %or_tree from %c-13_i7 : <i127> -> <i1>
    %1170 = comb.extract %oh_i from 52 : (i59) -> i1
    llhd.drv %1169, %1170 after %0 : i1
    %1171 = llhd.sig.extract %and_tree from %c-13_i7 : <i127> -> <i1>
    llhd.drv %1171, %1170 after %0 : i1
    %1172 = llhd.sig.extract %err_tree from %c-13_i7 : <i127> -> <i1>
    llhd.drv %1172, %false after %0 : i1
    %1173 = llhd.sig.extract %or_tree from %c-12_i7 : <i127> -> <i1>
    %1174 = comb.extract %oh_i from 53 : (i59) -> i1
    llhd.drv %1173, %1174 after %0 : i1
    %1175 = llhd.sig.extract %and_tree from %c-12_i7 : <i127> -> <i1>
    llhd.drv %1175, %1174 after %0 : i1
    %1176 = llhd.sig.extract %err_tree from %c-12_i7 : <i127> -> <i1>
    llhd.drv %1176, %false after %0 : i1
    %1177 = llhd.sig.extract %or_tree from %c-11_i7 : <i127> -> <i1>
    %1178 = comb.extract %oh_i from 54 : (i59) -> i1
    llhd.drv %1177, %1178 after %0 : i1
    %1179 = llhd.sig.extract %and_tree from %c-11_i7 : <i127> -> <i1>
    llhd.drv %1179, %1178 after %0 : i1
    %1180 = llhd.sig.extract %err_tree from %c-11_i7 : <i127> -> <i1>
    llhd.drv %1180, %false after %0 : i1
    %1181 = llhd.sig.extract %or_tree from %c-10_i7 : <i127> -> <i1>
    %1182 = comb.extract %oh_i from 55 : (i59) -> i1
    llhd.drv %1181, %1182 after %0 : i1
    %1183 = llhd.sig.extract %and_tree from %c-10_i7 : <i127> -> <i1>
    llhd.drv %1183, %1182 after %0 : i1
    %1184 = llhd.sig.extract %err_tree from %c-10_i7 : <i127> -> <i1>
    llhd.drv %1184, %false after %0 : i1
    %1185 = llhd.sig.extract %or_tree from %c-9_i7 : <i127> -> <i1>
    %1186 = comb.extract %oh_i from 56 : (i59) -> i1
    llhd.drv %1185, %1186 after %0 : i1
    %1187 = llhd.sig.extract %and_tree from %c-9_i7 : <i127> -> <i1>
    llhd.drv %1187, %1186 after %0 : i1
    %1188 = llhd.sig.extract %err_tree from %c-9_i7 : <i127> -> <i1>
    llhd.drv %1188, %false after %0 : i1
    %1189 = llhd.sig.extract %or_tree from %c-8_i7 : <i127> -> <i1>
    %1190 = comb.extract %oh_i from 57 : (i59) -> i1
    llhd.drv %1189, %1190 after %0 : i1
    %1191 = llhd.sig.extract %and_tree from %c-8_i7 : <i127> -> <i1>
    llhd.drv %1191, %1190 after %0 : i1
    %1192 = llhd.sig.extract %err_tree from %c-8_i7 : <i127> -> <i1>
    llhd.drv %1192, %false after %0 : i1
    %1193 = llhd.sig.extract %or_tree from %c-7_i7 : <i127> -> <i1>
    %1194 = comb.extract %oh_i from 58 : (i59) -> i1
    llhd.drv %1193, %1194 after %0 : i1
    %1195 = llhd.sig.extract %and_tree from %c-7_i7 : <i127> -> <i1>
    llhd.drv %1195, %1194 after %0 : i1
    %1196 = llhd.sig.extract %err_tree from %c-7_i7 : <i127> -> <i1>
    llhd.drv %1196, %false after %0 : i1
    %1197 = llhd.sig.extract %or_tree from %c-6_i7 : <i127> -> <i1>
    llhd.drv %1197, %false after %0 : i1
    %1198 = llhd.sig.extract %and_tree from %c-6_i7 : <i127> -> <i1>
    llhd.drv %1198, %false after %0 : i1
    %1199 = llhd.sig.extract %err_tree from %c-6_i7 : <i127> -> <i1>
    llhd.drv %1199, %false after %0 : i1
    %1200 = llhd.sig.extract %or_tree from %c-5_i7 : <i127> -> <i1>
    llhd.drv %1200, %false after %0 : i1
    %1201 = llhd.sig.extract %and_tree from %c-5_i7 : <i127> -> <i1>
    llhd.drv %1201, %false after %0 : i1
    %1202 = llhd.sig.extract %err_tree from %c-5_i7 : <i127> -> <i1>
    llhd.drv %1202, %false after %0 : i1
    %1203 = llhd.sig.extract %or_tree from %c-4_i7 : <i127> -> <i1>
    llhd.drv %1203, %false after %0 : i1
    %1204 = llhd.sig.extract %and_tree from %c-4_i7 : <i127> -> <i1>
    llhd.drv %1204, %false after %0 : i1
    %1205 = llhd.sig.extract %err_tree from %c-4_i7 : <i127> -> <i1>
    llhd.drv %1205, %false after %0 : i1
    %1206 = llhd.sig.extract %or_tree from %c-3_i7 : <i127> -> <i1>
    llhd.drv %1206, %false after %0 : i1
    %1207 = llhd.sig.extract %and_tree from %c-3_i7 : <i127> -> <i1>
    llhd.drv %1207, %false after %0 : i1
    %1208 = llhd.sig.extract %err_tree from %c-3_i7 : <i127> -> <i1>
    llhd.drv %1208, %false after %0 : i1
    %1209 = llhd.sig.extract %or_tree from %c-2_i7 : <i127> -> <i1>
    llhd.drv %1209, %false after %0 : i1
    %1210 = llhd.sig.extract %and_tree from %c-2_i7 : <i127> -> <i1>
    llhd.drv %1210, %false after %0 : i1
    %1211 = llhd.sig.extract %err_tree from %c-2_i7 : <i127> -> <i1>
    llhd.drv %1211, %false after %0 : i1
    %1212 = comb.or %1213, %1216 : i1
    %1213 = comb.extract %17 from 0 {sv.namehint = "oh0_err"} : (i127) -> i1
    %1214 = comb.xor %en_i, %true : i1
    %1215 = comb.extract %2 from 0 : (i127) -> i1
    %1216 = comb.and %1214, %1215 {sv.namehint = "enable_err"} : i1
    hw.output %1212 : i1
  }
  hw.module private @prim_packer(in %clk_i : i1, in %rst_ni : i1, in %valid_i : i1, in %data_i : i32, in %mask_i : i32, out ready_o : i1, out valid_o : i1, out data_o : i32, out mask_o : i32, in %ready_i : i1, in %flush_i : i1, out flush_done_o : i1, out err_o : i1) {
    %c-1_i32 = hw.constant -1 : i32
    %c31_i32 = hw.constant 31 : i32
    %c-32_i7 = hw.constant -32 : i7
    %c33_i32 = hw.constant 33 : i32
    %c0_i89 = hw.constant 0 : i89
    %c0_i27 = hw.constant 0 : i27
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c0_i25 = hw.constant 0 : i25
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i96 = hw.constant 0 : i96
    %c0_i64 = hw.constant 0 : i64
    %false = hw.constant false
    %c0_i32 = hw.constant 0 : i32
    %true = hw.constant true
    %c0_i5 = hw.constant 0 : i5
    %c-2_i2 = hw.constant -2 : i2
    %c0_i7 = hw.constant 0 : i7
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %c1_i32 = hw.constant 1 : i32
    %c32_i32 = hw.constant 32 : i32
    %c0_i6 = hw.constant 0 : i6
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %data_i_2 = llhd.sig name "data_i" %c0_i32 : i32
    %mask_i_3 = llhd.sig name "mask_i" %c0_i32 : i32
    %flush_i_4 = llhd.sig name "flush_i" %false : i1
    %stored_data = llhd.sig %c0_i64 : i64
    %stored_mask = llhd.sig %c0_i64 : i64
    %concat_data = llhd.sig %c0_i96 : i96
    %concat_mask = llhd.sig %c0_i96 : i96
    %pos_q = llhd.sig %c0_i7 : i7
    %lod_idx = llhd.sig %c0_i5 : i5
    %inmask_ones = llhd.sig %c0_i6 : i6
    %ack_in = llhd.sig %false : i1
    %ack_out = llhd.sig %false : i1
    %flush_valid = llhd.sig %false : i1
    %flush_done = llhd.sig %false : i1
    %pos_with_input = llhd.sig %c0_i7 : i7
    %g_pos_nodup.pos_d = llhd.sig %c0_i7 : i7
    %stored_data_next = llhd.sig %c0_i64 : i64
    %stored_mask_next = llhd.sig %c0_i64 : i64
    %flush_st = llhd.sig %false : i1
    %flush_st_next = llhd.sig %false : i1
    %4 = llhd.prb %inmask_ones : i6
    %5 = llhd.prb %mask_i_3 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb4
      llhd.drv %inmask_ones, %c0_i6 after %1 : i6
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%51: i32):  // 2 preds: ^bb1, ^bb3
      %52 = comb.icmp ult %51, %c32_i32 : i32
      cf.cond_br %52, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %53 = llhd.prb %inmask_ones : i6
      %54 = llhd.prb %mask_i_3 : i32
      %55 = comb.shru %54, %51 : i32
      %56 = comb.extract %55 from 0 : (i32) -> i1
      %57 = comb.concat %c0_i5, %56 : i5, i1
      %58 = comb.add %53, %57 : i6
      llhd.drv %inmask_ones, %58 after %1 : i6
      %59 = comb.add %51, %c1_i32 : i32
      cf.br ^bb2(%59 : i32)
    ^bb4:  // pred: ^bb2
      llhd.wait (%4, %5 : i6, i32), ^bb1
    }
    %6 = llhd.prb %pos_q : i7
    %7 = comb.concat %false, %4 : i1, i6
    %8 = comb.add %6, %7 : i7
    llhd.drv %pos_with_input, %8 after %1 : i7
    %9 = llhd.prb %g_pos_nodup.pos_d : i7
    %10 = llhd.prb %ack_in : i1
    %11 = llhd.prb %ack_out : i1
    %12 = llhd.prb %pos_with_input : i7
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb8
      %51 = llhd.prb %pos_q : i7
      llhd.drv %g_pos_nodup.pos_d, %51 after %1 : i7
      %52 = llhd.prb %ack_in : i1
      %53 = llhd.prb %ack_out : i1
      %54 = comb.concat %52, %53 : i1, i1
      %55 = comb.icmp ceq %54, %c0_i2 : i2
      cf.cond_br %55, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %56 = llhd.prb %pos_q : i7
      llhd.drv %g_pos_nodup.pos_d, %56 after %1 : i7
      cf.br ^bb8
    ^bb3:  // pred: ^bb1
      %57 = comb.icmp ceq %54, %c1_i2 : i2
      cf.cond_br %57, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %58 = llhd.prb %pos_q : i7
      %59 = comb.concat %c0_i25, %58 : i25, i7
      %60 = comb.icmp ult %59, %c33_i32 : i32
      %61 = comb.add %58, %c-32_i7 : i7
      %62 = comb.mux %60, %c0_i7, %61 : i7
      llhd.drv %g_pos_nodup.pos_d, %62 after %1 : i7
      cf.br ^bb8
    ^bb5:  // pred: ^bb3
      %63 = comb.icmp ceq %54, %c-2_i2 : i2
      cf.cond_br %63, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %64 = llhd.prb %pos_with_input : i7
      llhd.drv %g_pos_nodup.pos_d, %64 after %1 : i7
      cf.br ^bb8
    ^bb7:  // pred: ^bb5
      %65 = llhd.prb %pos_with_input : i7
      %66 = comb.concat %c0_i25, %65 : i25, i7
      %67 = comb.icmp ult %66, %c33_i32 : i32
      %68 = comb.add %65, %c-32_i7 : i7
      %69 = comb.mux %67, %c0_i7, %68 : i7
      llhd.drv %g_pos_nodup.pos_d, %69 after %1 : i7
      cf.br ^bb8
    ^bb8:  // 4 preds: ^bb2, ^bb4, ^bb6, ^bb7
      llhd.wait (%6, %9, %10, %11, %12 : i7, i7, i1, i1, i7), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %51 = llhd.prb %clk_i_0 : i1
      %52 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %pos_q, %c0_i7 after %0 : i7
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %62 = llhd.prb %flush_done : i1
      cf.cond_br %62, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %pos_q, %c0_i7 after %0 : i7
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %63 = llhd.prb %g_pos_nodup.pos_d : i7
      llhd.drv %pos_q, %63 after %0 : i7
      cf.br ^bb1
    }
    %13 = llhd.prb %lod_idx : i5
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      llhd.drv %lod_idx, %c0_i5 after %1 : i5
      cf.br ^bb2(%c31_i32 : i32)
    ^bb2(%51: i32):  // 2 preds: ^bb1, ^bb5
      %52 = comb.icmp sgt %51, %c-1_i32 : i32
      cf.cond_br %52, ^bb3, ^bb6
    ^bb3:  // pred: ^bb2
      %53 = llhd.prb %mask_i_3 : i32
      %54 = comb.shru %53, %51 : i32
      %55 = comb.extract %54 from 0 : (i32) -> i1
      cf.cond_br %55, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %56 = comb.extract %51 from 0 : (i32) -> i5
      llhd.drv %lod_idx, %56 after %1 : i5
      cf.br ^bb5
    ^bb5:  // 2 preds: ^bb3, ^bb4
      %57 = comb.add %51, %c-1_i32 : i32
      cf.br ^bb2(%57 : i32)
    ^bb6:  // pred: ^bb2
      llhd.wait (%13, %5 : i5, i32), ^bb1
    }
    %14 = comb.and %valid_i, %48 : i1
    llhd.drv %ack_in, %14 after %1 : i1
    %15 = comb.and %47, %ready_i : i1
    llhd.drv %ack_out, %15 after %1 : i1
    %16 = llhd.prb %data_i_2 : i32
    %17 = comb.concat %c0_i27, %13 : i27, i5
    %18 = comb.shru %16, %17 : i32
    %19 = comb.mux %valid_i, %18, %c0_i32 {sv.namehint = "shiftr_data"} : i32
    %20 = comb.shru %5, %17 : i32
    %21 = comb.mux %valid_i, %20, %c0_i32 {sv.namehint = "shiftr_mask"} : i32
    %22 = comb.concat %c0_i64, %19 : i64, i32
    %23 = comb.concat %c0_i89, %6 : i89, i7
    %24 = comb.shl %22, %23 {sv.namehint = "shiftl_data"} : i96
    %25 = comb.concat %c0_i64, %21 : i64, i32
    %26 = comb.shl %25, %23 {sv.namehint = "shiftl_mask"} : i96
    %27 = llhd.prb %stored_data : i64
    %28 = llhd.prb %stored_mask : i64
    %29 = comb.and %27, %28 : i64
    %30 = comb.concat %c0_i32, %29 : i32, i64
    %31 = comb.and %24, %26 : i96
    %32 = comb.or %30, %31 : i96
    llhd.drv %concat_data, %32 after %1 : i96
    %33 = comb.concat %c0_i32, %28 : i32, i64
    %34 = comb.or %33, %26 : i96
    llhd.drv %concat_mask, %34 after %1 : i96
    %35 = llhd.prb %stored_data_next : i64
    %36 = llhd.prb %stored_mask_next : i64
    %37 = llhd.prb %concat_data : i96
    %38 = llhd.prb %concat_mask : i96
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb8
      %51 = llhd.prb %ack_in : i1
      %52 = llhd.prb %ack_out : i1
      %53 = comb.concat %51, %52 : i1, i1
      %54 = comb.icmp ceq %53, %c0_i2 : i2
      cf.cond_br %54, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %55 = llhd.prb %stored_data : i64
      llhd.drv %stored_data_next, %55 after %1 : i64
      %56 = llhd.prb %stored_mask : i64
      llhd.drv %stored_mask_next, %56 after %1 : i64
      cf.br ^bb8
    ^bb3:  // pred: ^bb1
      %57 = comb.icmp ceq %53, %c1_i2 : i2
      cf.cond_br %57, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %58 = llhd.prb %stored_data : i64
      %59 = comb.extract %58 from 32 : (i64) -> i32
      %60 = comb.concat %c0_i32, %59 : i32, i32
      llhd.drv %stored_data_next, %60 after %1 : i64
      %61 = llhd.prb %stored_mask : i64
      %62 = comb.extract %61 from 32 : (i64) -> i32
      %63 = comb.concat %c0_i32, %62 : i32, i32
      llhd.drv %stored_mask_next, %63 after %1 : i64
      cf.br ^bb8
    ^bb5:  // pred: ^bb3
      %64 = comb.icmp ceq %53, %c-2_i2 : i2
      cf.cond_br %64, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %65 = llhd.prb %concat_data : i96
      %66 = comb.extract %65 from 0 : (i96) -> i64
      llhd.drv %stored_data_next, %66 after %1 : i64
      %67 = llhd.prb %concat_mask : i96
      %68 = comb.extract %67 from 0 : (i96) -> i64
      llhd.drv %stored_mask_next, %68 after %1 : i64
      cf.br ^bb8
    ^bb7:  // pred: ^bb5
      %69 = llhd.prb %concat_data : i96
      %70 = comb.extract %69 from 32 : (i96) -> i64
      llhd.drv %stored_data_next, %70 after %1 : i64
      %71 = llhd.prb %concat_mask : i96
      %72 = comb.extract %71 from 32 : (i96) -> i64
      llhd.drv %stored_mask_next, %72 after %1 : i64
      cf.br ^bb8
    ^bb8:  // 4 preds: ^bb2, ^bb4, ^bb6, ^bb7
      llhd.wait (%10, %11, %27, %35, %28, %36, %c0_i32, %37, %38 : i1, i1, i64, i64, i64, i64, i32, i96, i96), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %51 = llhd.prb %clk_i_0 : i1
      %52 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %stored_data, %c0_i64 after %0 : i64
      llhd.drv %stored_mask, %c0_i64 after %0 : i64
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %62 = llhd.prb %flush_done : i1
      cf.cond_br %62, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %stored_data, %c0_i64 after %0 : i64
      llhd.drv %stored_mask, %c0_i64 after %0 : i64
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %63 = llhd.prb %stored_data_next : i64
      llhd.drv %stored_data, %63 after %0 : i64
      %64 = llhd.prb %stored_mask_next : i64
      llhd.drv %stored_mask, %64 after %0 : i64
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %51 = llhd.prb %clk_i_0 : i1
      %52 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %flush_st, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %62 = llhd.prb %flush_st_next : i1
      llhd.drv %flush_st, %62 after %0 : i1
      cf.br ^bb1
    }
    %39 = llhd.prb %flush_st_next : i1
    %40 = llhd.prb %flush_valid : i1
    %41 = llhd.prb %flush_done : i1
    %42 = llhd.prb %flush_st : i1
    %43 = llhd.prb %flush_i_4 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb8
      llhd.drv %flush_st_next, %false after %1 : i1
      llhd.drv %flush_valid, %false after %1 : i1
      llhd.drv %flush_done, %false after %1 : i1
      %51 = llhd.prb %flush_st : i1
      %52 = comb.icmp ceq %51, %false : i1
      cf.cond_br %52, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %53 = llhd.prb %flush_i_4 : i1
      cf.cond_br %53, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %flush_st_next, %true after %1 : i1
      cf.br ^bb8
    ^bb4:  // pred: ^bb2
      llhd.drv %flush_st_next, %false after %1 : i1
      cf.br ^bb8
    ^bb5:  // pred: ^bb1
      %54 = llhd.prb %pos_q : i7
      %55 = comb.icmp eq %54, %c0_i7 : i7
      cf.cond_br %55, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %flush_st_next, %false after %1 : i1
      llhd.drv %flush_valid, %false after %1 : i1
      llhd.drv %flush_done, %true after %1 : i1
      cf.br ^bb8
    ^bb7:  // pred: ^bb5
      llhd.drv %flush_st_next, %true after %1 : i1
      llhd.drv %flush_valid, %true after %1 : i1
      llhd.drv %flush_done, %false after %1 : i1
      cf.br ^bb8
    ^bb8:  // 4 preds: ^bb3, ^bb4, ^bb6, ^bb7
      llhd.wait (%39, %40, %41, %42, %43, %6 : i1, i1, i1, i1, i1, i7), ^bb1
    }
    %44 = comb.concat %c0_i25, %6 : i25, i7
    %45 = comb.extract %6 from 5 : (i7) -> i2
    %46 = comb.icmp ne %45, %c0_i2 : i2
    %47 = comb.or %46, %40 {sv.namehint = "valid_next"} : i1
    %48 = comb.icmp ult %44, %c33_i32 {sv.namehint = "ready_next"} : i32
    %49 = comb.extract %27 from 0 : (i64) -> i32
    %50 = comb.extract %28 from 0 : (i64) -> i32
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %data_i_2, %data_i after %1 : i32
    llhd.drv %mask_i_3, %mask_i after %1 : i32
    llhd.drv %flush_i_4, %flush_i after %1 : i1
    hw.output %48, %47, %49, %50, %41, %false : i1, i1, i32, i32, i1, i1
  }
  hw.module private @prim_reg_we_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i59, in %en_i : i1, out err_o : i1) {
    %c0_i6 = hw.constant 0 : i6
    %u_prim_buf.out_o = hw.instance "u_prim_buf" @prim_buf(in_i: %oh_i: i59) -> (out_o: i59) {sv.namehint = "oh_buf"}
    %u_prim_onehot_check.err_o = hw.instance "u_prim_onehot_check" @prim_onehot_check(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, oh_i: %u_prim_buf.out_o: i59, addr_i: %c0_i6: i6, en_i: %en_i: i1) -> (err_o: i1)
    hw.output %u_prim_onehot_check.err_o : i1
  }
  hw.module private @prim_sec_anchor_buf(in %in_i : i2, out out_o : i2) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_16(in_i: %in_i: i2) -> (out_o: i2)
    hw.output %u_secure_anchor_buf.out_o : i2
  }
  hw.module private @prim_sec_anchor_buf_11(in %in_i : i1, out out_o : i1) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_18(in_i: %in_i: i1) -> (out_o: i1)
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
  hw.module private @prim_subreg_arb_13(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
    hw.output %de, %d : i1, i1
  }
  hw.module private @prim_subreg_arb_14(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
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
  hw.module private @prim_subreg_arb_15(in %we : i1, in %wd : i32, in %de : i1, in %d : i32, in %q : i32, out wr_en : i1, out wr_data : i32) {
    hw.output %de, %d : i1, i32
  }
  hw.module private @prim_subreg_ext(in %re : i1, in %we : i1, in %wd : i1, in %d : i1, out qe : i1, out qre : i1, out q : i1, out ds : i1, out qs : i1) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i1, i1, i1
  }
  hw.module private @prim_subreg_ext_7(in %re : i1, in %we : i1, in %wd : i4, in %d : i4, out qe : i1, out qre : i1, out q : i4, out ds : i4, out qs : i4) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i4, i4, i4
  }
  hw.module private @prim_subreg_ext_8(in %re : i1, in %we : i1, in %wd : i6, in %d : i6, out qe : i1, out qre : i1, out q : i6, out ds : i6, out qs : i6) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i6, i6, i6
  }
  hw.module private @prim_subreg_ext_10(in %re : i1, in %we : i1, in %wd : i32, in %d : i32, out qe : i1, out qre : i1, out q : i32, out ds : i32, out qs : i32) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i32, i32, i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_14(we: %we: i1, wd: %wd: i1, de: %de: i1, d: %d: i1, q: %4: i1) -> (wr_en: i1, wr_data: i1)
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_15(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
  hw.module private @tlul_adapter_reg(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %en_ifetch_i : i4, out intg_error_o : i1, out re_o : i1, out we_o : i1, out addr_o : i13, out wdata_o : i32, out be_o : i4, in %busy_i : i1, in %rdata_i : i32, in %error_i : i1) {
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
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen_12(tl_i: %32: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
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
    %22 = comb.extract %a_address from 2 : (i32) -> i11
    %23 = comb.concat %22, %c0_i2 : i11, i2
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
    hw.output %u_rsp_intg_gen.tl_o, %false, %21, %19, %23, %a_data, %a_mask : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i1, i1, i1, i13, i32, i4
  }
  hw.module private @tlul_adapter_sram(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %en_ifetch_i : i4, out req_o : i1, out req_type_o : i4, in %gnt_i : i1, out we_o : i1, out addr_o : i9, out wdata_o : i32, out wmask_o : i32, out intg_error_o : i1, out user_rsvd_o : i5, in %rdata_i : i32, in %rvalid_i : i1, in %rerror_i : i2, out compound_txn_in_progress_o : i1, in %readback_en_i : i4, out readback_error_o : i1, in %wr_collision_i : i1, in %write_pending_i : i1) {
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
    %c0_i9 = hw.constant 0 : i9
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
    %u_rsp_gen.tl_o = hw.instance "u_rsp_gen" @tlul_rsp_intg_gen(tl_i: %u_sram_byte.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %u_sram_byte.tl_o, %u_sram_byte.tl_sram_o, %u_sram_byte.error_o, %u_sram_byte.alert_o, %u_sram_byte.compound_txn_in_progress_o = hw.instance "u_sram_byte" @tlul_sram_byte(clk_i: %8: i1, rst_ni: %9: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, tl_sram_i: %67: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, error_i: %27: i1, readback_en_i: %readback_en_i: i4, wr_collision_i: %wr_collision_i: i1, write_pending_i: %write_pending_i: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tl_sram_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, error_o: i1, alert_o: i1, compound_txn_in_progress_o: i1) {sv.namehint = "tl_out"}
    llhd.drv %tl_i_int, %u_sram_byte.tl_sram_o after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %u_tlul_data_integ_enc_instr.data_intg_o = hw.instance "u_tlul_data_integ_enc_instr" @tlul_data_integ_enc(data_i: %c0_i32: i32) -> (data_intg_o: i39)
    %10 = comb.extract %u_tlul_data_integ_enc_instr.data_intg_o from 32 : (i39) -> i7
    llhd.drv %error_instr_integ, %10 after %1 : i7
    %u_tlul_data_integ_enc_data.data_intg_o = hw.instance "u_tlul_data_integ_enc_data" @tlul_data_integ_enc(data_i: %c-1_i32: i32) -> (data_intg_o: i39)
    %11 = comb.extract %u_tlul_data_integ_enc_data.data_intg_o from 32 : (i39) -> i7
    llhd.drv %error_data_integ, %11 after %1 : i7
    %12 = hw.bitcast %92 : (!hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>) -> i16
    %u_reqfifo.wready_o, %u_reqfifo.rvalid_o, %u_reqfifo.rdata_o, %u_reqfifo.full_o, %u_reqfifo.depth_o, %u_reqfifo.err_o = hw.instance "u_reqfifo" @prim_fifo_sync_1(clk_i: %8: i1, rst_ni: %9: i1, clr_i: %false: i1, wvalid_i: %31: i1, wdata_i: %12: i16, rready_i: %32: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i16, full_o: i1, depth_o: i1, err_o: i1) {sv.namehint = "reqfifo_wready"}
    llhd.drv %reqfifo_rvalid, %u_reqfifo.rvalid_o after %1 : i1
    %13 = hw.bitcast %u_reqfifo.rdata_o : (i16) -> !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    llhd.drv %reqfifo_rdata, %13 after %1 : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    llhd.drv %reqfifo_error, %u_reqfifo.err_o after %1 : i1
    %u_sramreqfifo.wready_o, %u_sramreqfifo.rvalid_o, %u_sramreqfifo.rdata_o, %u_sramreqfifo.full_o, %u_sramreqfifo.depth_o, %u_sramreqfifo.err_o = hw.instance "u_sramreqfifo" @prim_fifo_sync_2(clk_i: %8: i1, rst_ni: %9: i1, clr_i: %false: i1, wvalid_i: %95: i1, wdata_i: %29: i5, rready_i: %96: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i5, full_o: i1, depth_o: i1, err_o: i1) {sv.namehint = "sramreqfifo_rdata"}
    llhd.drv %sramreqfifo_error, %u_sramreqfifo.err_o after %1 : i1
    %14 = hw.bitcast %107 : (!hw.struct<data: i32, data_intg: i7, error: i1>) -> i40
    %u_rspfifo.wready_o, %u_rspfifo.rvalid_o, %u_rspfifo.rdata_o, %u_rspfifo.full_o, %u_rspfifo.depth_o, %u_rspfifo.err_o = hw.instance "u_rspfifo" @prim_fifo_sync_3(clk_i: %8: i1, rst_ni: %9: i1, clr_i: %false: i1, wvalid_i: %96: i1, wdata_i: %14: i40, rready_i: %109: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i40, full_o: i1, depth_o: i1, err_o: i1) {sv.namehint = "rspfifo_wready"}
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
    %74 = comb.extract %a_address from 2 : (i32) -> i9
    %75 = comb.mux %a_valid, %74, %c0_i9 : i9
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
    hw.output %u_rsp_gen.tl_o, %69, %instr_type_4, %80, %75, %90, %88, %21, %76, %u_sram_byte.compound_txn_in_progress_o, %false : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i1, i4, i1, i9, i32, i32, i1, i5, i1, i1
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
  hw.module private @tlul_fifo_sync(in %clk_i : i1, in %rst_ni : i1, in %tl_h_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_h_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_d_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, in %tl_d_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %spare_req_i : i1, out spare_req_o : i1, in %spare_rsp_i : i1, out spare_rsp_o : i1) {
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
    %reqfifo.wready_o, %reqfifo.rvalid_o, %reqfifo.rdata_o, %reqfifo.full_o, %reqfifo.depth_o, %reqfifo.err_o = hw.instance "reqfifo" @prim_fifo_sync_19(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clr_i: %false: i1, wvalid_i: %a_valid: i1, wdata_i: %4: i94, rready_i: %a_ready: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i94, full_o: i1, depth_o: i1, err_o: i1)
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
    %u_reqfifo_intg_prim_buf.out_o = hw.instance "u_reqfifo_intg_prim_buf" @prim_buf_16(in_i: %55: i2) -> (out_o: i2) {sv.namehint = "buf_reqfifo_intg_out"}
    %cmd_intg = hw.struct_extract %a_user["cmd_intg"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %data_intg = hw.struct_extract %a_user["data_intg"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %27 = comb.concat %cmd_intg, %data_intg : i7, i7
    %28 = llhd.sig.struct_extract %14["cmd_intg"] : <!hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>>
    %29 = llhd.sig.struct_extract %14["data_intg"] : <!hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>>
    %reqfifo_intg.wready_o, %reqfifo_intg.rvalid_o, %reqfifo_intg.rdata_o, %reqfifo_intg.full_o, %reqfifo_intg.depth_o, %reqfifo_intg.err_o = hw.instance "reqfifo_intg" @prim_fifo_sync_20(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clr_i: %false: i1, wvalid_i: %56: i1, wdata_i: %27: i14, rready_i: %57: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i14, full_o: i1, depth_o: i1, err_o: i1)
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
    %rspfifo.wready_o, %rspfifo.rvalid_o, %rspfifo.rdata_o, %rspfifo.full_o, %rspfifo.depth_o, %rspfifo.err_o = hw.instance "rspfifo" @prim_fifo_sync_21(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clr_i: %false: i1, wvalid_i: %d_valid: i1, wdata_i: %35: i51, rready_i: %d_ready: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i51, full_o: i1, depth_o: i1, err_o: i1)
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
    %u_rspfifo_intg_prim_buf.out_o = hw.instance "u_rspfifo_intg_prim_buf" @prim_buf_16(in_i: %58: i2) -> (out_o: i2) {sv.namehint = "buf_rspfifo_intg_out"}
    %d_user = hw.struct_extract %6["d_user"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %52 = llhd.sig.struct_extract %tl_h_o["d_user"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %53 = hw.bitcast %d_user : (!hw.struct<rsp_intg: i7, data_intg: i7>) -> i14
    %rspfifo_intg.wready_o, %rspfifo_intg.rvalid_o, %rspfifo_intg.rdata_o, %rspfifo_intg.full_o, %rspfifo_intg.depth_o, %rspfifo_intg.err_o = hw.instance "rspfifo_intg" @prim_fifo_sync_20(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clr_i: %false: i1, wvalid_i: %59: i1, wdata_i: %53: i14, rready_i: %60: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i14, full_o: i1, depth_o: i1, err_o: i1)
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
  hw.module private @tlul_rsp_intg_gen_4(in %tl_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) {
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
  hw.module private @tlul_rsp_intg_gen_12(in %tl_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) {
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
  hw.module private @tlul_socket_1n(in %clk_i : i1, in %rst_ni : i1, in %tl_h_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_h_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_d_o : !hw.array<2xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, in %tl_d_i : !hw.array<2xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, in %dev_select_i : i1) {
    %c-1_i9 = hw.constant -1 : i9
    %c-1_i2 = hw.constant -1 : i2
    %c0_i30 = hw.constant 0 : i30
    %c0_i2 = hw.constant 0 : i2
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c1_i2 = hw.constant 1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [0 : i5, 0 : i4, 0 : i7, 0 : i7] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %3 = hw.aggregate_constant [[false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false]] : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %4 = hw.aggregate_constant [[false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false]] : !hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %5 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %6 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %7 = hw.aggregate_constant [[false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false]] : !hw.array<2xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %c1_i32 = hw.constant 1 : i32
    %c2_i32 = hw.constant 2 : i32
    %c0_i32 = hw.constant 0 : i32
    %true = hw.constant true
    %c-1_i32 = hw.constant -1 : i32
    %c-43_i7 = hw.constant -43 : i7
    %c1_i9 = hw.constant 1 : i9
    %c0_i9 = hw.constant 0 : i9
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %8 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %9 = llhd.prb %rst_ni_1 : i1
    %tl_d_o = llhd.sig %7 : !hw.array<2xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %dev_select_t = llhd.sig %false : i1
    %tl_t_o = llhd.sig %6 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %tl_t_i = llhd.sig %5 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %num_req_outstanding = llhd.sig %c0_i9 : i9
    %dev_select_outstanding = llhd.sig %false : i1
    %hold_all_requests = llhd.sig %false : i1
    %accept_t_req = llhd.sig %false : i1
    %accept_t_rsp = llhd.sig %false : i1
    %tl_u_o = llhd.sig %4 : !hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %tl_u_i = llhd.sig %3 : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %blanked_auser = llhd.sig %2 : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %tl_t_p = llhd.sig %5 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %hfifo_reqready = llhd.sig %false : i1
    %10 = llhd.prb %tl_t_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %fifo_h.tl_h_o, %fifo_h.tl_d_o, %fifo_h.spare_req_o, %fifo_h.spare_rsp_o = hw.instance "fifo_h" @tlul_fifo_sync(clk_i: %8: i1, rst_ni: %9: i1, tl_h_i: %tl_h_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, tl_d_i: %10: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, spare_req_i: %dev_select_i: i1, spare_rsp_i: %false: i1) -> (tl_h_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tl_d_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, spare_req_o: i1, spare_rsp_o: i1)
    llhd.drv %tl_t_o, %fifo_h.tl_d_o after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %dev_select_t, %fifo_h.spare_req_o after %1 : i1
    %11 = llhd.prb %tl_u_o : !hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %12 = hw.array_get %11[%c-2_i2] : !hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, i2
    %13 = llhd.sig.array_get %tl_u_i[%c-2_i2] : <!hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>>
    %14 = llhd.sig.array_get %tl_d_o[%true] : <!hw.array<2xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>>
    %15 = hw.array_get %tl_d_i[%true] : !hw.array<2xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, i1
    %gen_dfifo_0.fifo_d.tl_h_o, %gen_dfifo_0.fifo_d.tl_d_o, %gen_dfifo_0.fifo_d.spare_req_o, %gen_dfifo_0.fifo_d.spare_rsp_o = hw.instance "gen_dfifo_0.fifo_d" @tlul_fifo_sync(clk_i: %8: i1, rst_ni: %9: i1, tl_h_i: %12: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, tl_d_i: %15: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, spare_req_i: %false: i1, spare_rsp_i: %false: i1) -> (tl_h_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tl_d_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, spare_req_o: i1, spare_rsp_o: i1)
    llhd.drv %13, %gen_dfifo_0.fifo_d.tl_h_o after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %14, %gen_dfifo_0.fifo_d.tl_d_o after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %16 = hw.array_get %11[%c1_i2] : !hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, i2
    %17 = llhd.sig.array_get %tl_u_i[%c1_i2] : <!hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>>
    %18 = llhd.sig.array_get %tl_d_o[%false] : <!hw.array<2xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>>
    %19 = hw.array_get %tl_d_i[%false] : !hw.array<2xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, i1
    %gen_dfifo_1.fifo_d.tl_h_o, %gen_dfifo_1.fifo_d.tl_d_o, %gen_dfifo_1.fifo_d.spare_req_o, %gen_dfifo_1.fifo_d.spare_rsp_o = hw.instance "gen_dfifo_1.fifo_d" @tlul_fifo_sync(clk_i: %8: i1, rst_ni: %9: i1, tl_h_i: %16: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, tl_d_i: %19: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, spare_req_i: %false: i1, spare_rsp_i: %false: i1) -> (tl_h_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tl_d_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, spare_req_o: i1, spare_rsp_o: i1)
    llhd.drv %17, %gen_dfifo_1.fifo_d.tl_h_o after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %18, %gen_dfifo_1.fifo_d.tl_d_o after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %20 = llhd.prb %tl_t_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_valid = hw.struct_extract %20["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_ready = hw.struct_extract %10["a_ready"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %21 = comb.and %a_valid, %a_ready : i1
    llhd.drv %accept_t_req, %21 after %1 : i1
    %d_valid = hw.struct_extract %10["d_valid"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %d_ready = hw.struct_extract %20["d_ready"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %22 = comb.and %d_valid, %d_ready : i1
    llhd.drv %accept_t_rsp, %22 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb8, ^bb9, ^bb10
      %82 = llhd.prb %clk_i_0 : i1
      %83 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%8, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %84 = llhd.prb %clk_i_0 : i1
      %85 = comb.xor bin %82, %true : i1
      %86 = comb.and bin %85, %84 : i1
      %87 = llhd.prb %rst_ni_1 : i1
      %88 = comb.xor bin %87, %true : i1
      %89 = comb.and bin %83, %88 : i1
      %90 = comb.or bin %86, %89 : i1
      cf.cond_br %90, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %91 = llhd.prb %rst_ni_1 : i1
      %92 = comb.xor %91, %true : i1
      cf.cond_br %92, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %num_req_outstanding, %c0_i9 after %0 : i9
      llhd.drv %dev_select_outstanding, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %93 = llhd.prb %accept_t_req : i1
      cf.cond_br %93, ^bb6, ^bb9
    ^bb6:  // pred: ^bb5
      %94 = llhd.prb %accept_t_rsp : i1
      %95 = comb.xor %94, %true : i1
      cf.cond_br %95, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %96 = llhd.prb %num_req_outstanding : i9
      %97 = comb.add %96, %c1_i9 : i9
      llhd.drv %num_req_outstanding, %97 after %0 : i9
      cf.br ^bb8
    ^bb8:  // 2 preds: ^bb6, ^bb7
      %98 = llhd.prb %dev_select_t : i1
      llhd.drv %dev_select_outstanding, %98 after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb5
      %99 = llhd.prb %accept_t_rsp : i1
      cf.cond_br %99, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %100 = llhd.prb %num_req_outstanding : i9
      %101 = comb.add %100, %c-1_i9 : i9
      llhd.drv %num_req_outstanding, %101 after %0 : i9
      cf.br ^bb1
    }
    %23 = llhd.prb %num_req_outstanding : i9
    %24 = comb.icmp ne %23, %c0_i9 : i9
    %25 = llhd.prb %dev_select_t : i1
    %26 = llhd.prb %dev_select_outstanding : i1
    %27 = comb.icmp ne %25, %26 : i1
    %28 = comb.and %24, %27 : i1
    llhd.drv %hold_all_requests, %28 after %1 : i1
    %a_user = hw.struct_extract %20["a_user"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %rsvd = hw.struct_extract %a_user["rsvd"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %instr_type = hw.struct_extract %a_user["instr_type"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %29 = func.call @"tlul_pkg::get_bad_cmd_intg"(%20) : (!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> i7
    %30 = hw.struct_create (%rsvd, %instr_type, %29, %c-43_i7) : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    llhd.drv %blanked_auser, %30 after %1 : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %31 = comb.xor %25, %true : i1
    %32 = llhd.prb %hold_all_requests : i1
    %33 = comb.xor %32, %true : i1
    %34 = comb.and %31, %33 {sv.namehint = "gen_u_o_0.dev_select"} : i1
    %35 = llhd.sig.array_get %tl_u_o[%c-2_i2] : <!hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>>
    %36 = llhd.sig.struct_extract %35["a_valid"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %37 = comb.and %a_valid, %34 : i1
    llhd.drv %36, %37 after %1 : i1
    %38 = llhd.sig.struct_extract %35["a_opcode"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %a_opcode = hw.struct_extract %20["a_opcode"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %38, %a_opcode after %1 : i3
    %39 = llhd.sig.struct_extract %35["a_param"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %a_param = hw.struct_extract %20["a_param"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %39, %a_param after %1 : i3
    %40 = llhd.sig.struct_extract %35["a_size"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %a_size = hw.struct_extract %20["a_size"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %40, %a_size after %1 : i2
    %41 = llhd.sig.struct_extract %35["a_source"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %a_source = hw.struct_extract %20["a_source"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %41, %a_source after %1 : i8
    %42 = llhd.sig.struct_extract %35["a_address"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %a_address = hw.struct_extract %20["a_address"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %42, %a_address after %1 : i32
    %43 = llhd.sig.struct_extract %35["a_mask"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %a_mask = hw.struct_extract %20["a_mask"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %43, %a_mask after %1 : i4
    %44 = llhd.sig.struct_extract %35["a_data"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %a_data = hw.struct_extract %20["a_data"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %45 = comb.mux %34, %a_data, %c-1_i32 : i32
    llhd.drv %44, %45 after %1 : i32
    %46 = llhd.sig.struct_extract %35["a_user"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %47 = llhd.prb %blanked_auser : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %48 = comb.mux %34, %a_user, %47 : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    llhd.drv %46, %48 after %1 : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %49 = llhd.sig.struct_extract %35["d_ready"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %49, %d_ready after %1 : i1
    %50 = comb.and %25, %33 {sv.namehint = "gen_u_o_1.dev_select"} : i1
    %51 = llhd.sig.array_get %tl_u_o[%c1_i2] : <!hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>>
    %52 = llhd.sig.struct_extract %51["a_valid"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %53 = comb.and %a_valid, %50 : i1
    llhd.drv %52, %53 after %1 : i1
    %54 = llhd.sig.struct_extract %51["a_opcode"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %54, %a_opcode after %1 : i3
    %55 = llhd.sig.struct_extract %51["a_param"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %55, %a_param after %1 : i3
    %56 = llhd.sig.struct_extract %51["a_size"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %56, %a_size after %1 : i2
    %57 = llhd.sig.struct_extract %51["a_source"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %57, %a_source after %1 : i8
    %58 = llhd.sig.struct_extract %51["a_address"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %58, %a_address after %1 : i32
    %59 = llhd.sig.struct_extract %51["a_mask"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %59, %a_mask after %1 : i4
    %60 = llhd.sig.struct_extract %51["a_data"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %61 = comb.mux %50, %a_data, %c-1_i32 : i32
    llhd.drv %60, %61 after %1 : i32
    %62 = llhd.sig.struct_extract %51["a_user"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %63 = comb.mux %50, %a_user, %47 : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    llhd.drv %62, %63 after %1 : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %64 = llhd.sig.struct_extract %51["d_ready"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %64, %d_ready after %1 : i1
    %65 = llhd.prb %tl_u_i : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %66 = llhd.prb %hfifo_reqready : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb8
      %82 = llhd.prb %tl_u_i : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
      %83 = hw.array_get %82[%c0_i2] : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, i2
      %a_ready_3 = hw.struct_extract %83["a_ready"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      llhd.drv %hfifo_reqready, %a_ready_3 after %1 : i1
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%84: i32):  // 2 preds: ^bb1, ^bb5
      %85 = comb.icmp ult %84, %c2_i32 : i32
      cf.cond_br %85, ^bb3, ^bb6
    ^bb3:  // pred: ^bb2
      %86 = llhd.prb %dev_select_t : i1
      %87 = comb.extract %84 from 0 : (i32) -> i1
      %88 = comb.icmp eq %86, %87 : i1
      cf.cond_br %88, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %89 = llhd.prb %tl_u_i : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
      %90 = comb.sub %c2_i32, %84 : i32
      %91 = comb.extract %90 from 2 : (i32) -> i30
      %92 = comb.icmp eq %91, %c0_i30 : i30
      %93 = comb.extract %90 from 0 : (i32) -> i2
      %94 = comb.mux %92, %93, %c-1_i2 : i2
      %95 = hw.array_get %89[%94] : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, i2
      %a_ready_4 = hw.struct_extract %95["a_ready"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      llhd.drv %hfifo_reqready, %a_ready_4 after %1 : i1
      cf.br ^bb5
    ^bb5:  // 2 preds: ^bb3, ^bb4
      %96 = comb.add %84, %c1_i32 : i32
      cf.br ^bb2(%96 : i32)
    ^bb6:  // pred: ^bb2
      %97 = llhd.prb %hold_all_requests : i1
      cf.cond_br %97, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      llhd.drv %hfifo_reqready, %false after %1 : i1
      cf.br ^bb8
    ^bb8:  // 2 preds: ^bb6, ^bb7
      llhd.wait (%65, %66, %25, %32 : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, i1, i1, i1), ^bb1
    }
    %67 = llhd.sig.struct_extract %tl_t_i["a_ready"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %68 = comb.and %a_valid, %66 : i1
    llhd.drv %67, %68 after %1 : i1
    %69 = llhd.prb %tl_t_p : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %82 = llhd.prb %tl_u_i : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
      %83 = hw.array_get %82[%c0_i2] : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, i2
      llhd.drv %tl_t_p, %83 after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%84: i32):  // 2 preds: ^bb1, ^bb5
      %85 = comb.icmp ult %84, %c2_i32 : i32
      cf.cond_br %85, ^bb3, ^bb6
    ^bb3:  // pred: ^bb2
      %86 = llhd.prb %dev_select_outstanding : i1
      %87 = comb.extract %84 from 0 : (i32) -> i1
      %88 = comb.icmp eq %86, %87 : i1
      cf.cond_br %88, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %89 = llhd.prb %tl_u_i : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
      %90 = comb.sub %c2_i32, %84 : i32
      %91 = comb.extract %90 from 2 : (i32) -> i30
      %92 = comb.icmp eq %91, %c0_i30 : i30
      %93 = comb.extract %90 from 0 : (i32) -> i2
      %94 = comb.mux %92, %93, %c-1_i2 : i2
      %95 = hw.array_get %89[%94] : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, i2
      llhd.drv %tl_t_p, %95 after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      cf.br ^bb5
    ^bb5:  // 2 preds: ^bb3, ^bb4
      %96 = comb.add %84, %c1_i32 : i32
      cf.br ^bb2(%96 : i32)
    ^bb6:  // pred: ^bb2
      llhd.wait (%65, %69, %26 : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i1), ^bb1
    }
    %70 = llhd.sig.struct_extract %tl_t_i["d_valid"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %d_valid_2 = hw.struct_extract %69["d_valid"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %70, %d_valid_2 after %1 : i1
    %71 = llhd.sig.struct_extract %tl_t_i["d_opcode"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %d_opcode = hw.struct_extract %69["d_opcode"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %71, %d_opcode after %1 : i3
    %72 = llhd.sig.struct_extract %tl_t_i["d_param"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %d_param = hw.struct_extract %69["d_param"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %72, %d_param after %1 : i3
    %73 = llhd.sig.struct_extract %tl_t_i["d_size"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %d_size = hw.struct_extract %69["d_size"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %73, %d_size after %1 : i2
    %74 = llhd.sig.struct_extract %tl_t_i["d_source"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %d_source = hw.struct_extract %69["d_source"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %74, %d_source after %1 : i8
    %75 = llhd.sig.struct_extract %tl_t_i["d_sink"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %d_sink = hw.struct_extract %69["d_sink"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %75, %d_sink after %1 : i1
    %76 = llhd.sig.struct_extract %tl_t_i["d_data"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %d_data = hw.struct_extract %69["d_data"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %76, %d_data after %1 : i32
    %77 = llhd.sig.struct_extract %tl_t_i["d_user"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %d_user = hw.struct_extract %69["d_user"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %77, %d_user after %1 : !hw.struct<rsp_intg: i7, data_intg: i7>
    %78 = llhd.sig.struct_extract %tl_t_i["d_error"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %d_error = hw.struct_extract %69["d_error"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %78, %d_error after %1 : i1
    %79 = llhd.sig.array_get %tl_u_o[%c0_i2] : <!hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>>
    llhd.drv %79, %6 after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %80 = llhd.sig.array_get %tl_u_i[%c0_i2] : <!hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>>
    llhd.drv %80, %5 after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %81 = llhd.prb %tl_d_o : !hw.array<2xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    hw.output %fifo_h.tl_h_o, %81 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.array<2xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
  }
  hw.module private @tlul_sram_byte(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_sram_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, in %tl_sram_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %error_i : i1, out error_o : i1, out alert_o : i1, out compound_txn_in_progress_o : i1, in %readback_en_i : i4, in %wr_collision_i : i1, in %write_pending_i : i1) {
    %false = hw.constant false
    hw.output %tl_sram_i, %tl_i, %error_i, %false, %false : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, i1, i1, i1
  }
  func.func private @"prim_sha2_pkg::conv_endian32"(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %conv_data = llhd.sig %c0_i32 : i32
    %1 = comb.extract %arg0 from 0 : (i32) -> i8
    %2 = comb.extract %arg0 from 8 : (i32) -> i8
    %3 = comb.extract %arg0 from 16 : (i32) -> i8
    %4 = comb.extract %arg0 from 24 : (i32) -> i8
    %5 = comb.concat %1, %2, %3, %4 : i8, i8, i8, i8
    llhd.drv %conv_data, %5 after %0 : i32
    %6 = llhd.prb %conv_data : i32
    %7 = comb.mux %arg1, %6, %arg0 : i32
    return %7 : i32
  }
  func.func private @"prim_sha2_pkg::rotr32"(%arg0: i32, %arg1: i32) -> i32 {
    %c32_i32 = hw.constant 32 : i32
    %0 = comb.shru %arg0, %arg1 : i32
    %1 = comb.sub %c32_i32, %arg1 : i32
    %2 = comb.shl %arg0, %1 : i32
    %3 = comb.or %0, %2 : i32
    return %3 : i32
  }
  func.func private @"prim_sha2_pkg::rotr64"(%arg0: i64, %arg1: i32) -> i64 {
    %c64_i32 = hw.constant 64 : i32
    %c0_i32 = hw.constant 0 : i32
    %0 = comb.concat %c0_i32, %arg1 : i32, i32
    %1 = comb.shru %arg0, %0 : i64
    %2 = comb.sub %c64_i32, %arg1 : i32
    %3 = comb.concat %c0_i32, %2 : i32, i32
    %4 = comb.shl %arg0, %3 : i64
    %5 = comb.or %1, %4 : i64
    return %5 : i64
  }
  func.func private @"prim_sha2_pkg::shiftr32"(%arg0: i32, %arg1: i32) -> i32 {
    %0 = comb.shru %arg0, %arg1 : i32
    return %0 : i32
  }
  func.func private @"prim_sha2_pkg::shiftr64"(%arg0: i64, %arg1: i32) -> i64 {
    %c0_i32 = hw.constant 0 : i32
    %0 = comb.concat %c0_i32, %arg1 : i32, i32
    %1 = comb.shru %arg0, %0 : i64
    return %1 : i64
  }
  func.func private @"prim_sha2_pkg::compress_multi_256"(%arg0: i32, %arg1: i32, %arg2: !hw.array<8xi64>) -> !hw.array<8xi64> {
    %c3_i3 = hw.constant 3 : i3
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %c-1_i3 = hw.constant -1 : i3
    %c-2_i3 = hw.constant -2 : i3
    %c-1_i32 = hw.constant -1 : i32
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c0_i32 = hw.constant 0 : i32
    %c22_i32 = hw.constant 22 : i32
    %c13_i32 = hw.constant 13 : i32
    %c2_i32 = hw.constant 2 : i32
    %c25_i32 = hw.constant 25 : i32
    %c11_i32 = hw.constant 11 : i32
    %c6_i32 = hw.constant 6 : i32
    %1 = hw.aggregate_constant [0, 0, 0, 0, 0, 0, 0, 0] : !hw.array<8xi64>
    %2 = llhd.sig %1 : !hw.array<8xi64>
    %3 = hw.array_get %arg2[%c-4_i3] : !hw.array<8xi64>, i3
    %4 = comb.extract %3 from 0 : (i64) -> i32
    %5 = call @"prim_sha2_pkg::rotr32"(%4, %c6_i32) : (i32, i32) -> i32
    %6 = call @"prim_sha2_pkg::rotr32"(%4, %c11_i32) : (i32, i32) -> i32
    %7 = call @"prim_sha2_pkg::rotr32"(%4, %c25_i32) : (i32, i32) -> i32
    %8 = comb.xor %5, %6, %7 : i32
    %9 = hw.array_get %arg2[%c-3_i3] : !hw.array<8xi64>, i3
    %10 = comb.extract %9 from 0 : (i64) -> i32
    %11 = comb.and %4, %10 : i32
    %12 = comb.xor %4, %c-1_i32 : i32
    %13 = hw.array_get %arg2[%c-2_i3] : !hw.array<8xi64>, i3
    %14 = comb.extract %13 from 0 : (i64) -> i32
    %15 = comb.and %12, %14 : i32
    %16 = comb.xor %11, %15 : i32
    %17 = hw.array_get %arg2[%c-1_i3] : !hw.array<8xi64>, i3
    %18 = comb.extract %17 from 0 : (i64) -> i32
    %19 = comb.add %18, %8, %16, %arg1, %arg0 : i32
    %20 = hw.array_get %arg2[%c0_i3] : !hw.array<8xi64>, i3
    %21 = comb.extract %20 from 0 : (i64) -> i32
    %22 = call @"prim_sha2_pkg::rotr32"(%21, %c2_i32) : (i32, i32) -> i32
    %23 = call @"prim_sha2_pkg::rotr32"(%21, %c13_i32) : (i32, i32) -> i32
    %24 = call @"prim_sha2_pkg::rotr32"(%21, %c22_i32) : (i32, i32) -> i32
    %25 = comb.xor %22, %23, %24 : i32
    %26 = hw.array_get %arg2[%c1_i3] : !hw.array<8xi64>, i3
    %27 = comb.extract %26 from 0 : (i64) -> i32
    %28 = comb.and %21, %27 : i32
    %29 = hw.array_get %arg2[%c2_i3] : !hw.array<8xi64>, i3
    %30 = comb.extract %29 from 0 : (i64) -> i32
    %31 = comb.and %21, %30 : i32
    %32 = comb.and %27, %30 : i32
    %33 = comb.xor %28, %31, %32 : i32
    %34 = llhd.sig.array_get %2[%c-1_i3] : <!hw.array<8xi64>>
    %35 = comb.concat %c0_i32, %14 : i32, i32
    llhd.drv %34, %35 after %0 : i64
    %36 = llhd.sig.array_get %2[%c-2_i3] : <!hw.array<8xi64>>
    %37 = comb.concat %c0_i32, %10 : i32, i32
    llhd.drv %36, %37 after %0 : i64
    %38 = llhd.sig.array_get %2[%c-3_i3] : <!hw.array<8xi64>>
    %39 = comb.concat %c0_i32, %4 : i32, i32
    llhd.drv %38, %39 after %0 : i64
    %40 = llhd.sig.array_get %2[%c-4_i3] : <!hw.array<8xi64>>
    %41 = hw.array_get %arg2[%c3_i3] : !hw.array<8xi64>, i3
    %42 = comb.extract %41 from 0 : (i64) -> i32
    %43 = comb.add %42, %19 : i32
    %44 = comb.concat %c0_i32, %43 : i32, i32
    llhd.drv %40, %44 after %0 : i64
    %45 = llhd.sig.array_get %2[%c3_i3] : <!hw.array<8xi64>>
    %46 = comb.concat %c0_i32, %30 : i32, i32
    llhd.drv %45, %46 after %0 : i64
    %47 = llhd.sig.array_get %2[%c2_i3] : <!hw.array<8xi64>>
    %48 = comb.concat %c0_i32, %27 : i32, i32
    llhd.drv %47, %48 after %0 : i64
    %49 = llhd.sig.array_get %2[%c1_i3] : <!hw.array<8xi64>>
    %50 = comb.concat %c0_i32, %21 : i32, i32
    llhd.drv %49, %50 after %0 : i64
    %51 = llhd.sig.array_get %2[%c0_i3] : <!hw.array<8xi64>>
    %52 = comb.add %19, %25, %33 : i32
    %53 = comb.concat %c0_i32, %52 : i32, i32
    llhd.drv %51, %53 after %0 : i64
    %54 = llhd.prb %2 : !hw.array<8xi64>
    return %54 : !hw.array<8xi64>
  }
  func.func private @"prim_sha2_pkg::compress_512"(%arg0: i64, %arg1: i64, %arg2: !hw.array<8xi64>) -> !hw.array<8xi64> {
    %c3_i3 = hw.constant 3 : i3
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %c-1_i3 = hw.constant -1 : i3
    %c-2_i3 = hw.constant -2 : i3
    %c-1_i64 = hw.constant -1 : i64
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c39_i32 = hw.constant 39 : i32
    %c34_i32 = hw.constant 34 : i32
    %c28_i32 = hw.constant 28 : i32
    %c41_i32 = hw.constant 41 : i32
    %c18_i32 = hw.constant 18 : i32
    %c14_i32 = hw.constant 14 : i32
    %1 = hw.aggregate_constant [0, 0, 0, 0, 0, 0, 0, 0] : !hw.array<8xi64>
    %2 = llhd.sig %1 : !hw.array<8xi64>
    %3 = hw.array_get %arg2[%c-4_i3] : !hw.array<8xi64>, i3
    %4 = call @"prim_sha2_pkg::rotr64"(%3, %c14_i32) : (i64, i32) -> i64
    %5 = call @"prim_sha2_pkg::rotr64"(%3, %c18_i32) : (i64, i32) -> i64
    %6 = call @"prim_sha2_pkg::rotr64"(%3, %c41_i32) : (i64, i32) -> i64
    %7 = comb.xor %4, %5, %6 : i64
    %8 = hw.array_get %arg2[%c-3_i3] : !hw.array<8xi64>, i3
    %9 = comb.and %3, %8 : i64
    %10 = comb.xor %3, %c-1_i64 : i64
    %11 = hw.array_get %arg2[%c-2_i3] : !hw.array<8xi64>, i3
    %12 = comb.and %10, %11 : i64
    %13 = comb.xor %9, %12 : i64
    %14 = hw.array_get %arg2[%c-1_i3] : !hw.array<8xi64>, i3
    %15 = comb.add %14, %7, %13, %arg1, %arg0 : i64
    %16 = hw.array_get %arg2[%c0_i3] : !hw.array<8xi64>, i3
    %17 = call @"prim_sha2_pkg::rotr64"(%16, %c28_i32) : (i64, i32) -> i64
    %18 = call @"prim_sha2_pkg::rotr64"(%16, %c34_i32) : (i64, i32) -> i64
    %19 = call @"prim_sha2_pkg::rotr64"(%16, %c39_i32) : (i64, i32) -> i64
    %20 = comb.xor %17, %18, %19 : i64
    %21 = hw.array_get %arg2[%c1_i3] : !hw.array<8xi64>, i3
    %22 = comb.and %16, %21 : i64
    %23 = hw.array_get %arg2[%c2_i3] : !hw.array<8xi64>, i3
    %24 = comb.and %16, %23 : i64
    %25 = comb.and %21, %23 : i64
    %26 = comb.xor %22, %24, %25 : i64
    %27 = llhd.sig.array_get %2[%c-1_i3] : <!hw.array<8xi64>>
    llhd.drv %27, %11 after %0 : i64
    %28 = llhd.sig.array_get %2[%c-2_i3] : <!hw.array<8xi64>>
    llhd.drv %28, %8 after %0 : i64
    %29 = llhd.sig.array_get %2[%c-3_i3] : <!hw.array<8xi64>>
    llhd.drv %29, %3 after %0 : i64
    %30 = llhd.sig.array_get %2[%c-4_i3] : <!hw.array<8xi64>>
    %31 = hw.array_get %arg2[%c3_i3] : !hw.array<8xi64>, i3
    %32 = comb.add %31, %15 : i64
    llhd.drv %30, %32 after %0 : i64
    %33 = llhd.sig.array_get %2[%c3_i3] : <!hw.array<8xi64>>
    llhd.drv %33, %23 after %0 : i64
    %34 = llhd.sig.array_get %2[%c2_i3] : <!hw.array<8xi64>>
    llhd.drv %34, %21 after %0 : i64
    %35 = llhd.sig.array_get %2[%c1_i3] : <!hw.array<8xi64>>
    llhd.drv %35, %16 after %0 : i64
    %36 = llhd.sig.array_get %2[%c0_i3] : <!hw.array<8xi64>>
    %37 = comb.add %15, %20, %26 : i64
    llhd.drv %36, %37 after %0 : i64
    %38 = llhd.prb %2 : !hw.array<8xi64>
    return %38 : !hw.array<8xi64>
  }
  func.func private @"prim_sha2_pkg::calc_w_256"(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %c10_i32 = hw.constant 10 : i32
    %c19_i32 = hw.constant 19 : i32
    %c17_i32 = hw.constant 17 : i32
    %c3_i32 = hw.constant 3 : i32
    %c18_i32 = hw.constant 18 : i32
    %c7_i32 = hw.constant 7 : i32
    %0 = call @"prim_sha2_pkg::rotr32"(%arg1, %c7_i32) : (i32, i32) -> i32
    %1 = call @"prim_sha2_pkg::rotr32"(%arg1, %c18_i32) : (i32, i32) -> i32
    %2 = call @"prim_sha2_pkg::shiftr32"(%arg1, %c3_i32) : (i32, i32) -> i32
    %3 = comb.xor %0, %1, %2 : i32
    %4 = call @"prim_sha2_pkg::rotr32"(%arg3, %c17_i32) : (i32, i32) -> i32
    %5 = call @"prim_sha2_pkg::rotr32"(%arg3, %c19_i32) : (i32, i32) -> i32
    %6 = call @"prim_sha2_pkg::shiftr32"(%arg3, %c10_i32) : (i32, i32) -> i32
    %7 = comb.xor %4, %5, %6 : i32
    %8 = comb.add %arg0, %3, %arg2, %7 : i32
    return %8 : i32
  }
  func.func private @"prim_sha2_pkg::calc_w_512"(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i64 {
    %c6_i32 = hw.constant 6 : i32
    %c61_i32 = hw.constant 61 : i32
    %c19_i32 = hw.constant 19 : i32
    %c7_i32 = hw.constant 7 : i32
    %c8_i32 = hw.constant 8 : i32
    %c1_i32 = hw.constant 1 : i32
    %0 = call @"prim_sha2_pkg::rotr64"(%arg1, %c1_i32) : (i64, i32) -> i64
    %1 = call @"prim_sha2_pkg::rotr64"(%arg1, %c8_i32) : (i64, i32) -> i64
    %2 = call @"prim_sha2_pkg::shiftr64"(%arg1, %c7_i32) : (i64, i32) -> i64
    %3 = comb.xor %0, %1, %2 : i64
    %4 = call @"prim_sha2_pkg::rotr64"(%arg3, %c19_i32) : (i64, i32) -> i64
    %5 = call @"prim_sha2_pkg::rotr64"(%arg3, %c61_i32) : (i64, i32) -> i64
    %6 = call @"prim_sha2_pkg::shiftr64"(%arg3, %c6_i32) : (i64, i32) -> i64
    %7 = comb.xor %4, %5, %6 : i64
    %8 = comb.add %arg0, %3, %arg2, %7 : i64
    return %8 : i64
  }
  hw.module private @prim_sha2_32(in %clk_i : i1, in %rst_ni : i1, in %wipe_secret_i : i1, in %wipe_v_i : i32, in %fifo_rvalid_i : i1, in %fifo_rdata_i : !hw.struct<data: i32, mask: i4>, out fifo_rready_o : i1, in %sha_en_i : i1, in %hash_start_i : i1, in %hash_stop_i : i1, in %hash_continue_i : i1, in %digest_mode_i : i4, in %hash_process_i : i1, out hash_done_o : i1, in %message_length_i : i64, in %digest_i : !hw.array<8xi64>, in %digest_we_i : i8, out digest_o : !hw.array<8xi64>, out digest_on_blk_o : i1, out hash_running_o : i1, out idle_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c0_i3 = hw.constant 0 : i3
    %c0_i6 = hw.constant 0 : i6
    %c-4_i3 = hw.constant -4 : i3
    %c-32_i6 = hw.constant -32 : i6
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [0, 0 : i8] : !hw.struct<data: i64, mask: i8>
    %3 = hw.aggregate_constant [0 : i32, 0 : i4] : !hw.struct<data: i32, mask: i4>
    %c-8_i4 = hw.constant -8 : i4
    %c0_i4 = hw.constant 0 : i4
    %c0_i32 = hw.constant 0 : i32
    %c-2_i2 = hw.constant -2 : i2
    %c-1_i4 = hw.constant -1 : i4
    %true = hw.constant true
    %c1_i2 = hw.constant 1 : i2
    %c1_i4 = hw.constant 1 : i4
    %c0_i2 = hw.constant 0 : i2
    %c0_i64 = hw.constant 0 : i64
    %c-1_i8 = hw.constant -1 : i8
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %4 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %5 = llhd.prb %rst_ni_1 : i1
    %fifo_rvalid_i_2 = llhd.sig name "fifo_rvalid_i" %false : i1
    %fifo_rdata_i_3 = llhd.sig name "fifo_rdata_i" %3 : !hw.struct<data: i32, mask: i4>
    %fifo_rready_o = llhd.sig %false : i1
    %sha_en_i_4 = llhd.sig name "sha_en_i" %false : i1
    %digest_mode_i_5 = llhd.sig name "digest_mode_i" %c0_i4 : i4
    %hash_process_i_6 = llhd.sig name "hash_process_i" %false : i1
    %hash_done_o = llhd.sig %false : i1
    %full_word = llhd.sig %2 : !hw.struct<data: i64, mask: i8>
    %sha_ready = llhd.sig %false : i1
    %hash_go = llhd.sig %false : i1
    %fifo_st = llhd.sig %c0_i2 : i2
    %gen_multimode_logic.word_buffer_d = llhd.sig %2 : !hw.struct<data: i64, mask: i8>
    %gen_multimode_logic.word_buffer_q = llhd.sig %2 : !hw.struct<data: i64, mask: i8>
    %gen_multimode_logic.word_part_count_d = llhd.sig %c0_i2 : i2
    %gen_multimode_logic.word_part_count_q = llhd.sig %c0_i2 : i2
    %gen_multimode_logic.sha_process = llhd.sig %false : i1
    %gen_multimode_logic.process_flag_d = llhd.sig %false : i1
    %gen_multimode_logic.process_flag_q = llhd.sig %false : i1
    %gen_multimode_logic.word_valid = llhd.sig %false : i1
    %gen_multimode_logic.word_part_inc = llhd.sig %false : i1
    %gen_multimode_logic.word_part_reset = llhd.sig %false : i1
    %gen_multimode_logic.digest_mode_flag_d = llhd.sig %c0_i4 : i4
    %gen_multimode_logic.digest_mode_flag_q = llhd.sig %c0_i4 : i4
    %6 = llhd.prb %gen_multimode_logic.word_valid : i1
    %7 = llhd.prb %full_word : !hw.struct<data: i64, mask: i8>
    %8 = llhd.prb %sha_en_i_4 : i1
    %9 = llhd.prb %digest_mode_i_5 : i4
    %10 = llhd.prb %gen_multimode_logic.sha_process : i1
    %gen_multimode_logic.u_prim_sha2_multimode.fifo_rready_o, %gen_multimode_logic.u_prim_sha2_multimode.hash_done_o, %gen_multimode_logic.u_prim_sha2_multimode.digest_o, %gen_multimode_logic.u_prim_sha2_multimode.digest_on_blk_o, %gen_multimode_logic.u_prim_sha2_multimode.fifo_st_o, %gen_multimode_logic.u_prim_sha2_multimode.hash_running_o, %gen_multimode_logic.u_prim_sha2_multimode.idle_o = hw.instance "gen_multimode_logic.u_prim_sha2_multimode" @prim_sha2(clk_i: %4: i1, rst_ni: %5: i1, wipe_secret_i: %wipe_secret_i: i1, wipe_v_i: %wipe_v_i: i32, fifo_rvalid_i: %6: i1, fifo_rdata_i: %7: !hw.struct<data: i64, mask: i8>, sha_en_i: %8: i1, hash_start_i: %hash_start_i: i1, hash_stop_i: %hash_stop_i: i1, hash_continue_i: %hash_continue_i: i1, digest_mode_i: %9: i4, hash_process_i: %10: i1, message_length_i: %message_length_i: i64, digest_i: %digest_i: !hw.array<8xi64>, digest_we_i: %digest_we_i: i8) -> (fifo_rready_o: i1, hash_done_o: i1, digest_o: !hw.array<8xi64>, digest_on_blk_o: i1, fifo_st_o: i2, hash_running_o: i1, idle_o: i1)
    llhd.drv %sha_ready, %gen_multimode_logic.u_prim_sha2_multimode.fifo_rready_o after %1 : i1
    llhd.drv %hash_done_o, %gen_multimode_logic.u_prim_sha2_multimode.hash_done_o after %1 : i1
    llhd.drv %fifo_st, %gen_multimode_logic.u_prim_sha2_multimode.fifo_st_o after %1 : i2
    %11 = comb.or %hash_start_i, %hash_continue_i : i1
    llhd.drv %hash_go, %11 after %1 : i1
    %12 = llhd.prb %gen_multimode_logic.word_part_inc : i1
    %13 = llhd.prb %gen_multimode_logic.word_part_reset : i1
    %14 = llhd.prb %fifo_rready_o : i1
    %15 = llhd.prb %hash_go : i1
    %16 = llhd.prb %gen_multimode_logic.word_buffer_d : !hw.struct<data: i64, mask: i8>
    %17 = llhd.prb %fifo_rvalid_i_2 : i1
    %18 = llhd.prb %gen_multimode_logic.word_part_count_q : i2
    %19 = llhd.prb %gen_multimode_logic.digest_mode_flag_q : i4
    %20 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i32, mask: i4>
    %21 = llhd.prb %fifo_st : i2
    %22 = llhd.prb %gen_multimode_logic.word_part_count_d : i2
    %23 = llhd.prb %gen_multimode_logic.digest_mode_flag_d : i4
    %24 = llhd.prb %gen_multimode_logic.process_flag_d : i1
    %25 = llhd.prb %hash_process_i_6 : i1
    %26 = llhd.prb %gen_multimode_logic.process_flag_q : i1
    %27 = llhd.prb %hash_done_o : i1
    %28 = llhd.prb %sha_ready : i1
    %29 = llhd.prb %gen_multimode_logic.word_buffer_q : !hw.struct<data: i64, mask: i8>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb54
      llhd.drv %gen_multimode_logic.word_part_inc, %false after %1 : i1
      llhd.drv %gen_multimode_logic.word_part_reset, %false after %1 : i1
      %30 = llhd.sig.struct_extract %full_word["mask"] : <!hw.struct<data: i64, mask: i8>>
      llhd.drv %30, %c-1_i8 after %1 : i8
      %31 = llhd.sig.struct_extract %full_word["data"] : <!hw.struct<data: i64, mask: i8>>
      llhd.drv %31, %c0_i64 after %1 : i64
      llhd.drv %gen_multimode_logic.sha_process, %false after %1 : i1
      llhd.drv %gen_multimode_logic.word_valid, %false after %1 : i1
      llhd.drv %fifo_rready_o, %false after %1 : i1
      %32 = llhd.prb %sha_en_i_4 : i1
      %33 = comb.xor %32, %true : i1
      %34 = llhd.prb %hash_go : i1
      %35 = comb.or %33, %34 : i1
      cf.cond_br %35, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %gen_multimode_logic.word_buffer_d, %2 after %1 : !hw.struct<data: i64, mask: i8>
      cf.br ^bb4
    ^bb3:  // pred: ^bb1
      %36 = llhd.prb %gen_multimode_logic.word_buffer_q : !hw.struct<data: i64, mask: i8>
      llhd.drv %gen_multimode_logic.word_buffer_d, %36 after %1 : !hw.struct<data: i64, mask: i8>
      cf.br ^bb4
    ^bb4:  // 2 preds: ^bb2, ^bb3
      %37 = llhd.prb %sha_en_i_4 : i1
      %38 = llhd.prb %fifo_rvalid_i_2 : i1
      %39 = comb.and %37, %38 : i1
      cf.cond_br %39, ^bb5, ^bb26
    ^bb5:  // pred: ^bb4
      %40 = llhd.prb %gen_multimode_logic.word_part_count_q : i2
      %41 = comb.icmp eq %40, %c0_i2 : i2
      cf.cond_br %41, ^bb6, ^bb15
    ^bb6:  // pred: ^bb5
      %42 = llhd.prb %gen_multimode_logic.digest_mode_flag_q : i4
      %43 = comb.icmp ne %42, %c1_i4 : i4
      cf.cond_br %43, ^bb7, ^bb10
    ^bb7:  // pred: ^bb6
      %44 = llhd.sig.struct_extract %gen_multimode_logic.word_buffer_d["data"] : <!hw.struct<data: i64, mask: i8>>
      %45 = llhd.sig.extract %44 from %c-32_i6 : <i64> -> <i32>
      %46 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i32, mask: i4>
      %data = hw.struct_extract %46["data"] : !hw.struct<data: i32, mask: i4>
      llhd.drv %45, %data after %1 : i32
      %47 = llhd.sig.struct_extract %gen_multimode_logic.word_buffer_d["mask"] : <!hw.struct<data: i64, mask: i8>>
      %48 = llhd.sig.extract %47 from %c-4_i3 : <i8> -> <i4>
      %49 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i32, mask: i4>
      %mask = hw.struct_extract %49["mask"] : !hw.struct<data: i32, mask: i4>
      llhd.drv %48, %mask after %1 : i4
      %50 = llhd.prb %fifo_st : i2
      %51 = comb.icmp eq %50, %c1_i2 : i2
      cf.cond_br %51, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %fifo_rready_o, %true after %1 : i1
      llhd.drv %gen_multimode_logic.word_part_inc, %true after %1 : i1
      cf.br ^bb39
    ^bb9:  // pred: ^bb7
      llhd.drv %fifo_rready_o, %false after %1 : i1
      llhd.drv %gen_multimode_logic.word_part_inc, %false after %1 : i1
      cf.br ^bb39
    ^bb10:  // pred: ^bb6
      llhd.drv %gen_multimode_logic.word_valid, %true after %1 : i1
      %52 = llhd.sig.struct_extract %gen_multimode_logic.word_buffer_d["data"] : <!hw.struct<data: i64, mask: i8>>
      %53 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i32, mask: i4>
      %data_7 = hw.struct_extract %53["data"] : !hw.struct<data: i32, mask: i4>
      %54 = comb.concat %c0_i32, %data_7 : i32, i32
      llhd.drv %52, %54 after %1 : i64
      %55 = llhd.sig.struct_extract %gen_multimode_logic.word_buffer_d["mask"] : <!hw.struct<data: i64, mask: i8>>
      %56 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i32, mask: i4>
      %mask_8 = hw.struct_extract %56["mask"] : !hw.struct<data: i32, mask: i4>
      %57 = comb.concat %c-1_i4, %mask_8 : i4, i4
      llhd.drv %55, %57 after %1 : i8
      %58 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i32, mask: i4>
      %data_9 = hw.struct_extract %58["data"] : !hw.struct<data: i32, mask: i4>
      %59 = comb.concat %c0_i32, %data_9 : i32, i32
      llhd.drv %31, %59 after %1 : i64
      %60 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i32, mask: i4>
      %mask_10 = hw.struct_extract %60["mask"] : !hw.struct<data: i32, mask: i4>
      %61 = comb.concat %c-1_i4, %mask_10 : i4, i4
      llhd.drv %30, %61 after %1 : i8
      %62 = llhd.prb %hash_process_i_6 : i1
      %63 = llhd.prb %gen_multimode_logic.process_flag_q : i1
      %64 = comb.or %62, %63 : i1
      cf.cond_br %64, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      llhd.drv %gen_multimode_logic.sha_process, %true after %1 : i1
      cf.br ^bb12
    ^bb12:  // 2 preds: ^bb10, ^bb11
      %65 = llhd.prb %sha_ready : i1
      cf.cond_br %65, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      llhd.drv %fifo_rready_o, %true after %1 : i1
      cf.br ^bb39
    ^bb14:  // pred: ^bb12
      llhd.drv %fifo_rready_o, %false after %1 : i1
      cf.br ^bb39
    ^bb15:  // pred: ^bb5
      %66 = llhd.prb %gen_multimode_logic.word_part_count_q : i2
      %67 = comb.icmp eq %66, %c1_i2 : i2
      cf.cond_br %67, ^bb16, ^bb21
    ^bb16:  // pred: ^bb15
      %68 = llhd.sig.struct_extract %gen_multimode_logic.word_buffer_d["data"] : <!hw.struct<data: i64, mask: i8>>
      %69 = llhd.sig.extract %68 from %c0_i6 : <i64> -> <i32>
      %70 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i32, mask: i4>
      %data_11 = hw.struct_extract %70["data"] : !hw.struct<data: i32, mask: i4>
      llhd.drv %69, %data_11 after %1 : i32
      %71 = llhd.sig.struct_extract %gen_multimode_logic.word_buffer_d["mask"] : <!hw.struct<data: i64, mask: i8>>
      %72 = llhd.sig.extract %71 from %c0_i3 : <i8> -> <i4>
      %73 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i32, mask: i4>
      %mask_12 = hw.struct_extract %73["mask"] : !hw.struct<data: i32, mask: i4>
      llhd.drv %72, %mask_12 after %1 : i4
      llhd.drv %gen_multimode_logic.word_valid, %true after %1 : i1
      %74 = llhd.sig.extract %31 from %c-32_i6 : <i64> -> <i32>
      %75 = llhd.prb %gen_multimode_logic.word_buffer_q : !hw.struct<data: i64, mask: i8>
      %data_13 = hw.struct_extract %75["data"] : !hw.struct<data: i64, mask: i8>
      %76 = comb.extract %data_13 from 32 : (i64) -> i32
      llhd.drv %74, %76 after %1 : i32
      %77 = llhd.sig.extract %30 from %c-4_i3 : <i8> -> <i4>
      %78 = llhd.prb %gen_multimode_logic.word_buffer_q : !hw.struct<data: i64, mask: i8>
      %mask_14 = hw.struct_extract %78["mask"] : !hw.struct<data: i64, mask: i8>
      %79 = comb.extract %mask_14 from 4 : (i8) -> i4
      llhd.drv %77, %79 after %1 : i4
      %80 = llhd.sig.extract %31 from %c0_i6 : <i64> -> <i32>
      %81 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i32, mask: i4>
      %data_15 = hw.struct_extract %81["data"] : !hw.struct<data: i32, mask: i4>
      llhd.drv %80, %data_15 after %1 : i32
      %82 = llhd.sig.extract %30 from %c0_i3 : <i8> -> <i4>
      %83 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i32, mask: i4>
      %mask_16 = hw.struct_extract %83["mask"] : !hw.struct<data: i32, mask: i4>
      llhd.drv %82, %mask_16 after %1 : i4
      %84 = llhd.prb %hash_process_i_6 : i1
      %85 = llhd.prb %gen_multimode_logic.process_flag_q : i1
      %86 = comb.or %84, %85 : i1
      cf.cond_br %86, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      llhd.drv %gen_multimode_logic.sha_process, %true after %1 : i1
      cf.br ^bb18
    ^bb18:  // 2 preds: ^bb16, ^bb17
      %87 = llhd.prb %sha_ready : i1
      cf.cond_br %87, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      llhd.drv %fifo_rready_o, %true after %1 : i1
      llhd.drv %gen_multimode_logic.word_part_reset, %true after %1 : i1
      llhd.drv %gen_multimode_logic.word_part_inc, %false after %1 : i1
      cf.br ^bb39
    ^bb20:  // pred: ^bb18
      llhd.drv %fifo_rready_o, %false after %1 : i1
      llhd.drv %gen_multimode_logic.word_part_inc, %false after %1 : i1
      cf.br ^bb39
    ^bb21:  // pred: ^bb15
      %88 = llhd.prb %gen_multimode_logic.word_part_count_q : i2
      %89 = comb.icmp eq %88, %c-2_i2 : i2
      cf.cond_br %89, ^bb22, ^bb39
    ^bb22:  // pred: ^bb21
      llhd.drv %fifo_rready_o, %false after %1 : i1
      llhd.drv %gen_multimode_logic.word_valid, %true after %1 : i1
      %90 = llhd.prb %gen_multimode_logic.word_buffer_q : !hw.struct<data: i64, mask: i8>
      llhd.drv %full_word, %90 after %1 : !hw.struct<data: i64, mask: i8>
      %91 = llhd.prb %hash_process_i_6 : i1
      %92 = llhd.prb %gen_multimode_logic.process_flag_q : i1
      %93 = comb.or %91, %92 : i1
      cf.cond_br %93, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      llhd.drv %gen_multimode_logic.sha_process, %true after %1 : i1
      cf.br ^bb24
    ^bb24:  // 2 preds: ^bb22, ^bb23
      %94 = llhd.prb %sha_ready : i1
      cf.cond_br %94, ^bb25, ^bb39
    ^bb25:  // pred: ^bb24
      llhd.drv %gen_multimode_logic.word_part_reset, %true after %1 : i1
      cf.br ^bb39
    ^bb26:  // pred: ^bb4
      %95 = llhd.prb %sha_en_i_4 : i1
      cf.cond_br %95, ^bb27, ^bb39
    ^bb27:  // pred: ^bb26
      %96 = llhd.prb %gen_multimode_logic.word_buffer_q : !hw.struct<data: i64, mask: i8>
      llhd.drv %full_word, %96 after %1 : !hw.struct<data: i64, mask: i8>
      %97 = llhd.prb %gen_multimode_logic.word_part_count_q : i2
      %98 = comb.icmp eq %97, %c0_i2 : i2
      %99 = llhd.prb %hash_process_i_6 : i1
      %100 = llhd.prb %gen_multimode_logic.process_flag_q : i1
      %101 = comb.or %99, %100 : i1
      %102 = comb.and %98, %101 : i1
      cf.cond_br %102, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      llhd.drv %gen_multimode_logic.sha_process, %true after %1 : i1
      cf.br ^bb39
    ^bb29:  // pred: ^bb27
      %103 = llhd.prb %gen_multimode_logic.word_part_count_q : i2
      %104 = comb.icmp eq %103, %c1_i2 : i2
      %105 = llhd.prb %hash_process_i_6 : i1
      %106 = llhd.prb %gen_multimode_logic.process_flag_q : i1
      %107 = comb.or %105, %106 : i1
      %108 = comb.and %104, %107 : i1
      cf.cond_br %108, ^bb30, ^bb32
    ^bb30:  // pred: ^bb29
      %109 = llhd.sig.extract %31 from %c0_i6 : <i64> -> <i32>
      llhd.drv %109, %c0_i32 after %1 : i32
      %110 = llhd.sig.extract %30 from %c0_i3 : <i8> -> <i4>
      llhd.drv %110, %c0_i4 after %1 : i4
      llhd.drv %gen_multimode_logic.word_valid, %true after %1 : i1
      llhd.drv %gen_multimode_logic.sha_process, %true after %1 : i1
      %111 = llhd.prb %sha_ready : i1
      cf.cond_br %111, ^bb31, ^bb39
    ^bb31:  // pred: ^bb30
      llhd.drv %gen_multimode_logic.word_part_reset, %true after %1 : i1
      cf.br ^bb39
    ^bb32:  // pred: ^bb29
      %112 = llhd.prb %gen_multimode_logic.word_part_count_q : i2
      %113 = comb.icmp eq %112, %c1_i2 : i2
      cf.cond_br %113, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      llhd.drv %gen_multimode_logic.word_valid, %false after %1 : i1
      cf.br ^bb39
    ^bb34:  // pred: ^bb32
      %114 = llhd.prb %gen_multimode_logic.word_part_count_q : i2
      %115 = comb.icmp eq %114, %c-2_i2 : i2
      %116 = llhd.prb %hash_process_i_6 : i1
      %117 = llhd.prb %gen_multimode_logic.process_flag_q : i1
      %118 = comb.or %116, %117 : i1
      %119 = comb.and %115, %118 : i1
      cf.cond_br %119, ^bb35, ^bb37
    ^bb35:  // pred: ^bb34
      llhd.drv %gen_multimode_logic.word_valid, %true after %1 : i1
      llhd.drv %gen_multimode_logic.sha_process, %true after %1 : i1
      %120 = llhd.prb %sha_ready : i1
      cf.cond_br %120, ^bb36, ^bb39
    ^bb36:  // pred: ^bb35
      llhd.drv %gen_multimode_logic.word_part_reset, %true after %1 : i1
      cf.br ^bb39
    ^bb37:  // pred: ^bb34
      %121 = llhd.prb %gen_multimode_logic.word_part_count_q : i2
      %122 = comb.icmp eq %121, %c-2_i2 : i2
      cf.cond_br %122, ^bb38, ^bb39
    ^bb38:  // pred: ^bb37
      llhd.drv %gen_multimode_logic.word_valid, %false after %1 : i1
      cf.br ^bb39
    ^bb39:  // 18 preds: ^bb8, ^bb9, ^bb13, ^bb14, ^bb19, ^bb20, ^bb21, ^bb24, ^bb25, ^bb26, ^bb28, ^bb30, ^bb31, ^bb33, ^bb35, ^bb36, ^bb37, ^bb38
      %123 = llhd.prb %gen_multimode_logic.word_part_reset : i1
      %124 = llhd.prb %hash_go : i1
      %125 = llhd.prb %sha_en_i_4 : i1
      %126 = comb.xor %125, %true : i1
      %127 = comb.or %123, %124, %126 : i1
      cf.cond_br %127, ^bb40, ^bb41
    ^bb40:  // pred: ^bb39
      llhd.drv %gen_multimode_logic.word_part_count_d, %c0_i2 after %1 : i2
      cf.br ^bb44
    ^bb41:  // pred: ^bb39
      %128 = llhd.prb %gen_multimode_logic.word_part_inc : i1
      cf.cond_br %128, ^bb42, ^bb43
    ^bb42:  // pred: ^bb41
      %129 = llhd.prb %gen_multimode_logic.word_part_count_q : i2
      %130 = comb.add %129, %c1_i2 : i2
      llhd.drv %gen_multimode_logic.word_part_count_d, %130 after %1 : i2
      cf.br ^bb44
    ^bb43:  // pred: ^bb41
      %131 = llhd.prb %gen_multimode_logic.word_part_count_q : i2
      llhd.drv %gen_multimode_logic.word_part_count_d, %131 after %1 : i2
      cf.br ^bb44
    ^bb44:  // 3 preds: ^bb40, ^bb42, ^bb43
      %132 = llhd.prb %hash_go : i1
      cf.cond_br %132, ^bb45, ^bb46
    ^bb45:  // pred: ^bb44
      %133 = llhd.prb %digest_mode_i_5 : i4
      llhd.drv %gen_multimode_logic.digest_mode_flag_d, %133 after %1 : i4
      cf.br ^bb49
    ^bb46:  // pred: ^bb44
      %134 = llhd.prb %hash_done_o : i1
      cf.cond_br %134, ^bb47, ^bb48
    ^bb47:  // pred: ^bb46
      llhd.drv %gen_multimode_logic.digest_mode_flag_d, %c-8_i4 after %1 : i4
      cf.br ^bb49
    ^bb48:  // pred: ^bb46
      %135 = llhd.prb %gen_multimode_logic.digest_mode_flag_q : i4
      llhd.drv %gen_multimode_logic.digest_mode_flag_d, %135 after %1 : i4
      cf.br ^bb49
    ^bb49:  // 3 preds: ^bb45, ^bb47, ^bb48
      %136 = llhd.prb %sha_en_i_4 : i1
      %137 = comb.xor %136, %true : i1
      %138 = llhd.prb %hash_go : i1
      %139 = comb.or %137, %138 : i1
      cf.cond_br %139, ^bb50, ^bb51
    ^bb50:  // pred: ^bb49
      llhd.drv %gen_multimode_logic.process_flag_d, %false after %1 : i1
      cf.br ^bb54
    ^bb51:  // pred: ^bb49
      %140 = llhd.prb %hash_process_i_6 : i1
      cf.cond_br %140, ^bb52, ^bb53
    ^bb52:  // pred: ^bb51
      llhd.drv %gen_multimode_logic.process_flag_d, %true after %1 : i1
      cf.br ^bb54
    ^bb53:  // pred: ^bb51
      %141 = llhd.prb %gen_multimode_logic.process_flag_q : i1
      llhd.drv %gen_multimode_logic.process_flag_d, %141 after %1 : i1
      cf.br ^bb54
    ^bb54:  // 3 preds: ^bb50, ^bb52, ^bb53
      llhd.wait (%12, %13, %7, %10, %6, %14, %8, %15, %16, %17, %18, %19, %20, %21, %22, %9, %23, %24, %25, %26, %27, %28, %29 : i1, i1, !hw.struct<data: i64, mask: i8>, i1, i1, i1, i1, i1, !hw.struct<data: i64, mask: i8>, i1, i2, i4, !hw.struct<data: i32, mask: i4>, i2, i2, i4, i4, i1, i1, i1, i1, i1, !hw.struct<data: i64, mask: i8>), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %30 = llhd.prb %clk_i_0 : i1
      %31 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %32 = llhd.prb %clk_i_0 : i1
      %33 = comb.xor bin %30, %true : i1
      %34 = comb.and bin %33, %32 : i1
      %35 = llhd.prb %rst_ni_1 : i1
      %36 = comb.xor bin %35, %true : i1
      %37 = comb.and bin %31, %36 : i1
      %38 = comb.or bin %34, %37 : i1
      cf.cond_br %38, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %39 = llhd.prb %rst_ni_1 : i1
      %40 = comb.xor %39, %true : i1
      cf.cond_br %40, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_multimode_logic.word_part_count_q, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %41 = llhd.prb %gen_multimode_logic.word_part_count_d : i2
      llhd.drv %gen_multimode_logic.word_part_count_q, %41 after %0 : i2
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %30 = llhd.prb %clk_i_0 : i1
      %31 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %32 = llhd.prb %clk_i_0 : i1
      %33 = comb.xor bin %30, %true : i1
      %34 = comb.and bin %33, %32 : i1
      %35 = llhd.prb %rst_ni_1 : i1
      %36 = comb.xor bin %35, %true : i1
      %37 = comb.and bin %31, %36 : i1
      %38 = comb.or bin %34, %37 : i1
      cf.cond_br %38, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %39 = llhd.prb %rst_ni_1 : i1
      %40 = comb.xor %39, %true : i1
      cf.cond_br %40, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_multimode_logic.word_buffer_q, %2 after %0 : !hw.struct<data: i64, mask: i8>
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %41 = llhd.prb %gen_multimode_logic.word_buffer_d : !hw.struct<data: i64, mask: i8>
      llhd.drv %gen_multimode_logic.word_buffer_q, %41 after %0 : !hw.struct<data: i64, mask: i8>
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %30 = llhd.prb %clk_i_0 : i1
      %31 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %32 = llhd.prb %clk_i_0 : i1
      %33 = comb.xor bin %30, %true : i1
      %34 = comb.and bin %33, %32 : i1
      %35 = llhd.prb %rst_ni_1 : i1
      %36 = comb.xor bin %35, %true : i1
      %37 = comb.and bin %31, %36 : i1
      %38 = comb.or bin %34, %37 : i1
      cf.cond_br %38, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %39 = llhd.prb %rst_ni_1 : i1
      %40 = comb.xor %39, %true : i1
      cf.cond_br %40, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_multimode_logic.process_flag_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %41 = llhd.prb %gen_multimode_logic.process_flag_d : i1
      llhd.drv %gen_multimode_logic.process_flag_q, %41 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %30 = llhd.prb %clk_i_0 : i1
      %31 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %32 = llhd.prb %clk_i_0 : i1
      %33 = comb.xor bin %30, %true : i1
      %34 = comb.and bin %33, %32 : i1
      %35 = llhd.prb %rst_ni_1 : i1
      %36 = comb.xor bin %35, %true : i1
      %37 = comb.and bin %31, %36 : i1
      %38 = comb.or bin %34, %37 : i1
      cf.cond_br %38, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %39 = llhd.prb %rst_ni_1 : i1
      %40 = comb.xor %39, %true : i1
      cf.cond_br %40, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_multimode_logic.digest_mode_flag_q, %c-8_i4 after %0 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %41 = llhd.prb %gen_multimode_logic.digest_mode_flag_d : i4
      llhd.drv %gen_multimode_logic.digest_mode_flag_q, %41 after %0 : i4
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %fifo_rvalid_i_2, %fifo_rvalid_i after %1 : i1
    llhd.drv %fifo_rdata_i_3, %fifo_rdata_i after %1 : !hw.struct<data: i32, mask: i4>
    llhd.drv %sha_en_i_4, %sha_en_i after %1 : i1
    llhd.drv %digest_mode_i_5, %digest_mode_i after %1 : i4
    llhd.drv %hash_process_i_6, %hash_process_i after %1 : i1
    hw.output %14, %27, %gen_multimode_logic.u_prim_sha2_multimode.digest_o, %gen_multimode_logic.u_prim_sha2_multimode.digest_on_blk_o, %gen_multimode_logic.u_prim_sha2_multimode.hash_running_o, %gen_multimode_logic.u_prim_sha2_multimode.idle_o : i1, i1, !hw.array<8xi64>, i1, i1, i1
  }
  hw.module private @prim_sha2(in %clk_i : i1, in %rst_ni : i1, in %wipe_secret_i : i1, in %wipe_v_i : i32, in %fifo_rvalid_i : i1, in %fifo_rdata_i : !hw.struct<data: i64, mask: i8>, out fifo_rready_o : i1, in %sha_en_i : i1, in %hash_start_i : i1, in %hash_stop_i : i1, in %hash_continue_i : i1, in %digest_mode_i : i4, in %hash_process_i : i1, out hash_done_o : i1, in %message_length_i : i64, in %digest_i : !hw.array<8xi64>, in %digest_we_i : i8, out digest_o : !hw.array<8xi64>, out digest_on_blk_o : i1, out fifo_st_o : i2, out hash_running_o : i1, out idle_o : i1) {
    %c1_i7 = hw.constant 1 : i7
    %0 = hw.aggregate_constant [7640891576956012808, -4942790177534073029, 4354685564936845355, -6534734903238641935, 5840696475078001361, -7276294671716946913, 2270897969802886507, 6620516959819538809] : !hw.array<8xi64>
    %1 = hw.aggregate_constant [-3766243637369397544, 7105036623409894663, -7973340178411365097, 1526699215303891257, 7436329637833083697, -8163818279084223215, -2662702644619276377, 5167115440072839076] : !hw.array<8xi64>
    %2 = hw.aggregate_constant [1779033703 : i32, -1150833019 : i32, 1013904242 : i32, -1521486534 : i32, 1359893119 : i32, -1694144372 : i32, 528734635 : i32, 1541459225 : i32] : !hw.array<8xi32>
    %3 = hw.aggregate_constant [4794697086780616226, 8158064640168781261, -5349999486874862801, -1606136188198331460, 4131703408338449720, 6480981068601479193, -7908458776815382629, -6116909921290321640, -2880145864133508542, 1334009975649890238, 2608012711638119052, 6128411473006802146, 8268148722764581231, -9160688886553864527, -7215885187991268811, -4495734319001033068, -1973867731355612462, -1171420211273849373, 1135362057144423861, 2597628984639134821, 3308224258029322869, 5365058923640841347, 6679025012923562964, 8573033837759648693, -7476448914759557205, -6327057829258317296, -5763719355590565569, -4658551843659510044, -4116276920077217854, -3051310485924567259, 489312712824947311, 1452737877330783856, 2861767655752347644, 3322285676063803686, 5560940570517711597, 5996557281743188959, 7280758554555802590, 8532644243296465576, -9096487096722542874, -7894198246740708037, -6719396339535248540, -6333637450476146687, -4446306890439682159, -4076793802049405392, -3345356375505022440, -2983346525034927856, -860691631967231958, 1182934255886127544, 1847814050463011016, 2177327727835720531, 2830643537854262169, 3796741975233480872, 4115178125766777443, 5681478168544905931, 6601373596472566643, 7507060721942968483, 8399075790359081724, 8693463985226723168, -8878714635349349518, -8302665154208450068, -8016688836872298968, -6606660893046293015, -4685533653050689259, -4147400797238176981, -3880063495543823972, -3348786107499101689, -1523767162380948706, -757361751448694408, 500013540394364858, 748580250866718886, 1242879168328830382, 1977374033974150939, 2944078676154940804, 3659926193048069267, 4368137639120453308, 4836135668995329356, 5532061633213252278, 6448918945643986474, 6902733635092675308, 7801388544844847127] : !hw.array<80xi64>
    %4 = hw.aggregate_constant [1116352408 : i32, 1899447441 : i32, -1245643825 : i32, -373957723 : i32, 961987163 : i32, 1508970993 : i32, -1841331548 : i32, -1424204075 : i32, -670586216 : i32, 310598401 : i32, 607225278 : i32, 1426881987 : i32, 1925078388 : i32, -2132889090 : i32, -1680079193 : i32, -1046744716 : i32, -459576895 : i32, -272742522 : i32, 264347078 : i32, 604807628 : i32, 770255983 : i32, 1249150122 : i32, 1555081692 : i32, 1996064986 : i32, -1740746414 : i32, -1473132947 : i32, -1341970488 : i32, -1084653625 : i32, -958395405 : i32, -710438585 : i32, 113926993 : i32, 338241895 : i32, 666307205 : i32, 773529912 : i32, 1294757372 : i32, 1396182291 : i32, 1695183700 : i32, 1986661051 : i32, -2117940946 : i32, -1838011259 : i32, -1564481375 : i32, -1474664885 : i32, -1035236496 : i32, -949202525 : i32, -778901479 : i32, -694614492 : i32, -200395387 : i32, 275423344 : i32, 430227734 : i32, 506948616 : i32, 659060556 : i32, 883997877 : i32, 958139571 : i32, 1322822218 : i32, 1537002063 : i32, 1747873779 : i32, 1955562222 : i32, 2024104815 : i32, -2067236844 : i32, -1933114872 : i32, -1866530822 : i32, -1538233109 : i32, -1090935817 : i32, -965641998 : i32] : !hw.array<64xi32>
    %c0_i25 = hw.constant 0 : i25
    %c-1_i8 = hw.constant -1 : i8
    %c0_i24 = hw.constant 0 : i24
    %c-1_i3 = hw.constant -1 : i3
    %c0_i29 = hw.constant 0 : i29
    %5 = llhd.constant_time <0ns, 1d, 0e>
    %c-2_i4 = hw.constant -2 : i4
    %c-7_i4 = hw.constant -7 : i4
    %6 = llhd.constant_time <0ns, 0d, 1e>
    %7 = hw.aggregate_constant [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : !hw.array<16xi64>
    %c0_i8 = hw.constant 0 : i8
    %8 = hw.aggregate_constant [0, 0, 0, 0, 0, 0, 0, 0] : !hw.array<8xi64>
    %c63_i7 = hw.constant 63 : i7
    %c0_i10 = hw.constant 0 : i10
    %c0_i9 = hw.constant 0 : i9
    %c64_i32 = hw.constant 64 : i32
    %c48_i32 = hw.constant 48 : i32
    %c-2_i2 = hw.constant -2 : i2
    %c-1_i4 = hw.constant -1 : i4
    %true = hw.constant true
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %false = hw.constant false
    %c0_i4 = hw.constant 0 : i4
    %c0_i32 = hw.constant 0 : i32
    %c1_i32 = hw.constant 1 : i32
    %c0_i7 = hw.constant 0 : i7
    %c7_i32 = hw.constant 7 : i32
    %c8_i32 = hw.constant 8 : i32
    %c-49_i7 = hw.constant -49 : i7
    %c-1_i6 = hw.constant -1 : i6
    %c0_i64 = hw.constant 0 : i64
    %c4_i4 = hw.constant 4 : i4
    %c2_i4 = hw.constant 2 : i4
    %c1_i4 = hw.constant 1 : i4
    %c-8_i4 = hw.constant -8 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %9 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %10 = llhd.prb %rst_ni_1 : i1
    %wipe_secret_i_2 = llhd.sig name "wipe_secret_i" %false : i1
    %wipe_v_i_3 = llhd.sig name "wipe_v_i" %c0_i32 : i32
    %sha_en_i_4 = llhd.sig name "sha_en_i" %false : i1
    %hash_start_i_5 = llhd.sig name "hash_start_i" %false : i1
    %digest_mode_i_6 = llhd.sig name "digest_mode_i" %c0_i4 : i4
    %hash_done_o = llhd.sig %false : i1
    %digest_i_7 = llhd.sig name "digest_i" %8 : !hw.array<8xi64>
    %digest_we_i_8 = llhd.sig name "digest_we_i" %c0_i8 : i8
    %msg_feed_complete = llhd.sig %false : i1
    %shaf_rvalid = llhd.sig %false : i1
    %update_w_from_fifo = llhd.sig %false : i1
    %calculate_next_w = llhd.sig %false : i1
    %init_hash = llhd.sig %false : i1
    %run_hash = llhd.sig %false : i1
    %one_chunk_done = llhd.sig %false : i1
    %update_digest = llhd.sig %false : i1
    %clear_digest = llhd.sig %false : i1
    %hash_done_next = llhd.sig %false : i1
    %hash_go = llhd.sig %false : i1
    %round_d = llhd.sig %c0_i7 : i7
    %round_q = llhd.sig %c0_i7 : i7
    %w_index_d = llhd.sig %c0_i4 : i4
    %w_index_q = llhd.sig %c0_i4 : i4
    %digest_mode_flag_d = llhd.sig %c0_i4 : i4
    %digest_mode_flag_q = llhd.sig %c0_i4 : i4
    %shaf_rdata = llhd.sig %c0_i64 : i64
    %gen_multimode.hash_d = llhd.sig %8 : !hw.array<8xi64>
    %gen_multimode.hash_q = llhd.sig %8 : !hw.array<8xi64>
    %gen_multimode.w_d = llhd.sig %7 : !hw.array<16xi64>
    %gen_multimode.w_q = llhd.sig %7 : !hw.array<16xi64>
    %gen_multimode.digest_d = llhd.sig %8 : !hw.array<8xi64>
    %gen_multimode.digest_q = llhd.sig %8 : !hw.array<8xi64>
    %fifo_st_q = llhd.sig %c0_i2 : i2
    %fifo_st_d = llhd.sig %c0_i2 : i2
    %sha_st_q = llhd.sig %c0_i2 : i2
    %sha_st_d = llhd.sig %c0_i2 : i2
    %sha_en_q = llhd.sig %false : i1
    %update_digest_q = llhd.sig %false : i1
    %update_digest_d = llhd.sig %false : i1
    %11 = llhd.prb %sha_en_i_4 : i1
    %12 = llhd.prb %hash_start_i_5 : i1
    %13 = llhd.prb %digest_mode_i_6 : i4
    %14 = llhd.prb %hash_done_o : i1
    %15 = comb.concat %c0_i64, %message_length_i : i64, i64
    %u_pad.fifo_rready_o, %u_pad.shaf_rvalid_o, %u_pad.shaf_rdata_o, %u_pad.msg_feed_complete_o = hw.instance "u_pad" @prim_sha2_pad(clk_i: %9: i1, rst_ni: %10: i1, fifo_rvalid_i: %fifo_rvalid_i: i1, fifo_rdata_i: %fifo_rdata_i: !hw.struct<data: i64, mask: i8>, shaf_rready_i: %26: i1, sha_en_i: %11: i1, hash_start_i: %12: i1, hash_stop_i: %hash_stop_i: i1, hash_continue_i: %hash_continue_i: i1, digest_mode_i: %13: i4, hash_process_i: %hash_process_i: i1, hash_done_i: %14: i1, message_length_i: %15: i128) -> (fifo_rready_o: i1, shaf_rvalid_o: i1, shaf_rdata_o: i64, msg_feed_complete_o: i1)
    llhd.drv %shaf_rvalid, %u_pad.shaf_rvalid_o after %6 : i1
    llhd.drv %shaf_rdata, %u_pad.shaf_rdata_o after %6 : i64
    llhd.drv %msg_feed_complete, %u_pad.msg_feed_complete_o after %6 : i1
    %16 = comb.or %12, %hash_continue_i : i1
    llhd.drv %hash_go, %16 after %6 : i1
    %17 = llhd.prb %hash_go : i1
    %18 = llhd.prb %digest_mode_flag_q : i4
    %19 = comb.mux %14, %c-8_i4, %18 : i4
    %20 = comb.mux %17, %13, %19 : i4
    llhd.drv %digest_mode_flag_d, %20 after %6 : i4
    %21 = llhd.prb %gen_multimode.w_q : !hw.array<16xi64>
    %22 = llhd.prb %gen_multimode.w_d : !hw.array<16xi64>
    %23 = llhd.prb %wipe_secret_i_2 : i1
    %24 = llhd.prb %wipe_v_i_3 : i32
    %25 = llhd.prb %run_hash : i1
    %26 = llhd.prb %update_w_from_fifo {sv.namehint = "shaf_rready"} : i1
    %27 = llhd.prb %shaf_rdata : i64
    %28 = llhd.prb %calculate_next_w : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb14
      %87 = llhd.prb %gen_multimode.w_q : !hw.array<16xi64>
      llhd.drv %gen_multimode.w_d, %87 after %6 : !hw.array<16xi64>
      %88 = llhd.prb %wipe_secret_i_2 : i1
      cf.cond_br %88, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %89 = llhd.prb %wipe_v_i_3 : i32
      %90 = comb.replicate %89 : (i32) -> i1024
      %91 = hw.bitcast %90 : (i1024) -> !hw.array<16xi64>
      llhd.drv %gen_multimode.w_d, %91 after %6 : !hw.array<16xi64>
      cf.br ^bb14
    ^bb3:  // pred: ^bb1
      %92 = llhd.prb %sha_en_i_4 : i1
      %93 = comb.xor %92, %true : i1
      %94 = llhd.prb %hash_go : i1
      %95 = comb.or %93, %94 : i1
      cf.cond_br %95, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_multimode.w_d, %7 after %6 : !hw.array<16xi64>
      cf.br ^bb14
    ^bb5:  // pred: ^bb3
      %96 = llhd.prb %run_hash : i1
      %97 = comb.xor %96, %true : i1
      %98 = llhd.prb %update_w_from_fifo : i1
      %99 = comb.and %97, %98 : i1
      cf.cond_br %99, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %100 = llhd.prb %shaf_rdata : i64
      %101 = llhd.prb %gen_multimode.w_q : !hw.array<16xi64>
      %102 = hw.array_slice %101[%c1_i4] : (!hw.array<16xi64>) -> !hw.array<15xi64>
      %103 = hw.bitcast %102 : (!hw.array<15xi64>) -> i960
      %104 = comb.concat %100, %103 : i64, i960
      %105 = hw.bitcast %104 : (i1024) -> !hw.array<16xi64>
      llhd.drv %gen_multimode.w_d, %105 after %6 : !hw.array<16xi64>
      cf.br ^bb14
    ^bb7:  // pred: ^bb5
      %106 = llhd.prb %calculate_next_w : i1
      cf.cond_br %106, ^bb8, ^bb12
    ^bb8:  // pred: ^bb7
      %107 = llhd.prb %digest_mode_flag_q : i4
      %108 = comb.icmp eq %107, %c1_i4 : i4
      cf.cond_br %108, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %109 = llhd.prb %gen_multimode.w_q : !hw.array<16xi64>
      %110 = hw.array_get %109[%c0_i4] : !hw.array<16xi64>, i4
      %111 = comb.extract %110 from 0 : (i64) -> i32
      %112 = hw.array_get %109[%c1_i4] : !hw.array<16xi64>, i4
      %113 = comb.extract %112 from 0 : (i64) -> i32
      %114 = hw.array_get %109[%c-7_i4] : !hw.array<16xi64>, i4
      %115 = comb.extract %114 from 0 : (i64) -> i32
      %116 = hw.array_get %109[%c-2_i4] : !hw.array<16xi64>, i4
      %117 = comb.extract %116 from 0 : (i64) -> i32
      %118 = func.call @"prim_sha2_pkg::calc_w_256"(%111, %113, %115, %117) : (i32, i32, i32, i32) -> i32
      %119 = llhd.prb %gen_multimode.w_q : !hw.array<16xi64>
      %120 = hw.array_slice %119[%c1_i4] : (!hw.array<16xi64>) -> !hw.array<15xi64>
      %121 = hw.bitcast %120 : (!hw.array<15xi64>) -> i960
      %122 = comb.concat %c0_i32, %118, %121 : i32, i32, i960
      %123 = hw.bitcast %122 : (i1024) -> !hw.array<16xi64>
      llhd.drv %gen_multimode.w_d, %123 after %6 : !hw.array<16xi64>
      cf.br ^bb14
    ^bb10:  // pred: ^bb8
      %124 = llhd.prb %digest_mode_flag_q : i4
      %125 = comb.icmp eq %124, %c2_i4 : i4
      %126 = comb.icmp eq %124, %c4_i4 : i4
      %127 = comb.or %125, %126 : i1
      cf.cond_br %127, ^bb11, ^bb14
    ^bb11:  // pred: ^bb10
      %128 = llhd.prb %gen_multimode.w_q : !hw.array<16xi64>
      %129 = hw.array_get %128[%c0_i4] : !hw.array<16xi64>, i4
      %130 = hw.array_get %128[%c1_i4] : !hw.array<16xi64>, i4
      %131 = hw.array_get %128[%c-7_i4] : !hw.array<16xi64>, i4
      %132 = hw.array_get %128[%c-2_i4] : !hw.array<16xi64>, i4
      %133 = func.call @"prim_sha2_pkg::calc_w_512"(%129, %130, %131, %132) : (i64, i64, i64, i64) -> i64
      %134 = llhd.prb %gen_multimode.w_q : !hw.array<16xi64>
      %135 = hw.array_slice %134[%c1_i4] : (!hw.array<16xi64>) -> !hw.array<15xi64>
      %136 = hw.bitcast %135 : (!hw.array<15xi64>) -> i960
      %137 = comb.concat %133, %136 : i64, i960
      %138 = hw.bitcast %137 : (i1024) -> !hw.array<16xi64>
      llhd.drv %gen_multimode.w_d, %138 after %6 : !hw.array<16xi64>
      cf.br ^bb14
    ^bb12:  // pred: ^bb7
      %139 = llhd.prb %run_hash : i1
      cf.cond_br %139, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      %140 = llhd.prb %gen_multimode.w_q : !hw.array<16xi64>
      %141 = hw.array_slice %140[%c1_i4] : (!hw.array<16xi64>) -> !hw.array<15xi64>
      %142 = hw.bitcast %141 : (!hw.array<15xi64>) -> i960
      %143 = comb.concat %c0_i64, %142 : i64, i960
      %144 = hw.bitcast %143 : (i1024) -> !hw.array<16xi64>
      llhd.drv %gen_multimode.w_d, %144 after %6 : !hw.array<16xi64>
      cf.br ^bb14
    ^bb14:  // 8 preds: ^bb2, ^bb4, ^bb6, ^bb9, ^bb10, ^bb11, ^bb12, ^bb13
      llhd.wait (%21, %22, %23, %24, %11, %17, %25, %26, %27, %28, %18 : !hw.array<16xi64>, !hw.array<16xi64>, i1, i32, i1, i1, i1, i1, i64, i1, i4), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %87 = llhd.prb %clk_i_0 : i1
      %88 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %89 = llhd.prb %clk_i_0 : i1
      %90 = comb.xor bin %87, %true : i1
      %91 = comb.and bin %90, %89 : i1
      %92 = llhd.prb %rst_ni_1 : i1
      %93 = comb.xor bin %92, %true : i1
      %94 = comb.and bin %88, %93 : i1
      %95 = comb.or bin %91, %94 : i1
      cf.cond_br %95, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %96 = llhd.prb %rst_ni_1 : i1
      %97 = comb.xor %96, %true : i1
      cf.cond_br %97, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_multimode.w_q, %7 after %5 : !hw.array<16xi64>
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %98 = llhd.prb %gen_multimode.w_d : !hw.array<16xi64>
      llhd.drv %gen_multimode.w_q, %98 after %5 : !hw.array<16xi64>
      cf.br ^bb1
    }
    %29 = llhd.prb %gen_multimode.hash_q : !hw.array<8xi64>
    %30 = llhd.prb %gen_multimode.hash_d : !hw.array<8xi64>
    %31 = llhd.prb %init_hash : i1
    %32 = llhd.prb %gen_multimode.digest_q : !hw.array<8xi64>
    %33 = llhd.prb %round_q : i7
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb9
      %87 = llhd.prb %gen_multimode.hash_q : !hw.array<8xi64>
      llhd.drv %gen_multimode.hash_d, %87 after %6 : !hw.array<8xi64>
      %88 = llhd.prb %wipe_secret_i_2 : i1
      cf.cond_br %88, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %89 = llhd.prb %wipe_v_i_3 : i32
      %90 = comb.replicate %89 : (i32) -> i512
      %91 = hw.bitcast %90 : (i512) -> !hw.array<8xi64>
      llhd.drv %gen_multimode.hash_d, %91 after %6 : !hw.array<8xi64>
      cf.br ^bb9
    ^bb3:  // pred: ^bb1
      %92 = llhd.prb %init_hash : i1
      cf.cond_br %92, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %93 = llhd.prb %gen_multimode.digest_q : !hw.array<8xi64>
      llhd.drv %gen_multimode.hash_d, %93 after %6 : !hw.array<8xi64>
      cf.br ^bb9
    ^bb5:  // pred: ^bb3
      %94 = llhd.prb %run_hash : i1
      cf.cond_br %94, ^bb6, ^bb9
    ^bb6:  // pred: ^bb5
      %95 = llhd.prb %digest_mode_flag_q : i4
      %96 = comb.icmp eq %95, %c1_i4 : i4
      cf.cond_br %96, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %97 = llhd.prb %gen_multimode.w_q : !hw.array<16xi64>
      %98 = hw.array_get %97[%c0_i4] : !hw.array<16xi64>, i4
      %99 = comb.extract %98 from 0 : (i64) -> i32
      %100 = llhd.prb %round_q : i7
      %101 = comb.extract %100 from 0 : (i7) -> i6
      %102 = comb.sub %c-1_i6, %101 : i6
      %103 = hw.array_get %4[%102] : !hw.array<64xi32>, i6
      %104 = llhd.prb %gen_multimode.hash_q : !hw.array<8xi64>
      %105 = func.call @"prim_sha2_pkg::compress_multi_256"(%99, %103, %104) : (i32, i32, !hw.array<8xi64>) -> !hw.array<8xi64>
      llhd.drv %gen_multimode.hash_d, %105 after %6 : !hw.array<8xi64>
      cf.br ^bb9
    ^bb8:  // pred: ^bb6
      %106 = llhd.prb %gen_multimode.w_q : !hw.array<16xi64>
      %107 = hw.array_get %106[%c0_i4] : !hw.array<16xi64>, i4
      %108 = llhd.prb %round_q : i7
      %109 = comb.sub %c-49_i7, %108 : i7
      %110 = hw.array_get %3[%109] : !hw.array<80xi64>, i7
      %111 = llhd.prb %gen_multimode.hash_q : !hw.array<8xi64>
      %112 = func.call @"prim_sha2_pkg::compress_512"(%107, %110, %111) : (i64, i64, !hw.array<8xi64>) -> !hw.array<8xi64>
      llhd.drv %gen_multimode.hash_d, %112 after %6 : !hw.array<8xi64>
      cf.br ^bb9
    ^bb9:  // 5 preds: ^bb2, ^bb4, ^bb5, ^bb7, ^bb8
      llhd.wait (%29, %30, %23, %24, %31, %32, %25, %18, %21, %33 : !hw.array<8xi64>, !hw.array<8xi64>, i1, i32, i1, !hw.array<8xi64>, i1, i4, !hw.array<16xi64>, i7), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %87 = llhd.prb %clk_i_0 : i1
      %88 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %89 = llhd.prb %clk_i_0 : i1
      %90 = comb.xor bin %87, %true : i1
      %91 = comb.and bin %90, %89 : i1
      %92 = llhd.prb %rst_ni_1 : i1
      %93 = comb.xor bin %92, %true : i1
      %94 = comb.and bin %88, %93 : i1
      %95 = comb.or bin %91, %94 : i1
      cf.cond_br %95, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %96 = llhd.prb %rst_ni_1 : i1
      %97 = comb.xor %96, %true : i1
      cf.cond_br %97, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_multimode.hash_q, %8 after %5 : !hw.array<8xi64>
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %98 = llhd.prb %gen_multimode.hash_d : !hw.array<8xi64>
      llhd.drv %gen_multimode.hash_q, %98 after %5 : !hw.array<8xi64>
      cf.br ^bb1
    }
    %34 = llhd.prb %gen_multimode.digest_d : !hw.array<8xi64>
    %35 = llhd.prb %clear_digest : i1
    %36 = llhd.prb %digest_we_i_8 : i8
    %37 = llhd.prb %digest_i_7 : !hw.array<8xi64>
    %38 = llhd.prb %update_digest : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb21
      %87 = llhd.prb %gen_multimode.digest_q : !hw.array<8xi64>
      llhd.drv %gen_multimode.digest_d, %87 after %6 : !hw.array<8xi64>
      %88 = llhd.prb %wipe_secret_i_2 : i1
      cf.cond_br %88, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %89 = llhd.prb %wipe_v_i_3 : i32
      %90 = comb.replicate %89 : (i32) -> i512
      %91 = hw.bitcast %90 : (i512) -> !hw.array<8xi64>
      llhd.drv %gen_multimode.digest_d, %91 after %6 : !hw.array<8xi64>
      cf.br ^bb21
    ^bb3:  // pred: ^bb1
      %92 = llhd.prb %hash_start_i_5 : i1
      cf.cond_br %92, ^bb4(%c0_i32 : i32), ^bb12
    ^bb4(%93: i32):  // 2 preds: ^bb3, ^bb11
      %94 = comb.icmp slt %93, %c8_i32 : i32
      cf.cond_br %94, ^bb5, ^bb21
    ^bb5:  // pred: ^bb4
      %95 = llhd.prb %digest_mode_i_6 : i4
      %96 = comb.icmp eq %95, %c1_i4 : i4
      cf.cond_br %96, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %97 = comb.extract %93 from 3 : (i32) -> i29
      %98 = comb.icmp eq %97, %c0_i29 : i29
      %99 = comb.extract %93 from 0 : (i32) -> i3
      %100 = comb.mux %98, %99, %c-1_i3 : i3
      %101 = llhd.sig.array_get %gen_multimode.digest_d[%100] : <!hw.array<8xi64>>
      %102 = comb.sub %c7_i32, %93 : i32
      %103 = comb.extract %102 from 3 : (i32) -> i29
      %104 = comb.icmp eq %103, %c0_i29 : i29
      %105 = comb.extract %102 from 0 : (i32) -> i3
      %106 = comb.mux %104, %105, %c-1_i3 : i3
      %107 = hw.array_get %2[%106] : !hw.array<8xi32>, i3
      %108 = comb.concat %c0_i32, %107 : i32, i32
      llhd.drv %101, %108 after %6 : i64
      cf.br ^bb11
    ^bb7:  // pred: ^bb5
      %109 = llhd.prb %digest_mode_i_6 : i4
      %110 = comb.icmp eq %109, %c2_i4 : i4
      cf.cond_br %110, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %111 = comb.extract %93 from 3 : (i32) -> i29
      %112 = comb.icmp eq %111, %c0_i29 : i29
      %113 = comb.extract %93 from 0 : (i32) -> i3
      %114 = comb.mux %112, %113, %c-1_i3 : i3
      %115 = llhd.sig.array_get %gen_multimode.digest_d[%114] : <!hw.array<8xi64>>
      %116 = comb.sub %c7_i32, %93 : i32
      %117 = comb.extract %116 from 3 : (i32) -> i29
      %118 = comb.icmp eq %117, %c0_i29 : i29
      %119 = comb.extract %116 from 0 : (i32) -> i3
      %120 = comb.mux %118, %119, %c-1_i3 : i3
      %121 = hw.array_get %1[%120] : !hw.array<8xi64>, i3
      llhd.drv %115, %121 after %6 : i64
      cf.br ^bb11
    ^bb9:  // pred: ^bb7
      %122 = llhd.prb %digest_mode_i_6 : i4
      %123 = comb.icmp eq %122, %c4_i4 : i4
      cf.cond_br %123, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %124 = comb.extract %93 from 3 : (i32) -> i29
      %125 = comb.icmp eq %124, %c0_i29 : i29
      %126 = comb.extract %93 from 0 : (i32) -> i3
      %127 = comb.mux %125, %126, %c-1_i3 : i3
      %128 = llhd.sig.array_get %gen_multimode.digest_d[%127] : <!hw.array<8xi64>>
      %129 = comb.sub %c7_i32, %93 : i32
      %130 = comb.extract %129 from 3 : (i32) -> i29
      %131 = comb.icmp eq %130, %c0_i29 : i29
      %132 = comb.extract %129 from 0 : (i32) -> i3
      %133 = comb.mux %131, %132, %c-1_i3 : i3
      %134 = hw.array_get %0[%133] : !hw.array<8xi64>, i3
      llhd.drv %128, %134 after %6 : i64
      cf.br ^bb11
    ^bb11:  // 4 preds: ^bb6, ^bb8, ^bb9, ^bb10
      %135 = comb.add %93, %c1_i32 : i32
      cf.br ^bb4(%135 : i32)
    ^bb12:  // pred: ^bb3
      %136 = llhd.prb %clear_digest : i1
      cf.cond_br %136, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      llhd.drv %gen_multimode.digest_d, %8 after %6 : !hw.array<8xi64>
      cf.br ^bb21
    ^bb14:  // pred: ^bb12
      %137 = llhd.prb %sha_en_i_4 : i1
      %138 = comb.xor %137, %true : i1
      cf.cond_br %138, ^bb15, ^bb18
    ^bb15:  // pred: ^bb14
      %i = llhd.sig %c0_i32 : i32
      llhd.drv %i, %c0_i32 after %6 : i32
      cf.br ^bb16
    ^bb16:  // 2 preds: ^bb15, ^bb17
      %139 = llhd.prb %i : i32
      %140 = comb.icmp slt %139, %c8_i32 : i32
      cf.cond_br %140, ^bb17, ^bb21
    ^bb17:  // pred: ^bb16
      %141 = llhd.prb %i : i32
      %142 = comb.extract %141 from 3 : (i32) -> i29
      %143 = comb.icmp eq %142, %c0_i29 : i29
      %144 = comb.extract %141 from 0 : (i32) -> i3
      %145 = comb.mux %143, %144, %c-1_i3 : i3
      %146 = llhd.sig.array_get %gen_multimode.digest_d[%145] : <!hw.array<8xi64>>
      %147 = llhd.prb %digest_we_i_8 : i8
      %148 = comb.extract %141 from 8 : (i32) -> i24
      %149 = comb.icmp eq %148, %c0_i24 : i24
      %150 = comb.extract %141 from 0 : (i32) -> i8
      %151 = comb.mux %149, %150, %c-1_i8 : i8
      %152 = comb.shru %147, %151 : i8
      %153 = comb.extract %152 from 0 : (i8) -> i1
      %154 = llhd.prb %digest_i_7 : !hw.array<8xi64>
      %155 = hw.array_get %154[%145] : !hw.array<8xi64>, i3
      %156 = llhd.prb %gen_multimode.digest_q : !hw.array<8xi64>
      %157 = hw.array_get %156[%145] : !hw.array<8xi64>, i3
      %158 = comb.mux %153, %155, %157 : i64
      llhd.drv %146, %158 after %6 : i64
      %159 = llhd.prb %i : i32
      %160 = comb.add %159, %c1_i32 : i32
      llhd.drv %i, %160 after %6 : i32
      cf.br ^bb16
    ^bb18:  // pred: ^bb14
      %161 = llhd.prb %update_digest : i1
      cf.cond_br %161, ^bb19(%c0_i32 : i32), ^bb21
    ^bb19(%162: i32):  // 2 preds: ^bb18, ^bb20
      %163 = comb.icmp slt %162, %c8_i32 : i32
      cf.cond_br %163, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %164 = comb.extract %162 from 3 : (i32) -> i29
      %165 = comb.icmp eq %164, %c0_i29 : i29
      %166 = comb.extract %162 from 0 : (i32) -> i3
      %167 = comb.mux %165, %166, %c-1_i3 : i3
      %168 = llhd.sig.array_get %gen_multimode.digest_d[%167] : <!hw.array<8xi64>>
      %169 = llhd.prb %gen_multimode.digest_q : !hw.array<8xi64>
      %170 = hw.array_get %169[%167] : !hw.array<8xi64>, i3
      %171 = llhd.prb %gen_multimode.hash_q : !hw.array<8xi64>
      %172 = hw.array_get %171[%167] : !hw.array<8xi64>, i3
      %173 = comb.add %170, %172 : i64
      llhd.drv %168, %173 after %6 : i64
      %174 = comb.add %162, %c1_i32 : i32
      cf.br ^bb19(%174 : i32)
    ^bb21:  // 6 preds: ^bb2, ^bb4, ^bb13, ^bb16, ^bb18, ^bb19
      llhd.wait (%32, %34, %23, %24, %12, %13, %35, %11, %36, %37, %38, %29 : !hw.array<8xi64>, !hw.array<8xi64>, i1, i32, i1, i4, i1, i1, i8, !hw.array<8xi64>, i1, !hw.array<8xi64>), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %87 = llhd.prb %clk_i_0 : i1
      %88 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %89 = llhd.prb %clk_i_0 : i1
      %90 = comb.xor bin %87, %true : i1
      %91 = comb.and bin %90, %89 : i1
      %92 = llhd.prb %rst_ni_1 : i1
      %93 = comb.xor bin %92, %true : i1
      %94 = comb.and bin %88, %93 : i1
      %95 = comb.or bin %91, %94 : i1
      cf.cond_br %95, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %96 = llhd.prb %rst_ni_1 : i1
      %97 = comb.xor %96, %true : i1
      cf.cond_br %97, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_multimode.digest_q, %8 after %5 : !hw.array<8xi64>
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %98 = llhd.prb %gen_multimode.digest_d : !hw.array<8xi64>
      llhd.drv %gen_multimode.digest_q, %98 after %5 : !hw.array<8xi64>
      cf.br ^bb1
    }
    %39 = llhd.prb %round_d : i7
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb7
      %87 = llhd.prb %round_q : i7
      llhd.drv %round_d, %87 after %6 : i7
      %88 = llhd.prb %sha_en_i_4 : i1
      %89 = comb.xor %88, %true : i1
      %90 = llhd.prb %hash_go : i1
      %91 = comb.or %89, %90 : i1
      cf.cond_br %91, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %round_d, %c0_i7 after %6 : i7
      cf.br ^bb7
    ^bb3:  // pred: ^bb1
      %92 = llhd.prb %run_hash : i1
      cf.cond_br %92, ^bb4, ^bb7
    ^bb4:  // pred: ^bb3
      %93 = llhd.prb %round_q : i7
      %94 = comb.extract %93 from 0 : (i7) -> i6
      %95 = comb.icmp eq %94, %c-1_i6 : i6
      %96 = llhd.prb %digest_mode_flag_q : i4
      %97 = comb.icmp eq %96, %c1_i4 : i4
      %98 = comb.and %95, %97 : i1
      %99 = comb.icmp eq %93, %c-49_i7 : i7
      %100 = comb.icmp eq %96, %c2_i4 : i4
      %101 = comb.icmp eq %96, %c4_i4 : i4
      %102 = comb.or %100, %101 : i1
      %103 = comb.and %99, %102 : i1
      %104 = comb.or %98, %103 : i1
      cf.cond_br %104, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %round_d, %c0_i7 after %6 : i7
      cf.br ^bb7
    ^bb6:  // pred: ^bb4
      %105 = llhd.prb %round_q : i7
      %106 = comb.add %105, %c1_i7 : i7
      llhd.drv %round_d, %106 after %6 : i7
      cf.br ^bb7
    ^bb7:  // 4 preds: ^bb2, ^bb3, ^bb5, ^bb6
      llhd.wait (%33, %39, %11, %17, %25, %18 : i7, i7, i1, i1, i1, i4), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %87 = llhd.prb %clk_i_0 : i1
      %88 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %89 = llhd.prb %clk_i_0 : i1
      %90 = comb.xor bin %87, %true : i1
      %91 = comb.and bin %90, %89 : i1
      %92 = llhd.prb %rst_ni_1 : i1
      %93 = comb.xor bin %92, %true : i1
      %94 = comb.and bin %88, %93 : i1
      %95 = comb.or bin %91, %94 : i1
      cf.cond_br %95, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %96 = llhd.prb %rst_ni_1 : i1
      %97 = comb.xor %96, %true : i1
      cf.cond_br %97, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %round_q, %c0_i7 after %5 : i7
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %98 = llhd.prb %round_d : i7
      llhd.drv %round_q, %98 after %5 : i7
      cf.br ^bb1
    }
    %40 = comb.xor %11, %true : i1
    %41 = comb.or %40, %17 : i1
    %42 = llhd.prb %w_index_q : i4
    %43 = comb.add %42, %c1_i4 : i4
    %44 = comb.mux %26, %43, %42 : i4
    %45 = comb.mux %41, %c0_i4, %44 : i4
    llhd.drv %w_index_d, %45 after %6 : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %87 = llhd.prb %clk_i_0 : i1
      %88 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %89 = llhd.prb %clk_i_0 : i1
      %90 = comb.xor bin %87, %true : i1
      %91 = comb.and bin %90, %89 : i1
      %92 = llhd.prb %rst_ni_1 : i1
      %93 = comb.xor bin %92, %true : i1
      %94 = comb.and bin %88, %93 : i1
      %95 = comb.or bin %91, %94 : i1
      cf.cond_br %95, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %96 = llhd.prb %rst_ni_1 : i1
      %97 = comb.xor %96, %true : i1
      cf.cond_br %97, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %w_index_q, %c0_i4 after %5 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %98 = llhd.prb %w_index_d : i4
      llhd.drv %w_index_q, %98 after %5 : i4
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %87 = llhd.prb %clk_i_0 : i1
      %88 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %89 = llhd.prb %clk_i_0 : i1
      %90 = comb.xor bin %87, %true : i1
      %91 = comb.and bin %90, %89 : i1
      %92 = llhd.prb %rst_ni_1 : i1
      %93 = comb.xor bin %92, %true : i1
      %94 = comb.and bin %88, %93 : i1
      %95 = comb.or bin %91, %94 : i1
      cf.cond_br %95, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %96 = llhd.prb %rst_ni_1 : i1
      %97 = comb.xor %96, %true : i1
      cf.cond_br %97, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %hash_done_o, %false after %5 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %98 = llhd.prb %hash_done_next : i1
      llhd.drv %hash_done_o, %98 after %5 : i1
      cf.br ^bb1
    }
    %46 = llhd.prb %fifo_st_q : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %87 = llhd.prb %clk_i_0 : i1
      %88 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %89 = llhd.prb %clk_i_0 : i1
      %90 = comb.xor bin %87, %true : i1
      %91 = comb.and bin %90, %89 : i1
      %92 = llhd.prb %rst_ni_1 : i1
      %93 = comb.xor bin %92, %true : i1
      %94 = comb.and bin %88, %93 : i1
      %95 = comb.or bin %91, %94 : i1
      cf.cond_br %95, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %96 = llhd.prb %rst_ni_1 : i1
      %97 = comb.xor %96, %true : i1
      cf.cond_br %97, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %fifo_st_q, %c0_i2 after %5 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %98 = llhd.prb %fifo_st_d : i2
      llhd.drv %fifo_st_q, %98 after %5 : i2
      cf.br ^bb1
    }
    %47 = llhd.prb %fifo_st_d : i2
    %48 = llhd.prb %hash_done_next : i1
    %49 = llhd.prb %shaf_rvalid : i1
    %50 = llhd.prb %msg_feed_complete : i1
    %51 = llhd.prb %one_chunk_done : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb23
      %87 = llhd.prb %fifo_st_q : i2
      llhd.drv %fifo_st_d, %87 after %6 : i2
      llhd.drv %update_w_from_fifo, %false after %6 : i1
      llhd.drv %hash_done_next, %false after %6 : i1
      %88 = llhd.prb %fifo_st_q : i2
      %89 = comb.icmp ceq %88, %c0_i2 : i2
      cf.cond_br %89, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %90 = llhd.prb %hash_go : i1
      cf.cond_br %90, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %fifo_st_d, %c1_i2 after %6 : i2
      cf.br ^bb19
    ^bb4:  // pred: ^bb2
      llhd.drv %fifo_st_d, %c0_i2 after %6 : i2
      cf.br ^bb19
    ^bb5:  // pred: ^bb1
      %91 = comb.icmp ceq %88, %c1_i2 : i2
      cf.cond_br %91, ^bb6, ^bb12
    ^bb6:  // pred: ^bb5
      %92 = llhd.prb %shaf_rvalid : i1
      %93 = comb.xor %92, %true : i1
      cf.cond_br %93, ^bb7, ^bb9
    ^bb7:  // pred: ^bb6
      llhd.drv %fifo_st_d, %c1_i2 after %6 : i2
      llhd.drv %update_w_from_fifo, %false after %6 : i1
      %94 = llhd.prb %msg_feed_complete : i1
      cf.cond_br %94, ^bb8, ^bb19
    ^bb8:  // pred: ^bb7
      llhd.drv %fifo_st_d, %c0_i2 after %6 : i2
      llhd.drv %hash_done_next, %true after %6 : i1
      cf.br ^bb19
    ^bb9:  // pred: ^bb6
      %95 = llhd.prb %w_index_q : i4
      %96 = comb.icmp eq %95, %c-1_i4 : i4
      cf.cond_br %96, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      llhd.drv %fifo_st_d, %c-2_i2 after %6 : i2
      llhd.drv %update_w_from_fifo, %true after %6 : i1
      cf.br ^bb19
    ^bb11:  // pred: ^bb9
      llhd.drv %fifo_st_d, %c1_i2 after %6 : i2
      llhd.drv %update_w_from_fifo, %true after %6 : i1
      cf.br ^bb19
    ^bb12:  // pred: ^bb5
      %97 = comb.icmp ceq %88, %c-2_i2 : i2
      cf.cond_br %97, ^bb13, ^bb18
    ^bb13:  // pred: ^bb12
      %98 = llhd.prb %msg_feed_complete : i1
      %99 = llhd.prb %one_chunk_done : i1
      %100 = comb.and %98, %99 : i1
      cf.cond_br %100, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      llhd.drv %fifo_st_d, %c0_i2 after %6 : i2
      llhd.drv %hash_done_next, %true after %6 : i1
      cf.br ^bb19
    ^bb15:  // pred: ^bb13
      %101 = llhd.prb %one_chunk_done : i1
      cf.cond_br %101, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      llhd.drv %fifo_st_d, %c1_i2 after %6 : i2
      cf.br ^bb19
    ^bb17:  // pred: ^bb15
      llhd.drv %fifo_st_d, %c-2_i2 after %6 : i2
      cf.br ^bb19
    ^bb18:  // pred: ^bb12
      llhd.drv %fifo_st_d, %c0_i2 after %6 : i2
      cf.br ^bb19
    ^bb19:  // 10 preds: ^bb3, ^bb4, ^bb7, ^bb8, ^bb10, ^bb11, ^bb14, ^bb16, ^bb17, ^bb18
      %102 = llhd.prb %sha_en_i_4 : i1
      %103 = comb.xor %102, %true : i1
      cf.cond_br %103, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      llhd.drv %fifo_st_d, %c0_i2 after %6 : i2
      llhd.drv %update_w_from_fifo, %false after %6 : i1
      cf.br ^bb23
    ^bb21:  // pred: ^bb19
      %104 = llhd.prb %hash_go : i1
      cf.cond_br %104, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      llhd.drv %fifo_st_d, %c1_i2 after %6 : i2
      cf.br ^bb23
    ^bb23:  // 3 preds: ^bb20, ^bb21, ^bb22
      llhd.wait (%46, %47, %26, %48, %17, %11, %49, %50, %42, %51 : i2, i2, i1, i1, i1, i1, i1, i1, i4, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %87 = llhd.prb %clk_i_0 : i1
      %88 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %89 = llhd.prb %clk_i_0 : i1
      %90 = comb.xor bin %87, %true : i1
      %91 = comb.and bin %90, %89 : i1
      %92 = llhd.prb %rst_ni_1 : i1
      %93 = comb.xor bin %92, %true : i1
      %94 = comb.and bin %88, %93 : i1
      %95 = comb.or bin %91, %94 : i1
      cf.cond_br %95, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %96 = llhd.prb %rst_ni_1 : i1
      %97 = comb.xor %96, %true : i1
      cf.cond_br %97, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %digest_mode_flag_q, %c-8_i4 after %5 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %98 = llhd.prb %digest_mode_flag_d : i4
      llhd.drv %digest_mode_flag_q, %98 after %5 : i4
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %87 = llhd.prb %clk_i_0 : i1
      %88 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %89 = llhd.prb %clk_i_0 : i1
      %90 = comb.xor bin %87, %true : i1
      %91 = comb.and bin %90, %89 : i1
      %92 = llhd.prb %rst_ni_1 : i1
      %93 = comb.xor bin %92, %true : i1
      %94 = comb.and bin %88, %93 : i1
      %95 = comb.or bin %91, %94 : i1
      cf.cond_br %95, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %96 = llhd.prb %rst_ni_1 : i1
      %97 = comb.xor %96, %true : i1
      cf.cond_br %97, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %sha_st_q, %c0_i2 after %5 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %98 = llhd.prb %sha_st_d : i2
      llhd.drv %sha_st_q, %98 after %5 : i2
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %87 = llhd.prb %clk_i_0 : i1
      %88 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %89 = llhd.prb %clk_i_0 : i1
      %90 = comb.xor bin %87, %true : i1
      %91 = comb.and bin %90, %89 : i1
      %92 = llhd.prb %rst_ni_1 : i1
      %93 = comb.xor bin %92, %true : i1
      %94 = comb.and bin %88, %93 : i1
      %95 = comb.or bin %91, %94 : i1
      cf.cond_br %95, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %96 = llhd.prb %rst_ni_1 : i1
      %97 = comb.xor %96, %true : i1
      cf.cond_br %97, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %sha_en_q, %false after %5 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %98 = llhd.prb %sha_en_i_4 : i1
      llhd.drv %sha_en_q, %98 after %5 : i1
      cf.br ^bb1
    }
    %52 = llhd.prb %sha_en_q : i1
    %53 = comb.and %40, %52 : i1
    %54 = comb.or %12, %53 : i1
    llhd.drv %clear_digest, %54 after %6 : i1
    %55 = llhd.prb %sha_st_q : i2
    %56 = llhd.prb %sha_st_d : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb18
      llhd.drv %update_digest, %false after %6 : i1
      llhd.drv %calculate_next_w, %false after %6 : i1
      llhd.drv %init_hash, %false after %6 : i1
      llhd.drv %run_hash, %false after %6 : i1
      %87 = llhd.prb %sha_st_q : i2
      llhd.drv %sha_st_d, %87 after %6 : i2
      %88 = llhd.prb %sha_st_q : i2
      %89 = comb.icmp ceq %88, %c0_i2 : i2
      cf.cond_br %89, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %90 = llhd.prb %fifo_st_q : i2
      %91 = comb.icmp eq %90, %c-2_i2 : i2
      cf.cond_br %91, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %init_hash, %true after %6 : i1
      llhd.drv %sha_st_d, %c1_i2 after %6 : i2
      cf.br ^bb16
    ^bb4:  // pred: ^bb2
      llhd.drv %sha_st_d, %c0_i2 after %6 : i2
      cf.br ^bb16
    ^bb5:  // pred: ^bb1
      %92 = comb.icmp ceq %88, %c1_i2 : i2
      cf.cond_br %92, ^bb6, ^bb11
    ^bb6:  // pred: ^bb5
      llhd.drv %run_hash, %true after %6 : i1
      %93 = llhd.prb %digest_mode_flag_q : i4
      %94 = comb.icmp eq %93, %c1_i4 : i4
      %95 = llhd.prb %round_q : i7
      %96 = comb.concat %c0_i25, %95 : i25, i7
      %97 = comb.icmp ult %96, %c48_i32 : i32
      %98 = comb.and %94, %97 : i1
      %99 = comb.icmp eq %93, %c2_i4 : i4
      %100 = comb.icmp eq %93, %c4_i4 : i4
      %101 = comb.or %99, %100 : i1
      %102 = comb.icmp ult %96, %c64_i32 : i32
      %103 = comb.and %101, %102 : i1
      %104 = comb.or %98, %103 : i1
      cf.cond_br %104, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      llhd.drv %calculate_next_w, %true after %6 : i1
      cf.br ^bb16
    ^bb8:  // pred: ^bb6
      %105 = llhd.prb %one_chunk_done : i1
      cf.cond_br %105, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      llhd.drv %sha_st_d, %c-2_i2 after %6 : i2
      cf.br ^bb16
    ^bb10:  // pred: ^bb8
      llhd.drv %sha_st_d, %c1_i2 after %6 : i2
      cf.br ^bb16
    ^bb11:  // pred: ^bb5
      %106 = comb.icmp ceq %88, %c-2_i2 : i2
      cf.cond_br %106, ^bb12, ^bb15
    ^bb12:  // pred: ^bb11
      llhd.drv %update_digest, %true after %6 : i1
      %107 = llhd.prb %fifo_st_q : i2
      %108 = comb.icmp eq %107, %c-2_i2 : i2
      cf.cond_br %108, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      llhd.drv %init_hash, %true after %6 : i1
      llhd.drv %sha_st_d, %c1_i2 after %6 : i2
      cf.br ^bb16
    ^bb14:  // pred: ^bb12
      llhd.drv %sha_st_d, %c0_i2 after %6 : i2
      cf.br ^bb16
    ^bb15:  // pred: ^bb11
      llhd.drv %sha_st_d, %c0_i2 after %6 : i2
      cf.br ^bb16
    ^bb16:  // 8 preds: ^bb3, ^bb4, ^bb7, ^bb9, ^bb10, ^bb13, ^bb14, ^bb15
      %109 = llhd.prb %sha_en_i_4 : i1
      %110 = comb.xor %109, %true : i1
      %111 = llhd.prb %hash_go : i1
      %112 = comb.or %110, %111 : i1
      cf.cond_br %112, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      llhd.drv %sha_st_d, %c0_i2 after %6 : i2
      cf.br ^bb18
    ^bb18:  // 2 preds: ^bb16, ^bb17
      llhd.wait (%38, %28, %31, %25, %55, %56, %46, %11, %17, %18, %33, %51 : i1, i1, i1, i1, i2, i2, i2, i1, i1, i4, i7, i1), ^bb1
    }
    %57 = llhd.prb %update_digest_q : i1
    %58 = comb.or %38, %57 : i1
    %59 = comb.icmp eq %46, %c0_i2 : i2
    %60 = comb.icmp eq %18, %c1_i4 : i4
    %61 = comb.extract %message_length_i from 0 : (i64) -> i9
    %62 = comb.icmp eq %61, %c0_i9 : i9
    %63 = comb.and %60, %62 : i1
    %64 = comb.icmp weq %18, %c2_i4 : i4
    %65 = comb.icmp weq %18, %c4_i4 : i4
    %66 = comb.or %64, %65 : i1
    %67 = comb.extract %message_length_i from 0 : (i64) -> i10
    %68 = comb.icmp eq %67, %c0_i10 : i10
    %69 = comb.and %66, %68 : i1
    %70 = comb.or %63, %69 : i1
    %71 = comb.and %58, %59, %70 : i1
    %72 = comb.or %38, %57 : i1
    %73 = comb.xor %71, %true : i1
    %74 = comb.and %73, %72 : i1
    llhd.drv %update_digest_d, %74 after %6 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %87 = llhd.prb %clk_i_0 : i1
      %88 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %89 = llhd.prb %clk_i_0 : i1
      %90 = comb.xor bin %87, %true : i1
      %91 = comb.and bin %90, %89 : i1
      %92 = llhd.prb %rst_ni_1 : i1
      %93 = comb.xor bin %92, %true : i1
      %94 = comb.and bin %88, %93 : i1
      %95 = comb.or bin %91, %94 : i1
      cf.cond_br %95, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %96 = llhd.prb %rst_ni_1 : i1
      %97 = comb.xor %96, %true : i1
      cf.cond_br %97, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %update_digest_q, %false after %5 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %98 = llhd.prb %update_digest_d : i1
      llhd.drv %update_digest_q, %98 after %5 : i1
      cf.br ^bb1
    }
    %75 = comb.icmp eq %33, %c63_i7 : i7
    %76 = comb.and %60, %75 : i1
    %77 = comb.icmp eq %18, %c2_i4 : i4
    %78 = comb.icmp eq %18, %c4_i4 : i4
    %79 = comb.or %77, %78 : i1
    %80 = comb.icmp eq %33, %c-49_i7 : i7
    %81 = comb.and %79, %80 : i1
    %82 = comb.or %76, %81 : i1
    llhd.drv %one_chunk_done, %82 after %6 : i1
    %83 = comb.or %31, %25, %38 : i1
    %84 = comb.icmp eq %55, %c0_i2 : i2
    %85 = comb.xor %17, %true : i1
    %86 = comb.and %59, %84, %85 : i1
    llhd.drv %clk_i_0, %clk_i after %6 : i1
    llhd.drv %rst_ni_1, %rst_ni after %6 : i1
    llhd.drv %wipe_secret_i_2, %wipe_secret_i after %6 : i1
    llhd.drv %wipe_v_i_3, %wipe_v_i after %6 : i32
    llhd.drv %sha_en_i_4, %sha_en_i after %6 : i1
    llhd.drv %hash_start_i_5, %hash_start_i after %6 : i1
    llhd.drv %digest_mode_i_6, %digest_mode_i after %6 : i4
    llhd.drv %digest_i_7, %digest_i after %6 : !hw.array<8xi64>
    llhd.drv %digest_we_i_8, %digest_we_i after %6 : i8
    hw.output %u_pad.fifo_rready_o, %14, %32, %71, %46, %83, %86 : i1, i1, !hw.array<8xi64>, i1, i2, i1, i1
  }
  hw.module private @prim_sha2_pad(in %clk_i : i1, in %rst_ni : i1, in %fifo_rvalid_i : i1, in %fifo_rdata_i : !hw.struct<data: i64, mask: i8>, out fifo_rready_o : i1, out shaf_rvalid_o : i1, out shaf_rdata_o : i64, in %shaf_rready_i : i1, in %sha_en_i : i1, in %hash_start_i : i1, in %hash_stop_i : i1, in %hash_continue_i : i1, in %digest_mode_i : i4, in %hash_process_i : i1, in %hash_done_i : i1, in %message_length_i : i128, out msg_feed_complete_o : i1) {
    %c6_i7 = hw.constant 6 : i7
    %c5_i7 = hw.constant 5 : i7
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i8 = hw.constant -1 : i8
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %2 = hw.aggregate_constant [0, 0 : i8] : !hw.struct<data: i64, mask: i8>
    %c-8_i4 = hw.constant -8 : i4
    %c1_i122 = hw.constant 1 : i122
    %c1_i123 = hw.constant 1 : i123
    %c0_i128 = hw.constant 0 : i128
    %c0_i32 = hw.constant 0 : i32
    %c0_i64 = hw.constant 0 : i64
    %c-2_i3 = hw.constant -2 : i3
    %c-3_i3 = hw.constant -3 : i3
    %c-2147483648_i32 = hw.constant -2147483648 : i32
    %c-4_i3 = hw.constant -4 : i3
    %c-549755813888_i40 = hw.constant -549755813888 : i40
    %c3_i3 = hw.constant 3 : i3
    %c-140737488355328_i48 = hw.constant -140737488355328 : i48
    %c2_i3 = hw.constant 2 : i3
    %c-36028797018963968_i56 = hw.constant -36028797018963968 : i56
    %c-9223372036854775808_i64 = hw.constant -9223372036854775808 : i64
    %c-128_i8 = hw.constant -128 : i8
    %c-32768_i16 = hw.constant -32768 : i16
    %c-2_i2 = hw.constant -2 : i2
    %c-8388608_i24 = hw.constant -8388608 : i24
    %c1_i2 = hw.constant 1 : i2
    %c2147483648_i64 = hw.constant 2147483648 : i64
    %c0_i2 = hw.constant 0 : i2
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %true = hw.constant true
    %false = hw.constant false
    %c-192_i10 = hw.constant -192 : i10
    %c4_i4 = hw.constant 4 : i4
    %c2_i4 = hw.constant 2 : i4
    %c-96_i9 = hw.constant -96 : i9
    %c1_i4 = hw.constant 1 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %fifo_rvalid_i_2 = llhd.sig name "fifo_rvalid_i" %false : i1
    %fifo_rdata_i_3 = llhd.sig name "fifo_rdata_i" %2 : !hw.struct<data: i64, mask: i8>
    %fifo_rready_o = llhd.sig %false : i1
    %shaf_rvalid_o = llhd.sig %false : i1
    %shaf_rdata_o = llhd.sig %c0_i64 : i64
    %shaf_rready_i_4 = llhd.sig name "shaf_rready_i" %false : i1
    %sha_en_i_5 = llhd.sig name "sha_en_i" %false : i1
    %hash_start_i_6 = llhd.sig name "hash_start_i" %false : i1
    %hash_stop_i_7 = llhd.sig name "hash_stop_i" %false : i1
    %hash_continue_i_8 = llhd.sig name "hash_continue_i" %false : i1
    %digest_mode_i_9 = llhd.sig name "digest_mode_i" %c0_i4 : i4
    %hash_process_i_10 = llhd.sig name "hash_process_i" %false : i1
    %hash_done_i_11 = llhd.sig name "hash_done_i" %false : i1
    %message_length_i_12 = llhd.sig name "message_length_i" %c0_i128 : i128
    %tx_count_d = llhd.sig %c0_i128 : i128
    %tx_count = llhd.sig %c0_i128 : i128
    %inc_txcount = llhd.sig %false : i1
    %fifo_partial = llhd.sig %false : i1
    %txcnt_eq_1a0 = llhd.sig %false : i1
    %txcnt_eq_msg_len = llhd.sig %false : i1
    %hash_go = llhd.sig %false : i1
    %hash_stop_flag_d = llhd.sig %false : i1
    %hash_stop_flag_q = llhd.sig %false : i1
    %hash_process_flag_d = llhd.sig %false : i1
    %hash_process_flag_q = llhd.sig %false : i1
    %digest_mode_flag_d = llhd.sig %c0_i4 : i4
    %digest_mode_flag_q = llhd.sig %c0_i4 : i4
    %sel_data = llhd.sig %c0_i3 : i3
    %st_q = llhd.sig %c0_i3 : i3
    %st_d = llhd.sig %c0_i3 : i3
    %5 = llhd.prb %hash_start_i_6 : i1
    %6 = llhd.prb %hash_continue_i_8 : i1
    %7 = comb.or %5, %6 : i1
    llhd.drv %hash_go, %7 after %1 : i1
    %8 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i64, mask: i8>
    %mask = hw.struct_extract %8["mask"] : !hw.struct<data: i64, mask: i8>
    %9 = comb.icmp ne %mask, %c-1_i8 : i8
    llhd.drv %fifo_partial, %9 after %1 : i1
    %10 = llhd.prb %digest_mode_flag_q : i4
    %11 = comb.icmp eq %10, %c1_i4 : i4
    %12 = llhd.prb %tx_count : i128
    %13 = comb.extract %12 from 0 : (i128) -> i9
    %14 = comb.icmp eq %13, %c-96_i9 : i9
    %15 = comb.icmp eq %10, %c2_i4 : i4
    %16 = comb.icmp eq %10, %c4_i4 : i4
    %17 = comb.or %15, %16 : i1
    %18 = comb.extract %12 from 0 : (i128) -> i10
    %19 = comb.icmp eq %18, %c-192_i10 : i10
    %20 = comb.and %17, %19 : i1
    %21 = comb.mux %11, %14, %20 : i1
    llhd.drv %txcnt_eq_1a0, %21 after %1 : i1
    %22 = llhd.prb %message_length_i_12 : i128
    %23 = comb.icmp eq %12, %22 : i128
    llhd.drv %txcnt_eq_msg_len, %23 after %1 : i1
    %24 = llhd.prb %sha_en_i_5 : i1
    %25 = comb.xor %24, %true : i1
    %26 = llhd.prb %hash_go : i1
    %27 = llhd.prb %hash_done_i_11 : i1
    %28 = comb.or %25, %26, %27 : i1
    %29 = llhd.prb %hash_stop_i_7 : i1
    %30 = llhd.prb %hash_stop_flag_q : i1
    %31 = comb.or %29, %30 : i1
    %32 = comb.xor %28, %true : i1
    %33 = comb.and %32, %31 : i1
    llhd.drv %hash_stop_flag_d, %33 after %1 : i1
    %34 = llhd.prb %hash_process_i_10 : i1
    %35 = llhd.prb %hash_process_flag_q : i1
    %36 = comb.or %34, %35 : i1
    %37 = comb.xor %28, %true : i1
    %38 = comb.and %37, %36 : i1
    llhd.drv %hash_process_flag_d, %38 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %58 = llhd.prb %clk_i_0 : i1
      %59 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %60 = llhd.prb %clk_i_0 : i1
      %61 = comb.xor bin %58, %true : i1
      %62 = comb.and bin %61, %60 : i1
      %63 = llhd.prb %rst_ni_1 : i1
      %64 = comb.xor bin %63, %true : i1
      %65 = comb.and bin %59, %64 : i1
      %66 = comb.or bin %62, %65 : i1
      cf.cond_br %66, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %67 = llhd.prb %rst_ni_1 : i1
      %68 = comb.xor %67, %true : i1
      cf.cond_br %68, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %hash_stop_flag_q, %false after %0 : i1
      llhd.drv %hash_process_flag_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %69 = llhd.prb %hash_stop_flag_d : i1
      llhd.drv %hash_stop_flag_q, %69 after %0 : i1
      %70 = llhd.prb %hash_process_flag_d : i1
      llhd.drv %hash_process_flag_q, %70 after %0 : i1
      cf.br ^bb1
    }
    %39 = llhd.prb %sel_data : i3
    %40 = llhd.prb %shaf_rdata_o : i64
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb34
      %58 = llhd.prb %sel_data : i3
      %59 = comb.icmp ceq %58, %c0_i3 : i3
      cf.cond_br %59, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %60 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i64, mask: i8>
      %data = hw.struct_extract %60["data"] : !hw.struct<data: i64, mask: i8>
      llhd.drv %shaf_rdata_o, %data after %1 : i64
      cf.br ^bb34
    ^bb3:  // pred: ^bb1
      %61 = comb.icmp ceq %58, %c1_i3 : i3
      cf.cond_br %61, ^bb4, ^bb27
    ^bb4:  // pred: ^bb3
      %62 = llhd.prb %digest_mode_flag_q : i4
      %63 = comb.icmp eq %62, %c1_i4 : i4
      cf.cond_br %63, ^bb5, ^bb12
    ^bb5:  // pred: ^bb4
      %64 = llhd.prb %message_length_i_12 : i128
      %65 = comb.extract %64 from 3 : (i128) -> i2
      %66 = comb.icmp ceq %65, %c0_i2 : i2
      cf.cond_br %66, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %shaf_rdata_o, %c2147483648_i64 after %1 : i64
      cf.br ^bb34
    ^bb7:  // pred: ^bb5
      %67 = comb.icmp ceq %65, %c1_i2 : i2
      cf.cond_br %67, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %68 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i64, mask: i8>
      %data_13 = hw.struct_extract %68["data"] : !hw.struct<data: i64, mask: i8>
      %69 = comb.extract %data_13 from 24 : (i64) -> i8
      %70 = comb.concat %c0_i32, %69, %c-8388608_i24 : i32, i8, i24
      llhd.drv %shaf_rdata_o, %70 after %1 : i64
      cf.br ^bb34
    ^bb9:  // pred: ^bb7
      %71 = comb.icmp ceq %65, %c-2_i2 : i2
      cf.cond_br %71, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %72 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i64, mask: i8>
      %data_14 = hw.struct_extract %72["data"] : !hw.struct<data: i64, mask: i8>
      %73 = comb.extract %data_14 from 16 : (i64) -> i16
      %74 = comb.concat %c0_i32, %73, %c-32768_i16 : i32, i16, i16
      llhd.drv %shaf_rdata_o, %74 after %1 : i64
      cf.br ^bb34
    ^bb11:  // pred: ^bb9
      %75 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i64, mask: i8>
      %data_15 = hw.struct_extract %75["data"] : !hw.struct<data: i64, mask: i8>
      %76 = comb.extract %data_15 from 8 : (i64) -> i24
      %77 = comb.concat %c0_i32, %76, %c-128_i8 : i32, i24, i8
      llhd.drv %shaf_rdata_o, %77 after %1 : i64
      cf.br ^bb34
    ^bb12:  // pred: ^bb4
      %78 = llhd.prb %message_length_i_12 : i128
      %79 = comb.extract %78 from 3 : (i128) -> i3
      %80 = comb.icmp ceq %79, %c0_i3 : i3
      cf.cond_br %80, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      llhd.drv %shaf_rdata_o, %c-9223372036854775808_i64 after %1 : i64
      cf.br ^bb34
    ^bb14:  // pred: ^bb12
      %81 = comb.icmp ceq %79, %c1_i3 : i3
      cf.cond_br %81, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      %82 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i64, mask: i8>
      %data_16 = hw.struct_extract %82["data"] : !hw.struct<data: i64, mask: i8>
      %83 = comb.extract %data_16 from 56 : (i64) -> i8
      %84 = comb.concat %83, %c-36028797018963968_i56 : i8, i56
      llhd.drv %shaf_rdata_o, %84 after %1 : i64
      cf.br ^bb34
    ^bb16:  // pred: ^bb14
      %85 = comb.icmp ceq %79, %c2_i3 : i3
      cf.cond_br %85, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      %86 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i64, mask: i8>
      %data_17 = hw.struct_extract %86["data"] : !hw.struct<data: i64, mask: i8>
      %87 = comb.extract %data_17 from 48 : (i64) -> i16
      %88 = comb.concat %87, %c-140737488355328_i48 : i16, i48
      llhd.drv %shaf_rdata_o, %88 after %1 : i64
      cf.br ^bb34
    ^bb18:  // pred: ^bb16
      %89 = comb.icmp ceq %79, %c3_i3 : i3
      cf.cond_br %89, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %90 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i64, mask: i8>
      %data_18 = hw.struct_extract %90["data"] : !hw.struct<data: i64, mask: i8>
      %91 = comb.extract %data_18 from 40 : (i64) -> i24
      %92 = comb.concat %91, %c-549755813888_i40 : i24, i40
      llhd.drv %shaf_rdata_o, %92 after %1 : i64
      cf.br ^bb34
    ^bb20:  // pred: ^bb18
      %93 = comb.icmp ceq %79, %c-4_i3 : i3
      cf.cond_br %93, ^bb21, ^bb22
    ^bb21:  // pred: ^bb20
      %94 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i64, mask: i8>
      %data_19 = hw.struct_extract %94["data"] : !hw.struct<data: i64, mask: i8>
      %95 = comb.extract %data_19 from 32 : (i64) -> i32
      %96 = comb.concat %95, %c-2147483648_i32 : i32, i32
      llhd.drv %shaf_rdata_o, %96 after %1 : i64
      cf.br ^bb34
    ^bb22:  // pred: ^bb20
      %97 = comb.icmp ceq %79, %c-3_i3 : i3
      cf.cond_br %97, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      %98 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i64, mask: i8>
      %data_20 = hw.struct_extract %98["data"] : !hw.struct<data: i64, mask: i8>
      %99 = comb.extract %data_20 from 24 : (i64) -> i40
      %100 = comb.concat %99, %c-8388608_i24 : i40, i24
      llhd.drv %shaf_rdata_o, %100 after %1 : i64
      cf.br ^bb34
    ^bb24:  // pred: ^bb22
      %101 = comb.icmp ceq %79, %c-2_i3 : i3
      cf.cond_br %101, ^bb25, ^bb26
    ^bb25:  // pred: ^bb24
      %102 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i64, mask: i8>
      %data_21 = hw.struct_extract %102["data"] : !hw.struct<data: i64, mask: i8>
      %103 = comb.extract %data_21 from 16 : (i64) -> i48
      %104 = comb.concat %103, %c-32768_i16 : i48, i16
      llhd.drv %shaf_rdata_o, %104 after %1 : i64
      cf.br ^bb34
    ^bb26:  // pred: ^bb24
      %105 = llhd.prb %fifo_rdata_i_3 : !hw.struct<data: i64, mask: i8>
      %data_22 = hw.struct_extract %105["data"] : !hw.struct<data: i64, mask: i8>
      %106 = comb.extract %data_22 from 8 : (i64) -> i56
      %107 = comb.concat %106, %c-128_i8 : i56, i8
      llhd.drv %shaf_rdata_o, %107 after %1 : i64
      cf.br ^bb34
    ^bb27:  // pred: ^bb3
      %108 = comb.icmp ceq %58, %c2_i3 : i3
      cf.cond_br %108, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      llhd.drv %shaf_rdata_o, %c0_i64 after %1 : i64
      cf.br ^bb34
    ^bb29:  // pred: ^bb27
      %109 = comb.icmp ceq %58, %c3_i3 : i3
      cf.cond_br %109, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %110 = llhd.prb %digest_mode_flag_q : i4
      %111 = comb.icmp eq %110, %c1_i4 : i4
      %112 = llhd.prb %message_length_i_12 : i128
      %113 = comb.extract %112 from 32 : (i128) -> i32
      %114 = comb.concat %c0_i32, %113 : i32, i32
      %115 = comb.extract %112 from 64 : (i128) -> i64
      %116 = comb.mux %111, %114, %115 : i64
      llhd.drv %shaf_rdata_o, %116 after %1 : i64
      cf.br ^bb34
    ^bb31:  // pred: ^bb29
      %117 = comb.icmp ceq %58, %c-4_i3 : i3
      cf.cond_br %117, ^bb32, ^bb33
    ^bb32:  // pred: ^bb31
      %118 = llhd.prb %digest_mode_flag_q : i4
      %119 = comb.icmp eq %118, %c1_i4 : i4
      %120 = llhd.prb %message_length_i_12 : i128
      %121 = comb.extract %120 from 0 : (i128) -> i32
      %122 = comb.concat %c0_i32, %121 : i32, i32
      %123 = comb.extract %120 from 0 : (i128) -> i64
      %124 = comb.mux %119, %122, %123 : i64
      llhd.drv %shaf_rdata_o, %124 after %1 : i64
      cf.br ^bb34
    ^bb33:  // pred: ^bb31
      llhd.drv %shaf_rdata_o, %c0_i64 after %1 : i64
      cf.br ^bb34
    ^bb34:  // 17 preds: ^bb2, ^bb6, ^bb8, ^bb10, ^bb11, ^bb13, ^bb15, ^bb17, ^bb19, ^bb21, ^bb23, ^bb25, ^bb26, ^bb28, ^bb30, ^bb32, ^bb33
      llhd.wait (%39, %8, %40, %false, %10, %false, %22 : i3, !hw.struct<data: i64, mask: i8>, i64, i1, i4, i1, i128), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %58 = llhd.prb %clk_i_0 : i1
      %59 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %60 = llhd.prb %clk_i_0 : i1
      %61 = comb.xor bin %58, %true : i1
      %62 = comb.and bin %61, %60 : i1
      %63 = llhd.prb %rst_ni_1 : i1
      %64 = comb.xor bin %63, %true : i1
      %65 = comb.and bin %59, %64 : i1
      %66 = comb.or bin %62, %65 : i1
      cf.cond_br %66, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %67 = llhd.prb %rst_ni_1 : i1
      %68 = comb.xor %67, %true : i1
      cf.cond_br %68, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %st_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %69 = llhd.prb %st_d : i3
      llhd.drv %st_q, %69 after %0 : i3
      cf.br ^bb1
    }
    %41 = llhd.prb %shaf_rvalid_o : i1
    %42 = llhd.prb %inc_txcount : i1
    %43 = llhd.prb %fifo_rready_o : i1
    %44 = llhd.prb %st_d : i3
    %45 = llhd.prb %st_q : i3
    %46 = llhd.prb %fifo_partial : i1
    %47 = llhd.prb %fifo_rvalid_i_2 : i1
    %48 = llhd.prb %txcnt_eq_msg_len : i1
    %49 = llhd.prb %shaf_rready_i_4 : i1
    %50 = llhd.prb %txcnt_eq_1a0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb38
      llhd.drv %shaf_rvalid_o, %false after %1 : i1
      llhd.drv %inc_txcount, %false after %1 : i1
      llhd.drv %sel_data, %c0_i3 after %1 : i3
      llhd.drv %fifo_rready_o, %false after %1 : i1
      llhd.drv %st_d, %c0_i3 after %1 : i3
      %58 = llhd.prb %st_q : i3
      %59 = comb.icmp ceq %58, %c0_i3 : i3
      cf.cond_br %59, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      llhd.drv %sel_data, %c0_i3 after %1 : i3
      llhd.drv %shaf_rvalid_o, %false after %1 : i1
      %60 = llhd.prb %sha_en_i_5 : i1
      %61 = llhd.prb %hash_go : i1
      %62 = comb.and %60, %61 : i1
      cf.cond_br %62, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %inc_txcount, %false after %1 : i1
      llhd.drv %st_d, %c1_i3 after %1 : i3
      cf.br ^bb34
    ^bb4:  // pred: ^bb2
      llhd.drv %st_d, %c0_i3 after %1 : i3
      cf.br ^bb34
    ^bb5:  // pred: ^bb1
      %63 = comb.icmp ceq %58, %c1_i3 : i3
      cf.cond_br %63, ^bb6, ^bb15
    ^bb6:  // pred: ^bb5
      llhd.drv %sel_data, %c0_i3 after %1 : i3
      %64 = llhd.prb %fifo_partial : i1
      %65 = llhd.prb %fifo_rvalid_i_2 : i1
      %66 = comb.and %64, %65 : i1
      cf.cond_br %66, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      llhd.drv %shaf_rvalid_o, %false after %1 : i1
      llhd.drv %inc_txcount, %false after %1 : i1
      llhd.drv %fifo_rready_o, %false after %1 : i1
      llhd.drv %st_d, %c2_i3 after %1 : i3
      cf.br ^bb13
    ^bb8:  // pred: ^bb6
      %67 = llhd.prb %hash_process_flag_q : i1
      %68 = comb.xor %67, %true : i1
      cf.cond_br %68, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %69 = llhd.prb %shaf_rready_i_4 : i1
      llhd.drv %fifo_rready_o, %69 after %1 : i1
      %70 = llhd.prb %fifo_rvalid_i_2 : i1
      llhd.drv %shaf_rvalid_o, %70 after %1 : i1
      %71 = llhd.prb %shaf_rready_i_4 : i1
      llhd.drv %inc_txcount, %71 after %1 : i1
      llhd.drv %st_d, %c1_i3 after %1 : i3
      cf.br ^bb13
    ^bb10:  // pred: ^bb8
      %72 = llhd.prb %txcnt_eq_msg_len : i1
      cf.cond_br %72, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      llhd.drv %shaf_rvalid_o, %false after %1 : i1
      llhd.drv %inc_txcount, %false after %1 : i1
      llhd.drv %fifo_rready_o, %false after %1 : i1
      llhd.drv %st_d, %c2_i3 after %1 : i3
      cf.br ^bb13
    ^bb12:  // pred: ^bb10
      %73 = llhd.prb %fifo_rvalid_i_2 : i1
      llhd.drv %shaf_rvalid_o, %73 after %1 : i1
      %74 = llhd.prb %shaf_rready_i_4 : i1
      llhd.drv %fifo_rready_o, %74 after %1 : i1
      %75 = llhd.prb %shaf_rready_i_4 : i1
      llhd.drv %inc_txcount, %75 after %1 : i1
      llhd.drv %st_d, %c1_i3 after %1 : i3
      cf.br ^bb13
    ^bb13:  // 4 preds: ^bb7, ^bb9, ^bb11, ^bb12
      %76 = llhd.prb %txcnt_eq_msg_len : i1
      %77 = llhd.prb %hash_stop_flag_q : i1
      %78 = comb.and %76, %77 : i1
      cf.cond_br %78, ^bb14, ^bb34
    ^bb14:  // pred: ^bb13
      llhd.drv %shaf_rvalid_o, %false after %1 : i1
      llhd.drv %inc_txcount, %false after %1 : i1
      llhd.drv %fifo_rready_o, %false after %1 : i1
      llhd.drv %st_d, %c0_i3 after %1 : i3
      cf.br ^bb34
    ^bb15:  // pred: ^bb5
      %79 = comb.icmp ceq %58, %c2_i3 : i3
      cf.cond_br %79, ^bb16, ^bb21
    ^bb16:  // pred: ^bb15
      llhd.drv %sel_data, %c1_i3 after %1 : i3
      llhd.drv %shaf_rvalid_o, %true after %1 : i1
      %80 = llhd.prb %digest_mode_flag_q : i4
      %81 = comb.icmp eq %80, %c1_i4 : i4
      %82 = llhd.prb %shaf_rready_i_4 : i1
      %83 = llhd.prb %message_length_i_12 : i128
      %84 = comb.extract %83 from 3 : (i128) -> i2
      %85 = comb.icmp ne %84, %c0_i2 : i2
      %86 = comb.and %82, %85 : i1
      %87 = comb.extract %83 from 3 : (i128) -> i3
      %88 = comb.icmp ne %87, %c0_i3 : i3
      %89 = comb.and %82, %88 : i1
      %90 = comb.mux %81, %86, %89 : i1
      llhd.drv %fifo_rready_o, %90 after %1 : i1
      %91 = llhd.prb %shaf_rready_i_4 : i1
      %92 = llhd.prb %txcnt_eq_1a0 : i1
      %93 = comb.and %91, %92 : i1
      cf.cond_br %93, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      llhd.drv %st_d, %c-4_i3 after %1 : i3
      llhd.drv %inc_txcount, %true after %1 : i1
      cf.br ^bb34
    ^bb18:  // pred: ^bb16
      %94 = llhd.prb %shaf_rready_i_4 : i1
      %95 = llhd.prb %txcnt_eq_1a0 : i1
      %96 = comb.xor %95, %true : i1
      %97 = comb.and %94, %96 : i1
      cf.cond_br %97, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      llhd.drv %st_d, %c3_i3 after %1 : i3
      llhd.drv %inc_txcount, %true after %1 : i1
      cf.br ^bb34
    ^bb20:  // pred: ^bb18
      llhd.drv %st_d, %c2_i3 after %1 : i3
      llhd.drv %inc_txcount, %false after %1 : i1
      cf.br ^bb34
    ^bb21:  // pred: ^bb15
      %98 = comb.icmp ceq %58, %c3_i3 : i3
      cf.cond_br %98, ^bb22, ^bb27
    ^bb22:  // pred: ^bb21
      llhd.drv %sel_data, %c2_i3 after %1 : i3
      llhd.drv %shaf_rvalid_o, %true after %1 : i1
      %99 = llhd.prb %shaf_rready_i_4 : i1
      cf.cond_br %99, ^bb23, ^bb26
    ^bb23:  // pred: ^bb22
      llhd.drv %inc_txcount, %true after %1 : i1
      %100 = llhd.prb %txcnt_eq_1a0 : i1
      cf.cond_br %100, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      llhd.drv %st_d, %c-4_i3 after %1 : i3
      cf.br ^bb34
    ^bb25:  // pred: ^bb23
      llhd.drv %st_d, %c3_i3 after %1 : i3
      cf.br ^bb34
    ^bb26:  // pred: ^bb22
      llhd.drv %st_d, %c3_i3 after %1 : i3
      cf.br ^bb34
    ^bb27:  // pred: ^bb21
      %101 = comb.icmp ceq %58, %c-4_i3 : i3
      cf.cond_br %101, ^bb28, ^bb30
    ^bb28:  // pred: ^bb27
      llhd.drv %sel_data, %c3_i3 after %1 : i3
      llhd.drv %shaf_rvalid_o, %true after %1 : i1
      llhd.drv %st_d, %c-4_i3 after %1 : i3
      llhd.drv %inc_txcount, %false after %1 : i1
      %102 = llhd.prb %shaf_rready_i_4 : i1
      cf.cond_br %102, ^bb29, ^bb34
    ^bb29:  // pred: ^bb28
      llhd.drv %st_d, %c-3_i3 after %1 : i3
      llhd.drv %inc_txcount, %true after %1 : i1
      cf.br ^bb34
    ^bb30:  // pred: ^bb27
      %103 = comb.icmp ceq %58, %c-3_i3 : i3
      cf.cond_br %103, ^bb31, ^bb33
    ^bb31:  // pred: ^bb30
      llhd.drv %sel_data, %c-4_i3 after %1 : i3
      llhd.drv %shaf_rvalid_o, %true after %1 : i1
      llhd.drv %st_d, %c-3_i3 after %1 : i3
      llhd.drv %inc_txcount, %false after %1 : i1
      %104 = llhd.prb %shaf_rready_i_4 : i1
      cf.cond_br %104, ^bb32, ^bb34
    ^bb32:  // pred: ^bb31
      llhd.drv %st_d, %c0_i3 after %1 : i3
      llhd.drv %inc_txcount, %true after %1 : i1
      cf.br ^bb34
    ^bb33:  // pred: ^bb30
      llhd.drv %st_d, %c0_i3 after %1 : i3
      cf.br ^bb34
    ^bb34:  // 15 preds: ^bb3, ^bb4, ^bb13, ^bb14, ^bb17, ^bb19, ^bb20, ^bb24, ^bb25, ^bb26, ^bb28, ^bb29, ^bb31, ^bb32, ^bb33
      %105 = llhd.prb %sha_en_i_5 : i1
      %106 = comb.xor %105, %true : i1
      cf.cond_br %106, ^bb35, ^bb36
    ^bb35:  // pred: ^bb34
      llhd.drv %st_d, %c0_i3 after %1 : i3
      cf.br ^bb38
    ^bb36:  // pred: ^bb34
      %107 = llhd.prb %hash_go : i1
      %108 = llhd.prb %st_q : i3
      %109 = comb.icmp weq %108, %c0_i3 : i3
      %110 = comb.icmp weq %108, %c1_i3 : i3
      %111 = comb.or %109, %110 : i1
      %112 = comb.and %107, %111 : i1
      cf.cond_br %112, ^bb37, ^bb38
    ^bb37:  // pred: ^bb36
      llhd.drv %st_d, %c1_i3 after %1 : i3
      cf.br ^bb38
    ^bb38:  // 3 preds: ^bb35, ^bb36, ^bb37
      llhd.wait (%41, %42, %39, %43, %44, %45, %24, %26, %46, %47, %48, %30, %35, %49, %10, %false, %22, %50 : i1, i1, i3, i1, i3, i3, i1, i1, i1, i1, i1, i1, i1, i1, i4, i1, i128, i1), ^bb1
    }
    %51 = llhd.prb %tx_count_d : i128
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb9
      %58 = llhd.prb %tx_count : i128
      llhd.drv %tx_count_d, %58 after %1 : i128
      %59 = llhd.prb %hash_start_i_6 : i1
      cf.cond_br %59, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %tx_count_d, %c0_i128 after %1 : i128
      cf.br ^bb9
    ^bb3:  // pred: ^bb1
      %60 = llhd.prb %hash_continue_i_8 : i1
      cf.cond_br %60, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %61 = llhd.prb %message_length_i_12 : i128
      llhd.drv %tx_count_d, %61 after %1 : i128
      cf.br ^bb9
    ^bb5:  // pred: ^bb3
      %62 = llhd.prb %inc_txcount : i1
      cf.cond_br %62, ^bb6, ^bb9
    ^bb6:  // pred: ^bb5
      %63 = llhd.prb %digest_mode_flag_q : i4
      %64 = comb.icmp eq %63, %c1_i4 : i4
      cf.cond_br %64, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %65 = llhd.sig.extract %tx_count_d from %c5_i7 : <i128> -> <i123>
      %66 = llhd.prb %tx_count : i128
      %67 = comb.extract %66 from 5 : (i128) -> i123
      %68 = comb.add %67, %c1_i123 : i123
      llhd.drv %65, %68 after %1 : i123
      cf.br ^bb9
    ^bb8:  // pred: ^bb6
      %69 = llhd.sig.extract %tx_count_d from %c6_i7 : <i128> -> <i122>
      %70 = llhd.prb %tx_count : i128
      %71 = comb.extract %70 from 6 : (i128) -> i122
      %72 = comb.add %71, %c1_i122 : i122
      llhd.drv %69, %72 after %1 : i122
      cf.br ^bb9
    ^bb9:  // 5 preds: ^bb2, ^bb4, ^bb5, ^bb7, ^bb8
      llhd.wait (%12, %51, %5, %6, %22, %42, %10, %false : i128, i128, i1, i1, i128, i1, i4, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %58 = llhd.prb %clk_i_0 : i1
      %59 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %60 = llhd.prb %clk_i_0 : i1
      %61 = comb.xor bin %58, %true : i1
      %62 = comb.and bin %61, %60 : i1
      %63 = llhd.prb %rst_ni_1 : i1
      %64 = comb.xor bin %63, %true : i1
      %65 = comb.and bin %59, %64 : i1
      %66 = comb.or bin %62, %65 : i1
      cf.cond_br %66, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %67 = llhd.prb %rst_ni_1 : i1
      %68 = comb.xor %67, %true : i1
      cf.cond_br %68, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %tx_count, %c0_i128 after %0 : i128
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %69 = llhd.prb %tx_count_d : i128
      llhd.drv %tx_count, %69 after %0 : i128
      cf.br ^bb1
    }
    %52 = llhd.prb %digest_mode_i_9 : i4
    %53 = comb.mux %27, %c-8_i4, %10 : i4
    %54 = comb.mux %7, %52, %53 : i4
    llhd.drv %digest_mode_flag_d, %54 after %1 : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %58 = llhd.prb %clk_i_0 : i1
      %59 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %60 = llhd.prb %clk_i_0 : i1
      %61 = comb.xor bin %58, %true : i1
      %62 = comb.and bin %61, %60 : i1
      %63 = llhd.prb %rst_ni_1 : i1
      %64 = comb.xor bin %63, %true : i1
      %65 = comb.and bin %59, %64 : i1
      %66 = comb.or bin %62, %65 : i1
      cf.cond_br %66, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %67 = llhd.prb %rst_ni_1 : i1
      %68 = comb.xor %67, %true : i1
      cf.cond_br %68, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %digest_mode_flag_q, %c-8_i4 after %0 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %69 = llhd.prb %digest_mode_flag_d : i4
      llhd.drv %digest_mode_flag_q, %69 after %0 : i4
      cf.br ^bb1
    }
    %55 = comb.or %35, %30 : i1
    %56 = comb.icmp eq %45, %c0_i3 : i3
    %57 = comb.and %55, %56 : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %fifo_rvalid_i_2, %fifo_rvalid_i after %1 : i1
    llhd.drv %fifo_rdata_i_3, %fifo_rdata_i after %1 : !hw.struct<data: i64, mask: i8>
    llhd.drv %shaf_rready_i_4, %shaf_rready_i after %1 : i1
    llhd.drv %sha_en_i_5, %sha_en_i after %1 : i1
    llhd.drv %hash_start_i_6, %hash_start_i after %1 : i1
    llhd.drv %hash_stop_i_7, %hash_stop_i after %1 : i1
    llhd.drv %hash_continue_i_8, %hash_continue_i after %1 : i1
    llhd.drv %digest_mode_i_9, %digest_mode_i after %1 : i4
    llhd.drv %hash_process_i_10, %hash_process_i after %1 : i1
    llhd.drv %hash_done_i_11, %hash_done_i after %1 : i1
    llhd.drv %message_length_i_12, %message_length_i after %1 : i128
    hw.output %43, %41, %40, %57 : i1, i1, i64, i1
  }
  hw.module private @hmac_core(in %clk_i : i1, in %rst_ni : i1, in %secret_key_i : i1024, in %hmac_en_i : i1, in %digest_size_i : i4, in %key_length_i : i6, in %reg_hash_start_i : i1, in %reg_hash_stop_i : i1, in %reg_hash_continue_i : i1, in %reg_hash_process_i : i1, out hash_done_o : i1, out sha_hash_start_o : i1, out sha_hash_continue_o : i1, out sha_hash_process_o : i1, in %sha_hash_done_i : i1, out sha_rvalid_o : i1, out sha_rdata_o : !hw.struct<data: i32, mask: i4>, in %sha_rready_i : i1, in %fifo_rvalid_i : i1, in %fifo_rdata_i : !hw.struct<data: i32, mask: i4>, out fifo_rready_o : i1, out fifo_wsel_o : i1, out fifo_wvalid_o : i1, out fifo_wdata_sel_o : i4, in %fifo_wready_i : i1, in %message_length_i : i64, out sha_message_length_o : i64, out idle_o : i1) {
    %c1536_i64 = hw.constant 1536 : i64
    %c1408_i64 = hw.constant 1408 : i64
    %c768_i64 = hw.constant 768 : i64
    %c0_i22 = hw.constant 0 : i22
    %c1023_i32 = hw.constant 1023 : i32
    %c0_i23 = hw.constant 0 : i23
    %c511_i32 = hw.constant 511 : i32
    %c64857948395032573925920030412780500193276032181447923408453205751025122251396425914545803582986248289972746968424188976096504544042848350075850837720908311540214298804265194687920800797312316309763465221928707963659254363825516019982745122234337669878542145031301723286569202456235819215862167773825210276956_i1024 = hw.constant 64857948395032573925920030412780500193276032181447923408453205751025122251396425914545803582986248289972746968424188976096504544042848350075850837720908311540214298804265194687920800797312316309763465221928707963659254363825516019982745122234337669878542145031301723286569202456235819215862167773825210276956 : i1024
    %c38068795797084336869561756981414641417792453671719433304961664245166919582341380428102971668274537039766612351031589181621861362807758814174955926488359226338821436254677396882040470033205055225295946978088589456930431909201933316076828658702763414928709519909677098450812357963442763452788663693332188640822_i1024 = hw.constant 38068795797084336869561756981414641417792453671719433304961664245166919582341380428102971668274537039766612351031589181621861362807758814174955926488359226338821436254677396882040470033205055225295946978088589456930431909201933316076828658702763414928709519909677098450812357963442763452788663693332188640822 : i1024
    %c4837326782567525228081609018960540563639614335272549767649284913029028591242220870061852687966098491558756591973163594817824930269408174255183904739449948_i512 = hw.constant 4837326782567525228081609018960540563639614335272549767649284913029028591242220870061852687966098491558756591973163594817824930269408174255183904739449948 : i512
    %c2839300502811373503439205293737708591701512762007800950576754188082255912250868771558043969023579549393183217027726457827853763419000450106303596260111926_i512 = hw.constant 2839300502811373503439205293737708591701512762007800950576754188082255912250868771558043969023579549393183217027726457827853763419000450106303596260111926 : i512
    %c1646057007142125333784265834213438438785007932026931425934453771163660060326267919837427367220384975606412127375571315578758277781829569787604881731037034138506602000161350491794605590928186460_i640 = hw.constant 1646057007142125333784265834213438438785007932026931425934453771163660060326267919837427367220384975606412127375571315578758277781829569787604881731037034138506602000161350491794605590928186460 : i640
    %c966163895496464869829895163560061692330330742711459750005005474378670035408896387730663889455443355247241900850878815665792902176291269223159387102999998298688657695746879636488138064240457270_i640 = hw.constant 966163895496464869829895163560061692330330742711459750005005474378670035408896387730663889455443355247241900850878815665792902176291269223159387102999998298688657695746879636488138064240457270 : i640
    %c560124174477118517779239658582549941504445151273474855783501127444692892733908523695846327891119513613509298918180622490069746525719854603972056585505053587477685716838894867884801593247478654603624297748321235784635850629612067932_i768 = hw.constant 560124174477118517779239658582549941504445151273474855783501127444692892733908523695846327891119513613509298918180622490069746525719854603972056585505053587477685716838894867884801593247478654603624297748321235784635850629612067932 : i768
    %c41775969450325843054778551454114853029415053291133066241686657759717678144604_i256 = hw.constant 41775969450325843054778551454114853029415053291133066241686657759717678144604 : i256
    %c328768537193091303913901538733235835230869980095300458829446313934928437039468046517127192457831018860103284147627756678953981656400784224070554952361661888302119877275003509410644413427867905962996870417492899264894955804337518134_i768 = hw.constant 328768537193091303913901538733235835230869980095300458829446313934928437039468046517127192457831018860103284147627756678953981656400784224070554952361661888302119877275003509410644413427867905962996870417492899264894955804337518134 : i768
    %c24520677720843429619109149766545674604221879105665060620120429554616898041398_i256 = hw.constant 24520677720843429619109149766545674604221879105665060620120429554616898041398 : i256
    %c190600379860710598683981412597331481567584133314992862885381902864525486412622302241750539379076318769843311134822179758655592060683321840890390533406237023825770882070229285268718822063651892458345997755119330718359288638953504627345617704653205317007990389970948611164_i896 = hw.constant 190600379860710598683981412597331481567584133314992862885381902864525486412622302241750539379076318769843311134822179758655592060683321840890390533406237023825770882070229285268718822063651892458345997755119330718359288638953504627345617704653205317007990389970948611164 : i896
    %c14215625764973694460900673291032205764969945148560082719416639188982770207755856377451421550782008780212587353365596_i384 = hw.constant 14215625764973694460900673291032205764969945148560082719416639188982770207755856377451421550782008780212587353365596 : i384
    %c122768540222456229955413583857735982172_i128 = hw.constant 122768540222456229955413583857735982172 : i128
    %c111874136005199699227554307394085869615755904337061028215332856029178002894365264359288360070327404495342813057395627249645673600835862819653055313086269557462952474258612841353378439037360893399463955204091781073819582461994448368224601696209490077374255228895991576118_i896 = hw.constant 111874136005199699227554307394085869615755904337061028215332856029178002894365264359288360070327404495342813057395627249645673600835862819653055313086269557462952474258612841353378439037360893399463955204091781073819582461994448368224601696209490077374255228895991576118 : i896
    %c8343954253354125009659090844736294688134533021980918117918462132663799904552350482417138736328570370994344750888502_i384 = hw.constant 8343954253354125009659090844736294688134533021980918117918462132663799904552350482417138736328570370994344750888502 : i384
    %c72059795347963439321655799220845033014_i128 = hw.constant 72059795347963439321655799220845033014 : i128
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c5_i6 = hw.constant 5 : i6
    %c0_i992 = hw.constant 0 : i992
    %c0_i480 = hw.constant 0 : i480
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i5 = hw.constant 0 : i5
    %c0_i512 = hw.constant 0 : i512
    %2 = hw.aggregate_constant [0 : i32, 0 : i4] : !hw.struct<data: i32, mask: i4>
    %c0_i6 = hw.constant 0 : i6
    %c0_i1024 = hw.constant 0 : i1024
    %c-3_i3 = hw.constant -3 : i3
    %c-5_i4 = hw.constant -5 : i4
    %c7_i4 = hw.constant 7 : i4
    %c3_i3 = hw.constant 3 : i3
    %c-2_i3 = hw.constant -2 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c1_i3 = hw.constant 1 : i3
    %c-2_i2 = hw.constant -2 : i2
    %c0_i3 = hw.constant 0 : i3
    %c0_i4 = hw.constant 0 : i4
    %true = hw.constant true
    %c1_i59 = hw.constant 1 : i59
    %c0_i10 = hw.constant 0 : i10
    %c0_i9 = hw.constant 0 : i9
    %c1024_i64 = hw.constant 1024 : i64
    %c512_i64 = hw.constant 512 : i64
    %c0_i64 = hw.constant 0 : i64
    %c1_i2 = hw.constant 1 : i2
    %c4_i4 = hw.constant 4 : i4
    %c2_i4 = hw.constant 2 : i4
    %c-1_i4 = hw.constant -1 : i4
    %c-31_i32 = hw.constant -31 : i32
    %c1_i4 = hw.constant 1 : i4
    %c0_i2 = hw.constant 0 : i2
    %c2_i3 = hw.constant 2 : i3
    %c16_i6 = hw.constant 16 : i6
    %c8_i6 = hw.constant 8 : i6
    %c4_i6 = hw.constant 4 : i6
    %c2_i6 = hw.constant 2 : i6
    %false = hw.constant false
    %c1_i6 = hw.constant 1 : i6
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %secret_key_i_2 = llhd.sig name "secret_key_i" %c0_i1024 : i1024
    %hmac_en_i_3 = llhd.sig name "hmac_en_i" %false : i1
    %digest_size_i_4 = llhd.sig name "digest_size_i" %c0_i4 : i4
    %key_length_i_5 = llhd.sig name "key_length_i" %c0_i6 : i6
    %reg_hash_start_i_6 = llhd.sig name "reg_hash_start_i" %false : i1
    %reg_hash_continue_i_7 = llhd.sig name "reg_hash_continue_i" %false : i1
    %reg_hash_process_i_8 = llhd.sig name "reg_hash_process_i" %false : i1
    %sha_hash_done_i_9 = llhd.sig name "sha_hash_done_i" %false : i1
    %sha_rready_i_10 = llhd.sig name "sha_rready_i" %false : i1
    %fifo_rvalid_i_11 = llhd.sig name "fifo_rvalid_i" %false : i1
    %fifo_rdata_i_12 = llhd.sig name "fifo_rdata_i" %2 : !hw.struct<data: i32, mask: i4>
    %fifo_wsel_o = llhd.sig %false : i1
    %fifo_wvalid_o = llhd.sig %false : i1
    %fifo_wdata_sel_o = llhd.sig %c0_i4 : i4
    %fifo_wready_i_13 = llhd.sig name "fifo_wready_i" %false : i1
    %message_length_i_14 = llhd.sig name "message_length_i" %c0_i64 : i64
    %sha_message_length_o = llhd.sig %c0_i64 : i64
    %hash_start = llhd.sig %false : i1
    %hash_continue = llhd.sig %false : i1
    %hash_process = llhd.sig %false : i1
    %hmac_hash_done = llhd.sig %false : i1
    %i_pad_256 = llhd.sig %c0_i512 : i512
    %i_pad_512 = llhd.sig %c0_i1024 : i1024
    %o_pad_256 = llhd.sig %c0_i512 : i512
    %o_pad_512 = llhd.sig %c0_i1024 : i1024
    %txcount = llhd.sig %c0_i64 : i64
    %txcount_d = llhd.sig %c0_i64 : i64
    %pad_index_512 = llhd.sig %c0_i5 : i5
    %pad_index_256 = llhd.sig %c0_i4 : i4
    %clr_txcount = llhd.sig %false : i1
    %load_txcount = llhd.sig %false : i1
    %inc_txcount = llhd.sig %false : i1
    %hmac_sha_rvalid = llhd.sig %false : i1
    %idle_d = llhd.sig %false : i1
    %idle_q = llhd.sig %false : i1
    %reg_hash_stop_d = llhd.sig %false : i1
    %reg_hash_stop_q = llhd.sig %false : i1
    %sel_rdata = llhd.sig %c0_i2 : i2
    %sel_msglen = llhd.sig %false : i1
    %update_round = llhd.sig %false : i1
    %round_q = llhd.sig %false : i1
    %round_d = llhd.sig %false : i1
    %st_q = llhd.sig %c0_i3 : i3
    %st_d = llhd.sig %c0_i3 : i3
    %clr_fifo_wdata_sel = llhd.sig %false : i1
    %txcnt_eq_blksz = llhd.sig %false : i1
    %reg_hash_process_flag = llhd.sig %false : i1
    %sha_msg_len = llhd.sig %c0_i64 : i64
    %5 = llhd.prb %hmac_en_i_3 : i1
    %6 = llhd.prb %hash_start : i1
    %7 = llhd.prb %reg_hash_start_i_6 : i1
    %8 = comb.mux %5, %6, %7 : i1
    %9 = llhd.prb %hash_continue : i1
    %10 = llhd.prb %reg_hash_continue_i_7 : i1
    %11 = comb.mux %5, %9, %10 : i1
    %12 = llhd.prb %reg_hash_process_i_8 : i1
    %13 = llhd.prb %hash_process : i1
    %14 = comb.and %5, %13 : i1
    %15 = comb.or %14, %12 : i1
    %16 = llhd.prb %hmac_hash_done : i1
    %17 = llhd.prb %sha_hash_done_i_9 : i1
    %18 = comb.mux %5, %16, %17 : i1
    %19 = llhd.prb %txcount : i64
    %20 = comb.extract %19 from 5 : (i64) -> i5
    llhd.drv %pad_index_512, %20 after %1 : i5
    %21 = comb.extract %19 from 5 : (i64) -> i4
    llhd.drv %pad_index_256, %21 after %1 : i4
    %22 = llhd.prb %i_pad_256 : i512
    %23 = llhd.prb %i_pad_512 : i1024
    %24 = llhd.prb %o_pad_256 : i512
    %25 = llhd.prb %o_pad_512 : i1024
    %26 = llhd.prb %key_length_i_5 : i6
    %27 = llhd.prb %secret_key_i_2 : i1024
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb11
      llhd.drv %i_pad_256, %c0_i512 after %1 : i512
      llhd.drv %i_pad_512, %c0_i1024 after %1 : i1024
      llhd.drv %o_pad_256, %c0_i512 after %1 : i512
      llhd.drv %o_pad_512, %c0_i1024 after %1 : i1024
      %112 = llhd.prb %key_length_i_5 : i6
      %113 = comb.icmp ceq %112, %c1_i6 : i6
      cf.cond_br %113, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %secret_key_i_2 : i1024
      %115 = comb.extract %114 from 896 : (i1024) -> i128
      %116 = comb.xor %115, %c72059795347963439321655799220845033014_i128 : i128
      %117 = comb.concat %116, %c8343954253354125009659090844736294688134533021980918117918462132663799904552350482417138736328570370994344750888502_i384 : i128, i384
      llhd.drv %i_pad_256, %117 after %1 : i512
      %118 = llhd.prb %secret_key_i_2 : i1024
      %119 = comb.extract %118 from 896 : (i1024) -> i128
      %120 = comb.xor %119, %c72059795347963439321655799220845033014_i128 : i128
      %121 = comb.concat %120, %c111874136005199699227554307394085869615755904337061028215332856029178002894365264359288360070327404495342813057395627249645673600835862819653055313086269557462952474258612841353378439037360893399463955204091781073819582461994448368224601696209490077374255228895991576118_i896 : i128, i896
      llhd.drv %i_pad_512, %121 after %1 : i1024
      %122 = llhd.prb %secret_key_i_2 : i1024
      %123 = comb.extract %122 from 896 : (i1024) -> i128
      %124 = comb.xor %123, %c122768540222456229955413583857735982172_i128 : i128
      %125 = comb.concat %124, %c14215625764973694460900673291032205764969945148560082719416639188982770207755856377451421550782008780212587353365596_i384 : i128, i384
      llhd.drv %o_pad_256, %125 after %1 : i512
      %126 = llhd.prb %secret_key_i_2 : i1024
      %127 = comb.extract %126 from 896 : (i1024) -> i128
      %128 = comb.xor %127, %c122768540222456229955413583857735982172_i128 : i128
      %129 = comb.concat %128, %c190600379860710598683981412597331481567584133314992862885381902864525486412622302241750539379076318769843311134822179758655592060683321840890390533406237023825770882070229285268718822063651892458345997755119330718359288638953504627345617704653205317007990389970948611164_i896 : i128, i896
      llhd.drv %o_pad_512, %129 after %1 : i1024
      cf.br ^bb11
    ^bb3:  // pred: ^bb1
      %130 = comb.icmp ceq %112, %c2_i6 : i6
      cf.cond_br %130, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %131 = llhd.prb %secret_key_i_2 : i1024
      %132 = comb.extract %131 from 768 : (i1024) -> i256
      %133 = comb.xor %132, %c24520677720843429619109149766545674604221879105665060620120429554616898041398_i256 : i256
      %134 = comb.concat %133, %c24520677720843429619109149766545674604221879105665060620120429554616898041398_i256 : i256, i256
      llhd.drv %i_pad_256, %134 after %1 : i512
      %135 = llhd.prb %secret_key_i_2 : i1024
      %136 = comb.extract %135 from 768 : (i1024) -> i256
      %137 = comb.xor %136, %c24520677720843429619109149766545674604221879105665060620120429554616898041398_i256 : i256
      %138 = comb.concat %137, %c328768537193091303913901538733235835230869980095300458829446313934928437039468046517127192457831018860103284147627756678953981656400784224070554952361661888302119877275003509410644413427867905962996870417492899264894955804337518134_i768 : i256, i768
      llhd.drv %i_pad_512, %138 after %1 : i1024
      %139 = llhd.prb %secret_key_i_2 : i1024
      %140 = comb.extract %139 from 768 : (i1024) -> i256
      %141 = comb.xor %140, %c41775969450325843054778551454114853029415053291133066241686657759717678144604_i256 : i256
      %142 = comb.concat %141, %c41775969450325843054778551454114853029415053291133066241686657759717678144604_i256 : i256, i256
      llhd.drv %o_pad_256, %142 after %1 : i512
      %143 = llhd.prb %secret_key_i_2 : i1024
      %144 = comb.extract %143 from 768 : (i1024) -> i256
      %145 = comb.xor %144, %c41775969450325843054778551454114853029415053291133066241686657759717678144604_i256 : i256
      %146 = comb.concat %145, %c560124174477118517779239658582549941504445151273474855783501127444692892733908523695846327891119513613509298918180622490069746525719854603972056585505053587477685716838894867884801593247478654603624297748321235784635850629612067932_i768 : i256, i768
      llhd.drv %o_pad_512, %146 after %1 : i1024
      cf.br ^bb11
    ^bb5:  // pred: ^bb3
      %147 = comb.icmp ceq %112, %c4_i6 : i6
      cf.cond_br %147, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %148 = llhd.prb %secret_key_i_2 : i1024
      %149 = comb.extract %148 from 640 : (i1024) -> i384
      %150 = comb.xor %149, %c8343954253354125009659090844736294688134533021980918117918462132663799904552350482417138736328570370994344750888502_i384 : i384
      %151 = comb.concat %150, %c72059795347963439321655799220845033014_i128 : i384, i128
      llhd.drv %i_pad_256, %151 after %1 : i512
      %152 = llhd.prb %secret_key_i_2 : i1024
      %153 = comb.extract %152 from 640 : (i1024) -> i384
      %154 = comb.xor %153, %c8343954253354125009659090844736294688134533021980918117918462132663799904552350482417138736328570370994344750888502_i384 : i384
      %155 = comb.concat %154, %c966163895496464869829895163560061692330330742711459750005005474378670035408896387730663889455443355247241900850878815665792902176291269223159387102999998298688657695746879636488138064240457270_i640 : i384, i640
      llhd.drv %i_pad_512, %155 after %1 : i1024
      %156 = llhd.prb %secret_key_i_2 : i1024
      %157 = comb.extract %156 from 640 : (i1024) -> i384
      %158 = comb.xor %157, %c14215625764973694460900673291032205764969945148560082719416639188982770207755856377451421550782008780212587353365596_i384 : i384
      %159 = comb.concat %158, %c122768540222456229955413583857735982172_i128 : i384, i128
      llhd.drv %o_pad_256, %159 after %1 : i512
      %160 = llhd.prb %secret_key_i_2 : i1024
      %161 = comb.extract %160 from 640 : (i1024) -> i384
      %162 = comb.xor %161, %c14215625764973694460900673291032205764969945148560082719416639188982770207755856377451421550782008780212587353365596_i384 : i384
      %163 = comb.concat %162, %c1646057007142125333784265834213438438785007932026931425934453771163660060326267919837427367220384975606412127375571315578758277781829569787604881731037034138506602000161350491794605590928186460_i640 : i384, i640
      llhd.drv %o_pad_512, %163 after %1 : i1024
      cf.br ^bb11
    ^bb7:  // pred: ^bb5
      %164 = comb.icmp ceq %112, %c8_i6 : i6
      cf.cond_br %164, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %165 = llhd.prb %secret_key_i_2 : i1024
      %166 = comb.extract %165 from 512 : (i1024) -> i512
      %167 = comb.xor %166, %c2839300502811373503439205293737708591701512762007800950576754188082255912250868771558043969023579549393183217027726457827853763419000450106303596260111926_i512 : i512
      llhd.drv %i_pad_256, %167 after %1 : i512
      %168 = llhd.prb %secret_key_i_2 : i1024
      %169 = comb.extract %168 from 512 : (i1024) -> i512
      %170 = comb.xor %169, %c2839300502811373503439205293737708591701512762007800950576754188082255912250868771558043969023579549393183217027726457827853763419000450106303596260111926_i512 : i512
      %171 = comb.concat %170, %c2839300502811373503439205293737708591701512762007800950576754188082255912250868771558043969023579549393183217027726457827853763419000450106303596260111926_i512 : i512, i512
      llhd.drv %i_pad_512, %171 after %1 : i1024
      %172 = llhd.prb %secret_key_i_2 : i1024
      %173 = comb.extract %172 from 512 : (i1024) -> i512
      %174 = comb.xor %173, %c4837326782567525228081609018960540563639614335272549767649284913029028591242220870061852687966098491558756591973163594817824930269408174255183904739449948_i512 : i512
      llhd.drv %o_pad_256, %174 after %1 : i512
      %175 = llhd.prb %secret_key_i_2 : i1024
      %176 = comb.extract %175 from 512 : (i1024) -> i512
      %177 = comb.xor %176, %c4837326782567525228081609018960540563639614335272549767649284913029028591242220870061852687966098491558756591973163594817824930269408174255183904739449948_i512 : i512
      %178 = comb.concat %177, %c4837326782567525228081609018960540563639614335272549767649284913029028591242220870061852687966098491558756591973163594817824930269408174255183904739449948_i512 : i512, i512
      llhd.drv %o_pad_512, %178 after %1 : i1024
      cf.br ^bb11
    ^bb9:  // pred: ^bb7
      %179 = comb.icmp ceq %112, %c16_i6 : i6
      cf.cond_br %179, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      llhd.drv %i_pad_256, %c0_i512 after %1 : i512
      %180 = llhd.prb %secret_key_i_2 : i1024
      %181 = comb.xor %180, %c38068795797084336869561756981414641417792453671719433304961664245166919582341380428102971668274537039766612351031589181621861362807758814174955926488359226338821436254677396882040470033205055225295946978088589456930431909201933316076828658702763414928709519909677098450812357963442763452788663693332188640822_i1024 : i1024
      llhd.drv %i_pad_512, %181 after %1 : i1024
      llhd.drv %o_pad_256, %c0_i512 after %1 : i512
      %182 = llhd.prb %secret_key_i_2 : i1024
      %183 = comb.xor %182, %c64857948395032573925920030412780500193276032181447923408453205751025122251396425914545803582986248289972746968424188976096504544042848350075850837720908311540214298804265194687920800797312316309763465221928707963659254363825516019982745122234337669878542145031301723286569202456235819215862167773825210276956_i1024 : i1024
      llhd.drv %o_pad_512, %183 after %1 : i1024
      cf.br ^bb11
    ^bb11:  // 6 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      llhd.wait (%22, %23, %24, %25, %26, %27 : i512, i1024, i512, i1024, i6, i1024), ^bb1
    }
    %28 = llhd.prb %st_q : i3
    %29 = comb.icmp eq %28, %c2_i3 : i3
    %30 = llhd.prb %sha_rready_i_10 : i1
    %31 = comb.xor %5, %true : i1
    %32 = comb.or %31, %29 : i1
    %33 = comb.and %32, %30 : i1
    %34 = comb.xor %5, %true : i1
    %35 = llhd.prb %fifo_rvalid_i_11 : i1
    %36 = llhd.prb %hmac_sha_rvalid : i1
    %37 = comb.mux %34, %35, %36 : i1
    %38 = llhd.prb %fifo_rdata_i_12 : !hw.struct<data: i32, mask: i4>
    %39 = llhd.prb %sel_rdata : i2
    %40 = comb.icmp eq %39, %c0_i2 : i2
    %41 = llhd.prb %digest_size_i_4 : i4
    %42 = comb.icmp eq %41, %c1_i4 : i4
    %43 = comb.and %40, %42 : i1
    %44 = llhd.prb %pad_index_256 : i4
    %45 = comb.concat %c0_i23, %44, %c0_i5 : i23, i4, i5
    %46 = comb.sub %c511_i32, %45 : i32
    %47 = comb.add %46, %c-31_i32 : i32
    %48 = comb.concat %c0_i480, %47 : i480, i32
    %49 = comb.shru %22, %48 : i512
    %50 = comb.extract %49 from 0 : (i512) -> i32
    %51 = hw.struct_create (%50, %c-1_i4) : !hw.struct<data: i32, mask: i4>
    %52 = comb.icmp eq %41, %c2_i4 : i4
    %53 = comb.icmp eq %41, %c4_i4 : i4
    %54 = comb.or %52, %53 : i1
    %55 = comb.and %40, %54 : i1
    %56 = llhd.prb %pad_index_512 : i5
    %57 = comb.concat %c0_i22, %56, %c0_i5 : i22, i5, i5
    %58 = comb.sub %c1023_i32, %57 : i32
    %59 = comb.add %58, %c-31_i32 : i32
    %60 = comb.concat %c0_i992, %59 : i992, i32
    %61 = comb.shru %23, %60 : i1024
    %62 = comb.extract %61 from 0 : (i1024) -> i32
    %63 = hw.struct_create (%62, %c-1_i4) : !hw.struct<data: i32, mask: i4>
    %64 = comb.icmp eq %39, %c1_i2 : i2
    %65 = comb.and %64, %42 : i1
    %66 = comb.shru %24, %48 : i512
    %67 = comb.extract %66 from 0 : (i512) -> i32
    %68 = hw.struct_create (%67, %c-1_i4) : !hw.struct<data: i32, mask: i4>
    %69 = comb.and %64, %54 : i1
    %70 = comb.shru %25, %60 : i1024
    %71 = comb.extract %70 from 0 : (i1024) -> i32
    %72 = hw.struct_create (%71, %c-1_i4) : !hw.struct<data: i32, mask: i4>
    %73 = comb.mux %69, %72, %38 : !hw.struct<data: i32, mask: i4>
    %74 = comb.mux %65, %68, %73 : !hw.struct<data: i32, mask: i4>
    %75 = comb.mux %55, %63, %74 : !hw.struct<data: i32, mask: i4>
    %76 = comb.mux %43, %51, %75 : !hw.struct<data: i32, mask: i4>
    %77 = comb.mux %34, %38, %76 : !hw.struct<data: i32, mask: i4>
    %78 = llhd.prb %sha_msg_len : i64
    %79 = llhd.prb %message_length_i_14 : i64
    %80 = llhd.prb %sel_msglen : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb14
      llhd.drv %sha_msg_len, %c0_i64 after %1 : i64
      %112 = llhd.prb %hmac_en_i_3 : i1
      %113 = comb.xor %112, %true : i1
      cf.cond_br %113, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %message_length_i_14 : i64
      llhd.drv %sha_msg_len, %114 after %1 : i64
      cf.br ^bb14
    ^bb3:  // pred: ^bb1
      %115 = llhd.prb %sel_msglen : i1
      %116 = comb.xor %115, %true : i1
      cf.cond_br %116, ^bb4, ^bb9
    ^bb4:  // pred: ^bb3
      %117 = llhd.prb %digest_size_i_4 : i4
      %118 = comb.icmp eq %117, %c1_i4 : i4
      cf.cond_br %118, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %119 = llhd.prb %message_length_i_14 : i64
      %120 = comb.add %119, %c512_i64 : i64
      llhd.drv %sha_msg_len, %120 after %1 : i64
      cf.br ^bb14
    ^bb6:  // pred: ^bb4
      %121 = llhd.prb %digest_size_i_4 : i4
      %122 = comb.icmp eq %121, %c2_i4 : i4
      %123 = comb.icmp eq %121, %c4_i4 : i4
      %124 = comb.or %122, %123 : i1
      cf.cond_br %124, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %125 = llhd.prb %message_length_i_14 : i64
      %126 = comb.add %125, %c1024_i64 : i64
      llhd.drv %sha_msg_len, %126 after %1 : i64
      cf.br ^bb14
    ^bb8:  // pred: ^bb6
      llhd.drv %sha_msg_len, %c0_i64 after %1 : i64
      cf.br ^bb14
    ^bb9:  // pred: ^bb3
      %127 = llhd.prb %digest_size_i_4 : i4
      %128 = comb.icmp eq %127, %c1_i4 : i4
      cf.cond_br %128, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      llhd.drv %sha_msg_len, %c768_i64 after %1 : i64
      cf.br ^bb14
    ^bb11:  // pred: ^bb9
      %129 = llhd.prb %digest_size_i_4 : i4
      %130 = comb.icmp eq %129, %c2_i4 : i4
      cf.cond_br %130, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      llhd.drv %sha_msg_len, %c1408_i64 after %1 : i64
      cf.br ^bb14
    ^bb13:  // pred: ^bb11
      llhd.drv %sha_msg_len, %c1536_i64 after %1 : i64
      cf.br ^bb14
    ^bb14:  // 7 preds: ^bb2, ^bb5, ^bb7, ^bb8, ^bb10, ^bb12, ^bb13
      llhd.wait (%78, %5, %79, %80, %41 : i64, i1, i64, i1, i4), ^bb1
    }
    llhd.drv %sha_message_length_o, %78 after %1 : i64
    %81 = llhd.prb %txcnt_eq_blksz : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb7
      llhd.drv %txcnt_eq_blksz, %false after %1 : i1
      %112 = llhd.prb %digest_size_i_4 : i4
      %113 = comb.icmp ceq %112, %c1_i4 : i4
      cf.cond_br %113, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %txcount : i64
      %115 = comb.extract %114 from 0 : (i64) -> i9
      %116 = comb.icmp eq %115, %c0_i9 : i9
      %117 = comb.icmp ne %114, %c0_i64 : i64
      %118 = comb.and %116, %117 : i1
      llhd.drv %txcnt_eq_blksz, %118 after %1 : i1
      cf.br ^bb7
    ^bb3:  // pred: ^bb1
      %119 = comb.icmp ceq %112, %c2_i4 : i4
      cf.cond_br %119, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %120 = llhd.prb %txcount : i64
      %121 = comb.extract %120 from 0 : (i64) -> i10
      %122 = comb.icmp eq %121, %c0_i10 : i10
      %123 = comb.icmp ne %120, %c0_i64 : i64
      %124 = comb.and %122, %123 : i1
      llhd.drv %txcnt_eq_blksz, %124 after %1 : i1
      cf.br ^bb7
    ^bb5:  // pred: ^bb3
      %125 = comb.icmp ceq %112, %c4_i4 : i4
      cf.cond_br %125, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %126 = llhd.prb %txcount : i64
      %127 = comb.extract %126 from 0 : (i64) -> i10
      %128 = comb.icmp eq %127, %c0_i10 : i10
      %129 = comb.icmp ne %126, %c0_i64 : i64
      %130 = comb.and %128, %129 : i1
      llhd.drv %txcnt_eq_blksz, %130 after %1 : i1
      cf.br ^bb7
    ^bb7:  // 4 preds: ^bb2, ^bb4, ^bb5, ^bb6
      llhd.wait (%81, %41, %19 : i1, i4, i64), ^bb1
    }
    %82 = comb.and %30, %37 : i1
    llhd.drv %inc_txcount, %82 after %1 : i1
    %83 = llhd.prb %txcount_d : i64
    %84 = llhd.prb %clr_txcount : i1
    %85 = llhd.prb %load_txcount : i1
    %86 = llhd.prb %inc_txcount : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb13
      %112 = llhd.prb %txcount : i64
      llhd.drv %txcount_d, %112 after %1 : i64
      %113 = llhd.prb %clr_txcount : i1
      cf.cond_br %113, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %txcount_d, %c0_i64 after %1 : i64
      cf.br ^bb13
    ^bb3:  // pred: ^bb1
      %114 = llhd.prb %load_txcount : i1
      cf.cond_br %114, ^bb4, ^bb11
    ^bb4:  // pred: ^bb3
      %115 = llhd.prb %digest_size_i_4 : i4
      %116 = comb.icmp ceq %115, %c1_i4 : i4
      cf.cond_br %116, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %117 = llhd.prb %message_length_i_14 : i64
      %118 = comb.add %117, %c512_i64 : i64
      llhd.drv %txcount_d, %118 after %1 : i64
      cf.br ^bb13
    ^bb6:  // pred: ^bb4
      %119 = comb.icmp ceq %115, %c2_i4 : i4
      cf.cond_br %119, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %120 = llhd.prb %message_length_i_14 : i64
      %121 = comb.add %120, %c1024_i64 : i64
      llhd.drv %txcount_d, %121 after %1 : i64
      cf.br ^bb13
    ^bb8:  // pred: ^bb6
      %122 = comb.icmp ceq %115, %c4_i4 : i4
      cf.cond_br %122, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %123 = llhd.prb %message_length_i_14 : i64
      %124 = comb.add %123, %c1024_i64 : i64
      llhd.drv %txcount_d, %124 after %1 : i64
      cf.br ^bb13
    ^bb10:  // pred: ^bb8
      %125 = llhd.prb %message_length_i_14 : i64
      llhd.drv %txcount_d, %125 after %1 : i64
      cf.br ^bb13
    ^bb11:  // pred: ^bb3
      %126 = llhd.prb %inc_txcount : i1
      cf.cond_br %126, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %127 = llhd.sig.extract %txcount_d from %c5_i6 : <i64> -> <i59>
      %128 = llhd.prb %txcount : i64
      %129 = comb.extract %128 from 5 : (i64) -> i59
      %130 = comb.add %129, %c1_i59 : i59
      llhd.drv %127, %130 after %1 : i59
      cf.br ^bb13
    ^bb13:  // 7 preds: ^bb2, ^bb5, ^bb7, ^bb9, ^bb10, ^bb11, ^bb12
      llhd.wait (%19, %83, %84, %85, %41, %79, %86 : i64, i64, i1, i1, i4, i64, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %clk_i_0 : i1
      %113 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %clk_i_0 : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %rst_ni_1 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %rst_ni_1 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %txcount, %c0_i64 after %0 : i64
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %txcount_d : i64
      llhd.drv %txcount, %123 after %0 : i64
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %112 = llhd.prb %clk_i_0 : i1
      %113 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %clk_i_0 : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %rst_ni_1 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %rst_ni_1 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %reg_hash_process_flag, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %reg_hash_process_i_8 : i1
      cf.cond_br %123, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %reg_hash_process_flag, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %124 = llhd.prb %hmac_hash_done : i1
      %125 = llhd.prb %reg_hash_start_i_6 : i1
      %126 = llhd.prb %reg_hash_continue_i_7 : i1
      %127 = comb.or %124, %125, %126 : i1
      cf.cond_br %127, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %reg_hash_process_flag, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %112 = llhd.prb %clk_i_0 : i1
      %113 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %clk_i_0 : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %rst_ni_1 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %rst_ni_1 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %round_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %update_round : i1
      cf.cond_br %123, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %124 = llhd.prb %round_d : i1
      llhd.drv %round_q, %124 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %112 = llhd.prb %clk_i_0 : i1
      %113 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %clk_i_0 : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %rst_ni_1 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %rst_ni_1 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %fifo_wdata_sel_o, %c0_i4 after %0 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %clr_fifo_wdata_sel : i1
      cf.cond_br %123, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %fifo_wdata_sel_o, %c0_i4 after %0 : i4
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %124 = llhd.prb %fifo_wsel_o : i1
      %125 = llhd.prb %fifo_wvalid_o : i1
      %126 = comb.and %124, %125 : i1
      cf.cond_br %126, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %127 = llhd.prb %fifo_wdata_sel_o : i4
      %128 = comb.add %127, %c1_i4 : i4
      llhd.drv %fifo_wdata_sel_o, %128 after %0 : i4
      cf.br ^bb1
    }
    %87 = llhd.prb %round_q : i1
    llhd.drv %sel_msglen, %87 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %clk_i_0 : i1
      %113 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %clk_i_0 : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %rst_ni_1 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %rst_ni_1 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %st_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %st_d : i3
      llhd.drv %st_q, %123 after %0 : i3
      cf.br ^bb1
    }
    %88 = llhd.prb %update_round : i1
    %89 = llhd.prb %round_d : i1
    %90 = llhd.prb %fifo_wsel_o : i1
    %91 = llhd.prb %fifo_wvalid_o : i1
    %92 = llhd.prb %clr_fifo_wdata_sel : i1
    %93 = llhd.prb %st_d : i3
    %94 = llhd.prb %reg_hash_process_flag : i1
    %95 = llhd.prb %sha_message_length_o : i64
    %96 = llhd.prb %reg_hash_stop_q : i1
    %97 = llhd.prb %fifo_wready_i_13 : i1
    %98 = llhd.prb %fifo_wdata_sel_o : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb36
      llhd.drv %hmac_hash_done, %false after %1 : i1
      llhd.drv %hmac_sha_rvalid, %false after %1 : i1
      llhd.drv %clr_txcount, %false after %1 : i1
      llhd.drv %load_txcount, %false after %1 : i1
      llhd.drv %update_round, %false after %1 : i1
      llhd.drv %round_d, %false after %1 : i1
      llhd.drv %fifo_wsel_o, %false after %1 : i1
      llhd.drv %fifo_wvalid_o, %false after %1 : i1
      llhd.drv %clr_fifo_wdata_sel, %true after %1 : i1
      llhd.drv %sel_rdata, %c-2_i2 after %1 : i2
      llhd.drv %hash_start, %false after %1 : i1
      llhd.drv %hash_continue, %false after %1 : i1
      llhd.drv %hash_process, %false after %1 : i1
      %112 = llhd.prb %st_q : i3
      llhd.drv %st_d, %112 after %1 : i3
      %113 = llhd.prb %st_q : i3
      %114 = comb.icmp ceq %113, %c0_i3 : i3
      cf.cond_br %114, ^bb2, ^bb7
    ^bb2:  // pred: ^bb1
      llhd.drv %update_round, %true after %1 : i1
      llhd.drv %round_d, %false after %1 : i1
      %115 = llhd.prb %hmac_en_i_3 : i1
      %116 = llhd.prb %reg_hash_start_i_6 : i1
      %117 = comb.and %115, %116 : i1
      cf.cond_br %117, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %st_d, %c1_i3 after %1 : i3
      llhd.drv %clr_txcount, %true after %1 : i1
      llhd.drv %hash_start, %true after %1 : i1
      cf.br ^bb36
    ^bb4:  // pred: ^bb2
      %118 = llhd.prb %hmac_en_i_3 : i1
      %119 = llhd.prb %reg_hash_continue_i_7 : i1
      %120 = comb.and %118, %119 : i1
      cf.cond_br %120, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %st_d, %c2_i3 after %1 : i3
      llhd.drv %load_txcount, %true after %1 : i1
      llhd.drv %hash_continue, %true after %1 : i1
      cf.br ^bb36
    ^bb6:  // pred: ^bb4
      llhd.drv %st_d, %c0_i3 after %1 : i3
      cf.br ^bb36
    ^bb7:  // pred: ^bb1
      %121 = comb.icmp ceq %113, %c1_i3 : i3
      cf.cond_br %121, ^bb8, ^bb11
    ^bb8:  // pred: ^bb7
      llhd.drv %sel_rdata, %c0_i2 after %1 : i2
      %122 = llhd.prb %txcnt_eq_blksz : i1
      cf.cond_br %122, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      llhd.drv %st_d, %c2_i3 after %1 : i3
      llhd.drv %hmac_sha_rvalid, %false after %1 : i1
      cf.br ^bb36
    ^bb10:  // pred: ^bb8
      llhd.drv %st_d, %c1_i3 after %1 : i3
      llhd.drv %hmac_sha_rvalid, %true after %1 : i1
      cf.br ^bb36
    ^bb11:  // pred: ^bb7
      %123 = comb.icmp ceq %113, %c2_i3 : i3
      cf.cond_br %123, ^bb12, ^bb17
    ^bb12:  // pred: ^bb11
      llhd.drv %sel_rdata, %c-2_i2 after %1 : i2
      %124 = llhd.prb %round_q : i1
      llhd.drv %fifo_wsel_o, %124 after %1 : i1
      %125 = llhd.prb %round_q : i1
      %126 = comb.xor %125, %true : i1
      %127 = llhd.prb %reg_hash_process_flag : i1
      %128 = comb.and %126, %127 : i1
      %129 = comb.or %128, %125 : i1
      %130 = llhd.prb %txcount : i64
      %131 = llhd.prb %sha_message_length_o : i64
      %132 = comb.icmp uge %130, %131 : i64
      %133 = comb.and %129, %132 : i1
      cf.cond_br %133, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      llhd.drv %st_d, %c-4_i3 after %1 : i3
      llhd.drv %hmac_sha_rvalid, %false after %1 : i1
      %134 = llhd.prb %round_q : i1
      llhd.drv %hash_process, %134 after %1 : i1
      cf.br ^bb36
    ^bb14:  // pred: ^bb12
      %135 = llhd.prb %txcnt_eq_blksz : i1
      %136 = llhd.prb %txcount : i64
      %137 = llhd.prb %sha_message_length_o : i64
      %138 = comb.icmp uge %136, %137 : i64
      %139 = llhd.prb %reg_hash_stop_q : i1
      %140 = llhd.prb %round_q : i1
      %141 = comb.xor %140, %true : i1
      %142 = comb.and %135, %138, %139, %141 : i1
      cf.cond_br %142, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      llhd.drv %st_d, %c-4_i3 after %1 : i3
      llhd.drv %hmac_sha_rvalid, %false after %1 : i1
      cf.br ^bb36
    ^bb16:  // pred: ^bb14
      llhd.drv %st_d, %c2_i3 after %1 : i3
      %143 = llhd.prb %fifo_rvalid_i_11 : i1
      llhd.drv %hmac_sha_rvalid, %143 after %1 : i1
      cf.br ^bb36
    ^bb17:  // pred: ^bb11
      %144 = comb.icmp ceq %113, %c-4_i3 : i3
      cf.cond_br %144, ^bb18, ^bb25
    ^bb18:  // pred: ^bb17
      llhd.drv %hmac_sha_rvalid, %false after %1 : i1
      %145 = llhd.prb %sha_hash_done_i_9 : i1
      cf.cond_br %145, ^bb19, ^bb24
    ^bb19:  // pred: ^bb18
      %146 = llhd.prb %round_q : i1
      cf.cond_br %146, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      llhd.drv %st_d, %c-2_i3 after %1 : i3
      cf.br ^bb36
    ^bb21:  // pred: ^bb19
      %147 = llhd.prb %reg_hash_stop_q : i1
      cf.cond_br %147, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      llhd.drv %st_d, %c-2_i3 after %1 : i3
      cf.br ^bb36
    ^bb23:  // pred: ^bb21
      llhd.drv %st_d, %c3_i3 after %1 : i3
      cf.br ^bb36
    ^bb24:  // pred: ^bb18
      llhd.drv %st_d, %c-4_i3 after %1 : i3
      cf.br ^bb36
    ^bb25:  // pred: ^bb17
      %148 = comb.icmp ceq %113, %c3_i3 : i3
      cf.cond_br %148, ^bb26, ^bb29
    ^bb26:  // pred: ^bb25
      llhd.drv %hmac_sha_rvalid, %false after %1 : i1
      llhd.drv %fifo_wsel_o, %true after %1 : i1
      llhd.drv %fifo_wvalid_o, %true after %1 : i1
      llhd.drv %clr_fifo_wdata_sel, %false after %1 : i1
      %149 = llhd.prb %fifo_wready_i_13 : i1
      %150 = llhd.prb %fifo_wdata_sel_o : i4
      %151 = comb.icmp eq %150, %c7_i4 : i4
      %152 = llhd.prb %digest_size_i_4 : i4
      %153 = comb.icmp eq %152, %c1_i4 : i4
      %154 = comb.and %151, %153 : i1
      %155 = comb.icmp eq %150, %c-1_i4 : i4
      %156 = comb.icmp eq %152, %c4_i4 : i4
      %157 = comb.and %155, %156 : i1
      %158 = comb.icmp eq %150, %c-5_i4 : i4
      %159 = comb.icmp eq %152, %c2_i4 : i4
      %160 = comb.and %158, %159 : i1
      %161 = comb.or %154, %157, %160 : i1
      %162 = comb.and %149, %161 : i1
      cf.cond_br %162, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      llhd.drv %st_d, %c-3_i3 after %1 : i3
      llhd.drv %clr_txcount, %true after %1 : i1
      llhd.drv %update_round, %true after %1 : i1
      llhd.drv %round_d, %true after %1 : i1
      llhd.drv %hash_start, %true after %1 : i1
      cf.br ^bb36
    ^bb28:  // pred: ^bb26
      llhd.drv %st_d, %c3_i3 after %1 : i3
      cf.br ^bb36
    ^bb29:  // pred: ^bb25
      %163 = comb.icmp ceq %113, %c-3_i3 : i3
      cf.cond_br %163, ^bb30, ^bb33
    ^bb30:  // pred: ^bb29
      llhd.drv %sel_rdata, %c1_i2 after %1 : i2
      llhd.drv %fifo_wsel_o, %true after %1 : i1
      %164 = llhd.prb %txcnt_eq_blksz : i1
      cf.cond_br %164, ^bb31, ^bb32
    ^bb31:  // pred: ^bb30
      llhd.drv %st_d, %c2_i3 after %1 : i3
      llhd.drv %hmac_sha_rvalid, %false after %1 : i1
      cf.br ^bb36
    ^bb32:  // pred: ^bb30
      llhd.drv %st_d, %c-3_i3 after %1 : i3
      llhd.drv %hmac_sha_rvalid, %true after %1 : i1
      cf.br ^bb36
    ^bb33:  // pred: ^bb29
      %165 = comb.icmp ceq %113, %c-2_i3 : i3
      cf.cond_br %165, ^bb34, ^bb35
    ^bb34:  // pred: ^bb33
      llhd.drv %st_d, %c0_i3 after %1 : i3
      llhd.drv %hmac_hash_done, %true after %1 : i1
      cf.br ^bb36
    ^bb35:  // pred: ^bb33
      llhd.drv %st_d, %c0_i3 after %1 : i3
      cf.br ^bb36
    ^bb36:  // 18 preds: ^bb3, ^bb5, ^bb6, ^bb9, ^bb10, ^bb13, ^bb15, ^bb16, ^bb20, ^bb22, ^bb23, ^bb24, ^bb27, ^bb28, ^bb31, ^bb32, ^bb34, ^bb35
      llhd.wait (%16, %36, %84, %85, %88, %89, %90, %91, %92, %39, %6, %9, %13, %28, %93, %5, %7, %10, %81, %87, %94, %19, %95, %96, %35, %17, %97, %98, %41 : i1, i1, i1, i1, i1, i1, i1, i1, i1, i2, i1, i1, i1, i3, i3, i1, i1, i1, i1, i1, i1, i64, i64, i1, i1, i1, i1, i4, i4), ^bb1
    }
    %99 = comb.and %17, %96 : i1
    %100 = comb.xor %99, %true : i1
    %101 = comb.and %100, %96 : i1
    %102 = comb.or %reg_hash_stop_i, %101 : i1
    llhd.drv %reg_hash_stop_d, %102 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %clk_i_0 : i1
      %113 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %clk_i_0 : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %rst_ni_1 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %rst_ni_1 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %reg_hash_stop_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %reg_hash_stop_d : i1
      llhd.drv %reg_hash_stop_q, %123 after %0 : i1
      cf.br ^bb1
    }
    %103 = comb.or %7, %10 : i1
    %104 = comb.icmp eq %28, %c0_i3 : i3
    %105 = llhd.prb %reg_hash_stop_d : i1
    %106 = comb.and %81, %105 : i1
    %107 = llhd.prb %idle_q : i1
    %108 = comb.or %104, %106, %107 : i1
    %109 = comb.xor %103, %true : i1
    %110 = comb.and %109, %108 : i1
    llhd.drv %idle_d, %110 after %1 : i1
    %111 = llhd.prb %idle_d : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %clk_i_0 : i1
      %113 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %clk_i_0 : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %rst_ni_1 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %rst_ni_1 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %idle_q, %true after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %idle_d : i1
      llhd.drv %idle_q, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %secret_key_i_2, %secret_key_i after %1 : i1024
    llhd.drv %hmac_en_i_3, %hmac_en_i after %1 : i1
    llhd.drv %digest_size_i_4, %digest_size_i after %1 : i4
    llhd.drv %key_length_i_5, %key_length_i after %1 : i6
    llhd.drv %reg_hash_start_i_6, %reg_hash_start_i after %1 : i1
    llhd.drv %reg_hash_continue_i_7, %reg_hash_continue_i after %1 : i1
    llhd.drv %reg_hash_process_i_8, %reg_hash_process_i after %1 : i1
    llhd.drv %sha_hash_done_i_9, %sha_hash_done_i after %1 : i1
    llhd.drv %sha_rready_i_10, %sha_rready_i after %1 : i1
    llhd.drv %fifo_rvalid_i_11, %fifo_rvalid_i after %1 : i1
    llhd.drv %fifo_rdata_i_12, %fifo_rdata_i after %1 : !hw.struct<data: i32, mask: i4>
    llhd.drv %fifo_wready_i_13, %fifo_wready_i after %1 : i1
    llhd.drv %message_length_i_14, %message_length_i after %1 : i64
    hw.output %18, %8, %11, %15, %37, %77, %33, %90, %91, %98, %95, %111 : i1, i1, i1, i1, i1, !hw.struct<data: i32, mask: i4>, i1, i1, i1, i4, i64, i1
  }
  hw.module private @hmac_reg_top(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_win_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, in %tl_win_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out reg2hw : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>, in %hw2reg : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>, out intg_err_o : i1) {
    %c8192_i32 = hw.constant 8192 : i32
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
    %c-1_i7 = hw.constant -1 : i7
    %c-1_i3 = hw.constant -1 : i3
    %c0_i19 = hw.constant 0 : i19
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-2_i4 = hw.constant -2 : i4
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
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i3 = hw.constant -2 : i3
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i7 = hw.constant 0 : i7
    %c0_i3 = hw.constant 0 : i3
    %2 = hw.aggregate_constant [[false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false]] : !hw.array<2xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %c0_i59 = hw.constant 0 : i59
    %c0_i4 = hw.constant 0 : i4
    %3 = hw.aggregate_constant [[[false], [false], [false]], [[false], [false], [false]], [[false, false], [false, false], [false, false]], [false, false], [[0 : i6, false], [0 : i4, false], [false, false], [false, false], [false, false], [false, false], [false, false]], [[false, false], [false, false], [false, false], [false, false]], [0 : i32, false], [[0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false]], [[0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false]], [0 : i32, false], [0 : i32, false]] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
    %4 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %c-1_i32 = hw.constant -1 : i32
    %c-1_i4 = hw.constant -1 : i4
    %c3_i4 = hw.constant 3 : i4
    %c1_i4 = hw.constant 1 : i4
    %c232_i13 = hw.constant 232 : i13
    %c228_i13 = hw.constant 228 : i13
    %c224_i13 = hw.constant 224 : i13
    %c220_i13 = hw.constant 220 : i13
    %c216_i13 = hw.constant 216 : i13
    %c212_i13 = hw.constant 212 : i13
    %c208_i13 = hw.constant 208 : i13
    %c204_i13 = hw.constant 204 : i13
    %c200_i13 = hw.constant 200 : i13
    %c196_i13 = hw.constant 196 : i13
    %c192_i13 = hw.constant 192 : i13
    %c188_i13 = hw.constant 188 : i13
    %c184_i13 = hw.constant 184 : i13
    %c180_i13 = hw.constant 180 : i13
    %c176_i13 = hw.constant 176 : i13
    %c172_i13 = hw.constant 172 : i13
    %c168_i13 = hw.constant 168 : i13
    %c164_i13 = hw.constant 164 : i13
    %c160_i13 = hw.constant 160 : i13
    %c156_i13 = hw.constant 156 : i13
    %c152_i13 = hw.constant 152 : i13
    %c148_i13 = hw.constant 148 : i13
    %c144_i13 = hw.constant 144 : i13
    %c140_i13 = hw.constant 140 : i13
    %c136_i13 = hw.constant 136 : i13
    %c132_i13 = hw.constant 132 : i13
    %c128_i13 = hw.constant 128 : i13
    %c124_i13 = hw.constant 124 : i13
    %c120_i13 = hw.constant 120 : i13
    %c116_i13 = hw.constant 116 : i13
    %c112_i13 = hw.constant 112 : i13
    %c108_i13 = hw.constant 108 : i13
    %c104_i13 = hw.constant 104 : i13
    %c100_i13 = hw.constant 100 : i13
    %c96_i13 = hw.constant 96 : i13
    %c92_i13 = hw.constant 92 : i13
    %c88_i13 = hw.constant 88 : i13
    %c84_i13 = hw.constant 84 : i13
    %c80_i13 = hw.constant 80 : i13
    %c76_i13 = hw.constant 76 : i13
    %c72_i13 = hw.constant 72 : i13
    %c68_i13 = hw.constant 68 : i13
    %c64_i13 = hw.constant 64 : i13
    %c60_i13 = hw.constant 60 : i13
    %c56_i13 = hw.constant 56 : i13
    %c52_i13 = hw.constant 52 : i13
    %c48_i13 = hw.constant 48 : i13
    %c44_i13 = hw.constant 44 : i13
    %c40_i13 = hw.constant 40 : i13
    %c36_i13 = hw.constant 36 : i13
    %c32_i13 = hw.constant 32 : i13
    %c28_i13 = hw.constant 28 : i13
    %c24_i13 = hw.constant 24 : i13
    %c20_i13 = hw.constant 20 : i13
    %c16_i13 = hw.constant 16 : i13
    %c12_i13 = hw.constant 12 : i13
    %c8_i13 = hw.constant 8 : i13
    %c4_i13 = hw.constant 4 : i13
    %c0_i13 = hw.constant 0 : i13
    %true = hw.constant true
    %c0_i32 = hw.constant 0 : i32
    %c0_i6 = hw.constant 0 : i6
    %false = hw.constant false {sv.namehint = "shadow_busy"}
    %c-7_i4 = hw.constant -7 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %5 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %6 = llhd.prb %rst_ni_1 : i1
    %tl_i_2 = llhd.sig name "tl_i" %4 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %reg2hw = llhd.sig %3 : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
    %reg_we = llhd.sig %false : i1
    %reg_addr = llhd.sig %c0_i13 : i13
    %reg_be = llhd.sig %c0_i4 : i4
    %wr_err = llhd.sig %false : i1
    %reg_rdata_next = llhd.sig %c0_i32 : i32
    %intg_err = llhd.sig %false : i1
    %reg_we_err = llhd.sig %false : i1
    %reg_we_check = llhd.sig %c0_i59 : i59
    %err_q = llhd.sig %false : i1
    %tl_socket_d2h = llhd.sig %2 : !hw.array<2xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %reg_steer = llhd.sig %false : i1
    %intr_state_we = llhd.sig %false : i1
    %intr_state_hmac_done_qs = llhd.sig %false : i1
    %intr_state_fifo_empty_qs = llhd.sig %false : i1
    %intr_state_hmac_err_qs = llhd.sig %false : i1
    %intr_enable_we = llhd.sig %false : i1
    %intr_enable_hmac_done_qs = llhd.sig %false : i1
    %intr_enable_fifo_empty_qs = llhd.sig %false : i1
    %intr_enable_hmac_err_qs = llhd.sig %false : i1
    %intr_test_we = llhd.sig %false : i1
    %alert_test_we = llhd.sig %false : i1
    %cfg_we = llhd.sig %false : i1
    %cfg_hmac_en_qs = llhd.sig %false : i1
    %cfg_sha_en_qs = llhd.sig %false : i1
    %cfg_endian_swap_qs = llhd.sig %false : i1
    %cfg_digest_swap_qs = llhd.sig %false : i1
    %cfg_key_swap_qs = llhd.sig %false : i1
    %cfg_digest_size_qs = llhd.sig %c0_i4 : i4
    %cfg_key_length_qs = llhd.sig %c0_i6 : i6
    %cmd_we = llhd.sig %false : i1
    %status_hmac_idle_qs = llhd.sig %false : i1
    %status_fifo_empty_qs = llhd.sig %false : i1
    %status_fifo_full_qs = llhd.sig %false : i1
    %status_fifo_depth_qs = llhd.sig %c0_i6 : i6
    %err_code_qs = llhd.sig %c0_i32 : i32
    %wipe_secret_we = llhd.sig %false : i1
    %key_0_we = llhd.sig %false : i1
    %key_1_we = llhd.sig %false : i1
    %key_2_we = llhd.sig %false : i1
    %key_3_we = llhd.sig %false : i1
    %key_4_we = llhd.sig %false : i1
    %key_5_we = llhd.sig %false : i1
    %key_6_we = llhd.sig %false : i1
    %key_7_we = llhd.sig %false : i1
    %key_8_we = llhd.sig %false : i1
    %key_9_we = llhd.sig %false : i1
    %key_10_we = llhd.sig %false : i1
    %key_11_we = llhd.sig %false : i1
    %key_12_we = llhd.sig %false : i1
    %key_13_we = llhd.sig %false : i1
    %key_14_we = llhd.sig %false : i1
    %key_15_we = llhd.sig %false : i1
    %key_16_we = llhd.sig %false : i1
    %key_17_we = llhd.sig %false : i1
    %key_18_we = llhd.sig %false : i1
    %key_19_we = llhd.sig %false : i1
    %key_20_we = llhd.sig %false : i1
    %key_21_we = llhd.sig %false : i1
    %key_22_we = llhd.sig %false : i1
    %key_23_we = llhd.sig %false : i1
    %key_24_we = llhd.sig %false : i1
    %key_25_we = llhd.sig %false : i1
    %key_26_we = llhd.sig %false : i1
    %key_27_we = llhd.sig %false : i1
    %key_28_we = llhd.sig %false : i1
    %key_29_we = llhd.sig %false : i1
    %key_30_we = llhd.sig %false : i1
    %key_31_we = llhd.sig %false : i1
    %digest_0_we = llhd.sig %false : i1
    %digest_0_qs = llhd.sig %c0_i32 : i32
    %digest_1_we = llhd.sig %false : i1
    %digest_1_qs = llhd.sig %c0_i32 : i32
    %digest_2_we = llhd.sig %false : i1
    %digest_2_qs = llhd.sig %c0_i32 : i32
    %digest_3_we = llhd.sig %false : i1
    %digest_3_qs = llhd.sig %c0_i32 : i32
    %digest_4_we = llhd.sig %false : i1
    %digest_4_qs = llhd.sig %c0_i32 : i32
    %digest_5_we = llhd.sig %false : i1
    %digest_5_qs = llhd.sig %c0_i32 : i32
    %digest_6_we = llhd.sig %false : i1
    %digest_6_qs = llhd.sig %c0_i32 : i32
    %digest_7_we = llhd.sig %false : i1
    %digest_7_qs = llhd.sig %c0_i32 : i32
    %digest_8_we = llhd.sig %false : i1
    %digest_8_qs = llhd.sig %c0_i32 : i32
    %digest_9_we = llhd.sig %false : i1
    %digest_9_qs = llhd.sig %c0_i32 : i32
    %digest_10_we = llhd.sig %false : i1
    %digest_10_qs = llhd.sig %c0_i32 : i32
    %digest_11_we = llhd.sig %false : i1
    %digest_11_qs = llhd.sig %c0_i32 : i32
    %digest_12_we = llhd.sig %false : i1
    %digest_12_qs = llhd.sig %c0_i32 : i32
    %digest_13_we = llhd.sig %false : i1
    %digest_13_qs = llhd.sig %c0_i32 : i32
    %digest_14_we = llhd.sig %false : i1
    %digest_14_qs = llhd.sig %c0_i32 : i32
    %digest_15_we = llhd.sig %false : i1
    %digest_15_qs = llhd.sig %c0_i32 : i32
    %msg_length_lower_we = llhd.sig %false : i1
    %msg_length_lower_qs = llhd.sig %c0_i32 : i32
    %msg_length_upper_we = llhd.sig %false : i1
    %msg_length_upper_qs = llhd.sig %c0_i32 : i32
    %intr_test_flds_we = llhd.sig %c0_i3 : i3
    %alert_test_flds_we = llhd.sig %false : i1
    %cfg_flds_we = llhd.sig %c0_i7 : i7
    %cmd_flds_we = llhd.sig %c0_i4 : i4
    %wipe_secret_flds_we = llhd.sig %false : i1
    %key_0_flds_we = llhd.sig %false : i1
    %key_1_flds_we = llhd.sig %false : i1
    %key_2_flds_we = llhd.sig %false : i1
    %key_3_flds_we = llhd.sig %false : i1
    %key_4_flds_we = llhd.sig %false : i1
    %key_5_flds_we = llhd.sig %false : i1
    %key_6_flds_we = llhd.sig %false : i1
    %key_7_flds_we = llhd.sig %false : i1
    %key_8_flds_we = llhd.sig %false : i1
    %key_9_flds_we = llhd.sig %false : i1
    %key_10_flds_we = llhd.sig %false : i1
    %key_11_flds_we = llhd.sig %false : i1
    %key_12_flds_we = llhd.sig %false : i1
    %key_13_flds_we = llhd.sig %false : i1
    %key_14_flds_we = llhd.sig %false : i1
    %key_15_flds_we = llhd.sig %false : i1
    %key_16_flds_we = llhd.sig %false : i1
    %key_17_flds_we = llhd.sig %false : i1
    %key_18_flds_we = llhd.sig %false : i1
    %key_19_flds_we = llhd.sig %false : i1
    %key_20_flds_we = llhd.sig %false : i1
    %key_21_flds_we = llhd.sig %false : i1
    %key_22_flds_we = llhd.sig %false : i1
    %key_23_flds_we = llhd.sig %false : i1
    %key_24_flds_we = llhd.sig %false : i1
    %key_25_flds_we = llhd.sig %false : i1
    %key_26_flds_we = llhd.sig %false : i1
    %key_27_flds_we = llhd.sig %false : i1
    %key_28_flds_we = llhd.sig %false : i1
    %key_29_flds_we = llhd.sig %false : i1
    %key_30_flds_we = llhd.sig %false : i1
    %key_31_flds_we = llhd.sig %false : i1
    %digest_0_flds_we = llhd.sig %false : i1
    %digest_1_flds_we = llhd.sig %false : i1
    %digest_2_flds_we = llhd.sig %false : i1
    %digest_3_flds_we = llhd.sig %false : i1
    %digest_4_flds_we = llhd.sig %false : i1
    %digest_5_flds_we = llhd.sig %false : i1
    %digest_6_flds_we = llhd.sig %false : i1
    %digest_7_flds_we = llhd.sig %false : i1
    %digest_8_flds_we = llhd.sig %false : i1
    %digest_9_flds_we = llhd.sig %false : i1
    %digest_10_flds_we = llhd.sig %false : i1
    %digest_11_flds_we = llhd.sig %false : i1
    %digest_12_flds_we = llhd.sig %false : i1
    %digest_13_flds_we = llhd.sig %false : i1
    %digest_14_flds_we = llhd.sig %false : i1
    %digest_15_flds_we = llhd.sig %false : i1
    %msg_length_lower_flds_we = llhd.sig %false : i1
    %msg_length_upper_flds_we = llhd.sig %false : i1
    %addr_hit = llhd.sig %c0_i59 : i59
    %7 = llhd.prb %tl_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %u_chk.err_o = hw.instance "u_chk" @tlul_cmd_intg_chk(tl_i: %7: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1)
    llhd.drv %intg_err, %u_chk.err_o after %1 : i1
    %8 = llhd.prb %reg_we_check : i59
    %9 = llhd.prb %reg_we : i1
    %10 = comb.xor %423, %true : i1
    %11 = comb.and %9, %10 : i1
    %u_prim_reg_we_check.err_o = hw.instance "u_prim_reg_we_check" @prim_reg_we_check(clk_i: %5: i1, rst_ni: %6: i1, oh_i: %8: i59, en_i: %11: i1) -> (err_o: i1)
    llhd.drv %reg_we_err, %u_prim_reg_we_check.err_o after %1 : i1
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen_4(tl_i: %u_socket.tl_h_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %12 = llhd.prb %tl_socket_d2h : !hw.array<2xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %13 = llhd.prb %reg_steer : i1
    %u_socket.tl_h_o, %u_socket.tl_d_o = hw.instance "u_socket" @tlul_socket_1n(clk_i: %5: i1, rst_ni: %6: i1, tl_h_i: %7: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, tl_d_i: %12: !hw.array<2xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, dev_select_i: %13: i1) -> (tl_h_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tl_d_o: !hw.array<2xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>) {sv.namehint = "tl_o_pre"}
    %u_reg_if.tl_o, %u_reg_if.intg_error_o, %u_reg_if.re_o, %u_reg_if.we_o, %u_reg_if.addr_o, %u_reg_if.wdata_o, %u_reg_if.be_o = hw.instance "u_reg_if" @tlul_adapter_reg(clk_i: %5: i1, rst_ni: %6: i1, tl_i: %288: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %c-7_i4: i4, busy_i: %false: i1, rdata_i: %292: i32, error_i: %294: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, intg_error_o: i1, re_o: i1, we_o: i1, addr_o: i13, wdata_o: i32, be_o: i4) {sv.namehint = "reg_re"}
    llhd.drv %reg_we, %u_reg_if.we_o after %1 : i1
    llhd.drv %reg_addr, %u_reg_if.addr_o after %1 : i13
    llhd.drv %reg_be, %u_reg_if.be_o after %1 : i4
    %14 = llhd.prb %intr_state_we : i1
    %intr_state = hw.struct_extract %hw2reg["intr_state"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>
    %hmac_done = hw.struct_extract %intr_state["hmac_done"] : !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>
    %de = hw.struct_extract %hmac_done["de"] : !hw.struct<d: i1, de: i1>
    %d = hw.struct_extract %hmac_done["d"] : !hw.struct<d: i1, de: i1>
    %15 = llhd.sig.struct_extract %reg2hw["intr_state"] : <!hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>>
    %16 = llhd.sig.struct_extract %15["hmac_done"] : <!hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>>
    %17 = llhd.sig.struct_extract %16["q"] : <!hw.struct<q: i1>>
    %u_intr_state_hmac_done.qe, %u_intr_state_hmac_done.q, %u_intr_state_hmac_done.ds, %u_intr_state_hmac_done.qs = hw.instance "u_intr_state_hmac_done" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %14: i1, wd: %428: i1, de: %de: i1, d: %d: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %17, %u_intr_state_hmac_done.q after %1 : i1
    llhd.drv %intr_state_hmac_done_qs, %u_intr_state_hmac_done.qs after %1 : i1
    %fifo_empty = hw.struct_extract %intr_state["fifo_empty"] : !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>
    %de_3 = hw.struct_extract %fifo_empty["de"] : !hw.struct<d: i1, de: i1>
    %d_4 = hw.struct_extract %fifo_empty["d"] : !hw.struct<d: i1, de: i1>
    %18 = llhd.sig.struct_extract %15["fifo_empty"] : <!hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>>
    %19 = llhd.sig.struct_extract %18["q"] : <!hw.struct<q: i1>>
    %u_intr_state_fifo_empty.qe, %u_intr_state_fifo_empty.q, %u_intr_state_fifo_empty.ds, %u_intr_state_fifo_empty.qs = hw.instance "u_intr_state_fifo_empty" @prim_subreg_5(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %false: i1, de: %de_3: i1, d: %d_4: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %19, %u_intr_state_fifo_empty.q after %1 : i1
    llhd.drv %intr_state_fifo_empty_qs, %u_intr_state_fifo_empty.qs after %1 : i1
    %hmac_err = hw.struct_extract %intr_state["hmac_err"] : !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>
    %de_5 = hw.struct_extract %hmac_err["de"] : !hw.struct<d: i1, de: i1>
    %d_6 = hw.struct_extract %hmac_err["d"] : !hw.struct<d: i1, de: i1>
    %20 = llhd.sig.struct_extract %15["hmac_err"] : <!hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>>
    %21 = llhd.sig.struct_extract %20["q"] : <!hw.struct<q: i1>>
    %u_intr_state_hmac_err.qe, %u_intr_state_hmac_err.q, %u_intr_state_hmac_err.ds, %u_intr_state_hmac_err.qs = hw.instance "u_intr_state_hmac_err" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %14: i1, wd: %429: i1, de: %de_5: i1, d: %d_6: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %21, %u_intr_state_hmac_err.q after %1 : i1
    llhd.drv %intr_state_hmac_err_qs, %u_intr_state_hmac_err.qs after %1 : i1
    %22 = llhd.prb %intr_enable_we : i1
    %23 = llhd.sig.struct_extract %reg2hw["intr_enable"] : <!hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>>
    %24 = llhd.sig.struct_extract %23["hmac_done"] : <!hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>>
    %25 = llhd.sig.struct_extract %24["q"] : <!hw.struct<q: i1>>
    %u_intr_enable_hmac_done.qe, %u_intr_enable_hmac_done.q, %u_intr_enable_hmac_done.ds, %u_intr_enable_hmac_done.qs = hw.instance "u_intr_enable_hmac_done" @prim_subreg_6(clk_i: %5: i1, rst_ni: %6: i1, we: %22: i1, wd: %428: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %25, %u_intr_enable_hmac_done.q after %1 : i1
    llhd.drv %intr_enable_hmac_done_qs, %u_intr_enable_hmac_done.qs after %1 : i1
    %26 = llhd.sig.struct_extract %23["fifo_empty"] : <!hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>>
    %27 = llhd.sig.struct_extract %26["q"] : <!hw.struct<q: i1>>
    %u_intr_enable_fifo_empty.qe, %u_intr_enable_fifo_empty.q, %u_intr_enable_fifo_empty.ds, %u_intr_enable_fifo_empty.qs = hw.instance "u_intr_enable_fifo_empty" @prim_subreg_6(clk_i: %5: i1, rst_ni: %6: i1, we: %22: i1, wd: %432: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %27, %u_intr_enable_fifo_empty.q after %1 : i1
    llhd.drv %intr_enable_fifo_empty_qs, %u_intr_enable_fifo_empty.qs after %1 : i1
    %28 = llhd.sig.struct_extract %23["hmac_err"] : <!hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>>
    %29 = llhd.sig.struct_extract %28["q"] : <!hw.struct<q: i1>>
    %u_intr_enable_hmac_err.qe, %u_intr_enable_hmac_err.q, %u_intr_enable_hmac_err.ds, %u_intr_enable_hmac_err.qs = hw.instance "u_intr_enable_hmac_err" @prim_subreg_6(clk_i: %5: i1, rst_ni: %6: i1, we: %22: i1, wd: %429: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %29, %u_intr_enable_hmac_err.q after %1 : i1
    llhd.drv %intr_enable_hmac_err_qs, %u_intr_enable_hmac_err.qs after %1 : i1
    %30 = llhd.prb %intr_test_we : i1
    %31 = llhd.sig.extract %intr_test_flds_we from %c0_i2 : <i3> -> <i1>
    %32 = llhd.sig.struct_extract %reg2hw["intr_test"] : <!hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>>
    %33 = llhd.sig.struct_extract %32["hmac_done"] : <!hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>>
    %34 = llhd.sig.struct_extract %33["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_intr_test_hmac_done.qe, %u_intr_test_hmac_done.qre, %u_intr_test_hmac_done.q, %u_intr_test_hmac_done.ds, %u_intr_test_hmac_done.qs = hw.instance "u_intr_test_hmac_done" @prim_subreg_ext(re: %false: i1, we: %30: i1, wd: %428: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %31, %u_intr_test_hmac_done.qe after %1 : i1
    llhd.drv %34, %u_intr_test_hmac_done.q after %1 : i1
    %35 = llhd.sig.extract %intr_test_flds_we from %c1_i2 : <i3> -> <i1>
    %36 = llhd.sig.struct_extract %32["fifo_empty"] : <!hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>>
    %37 = llhd.sig.struct_extract %36["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_intr_test_fifo_empty.qe, %u_intr_test_fifo_empty.qre, %u_intr_test_fifo_empty.q, %u_intr_test_fifo_empty.ds, %u_intr_test_fifo_empty.qs = hw.instance "u_intr_test_fifo_empty" @prim_subreg_ext(re: %false: i1, we: %30: i1, wd: %432: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %35, %u_intr_test_fifo_empty.qe after %1 : i1
    llhd.drv %37, %u_intr_test_fifo_empty.q after %1 : i1
    %38 = llhd.sig.extract %intr_test_flds_we from %c-2_i2 : <i3> -> <i1>
    %39 = llhd.sig.struct_extract %32["hmac_err"] : <!hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>>
    %40 = llhd.sig.struct_extract %39["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_intr_test_hmac_err.qe, %u_intr_test_hmac_err.qre, %u_intr_test_hmac_err.q, %u_intr_test_hmac_err.ds, %u_intr_test_hmac_err.qs = hw.instance "u_intr_test_hmac_err" @prim_subreg_ext(re: %false: i1, we: %30: i1, wd: %429: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %38, %u_intr_test_hmac_err.qe after %1 : i1
    llhd.drv %40, %u_intr_test_hmac_err.q after %1 : i1
    %41 = llhd.prb %alert_test_we : i1
    %42 = llhd.sig.struct_extract %reg2hw["alert_test"] : <!hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>>
    %43 = llhd.sig.struct_extract %42["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_alert_test.qe, %u_alert_test.qre, %u_alert_test.q, %u_alert_test.ds, %u_alert_test.qs = hw.instance "u_alert_test" @prim_subreg_ext(re: %false: i1, we: %41: i1, wd: %428: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %alert_test_flds_we, %u_alert_test.qe after %1 : i1
    llhd.drv %43, %u_alert_test.q after %1 : i1
    %44 = llhd.prb %cfg_we : i1
    %cfg = hw.struct_extract %hw2reg["cfg"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>
    %hmac_en = hw.struct_extract %cfg["hmac_en"] : !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>
    %d_7 = hw.struct_extract %hmac_en["d"] : !hw.struct<d: i1>
    %45 = llhd.sig.extract %cfg_flds_we from %c0_i3 : <i7> -> <i1>
    %46 = llhd.sig.struct_extract %reg2hw["cfg"] : <!hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>>
    %47 = llhd.sig.struct_extract %46["hmac_en"] : <!hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>>
    %48 = llhd.sig.struct_extract %47["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_cfg_hmac_en.qe, %u_cfg_hmac_en.qre, %u_cfg_hmac_en.q, %u_cfg_hmac_en.ds, %u_cfg_hmac_en.qs = hw.instance "u_cfg_hmac_en" @prim_subreg_ext(re: %438: i1, we: %44: i1, wd: %428: i1, d: %d_7: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %45, %u_cfg_hmac_en.qe after %1 : i1
    llhd.drv %48, %u_cfg_hmac_en.q after %1 : i1
    llhd.drv %cfg_hmac_en_qs, %u_cfg_hmac_en.qs after %1 : i1
    %sha_en = hw.struct_extract %cfg["sha_en"] : !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>
    %d_8 = hw.struct_extract %sha_en["d"] : !hw.struct<d: i1>
    %49 = llhd.sig.extract %cfg_flds_we from %c1_i3 : <i7> -> <i1>
    %50 = llhd.sig.struct_extract %46["sha_en"] : <!hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>>
    %51 = llhd.sig.struct_extract %50["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_cfg_sha_en.qe, %u_cfg_sha_en.qre, %u_cfg_sha_en.q, %u_cfg_sha_en.ds, %u_cfg_sha_en.qs = hw.instance "u_cfg_sha_en" @prim_subreg_ext(re: %438: i1, we: %44: i1, wd: %432: i1, d: %d_8: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %49, %u_cfg_sha_en.qe after %1 : i1
    llhd.drv %51, %u_cfg_sha_en.q after %1 : i1
    llhd.drv %cfg_sha_en_qs, %u_cfg_sha_en.qs after %1 : i1
    %endian_swap = hw.struct_extract %cfg["endian_swap"] : !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>
    %d_9 = hw.struct_extract %endian_swap["d"] : !hw.struct<d: i1>
    %52 = llhd.sig.extract %cfg_flds_we from %c2_i3 : <i7> -> <i1>
    %53 = llhd.sig.struct_extract %46["endian_swap"] : <!hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>>
    %54 = llhd.sig.struct_extract %53["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_cfg_endian_swap.qe, %u_cfg_endian_swap.qre, %u_cfg_endian_swap.q, %u_cfg_endian_swap.ds, %u_cfg_endian_swap.qs = hw.instance "u_cfg_endian_swap" @prim_subreg_ext(re: %438: i1, we: %44: i1, wd: %429: i1, d: %d_9: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %52, %u_cfg_endian_swap.qe after %1 : i1
    llhd.drv %54, %u_cfg_endian_swap.q after %1 : i1
    llhd.drv %cfg_endian_swap_qs, %u_cfg_endian_swap.qs after %1 : i1
    %digest_swap = hw.struct_extract %cfg["digest_swap"] : !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>
    %d_10 = hw.struct_extract %digest_swap["d"] : !hw.struct<d: i1>
    %55 = llhd.sig.extract %cfg_flds_we from %c3_i3 : <i7> -> <i1>
    %56 = llhd.sig.struct_extract %46["digest_swap"] : <!hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>>
    %57 = llhd.sig.struct_extract %56["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_cfg_digest_swap.qe, %u_cfg_digest_swap.qre, %u_cfg_digest_swap.q, %u_cfg_digest_swap.ds, %u_cfg_digest_swap.qs = hw.instance "u_cfg_digest_swap" @prim_subreg_ext(re: %438: i1, we: %44: i1, wd: %440: i1, d: %d_10: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %55, %u_cfg_digest_swap.qe after %1 : i1
    llhd.drv %57, %u_cfg_digest_swap.q after %1 : i1
    llhd.drv %cfg_digest_swap_qs, %u_cfg_digest_swap.qs after %1 : i1
    %key_swap = hw.struct_extract %cfg["key_swap"] : !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>
    %d_11 = hw.struct_extract %key_swap["d"] : !hw.struct<d: i1>
    %58 = llhd.sig.extract %cfg_flds_we from %c-4_i3 : <i7> -> <i1>
    %59 = llhd.sig.struct_extract %46["key_swap"] : <!hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>>
    %60 = llhd.sig.struct_extract %59["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_cfg_key_swap.qe, %u_cfg_key_swap.qre, %u_cfg_key_swap.q, %u_cfg_key_swap.ds, %u_cfg_key_swap.qs = hw.instance "u_cfg_key_swap" @prim_subreg_ext(re: %438: i1, we: %44: i1, wd: %441: i1, d: %d_11: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %58, %u_cfg_key_swap.qe after %1 : i1
    llhd.drv %60, %u_cfg_key_swap.q after %1 : i1
    llhd.drv %cfg_key_swap_qs, %u_cfg_key_swap.qs after %1 : i1
    %digest_size = hw.struct_extract %cfg["digest_size"] : !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>
    %d_12 = hw.struct_extract %digest_size["d"] : !hw.struct<d: i4>
    %61 = llhd.sig.extract %cfg_flds_we from %c-3_i3 : <i7> -> <i1>
    %62 = llhd.sig.struct_extract %46["digest_size"] : <!hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>>
    %63 = llhd.sig.struct_extract %62["q"] : <!hw.struct<q: i4, qe: i1>>
    %u_cfg_digest_size.qe, %u_cfg_digest_size.qre, %u_cfg_digest_size.q, %u_cfg_digest_size.ds, %u_cfg_digest_size.qs = hw.instance "u_cfg_digest_size" @prim_subreg_ext_7(re: %438: i1, we: %44: i1, wd: %442: i4, d: %d_12: i4) -> (qe: i1, qre: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %61, %u_cfg_digest_size.qe after %1 : i1
    llhd.drv %63, %u_cfg_digest_size.q after %1 : i4
    llhd.drv %cfg_digest_size_qs, %u_cfg_digest_size.qs after %1 : i4
    %key_length = hw.struct_extract %cfg["key_length"] : !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>
    %d_13 = hw.struct_extract %key_length["d"] : !hw.struct<d: i6>
    %64 = llhd.sig.extract %cfg_flds_we from %c-2_i3 : <i7> -> <i1>
    %65 = llhd.sig.struct_extract %46["key_length"] : <!hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>>
    %66 = llhd.sig.struct_extract %65["q"] : <!hw.struct<q: i6, qe: i1>>
    %u_cfg_key_length.qe, %u_cfg_key_length.qre, %u_cfg_key_length.q, %u_cfg_key_length.ds, %u_cfg_key_length.qs = hw.instance "u_cfg_key_length" @prim_subreg_ext_8(re: %438: i1, we: %44: i1, wd: %443: i6, d: %d_13: i6) -> (qe: i1, qre: i1, q: i6, ds: i6, qs: i6)
    llhd.drv %64, %u_cfg_key_length.qe after %1 : i1
    llhd.drv %66, %u_cfg_key_length.q after %1 : i6
    llhd.drv %cfg_key_length_qs, %u_cfg_key_length.qs after %1 : i6
    %67 = llhd.prb %cmd_we : i1
    %68 = llhd.sig.extract %cmd_flds_we from %c0_i2 : <i4> -> <i1>
    %69 = llhd.sig.struct_extract %reg2hw["cmd"] : <!hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>>
    %70 = llhd.sig.struct_extract %69["hash_start"] : <!hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>>
    %71 = llhd.sig.struct_extract %70["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_cmd_hash_start.qe, %u_cmd_hash_start.qre, %u_cmd_hash_start.q, %u_cmd_hash_start.ds, %u_cmd_hash_start.qs = hw.instance "u_cmd_hash_start" @prim_subreg_ext(re: %false: i1, we: %67: i1, wd: %428: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %68, %u_cmd_hash_start.qe after %1 : i1
    llhd.drv %71, %u_cmd_hash_start.q after %1 : i1
    %72 = llhd.sig.extract %cmd_flds_we from %c1_i2 : <i4> -> <i1>
    %73 = llhd.sig.struct_extract %69["hash_process"] : <!hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>>
    %74 = llhd.sig.struct_extract %73["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_cmd_hash_process.qe, %u_cmd_hash_process.qre, %u_cmd_hash_process.q, %u_cmd_hash_process.ds, %u_cmd_hash_process.qs = hw.instance "u_cmd_hash_process" @prim_subreg_ext(re: %false: i1, we: %67: i1, wd: %432: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %72, %u_cmd_hash_process.qe after %1 : i1
    llhd.drv %74, %u_cmd_hash_process.q after %1 : i1
    %75 = llhd.sig.extract %cmd_flds_we from %c-2_i2 : <i4> -> <i1>
    %76 = llhd.sig.struct_extract %69["hash_stop"] : <!hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>>
    %77 = llhd.sig.struct_extract %76["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_cmd_hash_stop.qe, %u_cmd_hash_stop.qre, %u_cmd_hash_stop.q, %u_cmd_hash_stop.ds, %u_cmd_hash_stop.qs = hw.instance "u_cmd_hash_stop" @prim_subreg_ext(re: %false: i1, we: %67: i1, wd: %429: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %75, %u_cmd_hash_stop.qe after %1 : i1
    llhd.drv %77, %u_cmd_hash_stop.q after %1 : i1
    %78 = llhd.sig.extract %cmd_flds_we from %c-1_i2 : <i4> -> <i1>
    %79 = llhd.sig.struct_extract %69["hash_continue"] : <!hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>>
    %80 = llhd.sig.struct_extract %79["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_cmd_hash_continue.qe, %u_cmd_hash_continue.qre, %u_cmd_hash_continue.q, %u_cmd_hash_continue.ds, %u_cmd_hash_continue.qs = hw.instance "u_cmd_hash_continue" @prim_subreg_ext(re: %false: i1, we: %67: i1, wd: %440: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %78, %u_cmd_hash_continue.qe after %1 : i1
    llhd.drv %80, %u_cmd_hash_continue.q after %1 : i1
    %status = hw.struct_extract %hw2reg["status"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>
    %hmac_idle = hw.struct_extract %status["hmac_idle"] : !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>
    %d_14 = hw.struct_extract %hmac_idle["d"] : !hw.struct<d: i1>
    %u_status_hmac_idle.qe, %u_status_hmac_idle.qre, %u_status_hmac_idle.q, %u_status_hmac_idle.ds, %u_status_hmac_idle.qs = hw.instance "u_status_hmac_idle" @prim_subreg_ext(re: %447: i1, we: %false: i1, wd: %false: i1, d: %d_14: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_hmac_idle_qs, %u_status_hmac_idle.qs after %1 : i1
    %fifo_empty_15 = hw.struct_extract %status["fifo_empty"] : !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>
    %d_16 = hw.struct_extract %fifo_empty_15["d"] : !hw.struct<d: i1>
    %u_status_fifo_empty.qe, %u_status_fifo_empty.qre, %u_status_fifo_empty.q, %u_status_fifo_empty.ds, %u_status_fifo_empty.qs = hw.instance "u_status_fifo_empty" @prim_subreg_ext(re: %447: i1, we: %false: i1, wd: %false: i1, d: %d_16: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_fifo_empty_qs, %u_status_fifo_empty.qs after %1 : i1
    %fifo_full = hw.struct_extract %status["fifo_full"] : !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>
    %d_17 = hw.struct_extract %fifo_full["d"] : !hw.struct<d: i1>
    %u_status_fifo_full.qe, %u_status_fifo_full.qre, %u_status_fifo_full.q, %u_status_fifo_full.ds, %u_status_fifo_full.qs = hw.instance "u_status_fifo_full" @prim_subreg_ext(re: %447: i1, we: %false: i1, wd: %false: i1, d: %d_17: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_fifo_full_qs, %u_status_fifo_full.qs after %1 : i1
    %fifo_depth = hw.struct_extract %status["fifo_depth"] : !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>
    %d_18 = hw.struct_extract %fifo_depth["d"] : !hw.struct<d: i6>
    %u_status_fifo_depth.qe, %u_status_fifo_depth.qre, %u_status_fifo_depth.q, %u_status_fifo_depth.ds, %u_status_fifo_depth.qs = hw.instance "u_status_fifo_depth" @prim_subreg_ext_8(re: %447: i1, we: %false: i1, wd: %c0_i6: i6, d: %d_18: i6) -> (qe: i1, qre: i1, q: i6, ds: i6, qs: i6)
    llhd.drv %status_fifo_depth_qs, %u_status_fifo_depth.qs after %1 : i6
    %err_code = hw.struct_extract %hw2reg["err_code"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>
    %de_19 = hw.struct_extract %err_code["de"] : !hw.struct<d: i32, de: i1>
    %d_20 = hw.struct_extract %err_code["d"] : !hw.struct<d: i32, de: i1>
    %u_err_code.qe, %u_err_code.q, %u_err_code.ds, %u_err_code.qs = hw.instance "u_err_code" @prim_subreg_9(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %c0_i32: i32, de: %de_19: i1, d: %d_20: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %err_code_qs, %u_err_code.qs after %1 : i32
    %81 = llhd.prb %wipe_secret_we : i1
    %82 = llhd.sig.struct_extract %reg2hw["wipe_secret"] : <!hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>>
    %83 = llhd.sig.struct_extract %82["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_wipe_secret.qe, %u_wipe_secret.qre, %u_wipe_secret.q, %u_wipe_secret.ds, %u_wipe_secret.qs = hw.instance "u_wipe_secret" @prim_subreg_ext_10(re: %false: i1, we: %81: i1, wd: %u_reg_if.wdata_o: i32, d: %c0_i32: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %wipe_secret_flds_we, %u_wipe_secret.qe after %1 : i1
    llhd.drv %83, %u_wipe_secret.q after %1 : i32
    %84 = llhd.prb %key_0_we : i1
    %key = hw.struct_extract %hw2reg["key"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>
    %85 = hw.array_get %key[%c0_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_21 = hw.struct_extract %85["d"] : !hw.struct<d: i32>
    %86 = llhd.sig.struct_extract %reg2hw["key"] : <!hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>>
    %87 = llhd.sig.array_get %86[%c0_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %88 = llhd.sig.struct_extract %87["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_0.qe, %u_key_0.qre, %u_key_0.q, %u_key_0.ds, %u_key_0.qs = hw.instance "u_key_0" @prim_subreg_ext_10(re: %false: i1, we: %84: i1, wd: %u_reg_if.wdata_o: i32, d: %d_21: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_0_flds_we, %u_key_0.qe after %1 : i1
    llhd.drv %88, %u_key_0.q after %1 : i32
    %89 = llhd.prb %key_1_we : i1
    %90 = hw.array_get %key[%c1_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_22 = hw.struct_extract %90["d"] : !hw.struct<d: i32>
    %91 = llhd.sig.array_get %86[%c1_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %92 = llhd.sig.struct_extract %91["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_1.qe, %u_key_1.qre, %u_key_1.q, %u_key_1.ds, %u_key_1.qs = hw.instance "u_key_1" @prim_subreg_ext_10(re: %false: i1, we: %89: i1, wd: %u_reg_if.wdata_o: i32, d: %d_22: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_1_flds_we, %u_key_1.qe after %1 : i1
    llhd.drv %92, %u_key_1.q after %1 : i32
    %93 = llhd.prb %key_2_we : i1
    %94 = hw.array_get %key[%c2_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_23 = hw.struct_extract %94["d"] : !hw.struct<d: i32>
    %95 = llhd.sig.array_get %86[%c2_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %96 = llhd.sig.struct_extract %95["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_2.qe, %u_key_2.qre, %u_key_2.q, %u_key_2.ds, %u_key_2.qs = hw.instance "u_key_2" @prim_subreg_ext_10(re: %false: i1, we: %93: i1, wd: %u_reg_if.wdata_o: i32, d: %d_23: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_2_flds_we, %u_key_2.qe after %1 : i1
    llhd.drv %96, %u_key_2.q after %1 : i32
    %97 = llhd.prb %key_3_we : i1
    %98 = hw.array_get %key[%c3_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_24 = hw.struct_extract %98["d"] : !hw.struct<d: i32>
    %99 = llhd.sig.array_get %86[%c3_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %100 = llhd.sig.struct_extract %99["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_3.qe, %u_key_3.qre, %u_key_3.q, %u_key_3.ds, %u_key_3.qs = hw.instance "u_key_3" @prim_subreg_ext_10(re: %false: i1, we: %97: i1, wd: %u_reg_if.wdata_o: i32, d: %d_24: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_3_flds_we, %u_key_3.qe after %1 : i1
    llhd.drv %100, %u_key_3.q after %1 : i32
    %101 = llhd.prb %key_4_we : i1
    %102 = hw.array_get %key[%c4_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_25 = hw.struct_extract %102["d"] : !hw.struct<d: i32>
    %103 = llhd.sig.array_get %86[%c4_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %104 = llhd.sig.struct_extract %103["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_4.qe, %u_key_4.qre, %u_key_4.q, %u_key_4.ds, %u_key_4.qs = hw.instance "u_key_4" @prim_subreg_ext_10(re: %false: i1, we: %101: i1, wd: %u_reg_if.wdata_o: i32, d: %d_25: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_4_flds_we, %u_key_4.qe after %1 : i1
    llhd.drv %104, %u_key_4.q after %1 : i32
    %105 = llhd.prb %key_5_we : i1
    %106 = hw.array_get %key[%c5_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_26 = hw.struct_extract %106["d"] : !hw.struct<d: i32>
    %107 = llhd.sig.array_get %86[%c5_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %108 = llhd.sig.struct_extract %107["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_5.qe, %u_key_5.qre, %u_key_5.q, %u_key_5.ds, %u_key_5.qs = hw.instance "u_key_5" @prim_subreg_ext_10(re: %false: i1, we: %105: i1, wd: %u_reg_if.wdata_o: i32, d: %d_26: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_5_flds_we, %u_key_5.qe after %1 : i1
    llhd.drv %108, %u_key_5.q after %1 : i32
    %109 = llhd.prb %key_6_we : i1
    %110 = hw.array_get %key[%c6_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_27 = hw.struct_extract %110["d"] : !hw.struct<d: i32>
    %111 = llhd.sig.array_get %86[%c6_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %112 = llhd.sig.struct_extract %111["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_6.qe, %u_key_6.qre, %u_key_6.q, %u_key_6.ds, %u_key_6.qs = hw.instance "u_key_6" @prim_subreg_ext_10(re: %false: i1, we: %109: i1, wd: %u_reg_if.wdata_o: i32, d: %d_27: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_6_flds_we, %u_key_6.qe after %1 : i1
    llhd.drv %112, %u_key_6.q after %1 : i32
    %113 = llhd.prb %key_7_we : i1
    %114 = hw.array_get %key[%c7_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_28 = hw.struct_extract %114["d"] : !hw.struct<d: i32>
    %115 = llhd.sig.array_get %86[%c7_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %116 = llhd.sig.struct_extract %115["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_7.qe, %u_key_7.qre, %u_key_7.q, %u_key_7.ds, %u_key_7.qs = hw.instance "u_key_7" @prim_subreg_ext_10(re: %false: i1, we: %113: i1, wd: %u_reg_if.wdata_o: i32, d: %d_28: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_7_flds_we, %u_key_7.qe after %1 : i1
    llhd.drv %116, %u_key_7.q after %1 : i32
    %117 = llhd.prb %key_8_we : i1
    %118 = hw.array_get %key[%c8_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_29 = hw.struct_extract %118["d"] : !hw.struct<d: i32>
    %119 = llhd.sig.array_get %86[%c8_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %120 = llhd.sig.struct_extract %119["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_8.qe, %u_key_8.qre, %u_key_8.q, %u_key_8.ds, %u_key_8.qs = hw.instance "u_key_8" @prim_subreg_ext_10(re: %false: i1, we: %117: i1, wd: %u_reg_if.wdata_o: i32, d: %d_29: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_8_flds_we, %u_key_8.qe after %1 : i1
    llhd.drv %120, %u_key_8.q after %1 : i32
    %121 = llhd.prb %key_9_we : i1
    %122 = hw.array_get %key[%c9_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_30 = hw.struct_extract %122["d"] : !hw.struct<d: i32>
    %123 = llhd.sig.array_get %86[%c9_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %124 = llhd.sig.struct_extract %123["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_9.qe, %u_key_9.qre, %u_key_9.q, %u_key_9.ds, %u_key_9.qs = hw.instance "u_key_9" @prim_subreg_ext_10(re: %false: i1, we: %121: i1, wd: %u_reg_if.wdata_o: i32, d: %d_30: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_9_flds_we, %u_key_9.qe after %1 : i1
    llhd.drv %124, %u_key_9.q after %1 : i32
    %125 = llhd.prb %key_10_we : i1
    %126 = hw.array_get %key[%c10_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_31 = hw.struct_extract %126["d"] : !hw.struct<d: i32>
    %127 = llhd.sig.array_get %86[%c10_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %128 = llhd.sig.struct_extract %127["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_10.qe, %u_key_10.qre, %u_key_10.q, %u_key_10.ds, %u_key_10.qs = hw.instance "u_key_10" @prim_subreg_ext_10(re: %false: i1, we: %125: i1, wd: %u_reg_if.wdata_o: i32, d: %d_31: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_10_flds_we, %u_key_10.qe after %1 : i1
    llhd.drv %128, %u_key_10.q after %1 : i32
    %129 = llhd.prb %key_11_we : i1
    %130 = hw.array_get %key[%c11_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_32 = hw.struct_extract %130["d"] : !hw.struct<d: i32>
    %131 = llhd.sig.array_get %86[%c11_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %132 = llhd.sig.struct_extract %131["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_11.qe, %u_key_11.qre, %u_key_11.q, %u_key_11.ds, %u_key_11.qs = hw.instance "u_key_11" @prim_subreg_ext_10(re: %false: i1, we: %129: i1, wd: %u_reg_if.wdata_o: i32, d: %d_32: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_11_flds_we, %u_key_11.qe after %1 : i1
    llhd.drv %132, %u_key_11.q after %1 : i32
    %133 = llhd.prb %key_12_we : i1
    %134 = hw.array_get %key[%c12_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_33 = hw.struct_extract %134["d"] : !hw.struct<d: i32>
    %135 = llhd.sig.array_get %86[%c12_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %136 = llhd.sig.struct_extract %135["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_12.qe, %u_key_12.qre, %u_key_12.q, %u_key_12.ds, %u_key_12.qs = hw.instance "u_key_12" @prim_subreg_ext_10(re: %false: i1, we: %133: i1, wd: %u_reg_if.wdata_o: i32, d: %d_33: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_12_flds_we, %u_key_12.qe after %1 : i1
    llhd.drv %136, %u_key_12.q after %1 : i32
    %137 = llhd.prb %key_13_we : i1
    %138 = hw.array_get %key[%c13_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_34 = hw.struct_extract %138["d"] : !hw.struct<d: i32>
    %139 = llhd.sig.array_get %86[%c13_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %140 = llhd.sig.struct_extract %139["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_13.qe, %u_key_13.qre, %u_key_13.q, %u_key_13.ds, %u_key_13.qs = hw.instance "u_key_13" @prim_subreg_ext_10(re: %false: i1, we: %137: i1, wd: %u_reg_if.wdata_o: i32, d: %d_34: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_13_flds_we, %u_key_13.qe after %1 : i1
    llhd.drv %140, %u_key_13.q after %1 : i32
    %141 = llhd.prb %key_14_we : i1
    %142 = hw.array_get %key[%c14_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_35 = hw.struct_extract %142["d"] : !hw.struct<d: i32>
    %143 = llhd.sig.array_get %86[%c14_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %144 = llhd.sig.struct_extract %143["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_14.qe, %u_key_14.qre, %u_key_14.q, %u_key_14.ds, %u_key_14.qs = hw.instance "u_key_14" @prim_subreg_ext_10(re: %false: i1, we: %141: i1, wd: %u_reg_if.wdata_o: i32, d: %d_35: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_14_flds_we, %u_key_14.qe after %1 : i1
    llhd.drv %144, %u_key_14.q after %1 : i32
    %145 = llhd.prb %key_15_we : i1
    %146 = hw.array_get %key[%c15_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_36 = hw.struct_extract %146["d"] : !hw.struct<d: i32>
    %147 = llhd.sig.array_get %86[%c15_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %148 = llhd.sig.struct_extract %147["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_15.qe, %u_key_15.qre, %u_key_15.q, %u_key_15.ds, %u_key_15.qs = hw.instance "u_key_15" @prim_subreg_ext_10(re: %false: i1, we: %145: i1, wd: %u_reg_if.wdata_o: i32, d: %d_36: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_15_flds_we, %u_key_15.qe after %1 : i1
    llhd.drv %148, %u_key_15.q after %1 : i32
    %149 = llhd.prb %key_16_we : i1
    %150 = hw.array_get %key[%c-16_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_37 = hw.struct_extract %150["d"] : !hw.struct<d: i32>
    %151 = llhd.sig.array_get %86[%c-16_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %152 = llhd.sig.struct_extract %151["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_16.qe, %u_key_16.qre, %u_key_16.q, %u_key_16.ds, %u_key_16.qs = hw.instance "u_key_16" @prim_subreg_ext_10(re: %false: i1, we: %149: i1, wd: %u_reg_if.wdata_o: i32, d: %d_37: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_16_flds_we, %u_key_16.qe after %1 : i1
    llhd.drv %152, %u_key_16.q after %1 : i32
    %153 = llhd.prb %key_17_we : i1
    %154 = hw.array_get %key[%c-15_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_38 = hw.struct_extract %154["d"] : !hw.struct<d: i32>
    %155 = llhd.sig.array_get %86[%c-15_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %156 = llhd.sig.struct_extract %155["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_17.qe, %u_key_17.qre, %u_key_17.q, %u_key_17.ds, %u_key_17.qs = hw.instance "u_key_17" @prim_subreg_ext_10(re: %false: i1, we: %153: i1, wd: %u_reg_if.wdata_o: i32, d: %d_38: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_17_flds_we, %u_key_17.qe after %1 : i1
    llhd.drv %156, %u_key_17.q after %1 : i32
    %157 = llhd.prb %key_18_we : i1
    %158 = hw.array_get %key[%c-14_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_39 = hw.struct_extract %158["d"] : !hw.struct<d: i32>
    %159 = llhd.sig.array_get %86[%c-14_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %160 = llhd.sig.struct_extract %159["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_18.qe, %u_key_18.qre, %u_key_18.q, %u_key_18.ds, %u_key_18.qs = hw.instance "u_key_18" @prim_subreg_ext_10(re: %false: i1, we: %157: i1, wd: %u_reg_if.wdata_o: i32, d: %d_39: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_18_flds_we, %u_key_18.qe after %1 : i1
    llhd.drv %160, %u_key_18.q after %1 : i32
    %161 = llhd.prb %key_19_we : i1
    %162 = hw.array_get %key[%c-13_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_40 = hw.struct_extract %162["d"] : !hw.struct<d: i32>
    %163 = llhd.sig.array_get %86[%c-13_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %164 = llhd.sig.struct_extract %163["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_19.qe, %u_key_19.qre, %u_key_19.q, %u_key_19.ds, %u_key_19.qs = hw.instance "u_key_19" @prim_subreg_ext_10(re: %false: i1, we: %161: i1, wd: %u_reg_if.wdata_o: i32, d: %d_40: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_19_flds_we, %u_key_19.qe after %1 : i1
    llhd.drv %164, %u_key_19.q after %1 : i32
    %165 = llhd.prb %key_20_we : i1
    %166 = hw.array_get %key[%c-12_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_41 = hw.struct_extract %166["d"] : !hw.struct<d: i32>
    %167 = llhd.sig.array_get %86[%c-12_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %168 = llhd.sig.struct_extract %167["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_20.qe, %u_key_20.qre, %u_key_20.q, %u_key_20.ds, %u_key_20.qs = hw.instance "u_key_20" @prim_subreg_ext_10(re: %false: i1, we: %165: i1, wd: %u_reg_if.wdata_o: i32, d: %d_41: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_20_flds_we, %u_key_20.qe after %1 : i1
    llhd.drv %168, %u_key_20.q after %1 : i32
    %169 = llhd.prb %key_21_we : i1
    %170 = hw.array_get %key[%c-11_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_42 = hw.struct_extract %170["d"] : !hw.struct<d: i32>
    %171 = llhd.sig.array_get %86[%c-11_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %172 = llhd.sig.struct_extract %171["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_21.qe, %u_key_21.qre, %u_key_21.q, %u_key_21.ds, %u_key_21.qs = hw.instance "u_key_21" @prim_subreg_ext_10(re: %false: i1, we: %169: i1, wd: %u_reg_if.wdata_o: i32, d: %d_42: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_21_flds_we, %u_key_21.qe after %1 : i1
    llhd.drv %172, %u_key_21.q after %1 : i32
    %173 = llhd.prb %key_22_we : i1
    %174 = hw.array_get %key[%c-10_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_43 = hw.struct_extract %174["d"] : !hw.struct<d: i32>
    %175 = llhd.sig.array_get %86[%c-10_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %176 = llhd.sig.struct_extract %175["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_22.qe, %u_key_22.qre, %u_key_22.q, %u_key_22.ds, %u_key_22.qs = hw.instance "u_key_22" @prim_subreg_ext_10(re: %false: i1, we: %173: i1, wd: %u_reg_if.wdata_o: i32, d: %d_43: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_22_flds_we, %u_key_22.qe after %1 : i1
    llhd.drv %176, %u_key_22.q after %1 : i32
    %177 = llhd.prb %key_23_we : i1
    %178 = hw.array_get %key[%c-9_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_44 = hw.struct_extract %178["d"] : !hw.struct<d: i32>
    %179 = llhd.sig.array_get %86[%c-9_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %180 = llhd.sig.struct_extract %179["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_23.qe, %u_key_23.qre, %u_key_23.q, %u_key_23.ds, %u_key_23.qs = hw.instance "u_key_23" @prim_subreg_ext_10(re: %false: i1, we: %177: i1, wd: %u_reg_if.wdata_o: i32, d: %d_44: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_23_flds_we, %u_key_23.qe after %1 : i1
    llhd.drv %180, %u_key_23.q after %1 : i32
    %181 = llhd.prb %key_24_we : i1
    %182 = hw.array_get %key[%c-8_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_45 = hw.struct_extract %182["d"] : !hw.struct<d: i32>
    %183 = llhd.sig.array_get %86[%c-8_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %184 = llhd.sig.struct_extract %183["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_24.qe, %u_key_24.qre, %u_key_24.q, %u_key_24.ds, %u_key_24.qs = hw.instance "u_key_24" @prim_subreg_ext_10(re: %false: i1, we: %181: i1, wd: %u_reg_if.wdata_o: i32, d: %d_45: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_24_flds_we, %u_key_24.qe after %1 : i1
    llhd.drv %184, %u_key_24.q after %1 : i32
    %185 = llhd.prb %key_25_we : i1
    %186 = hw.array_get %key[%c-7_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_46 = hw.struct_extract %186["d"] : !hw.struct<d: i32>
    %187 = llhd.sig.array_get %86[%c-7_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %188 = llhd.sig.struct_extract %187["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_25.qe, %u_key_25.qre, %u_key_25.q, %u_key_25.ds, %u_key_25.qs = hw.instance "u_key_25" @prim_subreg_ext_10(re: %false: i1, we: %185: i1, wd: %u_reg_if.wdata_o: i32, d: %d_46: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_25_flds_we, %u_key_25.qe after %1 : i1
    llhd.drv %188, %u_key_25.q after %1 : i32
    %189 = llhd.prb %key_26_we : i1
    %190 = hw.array_get %key[%c-6_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_47 = hw.struct_extract %190["d"] : !hw.struct<d: i32>
    %191 = llhd.sig.array_get %86[%c-6_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %192 = llhd.sig.struct_extract %191["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_26.qe, %u_key_26.qre, %u_key_26.q, %u_key_26.ds, %u_key_26.qs = hw.instance "u_key_26" @prim_subreg_ext_10(re: %false: i1, we: %189: i1, wd: %u_reg_if.wdata_o: i32, d: %d_47: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_26_flds_we, %u_key_26.qe after %1 : i1
    llhd.drv %192, %u_key_26.q after %1 : i32
    %193 = llhd.prb %key_27_we : i1
    %194 = hw.array_get %key[%c-5_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_48 = hw.struct_extract %194["d"] : !hw.struct<d: i32>
    %195 = llhd.sig.array_get %86[%c-5_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %196 = llhd.sig.struct_extract %195["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_27.qe, %u_key_27.qre, %u_key_27.q, %u_key_27.ds, %u_key_27.qs = hw.instance "u_key_27" @prim_subreg_ext_10(re: %false: i1, we: %193: i1, wd: %u_reg_if.wdata_o: i32, d: %d_48: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_27_flds_we, %u_key_27.qe after %1 : i1
    llhd.drv %196, %u_key_27.q after %1 : i32
    %197 = llhd.prb %key_28_we : i1
    %198 = hw.array_get %key[%c-4_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_49 = hw.struct_extract %198["d"] : !hw.struct<d: i32>
    %199 = llhd.sig.array_get %86[%c-4_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %200 = llhd.sig.struct_extract %199["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_28.qe, %u_key_28.qre, %u_key_28.q, %u_key_28.ds, %u_key_28.qs = hw.instance "u_key_28" @prim_subreg_ext_10(re: %false: i1, we: %197: i1, wd: %u_reg_if.wdata_o: i32, d: %d_49: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_28_flds_we, %u_key_28.qe after %1 : i1
    llhd.drv %200, %u_key_28.q after %1 : i32
    %201 = llhd.prb %key_29_we : i1
    %202 = hw.array_get %key[%c-3_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_50 = hw.struct_extract %202["d"] : !hw.struct<d: i32>
    %203 = llhd.sig.array_get %86[%c-3_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %204 = llhd.sig.struct_extract %203["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_29.qe, %u_key_29.qre, %u_key_29.q, %u_key_29.ds, %u_key_29.qs = hw.instance "u_key_29" @prim_subreg_ext_10(re: %false: i1, we: %201: i1, wd: %u_reg_if.wdata_o: i32, d: %d_50: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_29_flds_we, %u_key_29.qe after %1 : i1
    llhd.drv %204, %u_key_29.q after %1 : i32
    %205 = llhd.prb %key_30_we : i1
    %206 = hw.array_get %key[%c-2_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_51 = hw.struct_extract %206["d"] : !hw.struct<d: i32>
    %207 = llhd.sig.array_get %86[%c-2_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %208 = llhd.sig.struct_extract %207["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_30.qe, %u_key_30.qre, %u_key_30.q, %u_key_30.ds, %u_key_30.qs = hw.instance "u_key_30" @prim_subreg_ext_10(re: %false: i1, we: %205: i1, wd: %u_reg_if.wdata_o: i32, d: %d_51: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_30_flds_we, %u_key_30.qe after %1 : i1
    llhd.drv %208, %u_key_30.q after %1 : i32
    %209 = llhd.prb %key_31_we : i1
    %210 = hw.array_get %key[%c-1_i5] : !hw.array<32xstruct<d: i32>>, i5
    %d_52 = hw.struct_extract %210["d"] : !hw.struct<d: i32>
    %211 = llhd.sig.array_get %86[%c-1_i5] : <!hw.array<32xstruct<q: i32, qe: i1>>>
    %212 = llhd.sig.struct_extract %211["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_key_31.qe, %u_key_31.qre, %u_key_31.q, %u_key_31.ds, %u_key_31.qs = hw.instance "u_key_31" @prim_subreg_ext_10(re: %false: i1, we: %209: i1, wd: %u_reg_if.wdata_o: i32, d: %d_52: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %key_31_flds_we, %u_key_31.qe after %1 : i1
    llhd.drv %212, %u_key_31.q after %1 : i32
    %213 = llhd.prb %digest_0_we : i1
    %digest = hw.struct_extract %hw2reg["digest"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>
    %214 = hw.array_get %digest[%c0_i4] : !hw.array<16xstruct<d: i32>>, i4
    %d_53 = hw.struct_extract %214["d"] : !hw.struct<d: i32>
    %215 = llhd.sig.struct_extract %reg2hw["digest"] : <!hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>>
    %216 = llhd.sig.array_get %215[%c0_i4] : <!hw.array<16xstruct<q: i32, qe: i1>>>
    %217 = llhd.sig.struct_extract %216["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_digest_0.qe, %u_digest_0.qre, %u_digest_0.q, %u_digest_0.ds, %u_digest_0.qs = hw.instance "u_digest_0" @prim_subreg_ext_10(re: %515: i1, we: %213: i1, wd: %u_reg_if.wdata_o: i32, d: %d_53: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %digest_0_flds_we, %u_digest_0.qe after %1 : i1
    llhd.drv %217, %u_digest_0.q after %1 : i32
    llhd.drv %digest_0_qs, %u_digest_0.qs after %1 : i32
    %218 = llhd.prb %digest_1_we : i1
    %219 = hw.array_get %digest[%c1_i4] : !hw.array<16xstruct<d: i32>>, i4
    %d_54 = hw.struct_extract %219["d"] : !hw.struct<d: i32>
    %220 = llhd.sig.array_get %215[%c1_i4] : <!hw.array<16xstruct<q: i32, qe: i1>>>
    %221 = llhd.sig.struct_extract %220["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_digest_1.qe, %u_digest_1.qre, %u_digest_1.q, %u_digest_1.ds, %u_digest_1.qs = hw.instance "u_digest_1" @prim_subreg_ext_10(re: %518: i1, we: %218: i1, wd: %u_reg_if.wdata_o: i32, d: %d_54: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %digest_1_flds_we, %u_digest_1.qe after %1 : i1
    llhd.drv %221, %u_digest_1.q after %1 : i32
    llhd.drv %digest_1_qs, %u_digest_1.qs after %1 : i32
    %222 = llhd.prb %digest_2_we : i1
    %223 = hw.array_get %digest[%c2_i4] : !hw.array<16xstruct<d: i32>>, i4
    %d_55 = hw.struct_extract %223["d"] : !hw.struct<d: i32>
    %224 = llhd.sig.array_get %215[%c2_i4] : <!hw.array<16xstruct<q: i32, qe: i1>>>
    %225 = llhd.sig.struct_extract %224["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_digest_2.qe, %u_digest_2.qre, %u_digest_2.q, %u_digest_2.ds, %u_digest_2.qs = hw.instance "u_digest_2" @prim_subreg_ext_10(re: %521: i1, we: %222: i1, wd: %u_reg_if.wdata_o: i32, d: %d_55: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %digest_2_flds_we, %u_digest_2.qe after %1 : i1
    llhd.drv %225, %u_digest_2.q after %1 : i32
    llhd.drv %digest_2_qs, %u_digest_2.qs after %1 : i32
    %226 = llhd.prb %digest_3_we : i1
    %227 = hw.array_get %digest[%c3_i4] : !hw.array<16xstruct<d: i32>>, i4
    %d_56 = hw.struct_extract %227["d"] : !hw.struct<d: i32>
    %228 = llhd.sig.array_get %215[%c3_i4] : <!hw.array<16xstruct<q: i32, qe: i1>>>
    %229 = llhd.sig.struct_extract %228["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_digest_3.qe, %u_digest_3.qre, %u_digest_3.q, %u_digest_3.ds, %u_digest_3.qs = hw.instance "u_digest_3" @prim_subreg_ext_10(re: %524: i1, we: %226: i1, wd: %u_reg_if.wdata_o: i32, d: %d_56: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %digest_3_flds_we, %u_digest_3.qe after %1 : i1
    llhd.drv %229, %u_digest_3.q after %1 : i32
    llhd.drv %digest_3_qs, %u_digest_3.qs after %1 : i32
    %230 = llhd.prb %digest_4_we : i1
    %231 = hw.array_get %digest[%c4_i4] : !hw.array<16xstruct<d: i32>>, i4
    %d_57 = hw.struct_extract %231["d"] : !hw.struct<d: i32>
    %232 = llhd.sig.array_get %215[%c4_i4] : <!hw.array<16xstruct<q: i32, qe: i1>>>
    %233 = llhd.sig.struct_extract %232["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_digest_4.qe, %u_digest_4.qre, %u_digest_4.q, %u_digest_4.ds, %u_digest_4.qs = hw.instance "u_digest_4" @prim_subreg_ext_10(re: %527: i1, we: %230: i1, wd: %u_reg_if.wdata_o: i32, d: %d_57: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %digest_4_flds_we, %u_digest_4.qe after %1 : i1
    llhd.drv %233, %u_digest_4.q after %1 : i32
    llhd.drv %digest_4_qs, %u_digest_4.qs after %1 : i32
    %234 = llhd.prb %digest_5_we : i1
    %235 = hw.array_get %digest[%c5_i4] : !hw.array<16xstruct<d: i32>>, i4
    %d_58 = hw.struct_extract %235["d"] : !hw.struct<d: i32>
    %236 = llhd.sig.array_get %215[%c5_i4] : <!hw.array<16xstruct<q: i32, qe: i1>>>
    %237 = llhd.sig.struct_extract %236["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_digest_5.qe, %u_digest_5.qre, %u_digest_5.q, %u_digest_5.ds, %u_digest_5.qs = hw.instance "u_digest_5" @prim_subreg_ext_10(re: %530: i1, we: %234: i1, wd: %u_reg_if.wdata_o: i32, d: %d_58: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %digest_5_flds_we, %u_digest_5.qe after %1 : i1
    llhd.drv %237, %u_digest_5.q after %1 : i32
    llhd.drv %digest_5_qs, %u_digest_5.qs after %1 : i32
    %238 = llhd.prb %digest_6_we : i1
    %239 = hw.array_get %digest[%c6_i4] : !hw.array<16xstruct<d: i32>>, i4
    %d_59 = hw.struct_extract %239["d"] : !hw.struct<d: i32>
    %240 = llhd.sig.array_get %215[%c6_i4] : <!hw.array<16xstruct<q: i32, qe: i1>>>
    %241 = llhd.sig.struct_extract %240["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_digest_6.qe, %u_digest_6.qre, %u_digest_6.q, %u_digest_6.ds, %u_digest_6.qs = hw.instance "u_digest_6" @prim_subreg_ext_10(re: %533: i1, we: %238: i1, wd: %u_reg_if.wdata_o: i32, d: %d_59: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %digest_6_flds_we, %u_digest_6.qe after %1 : i1
    llhd.drv %241, %u_digest_6.q after %1 : i32
    llhd.drv %digest_6_qs, %u_digest_6.qs after %1 : i32
    %242 = llhd.prb %digest_7_we : i1
    %243 = hw.array_get %digest[%c7_i4] : !hw.array<16xstruct<d: i32>>, i4
    %d_60 = hw.struct_extract %243["d"] : !hw.struct<d: i32>
    %244 = llhd.sig.array_get %215[%c7_i4] : <!hw.array<16xstruct<q: i32, qe: i1>>>
    %245 = llhd.sig.struct_extract %244["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_digest_7.qe, %u_digest_7.qre, %u_digest_7.q, %u_digest_7.ds, %u_digest_7.qs = hw.instance "u_digest_7" @prim_subreg_ext_10(re: %536: i1, we: %242: i1, wd: %u_reg_if.wdata_o: i32, d: %d_60: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %digest_7_flds_we, %u_digest_7.qe after %1 : i1
    llhd.drv %245, %u_digest_7.q after %1 : i32
    llhd.drv %digest_7_qs, %u_digest_7.qs after %1 : i32
    %246 = llhd.prb %digest_8_we : i1
    %247 = hw.array_get %digest[%c-8_i4] : !hw.array<16xstruct<d: i32>>, i4
    %d_61 = hw.struct_extract %247["d"] : !hw.struct<d: i32>
    %248 = llhd.sig.array_get %215[%c-8_i4] : <!hw.array<16xstruct<q: i32, qe: i1>>>
    %249 = llhd.sig.struct_extract %248["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_digest_8.qe, %u_digest_8.qre, %u_digest_8.q, %u_digest_8.ds, %u_digest_8.qs = hw.instance "u_digest_8" @prim_subreg_ext_10(re: %539: i1, we: %246: i1, wd: %u_reg_if.wdata_o: i32, d: %d_61: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %digest_8_flds_we, %u_digest_8.qe after %1 : i1
    llhd.drv %249, %u_digest_8.q after %1 : i32
    llhd.drv %digest_8_qs, %u_digest_8.qs after %1 : i32
    %250 = llhd.prb %digest_9_we : i1
    %251 = hw.array_get %digest[%c-7_i4] : !hw.array<16xstruct<d: i32>>, i4
    %d_62 = hw.struct_extract %251["d"] : !hw.struct<d: i32>
    %252 = llhd.sig.array_get %215[%c-7_i4] : <!hw.array<16xstruct<q: i32, qe: i1>>>
    %253 = llhd.sig.struct_extract %252["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_digest_9.qe, %u_digest_9.qre, %u_digest_9.q, %u_digest_9.ds, %u_digest_9.qs = hw.instance "u_digest_9" @prim_subreg_ext_10(re: %542: i1, we: %250: i1, wd: %u_reg_if.wdata_o: i32, d: %d_62: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %digest_9_flds_we, %u_digest_9.qe after %1 : i1
    llhd.drv %253, %u_digest_9.q after %1 : i32
    llhd.drv %digest_9_qs, %u_digest_9.qs after %1 : i32
    %254 = llhd.prb %digest_10_we : i1
    %255 = hw.array_get %digest[%c-6_i4] : !hw.array<16xstruct<d: i32>>, i4
    %d_63 = hw.struct_extract %255["d"] : !hw.struct<d: i32>
    %256 = llhd.sig.array_get %215[%c-6_i4] : <!hw.array<16xstruct<q: i32, qe: i1>>>
    %257 = llhd.sig.struct_extract %256["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_digest_10.qe, %u_digest_10.qre, %u_digest_10.q, %u_digest_10.ds, %u_digest_10.qs = hw.instance "u_digest_10" @prim_subreg_ext_10(re: %545: i1, we: %254: i1, wd: %u_reg_if.wdata_o: i32, d: %d_63: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %digest_10_flds_we, %u_digest_10.qe after %1 : i1
    llhd.drv %257, %u_digest_10.q after %1 : i32
    llhd.drv %digest_10_qs, %u_digest_10.qs after %1 : i32
    %258 = llhd.prb %digest_11_we : i1
    %259 = hw.array_get %digest[%c-5_i4] : !hw.array<16xstruct<d: i32>>, i4
    %d_64 = hw.struct_extract %259["d"] : !hw.struct<d: i32>
    %260 = llhd.sig.array_get %215[%c-5_i4] : <!hw.array<16xstruct<q: i32, qe: i1>>>
    %261 = llhd.sig.struct_extract %260["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_digest_11.qe, %u_digest_11.qre, %u_digest_11.q, %u_digest_11.ds, %u_digest_11.qs = hw.instance "u_digest_11" @prim_subreg_ext_10(re: %548: i1, we: %258: i1, wd: %u_reg_if.wdata_o: i32, d: %d_64: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %digest_11_flds_we, %u_digest_11.qe after %1 : i1
    llhd.drv %261, %u_digest_11.q after %1 : i32
    llhd.drv %digest_11_qs, %u_digest_11.qs after %1 : i32
    %262 = llhd.prb %digest_12_we : i1
    %263 = hw.array_get %digest[%c-4_i4] : !hw.array<16xstruct<d: i32>>, i4
    %d_65 = hw.struct_extract %263["d"] : !hw.struct<d: i32>
    %264 = llhd.sig.array_get %215[%c-4_i4] : <!hw.array<16xstruct<q: i32, qe: i1>>>
    %265 = llhd.sig.struct_extract %264["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_digest_12.qe, %u_digest_12.qre, %u_digest_12.q, %u_digest_12.ds, %u_digest_12.qs = hw.instance "u_digest_12" @prim_subreg_ext_10(re: %551: i1, we: %262: i1, wd: %u_reg_if.wdata_o: i32, d: %d_65: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %digest_12_flds_we, %u_digest_12.qe after %1 : i1
    llhd.drv %265, %u_digest_12.q after %1 : i32
    llhd.drv %digest_12_qs, %u_digest_12.qs after %1 : i32
    %266 = llhd.prb %digest_13_we : i1
    %267 = hw.array_get %digest[%c-3_i4] : !hw.array<16xstruct<d: i32>>, i4
    %d_66 = hw.struct_extract %267["d"] : !hw.struct<d: i32>
    %268 = llhd.sig.array_get %215[%c-3_i4] : <!hw.array<16xstruct<q: i32, qe: i1>>>
    %269 = llhd.sig.struct_extract %268["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_digest_13.qe, %u_digest_13.qre, %u_digest_13.q, %u_digest_13.ds, %u_digest_13.qs = hw.instance "u_digest_13" @prim_subreg_ext_10(re: %554: i1, we: %266: i1, wd: %u_reg_if.wdata_o: i32, d: %d_66: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %digest_13_flds_we, %u_digest_13.qe after %1 : i1
    llhd.drv %269, %u_digest_13.q after %1 : i32
    llhd.drv %digest_13_qs, %u_digest_13.qs after %1 : i32
    %270 = llhd.prb %digest_14_we : i1
    %271 = hw.array_get %digest[%c-2_i4] : !hw.array<16xstruct<d: i32>>, i4
    %d_67 = hw.struct_extract %271["d"] : !hw.struct<d: i32>
    %272 = llhd.sig.array_get %215[%c-2_i4] : <!hw.array<16xstruct<q: i32, qe: i1>>>
    %273 = llhd.sig.struct_extract %272["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_digest_14.qe, %u_digest_14.qre, %u_digest_14.q, %u_digest_14.ds, %u_digest_14.qs = hw.instance "u_digest_14" @prim_subreg_ext_10(re: %557: i1, we: %270: i1, wd: %u_reg_if.wdata_o: i32, d: %d_67: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %digest_14_flds_we, %u_digest_14.qe after %1 : i1
    llhd.drv %273, %u_digest_14.q after %1 : i32
    llhd.drv %digest_14_qs, %u_digest_14.qs after %1 : i32
    %274 = llhd.prb %digest_15_we : i1
    %275 = hw.array_get %digest[%c-1_i4] : !hw.array<16xstruct<d: i32>>, i4
    %d_68 = hw.struct_extract %275["d"] : !hw.struct<d: i32>
    %276 = llhd.sig.array_get %215[%c-1_i4] : <!hw.array<16xstruct<q: i32, qe: i1>>>
    %277 = llhd.sig.struct_extract %276["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_digest_15.qe, %u_digest_15.qre, %u_digest_15.q, %u_digest_15.ds, %u_digest_15.qs = hw.instance "u_digest_15" @prim_subreg_ext_10(re: %560: i1, we: %274: i1, wd: %u_reg_if.wdata_o: i32, d: %d_68: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %digest_15_flds_we, %u_digest_15.qe after %1 : i1
    llhd.drv %277, %u_digest_15.q after %1 : i32
    llhd.drv %digest_15_qs, %u_digest_15.qs after %1 : i32
    %278 = llhd.prb %msg_length_lower_we : i1
    %msg_length_lower = hw.struct_extract %hw2reg["msg_length_lower"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>
    %d_69 = hw.struct_extract %msg_length_lower["d"] : !hw.struct<d: i32>
    %279 = llhd.sig.struct_extract %reg2hw["msg_length_lower"] : <!hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>>
    %280 = llhd.sig.struct_extract %279["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_msg_length_lower.qe, %u_msg_length_lower.qre, %u_msg_length_lower.q, %u_msg_length_lower.ds, %u_msg_length_lower.qs = hw.instance "u_msg_length_lower" @prim_subreg_ext_10(re: %563: i1, we: %278: i1, wd: %u_reg_if.wdata_o: i32, d: %d_69: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %msg_length_lower_flds_we, %u_msg_length_lower.qe after %1 : i1
    llhd.drv %280, %u_msg_length_lower.q after %1 : i32
    llhd.drv %msg_length_lower_qs, %u_msg_length_lower.qs after %1 : i32
    %281 = llhd.prb %msg_length_upper_we : i1
    %msg_length_upper = hw.struct_extract %hw2reg["msg_length_upper"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>
    %d_70 = hw.struct_extract %msg_length_upper["d"] : !hw.struct<d: i32>
    %282 = llhd.sig.struct_extract %reg2hw["msg_length_upper"] : <!hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>>
    %283 = llhd.sig.struct_extract %282["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_msg_length_upper.qe, %u_msg_length_upper.qre, %u_msg_length_upper.q, %u_msg_length_upper.ds, %u_msg_length_upper.qs = hw.instance "u_msg_length_upper" @prim_subreg_ext_10(re: %566: i1, we: %281: i1, wd: %u_reg_if.wdata_o: i32, d: %d_70: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %msg_length_upper_flds_we, %u_msg_length_upper.qe after %1 : i1
    llhd.drv %283, %u_msg_length_upper.q after %1 : i32
    llhd.drv %msg_length_upper_qs, %u_msg_length_upper.qs after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %605 = llhd.prb %clk_i_0 : i1
      %606 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%5, %6 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %607 = llhd.prb %clk_i_0 : i1
      %608 = comb.xor bin %605, %true : i1
      %609 = comb.and bin %608, %607 : i1
      %610 = llhd.prb %rst_ni_1 : i1
      %611 = comb.xor bin %610, %true : i1
      %612 = comb.and bin %606, %611 : i1
      %613 = comb.or bin %609, %612 : i1
      cf.cond_br %613, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %614 = llhd.prb %rst_ni_1 : i1
      %615 = comb.xor %614, %true : i1
      cf.cond_br %615, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %err_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %616 = llhd.prb %intg_err : i1
      %617 = llhd.prb %reg_we_err : i1
      %618 = comb.or %616, %617 : i1
      cf.cond_br %618, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %err_q, %true after %0 : i1
      cf.br ^bb1
    }
    %284 = llhd.prb %err_q : i1
    %285 = llhd.prb %intg_err : i1
    %286 = llhd.prb %reg_we_err : i1
    %287 = comb.or %284, %285, %286 : i1
    %288 = hw.array_get %u_socket.tl_d_o[%false] {sv.namehint = "tl_reg_h2d"} : !hw.array<2xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, i1
    %289 = llhd.sig.array_get %tl_socket_d2h[%false] : <!hw.array<2xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>>
    llhd.drv %289, %u_reg_if.tl_o after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %290 = hw.array_get %u_socket.tl_d_o[%true] : !hw.array<2xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, i1
    %291 = llhd.sig.array_get %tl_socket_d2h[%true] : <!hw.array<2xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>>
    llhd.drv %291, %tl_win_i after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb3
      %605 = llhd.prb %tl_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_address = hw.struct_extract %605["a_address"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %606 = comb.extract %a_address from 0 : (i32) -> i13
      %607 = comb.concat %c0_i19, %606 : i19, i13
      %608 = comb.extract %a_address from 12 : (i32) -> i1
      %609 = comb.icmp ult %607, %c8192_i32 : i32
      %610 = comb.and %608, %609 : i1
      %611 = comb.xor %610, %true : i1
      llhd.drv %reg_steer, %611 after %1 : i1
      %612 = llhd.prb %intg_err : i1
      cf.cond_br %612, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %reg_steer, %true after %1 : i1
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      llhd.wait (%7, %13, %285 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, i1, i1), ^bb1
    }
    %292 = llhd.prb %reg_rdata_next {sv.namehint = "reg_rdata"} : i32
    %293 = llhd.prb %wr_err : i1
    %294 = comb.or %423, %293, %285 {sv.namehint = "reg_error"} : i1
    %295 = llhd.prb %intr_test_flds_we : i3
    %296 = comb.icmp eq %295, %c-1_i3 {sv.namehint = "intr_test_qe"} : i3
    %297 = llhd.sig.struct_extract %33["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %297, %296 after %1 : i1
    %298 = llhd.sig.struct_extract %36["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %298, %296 after %1 : i1
    %299 = llhd.sig.struct_extract %39["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %299, %296 after %1 : i1
    %300 = llhd.prb %alert_test_flds_we {sv.namehint = "alert_test_qe"} : i1
    %301 = llhd.sig.struct_extract %42["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %301, %300 after %1 : i1
    %302 = llhd.prb %cfg_flds_we : i7
    %303 = comb.icmp eq %302, %c-1_i7 {sv.namehint = "cfg_qe"} : i7
    %304 = llhd.sig.struct_extract %47["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %304, %303 after %1 : i1
    %305 = llhd.sig.struct_extract %50["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %305, %303 after %1 : i1
    %306 = llhd.sig.struct_extract %53["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %306, %303 after %1 : i1
    %307 = llhd.sig.struct_extract %56["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %307, %303 after %1 : i1
    %308 = llhd.sig.struct_extract %59["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %308, %303 after %1 : i1
    %309 = llhd.sig.struct_extract %62["qe"] : <!hw.struct<q: i4, qe: i1>>
    llhd.drv %309, %303 after %1 : i1
    %310 = llhd.sig.struct_extract %65["qe"] : <!hw.struct<q: i6, qe: i1>>
    llhd.drv %310, %303 after %1 : i1
    %311 = llhd.prb %cmd_flds_we : i4
    %312 = comb.icmp eq %311, %c-1_i4 {sv.namehint = "cmd_qe"} : i4
    %313 = llhd.sig.struct_extract %70["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %313, %312 after %1 : i1
    %314 = llhd.sig.struct_extract %73["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %314, %312 after %1 : i1
    %315 = llhd.sig.struct_extract %76["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %315, %312 after %1 : i1
    %316 = llhd.sig.struct_extract %79["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %316, %312 after %1 : i1
    %317 = llhd.prb %wipe_secret_flds_we {sv.namehint = "wipe_secret_qe"} : i1
    %318 = llhd.sig.struct_extract %82["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %318, %317 after %1 : i1
    %319 = llhd.prb %key_0_flds_we {sv.namehint = "key_0_qe"} : i1
    %320 = llhd.sig.struct_extract %87["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %320, %319 after %1 : i1
    %321 = llhd.prb %key_1_flds_we {sv.namehint = "key_1_qe"} : i1
    %322 = llhd.sig.struct_extract %91["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %322, %321 after %1 : i1
    %323 = llhd.prb %key_2_flds_we {sv.namehint = "key_2_qe"} : i1
    %324 = llhd.sig.struct_extract %95["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %324, %323 after %1 : i1
    %325 = llhd.prb %key_3_flds_we {sv.namehint = "key_3_qe"} : i1
    %326 = llhd.sig.struct_extract %99["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %326, %325 after %1 : i1
    %327 = llhd.prb %key_4_flds_we {sv.namehint = "key_4_qe"} : i1
    %328 = llhd.sig.struct_extract %103["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %328, %327 after %1 : i1
    %329 = llhd.prb %key_5_flds_we {sv.namehint = "key_5_qe"} : i1
    %330 = llhd.sig.struct_extract %107["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %330, %329 after %1 : i1
    %331 = llhd.prb %key_6_flds_we {sv.namehint = "key_6_qe"} : i1
    %332 = llhd.sig.struct_extract %111["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %332, %331 after %1 : i1
    %333 = llhd.prb %key_7_flds_we {sv.namehint = "key_7_qe"} : i1
    %334 = llhd.sig.struct_extract %115["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %334, %333 after %1 : i1
    %335 = llhd.prb %key_8_flds_we {sv.namehint = "key_8_qe"} : i1
    %336 = llhd.sig.struct_extract %119["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %336, %335 after %1 : i1
    %337 = llhd.prb %key_9_flds_we {sv.namehint = "key_9_qe"} : i1
    %338 = llhd.sig.struct_extract %123["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %338, %337 after %1 : i1
    %339 = llhd.prb %key_10_flds_we {sv.namehint = "key_10_qe"} : i1
    %340 = llhd.sig.struct_extract %127["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %340, %339 after %1 : i1
    %341 = llhd.prb %key_11_flds_we {sv.namehint = "key_11_qe"} : i1
    %342 = llhd.sig.struct_extract %131["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %342, %341 after %1 : i1
    %343 = llhd.prb %key_12_flds_we {sv.namehint = "key_12_qe"} : i1
    %344 = llhd.sig.struct_extract %135["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %344, %343 after %1 : i1
    %345 = llhd.prb %key_13_flds_we {sv.namehint = "key_13_qe"} : i1
    %346 = llhd.sig.struct_extract %139["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %346, %345 after %1 : i1
    %347 = llhd.prb %key_14_flds_we {sv.namehint = "key_14_qe"} : i1
    %348 = llhd.sig.struct_extract %143["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %348, %347 after %1 : i1
    %349 = llhd.prb %key_15_flds_we {sv.namehint = "key_15_qe"} : i1
    %350 = llhd.sig.struct_extract %147["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %350, %349 after %1 : i1
    %351 = llhd.prb %key_16_flds_we {sv.namehint = "key_16_qe"} : i1
    %352 = llhd.sig.struct_extract %151["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %352, %351 after %1 : i1
    %353 = llhd.prb %key_17_flds_we {sv.namehint = "key_17_qe"} : i1
    %354 = llhd.sig.struct_extract %155["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %354, %353 after %1 : i1
    %355 = llhd.prb %key_18_flds_we {sv.namehint = "key_18_qe"} : i1
    %356 = llhd.sig.struct_extract %159["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %356, %355 after %1 : i1
    %357 = llhd.prb %key_19_flds_we {sv.namehint = "key_19_qe"} : i1
    %358 = llhd.sig.struct_extract %163["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %358, %357 after %1 : i1
    %359 = llhd.prb %key_20_flds_we {sv.namehint = "key_20_qe"} : i1
    %360 = llhd.sig.struct_extract %167["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %360, %359 after %1 : i1
    %361 = llhd.prb %key_21_flds_we {sv.namehint = "key_21_qe"} : i1
    %362 = llhd.sig.struct_extract %171["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %362, %361 after %1 : i1
    %363 = llhd.prb %key_22_flds_we {sv.namehint = "key_22_qe"} : i1
    %364 = llhd.sig.struct_extract %175["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %364, %363 after %1 : i1
    %365 = llhd.prb %key_23_flds_we {sv.namehint = "key_23_qe"} : i1
    %366 = llhd.sig.struct_extract %179["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %366, %365 after %1 : i1
    %367 = llhd.prb %key_24_flds_we {sv.namehint = "key_24_qe"} : i1
    %368 = llhd.sig.struct_extract %183["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %368, %367 after %1 : i1
    %369 = llhd.prb %key_25_flds_we {sv.namehint = "key_25_qe"} : i1
    %370 = llhd.sig.struct_extract %187["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %370, %369 after %1 : i1
    %371 = llhd.prb %key_26_flds_we {sv.namehint = "key_26_qe"} : i1
    %372 = llhd.sig.struct_extract %191["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %372, %371 after %1 : i1
    %373 = llhd.prb %key_27_flds_we {sv.namehint = "key_27_qe"} : i1
    %374 = llhd.sig.struct_extract %195["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %374, %373 after %1 : i1
    %375 = llhd.prb %key_28_flds_we {sv.namehint = "key_28_qe"} : i1
    %376 = llhd.sig.struct_extract %199["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %376, %375 after %1 : i1
    %377 = llhd.prb %key_29_flds_we {sv.namehint = "key_29_qe"} : i1
    %378 = llhd.sig.struct_extract %203["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %378, %377 after %1 : i1
    %379 = llhd.prb %key_30_flds_we {sv.namehint = "key_30_qe"} : i1
    %380 = llhd.sig.struct_extract %207["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %380, %379 after %1 : i1
    %381 = llhd.prb %key_31_flds_we {sv.namehint = "key_31_qe"} : i1
    %382 = llhd.sig.struct_extract %211["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %382, %381 after %1 : i1
    %383 = llhd.prb %digest_0_flds_we {sv.namehint = "digest_0_qe"} : i1
    %384 = llhd.sig.struct_extract %216["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %384, %383 after %1 : i1
    %385 = llhd.prb %digest_1_flds_we {sv.namehint = "digest_1_qe"} : i1
    %386 = llhd.sig.struct_extract %220["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %386, %385 after %1 : i1
    %387 = llhd.prb %digest_2_flds_we {sv.namehint = "digest_2_qe"} : i1
    %388 = llhd.sig.struct_extract %224["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %388, %387 after %1 : i1
    %389 = llhd.prb %digest_3_flds_we {sv.namehint = "digest_3_qe"} : i1
    %390 = llhd.sig.struct_extract %228["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %390, %389 after %1 : i1
    %391 = llhd.prb %digest_4_flds_we {sv.namehint = "digest_4_qe"} : i1
    %392 = llhd.sig.struct_extract %232["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %392, %391 after %1 : i1
    %393 = llhd.prb %digest_5_flds_we {sv.namehint = "digest_5_qe"} : i1
    %394 = llhd.sig.struct_extract %236["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %394, %393 after %1 : i1
    %395 = llhd.prb %digest_6_flds_we {sv.namehint = "digest_6_qe"} : i1
    %396 = llhd.sig.struct_extract %240["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %396, %395 after %1 : i1
    %397 = llhd.prb %digest_7_flds_we {sv.namehint = "digest_7_qe"} : i1
    %398 = llhd.sig.struct_extract %244["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %398, %397 after %1 : i1
    %399 = llhd.prb %digest_8_flds_we {sv.namehint = "digest_8_qe"} : i1
    %400 = llhd.sig.struct_extract %248["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %400, %399 after %1 : i1
    %401 = llhd.prb %digest_9_flds_we {sv.namehint = "digest_9_qe"} : i1
    %402 = llhd.sig.struct_extract %252["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %402, %401 after %1 : i1
    %403 = llhd.prb %digest_10_flds_we {sv.namehint = "digest_10_qe"} : i1
    %404 = llhd.sig.struct_extract %256["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %404, %403 after %1 : i1
    %405 = llhd.prb %digest_11_flds_we {sv.namehint = "digest_11_qe"} : i1
    %406 = llhd.sig.struct_extract %260["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %406, %405 after %1 : i1
    %407 = llhd.prb %digest_12_flds_we {sv.namehint = "digest_12_qe"} : i1
    %408 = llhd.sig.struct_extract %264["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %408, %407 after %1 : i1
    %409 = llhd.prb %digest_13_flds_we {sv.namehint = "digest_13_qe"} : i1
    %410 = llhd.sig.struct_extract %268["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %410, %409 after %1 : i1
    %411 = llhd.prb %digest_14_flds_we {sv.namehint = "digest_14_qe"} : i1
    %412 = llhd.sig.struct_extract %272["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %412, %411 after %1 : i1
    %413 = llhd.prb %digest_15_flds_we {sv.namehint = "digest_15_qe"} : i1
    %414 = llhd.sig.struct_extract %276["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %414, %413 after %1 : i1
    %415 = llhd.prb %msg_length_lower_flds_we {sv.namehint = "msg_length_lower_qe"} : i1
    %416 = llhd.sig.struct_extract %279["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %416, %415 after %1 : i1
    %417 = llhd.prb %msg_length_upper_flds_we {sv.namehint = "msg_length_upper_qe"} : i1
    %418 = llhd.sig.struct_extract %282["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %418, %417 after %1 : i1
    %419 = llhd.prb %addr_hit : i59
    %420 = llhd.prb %reg_addr : i13
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %605 = llhd.sig.extract %addr_hit from %c0_i6 : <i59> -> <i1>
      %606 = llhd.prb %reg_addr : i13
      %607 = comb.icmp eq %606, %c0_i13 : i13
      llhd.drv %605, %607 after %1 : i1
      %608 = llhd.sig.extract %addr_hit from %c1_i6 : <i59> -> <i1>
      %609 = llhd.prb %reg_addr : i13
      %610 = comb.icmp eq %609, %c4_i13 : i13
      llhd.drv %608, %610 after %1 : i1
      %611 = llhd.sig.extract %addr_hit from %c2_i6 : <i59> -> <i1>
      %612 = llhd.prb %reg_addr : i13
      %613 = comb.icmp eq %612, %c8_i13 : i13
      llhd.drv %611, %613 after %1 : i1
      %614 = llhd.sig.extract %addr_hit from %c3_i6 : <i59> -> <i1>
      %615 = llhd.prb %reg_addr : i13
      %616 = comb.icmp eq %615, %c12_i13 : i13
      llhd.drv %614, %616 after %1 : i1
      %617 = llhd.sig.extract %addr_hit from %c4_i6 : <i59> -> <i1>
      %618 = llhd.prb %reg_addr : i13
      %619 = comb.icmp eq %618, %c16_i13 : i13
      llhd.drv %617, %619 after %1 : i1
      %620 = llhd.sig.extract %addr_hit from %c5_i6 : <i59> -> <i1>
      %621 = llhd.prb %reg_addr : i13
      %622 = comb.icmp eq %621, %c20_i13 : i13
      llhd.drv %620, %622 after %1 : i1
      %623 = llhd.sig.extract %addr_hit from %c6_i6 : <i59> -> <i1>
      %624 = llhd.prb %reg_addr : i13
      %625 = comb.icmp eq %624, %c24_i13 : i13
      llhd.drv %623, %625 after %1 : i1
      %626 = llhd.sig.extract %addr_hit from %c7_i6 : <i59> -> <i1>
      %627 = llhd.prb %reg_addr : i13
      %628 = comb.icmp eq %627, %c28_i13 : i13
      llhd.drv %626, %628 after %1 : i1
      %629 = llhd.sig.extract %addr_hit from %c8_i6 : <i59> -> <i1>
      %630 = llhd.prb %reg_addr : i13
      %631 = comb.icmp eq %630, %c32_i13 : i13
      llhd.drv %629, %631 after %1 : i1
      %632 = llhd.sig.extract %addr_hit from %c9_i6 : <i59> -> <i1>
      %633 = llhd.prb %reg_addr : i13
      %634 = comb.icmp eq %633, %c36_i13 : i13
      llhd.drv %632, %634 after %1 : i1
      %635 = llhd.sig.extract %addr_hit from %c10_i6 : <i59> -> <i1>
      %636 = llhd.prb %reg_addr : i13
      %637 = comb.icmp eq %636, %c40_i13 : i13
      llhd.drv %635, %637 after %1 : i1
      %638 = llhd.sig.extract %addr_hit from %c11_i6 : <i59> -> <i1>
      %639 = llhd.prb %reg_addr : i13
      %640 = comb.icmp eq %639, %c44_i13 : i13
      llhd.drv %638, %640 after %1 : i1
      %641 = llhd.sig.extract %addr_hit from %c12_i6 : <i59> -> <i1>
      %642 = llhd.prb %reg_addr : i13
      %643 = comb.icmp eq %642, %c48_i13 : i13
      llhd.drv %641, %643 after %1 : i1
      %644 = llhd.sig.extract %addr_hit from %c13_i6 : <i59> -> <i1>
      %645 = llhd.prb %reg_addr : i13
      %646 = comb.icmp eq %645, %c52_i13 : i13
      llhd.drv %644, %646 after %1 : i1
      %647 = llhd.sig.extract %addr_hit from %c14_i6 : <i59> -> <i1>
      %648 = llhd.prb %reg_addr : i13
      %649 = comb.icmp eq %648, %c56_i13 : i13
      llhd.drv %647, %649 after %1 : i1
      %650 = llhd.sig.extract %addr_hit from %c15_i6 : <i59> -> <i1>
      %651 = llhd.prb %reg_addr : i13
      %652 = comb.icmp eq %651, %c60_i13 : i13
      llhd.drv %650, %652 after %1 : i1
      %653 = llhd.sig.extract %addr_hit from %c16_i6 : <i59> -> <i1>
      %654 = llhd.prb %reg_addr : i13
      %655 = comb.icmp eq %654, %c64_i13 : i13
      llhd.drv %653, %655 after %1 : i1
      %656 = llhd.sig.extract %addr_hit from %c17_i6 : <i59> -> <i1>
      %657 = llhd.prb %reg_addr : i13
      %658 = comb.icmp eq %657, %c68_i13 : i13
      llhd.drv %656, %658 after %1 : i1
      %659 = llhd.sig.extract %addr_hit from %c18_i6 : <i59> -> <i1>
      %660 = llhd.prb %reg_addr : i13
      %661 = comb.icmp eq %660, %c72_i13 : i13
      llhd.drv %659, %661 after %1 : i1
      %662 = llhd.sig.extract %addr_hit from %c19_i6 : <i59> -> <i1>
      %663 = llhd.prb %reg_addr : i13
      %664 = comb.icmp eq %663, %c76_i13 : i13
      llhd.drv %662, %664 after %1 : i1
      %665 = llhd.sig.extract %addr_hit from %c20_i6 : <i59> -> <i1>
      %666 = llhd.prb %reg_addr : i13
      %667 = comb.icmp eq %666, %c80_i13 : i13
      llhd.drv %665, %667 after %1 : i1
      %668 = llhd.sig.extract %addr_hit from %c21_i6 : <i59> -> <i1>
      %669 = llhd.prb %reg_addr : i13
      %670 = comb.icmp eq %669, %c84_i13 : i13
      llhd.drv %668, %670 after %1 : i1
      %671 = llhd.sig.extract %addr_hit from %c22_i6 : <i59> -> <i1>
      %672 = llhd.prb %reg_addr : i13
      %673 = comb.icmp eq %672, %c88_i13 : i13
      llhd.drv %671, %673 after %1 : i1
      %674 = llhd.sig.extract %addr_hit from %c23_i6 : <i59> -> <i1>
      %675 = llhd.prb %reg_addr : i13
      %676 = comb.icmp eq %675, %c92_i13 : i13
      llhd.drv %674, %676 after %1 : i1
      %677 = llhd.sig.extract %addr_hit from %c24_i6 : <i59> -> <i1>
      %678 = llhd.prb %reg_addr : i13
      %679 = comb.icmp eq %678, %c96_i13 : i13
      llhd.drv %677, %679 after %1 : i1
      %680 = llhd.sig.extract %addr_hit from %c25_i6 : <i59> -> <i1>
      %681 = llhd.prb %reg_addr : i13
      %682 = comb.icmp eq %681, %c100_i13 : i13
      llhd.drv %680, %682 after %1 : i1
      %683 = llhd.sig.extract %addr_hit from %c26_i6 : <i59> -> <i1>
      %684 = llhd.prb %reg_addr : i13
      %685 = comb.icmp eq %684, %c104_i13 : i13
      llhd.drv %683, %685 after %1 : i1
      %686 = llhd.sig.extract %addr_hit from %c27_i6 : <i59> -> <i1>
      %687 = llhd.prb %reg_addr : i13
      %688 = comb.icmp eq %687, %c108_i13 : i13
      llhd.drv %686, %688 after %1 : i1
      %689 = llhd.sig.extract %addr_hit from %c28_i6 : <i59> -> <i1>
      %690 = llhd.prb %reg_addr : i13
      %691 = comb.icmp eq %690, %c112_i13 : i13
      llhd.drv %689, %691 after %1 : i1
      %692 = llhd.sig.extract %addr_hit from %c29_i6 : <i59> -> <i1>
      %693 = llhd.prb %reg_addr : i13
      %694 = comb.icmp eq %693, %c116_i13 : i13
      llhd.drv %692, %694 after %1 : i1
      %695 = llhd.sig.extract %addr_hit from %c30_i6 : <i59> -> <i1>
      %696 = llhd.prb %reg_addr : i13
      %697 = comb.icmp eq %696, %c120_i13 : i13
      llhd.drv %695, %697 after %1 : i1
      %698 = llhd.sig.extract %addr_hit from %c31_i6 : <i59> -> <i1>
      %699 = llhd.prb %reg_addr : i13
      %700 = comb.icmp eq %699, %c124_i13 : i13
      llhd.drv %698, %700 after %1 : i1
      %701 = llhd.sig.extract %addr_hit from %c-32_i6 : <i59> -> <i1>
      %702 = llhd.prb %reg_addr : i13
      %703 = comb.icmp eq %702, %c128_i13 : i13
      llhd.drv %701, %703 after %1 : i1
      %704 = llhd.sig.extract %addr_hit from %c-31_i6 : <i59> -> <i1>
      %705 = llhd.prb %reg_addr : i13
      %706 = comb.icmp eq %705, %c132_i13 : i13
      llhd.drv %704, %706 after %1 : i1
      %707 = llhd.sig.extract %addr_hit from %c-30_i6 : <i59> -> <i1>
      %708 = llhd.prb %reg_addr : i13
      %709 = comb.icmp eq %708, %c136_i13 : i13
      llhd.drv %707, %709 after %1 : i1
      %710 = llhd.sig.extract %addr_hit from %c-29_i6 : <i59> -> <i1>
      %711 = llhd.prb %reg_addr : i13
      %712 = comb.icmp eq %711, %c140_i13 : i13
      llhd.drv %710, %712 after %1 : i1
      %713 = llhd.sig.extract %addr_hit from %c-28_i6 : <i59> -> <i1>
      %714 = llhd.prb %reg_addr : i13
      %715 = comb.icmp eq %714, %c144_i13 : i13
      llhd.drv %713, %715 after %1 : i1
      %716 = llhd.sig.extract %addr_hit from %c-27_i6 : <i59> -> <i1>
      %717 = llhd.prb %reg_addr : i13
      %718 = comb.icmp eq %717, %c148_i13 : i13
      llhd.drv %716, %718 after %1 : i1
      %719 = llhd.sig.extract %addr_hit from %c-26_i6 : <i59> -> <i1>
      %720 = llhd.prb %reg_addr : i13
      %721 = comb.icmp eq %720, %c152_i13 : i13
      llhd.drv %719, %721 after %1 : i1
      %722 = llhd.sig.extract %addr_hit from %c-25_i6 : <i59> -> <i1>
      %723 = llhd.prb %reg_addr : i13
      %724 = comb.icmp eq %723, %c156_i13 : i13
      llhd.drv %722, %724 after %1 : i1
      %725 = llhd.sig.extract %addr_hit from %c-24_i6 : <i59> -> <i1>
      %726 = llhd.prb %reg_addr : i13
      %727 = comb.icmp eq %726, %c160_i13 : i13
      llhd.drv %725, %727 after %1 : i1
      %728 = llhd.sig.extract %addr_hit from %c-23_i6 : <i59> -> <i1>
      %729 = llhd.prb %reg_addr : i13
      %730 = comb.icmp eq %729, %c164_i13 : i13
      llhd.drv %728, %730 after %1 : i1
      %731 = llhd.sig.extract %addr_hit from %c-22_i6 : <i59> -> <i1>
      %732 = llhd.prb %reg_addr : i13
      %733 = comb.icmp eq %732, %c168_i13 : i13
      llhd.drv %731, %733 after %1 : i1
      %734 = llhd.sig.extract %addr_hit from %c-21_i6 : <i59> -> <i1>
      %735 = llhd.prb %reg_addr : i13
      %736 = comb.icmp eq %735, %c172_i13 : i13
      llhd.drv %734, %736 after %1 : i1
      %737 = llhd.sig.extract %addr_hit from %c-20_i6 : <i59> -> <i1>
      %738 = llhd.prb %reg_addr : i13
      %739 = comb.icmp eq %738, %c176_i13 : i13
      llhd.drv %737, %739 after %1 : i1
      %740 = llhd.sig.extract %addr_hit from %c-19_i6 : <i59> -> <i1>
      %741 = llhd.prb %reg_addr : i13
      %742 = comb.icmp eq %741, %c180_i13 : i13
      llhd.drv %740, %742 after %1 : i1
      %743 = llhd.sig.extract %addr_hit from %c-18_i6 : <i59> -> <i1>
      %744 = llhd.prb %reg_addr : i13
      %745 = comb.icmp eq %744, %c184_i13 : i13
      llhd.drv %743, %745 after %1 : i1
      %746 = llhd.sig.extract %addr_hit from %c-17_i6 : <i59> -> <i1>
      %747 = llhd.prb %reg_addr : i13
      %748 = comb.icmp eq %747, %c188_i13 : i13
      llhd.drv %746, %748 after %1 : i1
      %749 = llhd.sig.extract %addr_hit from %c-16_i6 : <i59> -> <i1>
      %750 = llhd.prb %reg_addr : i13
      %751 = comb.icmp eq %750, %c192_i13 : i13
      llhd.drv %749, %751 after %1 : i1
      %752 = llhd.sig.extract %addr_hit from %c-15_i6 : <i59> -> <i1>
      %753 = llhd.prb %reg_addr : i13
      %754 = comb.icmp eq %753, %c196_i13 : i13
      llhd.drv %752, %754 after %1 : i1
      %755 = llhd.sig.extract %addr_hit from %c-14_i6 : <i59> -> <i1>
      %756 = llhd.prb %reg_addr : i13
      %757 = comb.icmp eq %756, %c200_i13 : i13
      llhd.drv %755, %757 after %1 : i1
      %758 = llhd.sig.extract %addr_hit from %c-13_i6 : <i59> -> <i1>
      %759 = llhd.prb %reg_addr : i13
      %760 = comb.icmp eq %759, %c204_i13 : i13
      llhd.drv %758, %760 after %1 : i1
      %761 = llhd.sig.extract %addr_hit from %c-12_i6 : <i59> -> <i1>
      %762 = llhd.prb %reg_addr : i13
      %763 = comb.icmp eq %762, %c208_i13 : i13
      llhd.drv %761, %763 after %1 : i1
      %764 = llhd.sig.extract %addr_hit from %c-11_i6 : <i59> -> <i1>
      %765 = llhd.prb %reg_addr : i13
      %766 = comb.icmp eq %765, %c212_i13 : i13
      llhd.drv %764, %766 after %1 : i1
      %767 = llhd.sig.extract %addr_hit from %c-10_i6 : <i59> -> <i1>
      %768 = llhd.prb %reg_addr : i13
      %769 = comb.icmp eq %768, %c216_i13 : i13
      llhd.drv %767, %769 after %1 : i1
      %770 = llhd.sig.extract %addr_hit from %c-9_i6 : <i59> -> <i1>
      %771 = llhd.prb %reg_addr : i13
      %772 = comb.icmp eq %771, %c220_i13 : i13
      llhd.drv %770, %772 after %1 : i1
      %773 = llhd.sig.extract %addr_hit from %c-8_i6 : <i59> -> <i1>
      %774 = llhd.prb %reg_addr : i13
      %775 = comb.icmp eq %774, %c224_i13 : i13
      llhd.drv %773, %775 after %1 : i1
      %776 = llhd.sig.extract %addr_hit from %c-7_i6 : <i59> -> <i1>
      %777 = llhd.prb %reg_addr : i13
      %778 = comb.icmp eq %777, %c228_i13 : i13
      llhd.drv %776, %778 after %1 : i1
      %779 = llhd.sig.extract %addr_hit from %c-6_i6 : <i59> -> <i1>
      %780 = llhd.prb %reg_addr : i13
      %781 = comb.icmp eq %780, %c232_i13 : i13
      llhd.drv %779, %781 after %1 : i1
      llhd.wait (%419, %420 : i59, i13), ^bb1
    }
    %421 = comb.or %u_reg_if.re_o, %9 : i1
    %422 = comb.icmp eq %419, %c0_i59 : i59
    %423 = comb.and %421, %422 {sv.namehint = "addrmiss"} : i1
    %424 = llhd.prb %reg_be : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %605 = llhd.prb %reg_we : i1
      %606 = llhd.prb %addr_hit : i59
      %607 = comb.extract %606 from 0 : (i59) -> i1
      %608 = llhd.prb %reg_be : i4
      %609 = comb.extract %608 from 0 : (i4) -> i2
      %610 = comb.extract %608 from 0 : (i4) -> i1
      %611 = comb.xor %610, %true : i1
      %612 = comb.and %607, %611 : i1
      %613 = comb.extract %606 from 1 : (i59) -> i1
      %614 = comb.and %613, %611 : i1
      %615 = comb.extract %606 from 2 : (i59) -> i1
      %616 = comb.and %615, %611 : i1
      %617 = comb.extract %606 from 3 : (i59) -> i1
      %618 = comb.and %617, %611 : i1
      %619 = comb.extract %606 from 4 : (i59) -> i1
      %620 = comb.icmp ne %609, %c-1_i2 : i2
      %621 = comb.and %619, %620 : i1
      %622 = comb.extract %606 from 5 : (i59) -> i1
      %623 = comb.and %622, %611 : i1
      %624 = comb.extract %606 from 6 : (i59) -> i1
      %625 = comb.icmp ne %609, %c-1_i2 : i2
      %626 = comb.and %624, %625 : i1
      %627 = comb.extract %606 from 7 : (i59) -> i1
      %628 = comb.icmp ne %608, %c-1_i4 : i4
      %629 = comb.and %627, %628 : i1
      %630 = comb.extract %606 from 8 : (i59) -> i1
      %631 = comb.icmp ne %608, %c-1_i4 : i4
      %632 = comb.and %630, %631 : i1
      %633 = comb.extract %606 from 9 : (i59) -> i1
      %634 = comb.icmp ne %608, %c-1_i4 : i4
      %635 = comb.and %633, %634 : i1
      %636 = comb.extract %606 from 10 : (i59) -> i1
      %637 = comb.icmp ne %608, %c-1_i4 : i4
      %638 = comb.and %636, %637 : i1
      %639 = comb.extract %606 from 11 : (i59) -> i1
      %640 = comb.icmp ne %608, %c-1_i4 : i4
      %641 = comb.and %639, %640 : i1
      %642 = comb.extract %606 from 12 : (i59) -> i1
      %643 = comb.icmp ne %608, %c-1_i4 : i4
      %644 = comb.and %642, %643 : i1
      %645 = comb.extract %606 from 13 : (i59) -> i1
      %646 = comb.icmp ne %608, %c-1_i4 : i4
      %647 = comb.and %645, %646 : i1
      %648 = comb.extract %606 from 14 : (i59) -> i1
      %649 = comb.icmp ne %608, %c-1_i4 : i4
      %650 = comb.and %648, %649 : i1
      %651 = comb.extract %606 from 15 : (i59) -> i1
      %652 = comb.icmp ne %608, %c-1_i4 : i4
      %653 = comb.and %651, %652 : i1
      %654 = comb.extract %606 from 16 : (i59) -> i1
      %655 = comb.icmp ne %608, %c-1_i4 : i4
      %656 = comb.and %654, %655 : i1
      %657 = comb.extract %606 from 17 : (i59) -> i1
      %658 = comb.icmp ne %608, %c-1_i4 : i4
      %659 = comb.and %657, %658 : i1
      %660 = comb.extract %606 from 18 : (i59) -> i1
      %661 = comb.icmp ne %608, %c-1_i4 : i4
      %662 = comb.and %660, %661 : i1
      %663 = comb.extract %606 from 19 : (i59) -> i1
      %664 = comb.icmp ne %608, %c-1_i4 : i4
      %665 = comb.and %663, %664 : i1
      %666 = comb.extract %606 from 20 : (i59) -> i1
      %667 = comb.icmp ne %608, %c-1_i4 : i4
      %668 = comb.and %666, %667 : i1
      %669 = comb.extract %606 from 21 : (i59) -> i1
      %670 = comb.icmp ne %608, %c-1_i4 : i4
      %671 = comb.and %669, %670 : i1
      %672 = comb.extract %606 from 22 : (i59) -> i1
      %673 = comb.icmp ne %608, %c-1_i4 : i4
      %674 = comb.and %672, %673 : i1
      %675 = comb.extract %606 from 23 : (i59) -> i1
      %676 = comb.icmp ne %608, %c-1_i4 : i4
      %677 = comb.and %675, %676 : i1
      %678 = comb.extract %606 from 24 : (i59) -> i1
      %679 = comb.icmp ne %608, %c-1_i4 : i4
      %680 = comb.and %678, %679 : i1
      %681 = comb.extract %606 from 25 : (i59) -> i1
      %682 = comb.icmp ne %608, %c-1_i4 : i4
      %683 = comb.and %681, %682 : i1
      %684 = comb.extract %606 from 26 : (i59) -> i1
      %685 = comb.icmp ne %608, %c-1_i4 : i4
      %686 = comb.and %684, %685 : i1
      %687 = comb.extract %606 from 27 : (i59) -> i1
      %688 = comb.icmp ne %608, %c-1_i4 : i4
      %689 = comb.and %687, %688 : i1
      %690 = comb.extract %606 from 28 : (i59) -> i1
      %691 = comb.icmp ne %608, %c-1_i4 : i4
      %692 = comb.and %690, %691 : i1
      %693 = comb.extract %606 from 29 : (i59) -> i1
      %694 = comb.icmp ne %608, %c-1_i4 : i4
      %695 = comb.and %693, %694 : i1
      %696 = comb.extract %606 from 30 : (i59) -> i1
      %697 = comb.icmp ne %608, %c-1_i4 : i4
      %698 = comb.and %696, %697 : i1
      %699 = comb.extract %606 from 31 : (i59) -> i1
      %700 = comb.icmp ne %608, %c-1_i4 : i4
      %701 = comb.and %699, %700 : i1
      %702 = comb.extract %606 from 32 : (i59) -> i1
      %703 = comb.icmp ne %608, %c-1_i4 : i4
      %704 = comb.and %702, %703 : i1
      %705 = comb.extract %606 from 33 : (i59) -> i1
      %706 = comb.icmp ne %608, %c-1_i4 : i4
      %707 = comb.and %705, %706 : i1
      %708 = comb.extract %606 from 34 : (i59) -> i1
      %709 = comb.icmp ne %608, %c-1_i4 : i4
      %710 = comb.and %708, %709 : i1
      %711 = comb.extract %606 from 35 : (i59) -> i1
      %712 = comb.icmp ne %608, %c-1_i4 : i4
      %713 = comb.and %711, %712 : i1
      %714 = comb.extract %606 from 36 : (i59) -> i1
      %715 = comb.icmp ne %608, %c-1_i4 : i4
      %716 = comb.and %714, %715 : i1
      %717 = comb.extract %606 from 37 : (i59) -> i1
      %718 = comb.icmp ne %608, %c-1_i4 : i4
      %719 = comb.and %717, %718 : i1
      %720 = comb.extract %606 from 38 : (i59) -> i1
      %721 = comb.icmp ne %608, %c-1_i4 : i4
      %722 = comb.and %720, %721 : i1
      %723 = comb.extract %606 from 39 : (i59) -> i1
      %724 = comb.icmp ne %608, %c-1_i4 : i4
      %725 = comb.and %723, %724 : i1
      %726 = comb.extract %606 from 40 : (i59) -> i1
      %727 = comb.icmp ne %608, %c-1_i4 : i4
      %728 = comb.and %726, %727 : i1
      %729 = comb.extract %606 from 41 : (i59) -> i1
      %730 = comb.icmp ne %608, %c-1_i4 : i4
      %731 = comb.and %729, %730 : i1
      %732 = comb.extract %606 from 42 : (i59) -> i1
      %733 = comb.icmp ne %608, %c-1_i4 : i4
      %734 = comb.and %732, %733 : i1
      %735 = comb.extract %606 from 43 : (i59) -> i1
      %736 = comb.icmp ne %608, %c-1_i4 : i4
      %737 = comb.and %735, %736 : i1
      %738 = comb.extract %606 from 44 : (i59) -> i1
      %739 = comb.icmp ne %608, %c-1_i4 : i4
      %740 = comb.and %738, %739 : i1
      %741 = comb.extract %606 from 45 : (i59) -> i1
      %742 = comb.icmp ne %608, %c-1_i4 : i4
      %743 = comb.and %741, %742 : i1
      %744 = comb.extract %606 from 46 : (i59) -> i1
      %745 = comb.icmp ne %608, %c-1_i4 : i4
      %746 = comb.and %744, %745 : i1
      %747 = comb.extract %606 from 47 : (i59) -> i1
      %748 = comb.icmp ne %608, %c-1_i4 : i4
      %749 = comb.and %747, %748 : i1
      %750 = comb.extract %606 from 48 : (i59) -> i1
      %751 = comb.icmp ne %608, %c-1_i4 : i4
      %752 = comb.and %750, %751 : i1
      %753 = comb.extract %606 from 49 : (i59) -> i1
      %754 = comb.icmp ne %608, %c-1_i4 : i4
      %755 = comb.and %753, %754 : i1
      %756 = comb.extract %606 from 50 : (i59) -> i1
      %757 = comb.icmp ne %608, %c-1_i4 : i4
      %758 = comb.and %756, %757 : i1
      %759 = comb.extract %606 from 51 : (i59) -> i1
      %760 = comb.icmp ne %608, %c-1_i4 : i4
      %761 = comb.and %759, %760 : i1
      %762 = comb.extract %606 from 52 : (i59) -> i1
      %763 = comb.icmp ne %608, %c-1_i4 : i4
      %764 = comb.and %762, %763 : i1
      %765 = comb.extract %606 from 53 : (i59) -> i1
      %766 = comb.icmp ne %608, %c-1_i4 : i4
      %767 = comb.and %765, %766 : i1
      %768 = comb.extract %606 from 54 : (i59) -> i1
      %769 = comb.icmp ne %608, %c-1_i4 : i4
      %770 = comb.and %768, %769 : i1
      %771 = comb.extract %606 from 55 : (i59) -> i1
      %772 = comb.icmp ne %608, %c-1_i4 : i4
      %773 = comb.and %771, %772 : i1
      %774 = comb.extract %606 from 56 : (i59) -> i1
      %775 = comb.icmp ne %608, %c-1_i4 : i4
      %776 = comb.and %774, %775 : i1
      %777 = comb.extract %606 from 57 : (i59) -> i1
      %778 = comb.icmp ne %608, %c-1_i4 : i4
      %779 = comb.and %777, %778 : i1
      %780 = comb.extract %606 from 58 : (i59) -> i1
      %781 = comb.icmp ne %608, %c-1_i4 : i4
      %782 = comb.and %780, %781 : i1
      %783 = comb.or %612, %614, %616, %618, %621, %623, %626, %629, %632, %635, %638, %641, %644, %647, %650, %653, %656, %659, %662, %665, %668, %671, %674, %677, %680, %683, %686, %689, %692, %695, %698, %701, %704, %707, %710, %713, %716, %719, %722, %725, %728, %731, %734, %737, %740, %743, %746, %749, %752, %755, %758, %761, %764, %767, %770, %773, %776, %779, %782 : i1
      %784 = comb.and %605, %783 : i1
      llhd.drv %wr_err, %784 after %1 : i1
      llhd.wait (%9, %419, %424, %293 : i1, i59, i4, i1), ^bb1
    }
    %425 = comb.extract %419 from 0 : (i59) -> i1
    %426 = comb.xor %294, %true : i1
    %427 = comb.and %425, %9, %426 : i1
    llhd.drv %intr_state_we, %427 after %1 : i1
    %428 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "alert_test_wd"} : (i32) -> i1
    %429 = comb.extract %u_reg_if.wdata_o from 2 {sv.namehint = "cmd_hash_stop_wd"} : (i32) -> i1
    %430 = comb.extract %419 from 1 : (i59) -> i1
    %431 = comb.and %430, %9, %426 : i1
    llhd.drv %intr_enable_we, %431 after %1 : i1
    %432 = comb.extract %u_reg_if.wdata_o from 1 {sv.namehint = "cfg_sha_en_wd"} : (i32) -> i1
    %433 = comb.extract %419 from 2 : (i59) -> i1
    %434 = comb.and %433, %9, %426 : i1
    llhd.drv %intr_test_we, %434 after %1 : i1
    %435 = comb.extract %419 from 3 : (i59) -> i1
    %436 = comb.and %435, %9, %426 : i1
    llhd.drv %alert_test_we, %436 after %1 : i1
    %437 = comb.extract %419 from 4 : (i59) -> i1
    %438 = comb.and %437, %u_reg_if.re_o, %426 {sv.namehint = "cfg_re"} : i1
    %439 = comb.and %437, %9, %426 : i1
    llhd.drv %cfg_we, %439 after %1 : i1
    %440 = comb.extract %u_reg_if.wdata_o from 3 {sv.namehint = "cfg_digest_swap_wd"} : (i32) -> i1
    %441 = comb.extract %u_reg_if.wdata_o from 4 {sv.namehint = "cfg_key_swap_wd"} : (i32) -> i1
    %442 = comb.extract %u_reg_if.wdata_o from 5 {sv.namehint = "cfg_digest_size_wd"} : (i32) -> i4
    %443 = comb.extract %u_reg_if.wdata_o from 9 {sv.namehint = "cfg_key_length_wd"} : (i32) -> i6
    %444 = comb.extract %419 from 5 : (i59) -> i1
    %445 = comb.and %444, %9, %426 : i1
    llhd.drv %cmd_we, %445 after %1 : i1
    %446 = comb.extract %419 from 6 : (i59) -> i1
    %447 = comb.and %446, %u_reg_if.re_o, %426 {sv.namehint = "status_re"} : i1
    %448 = comb.extract %419 from 8 : (i59) -> i1
    %449 = comb.and %448, %9, %426 : i1
    llhd.drv %wipe_secret_we, %449 after %1 : i1
    %450 = comb.extract %419 from 9 : (i59) -> i1
    %451 = comb.and %450, %9, %426 : i1
    llhd.drv %key_0_we, %451 after %1 : i1
    %452 = comb.extract %419 from 10 : (i59) -> i1
    %453 = comb.and %452, %9, %426 : i1
    llhd.drv %key_1_we, %453 after %1 : i1
    %454 = comb.extract %419 from 11 : (i59) -> i1
    %455 = comb.and %454, %9, %426 : i1
    llhd.drv %key_2_we, %455 after %1 : i1
    %456 = comb.extract %419 from 12 : (i59) -> i1
    %457 = comb.and %456, %9, %426 : i1
    llhd.drv %key_3_we, %457 after %1 : i1
    %458 = comb.extract %419 from 13 : (i59) -> i1
    %459 = comb.and %458, %9, %426 : i1
    llhd.drv %key_4_we, %459 after %1 : i1
    %460 = comb.extract %419 from 14 : (i59) -> i1
    %461 = comb.and %460, %9, %426 : i1
    llhd.drv %key_5_we, %461 after %1 : i1
    %462 = comb.extract %419 from 15 : (i59) -> i1
    %463 = comb.and %462, %9, %426 : i1
    llhd.drv %key_6_we, %463 after %1 : i1
    %464 = comb.extract %419 from 16 : (i59) -> i1
    %465 = comb.and %464, %9, %426 : i1
    llhd.drv %key_7_we, %465 after %1 : i1
    %466 = comb.extract %419 from 17 : (i59) -> i1
    %467 = comb.and %466, %9, %426 : i1
    llhd.drv %key_8_we, %467 after %1 : i1
    %468 = comb.extract %419 from 18 : (i59) -> i1
    %469 = comb.and %468, %9, %426 : i1
    llhd.drv %key_9_we, %469 after %1 : i1
    %470 = comb.extract %419 from 19 : (i59) -> i1
    %471 = comb.and %470, %9, %426 : i1
    llhd.drv %key_10_we, %471 after %1 : i1
    %472 = comb.extract %419 from 20 : (i59) -> i1
    %473 = comb.and %472, %9, %426 : i1
    llhd.drv %key_11_we, %473 after %1 : i1
    %474 = comb.extract %419 from 21 : (i59) -> i1
    %475 = comb.and %474, %9, %426 : i1
    llhd.drv %key_12_we, %475 after %1 : i1
    %476 = comb.extract %419 from 22 : (i59) -> i1
    %477 = comb.and %476, %9, %426 : i1
    llhd.drv %key_13_we, %477 after %1 : i1
    %478 = comb.extract %419 from 23 : (i59) -> i1
    %479 = comb.and %478, %9, %426 : i1
    llhd.drv %key_14_we, %479 after %1 : i1
    %480 = comb.extract %419 from 24 : (i59) -> i1
    %481 = comb.and %480, %9, %426 : i1
    llhd.drv %key_15_we, %481 after %1 : i1
    %482 = comb.extract %419 from 25 : (i59) -> i1
    %483 = comb.and %482, %9, %426 : i1
    llhd.drv %key_16_we, %483 after %1 : i1
    %484 = comb.extract %419 from 26 : (i59) -> i1
    %485 = comb.and %484, %9, %426 : i1
    llhd.drv %key_17_we, %485 after %1 : i1
    %486 = comb.extract %419 from 27 : (i59) -> i1
    %487 = comb.and %486, %9, %426 : i1
    llhd.drv %key_18_we, %487 after %1 : i1
    %488 = comb.extract %419 from 28 : (i59) -> i1
    %489 = comb.and %488, %9, %426 : i1
    llhd.drv %key_19_we, %489 after %1 : i1
    %490 = comb.extract %419 from 29 : (i59) -> i1
    %491 = comb.and %490, %9, %426 : i1
    llhd.drv %key_20_we, %491 after %1 : i1
    %492 = comb.extract %419 from 30 : (i59) -> i1
    %493 = comb.and %492, %9, %426 : i1
    llhd.drv %key_21_we, %493 after %1 : i1
    %494 = comb.extract %419 from 31 : (i59) -> i1
    %495 = comb.and %494, %9, %426 : i1
    llhd.drv %key_22_we, %495 after %1 : i1
    %496 = comb.extract %419 from 32 : (i59) -> i1
    %497 = comb.and %496, %9, %426 : i1
    llhd.drv %key_23_we, %497 after %1 : i1
    %498 = comb.extract %419 from 33 : (i59) -> i1
    %499 = comb.and %498, %9, %426 : i1
    llhd.drv %key_24_we, %499 after %1 : i1
    %500 = comb.extract %419 from 34 : (i59) -> i1
    %501 = comb.and %500, %9, %426 : i1
    llhd.drv %key_25_we, %501 after %1 : i1
    %502 = comb.extract %419 from 35 : (i59) -> i1
    %503 = comb.and %502, %9, %426 : i1
    llhd.drv %key_26_we, %503 after %1 : i1
    %504 = comb.extract %419 from 36 : (i59) -> i1
    %505 = comb.and %504, %9, %426 : i1
    llhd.drv %key_27_we, %505 after %1 : i1
    %506 = comb.extract %419 from 37 : (i59) -> i1
    %507 = comb.and %506, %9, %426 : i1
    llhd.drv %key_28_we, %507 after %1 : i1
    %508 = comb.extract %419 from 38 : (i59) -> i1
    %509 = comb.and %508, %9, %426 : i1
    llhd.drv %key_29_we, %509 after %1 : i1
    %510 = comb.extract %419 from 39 : (i59) -> i1
    %511 = comb.and %510, %9, %426 : i1
    llhd.drv %key_30_we, %511 after %1 : i1
    %512 = comb.extract %419 from 40 : (i59) -> i1
    %513 = comb.and %512, %9, %426 : i1
    llhd.drv %key_31_we, %513 after %1 : i1
    %514 = comb.extract %419 from 41 : (i59) -> i1
    %515 = comb.and %514, %u_reg_if.re_o, %426 {sv.namehint = "digest_0_re"} : i1
    %516 = comb.and %514, %9, %426 : i1
    llhd.drv %digest_0_we, %516 after %1 : i1
    %517 = comb.extract %419 from 42 : (i59) -> i1
    %518 = comb.and %517, %u_reg_if.re_o, %426 {sv.namehint = "digest_1_re"} : i1
    %519 = comb.and %517, %9, %426 : i1
    llhd.drv %digest_1_we, %519 after %1 : i1
    %520 = comb.extract %419 from 43 : (i59) -> i1
    %521 = comb.and %520, %u_reg_if.re_o, %426 {sv.namehint = "digest_2_re"} : i1
    %522 = comb.and %520, %9, %426 : i1
    llhd.drv %digest_2_we, %522 after %1 : i1
    %523 = comb.extract %419 from 44 : (i59) -> i1
    %524 = comb.and %523, %u_reg_if.re_o, %426 {sv.namehint = "digest_3_re"} : i1
    %525 = comb.and %523, %9, %426 : i1
    llhd.drv %digest_3_we, %525 after %1 : i1
    %526 = comb.extract %419 from 45 : (i59) -> i1
    %527 = comb.and %526, %u_reg_if.re_o, %426 {sv.namehint = "digest_4_re"} : i1
    %528 = comb.and %526, %9, %426 : i1
    llhd.drv %digest_4_we, %528 after %1 : i1
    %529 = comb.extract %419 from 46 : (i59) -> i1
    %530 = comb.and %529, %u_reg_if.re_o, %426 {sv.namehint = "digest_5_re"} : i1
    %531 = comb.and %529, %9, %426 : i1
    llhd.drv %digest_5_we, %531 after %1 : i1
    %532 = comb.extract %419 from 47 : (i59) -> i1
    %533 = comb.and %532, %u_reg_if.re_o, %426 {sv.namehint = "digest_6_re"} : i1
    %534 = comb.and %532, %9, %426 : i1
    llhd.drv %digest_6_we, %534 after %1 : i1
    %535 = comb.extract %419 from 48 : (i59) -> i1
    %536 = comb.and %535, %u_reg_if.re_o, %426 {sv.namehint = "digest_7_re"} : i1
    %537 = comb.and %535, %9, %426 : i1
    llhd.drv %digest_7_we, %537 after %1 : i1
    %538 = comb.extract %419 from 49 : (i59) -> i1
    %539 = comb.and %538, %u_reg_if.re_o, %426 {sv.namehint = "digest_8_re"} : i1
    %540 = comb.and %538, %9, %426 : i1
    llhd.drv %digest_8_we, %540 after %1 : i1
    %541 = comb.extract %419 from 50 : (i59) -> i1
    %542 = comb.and %541, %u_reg_if.re_o, %426 {sv.namehint = "digest_9_re"} : i1
    %543 = comb.and %541, %9, %426 : i1
    llhd.drv %digest_9_we, %543 after %1 : i1
    %544 = comb.extract %419 from 51 : (i59) -> i1
    %545 = comb.and %544, %u_reg_if.re_o, %426 {sv.namehint = "digest_10_re"} : i1
    %546 = comb.and %544, %9, %426 : i1
    llhd.drv %digest_10_we, %546 after %1 : i1
    %547 = comb.extract %419 from 52 : (i59) -> i1
    %548 = comb.and %547, %u_reg_if.re_o, %426 {sv.namehint = "digest_11_re"} : i1
    %549 = comb.and %547, %9, %426 : i1
    llhd.drv %digest_11_we, %549 after %1 : i1
    %550 = comb.extract %419 from 53 : (i59) -> i1
    %551 = comb.and %550, %u_reg_if.re_o, %426 {sv.namehint = "digest_12_re"} : i1
    %552 = comb.and %550, %9, %426 : i1
    llhd.drv %digest_12_we, %552 after %1 : i1
    %553 = comb.extract %419 from 54 : (i59) -> i1
    %554 = comb.and %553, %u_reg_if.re_o, %426 {sv.namehint = "digest_13_re"} : i1
    %555 = comb.and %553, %9, %426 : i1
    llhd.drv %digest_13_we, %555 after %1 : i1
    %556 = comb.extract %419 from 55 : (i59) -> i1
    %557 = comb.and %556, %u_reg_if.re_o, %426 {sv.namehint = "digest_14_re"} : i1
    %558 = comb.and %556, %9, %426 : i1
    llhd.drv %digest_14_we, %558 after %1 : i1
    %559 = comb.extract %419 from 56 : (i59) -> i1
    %560 = comb.and %559, %u_reg_if.re_o, %426 {sv.namehint = "digest_15_re"} : i1
    %561 = comb.and %559, %9, %426 : i1
    llhd.drv %digest_15_we, %561 after %1 : i1
    %562 = comb.extract %419 from 57 : (i59) -> i1
    %563 = comb.and %562, %u_reg_if.re_o, %426 {sv.namehint = "msg_length_lower_re"} : i1
    %564 = comb.and %562, %9, %426 : i1
    llhd.drv %msg_length_lower_we, %564 after %1 : i1
    %565 = comb.extract %419 from 58 : (i59) -> i1
    %566 = comb.and %565, %u_reg_if.re_o, %426 {sv.namehint = "msg_length_upper_re"} : i1
    %567 = comb.and %565, %9, %426 : i1
    llhd.drv %msg_length_upper_we, %567 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %605 = llhd.sig.extract %reg_we_check from %c0_i6 : <i59> -> <i1>
      %606 = llhd.prb %intr_state_we : i1
      llhd.drv %605, %606 after %1 : i1
      %607 = llhd.sig.extract %reg_we_check from %c1_i6 : <i59> -> <i1>
      %608 = llhd.prb %intr_enable_we : i1
      llhd.drv %607, %608 after %1 : i1
      %609 = llhd.sig.extract %reg_we_check from %c2_i6 : <i59> -> <i1>
      %610 = llhd.prb %intr_test_we : i1
      llhd.drv %609, %610 after %1 : i1
      %611 = llhd.sig.extract %reg_we_check from %c3_i6 : <i59> -> <i1>
      %612 = llhd.prb %alert_test_we : i1
      llhd.drv %611, %612 after %1 : i1
      %613 = llhd.sig.extract %reg_we_check from %c4_i6 : <i59> -> <i1>
      %614 = llhd.prb %cfg_we : i1
      llhd.drv %613, %614 after %1 : i1
      %615 = llhd.sig.extract %reg_we_check from %c5_i6 : <i59> -> <i1>
      %616 = llhd.prb %cmd_we : i1
      llhd.drv %615, %616 after %1 : i1
      %617 = llhd.sig.extract %reg_we_check from %c6_i6 : <i59> -> <i1>
      llhd.drv %617, %false after %1 : i1
      %618 = llhd.sig.extract %reg_we_check from %c7_i6 : <i59> -> <i1>
      llhd.drv %618, %false after %1 : i1
      %619 = llhd.sig.extract %reg_we_check from %c8_i6 : <i59> -> <i1>
      %620 = llhd.prb %wipe_secret_we : i1
      llhd.drv %619, %620 after %1 : i1
      %621 = llhd.sig.extract %reg_we_check from %c9_i6 : <i59> -> <i1>
      %622 = llhd.prb %key_0_we : i1
      llhd.drv %621, %622 after %1 : i1
      %623 = llhd.sig.extract %reg_we_check from %c10_i6 : <i59> -> <i1>
      %624 = llhd.prb %key_1_we : i1
      llhd.drv %623, %624 after %1 : i1
      %625 = llhd.sig.extract %reg_we_check from %c11_i6 : <i59> -> <i1>
      %626 = llhd.prb %key_2_we : i1
      llhd.drv %625, %626 after %1 : i1
      %627 = llhd.sig.extract %reg_we_check from %c12_i6 : <i59> -> <i1>
      %628 = llhd.prb %key_3_we : i1
      llhd.drv %627, %628 after %1 : i1
      %629 = llhd.sig.extract %reg_we_check from %c13_i6 : <i59> -> <i1>
      %630 = llhd.prb %key_4_we : i1
      llhd.drv %629, %630 after %1 : i1
      %631 = llhd.sig.extract %reg_we_check from %c14_i6 : <i59> -> <i1>
      %632 = llhd.prb %key_5_we : i1
      llhd.drv %631, %632 after %1 : i1
      %633 = llhd.sig.extract %reg_we_check from %c15_i6 : <i59> -> <i1>
      %634 = llhd.prb %key_6_we : i1
      llhd.drv %633, %634 after %1 : i1
      %635 = llhd.sig.extract %reg_we_check from %c16_i6 : <i59> -> <i1>
      %636 = llhd.prb %key_7_we : i1
      llhd.drv %635, %636 after %1 : i1
      %637 = llhd.sig.extract %reg_we_check from %c17_i6 : <i59> -> <i1>
      %638 = llhd.prb %key_8_we : i1
      llhd.drv %637, %638 after %1 : i1
      %639 = llhd.sig.extract %reg_we_check from %c18_i6 : <i59> -> <i1>
      %640 = llhd.prb %key_9_we : i1
      llhd.drv %639, %640 after %1 : i1
      %641 = llhd.sig.extract %reg_we_check from %c19_i6 : <i59> -> <i1>
      %642 = llhd.prb %key_10_we : i1
      llhd.drv %641, %642 after %1 : i1
      %643 = llhd.sig.extract %reg_we_check from %c20_i6 : <i59> -> <i1>
      %644 = llhd.prb %key_11_we : i1
      llhd.drv %643, %644 after %1 : i1
      %645 = llhd.sig.extract %reg_we_check from %c21_i6 : <i59> -> <i1>
      %646 = llhd.prb %key_12_we : i1
      llhd.drv %645, %646 after %1 : i1
      %647 = llhd.sig.extract %reg_we_check from %c22_i6 : <i59> -> <i1>
      %648 = llhd.prb %key_13_we : i1
      llhd.drv %647, %648 after %1 : i1
      %649 = llhd.sig.extract %reg_we_check from %c23_i6 : <i59> -> <i1>
      %650 = llhd.prb %key_14_we : i1
      llhd.drv %649, %650 after %1 : i1
      %651 = llhd.sig.extract %reg_we_check from %c24_i6 : <i59> -> <i1>
      %652 = llhd.prb %key_15_we : i1
      llhd.drv %651, %652 after %1 : i1
      %653 = llhd.sig.extract %reg_we_check from %c25_i6 : <i59> -> <i1>
      %654 = llhd.prb %key_16_we : i1
      llhd.drv %653, %654 after %1 : i1
      %655 = llhd.sig.extract %reg_we_check from %c26_i6 : <i59> -> <i1>
      %656 = llhd.prb %key_17_we : i1
      llhd.drv %655, %656 after %1 : i1
      %657 = llhd.sig.extract %reg_we_check from %c27_i6 : <i59> -> <i1>
      %658 = llhd.prb %key_18_we : i1
      llhd.drv %657, %658 after %1 : i1
      %659 = llhd.sig.extract %reg_we_check from %c28_i6 : <i59> -> <i1>
      %660 = llhd.prb %key_19_we : i1
      llhd.drv %659, %660 after %1 : i1
      %661 = llhd.sig.extract %reg_we_check from %c29_i6 : <i59> -> <i1>
      %662 = llhd.prb %key_20_we : i1
      llhd.drv %661, %662 after %1 : i1
      %663 = llhd.sig.extract %reg_we_check from %c30_i6 : <i59> -> <i1>
      %664 = llhd.prb %key_21_we : i1
      llhd.drv %663, %664 after %1 : i1
      %665 = llhd.sig.extract %reg_we_check from %c31_i6 : <i59> -> <i1>
      %666 = llhd.prb %key_22_we : i1
      llhd.drv %665, %666 after %1 : i1
      %667 = llhd.sig.extract %reg_we_check from %c-32_i6 : <i59> -> <i1>
      %668 = llhd.prb %key_23_we : i1
      llhd.drv %667, %668 after %1 : i1
      %669 = llhd.sig.extract %reg_we_check from %c-31_i6 : <i59> -> <i1>
      %670 = llhd.prb %key_24_we : i1
      llhd.drv %669, %670 after %1 : i1
      %671 = llhd.sig.extract %reg_we_check from %c-30_i6 : <i59> -> <i1>
      %672 = llhd.prb %key_25_we : i1
      llhd.drv %671, %672 after %1 : i1
      %673 = llhd.sig.extract %reg_we_check from %c-29_i6 : <i59> -> <i1>
      %674 = llhd.prb %key_26_we : i1
      llhd.drv %673, %674 after %1 : i1
      %675 = llhd.sig.extract %reg_we_check from %c-28_i6 : <i59> -> <i1>
      %676 = llhd.prb %key_27_we : i1
      llhd.drv %675, %676 after %1 : i1
      %677 = llhd.sig.extract %reg_we_check from %c-27_i6 : <i59> -> <i1>
      %678 = llhd.prb %key_28_we : i1
      llhd.drv %677, %678 after %1 : i1
      %679 = llhd.sig.extract %reg_we_check from %c-26_i6 : <i59> -> <i1>
      %680 = llhd.prb %key_29_we : i1
      llhd.drv %679, %680 after %1 : i1
      %681 = llhd.sig.extract %reg_we_check from %c-25_i6 : <i59> -> <i1>
      %682 = llhd.prb %key_30_we : i1
      llhd.drv %681, %682 after %1 : i1
      %683 = llhd.sig.extract %reg_we_check from %c-24_i6 : <i59> -> <i1>
      %684 = llhd.prb %key_31_we : i1
      llhd.drv %683, %684 after %1 : i1
      %685 = llhd.sig.extract %reg_we_check from %c-23_i6 : <i59> -> <i1>
      %686 = llhd.prb %digest_0_we : i1
      llhd.drv %685, %686 after %1 : i1
      %687 = llhd.sig.extract %reg_we_check from %c-22_i6 : <i59> -> <i1>
      %688 = llhd.prb %digest_1_we : i1
      llhd.drv %687, %688 after %1 : i1
      %689 = llhd.sig.extract %reg_we_check from %c-21_i6 : <i59> -> <i1>
      %690 = llhd.prb %digest_2_we : i1
      llhd.drv %689, %690 after %1 : i1
      %691 = llhd.sig.extract %reg_we_check from %c-20_i6 : <i59> -> <i1>
      %692 = llhd.prb %digest_3_we : i1
      llhd.drv %691, %692 after %1 : i1
      %693 = llhd.sig.extract %reg_we_check from %c-19_i6 : <i59> -> <i1>
      %694 = llhd.prb %digest_4_we : i1
      llhd.drv %693, %694 after %1 : i1
      %695 = llhd.sig.extract %reg_we_check from %c-18_i6 : <i59> -> <i1>
      %696 = llhd.prb %digest_5_we : i1
      llhd.drv %695, %696 after %1 : i1
      %697 = llhd.sig.extract %reg_we_check from %c-17_i6 : <i59> -> <i1>
      %698 = llhd.prb %digest_6_we : i1
      llhd.drv %697, %698 after %1 : i1
      %699 = llhd.sig.extract %reg_we_check from %c-16_i6 : <i59> -> <i1>
      %700 = llhd.prb %digest_7_we : i1
      llhd.drv %699, %700 after %1 : i1
      %701 = llhd.sig.extract %reg_we_check from %c-15_i6 : <i59> -> <i1>
      %702 = llhd.prb %digest_8_we : i1
      llhd.drv %701, %702 after %1 : i1
      %703 = llhd.sig.extract %reg_we_check from %c-14_i6 : <i59> -> <i1>
      %704 = llhd.prb %digest_9_we : i1
      llhd.drv %703, %704 after %1 : i1
      %705 = llhd.sig.extract %reg_we_check from %c-13_i6 : <i59> -> <i1>
      %706 = llhd.prb %digest_10_we : i1
      llhd.drv %705, %706 after %1 : i1
      %707 = llhd.sig.extract %reg_we_check from %c-12_i6 : <i59> -> <i1>
      %708 = llhd.prb %digest_11_we : i1
      llhd.drv %707, %708 after %1 : i1
      %709 = llhd.sig.extract %reg_we_check from %c-11_i6 : <i59> -> <i1>
      %710 = llhd.prb %digest_12_we : i1
      llhd.drv %709, %710 after %1 : i1
      %711 = llhd.sig.extract %reg_we_check from %c-10_i6 : <i59> -> <i1>
      %712 = llhd.prb %digest_13_we : i1
      llhd.drv %711, %712 after %1 : i1
      %713 = llhd.sig.extract %reg_we_check from %c-9_i6 : <i59> -> <i1>
      %714 = llhd.prb %digest_14_we : i1
      llhd.drv %713, %714 after %1 : i1
      %715 = llhd.sig.extract %reg_we_check from %c-8_i6 : <i59> -> <i1>
      %716 = llhd.prb %digest_15_we : i1
      llhd.drv %715, %716 after %1 : i1
      %717 = llhd.sig.extract %reg_we_check from %c-7_i6 : <i59> -> <i1>
      %718 = llhd.prb %msg_length_lower_we : i1
      llhd.drv %717, %718 after %1 : i1
      %719 = llhd.sig.extract %reg_we_check from %c-6_i6 : <i59> -> <i1>
      %720 = llhd.prb %msg_length_upper_we : i1
      llhd.drv %719, %720 after %1 : i1
      llhd.wait (%8, %14, %22, %30, %41, %44, %67, %81, %84, %89, %93, %97, %101, %105, %109, %113, %117, %121, %125, %129, %133, %137, %141, %145, %149, %153, %157, %161, %165, %169, %173, %177, %181, %185, %189, %193, %197, %201, %205, %209, %213, %218, %222, %226, %230, %234, %238, %242, %246, %250, %254, %258, %262, %266, %270, %274, %278, %281 : i59, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %568 = llhd.prb %intr_state_hmac_done_qs : i1
    %569 = llhd.prb %intr_state_fifo_empty_qs : i1
    %570 = llhd.prb %intr_state_hmac_err_qs : i1
    %571 = llhd.prb %intr_enable_hmac_done_qs : i1
    %572 = llhd.prb %intr_enable_fifo_empty_qs : i1
    %573 = llhd.prb %intr_enable_hmac_err_qs : i1
    %574 = llhd.prb %cfg_hmac_en_qs : i1
    %575 = llhd.prb %cfg_sha_en_qs : i1
    %576 = llhd.prb %cfg_endian_swap_qs : i1
    %577 = llhd.prb %cfg_digest_swap_qs : i1
    %578 = llhd.prb %cfg_key_swap_qs : i1
    %579 = llhd.prb %cfg_digest_size_qs : i4
    %580 = llhd.prb %cfg_key_length_qs : i6
    %581 = llhd.prb %status_hmac_idle_qs : i1
    %582 = llhd.prb %status_fifo_empty_qs : i1
    %583 = llhd.prb %status_fifo_full_qs : i1
    %584 = llhd.prb %status_fifo_depth_qs : i6
    %585 = llhd.prb %err_code_qs : i32
    %586 = llhd.prb %digest_0_qs : i32
    %587 = llhd.prb %digest_1_qs : i32
    %588 = llhd.prb %digest_2_qs : i32
    %589 = llhd.prb %digest_3_qs : i32
    %590 = llhd.prb %digest_4_qs : i32
    %591 = llhd.prb %digest_5_qs : i32
    %592 = llhd.prb %digest_6_qs : i32
    %593 = llhd.prb %digest_7_qs : i32
    %594 = llhd.prb %digest_8_qs : i32
    %595 = llhd.prb %digest_9_qs : i32
    %596 = llhd.prb %digest_10_qs : i32
    %597 = llhd.prb %digest_11_qs : i32
    %598 = llhd.prb %digest_12_qs : i32
    %599 = llhd.prb %digest_13_qs : i32
    %600 = llhd.prb %digest_14_qs : i32
    %601 = llhd.prb %digest_15_qs : i32
    %602 = llhd.prb %msg_length_lower_qs : i32
    %603 = llhd.prb %msg_length_upper_qs : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb120
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      %605 = llhd.prb %addr_hit : i59
      %606 = comb.extract %605 from 0 : (i59) -> i1
      %607 = comb.icmp ceq %606, %true : i1
      cf.cond_br %607, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %608 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %609 = llhd.prb %intr_state_hmac_done_qs : i1
      llhd.drv %608, %609 after %1 : i1
      %610 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %611 = llhd.prb %intr_state_fifo_empty_qs : i1
      llhd.drv %610, %611 after %1 : i1
      %612 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %613 = llhd.prb %intr_state_hmac_err_qs : i1
      llhd.drv %612, %613 after %1 : i1
      cf.br ^bb120
    ^bb3:  // pred: ^bb1
      %614 = llhd.prb %addr_hit : i59
      %615 = comb.extract %614 from 1 : (i59) -> i1
      %616 = comb.icmp ceq %615, %true : i1
      cf.cond_br %616, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %617 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %618 = llhd.prb %intr_enable_hmac_done_qs : i1
      llhd.drv %617, %618 after %1 : i1
      %619 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %620 = llhd.prb %intr_enable_fifo_empty_qs : i1
      llhd.drv %619, %620 after %1 : i1
      %621 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %622 = llhd.prb %intr_enable_hmac_err_qs : i1
      llhd.drv %621, %622 after %1 : i1
      cf.br ^bb120
    ^bb5:  // pred: ^bb3
      %623 = llhd.prb %addr_hit : i59
      %624 = comb.extract %623 from 2 : (i59) -> i1
      %625 = comb.icmp ceq %624, %true : i1
      cf.cond_br %625, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %626 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %626, %false after %1 : i1
      %627 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      llhd.drv %627, %false after %1 : i1
      %628 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      llhd.drv %628, %false after %1 : i1
      cf.br ^bb120
    ^bb7:  // pred: ^bb5
      %629 = llhd.prb %addr_hit : i59
      %630 = comb.extract %629 from 3 : (i59) -> i1
      %631 = comb.icmp ceq %630, %true : i1
      cf.cond_br %631, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %632 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %632, %false after %1 : i1
      cf.br ^bb120
    ^bb9:  // pred: ^bb7
      %633 = llhd.prb %addr_hit : i59
      %634 = comb.extract %633 from 4 : (i59) -> i1
      %635 = comb.icmp ceq %634, %true : i1
      cf.cond_br %635, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %636 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %637 = llhd.prb %cfg_hmac_en_qs : i1
      llhd.drv %636, %637 after %1 : i1
      %638 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %639 = llhd.prb %cfg_sha_en_qs : i1
      llhd.drv %638, %639 after %1 : i1
      %640 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %641 = llhd.prb %cfg_endian_swap_qs : i1
      llhd.drv %640, %641 after %1 : i1
      %642 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %643 = llhd.prb %cfg_digest_swap_qs : i1
      llhd.drv %642, %643 after %1 : i1
      %644 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i1>
      %645 = llhd.prb %cfg_key_swap_qs : i1
      llhd.drv %644, %645 after %1 : i1
      %646 = llhd.sig.extract %reg_rdata_next from %c5_i5 : <i32> -> <i4>
      %647 = llhd.prb %cfg_digest_size_qs : i4
      llhd.drv %646, %647 after %1 : i4
      %648 = llhd.sig.extract %reg_rdata_next from %c9_i5 : <i32> -> <i6>
      %649 = llhd.prb %cfg_key_length_qs : i6
      llhd.drv %648, %649 after %1 : i6
      cf.br ^bb120
    ^bb11:  // pred: ^bb9
      %650 = llhd.prb %addr_hit : i59
      %651 = comb.extract %650 from 5 : (i59) -> i1
      %652 = comb.icmp ceq %651, %true : i1
      cf.cond_br %652, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %653 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %653, %false after %1 : i1
      %654 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      llhd.drv %654, %false after %1 : i1
      %655 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      llhd.drv %655, %false after %1 : i1
      %656 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      llhd.drv %656, %false after %1 : i1
      cf.br ^bb120
    ^bb13:  // pred: ^bb11
      %657 = llhd.prb %addr_hit : i59
      %658 = comb.extract %657 from 6 : (i59) -> i1
      %659 = comb.icmp ceq %658, %true : i1
      cf.cond_br %659, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %660 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %661 = llhd.prb %status_hmac_idle_qs : i1
      llhd.drv %660, %661 after %1 : i1
      %662 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %663 = llhd.prb %status_fifo_empty_qs : i1
      llhd.drv %662, %663 after %1 : i1
      %664 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %665 = llhd.prb %status_fifo_full_qs : i1
      llhd.drv %664, %665 after %1 : i1
      %666 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i6>
      %667 = llhd.prb %status_fifo_depth_qs : i6
      llhd.drv %666, %667 after %1 : i6
      cf.br ^bb120
    ^bb15:  // pred: ^bb13
      %668 = llhd.prb %addr_hit : i59
      %669 = comb.extract %668 from 7 : (i59) -> i1
      %670 = comb.icmp ceq %669, %true : i1
      cf.cond_br %670, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %671 = llhd.prb %err_code_qs : i32
      llhd.drv %reg_rdata_next, %671 after %1 : i32
      cf.br ^bb120
    ^bb17:  // pred: ^bb15
      %672 = llhd.prb %addr_hit : i59
      %673 = comb.extract %672 from 8 : (i59) -> i1
      %674 = comb.icmp ceq %673, %true : i1
      cf.cond_br %674, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb19:  // pred: ^bb17
      %675 = llhd.prb %addr_hit : i59
      %676 = comb.extract %675 from 9 : (i59) -> i1
      %677 = comb.icmp ceq %676, %true : i1
      cf.cond_br %677, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb21:  // pred: ^bb19
      %678 = llhd.prb %addr_hit : i59
      %679 = comb.extract %678 from 10 : (i59) -> i1
      %680 = comb.icmp ceq %679, %true : i1
      cf.cond_br %680, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb23:  // pred: ^bb21
      %681 = llhd.prb %addr_hit : i59
      %682 = comb.extract %681 from 11 : (i59) -> i1
      %683 = comb.icmp ceq %682, %true : i1
      cf.cond_br %683, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb25:  // pred: ^bb23
      %684 = llhd.prb %addr_hit : i59
      %685 = comb.extract %684 from 12 : (i59) -> i1
      %686 = comb.icmp ceq %685, %true : i1
      cf.cond_br %686, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb27:  // pred: ^bb25
      %687 = llhd.prb %addr_hit : i59
      %688 = comb.extract %687 from 13 : (i59) -> i1
      %689 = comb.icmp ceq %688, %true : i1
      cf.cond_br %689, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb29:  // pred: ^bb27
      %690 = llhd.prb %addr_hit : i59
      %691 = comb.extract %690 from 14 : (i59) -> i1
      %692 = comb.icmp ceq %691, %true : i1
      cf.cond_br %692, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb31:  // pred: ^bb29
      %693 = llhd.prb %addr_hit : i59
      %694 = comb.extract %693 from 15 : (i59) -> i1
      %695 = comb.icmp ceq %694, %true : i1
      cf.cond_br %695, ^bb32, ^bb33
    ^bb32:  // pred: ^bb31
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb33:  // pred: ^bb31
      %696 = llhd.prb %addr_hit : i59
      %697 = comb.extract %696 from 16 : (i59) -> i1
      %698 = comb.icmp ceq %697, %true : i1
      cf.cond_br %698, ^bb34, ^bb35
    ^bb34:  // pred: ^bb33
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb35:  // pred: ^bb33
      %699 = llhd.prb %addr_hit : i59
      %700 = comb.extract %699 from 17 : (i59) -> i1
      %701 = comb.icmp ceq %700, %true : i1
      cf.cond_br %701, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb37:  // pred: ^bb35
      %702 = llhd.prb %addr_hit : i59
      %703 = comb.extract %702 from 18 : (i59) -> i1
      %704 = comb.icmp ceq %703, %true : i1
      cf.cond_br %704, ^bb38, ^bb39
    ^bb38:  // pred: ^bb37
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb39:  // pred: ^bb37
      %705 = llhd.prb %addr_hit : i59
      %706 = comb.extract %705 from 19 : (i59) -> i1
      %707 = comb.icmp ceq %706, %true : i1
      cf.cond_br %707, ^bb40, ^bb41
    ^bb40:  // pred: ^bb39
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb41:  // pred: ^bb39
      %708 = llhd.prb %addr_hit : i59
      %709 = comb.extract %708 from 20 : (i59) -> i1
      %710 = comb.icmp ceq %709, %true : i1
      cf.cond_br %710, ^bb42, ^bb43
    ^bb42:  // pred: ^bb41
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb43:  // pred: ^bb41
      %711 = llhd.prb %addr_hit : i59
      %712 = comb.extract %711 from 21 : (i59) -> i1
      %713 = comb.icmp ceq %712, %true : i1
      cf.cond_br %713, ^bb44, ^bb45
    ^bb44:  // pred: ^bb43
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb45:  // pred: ^bb43
      %714 = llhd.prb %addr_hit : i59
      %715 = comb.extract %714 from 22 : (i59) -> i1
      %716 = comb.icmp ceq %715, %true : i1
      cf.cond_br %716, ^bb46, ^bb47
    ^bb46:  // pred: ^bb45
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb47:  // pred: ^bb45
      %717 = llhd.prb %addr_hit : i59
      %718 = comb.extract %717 from 23 : (i59) -> i1
      %719 = comb.icmp ceq %718, %true : i1
      cf.cond_br %719, ^bb48, ^bb49
    ^bb48:  // pred: ^bb47
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb49:  // pred: ^bb47
      %720 = llhd.prb %addr_hit : i59
      %721 = comb.extract %720 from 24 : (i59) -> i1
      %722 = comb.icmp ceq %721, %true : i1
      cf.cond_br %722, ^bb50, ^bb51
    ^bb50:  // pred: ^bb49
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb51:  // pred: ^bb49
      %723 = llhd.prb %addr_hit : i59
      %724 = comb.extract %723 from 25 : (i59) -> i1
      %725 = comb.icmp ceq %724, %true : i1
      cf.cond_br %725, ^bb52, ^bb53
    ^bb52:  // pred: ^bb51
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb53:  // pred: ^bb51
      %726 = llhd.prb %addr_hit : i59
      %727 = comb.extract %726 from 26 : (i59) -> i1
      %728 = comb.icmp ceq %727, %true : i1
      cf.cond_br %728, ^bb54, ^bb55
    ^bb54:  // pred: ^bb53
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb55:  // pred: ^bb53
      %729 = llhd.prb %addr_hit : i59
      %730 = comb.extract %729 from 27 : (i59) -> i1
      %731 = comb.icmp ceq %730, %true : i1
      cf.cond_br %731, ^bb56, ^bb57
    ^bb56:  // pred: ^bb55
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb57:  // pred: ^bb55
      %732 = llhd.prb %addr_hit : i59
      %733 = comb.extract %732 from 28 : (i59) -> i1
      %734 = comb.icmp ceq %733, %true : i1
      cf.cond_br %734, ^bb58, ^bb59
    ^bb58:  // pred: ^bb57
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb59:  // pred: ^bb57
      %735 = llhd.prb %addr_hit : i59
      %736 = comb.extract %735 from 29 : (i59) -> i1
      %737 = comb.icmp ceq %736, %true : i1
      cf.cond_br %737, ^bb60, ^bb61
    ^bb60:  // pred: ^bb59
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb61:  // pred: ^bb59
      %738 = llhd.prb %addr_hit : i59
      %739 = comb.extract %738 from 30 : (i59) -> i1
      %740 = comb.icmp ceq %739, %true : i1
      cf.cond_br %740, ^bb62, ^bb63
    ^bb62:  // pred: ^bb61
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb63:  // pred: ^bb61
      %741 = llhd.prb %addr_hit : i59
      %742 = comb.extract %741 from 31 : (i59) -> i1
      %743 = comb.icmp ceq %742, %true : i1
      cf.cond_br %743, ^bb64, ^bb65
    ^bb64:  // pred: ^bb63
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb65:  // pred: ^bb63
      %744 = llhd.prb %addr_hit : i59
      %745 = comb.extract %744 from 32 : (i59) -> i1
      %746 = comb.icmp ceq %745, %true : i1
      cf.cond_br %746, ^bb66, ^bb67
    ^bb66:  // pred: ^bb65
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb67:  // pred: ^bb65
      %747 = llhd.prb %addr_hit : i59
      %748 = comb.extract %747 from 33 : (i59) -> i1
      %749 = comb.icmp ceq %748, %true : i1
      cf.cond_br %749, ^bb68, ^bb69
    ^bb68:  // pred: ^bb67
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb69:  // pred: ^bb67
      %750 = llhd.prb %addr_hit : i59
      %751 = comb.extract %750 from 34 : (i59) -> i1
      %752 = comb.icmp ceq %751, %true : i1
      cf.cond_br %752, ^bb70, ^bb71
    ^bb70:  // pred: ^bb69
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb71:  // pred: ^bb69
      %753 = llhd.prb %addr_hit : i59
      %754 = comb.extract %753 from 35 : (i59) -> i1
      %755 = comb.icmp ceq %754, %true : i1
      cf.cond_br %755, ^bb72, ^bb73
    ^bb72:  // pred: ^bb71
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb73:  // pred: ^bb71
      %756 = llhd.prb %addr_hit : i59
      %757 = comb.extract %756 from 36 : (i59) -> i1
      %758 = comb.icmp ceq %757, %true : i1
      cf.cond_br %758, ^bb74, ^bb75
    ^bb74:  // pred: ^bb73
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb75:  // pred: ^bb73
      %759 = llhd.prb %addr_hit : i59
      %760 = comb.extract %759 from 37 : (i59) -> i1
      %761 = comb.icmp ceq %760, %true : i1
      cf.cond_br %761, ^bb76, ^bb77
    ^bb76:  // pred: ^bb75
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb77:  // pred: ^bb75
      %762 = llhd.prb %addr_hit : i59
      %763 = comb.extract %762 from 38 : (i59) -> i1
      %764 = comb.icmp ceq %763, %true : i1
      cf.cond_br %764, ^bb78, ^bb79
    ^bb78:  // pred: ^bb77
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb79:  // pred: ^bb77
      %765 = llhd.prb %addr_hit : i59
      %766 = comb.extract %765 from 39 : (i59) -> i1
      %767 = comb.icmp ceq %766, %true : i1
      cf.cond_br %767, ^bb80, ^bb81
    ^bb80:  // pred: ^bb79
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb81:  // pred: ^bb79
      %768 = llhd.prb %addr_hit : i59
      %769 = comb.extract %768 from 40 : (i59) -> i1
      %770 = comb.icmp ceq %769, %true : i1
      cf.cond_br %770, ^bb82, ^bb83
    ^bb82:  // pred: ^bb81
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb120
    ^bb83:  // pred: ^bb81
      %771 = llhd.prb %addr_hit : i59
      %772 = comb.extract %771 from 41 : (i59) -> i1
      %773 = comb.icmp ceq %772, %true : i1
      cf.cond_br %773, ^bb84, ^bb85
    ^bb84:  // pred: ^bb83
      %774 = llhd.prb %digest_0_qs : i32
      llhd.drv %reg_rdata_next, %774 after %1 : i32
      cf.br ^bb120
    ^bb85:  // pred: ^bb83
      %775 = llhd.prb %addr_hit : i59
      %776 = comb.extract %775 from 42 : (i59) -> i1
      %777 = comb.icmp ceq %776, %true : i1
      cf.cond_br %777, ^bb86, ^bb87
    ^bb86:  // pred: ^bb85
      %778 = llhd.prb %digest_1_qs : i32
      llhd.drv %reg_rdata_next, %778 after %1 : i32
      cf.br ^bb120
    ^bb87:  // pred: ^bb85
      %779 = llhd.prb %addr_hit : i59
      %780 = comb.extract %779 from 43 : (i59) -> i1
      %781 = comb.icmp ceq %780, %true : i1
      cf.cond_br %781, ^bb88, ^bb89
    ^bb88:  // pred: ^bb87
      %782 = llhd.prb %digest_2_qs : i32
      llhd.drv %reg_rdata_next, %782 after %1 : i32
      cf.br ^bb120
    ^bb89:  // pred: ^bb87
      %783 = llhd.prb %addr_hit : i59
      %784 = comb.extract %783 from 44 : (i59) -> i1
      %785 = comb.icmp ceq %784, %true : i1
      cf.cond_br %785, ^bb90, ^bb91
    ^bb90:  // pred: ^bb89
      %786 = llhd.prb %digest_3_qs : i32
      llhd.drv %reg_rdata_next, %786 after %1 : i32
      cf.br ^bb120
    ^bb91:  // pred: ^bb89
      %787 = llhd.prb %addr_hit : i59
      %788 = comb.extract %787 from 45 : (i59) -> i1
      %789 = comb.icmp ceq %788, %true : i1
      cf.cond_br %789, ^bb92, ^bb93
    ^bb92:  // pred: ^bb91
      %790 = llhd.prb %digest_4_qs : i32
      llhd.drv %reg_rdata_next, %790 after %1 : i32
      cf.br ^bb120
    ^bb93:  // pred: ^bb91
      %791 = llhd.prb %addr_hit : i59
      %792 = comb.extract %791 from 46 : (i59) -> i1
      %793 = comb.icmp ceq %792, %true : i1
      cf.cond_br %793, ^bb94, ^bb95
    ^bb94:  // pred: ^bb93
      %794 = llhd.prb %digest_5_qs : i32
      llhd.drv %reg_rdata_next, %794 after %1 : i32
      cf.br ^bb120
    ^bb95:  // pred: ^bb93
      %795 = llhd.prb %addr_hit : i59
      %796 = comb.extract %795 from 47 : (i59) -> i1
      %797 = comb.icmp ceq %796, %true : i1
      cf.cond_br %797, ^bb96, ^bb97
    ^bb96:  // pred: ^bb95
      %798 = llhd.prb %digest_6_qs : i32
      llhd.drv %reg_rdata_next, %798 after %1 : i32
      cf.br ^bb120
    ^bb97:  // pred: ^bb95
      %799 = llhd.prb %addr_hit : i59
      %800 = comb.extract %799 from 48 : (i59) -> i1
      %801 = comb.icmp ceq %800, %true : i1
      cf.cond_br %801, ^bb98, ^bb99
    ^bb98:  // pred: ^bb97
      %802 = llhd.prb %digest_7_qs : i32
      llhd.drv %reg_rdata_next, %802 after %1 : i32
      cf.br ^bb120
    ^bb99:  // pred: ^bb97
      %803 = llhd.prb %addr_hit : i59
      %804 = comb.extract %803 from 49 : (i59) -> i1
      %805 = comb.icmp ceq %804, %true : i1
      cf.cond_br %805, ^bb100, ^bb101
    ^bb100:  // pred: ^bb99
      %806 = llhd.prb %digest_8_qs : i32
      llhd.drv %reg_rdata_next, %806 after %1 : i32
      cf.br ^bb120
    ^bb101:  // pred: ^bb99
      %807 = llhd.prb %addr_hit : i59
      %808 = comb.extract %807 from 50 : (i59) -> i1
      %809 = comb.icmp ceq %808, %true : i1
      cf.cond_br %809, ^bb102, ^bb103
    ^bb102:  // pred: ^bb101
      %810 = llhd.prb %digest_9_qs : i32
      llhd.drv %reg_rdata_next, %810 after %1 : i32
      cf.br ^bb120
    ^bb103:  // pred: ^bb101
      %811 = llhd.prb %addr_hit : i59
      %812 = comb.extract %811 from 51 : (i59) -> i1
      %813 = comb.icmp ceq %812, %true : i1
      cf.cond_br %813, ^bb104, ^bb105
    ^bb104:  // pred: ^bb103
      %814 = llhd.prb %digest_10_qs : i32
      llhd.drv %reg_rdata_next, %814 after %1 : i32
      cf.br ^bb120
    ^bb105:  // pred: ^bb103
      %815 = llhd.prb %addr_hit : i59
      %816 = comb.extract %815 from 52 : (i59) -> i1
      %817 = comb.icmp ceq %816, %true : i1
      cf.cond_br %817, ^bb106, ^bb107
    ^bb106:  // pred: ^bb105
      %818 = llhd.prb %digest_11_qs : i32
      llhd.drv %reg_rdata_next, %818 after %1 : i32
      cf.br ^bb120
    ^bb107:  // pred: ^bb105
      %819 = llhd.prb %addr_hit : i59
      %820 = comb.extract %819 from 53 : (i59) -> i1
      %821 = comb.icmp ceq %820, %true : i1
      cf.cond_br %821, ^bb108, ^bb109
    ^bb108:  // pred: ^bb107
      %822 = llhd.prb %digest_12_qs : i32
      llhd.drv %reg_rdata_next, %822 after %1 : i32
      cf.br ^bb120
    ^bb109:  // pred: ^bb107
      %823 = llhd.prb %addr_hit : i59
      %824 = comb.extract %823 from 54 : (i59) -> i1
      %825 = comb.icmp ceq %824, %true : i1
      cf.cond_br %825, ^bb110, ^bb111
    ^bb110:  // pred: ^bb109
      %826 = llhd.prb %digest_13_qs : i32
      llhd.drv %reg_rdata_next, %826 after %1 : i32
      cf.br ^bb120
    ^bb111:  // pred: ^bb109
      %827 = llhd.prb %addr_hit : i59
      %828 = comb.extract %827 from 55 : (i59) -> i1
      %829 = comb.icmp ceq %828, %true : i1
      cf.cond_br %829, ^bb112, ^bb113
    ^bb112:  // pred: ^bb111
      %830 = llhd.prb %digest_14_qs : i32
      llhd.drv %reg_rdata_next, %830 after %1 : i32
      cf.br ^bb120
    ^bb113:  // pred: ^bb111
      %831 = llhd.prb %addr_hit : i59
      %832 = comb.extract %831 from 56 : (i59) -> i1
      %833 = comb.icmp ceq %832, %true : i1
      cf.cond_br %833, ^bb114, ^bb115
    ^bb114:  // pred: ^bb113
      %834 = llhd.prb %digest_15_qs : i32
      llhd.drv %reg_rdata_next, %834 after %1 : i32
      cf.br ^bb120
    ^bb115:  // pred: ^bb113
      %835 = llhd.prb %addr_hit : i59
      %836 = comb.extract %835 from 57 : (i59) -> i1
      %837 = comb.icmp ceq %836, %true : i1
      cf.cond_br %837, ^bb116, ^bb117
    ^bb116:  // pred: ^bb115
      %838 = llhd.prb %msg_length_lower_qs : i32
      llhd.drv %reg_rdata_next, %838 after %1 : i32
      cf.br ^bb120
    ^bb117:  // pred: ^bb115
      %839 = llhd.prb %addr_hit : i59
      %840 = comb.extract %839 from 58 : (i59) -> i1
      %841 = comb.icmp ceq %840, %true : i1
      cf.cond_br %841, ^bb118, ^bb119
    ^bb118:  // pred: ^bb117
      %842 = llhd.prb %msg_length_upper_qs : i32
      llhd.drv %reg_rdata_next, %842 after %1 : i32
      cf.br ^bb120
    ^bb119:  // pred: ^bb117
      llhd.drv %reg_rdata_next, %c-1_i32 after %1 : i32
      cf.br ^bb120
    ^bb120:  // 60 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb22, ^bb24, ^bb26, ^bb28, ^bb30, ^bb32, ^bb34, ^bb36, ^bb38, ^bb40, ^bb42, ^bb44, ^bb46, ^bb48, ^bb50, ^bb52, ^bb54, ^bb56, ^bb58, ^bb60, ^bb62, ^bb64, ^bb66, ^bb68, ^bb70, ^bb72, ^bb74, ^bb76, ^bb78, ^bb80, ^bb82, ^bb84, ^bb86, ^bb88, ^bb90, ^bb92, ^bb94, ^bb96, ^bb98, ^bb100, ^bb102, ^bb104, ^bb106, ^bb108, ^bb110, ^bb112, ^bb114, ^bb116, ^bb118, ^bb119
      llhd.wait (%292, %419, %568, %569, %570, %571, %572, %573, %574, %575, %576, %577, %578, %579, %580, %581, %582, %583, %584, %585, %586, %587, %588, %589, %590, %591, %592, %593, %594, %595, %596, %597, %598, %599, %600, %601, %602, %603 : i32, i59, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i4, i6, i1, i1, i1, i6, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %tl_i_2, %tl_i after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %604 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
    hw.output %u_rsp_intg_gen.tl_o, %290, %604, %287 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>, i1
  }
  hw.module @hmac(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %alert_rx_i : !hw.array<1xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, out alert_tx_o : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>, out intr_hmac_done_o : i1, out intr_fifo_empty_o : i1, out intr_hmac_err_o : i1, out idle_o : i4) {
    %0 = hw.aggregate_constant [false, false] : !hw.struct<q: i1, qe: i1>
    %1 = hw.aggregate_constant [-8 : i4, false] : !hw.struct<q: i4, qe: i1>
    %2 = hw.aggregate_constant [-32 : i6, false] : !hw.struct<q: i6, qe: i1>
    %3 = hw.aggregate_constant [[0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32]] : !hw.array<16xstruct<d: i32>>
    %c0_i58 = hw.constant 0 : i58
    %c0_i28 = hw.constant 0 : i28
    %c-1_i3 = hw.constant -1 : i3
    %c0_i29 = hw.constant 0 : i29
    %c0_i5 = hw.constant 0 : i5
    %c1_i5 = hw.constant 1 : i5
    %c2_i5 = hw.constant 2 : i5
    %c3_i5 = hw.constant 3 : i5
    %c4_i5 = hw.constant 4 : i5
    %c5_i5 = hw.constant 5 : i5
    %c6_i5 = hw.constant 6 : i5
    %c7_i5 = hw.constant 7 : i5
    %c8_i5 = hw.constant 8 : i5
    %c9_i5 = hw.constant 9 : i5
    %c10_i5 = hw.constant 10 : i5
    %c11_i5 = hw.constant 11 : i5
    %c12_i5 = hw.constant 12 : i5
    %c13_i5 = hw.constant 13 : i5
    %c14_i5 = hw.constant 14 : i5
    %c15_i5 = hw.constant 15 : i5
    %c-16_i5 = hw.constant -16 : i5
    %c-15_i5 = hw.constant -15 : i5
    %c-14_i5 = hw.constant -14 : i5
    %c-13_i5 = hw.constant -13 : i5
    %c-12_i5 = hw.constant -12 : i5
    %c-11_i5 = hw.constant -11 : i5
    %c-10_i5 = hw.constant -10 : i5
    %c-9_i5 = hw.constant -9 : i5
    %c-8_i5 = hw.constant -8 : i5
    %c-7_i5 = hw.constant -7 : i5
    %c-6_i5 = hw.constant -6 : i5
    %c-5_i5 = hw.constant -5 : i5
    %c-4_i5 = hw.constant -4 : i5
    %c-3_i5 = hw.constant -3 : i5
    %c-2_i5 = hw.constant -2 : i5
    %c-1_i10 = hw.constant -1 : i10
    %c0_i22 = hw.constant 0 : i22
    %c-1_i5 = hw.constant -1 : i5
    %c0_i27 = hw.constant 0 : i27
    %4 = llhd.constant_time <0ns, 1d, 0e>
    %c0_i0 = hw.constant 0 : i0
    %5 = llhd.constant_time <0ns, 0d, 1e>
    %6 = hw.aggregate_constant [[0 : i6, false], [0 : i4, false], [false, false], [false, false], [false, false], [false, false], [false, false]] : !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>
    %7 = hw.aggregate_constant [0, 0, 0, 0, 0, 0, 0, 0] : !hw.array<8xi64>
    %c0_i4 = hw.constant 0 : i4
    %8 = hw.aggregate_constant [0 : i32, 0 : i4] : !hw.struct<data: i32, mask: i4>
    %9 = hw.aggregate_constant [[[false, false], [false, false], [false, false]], [[0 : i6], [0 : i4], [false], [false], [false], [false], [false]], [[0 : i6], [false], [false], [false]], [0 : i32, false], [[0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32]], [[0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32]], [0 : i32], [0 : i32]] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>
    %10 = hw.aggregate_constant [[[false], [false], [false]], [[false], [false], [false]], [[false, false], [false, false], [false, false]], [false, false], [[0 : i6, false], [0 : i4, false], [false, false], [false, false], [false, false], [false, false], [false, false]], [[false, false], [false, false], [false, false], [false, false]], [0 : i32, false], [[0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false]], [[0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false]], [0 : i32, false], [0 : i32, false]] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
    %11 = hw.aggregate_constant [[false, false]] : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %c3_i32 = hw.constant 3 : i32
    %c5_i32 = hw.constant 5 : i32
    %c4_i32 = hw.constant 4 : i32
    %c2_i32 = hw.constant 2 : i32
    %c6_i32 = hw.constant 6 : i32
    %c0_i64 = hw.constant 0 : i64
    %c0_i6 = hw.constant 0 : i6
    %c32_i32 = hw.constant 32 : i32
    %c-1_i4 = hw.constant -1 : i4
    %c-1_i32 = hw.constant -1 : i32 {sv.namehint = "msg_fifo_rdata"}
    %c16_i6 = hw.constant 16 : i6
    %c8_i6 = hw.constant 8 : i6
    %c4_i6 = hw.constant 4 : i6
    %c2_i6 = hw.constant 2 : i6
    %c1_i6 = hw.constant 1 : i6
    %c-32_i6 = hw.constant -32 : i6
    %c-8_i4 = hw.constant -8 : i4
    %c4_i4 = hw.constant 4 : i4
    %c2_i4 = hw.constant 2 : i4
    %c1_i4 = hw.constant 1 : i4
    %c8_i32 = hw.constant 8 : i32
    %c0_i8 = hw.constant 0 : i8
    %c0_i32 = hw.constant 0 : i32
    %c0_i1024 = hw.constant 0 : i1024
    %c1_i32 = hw.constant 1 : i32
    %c31_i32 = hw.constant 31 : i32
    %c-1_i2 = hw.constant -1 : i2 {sv.namehint = "msg_fifo_rerror"}
    %true = hw.constant true
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %c-7_i4 = hw.constant -7 : i4
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %12 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %13 = llhd.prb %rst_ni_1 : i1
    %alert_tx_o = llhd.sig %11 : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %reg2hw = llhd.sig %10 : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
    %hw2reg = llhd.sig %9 : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>
    %secret_key = llhd.sig %c0_i1024 : i1024
    %secret_key_d = llhd.sig %c0_i1024 : i1024
    %key_length_supplied = llhd.sig %c0_i6 : i6
    %key_length = llhd.sig %c0_i6 : i6
    %wipe_secret = llhd.sig %false : i1
    %wipe_v = llhd.sig %c0_i32 : i32
    %fifo_wdata = llhd.sig %8 : !hw.struct<data: i32, mask: i4>
    %fifo_full = llhd.sig %false : i1
    %fifo_empty = llhd.sig %false : i1
    %msg_fifo_wmask = llhd.sig %c0_i32 : i32
    %packer_ready = llhd.sig %false : i1
    %packer_flush_done = llhd.sig %false : i1
    %reg_fifo_wvalid = llhd.sig %false : i1
    %hmac_fifo_wsel = llhd.sig %false : i1
    %hmac_fifo_wvalid = llhd.sig %false : i1
    %hmac_fifo_wdata_sel = llhd.sig %c0_i4 : i4
    %sha_en = llhd.sig %false : i1
    %digest_swap = llhd.sig %false : i1
    %key_swap = llhd.sig %false : i1
    %reg_hash_stop = llhd.sig %false : i1
    %hash_start = llhd.sig %false : i1
    %hash_start_or_continue = llhd.sig %false : i1
    %hash_done_event = llhd.sig %false : i1
    %sha_hash_process = llhd.sig %false : i1
    %digest_on_blk = llhd.sig %false : i1
    %reg_hash_done = llhd.sig %false : i1
    %message_length = llhd.sig %c0_i64 : i64
    %message_length_d = llhd.sig %c0_i64 : i64
    %err_code = llhd.sig %c0_i32 : i32
    %invalid_config_atstart = llhd.sig %false : i1
    %digest = llhd.sig %7 : !hw.array<8xi64>
    %digest_sw = llhd.sig %7 : !hw.array<8xi64>
    %digest_sw_we = llhd.sig %c0_i8 : i8
    %digest_size = llhd.sig %c0_i4 : i4
    %digest_size_supplied = llhd.sig %c0_i4 : i4
    %digest_size_started_d = llhd.sig %c0_i4 : i4
    %digest_size_started_q = llhd.sig %c0_i4 : i4
    %cfg_reg = llhd.sig %6 : !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>
    %cfg_block = llhd.sig %false : i1
    %msg_allowed = llhd.sig %false : i1
    %hash_running = llhd.sig %false : i1
    %done_state_d = llhd.sig %c0_i2 : i2
    %done_state_q = llhd.sig %c0_i2 : i2
    %fifo_empty_negedge = llhd.sig %false : i1
    %fifo_empty_q = llhd.sig %false : i1
    %fifo_full_posedge = llhd.sig %false : i1
    %fifo_full_q = llhd.sig %false : i1
    %fifo_full_seen_d = llhd.sig %false : i1
    %fifo_full_seen_q = llhd.sig %false : i1
    %reg_fifo_wentry = llhd.sig %8 : !hw.struct<data: i32, mask: i4>
    %index = llhd.sig %false : i1
    %msg_write = llhd.sig %false : i1
    %wmask_ones = llhd.sig %c0_i6 : i6
    %alerts = llhd.sig %false : i1
    %hash_start_sha_disabled = llhd.sig %false : i1
    %update_seckey_inprocess = llhd.sig %false : i1
    %hash_start_active = llhd.sig %false : i1
    %msg_push_not_allowed = llhd.sig %false : i1
    %idle_q = llhd.sig %c0_i4 : i4
    %idle_d = llhd.sig %c0_i4 : i4
    %14 = llhd.prb %hash_done_event : i1
    %15 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
    %intr_enable = hw.struct_extract %15["intr_enable"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
    %hmac_done = hw.struct_extract %intr_enable["hmac_done"] : !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>
    %q = hw.struct_extract %hmac_done["q"] : !hw.struct<q: i1>
    %intr_test = hw.struct_extract %15["intr_test"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
    %hmac_done_2 = hw.struct_extract %intr_test["hmac_done"] : !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>
    %q_3 = hw.struct_extract %hmac_done_2["q"] : !hw.struct<q: i1, qe: i1>
    %qe = hw.struct_extract %hmac_done_2["qe"] : !hw.struct<q: i1, qe: i1>
    %intr_state = hw.struct_extract %15["intr_state"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
    %hmac_done_4 = hw.struct_extract %intr_state["hmac_done"] : !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>
    %q_5 = hw.struct_extract %hmac_done_4["q"] : !hw.struct<q: i1>
    %16 = llhd.sig.struct_extract %hw2reg["intr_state"] : <!hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>>
    %17 = llhd.sig.struct_extract %16["hmac_done"] : <!hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>>
    %18 = llhd.sig.struct_extract %17["de"] : <!hw.struct<d: i1, de: i1>>
    %19 = llhd.sig.struct_extract %17["d"] : <!hw.struct<d: i1, de: i1>>
    %intr_hw_hmac_done.hw2reg_intr_state_de_o, %intr_hw_hmac_done.hw2reg_intr_state_d_o, %intr_hw_hmac_done.intr_o = hw.instance "intr_hw_hmac_done" @prim_intr_hw(clk_i: %12: i1, rst_ni: %13: i1, event_intr_i: %14: i1, reg2hw_intr_enable_q_i: %q: i1, reg2hw_intr_test_q_i: %q_3: i1, reg2hw_intr_test_qe_i: %qe: i1, reg2hw_intr_state_q_i: %q_5: i1) -> (hw2reg_intr_state_de_o: i1, hw2reg_intr_state_d_o: i1, intr_o: i1)
    llhd.drv %18, %intr_hw_hmac_done.hw2reg_intr_state_de_o after %5 : i1
    llhd.drv %19, %intr_hw_hmac_done.hw2reg_intr_state_d_o after %5 : i1
    %fifo_empty_6 = hw.struct_extract %intr_enable["fifo_empty"] : !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>
    %q_7 = hw.struct_extract %fifo_empty_6["q"] : !hw.struct<q: i1>
    %fifo_empty_8 = hw.struct_extract %intr_test["fifo_empty"] : !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>
    %q_9 = hw.struct_extract %fifo_empty_8["q"] : !hw.struct<q: i1, qe: i1>
    %qe_10 = hw.struct_extract %fifo_empty_8["qe"] : !hw.struct<q: i1, qe: i1>
    %fifo_empty_11 = hw.struct_extract %intr_state["fifo_empty"] : !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>
    %q_12 = hw.struct_extract %fifo_empty_11["q"] : !hw.struct<q: i1>
    %20 = llhd.sig.struct_extract %16["fifo_empty"] : <!hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>>
    %21 = llhd.sig.struct_extract %20["de"] : <!hw.struct<d: i1, de: i1>>
    %22 = llhd.sig.struct_extract %20["d"] : <!hw.struct<d: i1, de: i1>>
    %intr_hw_fifo_empty.hw2reg_intr_state_de_o, %intr_hw_fifo_empty.hw2reg_intr_state_d_o, %intr_hw_fifo_empty.intr_o = hw.instance "intr_hw_fifo_empty" @prim_intr_hw_0(clk_i: %12: i1, rst_ni: %13: i1, event_intr_i: %193: i1, reg2hw_intr_enable_q_i: %q_7: i1, reg2hw_intr_test_q_i: %q_9: i1, reg2hw_intr_test_qe_i: %qe_10: i1, reg2hw_intr_state_q_i: %q_12: i1) -> (hw2reg_intr_state_de_o: i1, hw2reg_intr_state_d_o: i1, intr_o: i1)
    llhd.drv %21, %intr_hw_fifo_empty.hw2reg_intr_state_de_o after %5 : i1
    llhd.drv %22, %intr_hw_fifo_empty.hw2reg_intr_state_d_o after %5 : i1
    %hmac_err = hw.struct_extract %intr_enable["hmac_err"] : !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>
    %q_13 = hw.struct_extract %hmac_err["q"] : !hw.struct<q: i1>
    %hmac_err_14 = hw.struct_extract %intr_test["hmac_err"] : !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>
    %q_15 = hw.struct_extract %hmac_err_14["q"] : !hw.struct<q: i1, qe: i1>
    %qe_16 = hw.struct_extract %hmac_err_14["qe"] : !hw.struct<q: i1, qe: i1>
    %hmac_err_17 = hw.struct_extract %intr_state["hmac_err"] : !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>
    %q_18 = hw.struct_extract %hmac_err_17["q"] : !hw.struct<q: i1>
    %23 = llhd.sig.struct_extract %16["hmac_err"] : <!hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>>
    %24 = llhd.sig.struct_extract %23["de"] : <!hw.struct<d: i1, de: i1>>
    %25 = llhd.sig.struct_extract %23["d"] : <!hw.struct<d: i1, de: i1>>
    %intr_hw_hmac_err.hw2reg_intr_state_de_o, %intr_hw_hmac_err.hw2reg_intr_state_d_o, %intr_hw_hmac_err.intr_o = hw.instance "intr_hw_hmac_err" @prim_intr_hw(clk_i: %12: i1, rst_ni: %13: i1, event_intr_i: %244: i1, reg2hw_intr_enable_q_i: %q_13: i1, reg2hw_intr_test_q_i: %q_15: i1, reg2hw_intr_test_qe_i: %qe_16: i1, reg2hw_intr_state_q_i: %q_18: i1) -> (hw2reg_intr_state_de_o: i1, hw2reg_intr_state_d_o: i1, intr_o: i1)
    llhd.drv %24, %intr_hw_hmac_err.hw2reg_intr_state_de_o after %5 : i1
    llhd.drv %25, %intr_hw_hmac_err.hw2reg_intr_state_d_o after %5 : i1
    %26 = llhd.prb %sha_en : i1
    %27 = comb.and %208, %26 : i1
    %28 = llhd.prb %fifo_wdata : !hw.struct<data: i32, mask: i4>
    %29 = hw.bitcast %28 : (!hw.struct<data: i32, mask: i4>) -> i36
    %u_msg_fifo.wready_o, %u_msg_fifo.rvalid_o, %u_msg_fifo.rdata_o, %u_msg_fifo.full_o, %u_msg_fifo.depth_o, %u_msg_fifo.err_o = hw.instance "u_msg_fifo" @prim_fifo_sync(clk_i: %12: i1, rst_ni: %13: i1, clr_i: %false: i1, wvalid_i: %27: i1, wdata_i: %29: i36, rready_i: %u_hmac.fifo_rready_o: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i36, full_o: i1, depth_o: i6, err_o: i1) {sv.namehint = "fifo_depth"}
    %30 = hw.bitcast %u_msg_fifo.rdata_o {sv.namehint = "fifo_rdata"} : (i36) -> !hw.struct<data: i32, mask: i4>
    llhd.drv %fifo_full, %u_msg_fifo.full_o after %5 : i1
    %u_tlul_adapter.tl_o, %u_tlul_adapter.req_o, %u_tlul_adapter.req_type_o, %u_tlul_adapter.we_o, %u_tlul_adapter.addr_o, %u_tlul_adapter.wdata_o, %u_tlul_adapter.wmask_o, %u_tlul_adapter.intg_error_o, %u_tlul_adapter.user_rsvd_o, %u_tlul_adapter.compound_txn_in_progress_o, %u_tlul_adapter.readback_error_o = hw.instance "u_tlul_adapter" @tlul_adapter_sram(clk_i: %12: i1, rst_ni: %13: i1, tl_i: %u_reg.tl_win_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %c-7_i4: i4, gnt_i: %195: i1, rdata_i: %c-1_i32: i32, rvalid_i: %false: i1, rerror_i: %c-1_i2: i2, readback_en_i: %c-7_i4: i4, wr_collision_i: %false: i1, write_pending_i: %false: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, req_o: i1, req_type_o: i4, we_o: i1, addr_o: i9, wdata_o: i32, wmask_o: i32, intg_error_o: i1, user_rsvd_o: i5, compound_txn_in_progress_o: i1, readback_error_o: i1) {sv.namehint = "tl_win_d2h"}
    llhd.drv %msg_fifo_wmask, %u_tlul_adapter.wmask_o after %5 : i32
    %31 = llhd.prb %msg_write : i1
    %32 = comb.and %31, %26 : i1
    %33 = llhd.prb %hmac_fifo_wsel : i1
    %34 = comb.xor %33, %true : i1
    %35 = comb.and %u_msg_fifo.wready_o, %34 : i1
    %u_packer.ready_o, %u_packer.valid_o, %u_packer.data_o, %u_packer.mask_o, %u_packer.flush_done_o, %u_packer.err_o = hw.instance "u_packer" @prim_packer(clk_i: %12: i1, rst_ni: %13: i1, valid_i: %32: i1, data_i: %222: i32, mask_i: %223: i32, ready_i: %35: i1, flush_i: %171: i1) -> (ready_o: i1, valid_o: i1, data_o: i32, mask_o: i32, flush_done_o: i1, err_o: i1) {sv.namehint = "reg_fifo_wmask"}
    llhd.drv %packer_ready, %u_packer.ready_o after %5 : i1
    llhd.drv %reg_fifo_wvalid, %u_packer.valid_o after %5 : i1
    llhd.drv %packer_flush_done, %u_packer.flush_done_o after %5 : i1
    %36 = llhd.prb %secret_key : i1024
    %37 = llhd.prb %digest_size : i4
    %38 = llhd.prb %key_length : i6
    %39 = llhd.prb %hash_start : i1
    %40 = llhd.prb %reg_hash_stop : i1
    %41 = llhd.prb %packer_flush_done : i1
    %42 = llhd.prb %message_length : i64
    %u_hmac.hash_done_o, %u_hmac.sha_hash_start_o, %u_hmac.sha_hash_continue_o, %u_hmac.sha_hash_process_o, %u_hmac.sha_rvalid_o, %u_hmac.sha_rdata_o, %u_hmac.fifo_rready_o, %u_hmac.fifo_wsel_o, %u_hmac.fifo_wvalid_o, %u_hmac.fifo_wdata_sel_o, %u_hmac.sha_message_length_o, %u_hmac.idle_o = hw.instance "u_hmac" @hmac_core(clk_i: %12: i1, rst_ni: %13: i1, secret_key_i: %36: i1024, hmac_en_i: %q_28: i1, digest_size_i: %37: i4, key_length_i: %38: i6, reg_hash_start_i: %39: i1, reg_hash_stop_i: %40: i1, reg_hash_continue_i: %170: i1, reg_hash_process_i: %41: i1, sha_hash_done_i: %u_prim_sha2_512.hash_done_o: i1, sha_rready_i: %u_prim_sha2_512.fifo_rready_o: i1, fifo_rvalid_i: %u_msg_fifo.rvalid_o: i1, fifo_rdata_i: %30: !hw.struct<data: i32, mask: i4>, fifo_wready_i: %u_msg_fifo.wready_o: i1, message_length_i: %42: i64) -> (hash_done_o: i1, sha_hash_start_o: i1, sha_hash_continue_o: i1, sha_hash_process_o: i1, sha_rvalid_o: i1, sha_rdata_o: !hw.struct<data: i32, mask: i4>, fifo_rready_o: i1, fifo_wsel_o: i1, fifo_wvalid_o: i1, fifo_wdata_sel_o: i4, sha_message_length_o: i64, idle_o: i1) {sv.namehint = "shaf_rdata"}
    llhd.drv %reg_hash_done, %u_hmac.hash_done_o after %5 : i1
    llhd.drv %sha_hash_process, %u_hmac.sha_hash_process_o after %5 : i1
    llhd.drv %hmac_fifo_wsel, %u_hmac.fifo_wsel_o after %5 : i1
    llhd.drv %hmac_fifo_wvalid, %u_hmac.fifo_wvalid_o after %5 : i1
    llhd.drv %hmac_fifo_wdata_sel, %u_hmac.fifo_wdata_sel_o after %5 : i4
    %43 = llhd.prb %wipe_secret : i1
    %44 = llhd.prb %wipe_v : i32
    %45 = llhd.prb %sha_hash_process : i1
    %46 = llhd.prb %digest_sw : !hw.array<8xi64>
    %47 = llhd.prb %digest_sw_we : i8
    %u_prim_sha2_512.fifo_rready_o, %u_prim_sha2_512.hash_done_o, %u_prim_sha2_512.digest_o, %u_prim_sha2_512.digest_on_blk_o, %u_prim_sha2_512.hash_running_o, %u_prim_sha2_512.idle_o = hw.instance "u_prim_sha2_512" @prim_sha2_32(clk_i: %12: i1, rst_ni: %13: i1, wipe_secret_i: %43: i1, wipe_v_i: %44: i32, fifo_rvalid_i: %u_hmac.sha_rvalid_o: i1, fifo_rdata_i: %u_hmac.sha_rdata_o: !hw.struct<data: i32, mask: i4>, sha_en_i: %26: i1, hash_start_i: %u_hmac.sha_hash_start_o: i1, hash_stop_i: %40: i1, hash_continue_i: %u_hmac.sha_hash_continue_o: i1, digest_mode_i: %37: i4, hash_process_i: %45: i1, message_length_i: %u_hmac.sha_message_length_o: i64, digest_i: %46: !hw.array<8xi64>, digest_we_i: %47: i8) -> (fifo_rready_o: i1, hash_done_o: i1, digest_o: !hw.array<8xi64>, digest_on_blk_o: i1, hash_running_o: i1, idle_o: i1) {sv.namehint = "shaf_rready"}
    llhd.drv %digest, %u_prim_sha2_512.digest_o after %5 : !hw.array<8xi64>
    llhd.drv %digest_on_blk, %u_prim_sha2_512.digest_on_blk_o after %5 : i1
    llhd.drv %hash_running, %u_prim_sha2_512.hash_running_o after %5 : i1
    %48 = llhd.prb %hw2reg : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>
    %u_reg.tl_o, %u_reg.tl_win_o, %u_reg.reg2hw, %u_reg.intg_err_o = hw.instance "u_reg" @hmac_reg_top(clk_i: %12: i1, rst_ni: %13: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, tl_win_i: %u_tlul_adapter.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, hw2reg: %48: !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tl_win_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, reg2hw: !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>, intg_err_o: i1) {sv.namehint = "tl_win_h2d"}
    llhd.drv %reg2hw, %u_reg.reg2hw after %5 : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
    llhd.drv %alerts, %u_reg.intg_err_o after %5 : i1
    %49 = llhd.prb %alerts : i1
    %50 = hw.array_get %alert_rx_i[%c0_i0] : !hw.array<1xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, i0
    %51 = llhd.sig.array_get %alert_tx_o[%c0_i0] : <!hw.array<1xstruct<alert_p: i1, alert_n: i1>>>
    %gen_alert_tx_0.u_prim_alert_sender.alert_ack_o, %gen_alert_tx_0.u_prim_alert_sender.alert_state_o, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o = hw.instance "gen_alert_tx_0.u_prim_alert_sender" @prim_alert_sender(clk_i: %12: i1, rst_ni: %13: i1, alert_test_i: %224: i1, alert_req_i: %49: i1, alert_rx_i: %50: !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>) -> (alert_ack_o: i1, alert_state_o: i1, alert_tx_o: !hw.struct<alert_p: i1, alert_n: i1>)
    llhd.drv %51, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o after %5 : !hw.struct<alert_p: i1, alert_n: i1>
    %52 = llhd.sig.struct_extract %hw2reg["status"] : <!hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>>
    %53 = llhd.sig.struct_extract %52["fifo_full"] : <!hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>>
    %54 = llhd.sig.struct_extract %53["d"] : <!hw.struct<d: i1>>
    %55 = llhd.prb %fifo_full : i1
    llhd.drv %54, %55 after %5 : i1
    %56 = llhd.sig.struct_extract %52["fifo_empty"] : <!hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>>
    %57 = llhd.sig.struct_extract %56["d"] : <!hw.struct<d: i1>>
    %58 = llhd.prb %fifo_empty : i1
    llhd.drv %57, %58 after %5 : i1
    %59 = llhd.sig.struct_extract %52["fifo_depth"] : <!hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>>
    %60 = llhd.sig.struct_extract %59["d"] : <!hw.struct<d: i6>>
    llhd.drv %60, %u_msg_fifo.depth_o after %5 : i6
    %61 = llhd.sig.struct_extract %52["hmac_idle"] : <!hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>>
    %62 = llhd.sig.struct_extract %61["d"] : <!hw.struct<d: i1>>
    llhd.drv %62, %246 after %5 : i1
    %63 = llhd.prb %done_state_q : i2
    %64 = llhd.prb %done_state_d : i2
    %65 = llhd.prb %reg_hash_done : i1
    %66 = llhd.prb %digest_on_blk : i1
    %67 = llhd.prb %hash_running : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb14
      %250 = llhd.prb %done_state_q : i2
      llhd.drv %done_state_d, %250 after %5 : i2
      llhd.drv %hash_done_event, %false after %5 : i1
      %251 = llhd.prb %done_state_q : i2
      %252 = comb.icmp ceq %251, %c0_i2 : i2
      cf.cond_br %252, ^bb2, ^bb6
    ^bb2:  // pred: ^bb1
      %253 = llhd.prb %sha_hash_process : i1
      cf.cond_br %253, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %done_state_d, %c1_i2 after %5 : i2
      cf.br ^bb14
    ^bb4:  // pred: ^bb2
      %254 = llhd.prb %reg_hash_stop : i1
      cf.cond_br %254, ^bb5, ^bb14
    ^bb5:  // pred: ^bb4
      llhd.drv %done_state_d, %c-2_i2 after %5 : i2
      cf.br ^bb14
    ^bb6:  // pred: ^bb1
      %255 = comb.icmp ceq %251, %c1_i2 : i2
      cf.cond_br %255, ^bb7, ^bb9
    ^bb7:  // pred: ^bb6
      %256 = llhd.prb %reg_hash_done : i1
      cf.cond_br %256, ^bb8, ^bb14
    ^bb8:  // pred: ^bb7
      llhd.drv %hash_done_event, %true after %5 : i1
      llhd.drv %done_state_d, %c0_i2 after %5 : i2
      cf.br ^bb14
    ^bb9:  // pred: ^bb6
      %257 = comb.icmp ceq %251, %c-2_i2 : i2
      cf.cond_br %257, ^bb10, ^bb12
    ^bb10:  // pred: ^bb9
      %258 = llhd.prb %digest_on_blk : i1
      cf.cond_br %258, ^bb11, ^bb14
    ^bb11:  // pred: ^bb10
      llhd.drv %done_state_d, %c-1_i2 after %5 : i2
      cf.br ^bb14
    ^bb12:  // pred: ^bb9
      %259 = llhd.prb %hash_running : i1
      %260 = comb.xor %259, %true : i1
      cf.cond_br %260, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      llhd.drv %hash_done_event, %true after %5 : i1
      llhd.drv %done_state_d, %c0_i2 after %5 : i2
      cf.br ^bb14
    ^bb14:  // 9 preds: ^bb3, ^bb4, ^bb5, ^bb7, ^bb8, ^bb10, ^bb11, ^bb12, ^bb13
      llhd.wait (%63, %64, %14, %45, %40, %65, %66, %67 : i2, i2, i1, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %250 = llhd.prb %clk_i_0 : i1
      %251 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%12, %13 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %252 = llhd.prb %clk_i_0 : i1
      %253 = comb.xor bin %250, %true : i1
      %254 = comb.and bin %253, %252 : i1
      %255 = llhd.prb %rst_ni_1 : i1
      %256 = comb.xor bin %255, %true : i1
      %257 = comb.and bin %251, %256 : i1
      %258 = comb.or bin %254, %257 : i1
      cf.cond_br %258, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %259 = llhd.prb %rst_ni_1 : i1
      %260 = comb.xor %259, %true : i1
      cf.cond_br %260, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %done_state_q, %c0_i2 after %4 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %261 = llhd.prb %done_state_d : i2
      llhd.drv %done_state_q, %261 after %4 : i2
      cf.br ^bb1
    }
    %wipe_secret_19 = hw.struct_extract %15["wipe_secret"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
    %qe_20 = hw.struct_extract %wipe_secret_19["qe"] : !hw.struct<q: i32, qe: i1>
    llhd.drv %wipe_secret, %qe_20 after %5 : i1
    %q_21 = hw.struct_extract %wipe_secret_19["q"] : !hw.struct<q: i32, qe: i1>
    llhd.drv %wipe_v, %q_21 after %5 : i32
    %68 = llhd.prb %secret_key_d : i1024
    %69 = llhd.prb %cfg_block : i1
    %70 = llhd.prb %key_swap : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb8
      %250 = llhd.prb %secret_key : i1024
      llhd.drv %secret_key_d, %250 after %5 : i1024
      %251 = llhd.prb %wipe_secret : i1
      cf.cond_br %251, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %252 = llhd.prb %wipe_v : i32
      %253 = comb.replicate %252 : (i32) -> i1024
      llhd.drv %secret_key_d, %253 after %5 : i1024
      cf.br ^bb8
    ^bb3:  // pred: ^bb1
      %254 = llhd.prb %cfg_block : i1
      %255 = comb.xor %254, %true : i1
      cf.cond_br %255, ^bb4(%c0_i32 : i32), ^bb8
    ^bb4(%256: i32):  // 2 preds: ^bb3, ^bb7
      %257 = comb.icmp slt %256, %c32_i32 : i32
      cf.cond_br %257, ^bb5, ^bb8
    ^bb5:  // pred: ^bb4
      %258 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %key = hw.struct_extract %258["key"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %259 = comb.sub %c31_i32, %256 : i32
      %260 = comb.extract %259 from 5 : (i32) -> i27
      %261 = comb.icmp eq %260, %c0_i27 : i27
      %262 = comb.extract %259 from 0 : (i32) -> i5
      %263 = comb.mux %261, %262, %c-1_i5 : i5
      %264 = hw.array_get %key[%263] : !hw.array<32xstruct<q: i32, qe: i1>>, i5
      %qe_45 = hw.struct_extract %264["qe"] : !hw.struct<q: i32, qe: i1>
      cf.cond_br %qe_45, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %265 = comb.extract %256 from 5 : (i32) -> i22
      %266 = comb.icmp eq %265, %c0_i22 : i22
      %267 = comb.extract %256 from 0 : (i32) -> i5
      %268 = comb.concat %267, %c0_i5 : i5, i5
      %269 = comb.mux %266, %268, %c-1_i10 : i10
      %270 = llhd.sig.extract %secret_key_d from %269 : <i1024> -> <i32>
      %271 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %key_46 = hw.struct_extract %271["key"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %272 = hw.array_get %key_46[%263] : !hw.array<32xstruct<q: i32, qe: i1>>, i5
      %q_47 = hw.struct_extract %272["q"] : !hw.struct<q: i32, qe: i1>
      %273 = llhd.prb %key_swap : i1
      %274 = func.call @"prim_sha2_pkg::conv_endian32"(%q_47, %273) : (i32, i1) -> i32
      llhd.drv %270, %274 after %5 : i32
      cf.br ^bb7
    ^bb7:  // 2 preds: ^bb5, ^bb6
      %275 = comb.add %256, %c1_i32 : i32
      cf.br ^bb4(%275 : i32)
    ^bb8:  // 3 preds: ^bb2, ^bb3, ^bb4
      llhd.wait (%36, %68, %43, %44, %69, %15, %70 : i1024, i1024, i1, i32, i1, !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %250 = llhd.prb %clk_i_0 : i1
      %251 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%12, %13 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %252 = llhd.prb %clk_i_0 : i1
      %253 = comb.xor bin %250, %true : i1
      %254 = comb.and bin %253, %252 : i1
      %255 = llhd.prb %rst_ni_1 : i1
      %256 = comb.xor bin %255, %true : i1
      %257 = comb.and bin %251, %256 : i1
      %258 = comb.or bin %254, %257 : i1
      cf.cond_br %258, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %259 = llhd.prb %rst_ni_1 : i1
      %260 = comb.xor %259, %true : i1
      cf.cond_br %260, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %secret_key, %c0_i1024 after %4 : i1024
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %261 = llhd.prb %secret_key_d : i1024
      llhd.drv %secret_key, %261 after %4 : i1024
      cf.br ^bb1
    }
    %71 = llhd.sig.struct_extract %hw2reg["key"] : <!hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>>
    %72 = llhd.sig.array_get %71[%c-1_i5] : <!hw.array<32xstruct<d: i32>>>
    %73 = llhd.sig.struct_extract %72["d"] : <!hw.struct<d: i32>>
    llhd.drv %73, %c0_i32 after %5 : i32
    %74 = llhd.sig.array_get %71[%c-2_i5] : <!hw.array<32xstruct<d: i32>>>
    %75 = llhd.sig.struct_extract %74["d"] : <!hw.struct<d: i32>>
    llhd.drv %75, %c0_i32 after %5 : i32
    %76 = llhd.sig.array_get %71[%c-3_i5] : <!hw.array<32xstruct<d: i32>>>
    %77 = llhd.sig.struct_extract %76["d"] : <!hw.struct<d: i32>>
    llhd.drv %77, %c0_i32 after %5 : i32
    %78 = llhd.sig.array_get %71[%c-4_i5] : <!hw.array<32xstruct<d: i32>>>
    %79 = llhd.sig.struct_extract %78["d"] : <!hw.struct<d: i32>>
    llhd.drv %79, %c0_i32 after %5 : i32
    %80 = llhd.sig.array_get %71[%c-5_i5] : <!hw.array<32xstruct<d: i32>>>
    %81 = llhd.sig.struct_extract %80["d"] : <!hw.struct<d: i32>>
    llhd.drv %81, %c0_i32 after %5 : i32
    %82 = llhd.sig.array_get %71[%c-6_i5] : <!hw.array<32xstruct<d: i32>>>
    %83 = llhd.sig.struct_extract %82["d"] : <!hw.struct<d: i32>>
    llhd.drv %83, %c0_i32 after %5 : i32
    %84 = llhd.sig.array_get %71[%c-7_i5] : <!hw.array<32xstruct<d: i32>>>
    %85 = llhd.sig.struct_extract %84["d"] : <!hw.struct<d: i32>>
    llhd.drv %85, %c0_i32 after %5 : i32
    %86 = llhd.sig.array_get %71[%c-8_i5] : <!hw.array<32xstruct<d: i32>>>
    %87 = llhd.sig.struct_extract %86["d"] : <!hw.struct<d: i32>>
    llhd.drv %87, %c0_i32 after %5 : i32
    %88 = llhd.sig.array_get %71[%c-9_i5] : <!hw.array<32xstruct<d: i32>>>
    %89 = llhd.sig.struct_extract %88["d"] : <!hw.struct<d: i32>>
    llhd.drv %89, %c0_i32 after %5 : i32
    %90 = llhd.sig.array_get %71[%c-10_i5] : <!hw.array<32xstruct<d: i32>>>
    %91 = llhd.sig.struct_extract %90["d"] : <!hw.struct<d: i32>>
    llhd.drv %91, %c0_i32 after %5 : i32
    %92 = llhd.sig.array_get %71[%c-11_i5] : <!hw.array<32xstruct<d: i32>>>
    %93 = llhd.sig.struct_extract %92["d"] : <!hw.struct<d: i32>>
    llhd.drv %93, %c0_i32 after %5 : i32
    %94 = llhd.sig.array_get %71[%c-12_i5] : <!hw.array<32xstruct<d: i32>>>
    %95 = llhd.sig.struct_extract %94["d"] : <!hw.struct<d: i32>>
    llhd.drv %95, %c0_i32 after %5 : i32
    %96 = llhd.sig.array_get %71[%c-13_i5] : <!hw.array<32xstruct<d: i32>>>
    %97 = llhd.sig.struct_extract %96["d"] : <!hw.struct<d: i32>>
    llhd.drv %97, %c0_i32 after %5 : i32
    %98 = llhd.sig.array_get %71[%c-14_i5] : <!hw.array<32xstruct<d: i32>>>
    %99 = llhd.sig.struct_extract %98["d"] : <!hw.struct<d: i32>>
    llhd.drv %99, %c0_i32 after %5 : i32
    %100 = llhd.sig.array_get %71[%c-15_i5] : <!hw.array<32xstruct<d: i32>>>
    %101 = llhd.sig.struct_extract %100["d"] : <!hw.struct<d: i32>>
    llhd.drv %101, %c0_i32 after %5 : i32
    %102 = llhd.sig.array_get %71[%c-16_i5] : <!hw.array<32xstruct<d: i32>>>
    %103 = llhd.sig.struct_extract %102["d"] : <!hw.struct<d: i32>>
    llhd.drv %103, %c0_i32 after %5 : i32
    %104 = llhd.sig.array_get %71[%c15_i5] : <!hw.array<32xstruct<d: i32>>>
    %105 = llhd.sig.struct_extract %104["d"] : <!hw.struct<d: i32>>
    llhd.drv %105, %c0_i32 after %5 : i32
    %106 = llhd.sig.array_get %71[%c14_i5] : <!hw.array<32xstruct<d: i32>>>
    %107 = llhd.sig.struct_extract %106["d"] : <!hw.struct<d: i32>>
    llhd.drv %107, %c0_i32 after %5 : i32
    %108 = llhd.sig.array_get %71[%c13_i5] : <!hw.array<32xstruct<d: i32>>>
    %109 = llhd.sig.struct_extract %108["d"] : <!hw.struct<d: i32>>
    llhd.drv %109, %c0_i32 after %5 : i32
    %110 = llhd.sig.array_get %71[%c12_i5] : <!hw.array<32xstruct<d: i32>>>
    %111 = llhd.sig.struct_extract %110["d"] : <!hw.struct<d: i32>>
    llhd.drv %111, %c0_i32 after %5 : i32
    %112 = llhd.sig.array_get %71[%c11_i5] : <!hw.array<32xstruct<d: i32>>>
    %113 = llhd.sig.struct_extract %112["d"] : <!hw.struct<d: i32>>
    llhd.drv %113, %c0_i32 after %5 : i32
    %114 = llhd.sig.array_get %71[%c10_i5] : <!hw.array<32xstruct<d: i32>>>
    %115 = llhd.sig.struct_extract %114["d"] : <!hw.struct<d: i32>>
    llhd.drv %115, %c0_i32 after %5 : i32
    %116 = llhd.sig.array_get %71[%c9_i5] : <!hw.array<32xstruct<d: i32>>>
    %117 = llhd.sig.struct_extract %116["d"] : <!hw.struct<d: i32>>
    llhd.drv %117, %c0_i32 after %5 : i32
    %118 = llhd.sig.array_get %71[%c8_i5] : <!hw.array<32xstruct<d: i32>>>
    %119 = llhd.sig.struct_extract %118["d"] : <!hw.struct<d: i32>>
    llhd.drv %119, %c0_i32 after %5 : i32
    %120 = llhd.sig.array_get %71[%c7_i5] : <!hw.array<32xstruct<d: i32>>>
    %121 = llhd.sig.struct_extract %120["d"] : <!hw.struct<d: i32>>
    llhd.drv %121, %c0_i32 after %5 : i32
    %122 = llhd.sig.array_get %71[%c6_i5] : <!hw.array<32xstruct<d: i32>>>
    %123 = llhd.sig.struct_extract %122["d"] : <!hw.struct<d: i32>>
    llhd.drv %123, %c0_i32 after %5 : i32
    %124 = llhd.sig.array_get %71[%c5_i5] : <!hw.array<32xstruct<d: i32>>>
    %125 = llhd.sig.struct_extract %124["d"] : <!hw.struct<d: i32>>
    llhd.drv %125, %c0_i32 after %5 : i32
    %126 = llhd.sig.array_get %71[%c4_i5] : <!hw.array<32xstruct<d: i32>>>
    %127 = llhd.sig.struct_extract %126["d"] : <!hw.struct<d: i32>>
    llhd.drv %127, %c0_i32 after %5 : i32
    %128 = llhd.sig.array_get %71[%c3_i5] : <!hw.array<32xstruct<d: i32>>>
    %129 = llhd.sig.struct_extract %128["d"] : <!hw.struct<d: i32>>
    llhd.drv %129, %c0_i32 after %5 : i32
    %130 = llhd.sig.array_get %71[%c2_i5] : <!hw.array<32xstruct<d: i32>>>
    %131 = llhd.sig.struct_extract %130["d"] : <!hw.struct<d: i32>>
    llhd.drv %131, %c0_i32 after %5 : i32
    %132 = llhd.sig.array_get %71[%c1_i5] : <!hw.array<32xstruct<d: i32>>>
    %133 = llhd.sig.struct_extract %132["d"] : <!hw.struct<d: i32>>
    llhd.drv %133, %c0_i32 after %5 : i32
    %134 = llhd.sig.array_get %71[%c0_i5] : <!hw.array<32xstruct<d: i32>>>
    %135 = llhd.sig.struct_extract %134["d"] : <!hw.struct<d: i32>>
    llhd.drv %135, %c0_i32 after %5 : i32
    %136 = llhd.prb %digest_swap : i1
    %137 = llhd.prb %digest_size_started_q : i4
    %138 = llhd.prb %digest : !hw.array<8xi64>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb19
      llhd.drv %digest_sw, %7 after %5 : !hw.array<8xi64>
      llhd.drv %digest_sw_we, %c0_i8 after %5 : i8
      %250 = llhd.sig.struct_extract %hw2reg["digest"] : <!hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>>
      llhd.drv %250, %3 after %5 : !hw.array<16xstruct<d: i32>>
      %i = llhd.sig %c0_i32 : i32
      llhd.drv %i, %c0_i32 after %5 : i32
      cf.br ^bb2
    ^bb2:  // 2 preds: ^bb1, ^bb18
      %251 = llhd.prb %i : i32
      %252 = comb.icmp slt %251, %c8_i32 : i32
      cf.cond_br %252, ^bb3, ^bb19
    ^bb3:  // pred: ^bb2
      %253 = llhd.prb %digest_size : i4
      %254 = comb.icmp eq %253, %c1_i4 : i4
      cf.cond_br %254, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %255 = llhd.prb %i : i32
      %256 = comb.extract %255 from 3 : (i32) -> i29
      %257 = comb.icmp eq %256, %c0_i29 : i29
      %258 = comb.extract %255 from 0 : (i32) -> i3
      %259 = comb.mux %257, %258, %c-1_i3 : i3
      %260 = llhd.sig.array_get %digest_sw[%259] : <!hw.array<8xi64>>
      %261 = llhd.sig.extract %260 from %c0_i6 : <i64> -> <i32>
      %262 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %digest_45 = hw.struct_extract %262["digest"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %263 = comb.extract %255 from 4 : (i32) -> i28
      %264 = comb.icmp eq %263, %c0_i28 : i28
      %265 = comb.extract %255 from 0 : (i32) -> i4
      %266 = comb.mux %264, %265, %c-1_i4 : i4
      %267 = hw.array_get %digest_45[%266] : !hw.array<16xstruct<q: i32, qe: i1>>, i4
      %q_46 = hw.struct_extract %267["q"] : !hw.struct<q: i32, qe: i1>
      %268 = llhd.prb %digest_swap : i1
      %269 = func.call @"prim_sha2_pkg::conv_endian32"(%q_46, %268) : (i32, i1) -> i32
      llhd.drv %261, %269 after %5 : i32
      %270 = llhd.prb %i : i32
      %271 = comb.extract %270 from 3 : (i32) -> i29
      %272 = comb.icmp eq %271, %c0_i29 : i29
      %273 = comb.extract %270 from 0 : (i32) -> i3
      %274 = comb.mux %272, %273, %c-1_i3 : i3
      %275 = llhd.sig.extract %digest_sw_we from %274 : <i8> -> <i1>
      %276 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %digest_47 = hw.struct_extract %276["digest"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %277 = comb.extract %270 from 4 : (i32) -> i28
      %278 = comb.icmp eq %277, %c0_i28 : i28
      %279 = comb.extract %270 from 0 : (i32) -> i4
      %280 = comb.mux %278, %279, %c-1_i4 : i4
      %281 = hw.array_get %digest_47[%280] : !hw.array<16xstruct<q: i32, qe: i1>>, i4
      %qe_48 = hw.struct_extract %281["qe"] : !hw.struct<q: i32, qe: i1>
      llhd.drv %275, %qe_48 after %5 : i1
      cf.br ^bb13
    ^bb5:  // pred: ^bb3
      %282 = llhd.prb %digest_size : i4
      %283 = comb.icmp eq %282, %c2_i4 : i4
      %284 = comb.icmp eq %282, %c4_i4 : i4
      %285 = comb.or %283, %284 : i1
      cf.cond_br %285, ^bb6, ^bb13
    ^bb6:  // pred: ^bb5
      %286 = llhd.prb %i : i32
      %287 = comb.extract %286 from 3 : (i32) -> i29
      %288 = comb.icmp eq %287, %c0_i29 : i29
      %289 = comb.extract %286 from 0 : (i32) -> i3
      %290 = comb.mux %288, %289, %c-1_i3 : i3
      %291 = llhd.sig.array_get %digest_sw[%290] : <!hw.array<8xi64>>
      %292 = llhd.sig.extract %291 from %c-32_i6 : <i64> -> <i32>
      %293 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %digest_49 = hw.struct_extract %293["digest"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %294 = comb.extract %286 from 3 : (i32) -> i28
      %295 = comb.icmp eq %294, %c0_i28 : i28
      %296 = comb.extract %286 from 0 : (i32) -> i3
      %297 = comb.concat %296, %false : i3, i1
      %298 = comb.mux %295, %297, %c-1_i4 : i4
      %299 = hw.array_get %digest_49[%298] : !hw.array<16xstruct<q: i32, qe: i1>>, i4
      %qe_50 = hw.struct_extract %299["qe"] : !hw.struct<q: i32, qe: i1>
      cf.cond_br %qe_50, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %300 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %digest_51 = hw.struct_extract %300["digest"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %301 = llhd.prb %i : i32
      %302 = comb.extract %301 from 3 : (i32) -> i28
      %303 = comb.icmp eq %302, %c0_i28 : i28
      %304 = comb.extract %301 from 0 : (i32) -> i3
      %305 = comb.concat %304, %false : i3, i1
      %306 = comb.mux %303, %305, %c-1_i4 : i4
      %307 = hw.array_get %digest_51[%306] : !hw.array<16xstruct<q: i32, qe: i1>>, i4
      %q_52 = hw.struct_extract %307["q"] : !hw.struct<q: i32, qe: i1>
      %308 = llhd.prb %digest_swap : i1
      %309 = func.call @"prim_sha2_pkg::conv_endian32"(%q_52, %308) : (i32, i1) -> i32
      cf.br ^bb9(%309 : i32)
    ^bb8:  // pred: ^bb6
      %310 = llhd.prb %digest : !hw.array<8xi64>
      %311 = llhd.prb %i : i32
      %312 = comb.extract %311 from 3 : (i32) -> i29
      %313 = comb.icmp eq %312, %c0_i29 : i29
      %314 = comb.extract %311 from 0 : (i32) -> i3
      %315 = comb.mux %313, %314, %c-1_i3 : i3
      %316 = hw.array_get %310[%315] : !hw.array<8xi64>, i3
      %317 = comb.extract %316 from 32 : (i64) -> i32
      cf.br ^bb9(%317 : i32)
    ^bb9(%318: i32):  // 2 preds: ^bb7, ^bb8
      llhd.drv %292, %318 after %5 : i32
      %319 = llhd.prb %i : i32
      %320 = comb.extract %319 from 3 : (i32) -> i29
      %321 = comb.icmp eq %320, %c0_i29 : i29
      %322 = comb.extract %319 from 0 : (i32) -> i3
      %323 = comb.mux %321, %322, %c-1_i3 : i3
      %324 = llhd.sig.array_get %digest_sw[%323] : <!hw.array<8xi64>>
      %325 = llhd.sig.extract %324 from %c0_i6 : <i64> -> <i32>
      %326 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %digest_53 = hw.struct_extract %326["digest"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %327 = comb.extract %319 from 0 : (i32) -> i31
      %328 = comb.concat %327, %false : i31, i1
      %329 = comb.add %328, %c1_i32 : i32
      %330 = comb.extract %329 from 4 : (i32) -> i28
      %331 = comb.icmp eq %330, %c0_i28 : i28
      %332 = comb.extract %329 from 0 : (i32) -> i4
      %333 = comb.mux %331, %332, %c-1_i4 : i4
      %334 = hw.array_get %digest_53[%333] : !hw.array<16xstruct<q: i32, qe: i1>>, i4
      %qe_54 = hw.struct_extract %334["qe"] : !hw.struct<q: i32, qe: i1>
      cf.cond_br %qe_54, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %335 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %digest_55 = hw.struct_extract %335["digest"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %336 = llhd.prb %i : i32
      %337 = comb.extract %336 from 0 : (i32) -> i31
      %338 = comb.concat %337, %false : i31, i1
      %339 = comb.add %338, %c1_i32 : i32
      %340 = comb.extract %339 from 4 : (i32) -> i28
      %341 = comb.icmp eq %340, %c0_i28 : i28
      %342 = comb.extract %339 from 0 : (i32) -> i4
      %343 = comb.mux %341, %342, %c-1_i4 : i4
      %344 = hw.array_get %digest_55[%343] : !hw.array<16xstruct<q: i32, qe: i1>>, i4
      %q_56 = hw.struct_extract %344["q"] : !hw.struct<q: i32, qe: i1>
      %345 = llhd.prb %digest_swap : i1
      %346 = func.call @"prim_sha2_pkg::conv_endian32"(%q_56, %345) : (i32, i1) -> i32
      cf.br ^bb12(%346 : i32)
    ^bb11:  // pred: ^bb9
      %347 = llhd.prb %digest : !hw.array<8xi64>
      %348 = llhd.prb %i : i32
      %349 = comb.extract %348 from 3 : (i32) -> i29
      %350 = comb.icmp eq %349, %c0_i29 : i29
      %351 = comb.extract %348 from 0 : (i32) -> i3
      %352 = comb.mux %350, %351, %c-1_i3 : i3
      %353 = hw.array_get %347[%352] : !hw.array<8xi64>, i3
      %354 = comb.extract %353 from 0 : (i64) -> i32
      cf.br ^bb12(%354 : i32)
    ^bb12(%355: i32):  // 2 preds: ^bb10, ^bb11
      llhd.drv %325, %355 after %5 : i32
      %356 = llhd.prb %i : i32
      %357 = comb.extract %356 from 3 : (i32) -> i29
      %358 = comb.icmp eq %357, %c0_i29 : i29
      %359 = comb.extract %356 from 0 : (i32) -> i3
      %360 = comb.mux %358, %359, %c-1_i3 : i3
      %361 = llhd.sig.extract %digest_sw_we from %360 : <i8> -> <i1>
      %362 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %digest_57 = hw.struct_extract %362["digest"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %363 = comb.extract %356 from 0 : (i32) -> i31
      %364 = comb.concat %363, %false : i31, i1
      %365 = comb.extract %356 from 3 : (i32) -> i28
      %366 = comb.icmp eq %365, %c0_i28 : i28
      %367 = comb.extract %356 from 0 : (i32) -> i3
      %368 = comb.concat %367, %false : i3, i1
      %369 = comb.mux %366, %368, %c-1_i4 : i4
      %370 = hw.array_get %digest_57[%369] : !hw.array<16xstruct<q: i32, qe: i1>>, i4
      %qe_58 = hw.struct_extract %370["qe"] : !hw.struct<q: i32, qe: i1>
      %371 = comb.add %364, %c1_i32 : i32
      %372 = comb.extract %371 from 4 : (i32) -> i28
      %373 = comb.icmp eq %372, %c0_i28 : i28
      %374 = comb.extract %371 from 0 : (i32) -> i4
      %375 = comb.mux %373, %374, %c-1_i4 : i4
      %376 = hw.array_get %digest_57[%375] : !hw.array<16xstruct<q: i32, qe: i1>>, i4
      %qe_59 = hw.struct_extract %376["qe"] : !hw.struct<q: i32, qe: i1>
      %377 = comb.or %qe_58, %qe_59 : i1
      llhd.drv %361, %377 after %5 : i1
      cf.br ^bb13
    ^bb13:  // 3 preds: ^bb4, ^bb5, ^bb12
      %378 = llhd.prb %digest_size_started_q : i4
      %379 = comb.icmp eq %378, %c1_i4 : i4
      cf.cond_br %379, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %380 = llhd.prb %i : i32
      %381 = comb.extract %380 from 4 : (i32) -> i28
      %382 = comb.icmp eq %381, %c0_i28 : i28
      %383 = comb.extract %380 from 0 : (i32) -> i4
      %384 = comb.mux %382, %383, %c-1_i4 : i4
      %385 = llhd.sig.array_get %250[%384] : <!hw.array<16xstruct<d: i32>>>
      %386 = llhd.sig.struct_extract %385["d"] : <!hw.struct<d: i32>>
      %387 = llhd.prb %digest : !hw.array<8xi64>
      %388 = comb.extract %380 from 3 : (i32) -> i29
      %389 = comb.icmp eq %388, %c0_i29 : i29
      %390 = comb.extract %380 from 0 : (i32) -> i3
      %391 = comb.mux %389, %390, %c-1_i3 : i3
      %392 = hw.array_get %387[%391] : !hw.array<8xi64>, i3
      %393 = comb.extract %392 from 0 : (i64) -> i32
      %394 = llhd.prb %digest_swap : i1
      %395 = func.call @"prim_sha2_pkg::conv_endian32"(%393, %394) : (i32, i1) -> i32
      llhd.drv %386, %395 after %5 : i32
      %396 = llhd.prb %i : i32
      %397 = comb.add %396, %c8_i32 : i32
      %398 = comb.extract %397 from 4 : (i32) -> i28
      %399 = comb.icmp eq %398, %c0_i28 : i28
      %400 = comb.extract %397 from 0 : (i32) -> i4
      %401 = comb.mux %399, %400, %c-1_i4 : i4
      %402 = llhd.sig.array_get %250[%401] : <!hw.array<16xstruct<d: i32>>>
      %403 = llhd.sig.struct_extract %402["d"] : <!hw.struct<d: i32>>
      %404 = llhd.prb %digest : !hw.array<8xi64>
      %405 = comb.extract %396 from 3 : (i32) -> i29
      %406 = comb.icmp eq %405, %c0_i29 : i29
      %407 = comb.extract %396 from 0 : (i32) -> i3
      %408 = comb.mux %406, %407, %c-1_i3 : i3
      %409 = hw.array_get %404[%408] : !hw.array<8xi64>, i3
      %410 = comb.extract %409 from 0 : (i64) -> i32
      %411 = llhd.prb %digest_swap : i1
      %412 = func.call @"prim_sha2_pkg::conv_endian32"(%410, %411) : (i32, i1) -> i32
      llhd.drv %403, %412 after %5 : i32
      cf.br ^bb18
    ^bb15:  // pred: ^bb13
      %413 = llhd.prb %digest_size_started_q : i4
      %414 = comb.icmp eq %413, %c2_i4 : i4
      %415 = comb.icmp eq %413, %c4_i4 : i4
      %416 = comb.or %414, %415 : i1
      cf.cond_br %416, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %417 = llhd.prb %i : i32
      %418 = comb.extract %417 from 3 : (i32) -> i28
      %419 = comb.icmp eq %418, %c0_i28 : i28
      %420 = comb.extract %417 from 0 : (i32) -> i3
      %421 = comb.concat %420, %false : i3, i1
      %422 = comb.mux %419, %421, %c-1_i4 : i4
      %423 = llhd.sig.array_get %250[%422] : <!hw.array<16xstruct<d: i32>>>
      %424 = llhd.sig.struct_extract %423["d"] : <!hw.struct<d: i32>>
      %425 = llhd.prb %digest : !hw.array<8xi64>
      %426 = comb.extract %417 from 3 : (i32) -> i29
      %427 = comb.icmp eq %426, %c0_i29 : i29
      %428 = comb.extract %417 from 0 : (i32) -> i3
      %429 = comb.mux %427, %428, %c-1_i3 : i3
      %430 = hw.array_get %425[%429] : !hw.array<8xi64>, i3
      %431 = comb.extract %430 from 32 : (i64) -> i32
      %432 = llhd.prb %digest_swap : i1
      %433 = func.call @"prim_sha2_pkg::conv_endian32"(%431, %432) : (i32, i1) -> i32
      llhd.drv %424, %433 after %5 : i32
      %434 = llhd.prb %i : i32
      %435 = comb.extract %434 from 0 : (i32) -> i31
      %436 = comb.concat %435, %false : i31, i1
      %437 = comb.add %436, %c1_i32 : i32
      %438 = comb.extract %437 from 4 : (i32) -> i28
      %439 = comb.icmp eq %438, %c0_i28 : i28
      %440 = comb.extract %437 from 0 : (i32) -> i4
      %441 = comb.mux %439, %440, %c-1_i4 : i4
      %442 = llhd.sig.array_get %250[%441] : <!hw.array<16xstruct<d: i32>>>
      %443 = llhd.sig.struct_extract %442["d"] : <!hw.struct<d: i32>>
      %444 = llhd.prb %digest : !hw.array<8xi64>
      %445 = comb.extract %434 from 3 : (i32) -> i29
      %446 = comb.icmp eq %445, %c0_i29 : i29
      %447 = comb.extract %434 from 0 : (i32) -> i3
      %448 = comb.mux %446, %447, %c-1_i3 : i3
      %449 = hw.array_get %444[%448] : !hw.array<8xi64>, i3
      %450 = comb.extract %449 from 0 : (i64) -> i32
      %451 = llhd.prb %digest_swap : i1
      %452 = func.call @"prim_sha2_pkg::conv_endian32"(%450, %451) : (i32, i1) -> i32
      llhd.drv %443, %452 after %5 : i32
      cf.br ^bb18
    ^bb17:  // pred: ^bb15
      %453 = llhd.prb %i : i32
      %454 = comb.extract %453 from 4 : (i32) -> i28
      %455 = comb.icmp eq %454, %c0_i28 : i28
      %456 = comb.extract %453 from 0 : (i32) -> i4
      %457 = comb.mux %455, %456, %c-1_i4 : i4
      %458 = llhd.sig.array_get %250[%457] : <!hw.array<16xstruct<d: i32>>>
      %459 = llhd.sig.struct_extract %458["d"] : <!hw.struct<d: i32>>
      %460 = llhd.prb %digest : !hw.array<8xi64>
      %461 = comb.extract %453 from 3 : (i32) -> i29
      %462 = comb.icmp eq %461, %c0_i29 : i29
      %463 = comb.extract %453 from 0 : (i32) -> i3
      %464 = comb.mux %462, %463, %c-1_i3 : i3
      %465 = hw.array_get %460[%464] : !hw.array<8xi64>, i3
      %466 = comb.extract %465 from 0 : (i64) -> i32
      %467 = llhd.prb %digest_swap : i1
      %468 = func.call @"prim_sha2_pkg::conv_endian32"(%466, %467) : (i32, i1) -> i32
      llhd.drv %459, %468 after %5 : i32
      %469 = llhd.prb %i : i32
      %470 = comb.add %469, %c8_i32 : i32
      %471 = comb.extract %470 from 4 : (i32) -> i28
      %472 = comb.icmp eq %471, %c0_i28 : i28
      %473 = comb.extract %470 from 0 : (i32) -> i4
      %474 = comb.mux %472, %473, %c-1_i4 : i4
      %475 = llhd.sig.array_get %250[%474] : <!hw.array<16xstruct<d: i32>>>
      %476 = llhd.sig.struct_extract %475["d"] : <!hw.struct<d: i32>>
      %477 = llhd.prb %digest : !hw.array<8xi64>
      %478 = comb.extract %469 from 3 : (i32) -> i29
      %479 = comb.icmp eq %478, %c0_i29 : i29
      %480 = comb.extract %469 from 0 : (i32) -> i3
      %481 = comb.mux %479, %480, %c-1_i3 : i3
      %482 = hw.array_get %477[%481] : !hw.array<8xi64>, i3
      %483 = comb.extract %482 from 0 : (i64) -> i32
      %484 = llhd.prb %digest_swap : i1
      %485 = func.call @"prim_sha2_pkg::conv_endian32"(%483, %484) : (i32, i1) -> i32
      llhd.drv %476, %485 after %5 : i32
      cf.br ^bb18
    ^bb18:  // 3 preds: ^bb14, ^bb16, ^bb17
      %486 = llhd.prb %i : i32
      %487 = comb.add %486, %c1_i32 : i32
      llhd.drv %i, %487 after %5 : i32
      cf.br ^bb2
    ^bb19:  // pred: ^bb2
      llhd.wait (%46, %47, %48, %37, %15, %136, %137, %138 : !hw.array<8xi64>, i8, !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>, i4, !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>, i1, i4, !hw.array<8xi64>), ^bb1
    }
    %139 = llhd.prb %cfg_reg : !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>
    %sha_en_22 = hw.struct_extract %139["sha_en"] : !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>
    %hmac_en = hw.struct_extract %139["hmac_en"] : !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>
    %endian_swap = hw.struct_extract %139["endian_swap"] : !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>
    %digest_swap_23 = hw.struct_extract %139["digest_swap"] : !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>
    %key_swap_24 = hw.struct_extract %139["key_swap"] : !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>
    %digest_size_25 = hw.struct_extract %139["digest_size"] : !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>
    %key_length_26 = hw.struct_extract %139["key_length"] : !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>
    %q_27 = hw.struct_extract %sha_en_22["q"] : !hw.struct<q: i1, qe: i1>
    llhd.drv %sha_en, %q_27 after %5 : i1
    %q_28 = hw.struct_extract %hmac_en["q"] {sv.namehint = "hmac_en"} : !hw.struct<q: i1, qe: i1>
    %q_29 = hw.struct_extract %digest_size_25["q"] : !hw.struct<q: i4, qe: i1>
    llhd.drv %digest_size_supplied, %q_29 after %5 : i4
    %140 = llhd.prb %digest_size_supplied : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb8
      llhd.drv %digest_size, %c-8_i4 after %5 : i4
      %250 = llhd.prb %digest_size_supplied : i4
      %251 = comb.icmp ceq %250, %c1_i4 : i4
      cf.cond_br %251, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %digest_size, %c1_i4 after %5 : i4
      cf.br ^bb8
    ^bb3:  // pred: ^bb1
      %252 = comb.icmp ceq %250, %c2_i4 : i4
      cf.cond_br %252, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %digest_size, %c2_i4 after %5 : i4
      cf.br ^bb8
    ^bb5:  // pred: ^bb3
      %253 = comb.icmp ceq %250, %c4_i4 : i4
      cf.cond_br %253, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %digest_size, %c4_i4 after %5 : i4
      cf.br ^bb8
    ^bb7:  // pred: ^bb5
      llhd.drv %digest_size, %c-8_i4 after %5 : i4
      cf.br ^bb8
    ^bb8:  // 4 preds: ^bb2, ^bb4, ^bb6, ^bb7
      llhd.wait (%37, %140 : i4, i4), ^bb1
    }
    %141 = llhd.prb %hash_start_or_continue : i1
    %142 = comb.mux %141, %37, %137 : i4
    llhd.drv %digest_size_started_d, %142 after %5 : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %250 = llhd.prb %clk_i_0 : i1
      %251 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%12, %13 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %252 = llhd.prb %clk_i_0 : i1
      %253 = comb.xor bin %250, %true : i1
      %254 = comb.and bin %253, %252 : i1
      %255 = llhd.prb %rst_ni_1 : i1
      %256 = comb.xor bin %255, %true : i1
      %257 = comb.and bin %251, %256 : i1
      %258 = comb.or bin %254, %257 : i1
      cf.cond_br %258, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %259 = llhd.prb %rst_ni_1 : i1
      %260 = comb.xor %259, %true : i1
      cf.cond_br %260, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %digest_size_started_q, %c-8_i4 after %4 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %261 = llhd.prb %digest_size_started_d : i4
      llhd.drv %digest_size_started_q, %261 after %4 : i4
      cf.br ^bb1
    }
    %q_30 = hw.struct_extract %key_length_26["q"] : !hw.struct<q: i6, qe: i1>
    llhd.drv %key_length_supplied, %q_30 after %5 : i6
    %143 = llhd.prb %key_length_supplied : i6
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb12
      llhd.drv %key_length, %c-32_i6 after %5 : i6
      %250 = llhd.prb %key_length_supplied : i6
      %251 = comb.icmp ceq %250, %c1_i6 : i6
      cf.cond_br %251, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %key_length, %c1_i6 after %5 : i6
      cf.br ^bb12
    ^bb3:  // pred: ^bb1
      %252 = comb.icmp ceq %250, %c2_i6 : i6
      cf.cond_br %252, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %key_length, %c2_i6 after %5 : i6
      cf.br ^bb12
    ^bb5:  // pred: ^bb3
      %253 = comb.icmp ceq %250, %c4_i6 : i6
      cf.cond_br %253, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %key_length, %c4_i6 after %5 : i6
      cf.br ^bb12
    ^bb7:  // pred: ^bb5
      %254 = comb.icmp ceq %250, %c8_i6 : i6
      cf.cond_br %254, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %key_length, %c8_i6 after %5 : i6
      cf.br ^bb12
    ^bb9:  // pred: ^bb7
      %255 = comb.icmp ceq %250, %c16_i6 : i6
      cf.cond_br %255, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      llhd.drv %key_length, %c16_i6 after %5 : i6
      cf.br ^bb12
    ^bb11:  // pred: ^bb9
      llhd.drv %key_length, %c-32_i6 after %5 : i6
      cf.br ^bb12
    ^bb12:  // 6 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb11
      llhd.wait (%38, %143 : i6, i6), ^bb1
    }
    %q_31 = hw.struct_extract %endian_swap["q"] {sv.namehint = "endian_swap"} : !hw.struct<q: i1, qe: i1>
    %q_32 = hw.struct_extract %digest_swap_23["q"] : !hw.struct<q: i1, qe: i1>
    llhd.drv %digest_swap, %q_32 after %5 : i1
    %q_33 = hw.struct_extract %key_swap_24["q"] : !hw.struct<q: i1, qe: i1>
    llhd.drv %key_swap, %q_33 after %5 : i1
    %144 = llhd.sig.struct_extract %hw2reg["cfg"] : <!hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>>
    %145 = llhd.sig.struct_extract %144["hmac_en"] : <!hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>>
    %146 = llhd.sig.struct_extract %145["d"] : <!hw.struct<d: i1>>
    llhd.drv %146, %q_28 after %5 : i1
    %147 = llhd.sig.struct_extract %144["sha_en"] : <!hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>>
    %148 = llhd.sig.struct_extract %147["d"] : <!hw.struct<d: i1>>
    llhd.drv %148, %q_27 after %5 : i1
    %149 = llhd.sig.struct_extract %144["digest_size"] : <!hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>>
    %150 = llhd.sig.struct_extract %149["d"] : <!hw.struct<d: i4>>
    llhd.drv %150, %37 after %5 : i4
    %151 = llhd.sig.struct_extract %144["key_length"] : <!hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>>
    %152 = llhd.sig.struct_extract %151["d"] : <!hw.struct<d: i6>>
    llhd.drv %152, %38 after %5 : i6
    %153 = llhd.sig.struct_extract %144["endian_swap"] : <!hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>>
    %154 = llhd.sig.struct_extract %153["d"] : <!hw.struct<d: i1>>
    llhd.drv %154, %q_31 after %5 : i1
    %155 = llhd.sig.struct_extract %144["digest_swap"] : <!hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>>
    %156 = llhd.sig.struct_extract %155["d"] : <!hw.struct<d: i1>>
    llhd.drv %156, %q_32 after %5 : i1
    %157 = llhd.sig.struct_extract %144["key_swap"] : <!hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>>
    %158 = llhd.sig.struct_extract %157["d"] : <!hw.struct<d: i1>>
    llhd.drv %158, %q_33 after %5 : i1
    %cmd = hw.struct_extract %15["cmd"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
    %hash_start_34 = hw.struct_extract %cmd["hash_start"] : !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>
    %qe_35 = hw.struct_extract %hash_start_34["qe"] : !hw.struct<q: i1, qe: i1>
    %q_36 = hw.struct_extract %hash_start_34["q"] : !hw.struct<q: i1, qe: i1>
    %159 = comb.and %qe_35, %q_36 {sv.namehint = "reg_hash_start"} : i1
    %hash_stop = hw.struct_extract %cmd["hash_stop"] : !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>
    %qe_37 = hw.struct_extract %hash_stop["qe"] : !hw.struct<q: i1, qe: i1>
    %q_38 = hw.struct_extract %hash_stop["q"] : !hw.struct<q: i1, qe: i1>
    %160 = comb.and %qe_37, %q_38 : i1
    llhd.drv %reg_hash_stop, %160 after %5 : i1
    %hash_continue = hw.struct_extract %cmd["hash_continue"] : !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>
    %qe_39 = hw.struct_extract %hash_continue["qe"] : !hw.struct<q: i1, qe: i1>
    %q_40 = hw.struct_extract %hash_continue["q"] : !hw.struct<q: i1, qe: i1>
    %161 = comb.and %qe_39, %q_40 {sv.namehint = "reg_hash_continue"} : i1
    %hash_process = hw.struct_extract %cmd["hash_process"] : !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>
    %qe_41 = hw.struct_extract %hash_process["qe"] : !hw.struct<q: i1, qe: i1>
    %q_42 = hw.struct_extract %hash_process["q"] : !hw.struct<q: i1, qe: i1>
    %162 = comb.and %qe_41, %q_42 {sv.namehint = "reg_hash_process"} : i1
    %163 = llhd.sig.struct_extract %hw2reg["err_code"] : <!hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>>
    %164 = llhd.sig.struct_extract %163["de"] : <!hw.struct<d: i32, de: i1>>
    llhd.drv %164, %244 after %5 : i1
    %165 = llhd.sig.struct_extract %163["d"] : <!hw.struct<d: i32, de: i1>>
    %166 = llhd.prb %err_code : i32
    llhd.drv %165, %166 after %5 : i32
    %167 = comb.xor %69, %true : i1
    %168 = comb.xor %235, %true : i1
    %169 = comb.and %159, %26, %167, %168 : i1
    llhd.drv %hash_start, %169 after %5 : i1
    %170 = comb.and %161, %26, %167, %168 {sv.namehint = "hash_continue"} : i1
    %171 = comb.and %162, %26, %69, %168 {sv.namehint = "hash_process"} : i1
    %172 = comb.or %39, %170 : i1
    llhd.drv %hash_start_or_continue, %172 after %5 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %250 = llhd.prb %clk_i_0 : i1
      %251 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%12, %13 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %252 = llhd.prb %clk_i_0 : i1
      %253 = comb.xor bin %250, %true : i1
      %254 = comb.and bin %253, %252 : i1
      %255 = llhd.prb %rst_ni_1 : i1
      %256 = comb.xor bin %255, %true : i1
      %257 = comb.and bin %251, %256 : i1
      %258 = comb.or bin %254, %257 : i1
      cf.cond_br %258, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %259 = llhd.prb %rst_ni_1 : i1
      %260 = comb.xor %259, %true : i1
      cf.cond_br %260, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cfg_block, %false after %4 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %261 = llhd.prb %hash_start_or_continue : i1
      cf.cond_br %261, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %cfg_block, %true after %4 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %262 = llhd.prb %reg_hash_done : i1
      %263 = llhd.prb %reg_hash_stop : i1
      %264 = comb.or %262, %263 : i1
      cf.cond_br %264, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %cfg_block, %false after %4 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %250 = llhd.prb %clk_i_0 : i1
      %251 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%12, %13 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %252 = llhd.prb %clk_i_0 : i1
      %253 = comb.xor bin %250, %true : i1
      %254 = comb.and bin %253, %252 : i1
      %255 = llhd.prb %rst_ni_1 : i1
      %256 = comb.xor bin %255, %true : i1
      %257 = comb.and bin %251, %256 : i1
      %258 = comb.or bin %254, %257 : i1
      cf.cond_br %258, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %259 = llhd.prb %rst_ni_1 : i1
      %260 = comb.xor %259, %true : i1
      cf.cond_br %260, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %261 = hw.struct_create (%2, %1, %0, %0, %0, %0, %0) : !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>
      llhd.drv %cfg_reg, %261 after %4 : !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %262 = llhd.prb %cfg_block : i1
      %263 = comb.xor %262, %true : i1
      %264 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %cfg = hw.struct_extract %264["cfg"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %hmac_en_45 = hw.struct_extract %cfg["hmac_en"] : !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>
      %qe_46 = hw.struct_extract %hmac_en_45["qe"] : !hw.struct<q: i1, qe: i1>
      %265 = comb.and %263, %qe_46 : i1
      cf.cond_br %265, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %266 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %cfg_47 = hw.struct_extract %266["cfg"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      llhd.drv %cfg_reg, %cfg_47 after %4 : !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %250 = llhd.prb %clk_i_0 : i1
      %251 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%12, %13 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %252 = llhd.prb %clk_i_0 : i1
      %253 = comb.xor bin %250, %true : i1
      %254 = comb.and bin %253, %252 : i1
      %255 = llhd.prb %rst_ni_1 : i1
      %256 = comb.xor bin %255, %true : i1
      %257 = comb.and bin %251, %256 : i1
      %258 = comb.or bin %254, %257 : i1
      cf.cond_br %258, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %259 = llhd.prb %rst_ni_1 : i1
      %260 = comb.xor %259, %true : i1
      cf.cond_br %260, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %msg_allowed, %false after %4 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %261 = llhd.prb %hash_start_or_continue : i1
      cf.cond_br %261, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %msg_allowed, %true after %4 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %262 = llhd.prb %packer_flush_done : i1
      cf.cond_br %262, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %msg_allowed, %false after %4 : i1
      cf.br ^bb1
    }
    %173 = llhd.prb %fifo_empty_q : i1
    %174 = comb.xor %58, %true : i1
    %175 = comb.and %173, %174 : i1
    llhd.drv %fifo_empty_negedge, %175 after %5 : i1
    %176 = llhd.prb %fifo_full_q : i1
    %177 = comb.xor %176, %true : i1
    %178 = comb.and %177, %55 : i1
    llhd.drv %fifo_full_posedge, %178 after %5 : i1
    %179 = comb.or %159, %161 : i1
    %180 = comb.or %179, %162, %40 : i1
    %181 = llhd.prb %fifo_empty_negedge : i1
    %182 = llhd.prb %fifo_full_posedge : i1
    %183 = llhd.prb %fifo_full_seen_q : i1
    %184 = comb.or %182, %183 : i1
    %185 = comb.xor %181, %true : i1
    %186 = comb.xor %180, %true : i1
    %187 = comb.and %186, %185, %184 : i1
    llhd.drv %fifo_full_seen_d, %187 after %5 : i1
    %188 = llhd.prb %msg_allowed : i1
    %189 = comb.xor %188, %true : i1
    %190 = comb.xor %183, %true : i1
    %191 = comb.or %189, %190 {sv.namehint = "fifo_empty_gate"} : i1
    %192 = comb.xor %191, %true : i1
    %193 = comb.and %192, %58 {sv.namehint = "status_fifo_empty"} : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %250 = llhd.prb %clk_i_0 : i1
      %251 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%12, %13 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %252 = llhd.prb %clk_i_0 : i1
      %253 = comb.xor bin %250, %true : i1
      %254 = comb.and bin %253, %252 : i1
      %255 = llhd.prb %rst_ni_1 : i1
      %256 = comb.xor bin %255, %true : i1
      %257 = comb.and bin %251, %256 : i1
      %258 = comb.or bin %254, %257 : i1
      cf.cond_br %258, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %259 = llhd.prb %rst_ni_1 : i1
      %260 = comb.xor %259, %true : i1
      cf.cond_br %260, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %fifo_empty_q, %false after %4 : i1
      llhd.drv %fifo_full_q, %false after %4 : i1
      llhd.drv %fifo_full_seen_q, %false after %4 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %261 = llhd.prb %fifo_empty : i1
      llhd.drv %fifo_empty_q, %261 after %4 : i1
      %262 = llhd.prb %fifo_full : i1
      llhd.drv %fifo_full_q, %262 after %4 : i1
      %263 = llhd.prb %fifo_full_seen_d : i1
      llhd.drv %fifo_full_seen_q, %263 after %4 : i1
      cf.br ^bb1
    }
    %194 = llhd.prb %packer_ready : i1
    %195 = comb.and %u_tlul_adapter.req_o, %34, %194 {sv.namehint = "msg_fifo_gnt"} : i1
    %196 = llhd.sig.struct_extract %reg_fifo_wentry["data"] : <!hw.struct<data: i32, mask: i4>>
    %197 = func.call @"prim_sha2_pkg::conv_endian32"(%u_packer.data_o, %true) : (i32, i1) -> i32
    llhd.drv %196, %197 after %5 : i32
    %198 = llhd.sig.struct_extract %reg_fifo_wentry["mask"] : <!hw.struct<data: i32, mask: i4>>
    %199 = comb.extract %u_packer.mask_o from 0 : (i32) -> i1
    %200 = comb.extract %u_packer.mask_o from 8 : (i32) -> i1
    %201 = comb.extract %u_packer.mask_o from 16 : (i32) -> i1
    %202 = comb.extract %u_packer.mask_o from 24 : (i32) -> i1
    %203 = comb.concat %199, %200, %201, %202 : i1, i1, i1, i1
    llhd.drv %198, %203 after %5 : i4
    %204 = comb.xor %u_msg_fifo.rvalid_o, %true : i1
    llhd.drv %fifo_empty, %204 after %5 : i1
    %205 = comb.and %33, %u_msg_fifo.wready_o : i1
    %206 = llhd.prb %hmac_fifo_wvalid : i1
    %207 = llhd.prb %reg_fifo_wvalid : i1
    %208 = comb.mux %205, %206, %207 {sv.namehint = "fifo_wvalid"} : i1
    %209 = llhd.prb %index : i1
    %210 = llhd.prb %reg_fifo_wentry : !hw.struct<data: i32, mask: i4>
    %211 = llhd.prb %hmac_fifo_wdata_sel : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      llhd.drv %index, %false after %5 : i1
      %250 = llhd.prb %reg_fifo_wentry : !hw.struct<data: i32, mask: i4>
      llhd.drv %fifo_wdata, %250 after %5 : !hw.struct<data: i32, mask: i4>
      %251 = llhd.prb %hmac_fifo_wsel : i1
      cf.cond_br %251, ^bb2, ^bb6
    ^bb2:  // pred: ^bb1
      llhd.drv %fifo_wdata, %8 after %5 : !hw.struct<data: i32, mask: i4>
      %252 = llhd.prb %digest_size : i4
      %253 = comb.icmp eq %252, %c1_i4 : i4
      cf.cond_br %253, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %254 = llhd.prb %digest : !hw.array<8xi64>
      %255 = llhd.prb %hmac_fifo_wdata_sel : i4
      %256 = comb.extract %255 from 0 : (i4) -> i3
      %257 = hw.array_get %254[%256] : !hw.array<8xi64>, i3
      %258 = comb.extract %257 from 0 : (i64) -> i32
      %259 = hw.struct_create (%258, %c-1_i4) : !hw.struct<data: i32, mask: i4>
      llhd.drv %fifo_wdata, %259 after %5 : !hw.struct<data: i32, mask: i4>
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      %260 = llhd.prb %digest_size : i4
      %261 = comb.icmp eq %260, %c2_i4 : i4
      %262 = comb.icmp eq %260, %c4_i4 : i4
      %263 = comb.or %261, %262 : i1
      cf.cond_br %263, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %264 = llhd.prb %hmac_fifo_wdata_sel : i4
      %265 = comb.extract %264 from 0 : (i4) -> i1
      %266 = comb.xor %265, %true : i1
      llhd.drv %index, %266 after %5 : i1
      %267 = llhd.prb %digest : !hw.array<8xi64>
      %268 = llhd.prb %hmac_fifo_wdata_sel : i4
      %269 = comb.extract %268 from 1 : (i4) -> i3
      %270 = hw.array_get %267[%269] : !hw.array<8xi64>, i3
      %271 = llhd.prb %index : i1
      %272 = comb.concat %c0_i58, %271, %c0_i5 : i58, i1, i5
      %273 = comb.shru %270, %272 : i64
      %274 = comb.extract %273 from 0 : (i64) -> i32
      %275 = hw.struct_create (%274, %c-1_i4) : !hw.struct<data: i32, mask: i4>
      llhd.drv %fifo_wdata, %275 after %5 : !hw.struct<data: i32, mask: i4>
      cf.br ^bb6
    ^bb6:  // 4 preds: ^bb1, ^bb3, ^bb4, ^bb5
      llhd.wait (%209, %210, %28, %33, %37, %138, %211 : i1, !hw.struct<data: i32, mask: i4>, !hw.struct<data: i32, mask: i4>, i1, i4, !hw.array<8xi64>, i4), ^bb1
    }
    %212 = comb.and %u_tlul_adapter.req_o, %u_tlul_adapter.we_o, %34, %188 : i1
    llhd.drv %msg_write, %212 after %5 : i1
    %213 = llhd.prb %wmask_ones : i6
    %214 = llhd.prb %msg_fifo_wmask : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb4
      llhd.drv %wmask_ones, %c0_i6 after %5 : i6
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%250: i32):  // 2 preds: ^bb1, ^bb3
      %251 = comb.icmp slt %250, %c32_i32 : i32
      cf.cond_br %251, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %252 = llhd.prb %wmask_ones : i6
      %253 = llhd.prb %msg_fifo_wmask : i32
      %254 = comb.shru %253, %250 : i32
      %255 = comb.extract %254 from 0 : (i32) -> i1
      %256 = comb.concat %c0_i5, %255 : i5, i1
      %257 = comb.add %252, %256 : i6
      llhd.drv %wmask_ones, %257 after %5 : i6
      %258 = comb.add %250, %c1_i32 : i32
      cf.br ^bb2(%258 : i32)
    ^bb4:  // pred: ^bb2
      llhd.wait (%213, %214 : i6, i32), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %250 = llhd.prb %clk_i_0 : i1
      %251 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%12, %13 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %252 = llhd.prb %clk_i_0 : i1
      %253 = comb.xor bin %250, %true : i1
      %254 = comb.and bin %253, %252 : i1
      %255 = llhd.prb %rst_ni_1 : i1
      %256 = comb.xor bin %255, %true : i1
      %257 = comb.and bin %251, %256 : i1
      %258 = comb.or bin %254, %257 : i1
      cf.cond_br %258, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %259 = llhd.prb %rst_ni_1 : i1
      %260 = comb.xor %259, %true : i1
      cf.cond_br %260, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %message_length, %c0_i64 after %4 : i64
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %261 = llhd.prb %message_length_d : i64
      llhd.drv %message_length, %261 after %4 : i64
      cf.br ^bb1
    }
    %215 = llhd.prb %message_length_d : i64
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb10
      %250 = llhd.prb %message_length : i64
      llhd.drv %message_length_d, %250 after %5 : i64
      %251 = llhd.prb %cfg_block : i1
      %252 = comb.xor %251, %true : i1
      cf.cond_br %252, ^bb2, ^bb6
    ^bb2:  // pred: ^bb1
      %253 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %msg_length_lower = hw.struct_extract %253["msg_length_lower"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %qe_45 = hw.struct_extract %msg_length_lower["qe"] : !hw.struct<q: i32, qe: i1>
      cf.cond_br %qe_45, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %254 = llhd.sig.extract %message_length_d from %c0_i6 : <i64> -> <i32>
      %255 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %msg_length_lower_46 = hw.struct_extract %255["msg_length_lower"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %q_47 = hw.struct_extract %msg_length_lower_46["q"] : !hw.struct<q: i32, qe: i1>
      llhd.drv %254, %q_47 after %5 : i32
      cf.br ^bb4
    ^bb4:  // 2 preds: ^bb2, ^bb3
      %256 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %msg_length_upper = hw.struct_extract %256["msg_length_upper"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %qe_48 = hw.struct_extract %msg_length_upper["qe"] : !hw.struct<q: i32, qe: i1>
      cf.cond_br %qe_48, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %257 = llhd.sig.extract %message_length_d from %c-32_i6 : <i64> -> <i32>
      %258 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %msg_length_upper_49 = hw.struct_extract %258["msg_length_upper"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %q_50 = hw.struct_extract %msg_length_upper_49["q"] : !hw.struct<q: i32, qe: i1>
      llhd.drv %257, %q_50 after %5 : i32
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb1, ^bb4, ^bb5
      %259 = llhd.prb %hash_start : i1
      cf.cond_br %259, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      llhd.drv %message_length_d, %c0_i64 after %5 : i64
      cf.br ^bb10
    ^bb8:  // pred: ^bb6
      %260 = llhd.prb %msg_write : i1
      %261 = llhd.prb %sha_en : i1
      %262 = llhd.prb %packer_ready : i1
      %263 = comb.and %260, %261, %262 : i1
      cf.cond_br %263, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %264 = llhd.prb %message_length : i64
      %265 = llhd.prb %wmask_ones : i6
      %266 = comb.concat %c0_i58, %265 : i58, i6
      %267 = comb.add %264, %266 : i64
      llhd.drv %message_length_d, %267 after %5 : i64
      cf.br ^bb10
    ^bb10:  // 3 preds: ^bb7, ^bb8, ^bb9
      llhd.wait (%42, %215, %69, %15, %39, %31, %26, %194, %213 : i64, i64, i1, !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>, i1, i1, i1, i1, i6), ^bb1
    }
    %216 = llhd.sig.struct_extract %hw2reg["msg_length_upper"] : <!hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>>
    %217 = llhd.sig.struct_extract %216["d"] : <!hw.struct<d: i32>>
    %218 = comb.extract %42 from 32 : (i64) -> i32
    llhd.drv %217, %218 after %5 : i32
    %219 = llhd.sig.struct_extract %hw2reg["msg_length_lower"] : <!hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<d: i1, de: i1>, fifo_empty: !hw.struct<d: i1, de: i1>, hmac_done: !hw.struct<d: i1, de: i1>>, cfg: !hw.struct<key_length: !hw.struct<d: i6>, digest_size: !hw.struct<d: i4>, key_swap: !hw.struct<d: i1>, digest_swap: !hw.struct<d: i1>, endian_swap: !hw.struct<d: i1>, sha_en: !hw.struct<d: i1>, hmac_en: !hw.struct<d: i1>>, status: !hw.struct<fifo_depth: !hw.struct<d: i6>, fifo_full: !hw.struct<d: i1>, fifo_empty: !hw.struct<d: i1>, hmac_idle: !hw.struct<d: i1>>, err_code: !hw.struct<d: i32, de: i1>, key: !hw.array<32xstruct<d: i32>>, digest: !hw.array<16xstruct<d: i32>>, msg_length_lower: !hw.struct<d: i32>, msg_length_upper: !hw.struct<d: i32>>>
    %220 = llhd.sig.struct_extract %219["d"] : <!hw.struct<d: i32>>
    %221 = comb.extract %42 from 0 : (i64) -> i32
    llhd.drv %220, %221 after %5 : i32
    %222 = func.call @"prim_sha2_pkg::conv_endian32"(%u_tlul_adapter.wdata_o, %q_31) {sv.namehint = "msg_fifo_wdata_endian"} : (i32, i1) -> i32
    %223 = func.call @"prim_sha2_pkg::conv_endian32"(%214, %q_31) {sv.namehint = "msg_fifo_wmask_endian"} : (i32, i1) -> i32
    %alert_test = hw.struct_extract %15["alert_test"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
    %q_43 = hw.struct_extract %alert_test["q"] : !hw.struct<q: i1, qe: i1>
    %qe_44 = hw.struct_extract %alert_test["qe"] : !hw.struct<q: i1, qe: i1>
    %224 = comb.and %q_43, %qe_44 : i1
    %225 = comb.xor %26, %true : i1
    %226 = comb.and %179, %225 : i1
    llhd.drv %hash_start_sha_disabled, %226 after %5 : i1
    %227 = comb.and %179, %69 : i1
    llhd.drv %hash_start_active, %227 after %5 : i1
    %228 = comb.and %u_tlul_adapter.req_o, %189 : i1
    llhd.drv %msg_push_not_allowed, %228 after %5 : i1
    %229 = comb.icmp eq %37, %c-8_i4 : i4
    %230 = comb.icmp eq %38, %c-32_i6 : i6
    %231 = comb.and %230, %q_28 : i1
    %232 = comb.icmp eq %38, %c16_i6 : i6
    %233 = comb.icmp eq %37, %c1_i4 : i4
    %234 = comb.and %232, %233, %q_28 : i1
    %235 = comb.or %229, %231, %234 {sv.namehint = "invalid_config"} : i1
    %236 = comb.and %179, %235 : i1
    llhd.drv %invalid_config_atstart, %236 after %5 : i1
    %237 = llhd.prb %update_seckey_inprocess : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb7
      llhd.drv %update_seckey_inprocess, %false after %5 : i1
      %250 = llhd.prb %cfg_block : i1
      cf.cond_br %250, ^bb2(%c0_i32 : i32), ^bb6
    ^bb2(%251: i32):  // 2 preds: ^bb1, ^bb5
      %252 = comb.icmp slt %251, %c32_i32 : i32
      cf.cond_br %252, ^bb3, ^bb7
    ^bb3:  // pred: ^bb2
      %253 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %key = hw.struct_extract %253["key"] : !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>
      %254 = comb.extract %251 from 5 : (i32) -> i27
      %255 = comb.icmp eq %254, %c0_i27 : i27
      %256 = comb.extract %251 from 0 : (i32) -> i5
      %257 = comb.mux %255, %256, %c-1_i5 : i5
      %258 = hw.array_get %key[%257] : !hw.array<32xstruct<q: i32, qe: i1>>, i5
      %qe_45 = hw.struct_extract %258["qe"] : !hw.struct<q: i32, qe: i1>
      cf.cond_br %qe_45, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %update_seckey_inprocess, %true after %5 : i1
      cf.br ^bb5
    ^bb5:  // 2 preds: ^bb3, ^bb4
      %259 = comb.add %251, %c1_i32 : i32
      cf.br ^bb2(%259 : i32)
    ^bb6:  // pred: ^bb1
      llhd.drv %update_seckey_inprocess, %false after %5 : i1
      cf.br ^bb7
    ^bb7:  // 2 preds: ^bb2, ^bb6
      llhd.wait (%237, %69, %15 : i1, i1, !hw.struct<intr_state: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<hmac_err: !hw.struct<q: i1>, fifo_empty: !hw.struct<q: i1>, hmac_done: !hw.struct<q: i1>>, intr_test: !hw.struct<hmac_err: !hw.struct<q: i1, qe: i1>, fifo_empty: !hw.struct<q: i1, qe: i1>, hmac_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<key_length: !hw.struct<q: i6, qe: i1>, digest_size: !hw.struct<q: i4, qe: i1>, key_swap: !hw.struct<q: i1, qe: i1>, digest_swap: !hw.struct<q: i1, qe: i1>, endian_swap: !hw.struct<q: i1, qe: i1>, sha_en: !hw.struct<q: i1, qe: i1>, hmac_en: !hw.struct<q: i1, qe: i1>>, cmd: !hw.struct<hash_continue: !hw.struct<q: i1, qe: i1>, hash_stop: !hw.struct<q: i1, qe: i1>, hash_process: !hw.struct<q: i1, qe: i1>, hash_start: !hw.struct<q: i1, qe: i1>>, wipe_secret: !hw.struct<q: i32, qe: i1>, key: !hw.array<32xstruct<q: i32, qe: i1>>, digest: !hw.array<16xstruct<q: i32, qe: i1>>, msg_length_lower: !hw.struct<q: i32, qe: i1>, msg_length_upper: !hw.struct<q: i32, qe: i1>>), ^bb1
    }
    %238 = comb.xor %q_18, %true : i1
    %239 = llhd.prb %hash_start_sha_disabled : i1
    %240 = llhd.prb %hash_start_active : i1
    %241 = llhd.prb %msg_push_not_allowed : i1
    %242 = llhd.prb %invalid_config_atstart : i1
    %243 = comb.or %239, %237, %240, %241, %242 : i1
    %244 = comb.and %238, %243 {sv.namehint = "err_valid"} : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb12
      llhd.drv %err_code, %c0_i32 after %5 : i32
      %250 = llhd.prb %invalid_config_atstart : i1
      %251 = comb.icmp ceq %250, %true : i1
      cf.cond_br %251, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %err_code, %c6_i32 after %5 : i32
      cf.br ^bb12
    ^bb3:  // pred: ^bb1
      %252 = llhd.prb %hash_start_sha_disabled : i1
      %253 = comb.icmp ceq %252, %true : i1
      cf.cond_br %253, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %err_code, %c2_i32 after %5 : i32
      cf.br ^bb12
    ^bb5:  // pred: ^bb3
      %254 = llhd.prb %hash_start_active : i1
      %255 = comb.icmp ceq %254, %true : i1
      cf.cond_br %255, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %err_code, %c4_i32 after %5 : i32
      cf.br ^bb12
    ^bb7:  // pred: ^bb5
      %256 = llhd.prb %msg_push_not_allowed : i1
      %257 = comb.icmp ceq %256, %true : i1
      cf.cond_br %257, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %err_code, %c5_i32 after %5 : i32
      cf.br ^bb12
    ^bb9:  // pred: ^bb7
      %258 = llhd.prb %update_seckey_inprocess : i1
      %259 = comb.icmp ceq %258, %true : i1
      cf.cond_br %259, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      llhd.drv %err_code, %c3_i32 after %5 : i32
      cf.br ^bb12
    ^bb11:  // pred: ^bb9
      llhd.drv %err_code, %c0_i32 after %5 : i32
      cf.br ^bb12
    ^bb12:  // 6 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb11
      llhd.wait (%166, %242, %239, %240, %241, %237 : i32, i1, i1, i1, i1, i1), ^bb1
    }
    %245 = comb.xor %207, %true : i1
    %246 = comb.and %245, %204, %u_hmac.idle_o, %u_prim_sha2_512.idle_o {sv.namehint = "idle"} : i1
    %247 = func.call @"prim_mubi_pkg::mubi4_bool_to_mubi"(%246) : (i1) -> i4
    llhd.drv %idle_d, %247 after %5 : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %250 = llhd.prb %clk_i_0 : i1
      %251 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%12, %13 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %252 = llhd.prb %clk_i_0 : i1
      %253 = comb.xor bin %250, %true : i1
      %254 = comb.and bin %253, %252 : i1
      %255 = llhd.prb %rst_ni_1 : i1
      %256 = comb.xor bin %255, %true : i1
      %257 = comb.and bin %251, %256 : i1
      %258 = comb.or bin %254, %257 : i1
      cf.cond_br %258, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %259 = llhd.prb %rst_ni_1 : i1
      %260 = comb.xor %259, %true : i1
      cf.cond_br %260, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %idle_q, %c-7_i4 after %4 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %261 = llhd.prb %idle_d : i4
      llhd.drv %idle_q, %261 after %4 : i4
      cf.br ^bb1
    }
    %248 = llhd.prb %idle_q : i4
    llhd.drv %clk_i_0, %clk_i after %5 : i1
    llhd.drv %rst_ni_1, %rst_ni after %5 : i1
    %249 = llhd.prb %alert_tx_o : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    hw.output %u_reg.tl_o, %249, %intr_hw_hmac_done.intr_o, %intr_hw_fifo_empty.intr_o, %intr_hw_hmac_err.intr_o, %248 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.array<1xstruct<alert_p: i1, alert_n: i1>>, i1, i1, i1, i4
  }
}
