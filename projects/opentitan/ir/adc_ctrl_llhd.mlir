module {
  hw.module private @prim_buf(in %in_i : i2, out out_o : i2) {
    hw.output %in_i : i2
  }
  hw.module private @prim_buf_23(in %in_i : i1, out out_o : i1) {
    hw.output %in_i : i1
  }
  hw.module private @prim_buf_24(in %in_i : i32, out out_o : i32) {
    hw.output %in_i : i32
  }
  hw.module private @prim_flop_2sync(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %d_i_0 = llhd.sig name "d_i" %false : i1
    %d_o = llhd.sig %false : i1
    %1 = llhd.prb %d_o : i1
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_45(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_45(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
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
  hw.module private @prim_flop_2sync_22(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %d_i_0 = llhd.sig name "d_i" %false : i1
    %d_o = llhd.sig %false : i1
    %1 = llhd.prb %d_o : i1
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_46(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_46(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
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
  hw.module private @prim_flop_45(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
  hw.module private @prim_flop_46(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
    %gen_async.i_sync_n.q_o = hw.instance "gen_async.i_sync_n" @prim_flop_2sync_22(clk_i: %2: i1, rst_ni: %3: i1, d_i: %diff_ni: i1) -> (q_o: i1)
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
  hw.module private @prim_onehot_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i32, in %addr_i : i5, in %en_i : i1, out err_o : i1) {
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
    %480 = comb.extract %oh_i from 0 : (i32) -> i1
    llhd.drv %479, %480 after %0 : i1
    %481 = llhd.sig.extract %and_tree from %c31_i6 : <i63> -> <i1>
    llhd.drv %481, %480 after %0 : i1
    %482 = llhd.sig.extract %err_tree from %c31_i6 : <i63> -> <i1>
    llhd.drv %482, %false after %0 : i1
    %483 = llhd.sig.extract %or_tree from %c-32_i6 : <i63> -> <i1>
    %484 = comb.extract %oh_i from 1 : (i32) -> i1
    llhd.drv %483, %484 after %0 : i1
    %485 = llhd.sig.extract %and_tree from %c-32_i6 : <i63> -> <i1>
    llhd.drv %485, %484 after %0 : i1
    %486 = llhd.sig.extract %err_tree from %c-32_i6 : <i63> -> <i1>
    llhd.drv %486, %false after %0 : i1
    %487 = llhd.sig.extract %or_tree from %c-31_i6 : <i63> -> <i1>
    %488 = comb.extract %oh_i from 2 : (i32) -> i1
    llhd.drv %487, %488 after %0 : i1
    %489 = llhd.sig.extract %and_tree from %c-31_i6 : <i63> -> <i1>
    llhd.drv %489, %488 after %0 : i1
    %490 = llhd.sig.extract %err_tree from %c-31_i6 : <i63> -> <i1>
    llhd.drv %490, %false after %0 : i1
    %491 = llhd.sig.extract %or_tree from %c-30_i6 : <i63> -> <i1>
    %492 = comb.extract %oh_i from 3 : (i32) -> i1
    llhd.drv %491, %492 after %0 : i1
    %493 = llhd.sig.extract %and_tree from %c-30_i6 : <i63> -> <i1>
    llhd.drv %493, %492 after %0 : i1
    %494 = llhd.sig.extract %err_tree from %c-30_i6 : <i63> -> <i1>
    llhd.drv %494, %false after %0 : i1
    %495 = llhd.sig.extract %or_tree from %c-29_i6 : <i63> -> <i1>
    %496 = comb.extract %oh_i from 4 : (i32) -> i1
    llhd.drv %495, %496 after %0 : i1
    %497 = llhd.sig.extract %and_tree from %c-29_i6 : <i63> -> <i1>
    llhd.drv %497, %496 after %0 : i1
    %498 = llhd.sig.extract %err_tree from %c-29_i6 : <i63> -> <i1>
    llhd.drv %498, %false after %0 : i1
    %499 = llhd.sig.extract %or_tree from %c-28_i6 : <i63> -> <i1>
    %500 = comb.extract %oh_i from 5 : (i32) -> i1
    llhd.drv %499, %500 after %0 : i1
    %501 = llhd.sig.extract %and_tree from %c-28_i6 : <i63> -> <i1>
    llhd.drv %501, %500 after %0 : i1
    %502 = llhd.sig.extract %err_tree from %c-28_i6 : <i63> -> <i1>
    llhd.drv %502, %false after %0 : i1
    %503 = llhd.sig.extract %or_tree from %c-27_i6 : <i63> -> <i1>
    %504 = comb.extract %oh_i from 6 : (i32) -> i1
    llhd.drv %503, %504 after %0 : i1
    %505 = llhd.sig.extract %and_tree from %c-27_i6 : <i63> -> <i1>
    llhd.drv %505, %504 after %0 : i1
    %506 = llhd.sig.extract %err_tree from %c-27_i6 : <i63> -> <i1>
    llhd.drv %506, %false after %0 : i1
    %507 = llhd.sig.extract %or_tree from %c-26_i6 : <i63> -> <i1>
    %508 = comb.extract %oh_i from 7 : (i32) -> i1
    llhd.drv %507, %508 after %0 : i1
    %509 = llhd.sig.extract %and_tree from %c-26_i6 : <i63> -> <i1>
    llhd.drv %509, %508 after %0 : i1
    %510 = llhd.sig.extract %err_tree from %c-26_i6 : <i63> -> <i1>
    llhd.drv %510, %false after %0 : i1
    %511 = llhd.sig.extract %or_tree from %c-25_i6 : <i63> -> <i1>
    %512 = comb.extract %oh_i from 8 : (i32) -> i1
    llhd.drv %511, %512 after %0 : i1
    %513 = llhd.sig.extract %and_tree from %c-25_i6 : <i63> -> <i1>
    llhd.drv %513, %512 after %0 : i1
    %514 = llhd.sig.extract %err_tree from %c-25_i6 : <i63> -> <i1>
    llhd.drv %514, %false after %0 : i1
    %515 = llhd.sig.extract %or_tree from %c-24_i6 : <i63> -> <i1>
    %516 = comb.extract %oh_i from 9 : (i32) -> i1
    llhd.drv %515, %516 after %0 : i1
    %517 = llhd.sig.extract %and_tree from %c-24_i6 : <i63> -> <i1>
    llhd.drv %517, %516 after %0 : i1
    %518 = llhd.sig.extract %err_tree from %c-24_i6 : <i63> -> <i1>
    llhd.drv %518, %false after %0 : i1
    %519 = llhd.sig.extract %or_tree from %c-23_i6 : <i63> -> <i1>
    %520 = comb.extract %oh_i from 10 : (i32) -> i1
    llhd.drv %519, %520 after %0 : i1
    %521 = llhd.sig.extract %and_tree from %c-23_i6 : <i63> -> <i1>
    llhd.drv %521, %520 after %0 : i1
    %522 = llhd.sig.extract %err_tree from %c-23_i6 : <i63> -> <i1>
    llhd.drv %522, %false after %0 : i1
    %523 = llhd.sig.extract %or_tree from %c-22_i6 : <i63> -> <i1>
    %524 = comb.extract %oh_i from 11 : (i32) -> i1
    llhd.drv %523, %524 after %0 : i1
    %525 = llhd.sig.extract %and_tree from %c-22_i6 : <i63> -> <i1>
    llhd.drv %525, %524 after %0 : i1
    %526 = llhd.sig.extract %err_tree from %c-22_i6 : <i63> -> <i1>
    llhd.drv %526, %false after %0 : i1
    %527 = llhd.sig.extract %or_tree from %c-21_i6 : <i63> -> <i1>
    %528 = comb.extract %oh_i from 12 : (i32) -> i1
    llhd.drv %527, %528 after %0 : i1
    %529 = llhd.sig.extract %and_tree from %c-21_i6 : <i63> -> <i1>
    llhd.drv %529, %528 after %0 : i1
    %530 = llhd.sig.extract %err_tree from %c-21_i6 : <i63> -> <i1>
    llhd.drv %530, %false after %0 : i1
    %531 = llhd.sig.extract %or_tree from %c-20_i6 : <i63> -> <i1>
    %532 = comb.extract %oh_i from 13 : (i32) -> i1
    llhd.drv %531, %532 after %0 : i1
    %533 = llhd.sig.extract %and_tree from %c-20_i6 : <i63> -> <i1>
    llhd.drv %533, %532 after %0 : i1
    %534 = llhd.sig.extract %err_tree from %c-20_i6 : <i63> -> <i1>
    llhd.drv %534, %false after %0 : i1
    %535 = llhd.sig.extract %or_tree from %c-19_i6 : <i63> -> <i1>
    %536 = comb.extract %oh_i from 14 : (i32) -> i1
    llhd.drv %535, %536 after %0 : i1
    %537 = llhd.sig.extract %and_tree from %c-19_i6 : <i63> -> <i1>
    llhd.drv %537, %536 after %0 : i1
    %538 = llhd.sig.extract %err_tree from %c-19_i6 : <i63> -> <i1>
    llhd.drv %538, %false after %0 : i1
    %539 = llhd.sig.extract %or_tree from %c-18_i6 : <i63> -> <i1>
    %540 = comb.extract %oh_i from 15 : (i32) -> i1
    llhd.drv %539, %540 after %0 : i1
    %541 = llhd.sig.extract %and_tree from %c-18_i6 : <i63> -> <i1>
    llhd.drv %541, %540 after %0 : i1
    %542 = llhd.sig.extract %err_tree from %c-18_i6 : <i63> -> <i1>
    llhd.drv %542, %false after %0 : i1
    %543 = llhd.sig.extract %or_tree from %c-17_i6 : <i63> -> <i1>
    %544 = comb.extract %oh_i from 16 : (i32) -> i1
    llhd.drv %543, %544 after %0 : i1
    %545 = llhd.sig.extract %and_tree from %c-17_i6 : <i63> -> <i1>
    llhd.drv %545, %544 after %0 : i1
    %546 = llhd.sig.extract %err_tree from %c-17_i6 : <i63> -> <i1>
    llhd.drv %546, %false after %0 : i1
    %547 = llhd.sig.extract %or_tree from %c-16_i6 : <i63> -> <i1>
    %548 = comb.extract %oh_i from 17 : (i32) -> i1
    llhd.drv %547, %548 after %0 : i1
    %549 = llhd.sig.extract %and_tree from %c-16_i6 : <i63> -> <i1>
    llhd.drv %549, %548 after %0 : i1
    %550 = llhd.sig.extract %err_tree from %c-16_i6 : <i63> -> <i1>
    llhd.drv %550, %false after %0 : i1
    %551 = llhd.sig.extract %or_tree from %c-15_i6 : <i63> -> <i1>
    %552 = comb.extract %oh_i from 18 : (i32) -> i1
    llhd.drv %551, %552 after %0 : i1
    %553 = llhd.sig.extract %and_tree from %c-15_i6 : <i63> -> <i1>
    llhd.drv %553, %552 after %0 : i1
    %554 = llhd.sig.extract %err_tree from %c-15_i6 : <i63> -> <i1>
    llhd.drv %554, %false after %0 : i1
    %555 = llhd.sig.extract %or_tree from %c-14_i6 : <i63> -> <i1>
    %556 = comb.extract %oh_i from 19 : (i32) -> i1
    llhd.drv %555, %556 after %0 : i1
    %557 = llhd.sig.extract %and_tree from %c-14_i6 : <i63> -> <i1>
    llhd.drv %557, %556 after %0 : i1
    %558 = llhd.sig.extract %err_tree from %c-14_i6 : <i63> -> <i1>
    llhd.drv %558, %false after %0 : i1
    %559 = llhd.sig.extract %or_tree from %c-13_i6 : <i63> -> <i1>
    %560 = comb.extract %oh_i from 20 : (i32) -> i1
    llhd.drv %559, %560 after %0 : i1
    %561 = llhd.sig.extract %and_tree from %c-13_i6 : <i63> -> <i1>
    llhd.drv %561, %560 after %0 : i1
    %562 = llhd.sig.extract %err_tree from %c-13_i6 : <i63> -> <i1>
    llhd.drv %562, %false after %0 : i1
    %563 = llhd.sig.extract %or_tree from %c-12_i6 : <i63> -> <i1>
    %564 = comb.extract %oh_i from 21 : (i32) -> i1
    llhd.drv %563, %564 after %0 : i1
    %565 = llhd.sig.extract %and_tree from %c-12_i6 : <i63> -> <i1>
    llhd.drv %565, %564 after %0 : i1
    %566 = llhd.sig.extract %err_tree from %c-12_i6 : <i63> -> <i1>
    llhd.drv %566, %false after %0 : i1
    %567 = llhd.sig.extract %or_tree from %c-11_i6 : <i63> -> <i1>
    %568 = comb.extract %oh_i from 22 : (i32) -> i1
    llhd.drv %567, %568 after %0 : i1
    %569 = llhd.sig.extract %and_tree from %c-11_i6 : <i63> -> <i1>
    llhd.drv %569, %568 after %0 : i1
    %570 = llhd.sig.extract %err_tree from %c-11_i6 : <i63> -> <i1>
    llhd.drv %570, %false after %0 : i1
    %571 = llhd.sig.extract %or_tree from %c-10_i6 : <i63> -> <i1>
    %572 = comb.extract %oh_i from 23 : (i32) -> i1
    llhd.drv %571, %572 after %0 : i1
    %573 = llhd.sig.extract %and_tree from %c-10_i6 : <i63> -> <i1>
    llhd.drv %573, %572 after %0 : i1
    %574 = llhd.sig.extract %err_tree from %c-10_i6 : <i63> -> <i1>
    llhd.drv %574, %false after %0 : i1
    %575 = llhd.sig.extract %or_tree from %c-9_i6 : <i63> -> <i1>
    %576 = comb.extract %oh_i from 24 : (i32) -> i1
    llhd.drv %575, %576 after %0 : i1
    %577 = llhd.sig.extract %and_tree from %c-9_i6 : <i63> -> <i1>
    llhd.drv %577, %576 after %0 : i1
    %578 = llhd.sig.extract %err_tree from %c-9_i6 : <i63> -> <i1>
    llhd.drv %578, %false after %0 : i1
    %579 = llhd.sig.extract %or_tree from %c-8_i6 : <i63> -> <i1>
    %580 = comb.extract %oh_i from 25 : (i32) -> i1
    llhd.drv %579, %580 after %0 : i1
    %581 = llhd.sig.extract %and_tree from %c-8_i6 : <i63> -> <i1>
    llhd.drv %581, %580 after %0 : i1
    %582 = llhd.sig.extract %err_tree from %c-8_i6 : <i63> -> <i1>
    llhd.drv %582, %false after %0 : i1
    %583 = llhd.sig.extract %or_tree from %c-7_i6 : <i63> -> <i1>
    %584 = comb.extract %oh_i from 26 : (i32) -> i1
    llhd.drv %583, %584 after %0 : i1
    %585 = llhd.sig.extract %and_tree from %c-7_i6 : <i63> -> <i1>
    llhd.drv %585, %584 after %0 : i1
    %586 = llhd.sig.extract %err_tree from %c-7_i6 : <i63> -> <i1>
    llhd.drv %586, %false after %0 : i1
    %587 = llhd.sig.extract %or_tree from %c-6_i6 : <i63> -> <i1>
    %588 = comb.extract %oh_i from 27 : (i32) -> i1
    llhd.drv %587, %588 after %0 : i1
    %589 = llhd.sig.extract %and_tree from %c-6_i6 : <i63> -> <i1>
    llhd.drv %589, %588 after %0 : i1
    %590 = llhd.sig.extract %err_tree from %c-6_i6 : <i63> -> <i1>
    llhd.drv %590, %false after %0 : i1
    %591 = llhd.sig.extract %or_tree from %c-5_i6 : <i63> -> <i1>
    %592 = comb.extract %oh_i from 28 : (i32) -> i1
    llhd.drv %591, %592 after %0 : i1
    %593 = llhd.sig.extract %and_tree from %c-5_i6 : <i63> -> <i1>
    llhd.drv %593, %592 after %0 : i1
    %594 = llhd.sig.extract %err_tree from %c-5_i6 : <i63> -> <i1>
    llhd.drv %594, %false after %0 : i1
    %595 = llhd.sig.extract %or_tree from %c-4_i6 : <i63> -> <i1>
    %596 = comb.extract %oh_i from 29 : (i32) -> i1
    llhd.drv %595, %596 after %0 : i1
    %597 = llhd.sig.extract %and_tree from %c-4_i6 : <i63> -> <i1>
    llhd.drv %597, %596 after %0 : i1
    %598 = llhd.sig.extract %err_tree from %c-4_i6 : <i63> -> <i1>
    llhd.drv %598, %false after %0 : i1
    %599 = llhd.sig.extract %or_tree from %c-3_i6 : <i63> -> <i1>
    %600 = comb.extract %oh_i from 30 : (i32) -> i1
    llhd.drv %599, %600 after %0 : i1
    %601 = llhd.sig.extract %and_tree from %c-3_i6 : <i63> -> <i1>
    llhd.drv %601, %600 after %0 : i1
    %602 = llhd.sig.extract %err_tree from %c-3_i6 : <i63> -> <i1>
    llhd.drv %602, %false after %0 : i1
    %603 = llhd.sig.extract %or_tree from %c-2_i6 : <i63> -> <i1>
    %604 = comb.extract %oh_i from 31 : (i32) -> i1
    llhd.drv %603, %604 after %0 : i1
    %605 = llhd.sig.extract %and_tree from %c-2_i6 : <i63> -> <i1>
    llhd.drv %605, %604 after %0 : i1
    %606 = llhd.sig.extract %err_tree from %c-2_i6 : <i63> -> <i1>
    llhd.drv %606, %false after %0 : i1
    %607 = comb.or %608, %611 : i1
    %608 = comb.extract %17 from 0 {sv.namehint = "oh0_err"} : (i63) -> i1
    %609 = comb.xor %en_i, %true : i1
    %610 = comb.extract %2 from 0 : (i63) -> i1
    %611 = comb.and %609, %610 {sv.namehint = "enable_err"} : i1
    hw.output %607 : i1
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
  hw.module private @prim_reg_cdc_arb(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i2, in %dst_qs_i : i2, out dst_qs_o : i2) {
    %false = hw.constant false
    %gen_passthru.u_dst_to_src_ack.dst_pulse_o = hw.instance "gen_passthru.u_dst_to_src_ack" @prim_pulse_sync(clk_src_i: %clk_dst_i: i1, rst_src_ni: %rst_dst_ni: i1, src_pulse_i: %dst_req_i: i1, clk_dst_i: %clk_src_i: i1, rst_dst_ni: %rst_src_ni: i1) -> (dst_pulse_o: i1)
    hw.output %gen_passthru.u_dst_to_src_ack.dst_pulse_o, %false, %dst_req_i, %dst_qs_i : i1, i1, i1, i2
  }
  hw.module private @prim_reg_cdc_arb_26(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i32, in %dst_qs_i : i32, out dst_qs_o : i32) {
    %false = hw.constant false
    %gen_passthru.u_dst_to_src_ack.dst_pulse_o = hw.instance "gen_passthru.u_dst_to_src_ack" @prim_pulse_sync(clk_src_i: %clk_dst_i: i1, rst_src_ni: %rst_dst_ni: i1, src_pulse_i: %dst_req_i: i1, clk_dst_i: %clk_src_i: i1, rst_dst_ni: %rst_src_ni: i1) -> (dst_pulse_o: i1)
    hw.output %gen_passthru.u_dst_to_src_ack.dst_pulse_o, %false, %dst_req_i, %dst_qs_i : i1, i1, i1, i32
  }
  hw.module private @prim_reg_cdc_arb_27(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i8, in %dst_qs_i : i8, out dst_qs_o : i8) {
    %false = hw.constant false
    %gen_passthru.u_dst_to_src_ack.dst_pulse_o = hw.instance "gen_passthru.u_dst_to_src_ack" @prim_pulse_sync(clk_src_i: %clk_dst_i: i1, rst_src_ni: %rst_dst_ni: i1, src_pulse_i: %dst_req_i: i1, clk_dst_i: %clk_src_i: i1, rst_dst_ni: %rst_src_ni: i1) -> (dst_pulse_o: i1)
    hw.output %gen_passthru.u_dst_to_src_ack.dst_pulse_o, %false, %dst_req_i, %dst_qs_i : i1, i1, i1, i8
  }
  hw.module private @prim_reg_cdc_arb_28(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i16, in %dst_qs_i : i16, out dst_qs_o : i16) {
    %false = hw.constant false
    %gen_passthru.u_dst_to_src_ack.dst_pulse_o = hw.instance "gen_passthru.u_dst_to_src_ack" @prim_pulse_sync(clk_src_i: %clk_dst_i: i1, rst_src_ni: %rst_dst_ni: i1, src_pulse_i: %dst_req_i: i1, clk_dst_i: %clk_src_i: i1, rst_dst_ni: %rst_src_ni: i1) -> (dst_pulse_o: i1)
    hw.output %gen_passthru.u_dst_to_src_ack.dst_pulse_o, %false, %dst_req_i, %dst_qs_i : i1, i1, i1, i16
  }
  hw.module private @prim_reg_cdc_arb_29(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i1, in %dst_qs_i : i1, out dst_qs_o : i1) {
    %false = hw.constant false
    %gen_passthru.u_dst_to_src_ack.dst_pulse_o = hw.instance "gen_passthru.u_dst_to_src_ack" @prim_pulse_sync(clk_src_i: %clk_dst_i: i1, rst_src_ni: %rst_dst_ni: i1, src_pulse_i: %dst_req_i: i1, clk_dst_i: %clk_src_i: i1, rst_dst_ni: %rst_src_ni: i1) -> (dst_pulse_o: i1)
    hw.output %gen_passthru.u_dst_to_src_ack.dst_pulse_o, %false, %dst_req_i, %dst_qs_i : i1, i1, i1, i1
  }
  hw.module private @prim_reg_cdc_arb_30(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i32, in %dst_qs_i : i32, out dst_qs_o : i32) {
    %false = hw.constant false
    %gen_passthru.u_dst_to_src_ack.dst_pulse_o = hw.instance "gen_passthru.u_dst_to_src_ack" @prim_pulse_sync(clk_src_i: %clk_dst_i: i1, rst_src_ni: %rst_dst_ni: i1, src_pulse_i: %dst_req_i: i1, clk_dst_i: %clk_src_i: i1, rst_dst_ni: %rst_src_ni: i1) -> (dst_pulse_o: i1)
    hw.output %gen_passthru.u_dst_to_src_ack.dst_pulse_o, %false, %dst_req_i, %dst_qs_i : i1, i1, i1, i32
  }
  hw.module private @prim_reg_cdc_arb_31(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i28, in %dst_qs_i : i28, out dst_qs_o : i28) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i28 = hw.constant 0 : i28
    %false = hw.constant false
    %true = hw.constant true
    %clk_dst_i_0 = llhd.sig name "clk_dst_i" %false : i1
    %2 = llhd.prb %clk_dst_i_0 : i1
    %rst_dst_ni_1 = llhd.sig name "rst_dst_ni" %false : i1
    %3 = llhd.prb %rst_dst_ni_1 : i1
    %dst_req_i_2 = llhd.sig name "dst_req_i" %false : i1
    %dst_ds_i_3 = llhd.sig name "dst_ds_i" %c0_i28 : i28
    %dst_qs_i_4 = llhd.sig name "dst_qs_i" %c0_i28 : i28
    %dst_qs_o = llhd.sig %c0_i28 : i28
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
    %4 = llhd.prb %dst_qs_o : i28
    %5 = llhd.prb %dst_ds_i_3 : i28
    %6 = comb.icmp ne %4, %5 : i28
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
      llhd.drv %dst_qs_o, %c0_i28 after %0 : i28
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %37 = llhd.prb %gen_wr_req.dst_lat_d : i1
      cf.cond_br %37, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %38 = llhd.prb %dst_ds_i_3 : i28
      llhd.drv %dst_qs_o, %38 after %0 : i28
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %39 = llhd.prb %gen_wr_req.dst_lat_q : i1
      cf.cond_br %39, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %40 = llhd.prb %dst_qs_i_4 : i28
      llhd.drv %dst_qs_o, %40 after %0 : i28
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
    %19 = llhd.prb %dst_qs_i_4 : i28
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
      %30 = llhd.prb %dst_qs_o : i28
      %31 = llhd.prb %dst_qs_i_4 : i28
      %32 = comb.icmp ne %30, %31 : i28
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
      llhd.wait (%11, %14, %15, %16, %17, %12, %18, %4, %19, %20 : i1, i1, i1, i1, i1, i1, i1, i28, i28, i1), ^bb1
    }
    %21 = comb.or %15, %17, %16 {sv.namehint = "gen_wr_req.dst_update_req"} : i1
    %22 = llhd.prb %gen_wr_req.id_q : i1
    %23 = comb.xor %22, %true : i1
    %24 = comb.and %gen_wr_req.u_dst_update_sync.dst_req_o, %23 : i1
    %25 = comb.and %gen_wr_req.u_dst_update_sync.dst_req_o, %22 : i1
    llhd.drv %clk_dst_i_0, %clk_dst_i after %1 : i1
    llhd.drv %rst_dst_ni_1, %rst_dst_ni after %1 : i1
    llhd.drv %dst_req_i_2, %dst_req_i after %1 : i1
    llhd.drv %dst_ds_i_3, %dst_ds_i after %1 : i28
    llhd.drv %dst_qs_i_4, %dst_qs_i after %1 : i28
    hw.output %24, %25, %13, %4 : i1, i1, i1, i28
  }
  hw.module private @prim_reg_cdc_arb_32(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i9, in %dst_qs_i : i9, out dst_qs_o : i9) {
    %false = hw.constant false
    %gen_passthru.u_dst_to_src_ack.dst_pulse_o = hw.instance "gen_passthru.u_dst_to_src_ack" @prim_pulse_sync(clk_src_i: %clk_dst_i: i1, rst_src_ni: %rst_dst_ni: i1, src_pulse_i: %dst_req_i: i1, clk_dst_i: %clk_src_i: i1, rst_dst_ni: %rst_src_ni: i1) -> (dst_pulse_o: i1)
    hw.output %gen_passthru.u_dst_to_src_ack.dst_pulse_o, %false, %dst_req_i, %dst_qs_i : i1, i1, i1, i9
  }
  hw.module private @prim_reg_cdc_arb_33(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i9, in %dst_qs_i : i9, out dst_qs_o : i9) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i9 = hw.constant 0 : i9
    %false = hw.constant false
    %true = hw.constant true
    %clk_dst_i_0 = llhd.sig name "clk_dst_i" %false : i1
    %2 = llhd.prb %clk_dst_i_0 : i1
    %rst_dst_ni_1 = llhd.sig name "rst_dst_ni" %false : i1
    %3 = llhd.prb %rst_dst_ni_1 : i1
    %dst_req_i_2 = llhd.sig name "dst_req_i" %false : i1
    %dst_ds_i_3 = llhd.sig name "dst_ds_i" %c0_i9 : i9
    %dst_qs_i_4 = llhd.sig name "dst_qs_i" %c0_i9 : i9
    %dst_qs_o = llhd.sig %c0_i9 : i9
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
    %4 = llhd.prb %dst_qs_o : i9
    %5 = llhd.prb %dst_ds_i_3 : i9
    %6 = comb.icmp ne %4, %5 : i9
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
      llhd.drv %dst_qs_o, %c0_i9 after %0 : i9
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %37 = llhd.prb %gen_wr_req.dst_lat_d : i1
      cf.cond_br %37, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %38 = llhd.prb %dst_ds_i_3 : i9
      llhd.drv %dst_qs_o, %38 after %0 : i9
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %39 = llhd.prb %gen_wr_req.dst_lat_q : i1
      cf.cond_br %39, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %40 = llhd.prb %dst_qs_i_4 : i9
      llhd.drv %dst_qs_o, %40 after %0 : i9
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
    %19 = llhd.prb %dst_qs_i_4 : i9
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
      %30 = llhd.prb %dst_qs_o : i9
      %31 = llhd.prb %dst_qs_i_4 : i9
      %32 = comb.icmp ne %30, %31 : i9
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
      llhd.wait (%11, %14, %15, %16, %17, %12, %18, %4, %19, %20 : i1, i1, i1, i1, i1, i1, i1, i9, i9, i1), ^bb1
    }
    %21 = comb.or %15, %17, %16 {sv.namehint = "gen_wr_req.dst_update_req"} : i1
    %22 = llhd.prb %gen_wr_req.id_q : i1
    %23 = comb.xor %22, %true : i1
    %24 = comb.and %gen_wr_req.u_dst_update_sync.dst_req_o, %23 : i1
    %25 = comb.and %gen_wr_req.u_dst_update_sync.dst_req_o, %22 : i1
    llhd.drv %clk_dst_i_0, %clk_dst_i after %1 : i1
    llhd.drv %rst_dst_ni_1, %rst_dst_ni after %1 : i1
    llhd.drv %dst_req_i_2, %dst_req_i after %1 : i1
    llhd.drv %dst_ds_i_3, %dst_ds_i after %1 : i9
    llhd.drv %dst_qs_i_4, %dst_qs_i after %1 : i9
    hw.output %24, %25, %13, %4 : i1, i1, i1, i9
  }
  hw.module private @prim_reg_cdc_arb_34(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i5, in %dst_qs_i : i5, out dst_qs_o : i5) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i5 = hw.constant 0 : i5
    %false = hw.constant false
    %true = hw.constant true
    %clk_dst_i_0 = llhd.sig name "clk_dst_i" %false : i1
    %2 = llhd.prb %clk_dst_i_0 : i1
    %rst_dst_ni_1 = llhd.sig name "rst_dst_ni" %false : i1
    %3 = llhd.prb %rst_dst_ni_1 : i1
    %dst_req_i_2 = llhd.sig name "dst_req_i" %false : i1
    %dst_ds_i_3 = llhd.sig name "dst_ds_i" %c0_i5 : i5
    %dst_qs_i_4 = llhd.sig name "dst_qs_i" %c0_i5 : i5
    %dst_qs_o = llhd.sig %c0_i5 : i5
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
    %4 = llhd.prb %dst_qs_o : i5
    %5 = llhd.prb %dst_ds_i_3 : i5
    %6 = comb.icmp ne %4, %5 : i5
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
      llhd.drv %dst_qs_o, %c0_i5 after %0 : i5
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %37 = llhd.prb %gen_wr_req.dst_lat_d : i1
      cf.cond_br %37, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %38 = llhd.prb %dst_ds_i_3 : i5
      llhd.drv %dst_qs_o, %38 after %0 : i5
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %39 = llhd.prb %gen_wr_req.dst_lat_q : i1
      cf.cond_br %39, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %40 = llhd.prb %dst_qs_i_4 : i5
      llhd.drv %dst_qs_o, %40 after %0 : i5
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
    %19 = llhd.prb %dst_qs_i_4 : i5
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
      %30 = llhd.prb %dst_qs_o : i5
      %31 = llhd.prb %dst_qs_i_4 : i5
      %32 = comb.icmp ne %30, %31 : i5
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
      llhd.wait (%11, %14, %15, %16, %17, %12, %18, %4, %19, %20 : i1, i1, i1, i1, i1, i1, i1, i5, i5, i1), ^bb1
    }
    %21 = comb.or %15, %17, %16 {sv.namehint = "gen_wr_req.dst_update_req"} : i1
    %22 = llhd.prb %gen_wr_req.id_q : i1
    %23 = comb.xor %22, %true : i1
    %24 = comb.and %gen_wr_req.u_dst_update_sync.dst_req_o, %23 : i1
    %25 = comb.and %gen_wr_req.u_dst_update_sync.dst_req_o, %22 : i1
    llhd.drv %clk_dst_i_0, %clk_dst_i after %1 : i1
    llhd.drv %rst_dst_ni_1, %rst_dst_ni after %1 : i1
    llhd.drv %dst_req_i_2, %dst_req_i after %1 : i1
    llhd.drv %dst_ds_i_3, %dst_ds_i after %1 : i5
    llhd.drv %dst_qs_i_4, %dst_qs_i after %1 : i5
    hw.output %24, %25, %13, %4 : i1, i1, i1, i5
  }
  hw.module private @prim_reg_cdc(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i2, out src_busy_o : i1, out src_qs_o : i2, in %dst_ds_i : i2, in %dst_qs_i : i2, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i2) {
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
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i2, dst_qs_i: %dst_qs_i: i2) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i2) {sv.namehint = "dst_req"}
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
  hw.module private @prim_reg_cdc_1(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i32, out src_busy_o : i1, out src_qs_o : i32, in %dst_ds_i : i32, in %dst_qs_i : i32, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c-15_i32 = hw.constant -15 : i32
    %c0_i3 = hw.constant 0 : i3
    %c409712_i32 = hw.constant 409712 : i32
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
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb_26(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i32, dst_qs_i: %dst_qs_i: i32) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i32) {sv.namehint = "dst_req"}
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
      llhd.drv %src_q, %c409712_i32 after %0 : i32
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %src_req : i1
      cf.cond_br %29, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %30 = llhd.prb %src_wd_i_5 : i32
      %31 = comb.and %30, %c-15_i32 : i32
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
  hw.module private @prim_reg_cdc_2(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i8, out src_busy_o : i1, out src_qs_o : i8, in %dst_ds_i : i8, in %dst_qs_i : i8, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i8) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i8 = hw.constant 0 : i8
    %c0_i3 = hw.constant 0 : i3
    %c4_i8 = hw.constant 4 : i8
    %true = hw.constant true
    %false = hw.constant false
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %3 = llhd.prb %rst_src_ni_1 : i1
    %src_regwen_i_2 = llhd.sig name "src_regwen_i" %false : i1
    %src_we_i_3 = llhd.sig name "src_we_i" %false : i1
    %src_re_i_4 = llhd.sig name "src_re_i" %false : i1
    %src_wd_i_5 = llhd.sig name "src_wd_i" %c0_i8 : i8
    %src_ack = llhd.sig %false : i1
    %src_busy_q = llhd.sig %false : i1
    %src_q = llhd.sig %c0_i8 : i8
    %txn_bits_q = llhd.sig %c0_i3 : i3
    %src_req = llhd.sig %false : i1
    %dst_qs = llhd.sig %c0_i8 : i8
    %dst_to_src = llhd.sig %false : i1
    %4 = llhd.prb %src_req : i1
    %u_src_to_dst_req.dst_pulse_o = hw.instance "u_src_to_dst_req" @prim_pulse_sync(clk_src_i: %2: i1, rst_src_ni: %3: i1, src_pulse_i: %4: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1) -> (dst_pulse_o: i1) {sv.namehint = "dst_req_from_src"}
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb_27(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i8, dst_qs_i: %dst_qs_i: i8) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i8) {sv.namehint = "dst_req"}
    llhd.drv %src_ack, %u_arb.src_ack_o after %1 : i1
    llhd.drv %dst_qs, %u_arb.dst_qs_o after %1 : i8
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
      llhd.drv %src_q, %c4_i8 after %0 : i8
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %src_req : i1
      cf.cond_br %29, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %30 = llhd.prb %src_wd_i_5 : i8
      llhd.drv %src_q, %30 after %0 : i8
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
      %36 = llhd.prb %dst_qs : i8
      llhd.drv %src_q, %36 after %0 : i8
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    }
    %11 = llhd.prb %src_q : i8
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
    llhd.drv %src_wd_i_5, %src_wd_i after %1 : i8
    hw.output %8, %11, %15, %16, %17, %11 : i1, i8, i1, i1, i1, i8
  }
  hw.module private @prim_reg_cdc_3(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i16, out src_busy_o : i1, out src_qs_o : i16, in %dst_ds_i : i16, in %dst_qs_i : i16, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i16) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i16 = hw.constant 0 : i16
    %c0_i3 = hw.constant 0 : i3
    %c155_i16 = hw.constant 155 : i16
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
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb_28(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i16, dst_qs_i: %dst_qs_i: i16) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i16) {sv.namehint = "dst_req"}
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
      llhd.drv %src_q, %c155_i16 after %0 : i16
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
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb_29(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i1, dst_qs_i: %dst_qs_i: i1) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i1) {sv.namehint = "dst_req"}
    llhd.drv %src_ack, %u_arb.src_ack_o after %1 : i1
    llhd.drv %dst_qs, %u_arb.dst_qs_o after %1 : i1
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
      llhd.drv %src_q, %false after %0 : i1
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %src_req : i1
      cf.cond_br %29, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %30 = llhd.prb %src_wd_i_5 : i1
      llhd.drv %src_q, %30 after %0 : i1
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
      %36 = llhd.prb %dst_qs : i1
      llhd.drv %src_q, %36 after %0 : i1
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    }
    %11 = llhd.prb %src_q : i1
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
    llhd.drv %src_wd_i_5, %src_wd_i after %1 : i1
    hw.output %8, %11, %15, %16, %17, %11 : i1, i1, i1, i1, i1, i1
  }
  hw.module private @prim_reg_cdc_5(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i32, out src_busy_o : i1, out src_qs_o : i32, in %dst_ds_i : i32, in %dst_qs_i : i32, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i32) {
    %c0_i2 = hw.constant 0 : i2
    %c-469825537_i30 = hw.constant -469825537 : i30
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
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb_30(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i32, dst_qs_i: %dst_qs_i: i32) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i32) {sv.namehint = "dst_req"}
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
      %31 = comb.extract %30 from 2 : (i32) -> i30
      %32 = comb.and %31, %c-469825537_i30 : i30
      %33 = comb.concat %32, %c0_i2 : i30, i2
      llhd.drv %src_q, %33 after %0 : i32
      %34 = llhd.prb %src_we_i_3 : i1
      %35 = llhd.prb %src_re_i_4 : i1
      %36 = llhd.prb %src_regwen_i_2 : i1
      %37 = comb.concat %34, %35, %36 : i1, i1, i1
      llhd.drv %txn_bits_q, %37 after %0 : i3
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %38 = llhd.prb %dst_to_src : i1
      cf.cond_br %38, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %39 = llhd.prb %dst_qs : i32
      llhd.drv %src_q, %39 after %0 : i32
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
  hw.module private @prim_reg_cdc_6(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i28, out src_busy_o : i1, out src_qs_o : i28, in %dst_ds_i : i28, in %dst_qs_i : i28, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i28) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c-61441_i28 = hw.constant -61441 : i28
    %c0_i3 = hw.constant 0 : i3
    %c0_i28 = hw.constant 0 : i28
    %true = hw.constant true
    %false = hw.constant false
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %3 = llhd.prb %rst_src_ni_1 : i1
    %src_regwen_i_2 = llhd.sig name "src_regwen_i" %false : i1
    %src_we_i_3 = llhd.sig name "src_we_i" %false : i1
    %src_re_i_4 = llhd.sig name "src_re_i" %false : i1
    %src_wd_i_5 = llhd.sig name "src_wd_i" %c0_i28 : i28
    %src_ack = llhd.sig %false : i1
    %src_busy_q = llhd.sig %false : i1
    %src_q = llhd.sig %c0_i28 : i28
    %txn_bits_q = llhd.sig %c0_i3 : i3
    %src_req = llhd.sig %false : i1
    %dst_qs = llhd.sig %c0_i28 : i28
    %dst_to_src = llhd.sig %false : i1
    %4 = llhd.prb %src_req : i1
    %u_src_to_dst_req.dst_pulse_o = hw.instance "u_src_to_dst_req" @prim_pulse_sync(clk_src_i: %2: i1, rst_src_ni: %3: i1, src_pulse_i: %4: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1) -> (dst_pulse_o: i1) {sv.namehint = "dst_req_from_src"}
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb_31(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i28, dst_qs_i: %dst_qs_i: i28) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i28) {sv.namehint = "dst_req"}
    llhd.drv %src_ack, %u_arb.src_ack_o after %1 : i1
    llhd.drv %dst_qs, %u_arb.dst_qs_o after %1 : i28
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
      llhd.drv %src_q, %c0_i28 after %0 : i28
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %34 = llhd.prb %src_req : i1
      cf.cond_br %34, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %35 = llhd.prb %src_wd_i_5 : i28
      %36 = comb.and %35, %c-61441_i28 : i28
      llhd.drv %src_q, %36 after %0 : i28
      %37 = llhd.prb %src_we_i_3 : i1
      %38 = llhd.prb %src_re_i_4 : i1
      %39 = llhd.prb %src_regwen_i_2 : i1
      %40 = comb.concat %37, %38, %39 : i1, i1, i1
      llhd.drv %txn_bits_q, %40 after %0 : i3
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %41 = llhd.prb %dst_to_src : i1
      cf.cond_br %41, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %42 = llhd.prb %dst_qs : i28
      llhd.drv %src_q, %42 after %0 : i28
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    }
    %16 = llhd.prb %src_q : i28
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
    llhd.drv %src_wd_i_5, %src_wd_i after %1 : i28
    hw.output %8, %16, %20, %21, %22, %16 : i1, i28, i1, i1, i1, i28
  }
  hw.module private @prim_reg_cdc_7(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i9, out src_busy_o : i1, out src_qs_o : i9, in %dst_ds_i : i9, in %dst_qs_i : i9, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i9) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %c0_i9 = hw.constant 0 : i9
    %true = hw.constant true
    %false = hw.constant false
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %3 = llhd.prb %rst_src_ni_1 : i1
    %src_regwen_i_2 = llhd.sig name "src_regwen_i" %false : i1
    %src_we_i_3 = llhd.sig name "src_we_i" %false : i1
    %src_re_i_4 = llhd.sig name "src_re_i" %false : i1
    %src_wd_i_5 = llhd.sig name "src_wd_i" %c0_i9 : i9
    %src_ack = llhd.sig %false : i1
    %src_busy_q = llhd.sig %false : i1
    %src_q = llhd.sig %c0_i9 : i9
    %txn_bits_q = llhd.sig %c0_i3 : i3
    %src_req = llhd.sig %false : i1
    %dst_qs = llhd.sig %c0_i9 : i9
    %dst_to_src = llhd.sig %false : i1
    %4 = llhd.prb %src_req : i1
    %u_src_to_dst_req.dst_pulse_o = hw.instance "u_src_to_dst_req" @prim_pulse_sync(clk_src_i: %2: i1, rst_src_ni: %3: i1, src_pulse_i: %4: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1) -> (dst_pulse_o: i1) {sv.namehint = "dst_req_from_src"}
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb_32(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i9, dst_qs_i: %dst_qs_i: i9) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i9) {sv.namehint = "dst_req"}
    llhd.drv %src_ack, %u_arb.src_ack_o after %1 : i1
    llhd.drv %dst_qs, %u_arb.dst_qs_o after %1 : i9
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
      llhd.drv %src_q, %c0_i9 after %0 : i9
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %src_req : i1
      cf.cond_br %29, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %30 = llhd.prb %src_wd_i_5 : i9
      llhd.drv %src_q, %30 after %0 : i9
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
      %36 = llhd.prb %dst_qs : i9
      llhd.drv %src_q, %36 after %0 : i9
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    }
    %11 = llhd.prb %src_q : i9
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
    llhd.drv %src_wd_i_5, %src_wd_i after %1 : i9
    hw.output %8, %11, %15, %16, %17, %11 : i1, i9, i1, i1, i1, i9
  }
  hw.module private @prim_reg_cdc_8(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i9, out src_busy_o : i1, out src_qs_o : i9, in %dst_ds_i : i9, in %dst_qs_i : i9, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i9) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %c0_i9 = hw.constant 0 : i9
    %true = hw.constant true
    %false = hw.constant false
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %3 = llhd.prb %rst_src_ni_1 : i1
    %src_regwen_i_2 = llhd.sig name "src_regwen_i" %false : i1
    %src_we_i_3 = llhd.sig name "src_we_i" %false : i1
    %src_re_i_4 = llhd.sig name "src_re_i" %false : i1
    %src_wd_i_5 = llhd.sig name "src_wd_i" %c0_i9 : i9
    %src_ack = llhd.sig %false : i1
    %src_busy_q = llhd.sig %false : i1
    %src_q = llhd.sig %c0_i9 : i9
    %txn_bits_q = llhd.sig %c0_i3 : i3
    %src_req = llhd.sig %false : i1
    %dst_qs = llhd.sig %c0_i9 : i9
    %dst_to_src = llhd.sig %false : i1
    %4 = llhd.prb %src_req : i1
    %u_src_to_dst_req.dst_pulse_o = hw.instance "u_src_to_dst_req" @prim_pulse_sync(clk_src_i: %2: i1, rst_src_ni: %3: i1, src_pulse_i: %4: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1) -> (dst_pulse_o: i1) {sv.namehint = "dst_req_from_src"}
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb_33(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i9, dst_qs_i: %dst_qs_i: i9) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i9) {sv.namehint = "dst_req"}
    llhd.drv %src_ack, %u_arb.src_ack_o after %1 : i1
    llhd.drv %dst_qs, %u_arb.dst_qs_o after %1 : i9
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
      llhd.drv %src_q, %c0_i9 after %0 : i9
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %34 = llhd.prb %src_req : i1
      cf.cond_br %34, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %35 = llhd.prb %src_wd_i_5 : i9
      llhd.drv %src_q, %35 after %0 : i9
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
      %41 = llhd.prb %dst_qs : i9
      llhd.drv %src_q, %41 after %0 : i9
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    }
    %16 = llhd.prb %src_q : i9
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
    llhd.drv %src_wd_i_5, %src_wd_i after %1 : i9
    hw.output %8, %16, %20, %21, %22, %16 : i1, i9, i1, i1, i1, i9
  }
  hw.module private @prim_reg_cdc_9(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i5, out src_busy_o : i1, out src_qs_o : i5, in %dst_ds_i : i5, in %dst_qs_i : i5, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i5) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %c0_i5 = hw.constant 0 : i5
    %true = hw.constant true
    %false = hw.constant false
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %3 = llhd.prb %rst_src_ni_1 : i1
    %src_regwen_i_2 = llhd.sig name "src_regwen_i" %false : i1
    %src_we_i_3 = llhd.sig name "src_we_i" %false : i1
    %src_re_i_4 = llhd.sig name "src_re_i" %false : i1
    %src_wd_i_5 = llhd.sig name "src_wd_i" %c0_i5 : i5
    %src_ack = llhd.sig %false : i1
    %src_busy_q = llhd.sig %false : i1
    %src_q = llhd.sig %c0_i5 : i5
    %txn_bits_q = llhd.sig %c0_i3 : i3
    %src_req = llhd.sig %false : i1
    %dst_qs = llhd.sig %c0_i5 : i5
    %dst_to_src = llhd.sig %false : i1
    %4 = llhd.prb %src_req : i1
    %u_src_to_dst_req.dst_pulse_o = hw.instance "u_src_to_dst_req" @prim_pulse_sync(clk_src_i: %2: i1, rst_src_ni: %3: i1, src_pulse_i: %4: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1) -> (dst_pulse_o: i1) {sv.namehint = "dst_req_from_src"}
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb_34(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i5, dst_qs_i: %dst_qs_i: i5) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i5) {sv.namehint = "dst_req"}
    llhd.drv %src_ack, %u_arb.src_ack_o after %1 : i1
    llhd.drv %dst_qs, %u_arb.dst_qs_o after %1 : i5
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
      llhd.drv %src_q, %c0_i5 after %0 : i5
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %34 = llhd.prb %src_req : i1
      cf.cond_br %34, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %35 = llhd.prb %src_wd_i_5 : i5
      llhd.drv %src_q, %35 after %0 : i5
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
      %41 = llhd.prb %dst_qs : i5
      llhd.drv %src_q, %41 after %0 : i5
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    }
    %16 = llhd.prb %src_q : i5
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
    llhd.drv %src_wd_i_5, %src_wd_i after %1 : i5
    hw.output %8, %16, %20, %21, %22, %16 : i1, i5, i1, i1, i1, i5
  }
  hw.module private @prim_reg_we_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i32, in %en_i : i1, out err_o : i1) {
    %c0_i5 = hw.constant 0 : i5
    %u_prim_buf.out_o = hw.instance "u_prim_buf" @prim_buf_24(in_i: %oh_i: i32) -> (out_o: i32) {sv.namehint = "oh_buf"}
    %u_prim_onehot_check.err_o = hw.instance "u_prim_onehot_check" @prim_onehot_check(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, oh_i: %u_prim_buf.out_o: i32, addr_i: %c0_i5: i5, en_i: %en_i: i1) -> (err_o: i1)
    hw.output %u_prim_onehot_check.err_o : i1
  }
  hw.module private @prim_sec_anchor_buf(in %in_i : i2, out out_o : i2) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf(in_i: %in_i: i2) -> (out_o: i2)
    hw.output %u_secure_anchor_buf.out_o : i2
  }
  hw.module private @prim_sec_anchor_buf_0(in %in_i : i1, out out_o : i1) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_23(in_i: %in_i: i1) -> (out_o: i1)
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
    hw.output %de, %d : i1, i1
  }
  hw.module private @prim_subreg_arb_35(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
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
  hw.module private @prim_subreg_arb_36(in %we : i1, in %wd : i4, in %de : i1, in %d : i4, in %q : i4, out wr_en : i1, out wr_data : i4) {
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
  hw.module private @prim_subreg_arb_37(in %we : i1, in %wd : i24, in %de : i1, in %d : i24, in %q : i24, out wr_en : i1, out wr_data : i24) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i24 = hw.constant 0 : i24
    %wd_0 = llhd.sig name "wd" %c0_i24 : i24
    %d_1 = llhd.sig name "d" %c0_i24 : i24
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %wd_0 : i24
    %3 = llhd.prb %d_1 : i24
    %4 = comb.mux %we, %2, %3 : i24
    llhd.drv %wd_0, %wd after %0 : i24
    llhd.drv %d_1, %d after %0 : i24
    hw.output %1, %4 : i1, i24
  }
  hw.module private @prim_subreg_arb_38(in %we : i1, in %wd : i8, in %de : i1, in %d : i8, in %q : i8, out wr_en : i1, out wr_data : i8) {
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
  hw.module private @prim_subreg_arb_39(in %we : i1, in %wd : i16, in %de : i1, in %d : i16, in %q : i16, out wr_en : i1, out wr_data : i16) {
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
  hw.module private @prim_subreg_arb_40(in %we : i1, in %wd : i10, in %de : i1, in %d : i10, in %q : i10, out wr_en : i1, out wr_data : i10) {
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
  hw.module private @prim_subreg_arb_41(in %we : i1, in %wd : i2, in %de : i1, in %d : i2, in %q : i2, out wr_en : i1, out wr_data : i2) {
    hw.output %de, %d : i1, i2
  }
  hw.module private @prim_subreg_arb_42(in %we : i1, in %wd : i10, in %de : i1, in %d : i10, in %q : i10, out wr_en : i1, out wr_data : i10) {
    hw.output %de, %d : i1, i10
  }
  hw.module private @prim_subreg_arb_43(in %we : i1, in %wd : i8, in %de : i1, in %d : i8, in %q : i8, out wr_en : i1, out wr_data : i8) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c-1_i8 = hw.constant -1 : i8
    %c0_i8 = hw.constant 0 : i8
    %wd_0 = llhd.sig name "wd" %c0_i8 : i8
    %d_1 = llhd.sig name "d" %c0_i8 : i8
    %q_2 = llhd.sig name "q" %c0_i8 : i8
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %d_1 : i8
    %3 = llhd.prb %q_2 : i8
    %4 = comb.mux %de, %2, %3 : i8
    %5 = llhd.prb %wd_0 : i8
    %6 = comb.replicate %we : (i1) -> i8
    %7 = comb.and %6, %5 : i8
    %8 = comb.xor %7, %c-1_i8 : i8
    %9 = comb.and %4, %8 : i8
    llhd.drv %wd_0, %wd after %0 : i8
    llhd.drv %d_1, %d after %0 : i8
    llhd.drv %q_2, %q after %0 : i8
    hw.output %1, %9 : i1, i8
  }
  hw.module private @prim_subreg_arb_44(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
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
  hw.module private @prim_subreg_ext_21(in %re : i1, in %we : i1, in %wd : i5, in %d : i5, out qe : i1, out qre : i1, out q : i5, out ds : i5, out qs : i5) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i5, i5, i5
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_35(we: %we: i1, wd: %wd: i1, de: %de: i1, d: %d: i1, q: %4: i1) -> (wr_en: i1, wr_data: i1)
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
  hw.module private @prim_subreg_11(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i4, in %de : i1, in %d : i4, out qe : i1, out q : i4, out ds : i4, out qs : i4) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_36(we: %we: i1, wd: %wd: i4, de: %de: i1, d: %d: i4, q: %4: i4) -> (wr_en: i1, wr_data: i4)
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
  hw.module private @prim_subreg_12(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i24, in %de : i1, in %d : i24, out qe : i1, out q : i24, out ds : i24, out qs : i24) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i24 = hw.constant 0 : i24
    %c1600_i24 = hw.constant 1600 : i24
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %q = llhd.sig %c0_i24 : i24
    %qs = llhd.sig %c0_i24 : i24
    %wr_en = llhd.sig %false : i1
    %wr_data = llhd.sig %c0_i24 : i24
    %4 = llhd.prb %q : i24
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_37(we: %we: i1, wd: %wd: i24, de: %de: i1, d: %d: i24, q: %4: i24) -> (wr_en: i1, wr_data: i24)
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    llhd.drv %wr_data, %wr_en_data_arb.wr_data after %1 : i24
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
      llhd.drv %q, %c1600_i24 after %0 : i24
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %wr_en : i1
      cf.cond_br %20, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %21 = llhd.prb %wr_data : i24
      llhd.drv %q, %21 after %0 : i24
      cf.br ^bb1
    }
    %5 = llhd.prb %wr_en : i1
    %6 = llhd.prb %wr_data : i24
    %7 = llhd.prb %qs : i24
    %8 = comb.mux %5, %6, %7 : i24
    llhd.drv %qs, %4 after %1 : i24
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %we, %4, %8, %7 : i1, i24, i24, i24
  }
  hw.module private @prim_subreg_13(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i8, in %de : i1, in %d : i8, out qe : i1, out q : i8, out ds : i8, out qs : i8) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i8 = hw.constant 0 : i8
    %c4_i8 = hw.constant 4 : i8
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_38(we: %we: i1, wd: %wd: i8, de: %de: i1, d: %d: i8, q: %4: i8) -> (wr_en: i1, wr_data: i8)
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
      llhd.drv %q, %c4_i8 after %0 : i8
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
  hw.module private @prim_subreg_14(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i16, in %de : i1, in %d : i16, out qe : i1, out q : i16, out ds : i16, out qs : i16) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i16 = hw.constant 0 : i16
    %c155_i16 = hw.constant 155 : i16
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_39(we: %we: i1, wd: %wd: i16, de: %de: i1, d: %d: i16, q: %4: i16) -> (wr_en: i1, wr_data: i16)
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
      llhd.drv %q, %c155_i16 after %0 : i16
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
  hw.module private @prim_subreg_15(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i10, in %de : i1, in %d : i10, out qe : i1, out q : i10, out ds : i10, out qs : i10) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_40(we: %we: i1, wd: %wd: i10, de: %de: i1, d: %d: i10, q: %4: i10) -> (wr_en: i1, wr_data: i10)
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
  hw.module private @prim_subreg_16(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i2, in %de : i1, in %d : i2, out qe : i1, out q : i2, out ds : i2, out qs : i2) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_41(we: %we: i1, wd: %wd: i2, de: %de: i1, d: %d: i2, q: %4: i2) -> (wr_en: i1, wr_data: i2)
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
  hw.module private @prim_subreg_17(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i10, in %de : i1, in %d : i10, out qe : i1, out q : i10, out ds : i10, out qs : i10) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_42(we: %we: i1, wd: %wd: i10, de: %de: i1, d: %d: i10, q: %4: i10) -> (wr_en: i1, wr_data: i10)
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
  hw.module private @prim_subreg_18(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i8, in %de : i1, in %d : i8, out qe : i1, out q : i8, out ds : i8, out qs : i8) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_38(we: %we: i1, wd: %wd: i8, de: %de: i1, d: %d: i8, q: %4: i8) -> (wr_en: i1, wr_data: i8)
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
  hw.module private @prim_subreg_19(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i8, in %de : i1, in %d : i8, out qe : i1, out q : i8, out ds : i8, out qs : i8) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_43(we: %we: i1, wd: %wd: i8, de: %de: i1, d: %d: i8, q: %4: i8) -> (wr_en: i1, wr_data: i8)
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
  hw.module private @prim_subreg_20(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_44(we: %we: i1, wd: %wd: i1, de: %de: i1, d: %d: i1, q: %4: i1) -> (wr_en: i1, wr_data: i1)
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
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen_25(tl_i: %32: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
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
  hw.module private @tlul_rsp_intg_gen_25(in %tl_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) {
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
  hw.module private @adc_ctrl_core(in %clk_aon_i : i1, in %rst_aon_ni : i1, in %clk_i : i1, in %rst_ni : i1, in %reg2hw_i : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>, out intr_state_o : !hw.struct<d: i1, de: i1>, out adc_chn_val_o : !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>, out adc_intr_status_o : !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, out aon_filter_status_o : !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, out wkup_req_o : i1, out intr_o : i1, in %adc_i : !hw.struct<data: i10, data_valid: i1>, out adc_o : !hw.struct<channel_sel: i2, pd: i1>, out aon_fsm_state_o : i5) {
    %c-1_i3 = hw.constant -1 : i3
    %c-2_i3 = hw.constant -2 : i3
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %true = hw.constant true
    %c0_i3 = hw.constant 0 : i3
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = hw.aggregate_constant [[[0 : i10, 0 : i10, false, false], [0 : i10, 0 : i10, false, false], [0 : i10, 0 : i10, false, false], [0 : i10, 0 : i10, false, false], [0 : i10, 0 : i10, false, false], [0 : i10, 0 : i10, false, false], [0 : i10, 0 : i10, false, false], [0 : i10, 0 : i10, false, false]], [[0 : i10, 0 : i10, false, false], [0 : i10, 0 : i10, false, false], [0 : i10, 0 : i10, false, false], [0 : i10, 0 : i10, false, false], [0 : i10, 0 : i10, false, false], [0 : i10, 0 : i10, false, false], [0 : i10, 0 : i10, false, false], [0 : i10, 0 : i10, false, false]]] : !hw.array<2xarray<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>
    %c0_i8 = hw.constant 0 : i8
    %c0_i10 = hw.constant 0 : i10
    %2 = hw.aggregate_constant [0 : i2, false] : !hw.struct<channel_sel: i2, pd: i1>
    %3 = hw.aggregate_constant [[false, false], [0 : i8, false]] : !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>
    %4 = hw.aggregate_constant [[[0 : i10, false], [0 : i2, false], [0 : i10, false], [0 : i2, false]], [[0 : i10, false], [0 : i2, false], [0 : i10, false], [0 : i2, false]]] : !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>
    %c0_i2 = hw.constant 0 : i2
    %false = hw.constant false
    %5 = hw.aggregate_constant [[false], [false], [false, false], [false, false], [[false], [false]], [[0 : i24], [0 : i4], [false]], [0 : i8], [0 : i16], [false], [[[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]]], [[[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]]], [[false], [0 : i8]], [[false], [0 : i8]], [[false], [false], [0 : i8]], [[false], [false], [0 : i8]]] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %reg2hw_i_0 = llhd.sig name "reg2hw_i" %5 : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %adc_chn_val_o = llhd.sig %4 : !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>
    %aon_filter_status_o = llhd.sig %3 : !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>
    %adc_o = llhd.sig %2 : !hw.struct<channel_sel: i2, pd: i1>
    %chn0_val = llhd.sig %c0_i10 : i10
    %chn1_val = llhd.sig %c0_i10 : i10
    %chn0_match = llhd.sig %c0_i8 : i8
    %chn1_match = llhd.sig %c0_i8 : i8
    %match = llhd.sig %c0_i8 : i8
    %match_pulse = llhd.sig %c0_i8 : i8
    %oneshot_done = llhd.sig %false : i1
    %aon_filter_ctl = llhd.sig %1 : !hw.array<2xarray<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>
    %6 = llhd.prb %reg2hw_i_0 : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %adc_fsm_rst = hw.struct_extract %6["adc_fsm_rst"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %q = hw.struct_extract %adc_fsm_rst["q"] : !hw.struct<q: i1>
    %adc_en_ctl = hw.struct_extract %6["adc_en_ctl"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %adc_enable = hw.struct_extract %adc_en_ctl["adc_enable"] : !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>
    %q_1 = hw.struct_extract %adc_enable["q"] : !hw.struct<q: i1>
    %oneshot_mode = hw.struct_extract %adc_en_ctl["oneshot_mode"] : !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>
    %q_2 = hw.struct_extract %oneshot_mode["q"] : !hw.struct<q: i1>
    %adc_pd_ctl = hw.struct_extract %6["adc_pd_ctl"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %lp_mode = hw.struct_extract %adc_pd_ctl["lp_mode"] : !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>
    %q_3 = hw.struct_extract %lp_mode["q"] : !hw.struct<q: i1>
    %pwrup_time = hw.struct_extract %adc_pd_ctl["pwrup_time"] : !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>
    %q_4 = hw.struct_extract %pwrup_time["q"] : !hw.struct<q: i4>
    %wakeup_time = hw.struct_extract %adc_pd_ctl["wakeup_time"] : !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>
    %q_5 = hw.struct_extract %wakeup_time["q"] : !hw.struct<q: i24>
    %adc_lp_sample_ctl = hw.struct_extract %6["adc_lp_sample_ctl"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %q_6 = hw.struct_extract %adc_lp_sample_ctl["q"] : !hw.struct<q: i8>
    %adc_sample_ctl = hw.struct_extract %6["adc_sample_ctl"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %q_7 = hw.struct_extract %adc_sample_ctl["q"] : !hw.struct<q: i16>
    %7 = llhd.prb %match : i8
    %data = hw.struct_extract %adc_i["data"] : !hw.struct<data: i10, data_valid: i1>
    %data_valid = hw.struct_extract %adc_i["data_valid"] : !hw.struct<data: i10, data_valid: i1>
    %8 = llhd.sig.struct_extract %adc_o["pd"] : <!hw.struct<channel_sel: i2, pd: i1>>
    %9 = llhd.sig.struct_extract %adc_o["channel_sel"] : <!hw.struct<channel_sel: i2, pd: i1>>
    %u_adc_ctrl_fsm.adc_pd_o, %u_adc_ctrl_fsm.adc_chn_sel_o, %u_adc_ctrl_fsm.chn0_val_we_o, %u_adc_ctrl_fsm.chn1_val_we_o, %u_adc_ctrl_fsm.chn0_val_o, %u_adc_ctrl_fsm.chn1_val_o, %u_adc_ctrl_fsm.adc_ctrl_done_o, %u_adc_ctrl_fsm.oneshot_done_o, %u_adc_ctrl_fsm.aon_fsm_state_o, %u_adc_ctrl_fsm.aon_fsm_trans_o = hw.instance "u_adc_ctrl_fsm" @adc_ctrl_fsm(clk_aon_i: %clk_aon_i: i1, rst_aon_ni: %rst_aon_ni: i1, cfg_fsm_rst_i: %q: i1, cfg_adc_enable_i: %q_1: i1, cfg_oneshot_mode_i: %q_2: i1, cfg_lp_mode_i: %q_3: i1, cfg_pwrup_time_i: %q_4: i4, cfg_wakeup_time_i: %q_5: i24, cfg_lp_sample_cnt_i: %q_6: i8, cfg_np_sample_cnt_i: %q_7: i16, adc_ctrl_match_i: %7: i8, adc_d_i: %data: i10, adc_d_val_i: %data_valid: i1) -> (adc_pd_o: i1, adc_chn_sel_o: i2, chn0_val_we_o: i1, chn1_val_we_o: i1, chn0_val_o: i10, chn1_val_o: i10, adc_ctrl_done_o: i1, oneshot_done_o: i1, aon_fsm_state_o: i5, aon_fsm_trans_o: i1) {sv.namehint = "chn1_val_we"}
    llhd.drv %8, %u_adc_ctrl_fsm.adc_pd_o after %0 : i1
    llhd.drv %9, %u_adc_ctrl_fsm.adc_chn_sel_o after %0 : i2
    llhd.drv %chn0_val, %u_adc_ctrl_fsm.chn0_val_o after %0 : i10
    llhd.drv %chn1_val, %u_adc_ctrl_fsm.chn1_val_o after %0 : i10
    llhd.drv %oneshot_done, %u_adc_ctrl_fsm.oneshot_done_o after %0 : i1
    %10 = llhd.prb %oneshot_done : i1
    %u_oneshot_done_sync.dst_pulse_o = hw.instance "u_oneshot_done_sync" @prim_pulse_sync(clk_src_i: %clk_aon_i: i1, rst_src_ni: %rst_aon_ni: i1, src_pulse_i: %10: i1, clk_dst_i: %clk_i: i1, rst_dst_ni: %rst_ni: i1) -> (dst_pulse_o: i1) {sv.namehint = "cfg_oneshot_done"}
    %11 = llhd.prb %match_pulse : i8
    %adc_intr_ctl = hw.struct_extract %6["adc_intr_ctl"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %match_en = hw.struct_extract %adc_intr_ctl["match_en"] : !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>
    %q_8 = hw.struct_extract %match_en["q"] : !hw.struct<q: i8>
    %trans_en = hw.struct_extract %adc_intr_ctl["trans_en"] : !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>
    %q_9 = hw.struct_extract %trans_en["q"] : !hw.struct<q: i1>
    %oneshot_en = hw.struct_extract %adc_intr_ctl["oneshot_en"] : !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>
    %q_10 = hw.struct_extract %oneshot_en["q"] : !hw.struct<q: i1>
    %intr_state = hw.struct_extract %6["intr_state"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %intr_enable = hw.struct_extract %6["intr_enable"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %intr_test = hw.struct_extract %6["intr_test"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %adc_intr_status = hw.struct_extract %6["adc_intr_status"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %u_adc_ctrl_intr.intr_state_o, %u_adc_ctrl_intr.adc_intr_status_o, %u_adc_ctrl_intr.intr_o = hw.instance "u_adc_ctrl_intr" @adc_ctrl_intr(clk_aon_i: %clk_aon_i: i1, rst_aon_ni: %rst_aon_ni: i1, clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, aon_filter_match_i: %11: i8, aon_fsm_trans_i: %u_adc_ctrl_fsm.aon_fsm_trans_o: i1, cfg_oneshot_done_i: %u_oneshot_done_sync.dst_pulse_o: i1, cfg_intr_en_i: %q_8: i8, cfg_intr_trans_en_i: %q_9: i1, cfg_oneshot_done_en_i: %q_10: i1, intr_state_i: %intr_state: !hw.struct<q: i1>, intr_enable_i: %intr_enable: !hw.struct<q: i1>, intr_test_i: %intr_test: !hw.struct<q: i1, qe: i1>, adc_intr_status_i: %adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>) -> (intr_state_o: !hw.struct<d: i1, de: i1>, adc_intr_status_o: !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, intr_o: i1)
    %12 = llhd.sig.array_get %aon_filter_ctl[%false] : <!hw.array<2xarray<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>>
    %13 = llhd.sig.array_get %12[%c0_i3] : <!hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>
    %adc_chn0_filter_ctl = hw.struct_extract %6["adc_chn0_filter_ctl"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %14 = hw.array_get %adc_chn0_filter_ctl[%c0_i3] : !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, i3
    %min_v = hw.struct_extract %14["min_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_11 = hw.struct_extract %min_v["q"] : !hw.struct<q: i10>
    %max_v = hw.struct_extract %14["max_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_12 = hw.struct_extract %max_v["q"] : !hw.struct<q: i10>
    %cond = hw.struct_extract %14["cond"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_13 = hw.struct_extract %cond["q"] : !hw.struct<q: i1>
    %en = hw.struct_extract %14["en"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_14 = hw.struct_extract %en["q"] : !hw.struct<q: i1>
    %15 = hw.struct_create (%q_11, %q_12, %q_13, %q_14) : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    llhd.drv %13, %15 after %0 : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %16 = llhd.sig.array_get %aon_filter_ctl[%true] : <!hw.array<2xarray<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>>
    %17 = llhd.sig.array_get %16[%c0_i3] : <!hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>
    %adc_chn1_filter_ctl = hw.struct_extract %6["adc_chn1_filter_ctl"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %18 = hw.array_get %adc_chn1_filter_ctl[%c0_i3] : !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, i3
    %min_v_15 = hw.struct_extract %18["min_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_16 = hw.struct_extract %min_v_15["q"] : !hw.struct<q: i10>
    %max_v_17 = hw.struct_extract %18["max_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_18 = hw.struct_extract %max_v_17["q"] : !hw.struct<q: i10>
    %cond_19 = hw.struct_extract %18["cond"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_20 = hw.struct_extract %cond_19["q"] : !hw.struct<q: i1>
    %en_21 = hw.struct_extract %18["en"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_22 = hw.struct_extract %en_21["q"] : !hw.struct<q: i1>
    %19 = hw.struct_create (%q_16, %q_18, %q_20, %q_22) : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    llhd.drv %17, %19 after %0 : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %20 = llhd.sig.array_get %12[%c1_i3] : <!hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>
    %21 = hw.array_get %adc_chn0_filter_ctl[%c1_i3] : !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, i3
    %min_v_23 = hw.struct_extract %21["min_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_24 = hw.struct_extract %min_v_23["q"] : !hw.struct<q: i10>
    %max_v_25 = hw.struct_extract %21["max_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_26 = hw.struct_extract %max_v_25["q"] : !hw.struct<q: i10>
    %cond_27 = hw.struct_extract %21["cond"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_28 = hw.struct_extract %cond_27["q"] : !hw.struct<q: i1>
    %en_29 = hw.struct_extract %21["en"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_30 = hw.struct_extract %en_29["q"] : !hw.struct<q: i1>
    %22 = hw.struct_create (%q_24, %q_26, %q_28, %q_30) : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    llhd.drv %20, %22 after %0 : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %23 = llhd.sig.array_get %16[%c1_i3] : <!hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>
    %24 = hw.array_get %adc_chn1_filter_ctl[%c1_i3] : !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, i3
    %min_v_31 = hw.struct_extract %24["min_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_32 = hw.struct_extract %min_v_31["q"] : !hw.struct<q: i10>
    %max_v_33 = hw.struct_extract %24["max_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_34 = hw.struct_extract %max_v_33["q"] : !hw.struct<q: i10>
    %cond_35 = hw.struct_extract %24["cond"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_36 = hw.struct_extract %cond_35["q"] : !hw.struct<q: i1>
    %en_37 = hw.struct_extract %24["en"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_38 = hw.struct_extract %en_37["q"] : !hw.struct<q: i1>
    %25 = hw.struct_create (%q_32, %q_34, %q_36, %q_38) : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    llhd.drv %23, %25 after %0 : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %26 = llhd.sig.array_get %12[%c2_i3] : <!hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>
    %27 = hw.array_get %adc_chn0_filter_ctl[%c2_i3] : !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, i3
    %min_v_39 = hw.struct_extract %27["min_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_40 = hw.struct_extract %min_v_39["q"] : !hw.struct<q: i10>
    %max_v_41 = hw.struct_extract %27["max_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_42 = hw.struct_extract %max_v_41["q"] : !hw.struct<q: i10>
    %cond_43 = hw.struct_extract %27["cond"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_44 = hw.struct_extract %cond_43["q"] : !hw.struct<q: i1>
    %en_45 = hw.struct_extract %27["en"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_46 = hw.struct_extract %en_45["q"] : !hw.struct<q: i1>
    %28 = hw.struct_create (%q_40, %q_42, %q_44, %q_46) : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    llhd.drv %26, %28 after %0 : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %29 = llhd.sig.array_get %16[%c2_i3] : <!hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>
    %30 = hw.array_get %adc_chn1_filter_ctl[%c2_i3] : !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, i3
    %min_v_47 = hw.struct_extract %30["min_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_48 = hw.struct_extract %min_v_47["q"] : !hw.struct<q: i10>
    %max_v_49 = hw.struct_extract %30["max_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_50 = hw.struct_extract %max_v_49["q"] : !hw.struct<q: i10>
    %cond_51 = hw.struct_extract %30["cond"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_52 = hw.struct_extract %cond_51["q"] : !hw.struct<q: i1>
    %en_53 = hw.struct_extract %30["en"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_54 = hw.struct_extract %en_53["q"] : !hw.struct<q: i1>
    %31 = hw.struct_create (%q_48, %q_50, %q_52, %q_54) : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    llhd.drv %29, %31 after %0 : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %32 = llhd.sig.array_get %12[%c3_i3] : <!hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>
    %33 = hw.array_get %adc_chn0_filter_ctl[%c3_i3] : !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, i3
    %min_v_55 = hw.struct_extract %33["min_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_56 = hw.struct_extract %min_v_55["q"] : !hw.struct<q: i10>
    %max_v_57 = hw.struct_extract %33["max_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_58 = hw.struct_extract %max_v_57["q"] : !hw.struct<q: i10>
    %cond_59 = hw.struct_extract %33["cond"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_60 = hw.struct_extract %cond_59["q"] : !hw.struct<q: i1>
    %en_61 = hw.struct_extract %33["en"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_62 = hw.struct_extract %en_61["q"] : !hw.struct<q: i1>
    %34 = hw.struct_create (%q_56, %q_58, %q_60, %q_62) : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    llhd.drv %32, %34 after %0 : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %35 = llhd.sig.array_get %16[%c3_i3] : <!hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>
    %36 = hw.array_get %adc_chn1_filter_ctl[%c3_i3] : !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, i3
    %min_v_63 = hw.struct_extract %36["min_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_64 = hw.struct_extract %min_v_63["q"] : !hw.struct<q: i10>
    %max_v_65 = hw.struct_extract %36["max_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_66 = hw.struct_extract %max_v_65["q"] : !hw.struct<q: i10>
    %cond_67 = hw.struct_extract %36["cond"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_68 = hw.struct_extract %cond_67["q"] : !hw.struct<q: i1>
    %en_69 = hw.struct_extract %36["en"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_70 = hw.struct_extract %en_69["q"] : !hw.struct<q: i1>
    %37 = hw.struct_create (%q_64, %q_66, %q_68, %q_70) : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    llhd.drv %35, %37 after %0 : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %38 = llhd.sig.array_get %12[%c-4_i3] : <!hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>
    %39 = hw.array_get %adc_chn0_filter_ctl[%c-4_i3] : !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, i3
    %min_v_71 = hw.struct_extract %39["min_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_72 = hw.struct_extract %min_v_71["q"] : !hw.struct<q: i10>
    %max_v_73 = hw.struct_extract %39["max_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_74 = hw.struct_extract %max_v_73["q"] : !hw.struct<q: i10>
    %cond_75 = hw.struct_extract %39["cond"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_76 = hw.struct_extract %cond_75["q"] : !hw.struct<q: i1>
    %en_77 = hw.struct_extract %39["en"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_78 = hw.struct_extract %en_77["q"] : !hw.struct<q: i1>
    %40 = hw.struct_create (%q_72, %q_74, %q_76, %q_78) : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    llhd.drv %38, %40 after %0 : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %41 = llhd.sig.array_get %16[%c-4_i3] : <!hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>
    %42 = hw.array_get %adc_chn1_filter_ctl[%c-4_i3] : !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, i3
    %min_v_79 = hw.struct_extract %42["min_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_80 = hw.struct_extract %min_v_79["q"] : !hw.struct<q: i10>
    %max_v_81 = hw.struct_extract %42["max_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_82 = hw.struct_extract %max_v_81["q"] : !hw.struct<q: i10>
    %cond_83 = hw.struct_extract %42["cond"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_84 = hw.struct_extract %cond_83["q"] : !hw.struct<q: i1>
    %en_85 = hw.struct_extract %42["en"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_86 = hw.struct_extract %en_85["q"] : !hw.struct<q: i1>
    %43 = hw.struct_create (%q_80, %q_82, %q_84, %q_86) : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    llhd.drv %41, %43 after %0 : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %44 = llhd.sig.array_get %12[%c-3_i3] : <!hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>
    %45 = hw.array_get %adc_chn0_filter_ctl[%c-3_i3] : !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, i3
    %min_v_87 = hw.struct_extract %45["min_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_88 = hw.struct_extract %min_v_87["q"] : !hw.struct<q: i10>
    %max_v_89 = hw.struct_extract %45["max_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_90 = hw.struct_extract %max_v_89["q"] : !hw.struct<q: i10>
    %cond_91 = hw.struct_extract %45["cond"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_92 = hw.struct_extract %cond_91["q"] : !hw.struct<q: i1>
    %en_93 = hw.struct_extract %45["en"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_94 = hw.struct_extract %en_93["q"] : !hw.struct<q: i1>
    %46 = hw.struct_create (%q_88, %q_90, %q_92, %q_94) : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    llhd.drv %44, %46 after %0 : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %47 = llhd.sig.array_get %16[%c-3_i3] : <!hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>
    %48 = hw.array_get %adc_chn1_filter_ctl[%c-3_i3] : !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, i3
    %min_v_95 = hw.struct_extract %48["min_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_96 = hw.struct_extract %min_v_95["q"] : !hw.struct<q: i10>
    %max_v_97 = hw.struct_extract %48["max_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_98 = hw.struct_extract %max_v_97["q"] : !hw.struct<q: i10>
    %cond_99 = hw.struct_extract %48["cond"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_100 = hw.struct_extract %cond_99["q"] : !hw.struct<q: i1>
    %en_101 = hw.struct_extract %48["en"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_102 = hw.struct_extract %en_101["q"] : !hw.struct<q: i1>
    %49 = hw.struct_create (%q_96, %q_98, %q_100, %q_102) : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    llhd.drv %47, %49 after %0 : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %50 = llhd.sig.array_get %12[%c-2_i3] : <!hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>
    %51 = hw.array_get %adc_chn0_filter_ctl[%c-2_i3] : !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, i3
    %min_v_103 = hw.struct_extract %51["min_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_104 = hw.struct_extract %min_v_103["q"] : !hw.struct<q: i10>
    %max_v_105 = hw.struct_extract %51["max_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_106 = hw.struct_extract %max_v_105["q"] : !hw.struct<q: i10>
    %cond_107 = hw.struct_extract %51["cond"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_108 = hw.struct_extract %cond_107["q"] : !hw.struct<q: i1>
    %en_109 = hw.struct_extract %51["en"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_110 = hw.struct_extract %en_109["q"] : !hw.struct<q: i1>
    %52 = hw.struct_create (%q_104, %q_106, %q_108, %q_110) : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    llhd.drv %50, %52 after %0 : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %53 = llhd.sig.array_get %16[%c-2_i3] : <!hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>
    %54 = hw.array_get %adc_chn1_filter_ctl[%c-2_i3] : !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, i3
    %min_v_111 = hw.struct_extract %54["min_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_112 = hw.struct_extract %min_v_111["q"] : !hw.struct<q: i10>
    %max_v_113 = hw.struct_extract %54["max_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_114 = hw.struct_extract %max_v_113["q"] : !hw.struct<q: i10>
    %cond_115 = hw.struct_extract %54["cond"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_116 = hw.struct_extract %cond_115["q"] : !hw.struct<q: i1>
    %en_117 = hw.struct_extract %54["en"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_118 = hw.struct_extract %en_117["q"] : !hw.struct<q: i1>
    %55 = hw.struct_create (%q_112, %q_114, %q_116, %q_118) : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    llhd.drv %53, %55 after %0 : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %56 = llhd.sig.array_get %12[%c-1_i3] : <!hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>
    %57 = hw.array_get %adc_chn0_filter_ctl[%c-1_i3] : !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, i3
    %min_v_119 = hw.struct_extract %57["min_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_120 = hw.struct_extract %min_v_119["q"] : !hw.struct<q: i10>
    %max_v_121 = hw.struct_extract %57["max_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_122 = hw.struct_extract %max_v_121["q"] : !hw.struct<q: i10>
    %cond_123 = hw.struct_extract %57["cond"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_124 = hw.struct_extract %cond_123["q"] : !hw.struct<q: i1>
    %en_125 = hw.struct_extract %57["en"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_126 = hw.struct_extract %en_125["q"] : !hw.struct<q: i1>
    %58 = hw.struct_create (%q_120, %q_122, %q_124, %q_126) : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    llhd.drv %56, %58 after %0 : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %59 = llhd.sig.array_get %16[%c-1_i3] : <!hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>
    %60 = hw.array_get %adc_chn1_filter_ctl[%c-1_i3] : !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, i3
    %min_v_127 = hw.struct_extract %60["min_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_128 = hw.struct_extract %min_v_127["q"] : !hw.struct<q: i10>
    %max_v_129 = hw.struct_extract %60["max_v"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_130 = hw.struct_extract %max_v_129["q"] : !hw.struct<q: i10>
    %cond_131 = hw.struct_extract %60["cond"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_132 = hw.struct_extract %cond_131["q"] : !hw.struct<q: i1>
    %en_133 = hw.struct_extract %60["en"] : !hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>
    %q_134 = hw.struct_extract %en_133["q"] : !hw.struct<q: i1>
    %61 = hw.struct_create (%q_128, %q_130, %q_132, %q_134) : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    llhd.drv %59, %61 after %0 : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %62 = llhd.sig.array_get %adc_chn_val_o[%false] : <!hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>>
    %63 = llhd.sig.struct_extract %62["adc_chn_value"] : <!hw.struct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>
    %64 = llhd.sig.struct_extract %63["de"] : <!hw.struct<d: i10, de: i1>>
    llhd.drv %64, %u_adc_ctrl_fsm.chn0_val_we_o after %0 : i1
    %65 = llhd.sig.struct_extract %63["d"] : <!hw.struct<d: i10, de: i1>>
    %66 = llhd.prb %chn0_val : i10
    llhd.drv %65, %66 after %0 : i10
    %67 = llhd.sig.array_get %adc_chn_val_o[%true] : <!hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>>
    %68 = llhd.sig.struct_extract %67["adc_chn_value"] : <!hw.struct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>
    %69 = llhd.sig.struct_extract %68["de"] : <!hw.struct<d: i10, de: i1>>
    llhd.drv %69, %u_adc_ctrl_fsm.chn1_val_we_o after %0 : i1
    %70 = llhd.sig.struct_extract %68["d"] : <!hw.struct<d: i10, de: i1>>
    %71 = llhd.prb %chn1_val : i10
    llhd.drv %70, %71 after %0 : i10
    %72 = comb.icmp ne %11, %c0_i8 : i8
    %73 = comb.and %q_1, %72 : i1
    %74 = comb.mux %q_2, %10, %73 {sv.namehint = "chn_val_intr_we"} : i1
    %75 = llhd.sig.struct_extract %62["adc_chn_value_intr"] : <!hw.struct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>
    %76 = llhd.sig.struct_extract %75["de"] : <!hw.struct<d: i10, de: i1>>
    llhd.drv %76, %74 after %0 : i1
    %77 = llhd.sig.struct_extract %75["d"] : <!hw.struct<d: i10, de: i1>>
    llhd.drv %77, %66 after %0 : i10
    %78 = llhd.sig.struct_extract %67["adc_chn_value_intr"] : <!hw.struct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>
    %79 = llhd.sig.struct_extract %78["de"] : <!hw.struct<d: i10, de: i1>>
    llhd.drv %79, %74 after %0 : i1
    %80 = llhd.sig.struct_extract %78["d"] : <!hw.struct<d: i10, de: i1>>
    llhd.drv %80, %71 after %0 : i10
    %81 = llhd.sig.struct_extract %62["adc_chn_value_ext"] : <!hw.struct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>
    %82 = llhd.sig.struct_extract %81["de"] : <!hw.struct<d: i2, de: i1>>
    llhd.drv %82, %false after %0 : i1
    %83 = llhd.sig.struct_extract %81["d"] : <!hw.struct<d: i2, de: i1>>
    llhd.drv %83, %c0_i2 after %0 : i2
    %84 = llhd.sig.struct_extract %67["adc_chn_value_ext"] : <!hw.struct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>
    %85 = llhd.sig.struct_extract %84["de"] : <!hw.struct<d: i2, de: i1>>
    llhd.drv %85, %false after %0 : i1
    %86 = llhd.sig.struct_extract %84["d"] : <!hw.struct<d: i2, de: i1>>
    llhd.drv %86, %c0_i2 after %0 : i2
    %87 = llhd.sig.struct_extract %62["adc_chn_value_intr_ext"] : <!hw.struct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>
    %88 = llhd.sig.struct_extract %87["de"] : <!hw.struct<d: i2, de: i1>>
    llhd.drv %88, %false after %0 : i1
    %89 = llhd.sig.struct_extract %87["d"] : <!hw.struct<d: i2, de: i1>>
    llhd.drv %89, %c0_i2 after %0 : i2
    %90 = llhd.sig.struct_extract %67["adc_chn_value_intr_ext"] : <!hw.struct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>
    %91 = llhd.sig.struct_extract %90["de"] : <!hw.struct<d: i2, de: i1>>
    llhd.drv %91, %false after %0 : i1
    %92 = llhd.sig.struct_extract %90["d"] : <!hw.struct<d: i2, de: i1>>
    llhd.drv %92, %c0_i2 after %0 : i2
    %93 = llhd.sig.extract %chn0_match from %c0_i3 : <i8> -> <i1>
    %94 = llhd.prb %aon_filter_ctl : !hw.array<2xarray<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>
    %95 = hw.array_get %94[%false] : !hw.array<2xarray<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>, i1
    %96 = hw.array_get %95[%c0_i3] : !hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>, i3
    %cond_135 = hw.struct_extract %96["cond"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %97 = comb.xor %cond_135, %true : i1
    %min_v_136 = hw.struct_extract %96["min_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %98 = comb.icmp ule %min_v_136, %66 : i10
    %max_v_137 = hw.struct_extract %96["max_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %99 = comb.icmp ule %66, %max_v_137 : i10
    %100 = comb.and %98, %99 : i1
    %101 = comb.icmp ugt %min_v_136, %66 : i10
    %102 = comb.icmp ugt %66, %max_v_137 : i10
    %103 = comb.or %101, %102 : i1
    %104 = comb.mux %97, %100, %103 : i1
    llhd.drv %93, %104 after %0 : i1
    %105 = llhd.sig.extract %chn1_match from %c0_i3 : <i8> -> <i1>
    %106 = hw.array_get %94[%true] : !hw.array<2xarray<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>>, i1
    %107 = hw.array_get %106[%c0_i3] : !hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>, i3
    %cond_138 = hw.struct_extract %107["cond"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %108 = comb.xor %cond_138, %true : i1
    %min_v_139 = hw.struct_extract %107["min_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %109 = comb.icmp ule %min_v_139, %71 : i10
    %max_v_140 = hw.struct_extract %107["max_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %110 = comb.icmp ule %71, %max_v_140 : i10
    %111 = comb.and %109, %110 : i1
    %112 = comb.icmp ugt %min_v_139, %71 : i10
    %113 = comb.icmp ugt %71, %max_v_140 : i10
    %114 = comb.or %112, %113 : i1
    %115 = comb.mux %108, %111, %114 : i1
    llhd.drv %105, %115 after %0 : i1
    %116 = llhd.sig.extract %match from %c0_i3 : <i8> -> <i1>
    %en_141 = hw.struct_extract %96["en"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %en_142 = hw.struct_extract %107["en"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %117 = comb.concat %en_141, %en_142 : i1, i1
    %118 = comb.icmp ne %117, %c0_i2 : i2
    %119 = comb.xor %en_141, %true : i1
    %120 = llhd.prb %chn0_match : i8
    %121 = comb.extract %120 from 0 : (i8) -> i1
    %122 = comb.and %121, %en_141 : i1
    %123 = comb.or %119, %122 : i1
    %124 = comb.xor %en_142, %true : i1
    %125 = llhd.prb %chn1_match : i8
    %126 = comb.extract %125 from 0 : (i8) -> i1
    %127 = comb.and %126, %en_142 : i1
    %128 = comb.or %124, %127 : i1
    %129 = comb.and %118, %123, %128 : i1
    llhd.drv %116, %129 after %0 : i1
    %130 = llhd.sig.extract %match_pulse from %c0_i3 : <i8> -> <i1>
    %131 = comb.extract %7 from 0 : (i8) -> i1
    %132 = comb.and %u_adc_ctrl_fsm.adc_ctrl_done_o, %131 : i1
    llhd.drv %130, %132 after %0 : i1
    %133 = llhd.sig.extract %chn0_match from %c1_i3 : <i8> -> <i1>
    %134 = hw.array_get %95[%c1_i3] : !hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>, i3
    %cond_143 = hw.struct_extract %134["cond"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %135 = comb.xor %cond_143, %true : i1
    %min_v_144 = hw.struct_extract %134["min_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %136 = comb.icmp ule %min_v_144, %66 : i10
    %max_v_145 = hw.struct_extract %134["max_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %137 = comb.icmp ule %66, %max_v_145 : i10
    %138 = comb.and %136, %137 : i1
    %139 = comb.icmp ugt %min_v_144, %66 : i10
    %140 = comb.icmp ugt %66, %max_v_145 : i10
    %141 = comb.or %139, %140 : i1
    %142 = comb.mux %135, %138, %141 : i1
    llhd.drv %133, %142 after %0 : i1
    %143 = llhd.sig.extract %chn1_match from %c1_i3 : <i8> -> <i1>
    %144 = hw.array_get %106[%c1_i3] : !hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>, i3
    %cond_146 = hw.struct_extract %144["cond"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %145 = comb.xor %cond_146, %true : i1
    %min_v_147 = hw.struct_extract %144["min_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %146 = comb.icmp ule %min_v_147, %71 : i10
    %max_v_148 = hw.struct_extract %144["max_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %147 = comb.icmp ule %71, %max_v_148 : i10
    %148 = comb.and %146, %147 : i1
    %149 = comb.icmp ugt %min_v_147, %71 : i10
    %150 = comb.icmp ugt %71, %max_v_148 : i10
    %151 = comb.or %149, %150 : i1
    %152 = comb.mux %145, %148, %151 : i1
    llhd.drv %143, %152 after %0 : i1
    %153 = llhd.sig.extract %match from %c1_i3 : <i8> -> <i1>
    %en_149 = hw.struct_extract %134["en"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %en_150 = hw.struct_extract %144["en"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %154 = comb.concat %en_149, %en_150 : i1, i1
    %155 = comb.icmp ne %154, %c0_i2 : i2
    %156 = comb.xor %en_149, %true : i1
    %157 = comb.extract %120 from 1 : (i8) -> i1
    %158 = comb.and %157, %en_149 : i1
    %159 = comb.or %156, %158 : i1
    %160 = comb.xor %en_150, %true : i1
    %161 = comb.extract %125 from 1 : (i8) -> i1
    %162 = comb.and %161, %en_150 : i1
    %163 = comb.or %160, %162 : i1
    %164 = comb.and %155, %159, %163 : i1
    llhd.drv %153, %164 after %0 : i1
    %165 = llhd.sig.extract %match_pulse from %c1_i3 : <i8> -> <i1>
    %166 = comb.extract %7 from 1 : (i8) -> i1
    %167 = comb.and %u_adc_ctrl_fsm.adc_ctrl_done_o, %166 : i1
    llhd.drv %165, %167 after %0 : i1
    %168 = llhd.sig.extract %chn0_match from %c2_i3 : <i8> -> <i1>
    %169 = hw.array_get %95[%c2_i3] : !hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>, i3
    %cond_151 = hw.struct_extract %169["cond"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %170 = comb.xor %cond_151, %true : i1
    %min_v_152 = hw.struct_extract %169["min_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %171 = comb.icmp ule %min_v_152, %66 : i10
    %max_v_153 = hw.struct_extract %169["max_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %172 = comb.icmp ule %66, %max_v_153 : i10
    %173 = comb.and %171, %172 : i1
    %174 = comb.icmp ugt %min_v_152, %66 : i10
    %175 = comb.icmp ugt %66, %max_v_153 : i10
    %176 = comb.or %174, %175 : i1
    %177 = comb.mux %170, %173, %176 : i1
    llhd.drv %168, %177 after %0 : i1
    %178 = llhd.sig.extract %chn1_match from %c2_i3 : <i8> -> <i1>
    %179 = hw.array_get %106[%c2_i3] : !hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>, i3
    %cond_154 = hw.struct_extract %179["cond"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %180 = comb.xor %cond_154, %true : i1
    %min_v_155 = hw.struct_extract %179["min_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %181 = comb.icmp ule %min_v_155, %71 : i10
    %max_v_156 = hw.struct_extract %179["max_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %182 = comb.icmp ule %71, %max_v_156 : i10
    %183 = comb.and %181, %182 : i1
    %184 = comb.icmp ugt %min_v_155, %71 : i10
    %185 = comb.icmp ugt %71, %max_v_156 : i10
    %186 = comb.or %184, %185 : i1
    %187 = comb.mux %180, %183, %186 : i1
    llhd.drv %178, %187 after %0 : i1
    %188 = llhd.sig.extract %match from %c2_i3 : <i8> -> <i1>
    %en_157 = hw.struct_extract %169["en"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %en_158 = hw.struct_extract %179["en"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %189 = comb.concat %en_157, %en_158 : i1, i1
    %190 = comb.icmp ne %189, %c0_i2 : i2
    %191 = comb.xor %en_157, %true : i1
    %192 = comb.extract %120 from 2 : (i8) -> i1
    %193 = comb.and %192, %en_157 : i1
    %194 = comb.or %191, %193 : i1
    %195 = comb.xor %en_158, %true : i1
    %196 = comb.extract %125 from 2 : (i8) -> i1
    %197 = comb.and %196, %en_158 : i1
    %198 = comb.or %195, %197 : i1
    %199 = comb.and %190, %194, %198 : i1
    llhd.drv %188, %199 after %0 : i1
    %200 = llhd.sig.extract %match_pulse from %c2_i3 : <i8> -> <i1>
    %201 = comb.extract %7 from 2 : (i8) -> i1
    %202 = comb.and %u_adc_ctrl_fsm.adc_ctrl_done_o, %201 : i1
    llhd.drv %200, %202 after %0 : i1
    %203 = llhd.sig.extract %chn0_match from %c3_i3 : <i8> -> <i1>
    %204 = hw.array_get %95[%c3_i3] : !hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>, i3
    %cond_159 = hw.struct_extract %204["cond"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %205 = comb.xor %cond_159, %true : i1
    %min_v_160 = hw.struct_extract %204["min_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %206 = comb.icmp ule %min_v_160, %66 : i10
    %max_v_161 = hw.struct_extract %204["max_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %207 = comb.icmp ule %66, %max_v_161 : i10
    %208 = comb.and %206, %207 : i1
    %209 = comb.icmp ugt %min_v_160, %66 : i10
    %210 = comb.icmp ugt %66, %max_v_161 : i10
    %211 = comb.or %209, %210 : i1
    %212 = comb.mux %205, %208, %211 : i1
    llhd.drv %203, %212 after %0 : i1
    %213 = llhd.sig.extract %chn1_match from %c3_i3 : <i8> -> <i1>
    %214 = hw.array_get %106[%c3_i3] : !hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>, i3
    %cond_162 = hw.struct_extract %214["cond"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %215 = comb.xor %cond_162, %true : i1
    %min_v_163 = hw.struct_extract %214["min_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %216 = comb.icmp ule %min_v_163, %71 : i10
    %max_v_164 = hw.struct_extract %214["max_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %217 = comb.icmp ule %71, %max_v_164 : i10
    %218 = comb.and %216, %217 : i1
    %219 = comb.icmp ugt %min_v_163, %71 : i10
    %220 = comb.icmp ugt %71, %max_v_164 : i10
    %221 = comb.or %219, %220 : i1
    %222 = comb.mux %215, %218, %221 : i1
    llhd.drv %213, %222 after %0 : i1
    %223 = llhd.sig.extract %match from %c3_i3 : <i8> -> <i1>
    %en_165 = hw.struct_extract %204["en"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %en_166 = hw.struct_extract %214["en"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %224 = comb.concat %en_165, %en_166 : i1, i1
    %225 = comb.icmp ne %224, %c0_i2 : i2
    %226 = comb.xor %en_165, %true : i1
    %227 = comb.extract %120 from 3 : (i8) -> i1
    %228 = comb.and %227, %en_165 : i1
    %229 = comb.or %226, %228 : i1
    %230 = comb.xor %en_166, %true : i1
    %231 = comb.extract %125 from 3 : (i8) -> i1
    %232 = comb.and %231, %en_166 : i1
    %233 = comb.or %230, %232 : i1
    %234 = comb.and %225, %229, %233 : i1
    llhd.drv %223, %234 after %0 : i1
    %235 = llhd.sig.extract %match_pulse from %c3_i3 : <i8> -> <i1>
    %236 = comb.extract %7 from 3 : (i8) -> i1
    %237 = comb.and %u_adc_ctrl_fsm.adc_ctrl_done_o, %236 : i1
    llhd.drv %235, %237 after %0 : i1
    %238 = llhd.sig.extract %chn0_match from %c-4_i3 : <i8> -> <i1>
    %239 = hw.array_get %95[%c-4_i3] : !hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>, i3
    %cond_167 = hw.struct_extract %239["cond"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %240 = comb.xor %cond_167, %true : i1
    %min_v_168 = hw.struct_extract %239["min_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %241 = comb.icmp ule %min_v_168, %66 : i10
    %max_v_169 = hw.struct_extract %239["max_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %242 = comb.icmp ule %66, %max_v_169 : i10
    %243 = comb.and %241, %242 : i1
    %244 = comb.icmp ugt %min_v_168, %66 : i10
    %245 = comb.icmp ugt %66, %max_v_169 : i10
    %246 = comb.or %244, %245 : i1
    %247 = comb.mux %240, %243, %246 : i1
    llhd.drv %238, %247 after %0 : i1
    %248 = llhd.sig.extract %chn1_match from %c-4_i3 : <i8> -> <i1>
    %249 = hw.array_get %106[%c-4_i3] : !hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>, i3
    %cond_170 = hw.struct_extract %249["cond"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %250 = comb.xor %cond_170, %true : i1
    %min_v_171 = hw.struct_extract %249["min_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %251 = comb.icmp ule %min_v_171, %71 : i10
    %max_v_172 = hw.struct_extract %249["max_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %252 = comb.icmp ule %71, %max_v_172 : i10
    %253 = comb.and %251, %252 : i1
    %254 = comb.icmp ugt %min_v_171, %71 : i10
    %255 = comb.icmp ugt %71, %max_v_172 : i10
    %256 = comb.or %254, %255 : i1
    %257 = comb.mux %250, %253, %256 : i1
    llhd.drv %248, %257 after %0 : i1
    %258 = llhd.sig.extract %match from %c-4_i3 : <i8> -> <i1>
    %en_173 = hw.struct_extract %239["en"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %en_174 = hw.struct_extract %249["en"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %259 = comb.concat %en_173, %en_174 : i1, i1
    %260 = comb.icmp ne %259, %c0_i2 : i2
    %261 = comb.xor %en_173, %true : i1
    %262 = comb.extract %120 from 4 : (i8) -> i1
    %263 = comb.and %262, %en_173 : i1
    %264 = comb.or %261, %263 : i1
    %265 = comb.xor %en_174, %true : i1
    %266 = comb.extract %125 from 4 : (i8) -> i1
    %267 = comb.and %266, %en_174 : i1
    %268 = comb.or %265, %267 : i1
    %269 = comb.and %260, %264, %268 : i1
    llhd.drv %258, %269 after %0 : i1
    %270 = llhd.sig.extract %match_pulse from %c-4_i3 : <i8> -> <i1>
    %271 = comb.extract %7 from 4 : (i8) -> i1
    %272 = comb.and %u_adc_ctrl_fsm.adc_ctrl_done_o, %271 : i1
    llhd.drv %270, %272 after %0 : i1
    %273 = llhd.sig.extract %chn0_match from %c-3_i3 : <i8> -> <i1>
    %274 = hw.array_get %95[%c-3_i3] : !hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>, i3
    %cond_175 = hw.struct_extract %274["cond"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %275 = comb.xor %cond_175, %true : i1
    %min_v_176 = hw.struct_extract %274["min_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %276 = comb.icmp ule %min_v_176, %66 : i10
    %max_v_177 = hw.struct_extract %274["max_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %277 = comb.icmp ule %66, %max_v_177 : i10
    %278 = comb.and %276, %277 : i1
    %279 = comb.icmp ugt %min_v_176, %66 : i10
    %280 = comb.icmp ugt %66, %max_v_177 : i10
    %281 = comb.or %279, %280 : i1
    %282 = comb.mux %275, %278, %281 : i1
    llhd.drv %273, %282 after %0 : i1
    %283 = llhd.sig.extract %chn1_match from %c-3_i3 : <i8> -> <i1>
    %284 = hw.array_get %106[%c-3_i3] : !hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>, i3
    %cond_178 = hw.struct_extract %284["cond"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %285 = comb.xor %cond_178, %true : i1
    %min_v_179 = hw.struct_extract %284["min_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %286 = comb.icmp ule %min_v_179, %71 : i10
    %max_v_180 = hw.struct_extract %284["max_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %287 = comb.icmp ule %71, %max_v_180 : i10
    %288 = comb.and %286, %287 : i1
    %289 = comb.icmp ugt %min_v_179, %71 : i10
    %290 = comb.icmp ugt %71, %max_v_180 : i10
    %291 = comb.or %289, %290 : i1
    %292 = comb.mux %285, %288, %291 : i1
    llhd.drv %283, %292 after %0 : i1
    %293 = llhd.sig.extract %match from %c-3_i3 : <i8> -> <i1>
    %en_181 = hw.struct_extract %274["en"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %en_182 = hw.struct_extract %284["en"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %294 = comb.concat %en_181, %en_182 : i1, i1
    %295 = comb.icmp ne %294, %c0_i2 : i2
    %296 = comb.xor %en_181, %true : i1
    %297 = comb.extract %120 from 5 : (i8) -> i1
    %298 = comb.and %297, %en_181 : i1
    %299 = comb.or %296, %298 : i1
    %300 = comb.xor %en_182, %true : i1
    %301 = comb.extract %125 from 5 : (i8) -> i1
    %302 = comb.and %301, %en_182 : i1
    %303 = comb.or %300, %302 : i1
    %304 = comb.and %295, %299, %303 : i1
    llhd.drv %293, %304 after %0 : i1
    %305 = llhd.sig.extract %match_pulse from %c-3_i3 : <i8> -> <i1>
    %306 = comb.extract %7 from 5 : (i8) -> i1
    %307 = comb.and %u_adc_ctrl_fsm.adc_ctrl_done_o, %306 : i1
    llhd.drv %305, %307 after %0 : i1
    %308 = llhd.sig.extract %chn0_match from %c-2_i3 : <i8> -> <i1>
    %309 = hw.array_get %95[%c-2_i3] : !hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>, i3
    %cond_183 = hw.struct_extract %309["cond"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %310 = comb.xor %cond_183, %true : i1
    %min_v_184 = hw.struct_extract %309["min_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %311 = comb.icmp ule %min_v_184, %66 : i10
    %max_v_185 = hw.struct_extract %309["max_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %312 = comb.icmp ule %66, %max_v_185 : i10
    %313 = comb.and %311, %312 : i1
    %314 = comb.icmp ugt %min_v_184, %66 : i10
    %315 = comb.icmp ugt %66, %max_v_185 : i10
    %316 = comb.or %314, %315 : i1
    %317 = comb.mux %310, %313, %316 : i1
    llhd.drv %308, %317 after %0 : i1
    %318 = llhd.sig.extract %chn1_match from %c-2_i3 : <i8> -> <i1>
    %319 = hw.array_get %106[%c-2_i3] : !hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>, i3
    %cond_186 = hw.struct_extract %319["cond"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %320 = comb.xor %cond_186, %true : i1
    %min_v_187 = hw.struct_extract %319["min_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %321 = comb.icmp ule %min_v_187, %71 : i10
    %max_v_188 = hw.struct_extract %319["max_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %322 = comb.icmp ule %71, %max_v_188 : i10
    %323 = comb.and %321, %322 : i1
    %324 = comb.icmp ugt %min_v_187, %71 : i10
    %325 = comb.icmp ugt %71, %max_v_188 : i10
    %326 = comb.or %324, %325 : i1
    %327 = comb.mux %320, %323, %326 : i1
    llhd.drv %318, %327 after %0 : i1
    %328 = llhd.sig.extract %match from %c-2_i3 : <i8> -> <i1>
    %en_189 = hw.struct_extract %309["en"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %en_190 = hw.struct_extract %319["en"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %329 = comb.concat %en_189, %en_190 : i1, i1
    %330 = comb.icmp ne %329, %c0_i2 : i2
    %331 = comb.xor %en_189, %true : i1
    %332 = comb.extract %120 from 6 : (i8) -> i1
    %333 = comb.and %332, %en_189 : i1
    %334 = comb.or %331, %333 : i1
    %335 = comb.xor %en_190, %true : i1
    %336 = comb.extract %125 from 6 : (i8) -> i1
    %337 = comb.and %336, %en_190 : i1
    %338 = comb.or %335, %337 : i1
    %339 = comb.and %330, %334, %338 : i1
    llhd.drv %328, %339 after %0 : i1
    %340 = llhd.sig.extract %match_pulse from %c-2_i3 : <i8> -> <i1>
    %341 = comb.extract %7 from 6 : (i8) -> i1
    %342 = comb.and %u_adc_ctrl_fsm.adc_ctrl_done_o, %341 : i1
    llhd.drv %340, %342 after %0 : i1
    %343 = llhd.sig.extract %chn0_match from %c-1_i3 : <i8> -> <i1>
    %344 = hw.array_get %95[%c-1_i3] : !hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>, i3
    %cond_191 = hw.struct_extract %344["cond"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %345 = comb.xor %cond_191, %true : i1
    %min_v_192 = hw.struct_extract %344["min_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %346 = comb.icmp ule %min_v_192, %66 : i10
    %max_v_193 = hw.struct_extract %344["max_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %347 = comb.icmp ule %66, %max_v_193 : i10
    %348 = comb.and %346, %347 : i1
    %349 = comb.icmp ugt %min_v_192, %66 : i10
    %350 = comb.icmp ugt %66, %max_v_193 : i10
    %351 = comb.or %349, %350 : i1
    %352 = comb.mux %345, %348, %351 : i1
    llhd.drv %343, %352 after %0 : i1
    %353 = llhd.sig.extract %chn1_match from %c-1_i3 : <i8> -> <i1>
    %354 = hw.array_get %106[%c-1_i3] : !hw.array<8xstruct<min_v: i10, max_v: i10, cond: i1, en: i1>>, i3
    %cond_194 = hw.struct_extract %354["cond"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %355 = comb.xor %cond_194, %true : i1
    %min_v_195 = hw.struct_extract %354["min_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %356 = comb.icmp ule %min_v_195, %71 : i10
    %max_v_196 = hw.struct_extract %354["max_v"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %357 = comb.icmp ule %71, %max_v_196 : i10
    %358 = comb.and %356, %357 : i1
    %359 = comb.icmp ugt %min_v_195, %71 : i10
    %360 = comb.icmp ugt %71, %max_v_196 : i10
    %361 = comb.or %359, %360 : i1
    %362 = comb.mux %355, %358, %361 : i1
    llhd.drv %353, %362 after %0 : i1
    %363 = llhd.sig.extract %match from %c-1_i3 : <i8> -> <i1>
    %en_197 = hw.struct_extract %344["en"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %en_198 = hw.struct_extract %354["en"] : !hw.struct<min_v: i10, max_v: i10, cond: i1, en: i1>
    %364 = comb.concat %en_197, %en_198 : i1, i1
    %365 = comb.icmp ne %364, %c0_i2 : i2
    %366 = comb.xor %en_197, %true : i1
    %367 = comb.extract %120 from 7 : (i8) -> i1
    %368 = comb.and %367, %en_197 : i1
    %369 = comb.or %366, %368 : i1
    %370 = comb.xor %en_198, %true : i1
    %371 = comb.extract %125 from 7 : (i8) -> i1
    %372 = comb.and %371, %en_198 : i1
    %373 = comb.or %370, %372 : i1
    %374 = comb.and %365, %369, %373 : i1
    llhd.drv %363, %374 after %0 : i1
    %375 = llhd.sig.extract %match_pulse from %c-1_i3 : <i8> -> <i1>
    %376 = comb.extract %7 from 7 : (i8) -> i1
    %377 = comb.and %u_adc_ctrl_fsm.adc_ctrl_done_o, %376 : i1
    llhd.drv %375, %377 after %0 : i1
    %378 = llhd.sig.struct_extract %aon_filter_status_o["match"] : <!hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>>
    %379 = llhd.sig.struct_extract %378["d"] : <!hw.struct<d: i8, de: i1>>
    %filter_status = hw.struct_extract %6["filter_status"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %match_199 = hw.struct_extract %filter_status["match"] : !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>
    %q_200 = hw.struct_extract %match_199["q"] : !hw.struct<q: i8>
    %380 = comb.or %11, %q_200 : i8
    llhd.drv %379, %380 after %0 : i8
    %381 = llhd.sig.struct_extract %378["de"] : <!hw.struct<d: i8, de: i1>>
    llhd.drv %381, %72 after %0 : i1
    %382 = llhd.sig.struct_extract %aon_filter_status_o["trans"] : <!hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>>
    %383 = llhd.sig.struct_extract %382["d"] : <!hw.struct<d: i1, de: i1>>
    %trans = hw.struct_extract %filter_status["trans"] : !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>
    %q_201 = hw.struct_extract %trans["q"] : !hw.struct<q: i1>
    %384 = comb.or %u_adc_ctrl_fsm.aon_fsm_trans_o, %q_201 : i1
    llhd.drv %383, %384 after %0 : i1
    %385 = llhd.sig.struct_extract %382["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %385, %u_adc_ctrl_fsm.aon_fsm_trans_o after %0 : i1
    %adc_wakeup_ctl = hw.struct_extract %6["adc_wakeup_ctl"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %match_en_202 = hw.struct_extract %adc_wakeup_ctl["match_en"] : !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>
    %q_203 = hw.struct_extract %match_en_202["q"] : !hw.struct<q: i8>
    %386 = comb.and %q_200, %q_203 : i8
    %387 = comb.icmp ne %386, %c0_i8 : i8
    %trans_en_204 = hw.struct_extract %adc_wakeup_ctl["trans_en"] : !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>
    %q_205 = hw.struct_extract %trans_en_204["q"] : !hw.struct<q: i1>
    %388 = comb.and %q_201, %q_205 : i1
    %389 = comb.or %387, %388 : i1
    llhd.drv %reg2hw_i_0, %reg2hw_i after %0 : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %390 = llhd.prb %adc_chn_val_o : !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>
    %391 = llhd.prb %aon_filter_status_o : !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>
    %392 = llhd.prb %adc_o : !hw.struct<channel_sel: i2, pd: i1>
    hw.output %u_adc_ctrl_intr.intr_state_o, %390, %u_adc_ctrl_intr.adc_intr_status_o, %391, %389, %u_adc_ctrl_intr.intr_o, %392, %u_adc_ctrl_fsm.aon_fsm_state_o : !hw.struct<d: i1, de: i1>, !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>, !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, i1, i1, !hw.struct<channel_sel: i2, pd: i1>, i5
  }
  hw.module private @adc_ctrl_fsm(in %clk_aon_i : i1, in %rst_aon_ni : i1, in %cfg_fsm_rst_i : i1, in %cfg_adc_enable_i : i1, in %cfg_oneshot_mode_i : i1, in %cfg_lp_mode_i : i1, in %cfg_pwrup_time_i : i4, in %cfg_wakeup_time_i : i24, in %cfg_lp_sample_cnt_i : i8, in %cfg_np_sample_cnt_i : i16, in %adc_ctrl_match_i : i8, in %adc_d_i : i10, in %adc_d_val_i : i1, out adc_pd_o : i1, out adc_chn_sel_o : i2, out chn0_val_we_o : i1, out chn1_val_we_o : i1, out chn0_val_o : i10, out chn1_val_o : i10, out adc_ctrl_done_o : i1, out oneshot_done_o : i1, out aon_fsm_state_o : i5, out aon_fsm_trans_o : i1) {
    %c-1_i16 = hw.constant -1 : i16
    %c-1_i8 = hw.constant -1 : i8
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %c-16_i5 = hw.constant -16 : i5
    %c15_i5 = hw.constant 15 : i5
    %c13_i5 = hw.constant 13 : i5
    %c11_i5 = hw.constant 11 : i5
    %c10_i5 = hw.constant 10 : i5
    %c9_i5 = hw.constant 9 : i5
    %c7_i5 = hw.constant 7 : i5
    %c5_i5 = hw.constant 5 : i5
    %c-2_i2 = hw.constant -2 : i2
    %c3_i5 = hw.constant 3 : i5
    %c1_i2 = hw.constant 1 : i2
    %c1_i5 = hw.constant 1 : i5
    %c0_i2 = hw.constant 0 : i2
    %c0_i5 = hw.constant 0 : i5
    %c0_i10 = hw.constant 0 : i10
    %c14_i5 = hw.constant 14 : i5
    %c8_i5 = hw.constant 8 : i5
    %c4_i5 = hw.constant 4 : i5
    %c12_i5 = hw.constant 12 : i5
    %c6_i5 = hw.constant 6 : i5
    %c2_i5 = hw.constant 2 : i5
    %c0_i24 = hw.constant 0 : i24
    %c1_i24 = hw.constant 1 : i24
    %c0_i16 = hw.constant 0 : i16
    %c1_i16 = hw.constant 1 : i16
    %c0_i8 = hw.constant 0 : i8
    %c1_i8 = hw.constant 1 : i8
    %c0_i4 = hw.constant 0 : i4
    %c1_i4 = hw.constant 1 : i4
    %true = hw.constant true
    %false = hw.constant false
    %clk_aon_i_0 = llhd.sig name "clk_aon_i" %false : i1
    %2 = llhd.prb %clk_aon_i_0 : i1
    %rst_aon_ni_1 = llhd.sig name "rst_aon_ni" %false : i1
    %3 = llhd.prb %rst_aon_ni_1 : i1
    %cfg_fsm_rst_i_2 = llhd.sig name "cfg_fsm_rst_i" %false : i1
    %cfg_adc_enable_i_3 = llhd.sig name "cfg_adc_enable_i" %false : i1
    %cfg_oneshot_mode_i_4 = llhd.sig name "cfg_oneshot_mode_i" %false : i1
    %cfg_lp_mode_i_5 = llhd.sig name "cfg_lp_mode_i" %false : i1
    %cfg_pwrup_time_i_6 = llhd.sig name "cfg_pwrup_time_i" %c0_i4 : i4
    %cfg_wakeup_time_i_7 = llhd.sig name "cfg_wakeup_time_i" %c0_i24 : i24
    %adc_ctrl_match_i_8 = llhd.sig name "adc_ctrl_match_i" %c0_i8 : i8
    %adc_d_i_9 = llhd.sig name "adc_d_i" %c0_i10 : i10
    %adc_d_val_i_10 = llhd.sig name "adc_d_val_i" %false : i1
    %adc_pd_o = llhd.sig %false : i1
    %adc_chn_sel_o = llhd.sig %c0_i2 : i2
    %chn0_val_we_o = llhd.sig %false : i1
    %chn1_val_we_o = llhd.sig %false : i1
    %chn0_val_o = llhd.sig %c0_i10 : i10
    %chn1_val_o = llhd.sig %c0_i10 : i10
    %adc_ctrl_done_o = llhd.sig %false : i1
    %oneshot_done_o = llhd.sig %false : i1
    %aon_fsm_trans_o = llhd.sig %false : i1
    %trigger_q = llhd.sig %false : i1
    %trigger_l2h = llhd.sig %false : i1
    %trigger_h2l = llhd.sig %false : i1
    %pwrup_timer_cnt_d = llhd.sig %c0_i4 : i4
    %pwrup_timer_cnt_q = llhd.sig %c0_i4 : i4
    %pwrup_timer_cnt_clr = llhd.sig %false : i1
    %pwrup_timer_cnt_en = llhd.sig %false : i1
    %chn0_val_d = llhd.sig %c0_i10 : i10
    %chn1_val_d = llhd.sig %c0_i10 : i10
    %chn0_val_we_d = llhd.sig %false : i1
    %chn1_val_we_d = llhd.sig %false : i1
    %lp_sample_cnt_d = llhd.sig %c0_i8 : i8
    %lp_sample_cnt_q = llhd.sig %c0_i8 : i8
    %lp_sample_cnt_clr = llhd.sig %false : i1
    %lp_sample_cnt_en = llhd.sig %false : i1
    %wakeup_timer_cnt_d = llhd.sig %c0_i24 : i24
    %wakeup_timer_cnt_q = llhd.sig %c0_i24 : i24
    %wakeup_timer_cnt_clr = llhd.sig %false : i1
    %wakeup_timer_cnt_en = llhd.sig %false : i1
    %adc_ctrl_match_q = llhd.sig %c0_i8 : i8
    %stay_match = llhd.sig %false : i1
    %np_sample_cnt_d = llhd.sig %c0_i16 : i16
    %np_sample_cnt_q = llhd.sig %c0_i16 : i16
    %np_sample_cnt_clr = llhd.sig %false : i1
    %np_sample_cnt_en = llhd.sig %false : i1
    %lp_sample_cnt_thresh = llhd.sig %c0_i8 : i8
    %np_sample_cnt_thresh = llhd.sig %c0_i16 : i16
    %fsm_state_q = llhd.sig %c0_i5 : i5
    %fsm_state_d = llhd.sig %c0_i5 : i5
    %ld_match = llhd.sig %false : i1
    %4 = llhd.prb %fsm_state_q : i5
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %75 = llhd.prb %clk_aon_i_0 : i1
      %76 = llhd.prb %rst_aon_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %77 = llhd.prb %clk_aon_i_0 : i1
      %78 = comb.xor bin %75, %true : i1
      %79 = comb.and bin %78, %77 : i1
      %80 = llhd.prb %rst_aon_ni_1 : i1
      %81 = comb.xor bin %80, %true : i1
      %82 = comb.and bin %76, %81 : i1
      %83 = comb.or bin %79, %82 : i1
      cf.cond_br %83, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %84 = llhd.prb %rst_aon_ni_1 : i1
      %85 = comb.xor %84, %true : i1
      cf.cond_br %85, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %trigger_q, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %86 = llhd.prb %cfg_fsm_rst_i_2 : i1
      cf.cond_br %86, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %trigger_q, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %87 = llhd.prb %cfg_adc_enable_i_3 : i1
      llhd.drv %trigger_q, %87 after %1 : i1
      cf.br ^bb1
    }
    %5 = llhd.prb %trigger_q : i1
    %6 = comb.xor %5, %true : i1
    %7 = llhd.prb %cfg_adc_enable_i_3 : i1
    %8 = comb.and %6, %7 : i1
    llhd.drv %trigger_l2h, %8 after %0 : i1
    %9 = comb.xor %7, %true : i1
    %10 = comb.and %5, %9 : i1
    llhd.drv %trigger_h2l, %10 after %0 : i1
    %11 = llhd.prb %pwrup_timer_cnt_en : i1
    %12 = llhd.prb %pwrup_timer_cnt_q : i4
    %13 = comb.add %12, %c1_i4 : i4
    %14 = comb.mux %11, %13, %12 : i4
    llhd.drv %pwrup_timer_cnt_d, %14 after %0 : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %75 = llhd.prb %clk_aon_i_0 : i1
      %76 = llhd.prb %rst_aon_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %77 = llhd.prb %clk_aon_i_0 : i1
      %78 = comb.xor bin %75, %true : i1
      %79 = comb.and bin %78, %77 : i1
      %80 = llhd.prb %rst_aon_ni_1 : i1
      %81 = comb.xor bin %80, %true : i1
      %82 = comb.and bin %76, %81 : i1
      %83 = comb.or bin %79, %82 : i1
      cf.cond_br %83, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %84 = llhd.prb %rst_aon_ni_1 : i1
      %85 = comb.xor %84, %true : i1
      cf.cond_br %85, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pwrup_timer_cnt_q, %c0_i4 after %1 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %86 = llhd.prb %pwrup_timer_cnt_clr : i1
      %87 = llhd.prb %cfg_fsm_rst_i_2 : i1
      %88 = llhd.prb %trigger_h2l : i1
      %89 = comb.or %86, %87, %88 : i1
      cf.cond_br %89, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %pwrup_timer_cnt_q, %c0_i4 after %1 : i4
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %90 = llhd.prb %pwrup_timer_cnt_d : i4
      llhd.drv %pwrup_timer_cnt_q, %90 after %1 : i4
      cf.br ^bb1
    }
    %15 = llhd.prb %lp_sample_cnt_en : i1
    %16 = llhd.prb %lp_sample_cnt_q : i8
    %17 = comb.add %16, %c1_i8 : i8
    %18 = comb.mux %15, %17, %16 : i8
    llhd.drv %lp_sample_cnt_d, %18 after %0 : i8
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %75 = llhd.prb %clk_aon_i_0 : i1
      %76 = llhd.prb %rst_aon_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %77 = llhd.prb %clk_aon_i_0 : i1
      %78 = comb.xor bin %75, %true : i1
      %79 = comb.and bin %78, %77 : i1
      %80 = llhd.prb %rst_aon_ni_1 : i1
      %81 = comb.xor bin %80, %true : i1
      %82 = comb.and bin %76, %81 : i1
      %83 = comb.or bin %79, %82 : i1
      cf.cond_br %83, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %84 = llhd.prb %rst_aon_ni_1 : i1
      %85 = comb.xor %84, %true : i1
      cf.cond_br %85, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %lp_sample_cnt_q, %c0_i8 after %1 : i8
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %86 = llhd.prb %lp_sample_cnt_clr : i1
      %87 = llhd.prb %cfg_fsm_rst_i_2 : i1
      %88 = llhd.prb %trigger_h2l : i1
      %89 = comb.or %86, %87, %88 : i1
      cf.cond_br %89, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %lp_sample_cnt_q, %c0_i8 after %1 : i8
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %90 = llhd.prb %lp_sample_cnt_d : i8
      llhd.drv %lp_sample_cnt_q, %90 after %1 : i8
      cf.br ^bb1
    }
    %19 = llhd.prb %np_sample_cnt_en : i1
    %20 = llhd.prb %np_sample_cnt_q : i16
    %21 = comb.add %20, %c1_i16 : i16
    %22 = comb.mux %19, %21, %20 : i16
    llhd.drv %np_sample_cnt_d, %22 after %0 : i16
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %75 = llhd.prb %clk_aon_i_0 : i1
      %76 = llhd.prb %rst_aon_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %77 = llhd.prb %clk_aon_i_0 : i1
      %78 = comb.xor bin %75, %true : i1
      %79 = comb.and bin %78, %77 : i1
      %80 = llhd.prb %rst_aon_ni_1 : i1
      %81 = comb.xor bin %80, %true : i1
      %82 = comb.and bin %76, %81 : i1
      %83 = comb.or bin %79, %82 : i1
      cf.cond_br %83, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %84 = llhd.prb %rst_aon_ni_1 : i1
      %85 = comb.xor %84, %true : i1
      cf.cond_br %85, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %np_sample_cnt_q, %c0_i16 after %1 : i16
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %86 = llhd.prb %np_sample_cnt_clr : i1
      %87 = llhd.prb %cfg_fsm_rst_i_2 : i1
      %88 = llhd.prb %trigger_h2l : i1
      %89 = comb.or %86, %87, %88 : i1
      cf.cond_br %89, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %np_sample_cnt_q, %c0_i16 after %1 : i16
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %90 = llhd.prb %np_sample_cnt_d : i16
      llhd.drv %np_sample_cnt_q, %90 after %1 : i16
      cf.br ^bb1
    }
    %23 = llhd.prb %wakeup_timer_cnt_en : i1
    %24 = llhd.prb %wakeup_timer_cnt_q : i24
    %25 = comb.add %24, %c1_i24 : i24
    %26 = comb.mux %23, %25, %24 : i24
    llhd.drv %wakeup_timer_cnt_d, %26 after %0 : i24
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %75 = llhd.prb %clk_aon_i_0 : i1
      %76 = llhd.prb %rst_aon_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %77 = llhd.prb %clk_aon_i_0 : i1
      %78 = comb.xor bin %75, %true : i1
      %79 = comb.and bin %78, %77 : i1
      %80 = llhd.prb %rst_aon_ni_1 : i1
      %81 = comb.xor bin %80, %true : i1
      %82 = comb.and bin %76, %81 : i1
      %83 = comb.or bin %79, %82 : i1
      cf.cond_br %83, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %84 = llhd.prb %rst_aon_ni_1 : i1
      %85 = comb.xor %84, %true : i1
      cf.cond_br %85, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %wakeup_timer_cnt_q, %c0_i24 after %1 : i24
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %86 = llhd.prb %wakeup_timer_cnt_clr : i1
      %87 = llhd.prb %cfg_fsm_rst_i_2 : i1
      %88 = llhd.prb %trigger_h2l : i1
      %89 = comb.or %86, %87, %88 : i1
      cf.cond_br %89, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %wakeup_timer_cnt_q, %c0_i24 after %1 : i24
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %90 = llhd.prb %wakeup_timer_cnt_d : i24
      llhd.drv %wakeup_timer_cnt_q, %90 after %1 : i24
      cf.br ^bb1
    }
    %27 = comb.icmp eq %4, %c2_i5 : i5
    %28 = comb.icmp eq %4, %c6_i5 : i5
    %29 = comb.icmp eq %4, %c12_i5 : i5
    %30 = comb.or %27, %28, %29 {sv.namehint = "fsm_chn0_sel"} : i1
    %31 = llhd.prb %adc_d_val_i_10 : i1
    %32 = comb.and %30, %31 : i1
    llhd.drv %chn0_val_we_d, %32 after %0 : i1
    %33 = llhd.prb %chn0_val_we_d : i1
    %34 = llhd.prb %adc_d_i_9 : i10
    %35 = llhd.prb %chn0_val_o : i10
    %36 = comb.mux %33, %34, %35 : i10
    llhd.drv %chn0_val_d, %36 after %0 : i10
    %37 = comb.icmp eq %4, %c4_i5 : i5
    %38 = comb.icmp eq %4, %c8_i5 : i5
    %39 = comb.icmp eq %4, %c14_i5 : i5
    %40 = comb.or %37, %38, %39 {sv.namehint = "fsm_chn1_sel"} : i1
    %41 = comb.and %40, %31 : i1
    llhd.drv %chn1_val_we_d, %41 after %0 : i1
    %42 = llhd.prb %chn1_val_we_d : i1
    %43 = llhd.prb %chn1_val_o : i10
    %44 = comb.mux %42, %34, %43 : i10
    llhd.drv %chn1_val_d, %44 after %0 : i10
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %75 = llhd.prb %clk_aon_i_0 : i1
      %76 = llhd.prb %rst_aon_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %77 = llhd.prb %clk_aon_i_0 : i1
      %78 = comb.xor bin %75, %true : i1
      %79 = comb.and bin %78, %77 : i1
      %80 = llhd.prb %rst_aon_ni_1 : i1
      %81 = comb.xor bin %80, %true : i1
      %82 = comb.and bin %76, %81 : i1
      %83 = comb.or bin %79, %82 : i1
      cf.cond_br %83, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %84 = llhd.prb %rst_aon_ni_1 : i1
      %85 = comb.xor %84, %true : i1
      cf.cond_br %85, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %chn0_val_we_o, %false after %1 : i1
      llhd.drv %chn1_val_we_o, %false after %1 : i1
      llhd.drv %chn0_val_o, %c0_i10 after %1 : i10
      llhd.drv %chn1_val_o, %c0_i10 after %1 : i10
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %86 = llhd.prb %cfg_fsm_rst_i_2 : i1
      cf.cond_br %86, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %chn0_val_we_o, %false after %1 : i1
      llhd.drv %chn1_val_we_o, %false after %1 : i1
      llhd.drv %chn0_val_o, %c0_i10 after %1 : i10
      llhd.drv %chn1_val_o, %c0_i10 after %1 : i10
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %87 = llhd.prb %chn0_val_we_d : i1
      llhd.drv %chn0_val_we_o, %87 after %1 : i1
      %88 = llhd.prb %chn1_val_we_d : i1
      llhd.drv %chn1_val_we_o, %88 after %1 : i1
      %89 = llhd.prb %chn0_val_d : i10
      llhd.drv %chn0_val_o, %89 after %1 : i10
      %90 = llhd.prb %chn1_val_d : i10
      llhd.drv %chn1_val_o, %90 after %1 : i10
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %75 = llhd.prb %clk_aon_i_0 : i1
      %76 = llhd.prb %rst_aon_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %77 = llhd.prb %clk_aon_i_0 : i1
      %78 = comb.xor bin %75, %true : i1
      %79 = comb.and bin %78, %77 : i1
      %80 = llhd.prb %rst_aon_ni_1 : i1
      %81 = comb.xor bin %80, %true : i1
      %82 = comb.and bin %76, %81 : i1
      %83 = comb.or bin %79, %82 : i1
      cf.cond_br %83, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %84 = llhd.prb %rst_aon_ni_1 : i1
      %85 = comb.xor %84, %true : i1
      cf.cond_br %85, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %adc_ctrl_match_q, %c0_i8 after %1 : i8
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %86 = llhd.prb %cfg_fsm_rst_i_2 : i1
      cf.cond_br %86, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %adc_ctrl_match_q, %c0_i8 after %1 : i8
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %87 = llhd.prb %ld_match : i1
      cf.cond_br %87, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %88 = llhd.prb %adc_ctrl_match_i_8 : i8
      llhd.drv %adc_ctrl_match_q, %88 after %1 : i8
      cf.br ^bb1
    }
    %45 = llhd.prb %adc_ctrl_match_i_8 : i8
    %46 = comb.icmp ne %45, %c0_i8 : i8
    %47 = llhd.prb %adc_ctrl_match_q : i8
    %48 = comb.icmp eq %45, %47 : i8
    %49 = comb.icmp eq %47, %c0_i8 : i8
    %50 = comb.or %48, %49 : i1
    %51 = comb.and %46, %50 {sv.namehint = "np_match"} : i1
    llhd.drv %stay_match, %51 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %75 = llhd.prb %clk_aon_i_0 : i1
      %76 = llhd.prb %rst_aon_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %77 = llhd.prb %clk_aon_i_0 : i1
      %78 = comb.xor bin %75, %true : i1
      %79 = comb.and bin %78, %77 : i1
      %80 = llhd.prb %rst_aon_ni_1 : i1
      %81 = comb.xor bin %80, %true : i1
      %82 = comb.and bin %76, %81 : i1
      %83 = comb.or bin %79, %82 : i1
      cf.cond_br %83, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %84 = llhd.prb %rst_aon_ni_1 : i1
      %85 = comb.xor %84, %true : i1
      cf.cond_br %85, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %fsm_state_q, %c0_i5 after %1 : i5
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %86 = llhd.prb %trigger_h2l : i1
      %87 = llhd.prb %cfg_fsm_rst_i_2 : i1
      %88 = comb.or %86, %87 : i1
      cf.cond_br %88, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %fsm_state_q, %c0_i5 after %1 : i5
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %89 = llhd.prb %fsm_state_d : i5
      llhd.drv %fsm_state_q, %89 after %1 : i5
      cf.br ^bb1
    }
    %52 = comb.add %cfg_lp_sample_cnt_i, %c-1_i8 : i8
    llhd.drv %lp_sample_cnt_thresh, %52 after %0 : i8
    %53 = comb.add %cfg_np_sample_cnt_i, %c-1_i16 : i16
    llhd.drv %np_sample_cnt_thresh, %53 after %0 : i16
    %54 = llhd.prb %fsm_state_d : i5
    %55 = llhd.prb %adc_chn_sel_o : i2
    %56 = llhd.prb %adc_pd_o : i1
    %57 = llhd.prb %pwrup_timer_cnt_clr : i1
    %58 = llhd.prb %lp_sample_cnt_clr : i1
    %59 = llhd.prb %wakeup_timer_cnt_clr : i1
    %60 = llhd.prb %np_sample_cnt_clr : i1
    %61 = llhd.prb %adc_ctrl_done_o : i1
    %62 = llhd.prb %oneshot_done_o : i1
    %63 = llhd.prb %ld_match : i1
    %64 = llhd.prb %aon_fsm_trans_o : i1
    %65 = llhd.prb %trigger_l2h : i1
    %66 = llhd.prb %cfg_pwrup_time_i_6 : i4
    %67 = llhd.prb %cfg_oneshot_mode_i_4 : i1
    %68 = llhd.prb %cfg_lp_mode_i_5 : i1
    %69 = llhd.prb %stay_match : i1
    %70 = llhd.prb %lp_sample_cnt_thresh : i8
    %71 = llhd.prb %cfg_wakeup_time_i_7 : i24
    %72 = llhd.prb %np_sample_cnt_thresh : i16
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb77
      %75 = llhd.prb %fsm_state_q : i5
      llhd.drv %fsm_state_d, %75 after %0 : i5
      llhd.drv %adc_chn_sel_o, %c0_i2 after %0 : i2
      llhd.drv %adc_pd_o, %false after %0 : i1
      llhd.drv %pwrup_timer_cnt_clr, %false after %0 : i1
      llhd.drv %pwrup_timer_cnt_en, %false after %0 : i1
      llhd.drv %lp_sample_cnt_clr, %false after %0 : i1
      llhd.drv %lp_sample_cnt_en, %false after %0 : i1
      llhd.drv %wakeup_timer_cnt_clr, %false after %0 : i1
      llhd.drv %wakeup_timer_cnt_en, %false after %0 : i1
      llhd.drv %np_sample_cnt_clr, %false after %0 : i1
      llhd.drv %np_sample_cnt_en, %false after %0 : i1
      llhd.drv %adc_ctrl_done_o, %false after %0 : i1
      llhd.drv %oneshot_done_o, %false after %0 : i1
      llhd.drv %ld_match, %false after %0 : i1
      llhd.drv %aon_fsm_trans_o, %false after %0 : i1
      %76 = llhd.prb %fsm_state_q : i5
      %77 = comb.icmp ceq %76, %c0_i5 : i5
      cf.cond_br %77, ^bb2, ^bb4
    ^bb2:  // pred: ^bb1
      llhd.drv %adc_pd_o, %true after %0 : i1
      %78 = llhd.prb %trigger_l2h : i1
      cf.cond_br %78, ^bb3, ^bb77
    ^bb3:  // pred: ^bb2
      llhd.drv %fsm_state_d, %c1_i5 after %0 : i5
      cf.br ^bb77
    ^bb4:  // pred: ^bb1
      %79 = comb.icmp ceq %76, %c1_i5 : i5
      cf.cond_br %79, ^bb5, ^bb14
    ^bb5:  // pred: ^bb4
      %80 = llhd.prb %pwrup_timer_cnt_q : i4
      %81 = llhd.prb %cfg_pwrup_time_i_6 : i4
      %82 = comb.icmp ne %80, %81 : i4
      cf.cond_br %82, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %pwrup_timer_cnt_en, %true after %0 : i1
      cf.br ^bb77
    ^bb7:  // pred: ^bb5
      %83 = llhd.prb %pwrup_timer_cnt_q : i4
      %84 = llhd.prb %cfg_pwrup_time_i_6 : i4
      %85 = comb.icmp eq %83, %84 : i4
      cf.cond_br %85, ^bb8, ^bb77
    ^bb8:  // pred: ^bb7
      llhd.drv %pwrup_timer_cnt_clr, %true after %0 : i1
      %86 = llhd.prb %cfg_oneshot_mode_i_4 : i1
      cf.cond_br %86, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      llhd.drv %fsm_state_d, %c2_i5 after %0 : i5
      cf.br ^bb77
    ^bb10:  // pred: ^bb8
      %87 = llhd.prb %cfg_lp_mode_i_5 : i1
      cf.cond_br %87, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      llhd.drv %fsm_state_d, %c6_i5 after %0 : i5
      cf.br ^bb77
    ^bb12:  // pred: ^bb10
      %88 = llhd.prb %cfg_lp_mode_i_5 : i1
      %89 = comb.xor %88, %true : i1
      cf.cond_br %89, ^bb13, ^bb77
    ^bb13:  // pred: ^bb12
      llhd.drv %fsm_state_d, %c12_i5 after %0 : i5
      cf.br ^bb77
    ^bb14:  // pred: ^bb4
      %90 = comb.icmp ceq %76, %c2_i5 : i5
      cf.cond_br %90, ^bb15, ^bb17
    ^bb15:  // pred: ^bb14
      llhd.drv %adc_chn_sel_o, %c1_i2 after %0 : i2
      %91 = llhd.prb %adc_d_val_i_10 : i1
      cf.cond_br %91, ^bb16, ^bb77
    ^bb16:  // pred: ^bb15
      llhd.drv %fsm_state_d, %c3_i5 after %0 : i5
      cf.br ^bb77
    ^bb17:  // pred: ^bb14
      %92 = comb.icmp ceq %76, %c3_i5 : i5
      cf.cond_br %92, ^bb18, ^bb20
    ^bb18:  // pred: ^bb17
      %93 = llhd.prb %adc_d_val_i_10 : i1
      %94 = comb.xor %93, %true : i1
      cf.cond_br %94, ^bb19, ^bb77
    ^bb19:  // pred: ^bb18
      llhd.drv %fsm_state_d, %c4_i5 after %0 : i5
      cf.br ^bb77
    ^bb20:  // pred: ^bb17
      %95 = comb.icmp ceq %76, %c4_i5 : i5
      cf.cond_br %95, ^bb21, ^bb23
    ^bb21:  // pred: ^bb20
      llhd.drv %adc_chn_sel_o, %c-2_i2 after %0 : i2
      %96 = llhd.prb %adc_d_val_i_10 : i1
      cf.cond_br %96, ^bb22, ^bb77
    ^bb22:  // pred: ^bb21
      llhd.drv %fsm_state_d, %c5_i5 after %0 : i5
      cf.br ^bb77
    ^bb23:  // pred: ^bb20
      %97 = comb.icmp ceq %76, %c5_i5 : i5
      cf.cond_br %97, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      llhd.drv %oneshot_done_o, %true after %0 : i1
      llhd.drv %fsm_state_d, %c0_i5 after %0 : i5
      cf.br ^bb77
    ^bb25:  // pred: ^bb23
      %98 = comb.icmp ceq %76, %c6_i5 : i5
      cf.cond_br %98, ^bb26, ^bb28
    ^bb26:  // pred: ^bb25
      llhd.drv %adc_chn_sel_o, %c1_i2 after %0 : i2
      %99 = llhd.prb %adc_d_val_i_10 : i1
      cf.cond_br %99, ^bb27, ^bb77
    ^bb27:  // pred: ^bb26
      llhd.drv %fsm_state_d, %c7_i5 after %0 : i5
      cf.br ^bb77
    ^bb28:  // pred: ^bb25
      %100 = comb.icmp ceq %76, %c7_i5 : i5
      cf.cond_br %100, ^bb29, ^bb31
    ^bb29:  // pred: ^bb28
      %101 = llhd.prb %adc_d_val_i_10 : i1
      %102 = comb.xor %101, %true : i1
      cf.cond_br %102, ^bb30, ^bb77
    ^bb30:  // pred: ^bb29
      llhd.drv %fsm_state_d, %c8_i5 after %0 : i5
      cf.br ^bb77
    ^bb31:  // pred: ^bb28
      %103 = comb.icmp ceq %76, %c8_i5 : i5
      cf.cond_br %103, ^bb32, ^bb34
    ^bb32:  // pred: ^bb31
      llhd.drv %adc_chn_sel_o, %c-2_i2 after %0 : i2
      %104 = llhd.prb %adc_d_val_i_10 : i1
      cf.cond_br %104, ^bb33, ^bb77
    ^bb33:  // pred: ^bb32
      llhd.drv %fsm_state_d, %c9_i5 after %0 : i5
      cf.br ^bb77
    ^bb34:  // pred: ^bb31
      %105 = comb.icmp ceq %76, %c9_i5 : i5
      cf.cond_br %105, ^bb35, ^bb42
    ^bb35:  // pred: ^bb34
      %106 = llhd.prb %adc_d_val_i_10 : i1
      %107 = comb.xor %106, %true : i1
      cf.cond_br %107, ^bb36, ^bb77
    ^bb36:  // pred: ^bb35
      llhd.drv %ld_match, %true after %0 : i1
      %108 = llhd.prb %stay_match : i1
      %109 = comb.xor %108, %true : i1
      cf.cond_br %109, ^bb37, ^bb38
    ^bb37:  // pred: ^bb36
      llhd.drv %fsm_state_d, %c10_i5 after %0 : i5
      llhd.drv %lp_sample_cnt_clr, %true after %0 : i1
      cf.br ^bb77
    ^bb38:  // pred: ^bb36
      %110 = llhd.prb %lp_sample_cnt_q : i8
      %111 = llhd.prb %lp_sample_cnt_thresh : i8
      %112 = comb.icmp ult %110, %111 : i8
      cf.cond_br %112, ^bb39, ^bb40
    ^bb39:  // pred: ^bb38
      llhd.drv %fsm_state_d, %c10_i5 after %0 : i5
      llhd.drv %lp_sample_cnt_en, %true after %0 : i1
      cf.br ^bb77
    ^bb40:  // pred: ^bb38
      %113 = llhd.prb %lp_sample_cnt_q : i8
      %114 = llhd.prb %lp_sample_cnt_thresh : i8
      %115 = comb.icmp eq %113, %114 : i8
      cf.cond_br %115, ^bb41, ^bb77
    ^bb41:  // pred: ^bb40
      llhd.drv %fsm_state_d, %c12_i5 after %0 : i5
      llhd.drv %lp_sample_cnt_clr, %true after %0 : i1
      llhd.drv %aon_fsm_trans_o, %true after %0 : i1
      cf.br ^bb77
    ^bb42:  // pred: ^bb34
      %116 = comb.icmp ceq %76, %c10_i5 : i5
      cf.cond_br %116, ^bb43, ^bb47
    ^bb43:  // pred: ^bb42
      llhd.drv %adc_pd_o, %true after %0 : i1
      %117 = llhd.prb %wakeup_timer_cnt_q : i24
      %118 = llhd.prb %cfg_wakeup_time_i_7 : i24
      %119 = comb.icmp ne %117, %118 : i24
      cf.cond_br %119, ^bb44, ^bb45
    ^bb44:  // pred: ^bb43
      llhd.drv %wakeup_timer_cnt_en, %true after %0 : i1
      cf.br ^bb77
    ^bb45:  // pred: ^bb43
      %120 = llhd.prb %wakeup_timer_cnt_q : i24
      %121 = llhd.prb %cfg_wakeup_time_i_7 : i24
      %122 = comb.icmp eq %120, %121 : i24
      cf.cond_br %122, ^bb46, ^bb77
    ^bb46:  // pred: ^bb45
      llhd.drv %fsm_state_d, %c11_i5 after %0 : i5
      llhd.drv %wakeup_timer_cnt_clr, %true after %0 : i1
      cf.br ^bb77
    ^bb47:  // pred: ^bb42
      %123 = comb.icmp ceq %76, %c11_i5 : i5
      cf.cond_br %123, ^bb48, ^bb52
    ^bb48:  // pred: ^bb47
      %124 = llhd.prb %pwrup_timer_cnt_q : i4
      %125 = llhd.prb %cfg_pwrup_time_i_6 : i4
      %126 = comb.icmp ne %124, %125 : i4
      cf.cond_br %126, ^bb49, ^bb50
    ^bb49:  // pred: ^bb48
      llhd.drv %pwrup_timer_cnt_en, %true after %0 : i1
      cf.br ^bb77
    ^bb50:  // pred: ^bb48
      %127 = llhd.prb %pwrup_timer_cnt_q : i4
      %128 = llhd.prb %cfg_pwrup_time_i_6 : i4
      %129 = comb.icmp eq %127, %128 : i4
      cf.cond_br %129, ^bb51, ^bb77
    ^bb51:  // pred: ^bb50
      llhd.drv %pwrup_timer_cnt_clr, %true after %0 : i1
      llhd.drv %fsm_state_d, %c6_i5 after %0 : i5
      cf.br ^bb77
    ^bb52:  // pred: ^bb47
      %130 = comb.icmp ceq %76, %c12_i5 : i5
      cf.cond_br %130, ^bb53, ^bb55
    ^bb53:  // pred: ^bb52
      llhd.drv %adc_chn_sel_o, %c1_i2 after %0 : i2
      %131 = llhd.prb %adc_d_val_i_10 : i1
      cf.cond_br %131, ^bb54, ^bb77
    ^bb54:  // pred: ^bb53
      llhd.drv %fsm_state_d, %c13_i5 after %0 : i5
      cf.br ^bb77
    ^bb55:  // pred: ^bb52
      %132 = comb.icmp ceq %76, %c13_i5 : i5
      cf.cond_br %132, ^bb56, ^bb58
    ^bb56:  // pred: ^bb55
      %133 = llhd.prb %adc_d_val_i_10 : i1
      %134 = comb.xor %133, %true : i1
      cf.cond_br %134, ^bb57, ^bb77
    ^bb57:  // pred: ^bb56
      llhd.drv %fsm_state_d, %c14_i5 after %0 : i5
      cf.br ^bb77
    ^bb58:  // pred: ^bb55
      %135 = comb.icmp ceq %76, %c14_i5 : i5
      cf.cond_br %135, ^bb59, ^bb61
    ^bb59:  // pred: ^bb58
      llhd.drv %adc_chn_sel_o, %c-2_i2 after %0 : i2
      %136 = llhd.prb %adc_d_val_i_10 : i1
      cf.cond_br %136, ^bb60, ^bb77
    ^bb60:  // pred: ^bb59
      llhd.drv %fsm_state_d, %c15_i5 after %0 : i5
      cf.br ^bb77
    ^bb61:  // pred: ^bb58
      %137 = comb.icmp ceq %76, %c15_i5 : i5
      cf.cond_br %137, ^bb62, ^bb74
    ^bb62:  // pred: ^bb61
      %138 = llhd.prb %adc_d_val_i_10 : i1
      %139 = comb.xor %138, %true : i1
      cf.cond_br %139, ^bb63, ^bb77
    ^bb63:  // pred: ^bb62
      llhd.drv %ld_match, %true after %0 : i1
      %140 = llhd.prb %stay_match : i1
      %141 = comb.xor %140, %true : i1
      cf.cond_br %141, ^bb64, ^bb68
    ^bb64:  // pred: ^bb63
      %142 = llhd.prb %cfg_lp_mode_i_5 : i1
      cf.cond_br %142, ^bb65, ^bb66
    ^bb65:  // pred: ^bb64
      llhd.drv %fsm_state_d, %c6_i5 after %0 : i5
      cf.br ^bb67
    ^bb66:  // pred: ^bb64
      llhd.drv %fsm_state_d, %c12_i5 after %0 : i5
      cf.br ^bb67
    ^bb67:  // 2 preds: ^bb65, ^bb66
      llhd.drv %np_sample_cnt_clr, %true after %0 : i1
      cf.br ^bb77
    ^bb68:  // pred: ^bb63
      %143 = llhd.prb %np_sample_cnt_q : i16
      %144 = llhd.prb %np_sample_cnt_thresh : i16
      %145 = comb.icmp ult %143, %144 : i16
      cf.cond_br %145, ^bb69, ^bb70
    ^bb69:  // pred: ^bb68
      llhd.drv %fsm_state_d, %c12_i5 after %0 : i5
      llhd.drv %np_sample_cnt_en, %true after %0 : i1
      cf.br ^bb77
    ^bb70:  // pred: ^bb68
      %146 = llhd.prb %np_sample_cnt_q : i16
      %147 = llhd.prb %np_sample_cnt_thresh : i16
      %148 = comb.icmp eq %146, %147 : i16
      cf.cond_br %148, ^bb71, ^bb72
    ^bb71:  // pred: ^bb70
      llhd.drv %fsm_state_d, %c-16_i5 after %0 : i5
      llhd.drv %np_sample_cnt_en, %true after %0 : i1
      cf.br ^bb77
    ^bb72:  // pred: ^bb70
      %149 = llhd.prb %np_sample_cnt_q : i16
      %150 = llhd.prb %np_sample_cnt_thresh : i16
      %151 = comb.icmp ugt %149, %150 : i16
      cf.cond_br %151, ^bb73, ^bb77
    ^bb73:  // pred: ^bb72
      llhd.drv %fsm_state_d, %c12_i5 after %0 : i5
      cf.br ^bb77
    ^bb74:  // pred: ^bb61
      %152 = comb.icmp ceq %76, %c-16_i5 : i5
      cf.cond_br %152, ^bb75, ^bb76
    ^bb75:  // pred: ^bb74
      llhd.drv %adc_ctrl_done_o, %true after %0 : i1
      llhd.drv %fsm_state_d, %c12_i5 after %0 : i5
      cf.br ^bb77
    ^bb76:  // pred: ^bb74
      llhd.drv %fsm_state_d, %c0_i5 after %0 : i5
      cf.br ^bb77
    ^bb77:  // 46 preds: ^bb2, ^bb3, ^bb6, ^bb7, ^bb9, ^bb11, ^bb12, ^bb13, ^bb15, ^bb16, ^bb18, ^bb19, ^bb21, ^bb22, ^bb24, ^bb26, ^bb27, ^bb29, ^bb30, ^bb32, ^bb33, ^bb35, ^bb37, ^bb39, ^bb40, ^bb41, ^bb44, ^bb45, ^bb46, ^bb49, ^bb50, ^bb51, ^bb53, ^bb54, ^bb56, ^bb57, ^bb59, ^bb60, ^bb62, ^bb67, ^bb69, ^bb71, ^bb72, ^bb73, ^bb75, ^bb76
      llhd.wait (%4, %54, %55, %56, %57, %11, %58, %15, %59, %23, %60, %19, %61, %62, %63, %64, %65, %12, %66, %67, %68, %31, %69, %16, %70, %24, %71, %20, %72 : i5, i5, i2, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i4, i4, i1, i1, i1, i1, i8, i8, i24, i24, i16, i16), ^bb1
    }
    llhd.drv %clk_aon_i_0, %clk_aon_i after %0 : i1
    llhd.drv %rst_aon_ni_1, %rst_aon_ni after %0 : i1
    llhd.drv %cfg_fsm_rst_i_2, %cfg_fsm_rst_i after %0 : i1
    llhd.drv %cfg_adc_enable_i_3, %cfg_adc_enable_i after %0 : i1
    llhd.drv %cfg_oneshot_mode_i_4, %cfg_oneshot_mode_i after %0 : i1
    llhd.drv %cfg_lp_mode_i_5, %cfg_lp_mode_i after %0 : i1
    llhd.drv %cfg_pwrup_time_i_6, %cfg_pwrup_time_i after %0 : i4
    llhd.drv %cfg_wakeup_time_i_7, %cfg_wakeup_time_i after %0 : i24
    llhd.drv %adc_ctrl_match_i_8, %adc_ctrl_match_i after %0 : i8
    llhd.drv %adc_d_i_9, %adc_d_i after %0 : i10
    llhd.drv %adc_d_val_i_10, %adc_d_val_i after %0 : i1
    %73 = llhd.prb %chn0_val_we_o : i1
    %74 = llhd.prb %chn1_val_we_o : i1
    hw.output %56, %55, %73, %74, %35, %43, %61, %62, %4, %64 : i1, i2, i1, i1, i10, i10, i1, i1, i5, i1
  }
  hw.module private @adc_ctrl_intr(in %clk_aon_i : i1, in %rst_aon_ni : i1, in %clk_i : i1, in %rst_ni : i1, in %aon_filter_match_i : i8, in %aon_fsm_trans_i : i1, in %cfg_oneshot_done_i : i1, in %cfg_intr_en_i : i8, in %cfg_intr_trans_en_i : i1, in %cfg_oneshot_done_en_i : i1, in %intr_state_i : !hw.struct<q: i1>, in %intr_enable_i : !hw.struct<q: i1>, in %intr_test_i : !hw.struct<q: i1, qe: i1>, out intr_state_o : !hw.struct<d: i1, de: i1>, in %adc_intr_status_i : !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, out adc_intr_status_o : !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, out intr_o : i1) {
    %c0_i10 = hw.constant 0 : i10
    %c0_i8 = hw.constant 0 : i8
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [[false, false], [false, false], [0 : i8, false]] : !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>
    %3 = hw.aggregate_constant [false, false] : !hw.struct<d: i1, de: i1>
    %false = hw.constant false
    %c0_i9 = hw.constant 0 : i9
    %true = hw.constant true
    %clk_aon_i_0 = llhd.sig name "clk_aon_i" %false : i1
    %4 = llhd.prb %clk_aon_i_0 : i1
    %rst_aon_ni_1 = llhd.sig name "rst_aon_ni" %false : i1
    %5 = llhd.prb %rst_aon_ni_1 : i1
    %clk_i_2 = llhd.sig name "clk_i" %false : i1
    %6 = llhd.prb %clk_i_2 : i1
    %rst_ni_3 = llhd.sig name "rst_ni" %false : i1
    %7 = llhd.prb %rst_ni_3 : i1
    %intr_state_o = llhd.sig %3 : !hw.struct<d: i1, de: i1>
    %adc_intr_status_o = llhd.sig %2 : !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>
    %aon_reqs = llhd.sig %c0_i9 : i9
    %aon_staging_reqs_q = llhd.sig %c0_i9 : i9
    %aon_ld_req = llhd.sig %false : i1
    %aon_req_hold_q = llhd.sig %c0_i9 : i9
    %aon_ack = llhd.sig %false : i1
    %dst_ack = llhd.sig %false : i1
    %dst_ack_q = llhd.sig %false : i1
    %req_hold_q = llhd.sig %c0_i9 : i9
    %8 = llhd.prb %aon_req_hold_q : i9
    %9 = comb.icmp ne %8, %c0_i9 : i9
    %10 = llhd.prb %dst_ack : i1
    %u_match_sync.src_ack_o, %u_match_sync.dst_req_o = hw.instance "u_match_sync" @prim_sync_reqack(clk_src_i: %4: i1, rst_src_ni: %5: i1, clk_dst_i: %6: i1, rst_dst_ni: %7: i1, req_chk_i: %true: i1, src_req_i: %9: i1, dst_ack_i: %10: i1) -> (src_ack_o: i1, dst_req_o: i1)
    llhd.drv %aon_ack, %u_match_sync.src_ack_o after %1 : i1
    llhd.drv %dst_ack, %u_match_sync.dst_req_o after %1 : i1
    %q = hw.struct_extract %intr_enable_i["q"] : !hw.struct<q: i1>
    %q_4 = hw.struct_extract %intr_test_i["q"] : !hw.struct<q: i1, qe: i1>
    %qe = hw.struct_extract %intr_test_i["qe"] : !hw.struct<q: i1, qe: i1>
    %q_5 = hw.struct_extract %intr_state_i["q"] : !hw.struct<q: i1>
    %11 = llhd.sig.struct_extract %intr_state_o["de"] : <!hw.struct<d: i1, de: i1>>
    %12 = llhd.sig.struct_extract %intr_state_o["d"] : <!hw.struct<d: i1, de: i1>>
    %i_adc_ctrl_intr_o.hw2reg_intr_state_de_o, %i_adc_ctrl_intr_o.hw2reg_intr_state_d_o, %i_adc_ctrl_intr_o.intr_o = hw.instance "i_adc_ctrl_intr_o" @prim_intr_hw(clk_i: %6: i1, rst_ni: %7: i1, event_intr_i: %38: i1, reg2hw_intr_enable_q_i: %q: i1, reg2hw_intr_test_q_i: %q_4: i1, reg2hw_intr_test_qe_i: %qe: i1, reg2hw_intr_state_q_i: %q_5: i1) -> (hw2reg_intr_state_de_o: i1, hw2reg_intr_state_d_o: i1, intr_o: i1)
    llhd.drv %11, %i_adc_ctrl_intr_o.hw2reg_intr_state_de_o after %1 : i1
    llhd.drv %12, %i_adc_ctrl_intr_o.hw2reg_intr_state_d_o after %1 : i1
    %13 = comb.concat %aon_fsm_trans_i, %aon_filter_match_i : i1, i8
    llhd.drv %aon_reqs, %13 after %1 : i9
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %41 = llhd.prb %clk_aon_i_0 : i1
      %42 = llhd.prb %rst_aon_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %43 = llhd.prb %clk_aon_i_0 : i1
      %44 = comb.xor bin %41, %true : i1
      %45 = comb.and bin %44, %43 : i1
      %46 = llhd.prb %rst_aon_ni_1 : i1
      %47 = comb.xor bin %46, %true : i1
      %48 = comb.and bin %42, %47 : i1
      %49 = comb.or bin %45, %48 : i1
      cf.cond_br %49, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %50 = llhd.prb %rst_aon_ni_1 : i1
      %51 = comb.xor %50, %true : i1
      cf.cond_br %51, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %aon_staging_reqs_q, %c0_i9 after %0 : i9
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %52 = llhd.prb %aon_ld_req : i1
      cf.cond_br %52, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %53 = llhd.prb %aon_reqs : i9
      llhd.drv %aon_staging_reqs_q, %53 after %0 : i9
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %54 = llhd.prb %aon_reqs : i9
      %55 = comb.icmp ne %54, %c0_i9 : i9
      cf.cond_br %55, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %56 = llhd.prb %aon_staging_reqs_q : i9
      %57 = llhd.prb %aon_reqs : i9
      %58 = comb.or %56, %57 : i9
      llhd.drv %aon_staging_reqs_q, %58 after %0 : i9
      cf.br ^bb1
    }
    %14 = comb.icmp eq %8, %c0_i9 : i9
    %15 = llhd.prb %aon_staging_reqs_q : i9
    %16 = comb.icmp ne %15, %c0_i9 : i9
    %17 = comb.and %14, %16 : i1
    llhd.drv %aon_ld_req, %17 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %41 = llhd.prb %clk_aon_i_0 : i1
      %42 = llhd.prb %rst_aon_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %43 = llhd.prb %clk_aon_i_0 : i1
      %44 = comb.xor bin %41, %true : i1
      %45 = comb.and bin %44, %43 : i1
      %46 = llhd.prb %rst_aon_ni_1 : i1
      %47 = comb.xor bin %46, %true : i1
      %48 = comb.and bin %42, %47 : i1
      %49 = comb.or bin %45, %48 : i1
      cf.cond_br %49, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %50 = llhd.prb %rst_aon_ni_1 : i1
      %51 = comb.xor %50, %true : i1
      cf.cond_br %51, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %aon_req_hold_q, %c0_i9 after %0 : i9
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %52 = llhd.prb %aon_ld_req : i1
      cf.cond_br %52, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %53 = llhd.prb %aon_staging_reqs_q : i9
      llhd.drv %aon_req_hold_q, %53 after %0 : i9
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %54 = llhd.prb %aon_ack : i1
      cf.cond_br %54, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %aon_req_hold_q, %c0_i9 after %0 : i9
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %41 = llhd.prb %clk_i_2 : i1
      %42 = llhd.prb %rst_ni_3 : i1
      llhd.wait (%6, %7 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %43 = llhd.prb %clk_i_2 : i1
      %44 = comb.xor bin %41, %true : i1
      %45 = comb.and bin %44, %43 : i1
      %46 = llhd.prb %rst_ni_3 : i1
      %47 = comb.xor bin %46, %true : i1
      %48 = comb.and bin %42, %47 : i1
      %49 = comb.or bin %45, %48 : i1
      cf.cond_br %49, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %50 = llhd.prb %rst_ni_3 : i1
      %51 = comb.xor %50, %true : i1
      cf.cond_br %51, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %req_hold_q, %c0_i9 after %0 : i9
      llhd.drv %dst_ack_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %52 = llhd.prb %dst_ack : i1
      llhd.drv %dst_ack_q, %52 after %0 : i1
      %53 = llhd.prb %dst_ack : i1
      cf.cond_br %53, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %54 = llhd.prb %aon_req_hold_q : i9
      llhd.drv %req_hold_q, %54 after %0 : i9
      cf.br ^bb1
    }
    %18 = llhd.sig.struct_extract %adc_intr_status_o["trans"] : <!hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>>
    %19 = llhd.sig.struct_extract %18["de"] : <!hw.struct<d: i1, de: i1>>
    %20 = llhd.prb %dst_ack_q : i1
    %21 = llhd.prb %req_hold_q : i9
    %22 = comb.extract %21 from 8 : (i9) -> i1
    %23 = comb.and %cfg_intr_trans_en_i, %20, %22 : i1
    llhd.drv %19, %23 after %1 : i1
    %24 = llhd.sig.struct_extract %18["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %24, %true after %1 : i1
    %25 = comb.replicate %20 : (i1) -> i8
    %26 = comb.extract %21 from 0 : (i9) -> i8
    %27 = comb.and %cfg_intr_en_i, %25, %26 {sv.namehint = "match_events"} : i8
    %28 = llhd.sig.struct_extract %adc_intr_status_o["match"] : <!hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>>
    %29 = llhd.sig.struct_extract %28["de"] : <!hw.struct<d: i8, de: i1>>
    %30 = comb.icmp ne %27, %c0_i8 : i8
    llhd.drv %29, %30 after %1 : i1
    %31 = llhd.sig.struct_extract %28["d"] : <!hw.struct<d: i8, de: i1>>
    %match = hw.struct_extract %adc_intr_status_i["match"] : !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>
    %q_6 = hw.struct_extract %match["q"] : !hw.struct<q: i8>
    %32 = comb.or %27, %q_6 : i8
    llhd.drv %31, %32 after %1 : i8
    %33 = llhd.sig.struct_extract %adc_intr_status_o["oneshot"] : <!hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>>
    %34 = llhd.sig.struct_extract %33["de"] : <!hw.struct<d: i1, de: i1>>
    %35 = comb.and %cfg_oneshot_done_i, %cfg_oneshot_done_en_i : i1
    llhd.drv %34, %35 after %1 : i1
    %36 = llhd.sig.struct_extract %33["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %36, %true after %1 : i1
    %oneshot = hw.struct_extract %adc_intr_status_i["oneshot"] : !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>
    %q_7 = hw.struct_extract %oneshot["q"] : !hw.struct<q: i1>
    %trans = hw.struct_extract %adc_intr_status_i["trans"] : !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>
    %q_8 = hw.struct_extract %trans["q"] : !hw.struct<q: i1>
    %37 = comb.concat %q_7, %q_8, %q_6 : i1, i1, i8
    %38 = comb.icmp ne %37, %c0_i10 {sv.namehint = "status_irq_value"} : i10
    llhd.drv %clk_aon_i_0, %clk_aon_i after %1 : i1
    llhd.drv %rst_aon_ni_1, %rst_aon_ni after %1 : i1
    llhd.drv %clk_i_2, %clk_i after %1 : i1
    llhd.drv %rst_ni_3, %rst_ni after %1 : i1
    %39 = llhd.prb %intr_state_o : !hw.struct<d: i1, de: i1>
    %40 = llhd.prb %adc_intr_status_o : !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>
    hw.output %39, %40, %i_adc_ctrl_intr_o.intr_o : !hw.struct<d: i1, de: i1>, !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, i1
  }
  hw.module private @adc_ctrl_reg_top(in %clk_i : i1, in %rst_ni : i1, in %clk_aon_i : i1, in %rst_aon_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out reg2hw : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>, in %hw2reg : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, adc_chn_val: !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>, filter_status: !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_fsm_state: !hw.struct<d: i5>>, out intg_err_o : i1) {
    %c0_i27 = hw.constant 0 : i27
    %c0_i23 = hw.constant 0 : i23
    %c0_i31 = hw.constant 0 : i31
    %c0_i30 = hw.constant 0 : i30
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
    %c-15_i5 = hw.constant -15 : i5
    %c15_i5 = hw.constant 15 : i5
    %c14_i5 = hw.constant 14 : i5
    %c13_i5 = hw.constant 13 : i5
    %c11_i5 = hw.constant 11 : i5
    %c10_i5 = hw.constant 10 : i5
    %c9_i5 = hw.constant 9 : i5
    %c7_i5 = hw.constant 7 : i5
    %c6_i5 = hw.constant 6 : i5
    %c5_i5 = hw.constant 5 : i5
    %c3_i5 = hw.constant 3 : i5
    %c1_i5 = hw.constant 1 : i5
    %c-8_i4 = hw.constant -8 : i4
    %c-16_i5 = hw.constant -16 : i5
    %c-1_i5 = hw.constant -1 : i5
    %c-14_i5 = hw.constant -14 : i5
    %c12_i5 = hw.constant 12 : i5
    %c2_i5 = hw.constant 2 : i5
    %c8_i5 = hw.constant 8 : i5
    %c4_i5 = hw.constant 4 : i5
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c-1_i3 = hw.constant -1 : i3
    %c-2_i3 = hw.constant -2 : i3
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [[false], [false], [false, false], [false, false], [[false], [false]], [[0 : i24], [0 : i4], [false]], [0 : i8], [0 : i16], [false], [[[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]]], [[[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]], [[false], [0 : i10], [false], [0 : i10]]], [[false], [0 : i8]], [[false], [0 : i8]], [[false], [false], [0 : i8]], [[false], [false], [0 : i8]]] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %c-1_i32 = hw.constant -1 : i32
    %c-1_i4 = hw.constant -1 : i4
    %c-4_i7 = hw.constant -4 : i7
    %c-8_i7 = hw.constant -8 : i7
    %c-12_i7 = hw.constant -12 : i7
    %c-16_i7 = hw.constant -16 : i7
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
    %c155_i16 = hw.constant 155 : i16
    %c4_i8 = hw.constant 4 : i8
    %c409712_i32 = hw.constant 409712 : i32
    %true = hw.constant true
    %c0_i10 = hw.constant 0 : i10
    %c0_i24 = hw.constant 0 : i24
    %c0_i4 = hw.constant 0 : i4
    %c0_i5 = hw.constant 0 : i5
    %c0_i9 = hw.constant 0 : i9
    %c0_i28 = hw.constant 0 : i28
    %c0_i16 = hw.constant 0 : i16
    %c0_i8 = hw.constant 0 : i8
    %c0_i32 = hw.constant 0 : i32
    %c0_i2 = hw.constant 0 : i2
    %false = hw.constant false {sv.namehint = "shadow_busy"}
    %c-7_i4 = hw.constant -7 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %reg2hw = llhd.sig %2 : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %reg_we = llhd.sig %false : i1
    %reg_addr = llhd.sig %c0_i7 : i7
    %reg_be = llhd.sig %c0_i4 : i4
    %wr_err = llhd.sig %false : i1
    %reg_rdata_next = llhd.sig %c0_i32 : i32
    %intg_err = llhd.sig %false : i1
    %reg_we_err = llhd.sig %false : i1
    %reg_we_check = llhd.sig %c0_i32 : i32
    %err_q = llhd.sig %false : i1
    %intr_state_qs = llhd.sig %false : i1
    %intr_enable_we = llhd.sig %false : i1
    %intr_enable_qs = llhd.sig %false : i1
    %intr_test_we = llhd.sig %false : i1
    %alert_test_we = llhd.sig %false : i1
    %adc_en_ctl_we = llhd.sig %false : i1
    %adc_en_ctl_qs = llhd.sig %c0_i2 : i2
    %adc_en_ctl_busy = llhd.sig %false : i1
    %adc_pd_ctl_we = llhd.sig %false : i1
    %adc_pd_ctl_qs = llhd.sig %c0_i32 : i32
    %adc_pd_ctl_busy = llhd.sig %false : i1
    %adc_lp_sample_ctl_we = llhd.sig %false : i1
    %adc_lp_sample_ctl_qs = llhd.sig %c0_i8 : i8
    %adc_lp_sample_ctl_busy = llhd.sig %false : i1
    %adc_sample_ctl_we = llhd.sig %false : i1
    %adc_sample_ctl_qs = llhd.sig %c0_i16 : i16
    %adc_sample_ctl_busy = llhd.sig %false : i1
    %adc_fsm_rst_we = llhd.sig %false : i1
    %adc_fsm_rst_qs = llhd.sig %false : i1
    %adc_fsm_rst_busy = llhd.sig %false : i1
    %adc_chn0_filter_ctl_0_we = llhd.sig %false : i1
    %adc_chn0_filter_ctl_0_qs = llhd.sig %c0_i32 : i32
    %adc_chn0_filter_ctl_0_busy = llhd.sig %false : i1
    %adc_chn0_filter_ctl_1_we = llhd.sig %false : i1
    %adc_chn0_filter_ctl_1_qs = llhd.sig %c0_i32 : i32
    %adc_chn0_filter_ctl_1_busy = llhd.sig %false : i1
    %adc_chn0_filter_ctl_2_we = llhd.sig %false : i1
    %adc_chn0_filter_ctl_2_qs = llhd.sig %c0_i32 : i32
    %adc_chn0_filter_ctl_2_busy = llhd.sig %false : i1
    %adc_chn0_filter_ctl_3_we = llhd.sig %false : i1
    %adc_chn0_filter_ctl_3_qs = llhd.sig %c0_i32 : i32
    %adc_chn0_filter_ctl_3_busy = llhd.sig %false : i1
    %adc_chn0_filter_ctl_4_we = llhd.sig %false : i1
    %adc_chn0_filter_ctl_4_qs = llhd.sig %c0_i32 : i32
    %adc_chn0_filter_ctl_4_busy = llhd.sig %false : i1
    %adc_chn0_filter_ctl_5_we = llhd.sig %false : i1
    %adc_chn0_filter_ctl_5_qs = llhd.sig %c0_i32 : i32
    %adc_chn0_filter_ctl_5_busy = llhd.sig %false : i1
    %adc_chn0_filter_ctl_6_we = llhd.sig %false : i1
    %adc_chn0_filter_ctl_6_qs = llhd.sig %c0_i32 : i32
    %adc_chn0_filter_ctl_6_busy = llhd.sig %false : i1
    %adc_chn0_filter_ctl_7_we = llhd.sig %false : i1
    %adc_chn0_filter_ctl_7_qs = llhd.sig %c0_i32 : i32
    %adc_chn0_filter_ctl_7_busy = llhd.sig %false : i1
    %adc_chn1_filter_ctl_0_we = llhd.sig %false : i1
    %adc_chn1_filter_ctl_0_qs = llhd.sig %c0_i32 : i32
    %adc_chn1_filter_ctl_0_busy = llhd.sig %false : i1
    %adc_chn1_filter_ctl_1_we = llhd.sig %false : i1
    %adc_chn1_filter_ctl_1_qs = llhd.sig %c0_i32 : i32
    %adc_chn1_filter_ctl_1_busy = llhd.sig %false : i1
    %adc_chn1_filter_ctl_2_we = llhd.sig %false : i1
    %adc_chn1_filter_ctl_2_qs = llhd.sig %c0_i32 : i32
    %adc_chn1_filter_ctl_2_busy = llhd.sig %false : i1
    %adc_chn1_filter_ctl_3_we = llhd.sig %false : i1
    %adc_chn1_filter_ctl_3_qs = llhd.sig %c0_i32 : i32
    %adc_chn1_filter_ctl_3_busy = llhd.sig %false : i1
    %adc_chn1_filter_ctl_4_we = llhd.sig %false : i1
    %adc_chn1_filter_ctl_4_qs = llhd.sig %c0_i32 : i32
    %adc_chn1_filter_ctl_4_busy = llhd.sig %false : i1
    %adc_chn1_filter_ctl_5_we = llhd.sig %false : i1
    %adc_chn1_filter_ctl_5_qs = llhd.sig %c0_i32 : i32
    %adc_chn1_filter_ctl_5_busy = llhd.sig %false : i1
    %adc_chn1_filter_ctl_6_we = llhd.sig %false : i1
    %adc_chn1_filter_ctl_6_qs = llhd.sig %c0_i32 : i32
    %adc_chn1_filter_ctl_6_busy = llhd.sig %false : i1
    %adc_chn1_filter_ctl_7_we = llhd.sig %false : i1
    %adc_chn1_filter_ctl_7_qs = llhd.sig %c0_i32 : i32
    %adc_chn1_filter_ctl_7_busy = llhd.sig %false : i1
    %adc_chn_val_0_qs = llhd.sig %c0_i28 : i28
    %adc_chn_val_0_busy = llhd.sig %false : i1
    %adc_chn_val_1_qs = llhd.sig %c0_i28 : i28
    %adc_chn_val_1_busy = llhd.sig %false : i1
    %adc_wakeup_ctl_we = llhd.sig %false : i1
    %adc_wakeup_ctl_qs = llhd.sig %c0_i9 : i9
    %adc_wakeup_ctl_busy = llhd.sig %false : i1
    %filter_status_we = llhd.sig %false : i1
    %filter_status_qs = llhd.sig %c0_i9 : i9
    %filter_status_busy = llhd.sig %false : i1
    %adc_intr_ctl_we = llhd.sig %false : i1
    %adc_intr_ctl_match_en_qs = llhd.sig %c0_i8 : i8
    %adc_intr_ctl_trans_en_qs = llhd.sig %false : i1
    %adc_intr_ctl_oneshot_en_qs = llhd.sig %false : i1
    %adc_intr_status_we = llhd.sig %false : i1
    %adc_intr_status_match_qs = llhd.sig %c0_i8 : i8
    %adc_intr_status_trans_qs = llhd.sig %false : i1
    %adc_intr_status_oneshot_qs = llhd.sig %false : i1
    %adc_fsm_state_qs = llhd.sig %c0_i5 : i5
    %adc_fsm_state_busy = llhd.sig %false : i1
    %aon_adc_en_ctl_adc_enable_qs_int = llhd.sig %false : i1
    %aon_adc_en_ctl_oneshot_mode_qs_int = llhd.sig %false : i1
    %aon_adc_en_ctl_qs = llhd.sig %c0_i2 : i2
    %aon_adc_pd_ctl_lp_mode_qs_int = llhd.sig %false : i1
    %aon_adc_pd_ctl_pwrup_time_qs_int = llhd.sig %c0_i4 : i4
    %aon_adc_pd_ctl_wakeup_time_qs_int = llhd.sig %c0_i24 : i24
    %aon_adc_pd_ctl_qs = llhd.sig %c0_i32 : i32
    %aon_adc_lp_sample_ctl_qs_int = llhd.sig %c0_i8 : i8
    %aon_adc_lp_sample_ctl_qs = llhd.sig %c0_i8 : i8
    %aon_adc_sample_ctl_qs_int = llhd.sig %c0_i16 : i16
    %aon_adc_sample_ctl_qs = llhd.sig %c0_i16 : i16
    %aon_adc_fsm_rst_qs_int = llhd.sig %false : i1
    %aon_adc_fsm_rst_qs = llhd.sig %false : i1
    %aon_adc_chn0_filter_ctl_0_min_v_0_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn0_filter_ctl_0_cond_0_qs_int = llhd.sig %false : i1
    %aon_adc_chn0_filter_ctl_0_max_v_0_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn0_filter_ctl_0_en_0_qs_int = llhd.sig %false : i1
    %aon_adc_chn0_filter_ctl_0_qs = llhd.sig %c0_i32 : i32
    %aon_adc_chn0_filter_ctl_1_min_v_1_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn0_filter_ctl_1_cond_1_qs_int = llhd.sig %false : i1
    %aon_adc_chn0_filter_ctl_1_max_v_1_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn0_filter_ctl_1_en_1_qs_int = llhd.sig %false : i1
    %aon_adc_chn0_filter_ctl_1_qs = llhd.sig %c0_i32 : i32
    %aon_adc_chn0_filter_ctl_2_min_v_2_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn0_filter_ctl_2_cond_2_qs_int = llhd.sig %false : i1
    %aon_adc_chn0_filter_ctl_2_max_v_2_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn0_filter_ctl_2_en_2_qs_int = llhd.sig %false : i1
    %aon_adc_chn0_filter_ctl_2_qs = llhd.sig %c0_i32 : i32
    %aon_adc_chn0_filter_ctl_3_min_v_3_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn0_filter_ctl_3_cond_3_qs_int = llhd.sig %false : i1
    %aon_adc_chn0_filter_ctl_3_max_v_3_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn0_filter_ctl_3_en_3_qs_int = llhd.sig %false : i1
    %aon_adc_chn0_filter_ctl_3_qs = llhd.sig %c0_i32 : i32
    %aon_adc_chn0_filter_ctl_4_min_v_4_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn0_filter_ctl_4_cond_4_qs_int = llhd.sig %false : i1
    %aon_adc_chn0_filter_ctl_4_max_v_4_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn0_filter_ctl_4_en_4_qs_int = llhd.sig %false : i1
    %aon_adc_chn0_filter_ctl_4_qs = llhd.sig %c0_i32 : i32
    %aon_adc_chn0_filter_ctl_5_min_v_5_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn0_filter_ctl_5_cond_5_qs_int = llhd.sig %false : i1
    %aon_adc_chn0_filter_ctl_5_max_v_5_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn0_filter_ctl_5_en_5_qs_int = llhd.sig %false : i1
    %aon_adc_chn0_filter_ctl_5_qs = llhd.sig %c0_i32 : i32
    %aon_adc_chn0_filter_ctl_6_min_v_6_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn0_filter_ctl_6_cond_6_qs_int = llhd.sig %false : i1
    %aon_adc_chn0_filter_ctl_6_max_v_6_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn0_filter_ctl_6_en_6_qs_int = llhd.sig %false : i1
    %aon_adc_chn0_filter_ctl_6_qs = llhd.sig %c0_i32 : i32
    %aon_adc_chn0_filter_ctl_7_min_v_7_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn0_filter_ctl_7_cond_7_qs_int = llhd.sig %false : i1
    %aon_adc_chn0_filter_ctl_7_max_v_7_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn0_filter_ctl_7_en_7_qs_int = llhd.sig %false : i1
    %aon_adc_chn0_filter_ctl_7_qs = llhd.sig %c0_i32 : i32
    %aon_adc_chn1_filter_ctl_0_min_v_0_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn1_filter_ctl_0_cond_0_qs_int = llhd.sig %false : i1
    %aon_adc_chn1_filter_ctl_0_max_v_0_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn1_filter_ctl_0_en_0_qs_int = llhd.sig %false : i1
    %aon_adc_chn1_filter_ctl_0_qs = llhd.sig %c0_i32 : i32
    %aon_adc_chn1_filter_ctl_1_min_v_1_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn1_filter_ctl_1_cond_1_qs_int = llhd.sig %false : i1
    %aon_adc_chn1_filter_ctl_1_max_v_1_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn1_filter_ctl_1_en_1_qs_int = llhd.sig %false : i1
    %aon_adc_chn1_filter_ctl_1_qs = llhd.sig %c0_i32 : i32
    %aon_adc_chn1_filter_ctl_2_min_v_2_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn1_filter_ctl_2_cond_2_qs_int = llhd.sig %false : i1
    %aon_adc_chn1_filter_ctl_2_max_v_2_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn1_filter_ctl_2_en_2_qs_int = llhd.sig %false : i1
    %aon_adc_chn1_filter_ctl_2_qs = llhd.sig %c0_i32 : i32
    %aon_adc_chn1_filter_ctl_3_min_v_3_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn1_filter_ctl_3_cond_3_qs_int = llhd.sig %false : i1
    %aon_adc_chn1_filter_ctl_3_max_v_3_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn1_filter_ctl_3_en_3_qs_int = llhd.sig %false : i1
    %aon_adc_chn1_filter_ctl_3_qs = llhd.sig %c0_i32 : i32
    %aon_adc_chn1_filter_ctl_4_min_v_4_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn1_filter_ctl_4_cond_4_qs_int = llhd.sig %false : i1
    %aon_adc_chn1_filter_ctl_4_max_v_4_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn1_filter_ctl_4_en_4_qs_int = llhd.sig %false : i1
    %aon_adc_chn1_filter_ctl_4_qs = llhd.sig %c0_i32 : i32
    %aon_adc_chn1_filter_ctl_5_min_v_5_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn1_filter_ctl_5_cond_5_qs_int = llhd.sig %false : i1
    %aon_adc_chn1_filter_ctl_5_max_v_5_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn1_filter_ctl_5_en_5_qs_int = llhd.sig %false : i1
    %aon_adc_chn1_filter_ctl_5_qs = llhd.sig %c0_i32 : i32
    %aon_adc_chn1_filter_ctl_6_min_v_6_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn1_filter_ctl_6_cond_6_qs_int = llhd.sig %false : i1
    %aon_adc_chn1_filter_ctl_6_max_v_6_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn1_filter_ctl_6_en_6_qs_int = llhd.sig %false : i1
    %aon_adc_chn1_filter_ctl_6_qs = llhd.sig %c0_i32 : i32
    %aon_adc_chn1_filter_ctl_7_min_v_7_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn1_filter_ctl_7_cond_7_qs_int = llhd.sig %false : i1
    %aon_adc_chn1_filter_ctl_7_max_v_7_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn1_filter_ctl_7_en_7_qs_int = llhd.sig %false : i1
    %aon_adc_chn1_filter_ctl_7_qs = llhd.sig %c0_i32 : i32
    %aon_adc_chn_val_0_adc_chn_value_ext_0_ds_int = llhd.sig %c0_i2 : i2
    %aon_adc_chn_val_0_adc_chn_value_ext_0_qs_int = llhd.sig %c0_i2 : i2
    %aon_adc_chn_val_0_adc_chn_value_0_ds_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn_val_0_adc_chn_value_0_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn_val_0_adc_chn_value_intr_ext_0_ds_int = llhd.sig %c0_i2 : i2
    %aon_adc_chn_val_0_adc_chn_value_intr_ext_0_qs_int = llhd.sig %c0_i2 : i2
    %aon_adc_chn_val_0_adc_chn_value_intr_0_ds_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn_val_0_adc_chn_value_intr_0_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn_val_0_ds = llhd.sig %c0_i28 : i28
    %aon_adc_chn_val_0_qs = llhd.sig %c0_i28 : i28
    %aon_adc_chn_val_1_adc_chn_value_ext_1_ds_int = llhd.sig %c0_i2 : i2
    %aon_adc_chn_val_1_adc_chn_value_ext_1_qs_int = llhd.sig %c0_i2 : i2
    %aon_adc_chn_val_1_adc_chn_value_1_ds_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn_val_1_adc_chn_value_1_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn_val_1_adc_chn_value_intr_ext_1_ds_int = llhd.sig %c0_i2 : i2
    %aon_adc_chn_val_1_adc_chn_value_intr_ext_1_qs_int = llhd.sig %c0_i2 : i2
    %aon_adc_chn_val_1_adc_chn_value_intr_1_ds_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn_val_1_adc_chn_value_intr_1_qs_int = llhd.sig %c0_i10 : i10
    %aon_adc_chn_val_1_ds = llhd.sig %c0_i28 : i28
    %aon_adc_chn_val_1_qs = llhd.sig %c0_i28 : i28
    %aon_adc_wakeup_ctl_match_en_qs_int = llhd.sig %c0_i8 : i8
    %aon_adc_wakeup_ctl_trans_en_qs_int = llhd.sig %false : i1
    %aon_adc_wakeup_ctl_qs = llhd.sig %c0_i9 : i9
    %aon_filter_status_match_ds_int = llhd.sig %c0_i8 : i8
    %aon_filter_status_match_qs_int = llhd.sig %c0_i8 : i8
    %aon_filter_status_trans_ds_int = llhd.sig %false : i1
    %aon_filter_status_trans_qs_int = llhd.sig %false : i1
    %aon_filter_status_ds = llhd.sig %c0_i9 : i9
    %aon_filter_status_qs = llhd.sig %c0_i9 : i9
    %aon_adc_fsm_state_ds_int = llhd.sig %c0_i5 : i5
    %aon_adc_fsm_state_qs_int = llhd.sig %c0_i5 : i5
    %aon_adc_fsm_state_ds = llhd.sig %c0_i5 : i5
    %aon_adc_fsm_state_qs = llhd.sig %c0_i5 : i5
    %intr_test_flds_we = llhd.sig %false : i1
    %alert_test_flds_we = llhd.sig %false : i1
    %adc_chn_val_0_flds_we = llhd.sig %c0_i4 : i4
    %adc_chn_val_1_flds_we = llhd.sig %c0_i4 : i4
    %filter_status_flds_we = llhd.sig %c0_i2 : i2
    %adc_fsm_state_flds_we = llhd.sig %false : i1
    %addr_hit = llhd.sig %c0_i32 : i32
    %reg_busy_sel = llhd.sig %false : i1
    %u_chk.err_o = hw.instance "u_chk" @tlul_cmd_intg_chk(tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1)
    llhd.drv %intg_err, %u_chk.err_o after %1 : i1
    %5 = llhd.prb %reg_we_check : i32
    %6 = llhd.prb %reg_we : i1
    %7 = comb.xor %471, %true : i1
    %8 = comb.and %6, %7 : i1
    %u_prim_reg_we_check.err_o = hw.instance "u_prim_reg_we_check" @prim_reg_we_check(clk_i: %3: i1, rst_ni: %4: i1, oh_i: %5: i32, en_i: %8: i1) -> (err_o: i1)
    llhd.drv %reg_we_err, %u_prim_reg_we_check.err_o after %1 : i1
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen(tl_i: %u_reg_if.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %u_reg_if.tl_o, %u_reg_if.intg_error_o, %u_reg_if.re_o, %u_reg_if.we_o, %u_reg_if.addr_o, %u_reg_if.wdata_o, %u_reg_if.be_o = hw.instance "u_reg_if" @tlul_adapter_reg(clk_i: %3: i1, rst_ni: %4: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %c-7_i4: i4, busy_i: %569: i1, rdata_i: %357: i32, error_i: %359: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, intg_error_o: i1, re_o: i1, we_o: i1, addr_o: i7, wdata_o: i32, be_o: i4) {sv.namehint = "reg_re"}
    llhd.drv %reg_we, %u_reg_if.we_o after %1 : i1
    llhd.drv %reg_addr, %u_reg_if.addr_o after %1 : i7
    llhd.drv %reg_be, %u_reg_if.be_o after %1 : i4
    %9 = llhd.prb %adc_en_ctl_we : i1
    %10 = comb.extract %u_reg_if.wdata_o from 0 : (i32) -> i2
    %11 = llhd.prb %aon_adc_en_ctl_qs : i2
    %u_adc_en_ctl_cdc.src_busy_o, %u_adc_en_ctl_cdc.src_qs_o, %u_adc_en_ctl_cdc.dst_we_o, %u_adc_en_ctl_cdc.dst_re_o, %u_adc_en_ctl_cdc.dst_regwen_o, %u_adc_en_ctl_cdc.dst_wd_o = hw.instance "u_adc_en_ctl_cdc" @prim_reg_cdc(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %9: i1, src_re_i: %false: i1, src_wd_i: %10: i2, dst_ds_i: %c0_i2: i2, dst_qs_i: %11: i2, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i2, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i2) {sv.namehint = "aon_adc_en_ctl_we"}
    llhd.drv %adc_en_ctl_busy, %u_adc_en_ctl_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_en_ctl_qs, %u_adc_en_ctl_cdc.src_qs_o after %1 : i2
    %12 = llhd.prb %adc_pd_ctl_we : i1
    %13 = llhd.prb %aon_adc_pd_ctl_qs : i32
    %u_adc_pd_ctl_cdc.src_busy_o, %u_adc_pd_ctl_cdc.src_qs_o, %u_adc_pd_ctl_cdc.dst_we_o, %u_adc_pd_ctl_cdc.dst_re_o, %u_adc_pd_ctl_cdc.dst_regwen_o, %u_adc_pd_ctl_cdc.dst_wd_o = hw.instance "u_adc_pd_ctl_cdc" @prim_reg_cdc_1(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %12: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %13: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_adc_pd_ctl_we"}
    llhd.drv %adc_pd_ctl_busy, %u_adc_pd_ctl_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_pd_ctl_qs, %u_adc_pd_ctl_cdc.src_qs_o after %1 : i32
    %14 = llhd.prb %adc_lp_sample_ctl_we : i1
    %15 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "adc_intr_status_match_wd"} : (i32) -> i8
    %16 = llhd.prb %aon_adc_lp_sample_ctl_qs : i8
    %u_adc_lp_sample_ctl_cdc.src_busy_o, %u_adc_lp_sample_ctl_cdc.src_qs_o, %u_adc_lp_sample_ctl_cdc.dst_we_o, %u_adc_lp_sample_ctl_cdc.dst_re_o, %u_adc_lp_sample_ctl_cdc.dst_regwen_o, %u_adc_lp_sample_ctl_cdc.dst_wd_o = hw.instance "u_adc_lp_sample_ctl_cdc" @prim_reg_cdc_2(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %14: i1, src_re_i: %false: i1, src_wd_i: %15: i8, dst_ds_i: %c0_i8: i8, dst_qs_i: %16: i8, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i8, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i8) {sv.namehint = "aon_adc_lp_sample_ctl_we"}
    llhd.drv %adc_lp_sample_ctl_busy, %u_adc_lp_sample_ctl_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_lp_sample_ctl_qs, %u_adc_lp_sample_ctl_cdc.src_qs_o after %1 : i8
    %17 = llhd.prb %adc_sample_ctl_we : i1
    %18 = comb.extract %u_reg_if.wdata_o from 0 : (i32) -> i16
    %19 = llhd.prb %aon_adc_sample_ctl_qs : i16
    %u_adc_sample_ctl_cdc.src_busy_o, %u_adc_sample_ctl_cdc.src_qs_o, %u_adc_sample_ctl_cdc.dst_we_o, %u_adc_sample_ctl_cdc.dst_re_o, %u_adc_sample_ctl_cdc.dst_regwen_o, %u_adc_sample_ctl_cdc.dst_wd_o = hw.instance "u_adc_sample_ctl_cdc" @prim_reg_cdc_3(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %17: i1, src_re_i: %false: i1, src_wd_i: %18: i16, dst_ds_i: %c0_i16: i16, dst_qs_i: %19: i16, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i16, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i16) {sv.namehint = "aon_adc_sample_ctl_we"}
    llhd.drv %adc_sample_ctl_busy, %u_adc_sample_ctl_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_sample_ctl_qs, %u_adc_sample_ctl_cdc.src_qs_o after %1 : i16
    %20 = llhd.prb %adc_fsm_rst_we : i1
    %21 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "intr_test_wd"} : (i32) -> i1
    %22 = llhd.prb %aon_adc_fsm_rst_qs : i1
    %u_adc_fsm_rst_cdc.src_busy_o, %u_adc_fsm_rst_cdc.src_qs_o, %u_adc_fsm_rst_cdc.dst_we_o, %u_adc_fsm_rst_cdc.dst_re_o, %u_adc_fsm_rst_cdc.dst_regwen_o, %u_adc_fsm_rst_cdc.dst_wd_o = hw.instance "u_adc_fsm_rst_cdc" @prim_reg_cdc_4(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %20: i1, src_re_i: %false: i1, src_wd_i: %21: i1, dst_ds_i: %false: i1, dst_qs_i: %22: i1, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i1, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i1) {sv.namehint = "aon_adc_fsm_rst_we"}
    llhd.drv %adc_fsm_rst_busy, %u_adc_fsm_rst_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_fsm_rst_qs, %u_adc_fsm_rst_cdc.src_qs_o after %1 : i1
    %23 = llhd.prb %adc_chn0_filter_ctl_0_we : i1
    %24 = llhd.prb %aon_adc_chn0_filter_ctl_0_qs : i32
    %u_adc_chn0_filter_ctl_0_cdc.src_busy_o, %u_adc_chn0_filter_ctl_0_cdc.src_qs_o, %u_adc_chn0_filter_ctl_0_cdc.dst_we_o, %u_adc_chn0_filter_ctl_0_cdc.dst_re_o, %u_adc_chn0_filter_ctl_0_cdc.dst_regwen_o, %u_adc_chn0_filter_ctl_0_cdc.dst_wd_o = hw.instance "u_adc_chn0_filter_ctl_0_cdc" @prim_reg_cdc_5(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %23: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %24: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_adc_chn0_filter_ctl_0_we"}
    llhd.drv %adc_chn0_filter_ctl_0_busy, %u_adc_chn0_filter_ctl_0_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_chn0_filter_ctl_0_qs, %u_adc_chn0_filter_ctl_0_cdc.src_qs_o after %1 : i32
    %25 = llhd.prb %adc_chn0_filter_ctl_1_we : i1
    %26 = llhd.prb %aon_adc_chn0_filter_ctl_1_qs : i32
    %u_adc_chn0_filter_ctl_1_cdc.src_busy_o, %u_adc_chn0_filter_ctl_1_cdc.src_qs_o, %u_adc_chn0_filter_ctl_1_cdc.dst_we_o, %u_adc_chn0_filter_ctl_1_cdc.dst_re_o, %u_adc_chn0_filter_ctl_1_cdc.dst_regwen_o, %u_adc_chn0_filter_ctl_1_cdc.dst_wd_o = hw.instance "u_adc_chn0_filter_ctl_1_cdc" @prim_reg_cdc_5(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %25: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %26: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_adc_chn0_filter_ctl_1_we"}
    llhd.drv %adc_chn0_filter_ctl_1_busy, %u_adc_chn0_filter_ctl_1_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_chn0_filter_ctl_1_qs, %u_adc_chn0_filter_ctl_1_cdc.src_qs_o after %1 : i32
    %27 = llhd.prb %adc_chn0_filter_ctl_2_we : i1
    %28 = llhd.prb %aon_adc_chn0_filter_ctl_2_qs : i32
    %u_adc_chn0_filter_ctl_2_cdc.src_busy_o, %u_adc_chn0_filter_ctl_2_cdc.src_qs_o, %u_adc_chn0_filter_ctl_2_cdc.dst_we_o, %u_adc_chn0_filter_ctl_2_cdc.dst_re_o, %u_adc_chn0_filter_ctl_2_cdc.dst_regwen_o, %u_adc_chn0_filter_ctl_2_cdc.dst_wd_o = hw.instance "u_adc_chn0_filter_ctl_2_cdc" @prim_reg_cdc_5(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %27: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %28: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_adc_chn0_filter_ctl_2_we"}
    llhd.drv %adc_chn0_filter_ctl_2_busy, %u_adc_chn0_filter_ctl_2_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_chn0_filter_ctl_2_qs, %u_adc_chn0_filter_ctl_2_cdc.src_qs_o after %1 : i32
    %29 = llhd.prb %adc_chn0_filter_ctl_3_we : i1
    %30 = llhd.prb %aon_adc_chn0_filter_ctl_3_qs : i32
    %u_adc_chn0_filter_ctl_3_cdc.src_busy_o, %u_adc_chn0_filter_ctl_3_cdc.src_qs_o, %u_adc_chn0_filter_ctl_3_cdc.dst_we_o, %u_adc_chn0_filter_ctl_3_cdc.dst_re_o, %u_adc_chn0_filter_ctl_3_cdc.dst_regwen_o, %u_adc_chn0_filter_ctl_3_cdc.dst_wd_o = hw.instance "u_adc_chn0_filter_ctl_3_cdc" @prim_reg_cdc_5(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %29: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %30: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_adc_chn0_filter_ctl_3_we"}
    llhd.drv %adc_chn0_filter_ctl_3_busy, %u_adc_chn0_filter_ctl_3_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_chn0_filter_ctl_3_qs, %u_adc_chn0_filter_ctl_3_cdc.src_qs_o after %1 : i32
    %31 = llhd.prb %adc_chn0_filter_ctl_4_we : i1
    %32 = llhd.prb %aon_adc_chn0_filter_ctl_4_qs : i32
    %u_adc_chn0_filter_ctl_4_cdc.src_busy_o, %u_adc_chn0_filter_ctl_4_cdc.src_qs_o, %u_adc_chn0_filter_ctl_4_cdc.dst_we_o, %u_adc_chn0_filter_ctl_4_cdc.dst_re_o, %u_adc_chn0_filter_ctl_4_cdc.dst_regwen_o, %u_adc_chn0_filter_ctl_4_cdc.dst_wd_o = hw.instance "u_adc_chn0_filter_ctl_4_cdc" @prim_reg_cdc_5(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %31: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %32: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_adc_chn0_filter_ctl_4_we"}
    llhd.drv %adc_chn0_filter_ctl_4_busy, %u_adc_chn0_filter_ctl_4_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_chn0_filter_ctl_4_qs, %u_adc_chn0_filter_ctl_4_cdc.src_qs_o after %1 : i32
    %33 = llhd.prb %adc_chn0_filter_ctl_5_we : i1
    %34 = llhd.prb %aon_adc_chn0_filter_ctl_5_qs : i32
    %u_adc_chn0_filter_ctl_5_cdc.src_busy_o, %u_adc_chn0_filter_ctl_5_cdc.src_qs_o, %u_adc_chn0_filter_ctl_5_cdc.dst_we_o, %u_adc_chn0_filter_ctl_5_cdc.dst_re_o, %u_adc_chn0_filter_ctl_5_cdc.dst_regwen_o, %u_adc_chn0_filter_ctl_5_cdc.dst_wd_o = hw.instance "u_adc_chn0_filter_ctl_5_cdc" @prim_reg_cdc_5(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %33: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %34: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_adc_chn0_filter_ctl_5_we"}
    llhd.drv %adc_chn0_filter_ctl_5_busy, %u_adc_chn0_filter_ctl_5_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_chn0_filter_ctl_5_qs, %u_adc_chn0_filter_ctl_5_cdc.src_qs_o after %1 : i32
    %35 = llhd.prb %adc_chn0_filter_ctl_6_we : i1
    %36 = llhd.prb %aon_adc_chn0_filter_ctl_6_qs : i32
    %u_adc_chn0_filter_ctl_6_cdc.src_busy_o, %u_adc_chn0_filter_ctl_6_cdc.src_qs_o, %u_adc_chn0_filter_ctl_6_cdc.dst_we_o, %u_adc_chn0_filter_ctl_6_cdc.dst_re_o, %u_adc_chn0_filter_ctl_6_cdc.dst_regwen_o, %u_adc_chn0_filter_ctl_6_cdc.dst_wd_o = hw.instance "u_adc_chn0_filter_ctl_6_cdc" @prim_reg_cdc_5(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %35: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %36: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_adc_chn0_filter_ctl_6_we"}
    llhd.drv %adc_chn0_filter_ctl_6_busy, %u_adc_chn0_filter_ctl_6_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_chn0_filter_ctl_6_qs, %u_adc_chn0_filter_ctl_6_cdc.src_qs_o after %1 : i32
    %37 = llhd.prb %adc_chn0_filter_ctl_7_we : i1
    %38 = llhd.prb %aon_adc_chn0_filter_ctl_7_qs : i32
    %u_adc_chn0_filter_ctl_7_cdc.src_busy_o, %u_adc_chn0_filter_ctl_7_cdc.src_qs_o, %u_adc_chn0_filter_ctl_7_cdc.dst_we_o, %u_adc_chn0_filter_ctl_7_cdc.dst_re_o, %u_adc_chn0_filter_ctl_7_cdc.dst_regwen_o, %u_adc_chn0_filter_ctl_7_cdc.dst_wd_o = hw.instance "u_adc_chn0_filter_ctl_7_cdc" @prim_reg_cdc_5(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %37: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %38: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_adc_chn0_filter_ctl_7_we"}
    llhd.drv %adc_chn0_filter_ctl_7_busy, %u_adc_chn0_filter_ctl_7_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_chn0_filter_ctl_7_qs, %u_adc_chn0_filter_ctl_7_cdc.src_qs_o after %1 : i32
    %39 = llhd.prb %adc_chn1_filter_ctl_0_we : i1
    %40 = llhd.prb %aon_adc_chn1_filter_ctl_0_qs : i32
    %u_adc_chn1_filter_ctl_0_cdc.src_busy_o, %u_adc_chn1_filter_ctl_0_cdc.src_qs_o, %u_adc_chn1_filter_ctl_0_cdc.dst_we_o, %u_adc_chn1_filter_ctl_0_cdc.dst_re_o, %u_adc_chn1_filter_ctl_0_cdc.dst_regwen_o, %u_adc_chn1_filter_ctl_0_cdc.dst_wd_o = hw.instance "u_adc_chn1_filter_ctl_0_cdc" @prim_reg_cdc_5(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %39: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %40: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_adc_chn1_filter_ctl_0_we"}
    llhd.drv %adc_chn1_filter_ctl_0_busy, %u_adc_chn1_filter_ctl_0_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_chn1_filter_ctl_0_qs, %u_adc_chn1_filter_ctl_0_cdc.src_qs_o after %1 : i32
    %41 = llhd.prb %adc_chn1_filter_ctl_1_we : i1
    %42 = llhd.prb %aon_adc_chn1_filter_ctl_1_qs : i32
    %u_adc_chn1_filter_ctl_1_cdc.src_busy_o, %u_adc_chn1_filter_ctl_1_cdc.src_qs_o, %u_adc_chn1_filter_ctl_1_cdc.dst_we_o, %u_adc_chn1_filter_ctl_1_cdc.dst_re_o, %u_adc_chn1_filter_ctl_1_cdc.dst_regwen_o, %u_adc_chn1_filter_ctl_1_cdc.dst_wd_o = hw.instance "u_adc_chn1_filter_ctl_1_cdc" @prim_reg_cdc_5(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %41: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %42: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_adc_chn1_filter_ctl_1_we"}
    llhd.drv %adc_chn1_filter_ctl_1_busy, %u_adc_chn1_filter_ctl_1_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_chn1_filter_ctl_1_qs, %u_adc_chn1_filter_ctl_1_cdc.src_qs_o after %1 : i32
    %43 = llhd.prb %adc_chn1_filter_ctl_2_we : i1
    %44 = llhd.prb %aon_adc_chn1_filter_ctl_2_qs : i32
    %u_adc_chn1_filter_ctl_2_cdc.src_busy_o, %u_adc_chn1_filter_ctl_2_cdc.src_qs_o, %u_adc_chn1_filter_ctl_2_cdc.dst_we_o, %u_adc_chn1_filter_ctl_2_cdc.dst_re_o, %u_adc_chn1_filter_ctl_2_cdc.dst_regwen_o, %u_adc_chn1_filter_ctl_2_cdc.dst_wd_o = hw.instance "u_adc_chn1_filter_ctl_2_cdc" @prim_reg_cdc_5(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %43: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %44: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_adc_chn1_filter_ctl_2_we"}
    llhd.drv %adc_chn1_filter_ctl_2_busy, %u_adc_chn1_filter_ctl_2_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_chn1_filter_ctl_2_qs, %u_adc_chn1_filter_ctl_2_cdc.src_qs_o after %1 : i32
    %45 = llhd.prb %adc_chn1_filter_ctl_3_we : i1
    %46 = llhd.prb %aon_adc_chn1_filter_ctl_3_qs : i32
    %u_adc_chn1_filter_ctl_3_cdc.src_busy_o, %u_adc_chn1_filter_ctl_3_cdc.src_qs_o, %u_adc_chn1_filter_ctl_3_cdc.dst_we_o, %u_adc_chn1_filter_ctl_3_cdc.dst_re_o, %u_adc_chn1_filter_ctl_3_cdc.dst_regwen_o, %u_adc_chn1_filter_ctl_3_cdc.dst_wd_o = hw.instance "u_adc_chn1_filter_ctl_3_cdc" @prim_reg_cdc_5(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %45: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %46: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_adc_chn1_filter_ctl_3_we"}
    llhd.drv %adc_chn1_filter_ctl_3_busy, %u_adc_chn1_filter_ctl_3_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_chn1_filter_ctl_3_qs, %u_adc_chn1_filter_ctl_3_cdc.src_qs_o after %1 : i32
    %47 = llhd.prb %adc_chn1_filter_ctl_4_we : i1
    %48 = llhd.prb %aon_adc_chn1_filter_ctl_4_qs : i32
    %u_adc_chn1_filter_ctl_4_cdc.src_busy_o, %u_adc_chn1_filter_ctl_4_cdc.src_qs_o, %u_adc_chn1_filter_ctl_4_cdc.dst_we_o, %u_adc_chn1_filter_ctl_4_cdc.dst_re_o, %u_adc_chn1_filter_ctl_4_cdc.dst_regwen_o, %u_adc_chn1_filter_ctl_4_cdc.dst_wd_o = hw.instance "u_adc_chn1_filter_ctl_4_cdc" @prim_reg_cdc_5(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %47: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %48: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_adc_chn1_filter_ctl_4_we"}
    llhd.drv %adc_chn1_filter_ctl_4_busy, %u_adc_chn1_filter_ctl_4_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_chn1_filter_ctl_4_qs, %u_adc_chn1_filter_ctl_4_cdc.src_qs_o after %1 : i32
    %49 = llhd.prb %adc_chn1_filter_ctl_5_we : i1
    %50 = llhd.prb %aon_adc_chn1_filter_ctl_5_qs : i32
    %u_adc_chn1_filter_ctl_5_cdc.src_busy_o, %u_adc_chn1_filter_ctl_5_cdc.src_qs_o, %u_adc_chn1_filter_ctl_5_cdc.dst_we_o, %u_adc_chn1_filter_ctl_5_cdc.dst_re_o, %u_adc_chn1_filter_ctl_5_cdc.dst_regwen_o, %u_adc_chn1_filter_ctl_5_cdc.dst_wd_o = hw.instance "u_adc_chn1_filter_ctl_5_cdc" @prim_reg_cdc_5(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %49: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %50: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_adc_chn1_filter_ctl_5_we"}
    llhd.drv %adc_chn1_filter_ctl_5_busy, %u_adc_chn1_filter_ctl_5_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_chn1_filter_ctl_5_qs, %u_adc_chn1_filter_ctl_5_cdc.src_qs_o after %1 : i32
    %51 = llhd.prb %adc_chn1_filter_ctl_6_we : i1
    %52 = llhd.prb %aon_adc_chn1_filter_ctl_6_qs : i32
    %u_adc_chn1_filter_ctl_6_cdc.src_busy_o, %u_adc_chn1_filter_ctl_6_cdc.src_qs_o, %u_adc_chn1_filter_ctl_6_cdc.dst_we_o, %u_adc_chn1_filter_ctl_6_cdc.dst_re_o, %u_adc_chn1_filter_ctl_6_cdc.dst_regwen_o, %u_adc_chn1_filter_ctl_6_cdc.dst_wd_o = hw.instance "u_adc_chn1_filter_ctl_6_cdc" @prim_reg_cdc_5(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %51: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %52: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_adc_chn1_filter_ctl_6_we"}
    llhd.drv %adc_chn1_filter_ctl_6_busy, %u_adc_chn1_filter_ctl_6_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_chn1_filter_ctl_6_qs, %u_adc_chn1_filter_ctl_6_cdc.src_qs_o after %1 : i32
    %53 = llhd.prb %adc_chn1_filter_ctl_7_we : i1
    %54 = llhd.prb %aon_adc_chn1_filter_ctl_7_qs : i32
    %u_adc_chn1_filter_ctl_7_cdc.src_busy_o, %u_adc_chn1_filter_ctl_7_cdc.src_qs_o, %u_adc_chn1_filter_ctl_7_cdc.dst_we_o, %u_adc_chn1_filter_ctl_7_cdc.dst_re_o, %u_adc_chn1_filter_ctl_7_cdc.dst_regwen_o, %u_adc_chn1_filter_ctl_7_cdc.dst_wd_o = hw.instance "u_adc_chn1_filter_ctl_7_cdc" @prim_reg_cdc_5(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %53: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %54: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_adc_chn1_filter_ctl_7_we"}
    llhd.drv %adc_chn1_filter_ctl_7_busy, %u_adc_chn1_filter_ctl_7_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_chn1_filter_ctl_7_qs, %u_adc_chn1_filter_ctl_7_cdc.src_qs_o after %1 : i32
    %55 = llhd.prb %aon_adc_chn_val_0_ds : i28
    %56 = llhd.prb %aon_adc_chn_val_0_qs : i28
    %u_adc_chn_val_0_cdc.src_busy_o, %u_adc_chn_val_0_cdc.src_qs_o, %u_adc_chn_val_0_cdc.dst_we_o, %u_adc_chn_val_0_cdc.dst_re_o, %u_adc_chn_val_0_cdc.dst_regwen_o, %u_adc_chn_val_0_cdc.dst_wd_o = hw.instance "u_adc_chn_val_0_cdc" @prim_reg_cdc_6(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %false: i1, src_re_i: %false: i1, src_wd_i: %c0_i28: i28, dst_ds_i: %55: i28, dst_qs_i: %56: i28, dst_update_i: %461: i1) -> (src_busy_o: i1, src_qs_o: i28, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i28)
    llhd.drv %adc_chn_val_0_busy, %u_adc_chn_val_0_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_chn_val_0_qs, %u_adc_chn_val_0_cdc.src_qs_o after %1 : i28
    %57 = llhd.prb %aon_adc_chn_val_1_ds : i28
    %58 = llhd.prb %aon_adc_chn_val_1_qs : i28
    %u_adc_chn_val_1_cdc.src_busy_o, %u_adc_chn_val_1_cdc.src_qs_o, %u_adc_chn_val_1_cdc.dst_we_o, %u_adc_chn_val_1_cdc.dst_re_o, %u_adc_chn_val_1_cdc.dst_regwen_o, %u_adc_chn_val_1_cdc.dst_wd_o = hw.instance "u_adc_chn_val_1_cdc" @prim_reg_cdc_6(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %false: i1, src_re_i: %false: i1, src_wd_i: %c0_i28: i28, dst_ds_i: %57: i28, dst_qs_i: %58: i28, dst_update_i: %463: i1) -> (src_busy_o: i1, src_qs_o: i28, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i28)
    llhd.drv %adc_chn_val_1_busy, %u_adc_chn_val_1_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_chn_val_1_qs, %u_adc_chn_val_1_cdc.src_qs_o after %1 : i28
    %59 = llhd.prb %adc_wakeup_ctl_we : i1
    %60 = comb.extract %u_reg_if.wdata_o from 0 : (i32) -> i9
    %61 = llhd.prb %aon_adc_wakeup_ctl_qs : i9
    %u_adc_wakeup_ctl_cdc.src_busy_o, %u_adc_wakeup_ctl_cdc.src_qs_o, %u_adc_wakeup_ctl_cdc.dst_we_o, %u_adc_wakeup_ctl_cdc.dst_re_o, %u_adc_wakeup_ctl_cdc.dst_regwen_o, %u_adc_wakeup_ctl_cdc.dst_wd_o = hw.instance "u_adc_wakeup_ctl_cdc" @prim_reg_cdc_7(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %59: i1, src_re_i: %false: i1, src_wd_i: %60: i9, dst_ds_i: %c0_i9: i9, dst_qs_i: %61: i9, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i9, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i9) {sv.namehint = "aon_adc_wakeup_ctl_we"}
    llhd.drv %adc_wakeup_ctl_busy, %u_adc_wakeup_ctl_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_wakeup_ctl_qs, %u_adc_wakeup_ctl_cdc.src_qs_o after %1 : i9
    %62 = llhd.prb %filter_status_we : i1
    %63 = llhd.prb %aon_filter_status_ds : i9
    %64 = llhd.prb %aon_filter_status_qs : i9
    %u_filter_status_cdc.src_busy_o, %u_filter_status_cdc.src_qs_o, %u_filter_status_cdc.dst_we_o, %u_filter_status_cdc.dst_re_o, %u_filter_status_cdc.dst_regwen_o, %u_filter_status_cdc.dst_wd_o = hw.instance "u_filter_status_cdc" @prim_reg_cdc_8(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %62: i1, src_re_i: %false: i1, src_wd_i: %60: i9, dst_ds_i: %63: i9, dst_qs_i: %64: i9, dst_update_i: %465: i1) -> (src_busy_o: i1, src_qs_o: i9, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i9) {sv.namehint = "aon_filter_status_we"}
    llhd.drv %filter_status_busy, %u_filter_status_cdc.src_busy_o after %1 : i1
    llhd.drv %filter_status_qs, %u_filter_status_cdc.src_qs_o after %1 : i9
    %65 = llhd.prb %aon_adc_fsm_state_ds : i5
    %66 = llhd.prb %aon_adc_fsm_state_qs : i5
    %u_adc_fsm_state_cdc.src_busy_o, %u_adc_fsm_state_cdc.src_qs_o, %u_adc_fsm_state_cdc.dst_we_o, %u_adc_fsm_state_cdc.dst_re_o, %u_adc_fsm_state_cdc.dst_regwen_o, %u_adc_fsm_state_cdc.dst_wd_o = hw.instance "u_adc_fsm_state_cdc" @prim_reg_cdc_9(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %false: i1, src_re_i: %533: i1, src_wd_i: %c0_i5: i5, dst_ds_i: %65: i5, dst_qs_i: %66: i5, dst_update_i: %466: i1) -> (src_busy_o: i1, src_qs_o: i5, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i5) {sv.namehint = "aon_adc_fsm_state_re"}
    llhd.drv %adc_fsm_state_busy, %u_adc_fsm_state_cdc.src_busy_o after %1 : i1
    llhd.drv %adc_fsm_state_qs, %u_adc_fsm_state_cdc.src_qs_o after %1 : i5
    %intr_state = hw.struct_extract %hw2reg["intr_state"] : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, adc_chn_val: !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>, filter_status: !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_fsm_state: !hw.struct<d: i5>>
    %de = hw.struct_extract %intr_state["de"] : !hw.struct<d: i1, de: i1>
    %d = hw.struct_extract %intr_state["d"] : !hw.struct<d: i1, de: i1>
    %67 = llhd.sig.struct_extract %reg2hw["intr_state"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>>
    %68 = llhd.sig.struct_extract %67["q"] : <!hw.struct<q: i1>>
    %u_intr_state.qe, %u_intr_state.q, %u_intr_state.ds, %u_intr_state.qs = hw.instance "u_intr_state" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de: i1, d: %d: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %68, %u_intr_state.q after %1 : i1
    llhd.drv %intr_state_qs, %u_intr_state.qs after %1 : i1
    %69 = llhd.prb %intr_enable_we : i1
    %70 = llhd.sig.struct_extract %reg2hw["intr_enable"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>>
    %71 = llhd.sig.struct_extract %70["q"] : <!hw.struct<q: i1>>
    %u_intr_enable.qe, %u_intr_enable.q, %u_intr_enable.ds, %u_intr_enable.qs = hw.instance "u_intr_enable" @prim_subreg_10(clk_i: %3: i1, rst_ni: %4: i1, we: %69: i1, wd: %21: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %71, %u_intr_enable.q after %1 : i1
    llhd.drv %intr_enable_qs, %u_intr_enable.qs after %1 : i1
    %72 = llhd.prb %intr_test_we : i1
    %73 = llhd.sig.struct_extract %reg2hw["intr_test"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>>
    %74 = llhd.sig.struct_extract %73["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_intr_test.qe, %u_intr_test.qre, %u_intr_test.q, %u_intr_test.ds, %u_intr_test.qs = hw.instance "u_intr_test" @prim_subreg_ext(re: %false: i1, we: %72: i1, wd: %21: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %intr_test_flds_we, %u_intr_test.qe after %1 : i1
    llhd.drv %74, %u_intr_test.q after %1 : i1
    %75 = llhd.prb %alert_test_we : i1
    %76 = llhd.sig.struct_extract %reg2hw["alert_test"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>>
    %77 = llhd.sig.struct_extract %76["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_alert_test.qe, %u_alert_test.qre, %u_alert_test.q, %u_alert_test.ds, %u_alert_test.qs = hw.instance "u_alert_test" @prim_subreg_ext(re: %false: i1, we: %75: i1, wd: %21: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %alert_test_flds_we, %u_alert_test.qe after %1 : i1
    llhd.drv %77, %u_alert_test.q after %1 : i1
    %78 = comb.extract %u_adc_en_ctl_cdc.dst_wd_o from 0 : (i2) -> i1
    %79 = llhd.sig.struct_extract %reg2hw["adc_en_ctl"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>>
    %80 = llhd.sig.struct_extract %79["adc_enable"] : <!hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>>
    %81 = llhd.sig.struct_extract %80["q"] : <!hw.struct<q: i1>>
    %u_adc_en_ctl_adc_enable.qe, %u_adc_en_ctl_adc_enable.q, %u_adc_en_ctl_adc_enable.ds, %u_adc_en_ctl_adc_enable.qs = hw.instance "u_adc_en_ctl_adc_enable" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_en_ctl_cdc.dst_we_o: i1, wd: %78: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %81, %u_adc_en_ctl_adc_enable.q after %1 : i1
    llhd.drv %aon_adc_en_ctl_adc_enable_qs_int, %u_adc_en_ctl_adc_enable.qs after %1 : i1
    %82 = comb.extract %u_adc_en_ctl_cdc.dst_wd_o from 1 : (i2) -> i1
    %83 = llhd.sig.struct_extract %79["oneshot_mode"] : <!hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>>
    %84 = llhd.sig.struct_extract %83["q"] : <!hw.struct<q: i1>>
    %u_adc_en_ctl_oneshot_mode.qe, %u_adc_en_ctl_oneshot_mode.q, %u_adc_en_ctl_oneshot_mode.ds, %u_adc_en_ctl_oneshot_mode.qs = hw.instance "u_adc_en_ctl_oneshot_mode" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_en_ctl_cdc.dst_we_o: i1, wd: %82: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %84, %u_adc_en_ctl_oneshot_mode.q after %1 : i1
    llhd.drv %aon_adc_en_ctl_oneshot_mode_qs_int, %u_adc_en_ctl_oneshot_mode.qs after %1 : i1
    %85 = comb.extract %u_adc_pd_ctl_cdc.dst_wd_o from 0 : (i32) -> i1
    %86 = llhd.sig.struct_extract %reg2hw["adc_pd_ctl"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>>
    %87 = llhd.sig.struct_extract %86["lp_mode"] : <!hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>>
    %88 = llhd.sig.struct_extract %87["q"] : <!hw.struct<q: i1>>
    %u_adc_pd_ctl_lp_mode.qe, %u_adc_pd_ctl_lp_mode.q, %u_adc_pd_ctl_lp_mode.ds, %u_adc_pd_ctl_lp_mode.qs = hw.instance "u_adc_pd_ctl_lp_mode" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_pd_ctl_cdc.dst_we_o: i1, wd: %85: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %88, %u_adc_pd_ctl_lp_mode.q after %1 : i1
    llhd.drv %aon_adc_pd_ctl_lp_mode_qs_int, %u_adc_pd_ctl_lp_mode.qs after %1 : i1
    %89 = comb.extract %u_adc_pd_ctl_cdc.dst_wd_o from 4 : (i32) -> i4
    %90 = llhd.sig.struct_extract %86["pwrup_time"] : <!hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>>
    %91 = llhd.sig.struct_extract %90["q"] : <!hw.struct<q: i4>>
    %u_adc_pd_ctl_pwrup_time.qe, %u_adc_pd_ctl_pwrup_time.q, %u_adc_pd_ctl_pwrup_time.ds, %u_adc_pd_ctl_pwrup_time.qs = hw.instance "u_adc_pd_ctl_pwrup_time" @prim_subreg_11(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_pd_ctl_cdc.dst_we_o: i1, wd: %89: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %91, %u_adc_pd_ctl_pwrup_time.q after %1 : i4
    llhd.drv %aon_adc_pd_ctl_pwrup_time_qs_int, %u_adc_pd_ctl_pwrup_time.qs after %1 : i4
    %92 = comb.extract %u_adc_pd_ctl_cdc.dst_wd_o from 8 : (i32) -> i24
    %93 = llhd.sig.struct_extract %86["wakeup_time"] : <!hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>>
    %94 = llhd.sig.struct_extract %93["q"] : <!hw.struct<q: i24>>
    %u_adc_pd_ctl_wakeup_time.qe, %u_adc_pd_ctl_wakeup_time.q, %u_adc_pd_ctl_wakeup_time.ds, %u_adc_pd_ctl_wakeup_time.qs = hw.instance "u_adc_pd_ctl_wakeup_time" @prim_subreg_12(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_pd_ctl_cdc.dst_we_o: i1, wd: %92: i24, de: %false: i1, d: %c0_i24: i24) -> (qe: i1, q: i24, ds: i24, qs: i24)
    llhd.drv %94, %u_adc_pd_ctl_wakeup_time.q after %1 : i24
    llhd.drv %aon_adc_pd_ctl_wakeup_time_qs_int, %u_adc_pd_ctl_wakeup_time.qs after %1 : i24
    %95 = llhd.sig.struct_extract %reg2hw["adc_lp_sample_ctl"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>>
    %96 = llhd.sig.struct_extract %95["q"] : <!hw.struct<q: i8>>
    %u_adc_lp_sample_ctl.qe, %u_adc_lp_sample_ctl.q, %u_adc_lp_sample_ctl.ds, %u_adc_lp_sample_ctl.qs = hw.instance "u_adc_lp_sample_ctl" @prim_subreg_13(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_lp_sample_ctl_cdc.dst_we_o: i1, wd: %u_adc_lp_sample_ctl_cdc.dst_wd_o: i8, de: %false: i1, d: %c0_i8: i8) -> (qe: i1, q: i8, ds: i8, qs: i8)
    llhd.drv %96, %u_adc_lp_sample_ctl.q after %1 : i8
    llhd.drv %aon_adc_lp_sample_ctl_qs_int, %u_adc_lp_sample_ctl.qs after %1 : i8
    %97 = llhd.sig.struct_extract %reg2hw["adc_sample_ctl"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>>
    %98 = llhd.sig.struct_extract %97["q"] : <!hw.struct<q: i16>>
    %u_adc_sample_ctl.qe, %u_adc_sample_ctl.q, %u_adc_sample_ctl.ds, %u_adc_sample_ctl.qs = hw.instance "u_adc_sample_ctl" @prim_subreg_14(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_sample_ctl_cdc.dst_we_o: i1, wd: %u_adc_sample_ctl_cdc.dst_wd_o: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %98, %u_adc_sample_ctl.q after %1 : i16
    llhd.drv %aon_adc_sample_ctl_qs_int, %u_adc_sample_ctl.qs after %1 : i16
    %99 = llhd.sig.struct_extract %reg2hw["adc_fsm_rst"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>>
    %100 = llhd.sig.struct_extract %99["q"] : <!hw.struct<q: i1>>
    %u_adc_fsm_rst.qe, %u_adc_fsm_rst.q, %u_adc_fsm_rst.ds, %u_adc_fsm_rst.qs = hw.instance "u_adc_fsm_rst" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_fsm_rst_cdc.dst_we_o: i1, wd: %u_adc_fsm_rst_cdc.dst_wd_o: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %100, %u_adc_fsm_rst.q after %1 : i1
    llhd.drv %aon_adc_fsm_rst_qs_int, %u_adc_fsm_rst.qs after %1 : i1
    %101 = comb.extract %u_adc_chn0_filter_ctl_0_cdc.dst_wd_o from 2 : (i32) -> i10
    %102 = llhd.sig.struct_extract %reg2hw["adc_chn0_filter_ctl"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>>
    %103 = llhd.sig.array_get %102[%c0_i3] : <!hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>>
    %104 = llhd.sig.struct_extract %103["min_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %105 = llhd.sig.struct_extract %104["q"] : <!hw.struct<q: i10>>
    %u_adc_chn0_filter_ctl_0_min_v_0.qe, %u_adc_chn0_filter_ctl_0_min_v_0.q, %u_adc_chn0_filter_ctl_0_min_v_0.ds, %u_adc_chn0_filter_ctl_0_min_v_0.qs = hw.instance "u_adc_chn0_filter_ctl_0_min_v_0" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_0_cdc.dst_we_o: i1, wd: %101: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %105, %u_adc_chn0_filter_ctl_0_min_v_0.q after %1 : i10
    llhd.drv %aon_adc_chn0_filter_ctl_0_min_v_0_qs_int, %u_adc_chn0_filter_ctl_0_min_v_0.qs after %1 : i10
    %106 = comb.extract %u_adc_chn0_filter_ctl_0_cdc.dst_wd_o from 12 : (i32) -> i1
    %107 = llhd.sig.struct_extract %103["cond"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %108 = llhd.sig.struct_extract %107["q"] : <!hw.struct<q: i1>>
    %u_adc_chn0_filter_ctl_0_cond_0.qe, %u_adc_chn0_filter_ctl_0_cond_0.q, %u_adc_chn0_filter_ctl_0_cond_0.ds, %u_adc_chn0_filter_ctl_0_cond_0.qs = hw.instance "u_adc_chn0_filter_ctl_0_cond_0" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_0_cdc.dst_we_o: i1, wd: %106: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %108, %u_adc_chn0_filter_ctl_0_cond_0.q after %1 : i1
    llhd.drv %aon_adc_chn0_filter_ctl_0_cond_0_qs_int, %u_adc_chn0_filter_ctl_0_cond_0.qs after %1 : i1
    %109 = comb.extract %u_adc_chn0_filter_ctl_0_cdc.dst_wd_o from 18 : (i32) -> i10
    %110 = llhd.sig.struct_extract %103["max_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %111 = llhd.sig.struct_extract %110["q"] : <!hw.struct<q: i10>>
    %u_adc_chn0_filter_ctl_0_max_v_0.qe, %u_adc_chn0_filter_ctl_0_max_v_0.q, %u_adc_chn0_filter_ctl_0_max_v_0.ds, %u_adc_chn0_filter_ctl_0_max_v_0.qs = hw.instance "u_adc_chn0_filter_ctl_0_max_v_0" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_0_cdc.dst_we_o: i1, wd: %109: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %111, %u_adc_chn0_filter_ctl_0_max_v_0.q after %1 : i10
    llhd.drv %aon_adc_chn0_filter_ctl_0_max_v_0_qs_int, %u_adc_chn0_filter_ctl_0_max_v_0.qs after %1 : i10
    %112 = comb.extract %u_adc_chn0_filter_ctl_0_cdc.dst_wd_o from 31 : (i32) -> i1
    %113 = llhd.sig.struct_extract %103["en"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %114 = llhd.sig.struct_extract %113["q"] : <!hw.struct<q: i1>>
    %u_adc_chn0_filter_ctl_0_en_0.qe, %u_adc_chn0_filter_ctl_0_en_0.q, %u_adc_chn0_filter_ctl_0_en_0.ds, %u_adc_chn0_filter_ctl_0_en_0.qs = hw.instance "u_adc_chn0_filter_ctl_0_en_0" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_0_cdc.dst_we_o: i1, wd: %112: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %114, %u_adc_chn0_filter_ctl_0_en_0.q after %1 : i1
    llhd.drv %aon_adc_chn0_filter_ctl_0_en_0_qs_int, %u_adc_chn0_filter_ctl_0_en_0.qs after %1 : i1
    %115 = comb.extract %u_adc_chn0_filter_ctl_1_cdc.dst_wd_o from 2 : (i32) -> i10
    %116 = llhd.sig.array_get %102[%c1_i3] : <!hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>>
    %117 = llhd.sig.struct_extract %116["min_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %118 = llhd.sig.struct_extract %117["q"] : <!hw.struct<q: i10>>
    %u_adc_chn0_filter_ctl_1_min_v_1.qe, %u_adc_chn0_filter_ctl_1_min_v_1.q, %u_adc_chn0_filter_ctl_1_min_v_1.ds, %u_adc_chn0_filter_ctl_1_min_v_1.qs = hw.instance "u_adc_chn0_filter_ctl_1_min_v_1" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_1_cdc.dst_we_o: i1, wd: %115: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %118, %u_adc_chn0_filter_ctl_1_min_v_1.q after %1 : i10
    llhd.drv %aon_adc_chn0_filter_ctl_1_min_v_1_qs_int, %u_adc_chn0_filter_ctl_1_min_v_1.qs after %1 : i10
    %119 = comb.extract %u_adc_chn0_filter_ctl_1_cdc.dst_wd_o from 12 : (i32) -> i1
    %120 = llhd.sig.struct_extract %116["cond"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %121 = llhd.sig.struct_extract %120["q"] : <!hw.struct<q: i1>>
    %u_adc_chn0_filter_ctl_1_cond_1.qe, %u_adc_chn0_filter_ctl_1_cond_1.q, %u_adc_chn0_filter_ctl_1_cond_1.ds, %u_adc_chn0_filter_ctl_1_cond_1.qs = hw.instance "u_adc_chn0_filter_ctl_1_cond_1" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_1_cdc.dst_we_o: i1, wd: %119: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %121, %u_adc_chn0_filter_ctl_1_cond_1.q after %1 : i1
    llhd.drv %aon_adc_chn0_filter_ctl_1_cond_1_qs_int, %u_adc_chn0_filter_ctl_1_cond_1.qs after %1 : i1
    %122 = comb.extract %u_adc_chn0_filter_ctl_1_cdc.dst_wd_o from 18 : (i32) -> i10
    %123 = llhd.sig.struct_extract %116["max_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %124 = llhd.sig.struct_extract %123["q"] : <!hw.struct<q: i10>>
    %u_adc_chn0_filter_ctl_1_max_v_1.qe, %u_adc_chn0_filter_ctl_1_max_v_1.q, %u_adc_chn0_filter_ctl_1_max_v_1.ds, %u_adc_chn0_filter_ctl_1_max_v_1.qs = hw.instance "u_adc_chn0_filter_ctl_1_max_v_1" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_1_cdc.dst_we_o: i1, wd: %122: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %124, %u_adc_chn0_filter_ctl_1_max_v_1.q after %1 : i10
    llhd.drv %aon_adc_chn0_filter_ctl_1_max_v_1_qs_int, %u_adc_chn0_filter_ctl_1_max_v_1.qs after %1 : i10
    %125 = comb.extract %u_adc_chn0_filter_ctl_1_cdc.dst_wd_o from 31 : (i32) -> i1
    %126 = llhd.sig.struct_extract %116["en"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %127 = llhd.sig.struct_extract %126["q"] : <!hw.struct<q: i1>>
    %u_adc_chn0_filter_ctl_1_en_1.qe, %u_adc_chn0_filter_ctl_1_en_1.q, %u_adc_chn0_filter_ctl_1_en_1.ds, %u_adc_chn0_filter_ctl_1_en_1.qs = hw.instance "u_adc_chn0_filter_ctl_1_en_1" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_1_cdc.dst_we_o: i1, wd: %125: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %127, %u_adc_chn0_filter_ctl_1_en_1.q after %1 : i1
    llhd.drv %aon_adc_chn0_filter_ctl_1_en_1_qs_int, %u_adc_chn0_filter_ctl_1_en_1.qs after %1 : i1
    %128 = comb.extract %u_adc_chn0_filter_ctl_2_cdc.dst_wd_o from 2 : (i32) -> i10
    %129 = llhd.sig.array_get %102[%c2_i3] : <!hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>>
    %130 = llhd.sig.struct_extract %129["min_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %131 = llhd.sig.struct_extract %130["q"] : <!hw.struct<q: i10>>
    %u_adc_chn0_filter_ctl_2_min_v_2.qe, %u_adc_chn0_filter_ctl_2_min_v_2.q, %u_adc_chn0_filter_ctl_2_min_v_2.ds, %u_adc_chn0_filter_ctl_2_min_v_2.qs = hw.instance "u_adc_chn0_filter_ctl_2_min_v_2" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_2_cdc.dst_we_o: i1, wd: %128: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %131, %u_adc_chn0_filter_ctl_2_min_v_2.q after %1 : i10
    llhd.drv %aon_adc_chn0_filter_ctl_2_min_v_2_qs_int, %u_adc_chn0_filter_ctl_2_min_v_2.qs after %1 : i10
    %132 = comb.extract %u_adc_chn0_filter_ctl_2_cdc.dst_wd_o from 12 : (i32) -> i1
    %133 = llhd.sig.struct_extract %129["cond"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %134 = llhd.sig.struct_extract %133["q"] : <!hw.struct<q: i1>>
    %u_adc_chn0_filter_ctl_2_cond_2.qe, %u_adc_chn0_filter_ctl_2_cond_2.q, %u_adc_chn0_filter_ctl_2_cond_2.ds, %u_adc_chn0_filter_ctl_2_cond_2.qs = hw.instance "u_adc_chn0_filter_ctl_2_cond_2" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_2_cdc.dst_we_o: i1, wd: %132: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %134, %u_adc_chn0_filter_ctl_2_cond_2.q after %1 : i1
    llhd.drv %aon_adc_chn0_filter_ctl_2_cond_2_qs_int, %u_adc_chn0_filter_ctl_2_cond_2.qs after %1 : i1
    %135 = comb.extract %u_adc_chn0_filter_ctl_2_cdc.dst_wd_o from 18 : (i32) -> i10
    %136 = llhd.sig.struct_extract %129["max_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %137 = llhd.sig.struct_extract %136["q"] : <!hw.struct<q: i10>>
    %u_adc_chn0_filter_ctl_2_max_v_2.qe, %u_adc_chn0_filter_ctl_2_max_v_2.q, %u_adc_chn0_filter_ctl_2_max_v_2.ds, %u_adc_chn0_filter_ctl_2_max_v_2.qs = hw.instance "u_adc_chn0_filter_ctl_2_max_v_2" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_2_cdc.dst_we_o: i1, wd: %135: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %137, %u_adc_chn0_filter_ctl_2_max_v_2.q after %1 : i10
    llhd.drv %aon_adc_chn0_filter_ctl_2_max_v_2_qs_int, %u_adc_chn0_filter_ctl_2_max_v_2.qs after %1 : i10
    %138 = comb.extract %u_adc_chn0_filter_ctl_2_cdc.dst_wd_o from 31 : (i32) -> i1
    %139 = llhd.sig.struct_extract %129["en"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %140 = llhd.sig.struct_extract %139["q"] : <!hw.struct<q: i1>>
    %u_adc_chn0_filter_ctl_2_en_2.qe, %u_adc_chn0_filter_ctl_2_en_2.q, %u_adc_chn0_filter_ctl_2_en_2.ds, %u_adc_chn0_filter_ctl_2_en_2.qs = hw.instance "u_adc_chn0_filter_ctl_2_en_2" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_2_cdc.dst_we_o: i1, wd: %138: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %140, %u_adc_chn0_filter_ctl_2_en_2.q after %1 : i1
    llhd.drv %aon_adc_chn0_filter_ctl_2_en_2_qs_int, %u_adc_chn0_filter_ctl_2_en_2.qs after %1 : i1
    %141 = comb.extract %u_adc_chn0_filter_ctl_3_cdc.dst_wd_o from 2 : (i32) -> i10
    %142 = llhd.sig.array_get %102[%c3_i3] : <!hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>>
    %143 = llhd.sig.struct_extract %142["min_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %144 = llhd.sig.struct_extract %143["q"] : <!hw.struct<q: i10>>
    %u_adc_chn0_filter_ctl_3_min_v_3.qe, %u_adc_chn0_filter_ctl_3_min_v_3.q, %u_adc_chn0_filter_ctl_3_min_v_3.ds, %u_adc_chn0_filter_ctl_3_min_v_3.qs = hw.instance "u_adc_chn0_filter_ctl_3_min_v_3" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_3_cdc.dst_we_o: i1, wd: %141: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %144, %u_adc_chn0_filter_ctl_3_min_v_3.q after %1 : i10
    llhd.drv %aon_adc_chn0_filter_ctl_3_min_v_3_qs_int, %u_adc_chn0_filter_ctl_3_min_v_3.qs after %1 : i10
    %145 = comb.extract %u_adc_chn0_filter_ctl_3_cdc.dst_wd_o from 12 : (i32) -> i1
    %146 = llhd.sig.struct_extract %142["cond"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %147 = llhd.sig.struct_extract %146["q"] : <!hw.struct<q: i1>>
    %u_adc_chn0_filter_ctl_3_cond_3.qe, %u_adc_chn0_filter_ctl_3_cond_3.q, %u_adc_chn0_filter_ctl_3_cond_3.ds, %u_adc_chn0_filter_ctl_3_cond_3.qs = hw.instance "u_adc_chn0_filter_ctl_3_cond_3" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_3_cdc.dst_we_o: i1, wd: %145: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %147, %u_adc_chn0_filter_ctl_3_cond_3.q after %1 : i1
    llhd.drv %aon_adc_chn0_filter_ctl_3_cond_3_qs_int, %u_adc_chn0_filter_ctl_3_cond_3.qs after %1 : i1
    %148 = comb.extract %u_adc_chn0_filter_ctl_3_cdc.dst_wd_o from 18 : (i32) -> i10
    %149 = llhd.sig.struct_extract %142["max_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %150 = llhd.sig.struct_extract %149["q"] : <!hw.struct<q: i10>>
    %u_adc_chn0_filter_ctl_3_max_v_3.qe, %u_adc_chn0_filter_ctl_3_max_v_3.q, %u_adc_chn0_filter_ctl_3_max_v_3.ds, %u_adc_chn0_filter_ctl_3_max_v_3.qs = hw.instance "u_adc_chn0_filter_ctl_3_max_v_3" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_3_cdc.dst_we_o: i1, wd: %148: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %150, %u_adc_chn0_filter_ctl_3_max_v_3.q after %1 : i10
    llhd.drv %aon_adc_chn0_filter_ctl_3_max_v_3_qs_int, %u_adc_chn0_filter_ctl_3_max_v_3.qs after %1 : i10
    %151 = comb.extract %u_adc_chn0_filter_ctl_3_cdc.dst_wd_o from 31 : (i32) -> i1
    %152 = llhd.sig.struct_extract %142["en"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %153 = llhd.sig.struct_extract %152["q"] : <!hw.struct<q: i1>>
    %u_adc_chn0_filter_ctl_3_en_3.qe, %u_adc_chn0_filter_ctl_3_en_3.q, %u_adc_chn0_filter_ctl_3_en_3.ds, %u_adc_chn0_filter_ctl_3_en_3.qs = hw.instance "u_adc_chn0_filter_ctl_3_en_3" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_3_cdc.dst_we_o: i1, wd: %151: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %153, %u_adc_chn0_filter_ctl_3_en_3.q after %1 : i1
    llhd.drv %aon_adc_chn0_filter_ctl_3_en_3_qs_int, %u_adc_chn0_filter_ctl_3_en_3.qs after %1 : i1
    %154 = comb.extract %u_adc_chn0_filter_ctl_4_cdc.dst_wd_o from 2 : (i32) -> i10
    %155 = llhd.sig.array_get %102[%c-4_i3] : <!hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>>
    %156 = llhd.sig.struct_extract %155["min_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %157 = llhd.sig.struct_extract %156["q"] : <!hw.struct<q: i10>>
    %u_adc_chn0_filter_ctl_4_min_v_4.qe, %u_adc_chn0_filter_ctl_4_min_v_4.q, %u_adc_chn0_filter_ctl_4_min_v_4.ds, %u_adc_chn0_filter_ctl_4_min_v_4.qs = hw.instance "u_adc_chn0_filter_ctl_4_min_v_4" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_4_cdc.dst_we_o: i1, wd: %154: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %157, %u_adc_chn0_filter_ctl_4_min_v_4.q after %1 : i10
    llhd.drv %aon_adc_chn0_filter_ctl_4_min_v_4_qs_int, %u_adc_chn0_filter_ctl_4_min_v_4.qs after %1 : i10
    %158 = comb.extract %u_adc_chn0_filter_ctl_4_cdc.dst_wd_o from 12 : (i32) -> i1
    %159 = llhd.sig.struct_extract %155["cond"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %160 = llhd.sig.struct_extract %159["q"] : <!hw.struct<q: i1>>
    %u_adc_chn0_filter_ctl_4_cond_4.qe, %u_adc_chn0_filter_ctl_4_cond_4.q, %u_adc_chn0_filter_ctl_4_cond_4.ds, %u_adc_chn0_filter_ctl_4_cond_4.qs = hw.instance "u_adc_chn0_filter_ctl_4_cond_4" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_4_cdc.dst_we_o: i1, wd: %158: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %160, %u_adc_chn0_filter_ctl_4_cond_4.q after %1 : i1
    llhd.drv %aon_adc_chn0_filter_ctl_4_cond_4_qs_int, %u_adc_chn0_filter_ctl_4_cond_4.qs after %1 : i1
    %161 = comb.extract %u_adc_chn0_filter_ctl_4_cdc.dst_wd_o from 18 : (i32) -> i10
    %162 = llhd.sig.struct_extract %155["max_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %163 = llhd.sig.struct_extract %162["q"] : <!hw.struct<q: i10>>
    %u_adc_chn0_filter_ctl_4_max_v_4.qe, %u_adc_chn0_filter_ctl_4_max_v_4.q, %u_adc_chn0_filter_ctl_4_max_v_4.ds, %u_adc_chn0_filter_ctl_4_max_v_4.qs = hw.instance "u_adc_chn0_filter_ctl_4_max_v_4" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_4_cdc.dst_we_o: i1, wd: %161: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %163, %u_adc_chn0_filter_ctl_4_max_v_4.q after %1 : i10
    llhd.drv %aon_adc_chn0_filter_ctl_4_max_v_4_qs_int, %u_adc_chn0_filter_ctl_4_max_v_4.qs after %1 : i10
    %164 = comb.extract %u_adc_chn0_filter_ctl_4_cdc.dst_wd_o from 31 : (i32) -> i1
    %165 = llhd.sig.struct_extract %155["en"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %166 = llhd.sig.struct_extract %165["q"] : <!hw.struct<q: i1>>
    %u_adc_chn0_filter_ctl_4_en_4.qe, %u_adc_chn0_filter_ctl_4_en_4.q, %u_adc_chn0_filter_ctl_4_en_4.ds, %u_adc_chn0_filter_ctl_4_en_4.qs = hw.instance "u_adc_chn0_filter_ctl_4_en_4" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_4_cdc.dst_we_o: i1, wd: %164: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %166, %u_adc_chn0_filter_ctl_4_en_4.q after %1 : i1
    llhd.drv %aon_adc_chn0_filter_ctl_4_en_4_qs_int, %u_adc_chn0_filter_ctl_4_en_4.qs after %1 : i1
    %167 = comb.extract %u_adc_chn0_filter_ctl_5_cdc.dst_wd_o from 2 : (i32) -> i10
    %168 = llhd.sig.array_get %102[%c-3_i3] : <!hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>>
    %169 = llhd.sig.struct_extract %168["min_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %170 = llhd.sig.struct_extract %169["q"] : <!hw.struct<q: i10>>
    %u_adc_chn0_filter_ctl_5_min_v_5.qe, %u_adc_chn0_filter_ctl_5_min_v_5.q, %u_adc_chn0_filter_ctl_5_min_v_5.ds, %u_adc_chn0_filter_ctl_5_min_v_5.qs = hw.instance "u_adc_chn0_filter_ctl_5_min_v_5" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_5_cdc.dst_we_o: i1, wd: %167: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %170, %u_adc_chn0_filter_ctl_5_min_v_5.q after %1 : i10
    llhd.drv %aon_adc_chn0_filter_ctl_5_min_v_5_qs_int, %u_adc_chn0_filter_ctl_5_min_v_5.qs after %1 : i10
    %171 = comb.extract %u_adc_chn0_filter_ctl_5_cdc.dst_wd_o from 12 : (i32) -> i1
    %172 = llhd.sig.struct_extract %168["cond"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %173 = llhd.sig.struct_extract %172["q"] : <!hw.struct<q: i1>>
    %u_adc_chn0_filter_ctl_5_cond_5.qe, %u_adc_chn0_filter_ctl_5_cond_5.q, %u_adc_chn0_filter_ctl_5_cond_5.ds, %u_adc_chn0_filter_ctl_5_cond_5.qs = hw.instance "u_adc_chn0_filter_ctl_5_cond_5" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_5_cdc.dst_we_o: i1, wd: %171: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %173, %u_adc_chn0_filter_ctl_5_cond_5.q after %1 : i1
    llhd.drv %aon_adc_chn0_filter_ctl_5_cond_5_qs_int, %u_adc_chn0_filter_ctl_5_cond_5.qs after %1 : i1
    %174 = comb.extract %u_adc_chn0_filter_ctl_5_cdc.dst_wd_o from 18 : (i32) -> i10
    %175 = llhd.sig.struct_extract %168["max_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %176 = llhd.sig.struct_extract %175["q"] : <!hw.struct<q: i10>>
    %u_adc_chn0_filter_ctl_5_max_v_5.qe, %u_adc_chn0_filter_ctl_5_max_v_5.q, %u_adc_chn0_filter_ctl_5_max_v_5.ds, %u_adc_chn0_filter_ctl_5_max_v_5.qs = hw.instance "u_adc_chn0_filter_ctl_5_max_v_5" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_5_cdc.dst_we_o: i1, wd: %174: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %176, %u_adc_chn0_filter_ctl_5_max_v_5.q after %1 : i10
    llhd.drv %aon_adc_chn0_filter_ctl_5_max_v_5_qs_int, %u_adc_chn0_filter_ctl_5_max_v_5.qs after %1 : i10
    %177 = comb.extract %u_adc_chn0_filter_ctl_5_cdc.dst_wd_o from 31 : (i32) -> i1
    %178 = llhd.sig.struct_extract %168["en"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %179 = llhd.sig.struct_extract %178["q"] : <!hw.struct<q: i1>>
    %u_adc_chn0_filter_ctl_5_en_5.qe, %u_adc_chn0_filter_ctl_5_en_5.q, %u_adc_chn0_filter_ctl_5_en_5.ds, %u_adc_chn0_filter_ctl_5_en_5.qs = hw.instance "u_adc_chn0_filter_ctl_5_en_5" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_5_cdc.dst_we_o: i1, wd: %177: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %179, %u_adc_chn0_filter_ctl_5_en_5.q after %1 : i1
    llhd.drv %aon_adc_chn0_filter_ctl_5_en_5_qs_int, %u_adc_chn0_filter_ctl_5_en_5.qs after %1 : i1
    %180 = comb.extract %u_adc_chn0_filter_ctl_6_cdc.dst_wd_o from 2 : (i32) -> i10
    %181 = llhd.sig.array_get %102[%c-2_i3] : <!hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>>
    %182 = llhd.sig.struct_extract %181["min_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %183 = llhd.sig.struct_extract %182["q"] : <!hw.struct<q: i10>>
    %u_adc_chn0_filter_ctl_6_min_v_6.qe, %u_adc_chn0_filter_ctl_6_min_v_6.q, %u_adc_chn0_filter_ctl_6_min_v_6.ds, %u_adc_chn0_filter_ctl_6_min_v_6.qs = hw.instance "u_adc_chn0_filter_ctl_6_min_v_6" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_6_cdc.dst_we_o: i1, wd: %180: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %183, %u_adc_chn0_filter_ctl_6_min_v_6.q after %1 : i10
    llhd.drv %aon_adc_chn0_filter_ctl_6_min_v_6_qs_int, %u_adc_chn0_filter_ctl_6_min_v_6.qs after %1 : i10
    %184 = comb.extract %u_adc_chn0_filter_ctl_6_cdc.dst_wd_o from 12 : (i32) -> i1
    %185 = llhd.sig.struct_extract %181["cond"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %186 = llhd.sig.struct_extract %185["q"] : <!hw.struct<q: i1>>
    %u_adc_chn0_filter_ctl_6_cond_6.qe, %u_adc_chn0_filter_ctl_6_cond_6.q, %u_adc_chn0_filter_ctl_6_cond_6.ds, %u_adc_chn0_filter_ctl_6_cond_6.qs = hw.instance "u_adc_chn0_filter_ctl_6_cond_6" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_6_cdc.dst_we_o: i1, wd: %184: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %186, %u_adc_chn0_filter_ctl_6_cond_6.q after %1 : i1
    llhd.drv %aon_adc_chn0_filter_ctl_6_cond_6_qs_int, %u_adc_chn0_filter_ctl_6_cond_6.qs after %1 : i1
    %187 = comb.extract %u_adc_chn0_filter_ctl_6_cdc.dst_wd_o from 18 : (i32) -> i10
    %188 = llhd.sig.struct_extract %181["max_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %189 = llhd.sig.struct_extract %188["q"] : <!hw.struct<q: i10>>
    %u_adc_chn0_filter_ctl_6_max_v_6.qe, %u_adc_chn0_filter_ctl_6_max_v_6.q, %u_adc_chn0_filter_ctl_6_max_v_6.ds, %u_adc_chn0_filter_ctl_6_max_v_6.qs = hw.instance "u_adc_chn0_filter_ctl_6_max_v_6" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_6_cdc.dst_we_o: i1, wd: %187: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %189, %u_adc_chn0_filter_ctl_6_max_v_6.q after %1 : i10
    llhd.drv %aon_adc_chn0_filter_ctl_6_max_v_6_qs_int, %u_adc_chn0_filter_ctl_6_max_v_6.qs after %1 : i10
    %190 = comb.extract %u_adc_chn0_filter_ctl_6_cdc.dst_wd_o from 31 : (i32) -> i1
    %191 = llhd.sig.struct_extract %181["en"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %192 = llhd.sig.struct_extract %191["q"] : <!hw.struct<q: i1>>
    %u_adc_chn0_filter_ctl_6_en_6.qe, %u_adc_chn0_filter_ctl_6_en_6.q, %u_adc_chn0_filter_ctl_6_en_6.ds, %u_adc_chn0_filter_ctl_6_en_6.qs = hw.instance "u_adc_chn0_filter_ctl_6_en_6" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_6_cdc.dst_we_o: i1, wd: %190: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %192, %u_adc_chn0_filter_ctl_6_en_6.q after %1 : i1
    llhd.drv %aon_adc_chn0_filter_ctl_6_en_6_qs_int, %u_adc_chn0_filter_ctl_6_en_6.qs after %1 : i1
    %193 = comb.extract %u_adc_chn0_filter_ctl_7_cdc.dst_wd_o from 2 : (i32) -> i10
    %194 = llhd.sig.array_get %102[%c-1_i3] : <!hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>>
    %195 = llhd.sig.struct_extract %194["min_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %196 = llhd.sig.struct_extract %195["q"] : <!hw.struct<q: i10>>
    %u_adc_chn0_filter_ctl_7_min_v_7.qe, %u_adc_chn0_filter_ctl_7_min_v_7.q, %u_adc_chn0_filter_ctl_7_min_v_7.ds, %u_adc_chn0_filter_ctl_7_min_v_7.qs = hw.instance "u_adc_chn0_filter_ctl_7_min_v_7" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_7_cdc.dst_we_o: i1, wd: %193: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %196, %u_adc_chn0_filter_ctl_7_min_v_7.q after %1 : i10
    llhd.drv %aon_adc_chn0_filter_ctl_7_min_v_7_qs_int, %u_adc_chn0_filter_ctl_7_min_v_7.qs after %1 : i10
    %197 = comb.extract %u_adc_chn0_filter_ctl_7_cdc.dst_wd_o from 12 : (i32) -> i1
    %198 = llhd.sig.struct_extract %194["cond"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %199 = llhd.sig.struct_extract %198["q"] : <!hw.struct<q: i1>>
    %u_adc_chn0_filter_ctl_7_cond_7.qe, %u_adc_chn0_filter_ctl_7_cond_7.q, %u_adc_chn0_filter_ctl_7_cond_7.ds, %u_adc_chn0_filter_ctl_7_cond_7.qs = hw.instance "u_adc_chn0_filter_ctl_7_cond_7" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_7_cdc.dst_we_o: i1, wd: %197: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %199, %u_adc_chn0_filter_ctl_7_cond_7.q after %1 : i1
    llhd.drv %aon_adc_chn0_filter_ctl_7_cond_7_qs_int, %u_adc_chn0_filter_ctl_7_cond_7.qs after %1 : i1
    %200 = comb.extract %u_adc_chn0_filter_ctl_7_cdc.dst_wd_o from 18 : (i32) -> i10
    %201 = llhd.sig.struct_extract %194["max_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %202 = llhd.sig.struct_extract %201["q"] : <!hw.struct<q: i10>>
    %u_adc_chn0_filter_ctl_7_max_v_7.qe, %u_adc_chn0_filter_ctl_7_max_v_7.q, %u_adc_chn0_filter_ctl_7_max_v_7.ds, %u_adc_chn0_filter_ctl_7_max_v_7.qs = hw.instance "u_adc_chn0_filter_ctl_7_max_v_7" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_7_cdc.dst_we_o: i1, wd: %200: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %202, %u_adc_chn0_filter_ctl_7_max_v_7.q after %1 : i10
    llhd.drv %aon_adc_chn0_filter_ctl_7_max_v_7_qs_int, %u_adc_chn0_filter_ctl_7_max_v_7.qs after %1 : i10
    %203 = comb.extract %u_adc_chn0_filter_ctl_7_cdc.dst_wd_o from 31 : (i32) -> i1
    %204 = llhd.sig.struct_extract %194["en"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %205 = llhd.sig.struct_extract %204["q"] : <!hw.struct<q: i1>>
    %u_adc_chn0_filter_ctl_7_en_7.qe, %u_adc_chn0_filter_ctl_7_en_7.q, %u_adc_chn0_filter_ctl_7_en_7.ds, %u_adc_chn0_filter_ctl_7_en_7.qs = hw.instance "u_adc_chn0_filter_ctl_7_en_7" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn0_filter_ctl_7_cdc.dst_we_o: i1, wd: %203: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %205, %u_adc_chn0_filter_ctl_7_en_7.q after %1 : i1
    llhd.drv %aon_adc_chn0_filter_ctl_7_en_7_qs_int, %u_adc_chn0_filter_ctl_7_en_7.qs after %1 : i1
    %206 = comb.extract %u_adc_chn1_filter_ctl_0_cdc.dst_wd_o from 2 : (i32) -> i10
    %207 = llhd.sig.struct_extract %reg2hw["adc_chn1_filter_ctl"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>>
    %208 = llhd.sig.array_get %207[%c0_i3] : <!hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>>
    %209 = llhd.sig.struct_extract %208["min_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %210 = llhd.sig.struct_extract %209["q"] : <!hw.struct<q: i10>>
    %u_adc_chn1_filter_ctl_0_min_v_0.qe, %u_adc_chn1_filter_ctl_0_min_v_0.q, %u_adc_chn1_filter_ctl_0_min_v_0.ds, %u_adc_chn1_filter_ctl_0_min_v_0.qs = hw.instance "u_adc_chn1_filter_ctl_0_min_v_0" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_0_cdc.dst_we_o: i1, wd: %206: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %210, %u_adc_chn1_filter_ctl_0_min_v_0.q after %1 : i10
    llhd.drv %aon_adc_chn1_filter_ctl_0_min_v_0_qs_int, %u_adc_chn1_filter_ctl_0_min_v_0.qs after %1 : i10
    %211 = comb.extract %u_adc_chn1_filter_ctl_0_cdc.dst_wd_o from 12 : (i32) -> i1
    %212 = llhd.sig.struct_extract %208["cond"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %213 = llhd.sig.struct_extract %212["q"] : <!hw.struct<q: i1>>
    %u_adc_chn1_filter_ctl_0_cond_0.qe, %u_adc_chn1_filter_ctl_0_cond_0.q, %u_adc_chn1_filter_ctl_0_cond_0.ds, %u_adc_chn1_filter_ctl_0_cond_0.qs = hw.instance "u_adc_chn1_filter_ctl_0_cond_0" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_0_cdc.dst_we_o: i1, wd: %211: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %213, %u_adc_chn1_filter_ctl_0_cond_0.q after %1 : i1
    llhd.drv %aon_adc_chn1_filter_ctl_0_cond_0_qs_int, %u_adc_chn1_filter_ctl_0_cond_0.qs after %1 : i1
    %214 = comb.extract %u_adc_chn1_filter_ctl_0_cdc.dst_wd_o from 18 : (i32) -> i10
    %215 = llhd.sig.struct_extract %208["max_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %216 = llhd.sig.struct_extract %215["q"] : <!hw.struct<q: i10>>
    %u_adc_chn1_filter_ctl_0_max_v_0.qe, %u_adc_chn1_filter_ctl_0_max_v_0.q, %u_adc_chn1_filter_ctl_0_max_v_0.ds, %u_adc_chn1_filter_ctl_0_max_v_0.qs = hw.instance "u_adc_chn1_filter_ctl_0_max_v_0" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_0_cdc.dst_we_o: i1, wd: %214: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %216, %u_adc_chn1_filter_ctl_0_max_v_0.q after %1 : i10
    llhd.drv %aon_adc_chn1_filter_ctl_0_max_v_0_qs_int, %u_adc_chn1_filter_ctl_0_max_v_0.qs after %1 : i10
    %217 = comb.extract %u_adc_chn1_filter_ctl_0_cdc.dst_wd_o from 31 : (i32) -> i1
    %218 = llhd.sig.struct_extract %208["en"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %219 = llhd.sig.struct_extract %218["q"] : <!hw.struct<q: i1>>
    %u_adc_chn1_filter_ctl_0_en_0.qe, %u_adc_chn1_filter_ctl_0_en_0.q, %u_adc_chn1_filter_ctl_0_en_0.ds, %u_adc_chn1_filter_ctl_0_en_0.qs = hw.instance "u_adc_chn1_filter_ctl_0_en_0" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_0_cdc.dst_we_o: i1, wd: %217: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %219, %u_adc_chn1_filter_ctl_0_en_0.q after %1 : i1
    llhd.drv %aon_adc_chn1_filter_ctl_0_en_0_qs_int, %u_adc_chn1_filter_ctl_0_en_0.qs after %1 : i1
    %220 = comb.extract %u_adc_chn1_filter_ctl_1_cdc.dst_wd_o from 2 : (i32) -> i10
    %221 = llhd.sig.array_get %207[%c1_i3] : <!hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>>
    %222 = llhd.sig.struct_extract %221["min_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %223 = llhd.sig.struct_extract %222["q"] : <!hw.struct<q: i10>>
    %u_adc_chn1_filter_ctl_1_min_v_1.qe, %u_adc_chn1_filter_ctl_1_min_v_1.q, %u_adc_chn1_filter_ctl_1_min_v_1.ds, %u_adc_chn1_filter_ctl_1_min_v_1.qs = hw.instance "u_adc_chn1_filter_ctl_1_min_v_1" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_1_cdc.dst_we_o: i1, wd: %220: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %223, %u_adc_chn1_filter_ctl_1_min_v_1.q after %1 : i10
    llhd.drv %aon_adc_chn1_filter_ctl_1_min_v_1_qs_int, %u_adc_chn1_filter_ctl_1_min_v_1.qs after %1 : i10
    %224 = comb.extract %u_adc_chn1_filter_ctl_1_cdc.dst_wd_o from 12 : (i32) -> i1
    %225 = llhd.sig.struct_extract %221["cond"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %226 = llhd.sig.struct_extract %225["q"] : <!hw.struct<q: i1>>
    %u_adc_chn1_filter_ctl_1_cond_1.qe, %u_adc_chn1_filter_ctl_1_cond_1.q, %u_adc_chn1_filter_ctl_1_cond_1.ds, %u_adc_chn1_filter_ctl_1_cond_1.qs = hw.instance "u_adc_chn1_filter_ctl_1_cond_1" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_1_cdc.dst_we_o: i1, wd: %224: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %226, %u_adc_chn1_filter_ctl_1_cond_1.q after %1 : i1
    llhd.drv %aon_adc_chn1_filter_ctl_1_cond_1_qs_int, %u_adc_chn1_filter_ctl_1_cond_1.qs after %1 : i1
    %227 = comb.extract %u_adc_chn1_filter_ctl_1_cdc.dst_wd_o from 18 : (i32) -> i10
    %228 = llhd.sig.struct_extract %221["max_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %229 = llhd.sig.struct_extract %228["q"] : <!hw.struct<q: i10>>
    %u_adc_chn1_filter_ctl_1_max_v_1.qe, %u_adc_chn1_filter_ctl_1_max_v_1.q, %u_adc_chn1_filter_ctl_1_max_v_1.ds, %u_adc_chn1_filter_ctl_1_max_v_1.qs = hw.instance "u_adc_chn1_filter_ctl_1_max_v_1" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_1_cdc.dst_we_o: i1, wd: %227: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %229, %u_adc_chn1_filter_ctl_1_max_v_1.q after %1 : i10
    llhd.drv %aon_adc_chn1_filter_ctl_1_max_v_1_qs_int, %u_adc_chn1_filter_ctl_1_max_v_1.qs after %1 : i10
    %230 = comb.extract %u_adc_chn1_filter_ctl_1_cdc.dst_wd_o from 31 : (i32) -> i1
    %231 = llhd.sig.struct_extract %221["en"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %232 = llhd.sig.struct_extract %231["q"] : <!hw.struct<q: i1>>
    %u_adc_chn1_filter_ctl_1_en_1.qe, %u_adc_chn1_filter_ctl_1_en_1.q, %u_adc_chn1_filter_ctl_1_en_1.ds, %u_adc_chn1_filter_ctl_1_en_1.qs = hw.instance "u_adc_chn1_filter_ctl_1_en_1" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_1_cdc.dst_we_o: i1, wd: %230: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %232, %u_adc_chn1_filter_ctl_1_en_1.q after %1 : i1
    llhd.drv %aon_adc_chn1_filter_ctl_1_en_1_qs_int, %u_adc_chn1_filter_ctl_1_en_1.qs after %1 : i1
    %233 = comb.extract %u_adc_chn1_filter_ctl_2_cdc.dst_wd_o from 2 : (i32) -> i10
    %234 = llhd.sig.array_get %207[%c2_i3] : <!hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>>
    %235 = llhd.sig.struct_extract %234["min_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %236 = llhd.sig.struct_extract %235["q"] : <!hw.struct<q: i10>>
    %u_adc_chn1_filter_ctl_2_min_v_2.qe, %u_adc_chn1_filter_ctl_2_min_v_2.q, %u_adc_chn1_filter_ctl_2_min_v_2.ds, %u_adc_chn1_filter_ctl_2_min_v_2.qs = hw.instance "u_adc_chn1_filter_ctl_2_min_v_2" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_2_cdc.dst_we_o: i1, wd: %233: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %236, %u_adc_chn1_filter_ctl_2_min_v_2.q after %1 : i10
    llhd.drv %aon_adc_chn1_filter_ctl_2_min_v_2_qs_int, %u_adc_chn1_filter_ctl_2_min_v_2.qs after %1 : i10
    %237 = comb.extract %u_adc_chn1_filter_ctl_2_cdc.dst_wd_o from 12 : (i32) -> i1
    %238 = llhd.sig.struct_extract %234["cond"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %239 = llhd.sig.struct_extract %238["q"] : <!hw.struct<q: i1>>
    %u_adc_chn1_filter_ctl_2_cond_2.qe, %u_adc_chn1_filter_ctl_2_cond_2.q, %u_adc_chn1_filter_ctl_2_cond_2.ds, %u_adc_chn1_filter_ctl_2_cond_2.qs = hw.instance "u_adc_chn1_filter_ctl_2_cond_2" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_2_cdc.dst_we_o: i1, wd: %237: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %239, %u_adc_chn1_filter_ctl_2_cond_2.q after %1 : i1
    llhd.drv %aon_adc_chn1_filter_ctl_2_cond_2_qs_int, %u_adc_chn1_filter_ctl_2_cond_2.qs after %1 : i1
    %240 = comb.extract %u_adc_chn1_filter_ctl_2_cdc.dst_wd_o from 18 : (i32) -> i10
    %241 = llhd.sig.struct_extract %234["max_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %242 = llhd.sig.struct_extract %241["q"] : <!hw.struct<q: i10>>
    %u_adc_chn1_filter_ctl_2_max_v_2.qe, %u_adc_chn1_filter_ctl_2_max_v_2.q, %u_adc_chn1_filter_ctl_2_max_v_2.ds, %u_adc_chn1_filter_ctl_2_max_v_2.qs = hw.instance "u_adc_chn1_filter_ctl_2_max_v_2" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_2_cdc.dst_we_o: i1, wd: %240: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %242, %u_adc_chn1_filter_ctl_2_max_v_2.q after %1 : i10
    llhd.drv %aon_adc_chn1_filter_ctl_2_max_v_2_qs_int, %u_adc_chn1_filter_ctl_2_max_v_2.qs after %1 : i10
    %243 = comb.extract %u_adc_chn1_filter_ctl_2_cdc.dst_wd_o from 31 : (i32) -> i1
    %244 = llhd.sig.struct_extract %234["en"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %245 = llhd.sig.struct_extract %244["q"] : <!hw.struct<q: i1>>
    %u_adc_chn1_filter_ctl_2_en_2.qe, %u_adc_chn1_filter_ctl_2_en_2.q, %u_adc_chn1_filter_ctl_2_en_2.ds, %u_adc_chn1_filter_ctl_2_en_2.qs = hw.instance "u_adc_chn1_filter_ctl_2_en_2" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_2_cdc.dst_we_o: i1, wd: %243: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %245, %u_adc_chn1_filter_ctl_2_en_2.q after %1 : i1
    llhd.drv %aon_adc_chn1_filter_ctl_2_en_2_qs_int, %u_adc_chn1_filter_ctl_2_en_2.qs after %1 : i1
    %246 = comb.extract %u_adc_chn1_filter_ctl_3_cdc.dst_wd_o from 2 : (i32) -> i10
    %247 = llhd.sig.array_get %207[%c3_i3] : <!hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>>
    %248 = llhd.sig.struct_extract %247["min_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %249 = llhd.sig.struct_extract %248["q"] : <!hw.struct<q: i10>>
    %u_adc_chn1_filter_ctl_3_min_v_3.qe, %u_adc_chn1_filter_ctl_3_min_v_3.q, %u_adc_chn1_filter_ctl_3_min_v_3.ds, %u_adc_chn1_filter_ctl_3_min_v_3.qs = hw.instance "u_adc_chn1_filter_ctl_3_min_v_3" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_3_cdc.dst_we_o: i1, wd: %246: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %249, %u_adc_chn1_filter_ctl_3_min_v_3.q after %1 : i10
    llhd.drv %aon_adc_chn1_filter_ctl_3_min_v_3_qs_int, %u_adc_chn1_filter_ctl_3_min_v_3.qs after %1 : i10
    %250 = comb.extract %u_adc_chn1_filter_ctl_3_cdc.dst_wd_o from 12 : (i32) -> i1
    %251 = llhd.sig.struct_extract %247["cond"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %252 = llhd.sig.struct_extract %251["q"] : <!hw.struct<q: i1>>
    %u_adc_chn1_filter_ctl_3_cond_3.qe, %u_adc_chn1_filter_ctl_3_cond_3.q, %u_adc_chn1_filter_ctl_3_cond_3.ds, %u_adc_chn1_filter_ctl_3_cond_3.qs = hw.instance "u_adc_chn1_filter_ctl_3_cond_3" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_3_cdc.dst_we_o: i1, wd: %250: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %252, %u_adc_chn1_filter_ctl_3_cond_3.q after %1 : i1
    llhd.drv %aon_adc_chn1_filter_ctl_3_cond_3_qs_int, %u_adc_chn1_filter_ctl_3_cond_3.qs after %1 : i1
    %253 = comb.extract %u_adc_chn1_filter_ctl_3_cdc.dst_wd_o from 18 : (i32) -> i10
    %254 = llhd.sig.struct_extract %247["max_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %255 = llhd.sig.struct_extract %254["q"] : <!hw.struct<q: i10>>
    %u_adc_chn1_filter_ctl_3_max_v_3.qe, %u_adc_chn1_filter_ctl_3_max_v_3.q, %u_adc_chn1_filter_ctl_3_max_v_3.ds, %u_adc_chn1_filter_ctl_3_max_v_3.qs = hw.instance "u_adc_chn1_filter_ctl_3_max_v_3" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_3_cdc.dst_we_o: i1, wd: %253: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %255, %u_adc_chn1_filter_ctl_3_max_v_3.q after %1 : i10
    llhd.drv %aon_adc_chn1_filter_ctl_3_max_v_3_qs_int, %u_adc_chn1_filter_ctl_3_max_v_3.qs after %1 : i10
    %256 = comb.extract %u_adc_chn1_filter_ctl_3_cdc.dst_wd_o from 31 : (i32) -> i1
    %257 = llhd.sig.struct_extract %247["en"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %258 = llhd.sig.struct_extract %257["q"] : <!hw.struct<q: i1>>
    %u_adc_chn1_filter_ctl_3_en_3.qe, %u_adc_chn1_filter_ctl_3_en_3.q, %u_adc_chn1_filter_ctl_3_en_3.ds, %u_adc_chn1_filter_ctl_3_en_3.qs = hw.instance "u_adc_chn1_filter_ctl_3_en_3" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_3_cdc.dst_we_o: i1, wd: %256: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %258, %u_adc_chn1_filter_ctl_3_en_3.q after %1 : i1
    llhd.drv %aon_adc_chn1_filter_ctl_3_en_3_qs_int, %u_adc_chn1_filter_ctl_3_en_3.qs after %1 : i1
    %259 = comb.extract %u_adc_chn1_filter_ctl_4_cdc.dst_wd_o from 2 : (i32) -> i10
    %260 = llhd.sig.array_get %207[%c-4_i3] : <!hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>>
    %261 = llhd.sig.struct_extract %260["min_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %262 = llhd.sig.struct_extract %261["q"] : <!hw.struct<q: i10>>
    %u_adc_chn1_filter_ctl_4_min_v_4.qe, %u_adc_chn1_filter_ctl_4_min_v_4.q, %u_adc_chn1_filter_ctl_4_min_v_4.ds, %u_adc_chn1_filter_ctl_4_min_v_4.qs = hw.instance "u_adc_chn1_filter_ctl_4_min_v_4" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_4_cdc.dst_we_o: i1, wd: %259: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %262, %u_adc_chn1_filter_ctl_4_min_v_4.q after %1 : i10
    llhd.drv %aon_adc_chn1_filter_ctl_4_min_v_4_qs_int, %u_adc_chn1_filter_ctl_4_min_v_4.qs after %1 : i10
    %263 = comb.extract %u_adc_chn1_filter_ctl_4_cdc.dst_wd_o from 12 : (i32) -> i1
    %264 = llhd.sig.struct_extract %260["cond"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %265 = llhd.sig.struct_extract %264["q"] : <!hw.struct<q: i1>>
    %u_adc_chn1_filter_ctl_4_cond_4.qe, %u_adc_chn1_filter_ctl_4_cond_4.q, %u_adc_chn1_filter_ctl_4_cond_4.ds, %u_adc_chn1_filter_ctl_4_cond_4.qs = hw.instance "u_adc_chn1_filter_ctl_4_cond_4" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_4_cdc.dst_we_o: i1, wd: %263: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %265, %u_adc_chn1_filter_ctl_4_cond_4.q after %1 : i1
    llhd.drv %aon_adc_chn1_filter_ctl_4_cond_4_qs_int, %u_adc_chn1_filter_ctl_4_cond_4.qs after %1 : i1
    %266 = comb.extract %u_adc_chn1_filter_ctl_4_cdc.dst_wd_o from 18 : (i32) -> i10
    %267 = llhd.sig.struct_extract %260["max_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %268 = llhd.sig.struct_extract %267["q"] : <!hw.struct<q: i10>>
    %u_adc_chn1_filter_ctl_4_max_v_4.qe, %u_adc_chn1_filter_ctl_4_max_v_4.q, %u_adc_chn1_filter_ctl_4_max_v_4.ds, %u_adc_chn1_filter_ctl_4_max_v_4.qs = hw.instance "u_adc_chn1_filter_ctl_4_max_v_4" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_4_cdc.dst_we_o: i1, wd: %266: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %268, %u_adc_chn1_filter_ctl_4_max_v_4.q after %1 : i10
    llhd.drv %aon_adc_chn1_filter_ctl_4_max_v_4_qs_int, %u_adc_chn1_filter_ctl_4_max_v_4.qs after %1 : i10
    %269 = comb.extract %u_adc_chn1_filter_ctl_4_cdc.dst_wd_o from 31 : (i32) -> i1
    %270 = llhd.sig.struct_extract %260["en"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %271 = llhd.sig.struct_extract %270["q"] : <!hw.struct<q: i1>>
    %u_adc_chn1_filter_ctl_4_en_4.qe, %u_adc_chn1_filter_ctl_4_en_4.q, %u_adc_chn1_filter_ctl_4_en_4.ds, %u_adc_chn1_filter_ctl_4_en_4.qs = hw.instance "u_adc_chn1_filter_ctl_4_en_4" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_4_cdc.dst_we_o: i1, wd: %269: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %271, %u_adc_chn1_filter_ctl_4_en_4.q after %1 : i1
    llhd.drv %aon_adc_chn1_filter_ctl_4_en_4_qs_int, %u_adc_chn1_filter_ctl_4_en_4.qs after %1 : i1
    %272 = comb.extract %u_adc_chn1_filter_ctl_5_cdc.dst_wd_o from 2 : (i32) -> i10
    %273 = llhd.sig.array_get %207[%c-3_i3] : <!hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>>
    %274 = llhd.sig.struct_extract %273["min_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %275 = llhd.sig.struct_extract %274["q"] : <!hw.struct<q: i10>>
    %u_adc_chn1_filter_ctl_5_min_v_5.qe, %u_adc_chn1_filter_ctl_5_min_v_5.q, %u_adc_chn1_filter_ctl_5_min_v_5.ds, %u_adc_chn1_filter_ctl_5_min_v_5.qs = hw.instance "u_adc_chn1_filter_ctl_5_min_v_5" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_5_cdc.dst_we_o: i1, wd: %272: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %275, %u_adc_chn1_filter_ctl_5_min_v_5.q after %1 : i10
    llhd.drv %aon_adc_chn1_filter_ctl_5_min_v_5_qs_int, %u_adc_chn1_filter_ctl_5_min_v_5.qs after %1 : i10
    %276 = comb.extract %u_adc_chn1_filter_ctl_5_cdc.dst_wd_o from 12 : (i32) -> i1
    %277 = llhd.sig.struct_extract %273["cond"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %278 = llhd.sig.struct_extract %277["q"] : <!hw.struct<q: i1>>
    %u_adc_chn1_filter_ctl_5_cond_5.qe, %u_adc_chn1_filter_ctl_5_cond_5.q, %u_adc_chn1_filter_ctl_5_cond_5.ds, %u_adc_chn1_filter_ctl_5_cond_5.qs = hw.instance "u_adc_chn1_filter_ctl_5_cond_5" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_5_cdc.dst_we_o: i1, wd: %276: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %278, %u_adc_chn1_filter_ctl_5_cond_5.q after %1 : i1
    llhd.drv %aon_adc_chn1_filter_ctl_5_cond_5_qs_int, %u_adc_chn1_filter_ctl_5_cond_5.qs after %1 : i1
    %279 = comb.extract %u_adc_chn1_filter_ctl_5_cdc.dst_wd_o from 18 : (i32) -> i10
    %280 = llhd.sig.struct_extract %273["max_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %281 = llhd.sig.struct_extract %280["q"] : <!hw.struct<q: i10>>
    %u_adc_chn1_filter_ctl_5_max_v_5.qe, %u_adc_chn1_filter_ctl_5_max_v_5.q, %u_adc_chn1_filter_ctl_5_max_v_5.ds, %u_adc_chn1_filter_ctl_5_max_v_5.qs = hw.instance "u_adc_chn1_filter_ctl_5_max_v_5" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_5_cdc.dst_we_o: i1, wd: %279: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %281, %u_adc_chn1_filter_ctl_5_max_v_5.q after %1 : i10
    llhd.drv %aon_adc_chn1_filter_ctl_5_max_v_5_qs_int, %u_adc_chn1_filter_ctl_5_max_v_5.qs after %1 : i10
    %282 = comb.extract %u_adc_chn1_filter_ctl_5_cdc.dst_wd_o from 31 : (i32) -> i1
    %283 = llhd.sig.struct_extract %273["en"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %284 = llhd.sig.struct_extract %283["q"] : <!hw.struct<q: i1>>
    %u_adc_chn1_filter_ctl_5_en_5.qe, %u_adc_chn1_filter_ctl_5_en_5.q, %u_adc_chn1_filter_ctl_5_en_5.ds, %u_adc_chn1_filter_ctl_5_en_5.qs = hw.instance "u_adc_chn1_filter_ctl_5_en_5" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_5_cdc.dst_we_o: i1, wd: %282: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %284, %u_adc_chn1_filter_ctl_5_en_5.q after %1 : i1
    llhd.drv %aon_adc_chn1_filter_ctl_5_en_5_qs_int, %u_adc_chn1_filter_ctl_5_en_5.qs after %1 : i1
    %285 = comb.extract %u_adc_chn1_filter_ctl_6_cdc.dst_wd_o from 2 : (i32) -> i10
    %286 = llhd.sig.array_get %207[%c-2_i3] : <!hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>>
    %287 = llhd.sig.struct_extract %286["min_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %288 = llhd.sig.struct_extract %287["q"] : <!hw.struct<q: i10>>
    %u_adc_chn1_filter_ctl_6_min_v_6.qe, %u_adc_chn1_filter_ctl_6_min_v_6.q, %u_adc_chn1_filter_ctl_6_min_v_6.ds, %u_adc_chn1_filter_ctl_6_min_v_6.qs = hw.instance "u_adc_chn1_filter_ctl_6_min_v_6" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_6_cdc.dst_we_o: i1, wd: %285: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %288, %u_adc_chn1_filter_ctl_6_min_v_6.q after %1 : i10
    llhd.drv %aon_adc_chn1_filter_ctl_6_min_v_6_qs_int, %u_adc_chn1_filter_ctl_6_min_v_6.qs after %1 : i10
    %289 = comb.extract %u_adc_chn1_filter_ctl_6_cdc.dst_wd_o from 12 : (i32) -> i1
    %290 = llhd.sig.struct_extract %286["cond"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %291 = llhd.sig.struct_extract %290["q"] : <!hw.struct<q: i1>>
    %u_adc_chn1_filter_ctl_6_cond_6.qe, %u_adc_chn1_filter_ctl_6_cond_6.q, %u_adc_chn1_filter_ctl_6_cond_6.ds, %u_adc_chn1_filter_ctl_6_cond_6.qs = hw.instance "u_adc_chn1_filter_ctl_6_cond_6" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_6_cdc.dst_we_o: i1, wd: %289: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %291, %u_adc_chn1_filter_ctl_6_cond_6.q after %1 : i1
    llhd.drv %aon_adc_chn1_filter_ctl_6_cond_6_qs_int, %u_adc_chn1_filter_ctl_6_cond_6.qs after %1 : i1
    %292 = comb.extract %u_adc_chn1_filter_ctl_6_cdc.dst_wd_o from 18 : (i32) -> i10
    %293 = llhd.sig.struct_extract %286["max_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %294 = llhd.sig.struct_extract %293["q"] : <!hw.struct<q: i10>>
    %u_adc_chn1_filter_ctl_6_max_v_6.qe, %u_adc_chn1_filter_ctl_6_max_v_6.q, %u_adc_chn1_filter_ctl_6_max_v_6.ds, %u_adc_chn1_filter_ctl_6_max_v_6.qs = hw.instance "u_adc_chn1_filter_ctl_6_max_v_6" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_6_cdc.dst_we_o: i1, wd: %292: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %294, %u_adc_chn1_filter_ctl_6_max_v_6.q after %1 : i10
    llhd.drv %aon_adc_chn1_filter_ctl_6_max_v_6_qs_int, %u_adc_chn1_filter_ctl_6_max_v_6.qs after %1 : i10
    %295 = comb.extract %u_adc_chn1_filter_ctl_6_cdc.dst_wd_o from 31 : (i32) -> i1
    %296 = llhd.sig.struct_extract %286["en"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %297 = llhd.sig.struct_extract %296["q"] : <!hw.struct<q: i1>>
    %u_adc_chn1_filter_ctl_6_en_6.qe, %u_adc_chn1_filter_ctl_6_en_6.q, %u_adc_chn1_filter_ctl_6_en_6.ds, %u_adc_chn1_filter_ctl_6_en_6.qs = hw.instance "u_adc_chn1_filter_ctl_6_en_6" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_6_cdc.dst_we_o: i1, wd: %295: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %297, %u_adc_chn1_filter_ctl_6_en_6.q after %1 : i1
    llhd.drv %aon_adc_chn1_filter_ctl_6_en_6_qs_int, %u_adc_chn1_filter_ctl_6_en_6.qs after %1 : i1
    %298 = comb.extract %u_adc_chn1_filter_ctl_7_cdc.dst_wd_o from 2 : (i32) -> i10
    %299 = llhd.sig.array_get %207[%c-1_i3] : <!hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>>
    %300 = llhd.sig.struct_extract %299["min_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %301 = llhd.sig.struct_extract %300["q"] : <!hw.struct<q: i10>>
    %u_adc_chn1_filter_ctl_7_min_v_7.qe, %u_adc_chn1_filter_ctl_7_min_v_7.q, %u_adc_chn1_filter_ctl_7_min_v_7.ds, %u_adc_chn1_filter_ctl_7_min_v_7.qs = hw.instance "u_adc_chn1_filter_ctl_7_min_v_7" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_7_cdc.dst_we_o: i1, wd: %298: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %301, %u_adc_chn1_filter_ctl_7_min_v_7.q after %1 : i10
    llhd.drv %aon_adc_chn1_filter_ctl_7_min_v_7_qs_int, %u_adc_chn1_filter_ctl_7_min_v_7.qs after %1 : i10
    %302 = comb.extract %u_adc_chn1_filter_ctl_7_cdc.dst_wd_o from 12 : (i32) -> i1
    %303 = llhd.sig.struct_extract %299["cond"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %304 = llhd.sig.struct_extract %303["q"] : <!hw.struct<q: i1>>
    %u_adc_chn1_filter_ctl_7_cond_7.qe, %u_adc_chn1_filter_ctl_7_cond_7.q, %u_adc_chn1_filter_ctl_7_cond_7.ds, %u_adc_chn1_filter_ctl_7_cond_7.qs = hw.instance "u_adc_chn1_filter_ctl_7_cond_7" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_7_cdc.dst_we_o: i1, wd: %302: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %304, %u_adc_chn1_filter_ctl_7_cond_7.q after %1 : i1
    llhd.drv %aon_adc_chn1_filter_ctl_7_cond_7_qs_int, %u_adc_chn1_filter_ctl_7_cond_7.qs after %1 : i1
    %305 = comb.extract %u_adc_chn1_filter_ctl_7_cdc.dst_wd_o from 18 : (i32) -> i10
    %306 = llhd.sig.struct_extract %299["max_v"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %307 = llhd.sig.struct_extract %306["q"] : <!hw.struct<q: i10>>
    %u_adc_chn1_filter_ctl_7_max_v_7.qe, %u_adc_chn1_filter_ctl_7_max_v_7.q, %u_adc_chn1_filter_ctl_7_max_v_7.ds, %u_adc_chn1_filter_ctl_7_max_v_7.qs = hw.instance "u_adc_chn1_filter_ctl_7_max_v_7" @prim_subreg_15(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_7_cdc.dst_we_o: i1, wd: %305: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %307, %u_adc_chn1_filter_ctl_7_max_v_7.q after %1 : i10
    llhd.drv %aon_adc_chn1_filter_ctl_7_max_v_7_qs_int, %u_adc_chn1_filter_ctl_7_max_v_7.qs after %1 : i10
    %308 = comb.extract %u_adc_chn1_filter_ctl_7_cdc.dst_wd_o from 31 : (i32) -> i1
    %309 = llhd.sig.struct_extract %299["en"] : <!hw.struct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>
    %310 = llhd.sig.struct_extract %309["q"] : <!hw.struct<q: i1>>
    %u_adc_chn1_filter_ctl_7_en_7.qe, %u_adc_chn1_filter_ctl_7_en_7.q, %u_adc_chn1_filter_ctl_7_en_7.ds, %u_adc_chn1_filter_ctl_7_en_7.qs = hw.instance "u_adc_chn1_filter_ctl_7_en_7" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_chn1_filter_ctl_7_cdc.dst_we_o: i1, wd: %308: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %310, %u_adc_chn1_filter_ctl_7_en_7.q after %1 : i1
    llhd.drv %aon_adc_chn1_filter_ctl_7_en_7_qs_int, %u_adc_chn1_filter_ctl_7_en_7.qs after %1 : i1
    %adc_chn_val = hw.struct_extract %hw2reg["adc_chn_val"] : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, adc_chn_val: !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>, filter_status: !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_fsm_state: !hw.struct<d: i5>>
    %311 = hw.array_get %adc_chn_val[%false] : !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>, i1
    %adc_chn_value_ext = hw.struct_extract %311["adc_chn_value_ext"] : !hw.struct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>
    %de_2 = hw.struct_extract %adc_chn_value_ext["de"] : !hw.struct<d: i2, de: i1>
    %d_3 = hw.struct_extract %adc_chn_value_ext["d"] : !hw.struct<d: i2, de: i1>
    %312 = llhd.sig.extract %adc_chn_val_0_flds_we from %c0_i2 : <i4> -> <i1>
    %u_adc_chn_val_0_adc_chn_value_ext_0.qe, %u_adc_chn_val_0_adc_chn_value_ext_0.q, %u_adc_chn_val_0_adc_chn_value_ext_0.ds, %u_adc_chn_val_0_adc_chn_value_ext_0.qs = hw.instance "u_adc_chn_val_0_adc_chn_value_ext_0" @prim_subreg_16(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %false: i1, wd: %c0_i2: i2, de: %de_2: i1, d: %d_3: i2) -> (qe: i1, q: i2, ds: i2, qs: i2)
    llhd.drv %312, %u_adc_chn_val_0_adc_chn_value_ext_0.qe after %1 : i1
    llhd.drv %aon_adc_chn_val_0_adc_chn_value_ext_0_ds_int, %u_adc_chn_val_0_adc_chn_value_ext_0.ds after %1 : i2
    llhd.drv %aon_adc_chn_val_0_adc_chn_value_ext_0_qs_int, %u_adc_chn_val_0_adc_chn_value_ext_0.qs after %1 : i2
    %adc_chn_value = hw.struct_extract %311["adc_chn_value"] : !hw.struct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>
    %de_4 = hw.struct_extract %adc_chn_value["de"] : !hw.struct<d: i10, de: i1>
    %d_5 = hw.struct_extract %adc_chn_value["d"] : !hw.struct<d: i10, de: i1>
    %313 = llhd.sig.extract %adc_chn_val_0_flds_we from %c1_i2 : <i4> -> <i1>
    %u_adc_chn_val_0_adc_chn_value_0.qe, %u_adc_chn_val_0_adc_chn_value_0.q, %u_adc_chn_val_0_adc_chn_value_0.ds, %u_adc_chn_val_0_adc_chn_value_0.qs = hw.instance "u_adc_chn_val_0_adc_chn_value_0" @prim_subreg_17(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %false: i1, wd: %c0_i10: i10, de: %de_4: i1, d: %d_5: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %313, %u_adc_chn_val_0_adc_chn_value_0.qe after %1 : i1
    llhd.drv %aon_adc_chn_val_0_adc_chn_value_0_ds_int, %u_adc_chn_val_0_adc_chn_value_0.ds after %1 : i10
    llhd.drv %aon_adc_chn_val_0_adc_chn_value_0_qs_int, %u_adc_chn_val_0_adc_chn_value_0.qs after %1 : i10
    %adc_chn_value_intr_ext = hw.struct_extract %311["adc_chn_value_intr_ext"] : !hw.struct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>
    %de_6 = hw.struct_extract %adc_chn_value_intr_ext["de"] : !hw.struct<d: i2, de: i1>
    %d_7 = hw.struct_extract %adc_chn_value_intr_ext["d"] : !hw.struct<d: i2, de: i1>
    %314 = llhd.sig.extract %adc_chn_val_0_flds_we from %c-2_i2 : <i4> -> <i1>
    %u_adc_chn_val_0_adc_chn_value_intr_ext_0.qe, %u_adc_chn_val_0_adc_chn_value_intr_ext_0.q, %u_adc_chn_val_0_adc_chn_value_intr_ext_0.ds, %u_adc_chn_val_0_adc_chn_value_intr_ext_0.qs = hw.instance "u_adc_chn_val_0_adc_chn_value_intr_ext_0" @prim_subreg_16(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %false: i1, wd: %c0_i2: i2, de: %de_6: i1, d: %d_7: i2) -> (qe: i1, q: i2, ds: i2, qs: i2)
    llhd.drv %314, %u_adc_chn_val_0_adc_chn_value_intr_ext_0.qe after %1 : i1
    llhd.drv %aon_adc_chn_val_0_adc_chn_value_intr_ext_0_ds_int, %u_adc_chn_val_0_adc_chn_value_intr_ext_0.ds after %1 : i2
    llhd.drv %aon_adc_chn_val_0_adc_chn_value_intr_ext_0_qs_int, %u_adc_chn_val_0_adc_chn_value_intr_ext_0.qs after %1 : i2
    %adc_chn_value_intr = hw.struct_extract %311["adc_chn_value_intr"] : !hw.struct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>
    %de_8 = hw.struct_extract %adc_chn_value_intr["de"] : !hw.struct<d: i10, de: i1>
    %d_9 = hw.struct_extract %adc_chn_value_intr["d"] : !hw.struct<d: i10, de: i1>
    %315 = llhd.sig.extract %adc_chn_val_0_flds_we from %c-1_i2 : <i4> -> <i1>
    %u_adc_chn_val_0_adc_chn_value_intr_0.qe, %u_adc_chn_val_0_adc_chn_value_intr_0.q, %u_adc_chn_val_0_adc_chn_value_intr_0.ds, %u_adc_chn_val_0_adc_chn_value_intr_0.qs = hw.instance "u_adc_chn_val_0_adc_chn_value_intr_0" @prim_subreg_17(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %false: i1, wd: %c0_i10: i10, de: %de_8: i1, d: %d_9: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %315, %u_adc_chn_val_0_adc_chn_value_intr_0.qe after %1 : i1
    llhd.drv %aon_adc_chn_val_0_adc_chn_value_intr_0_ds_int, %u_adc_chn_val_0_adc_chn_value_intr_0.ds after %1 : i10
    llhd.drv %aon_adc_chn_val_0_adc_chn_value_intr_0_qs_int, %u_adc_chn_val_0_adc_chn_value_intr_0.qs after %1 : i10
    %316 = hw.array_get %adc_chn_val[%true] : !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>, i1
    %adc_chn_value_ext_10 = hw.struct_extract %316["adc_chn_value_ext"] : !hw.struct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>
    %de_11 = hw.struct_extract %adc_chn_value_ext_10["de"] : !hw.struct<d: i2, de: i1>
    %d_12 = hw.struct_extract %adc_chn_value_ext_10["d"] : !hw.struct<d: i2, de: i1>
    %317 = llhd.sig.extract %adc_chn_val_1_flds_we from %c0_i2 : <i4> -> <i1>
    %u_adc_chn_val_1_adc_chn_value_ext_1.qe, %u_adc_chn_val_1_adc_chn_value_ext_1.q, %u_adc_chn_val_1_adc_chn_value_ext_1.ds, %u_adc_chn_val_1_adc_chn_value_ext_1.qs = hw.instance "u_adc_chn_val_1_adc_chn_value_ext_1" @prim_subreg_16(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %false: i1, wd: %c0_i2: i2, de: %de_11: i1, d: %d_12: i2) -> (qe: i1, q: i2, ds: i2, qs: i2)
    llhd.drv %317, %u_adc_chn_val_1_adc_chn_value_ext_1.qe after %1 : i1
    llhd.drv %aon_adc_chn_val_1_adc_chn_value_ext_1_ds_int, %u_adc_chn_val_1_adc_chn_value_ext_1.ds after %1 : i2
    llhd.drv %aon_adc_chn_val_1_adc_chn_value_ext_1_qs_int, %u_adc_chn_val_1_adc_chn_value_ext_1.qs after %1 : i2
    %adc_chn_value_13 = hw.struct_extract %316["adc_chn_value"] : !hw.struct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>
    %de_14 = hw.struct_extract %adc_chn_value_13["de"] : !hw.struct<d: i10, de: i1>
    %d_15 = hw.struct_extract %adc_chn_value_13["d"] : !hw.struct<d: i10, de: i1>
    %318 = llhd.sig.extract %adc_chn_val_1_flds_we from %c1_i2 : <i4> -> <i1>
    %u_adc_chn_val_1_adc_chn_value_1.qe, %u_adc_chn_val_1_adc_chn_value_1.q, %u_adc_chn_val_1_adc_chn_value_1.ds, %u_adc_chn_val_1_adc_chn_value_1.qs = hw.instance "u_adc_chn_val_1_adc_chn_value_1" @prim_subreg_17(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %false: i1, wd: %c0_i10: i10, de: %de_14: i1, d: %d_15: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %318, %u_adc_chn_val_1_adc_chn_value_1.qe after %1 : i1
    llhd.drv %aon_adc_chn_val_1_adc_chn_value_1_ds_int, %u_adc_chn_val_1_adc_chn_value_1.ds after %1 : i10
    llhd.drv %aon_adc_chn_val_1_adc_chn_value_1_qs_int, %u_adc_chn_val_1_adc_chn_value_1.qs after %1 : i10
    %adc_chn_value_intr_ext_16 = hw.struct_extract %316["adc_chn_value_intr_ext"] : !hw.struct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>
    %de_17 = hw.struct_extract %adc_chn_value_intr_ext_16["de"] : !hw.struct<d: i2, de: i1>
    %d_18 = hw.struct_extract %adc_chn_value_intr_ext_16["d"] : !hw.struct<d: i2, de: i1>
    %319 = llhd.sig.extract %adc_chn_val_1_flds_we from %c-2_i2 : <i4> -> <i1>
    %u_adc_chn_val_1_adc_chn_value_intr_ext_1.qe, %u_adc_chn_val_1_adc_chn_value_intr_ext_1.q, %u_adc_chn_val_1_adc_chn_value_intr_ext_1.ds, %u_adc_chn_val_1_adc_chn_value_intr_ext_1.qs = hw.instance "u_adc_chn_val_1_adc_chn_value_intr_ext_1" @prim_subreg_16(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %false: i1, wd: %c0_i2: i2, de: %de_17: i1, d: %d_18: i2) -> (qe: i1, q: i2, ds: i2, qs: i2)
    llhd.drv %319, %u_adc_chn_val_1_adc_chn_value_intr_ext_1.qe after %1 : i1
    llhd.drv %aon_adc_chn_val_1_adc_chn_value_intr_ext_1_ds_int, %u_adc_chn_val_1_adc_chn_value_intr_ext_1.ds after %1 : i2
    llhd.drv %aon_adc_chn_val_1_adc_chn_value_intr_ext_1_qs_int, %u_adc_chn_val_1_adc_chn_value_intr_ext_1.qs after %1 : i2
    %adc_chn_value_intr_19 = hw.struct_extract %316["adc_chn_value_intr"] : !hw.struct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>
    %de_20 = hw.struct_extract %adc_chn_value_intr_19["de"] : !hw.struct<d: i10, de: i1>
    %d_21 = hw.struct_extract %adc_chn_value_intr_19["d"] : !hw.struct<d: i10, de: i1>
    %320 = llhd.sig.extract %adc_chn_val_1_flds_we from %c-1_i2 : <i4> -> <i1>
    %u_adc_chn_val_1_adc_chn_value_intr_1.qe, %u_adc_chn_val_1_adc_chn_value_intr_1.q, %u_adc_chn_val_1_adc_chn_value_intr_1.ds, %u_adc_chn_val_1_adc_chn_value_intr_1.qs = hw.instance "u_adc_chn_val_1_adc_chn_value_intr_1" @prim_subreg_17(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %false: i1, wd: %c0_i10: i10, de: %de_20: i1, d: %d_21: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %320, %u_adc_chn_val_1_adc_chn_value_intr_1.qe after %1 : i1
    llhd.drv %aon_adc_chn_val_1_adc_chn_value_intr_1_ds_int, %u_adc_chn_val_1_adc_chn_value_intr_1.ds after %1 : i10
    llhd.drv %aon_adc_chn_val_1_adc_chn_value_intr_1_qs_int, %u_adc_chn_val_1_adc_chn_value_intr_1.qs after %1 : i10
    %321 = comb.extract %u_adc_wakeup_ctl_cdc.dst_wd_o from 0 : (i9) -> i8
    %322 = llhd.sig.struct_extract %reg2hw["adc_wakeup_ctl"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>>
    %323 = llhd.sig.struct_extract %322["match_en"] : <!hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>>
    %324 = llhd.sig.struct_extract %323["q"] : <!hw.struct<q: i8>>
    %u_adc_wakeup_ctl_match_en.qe, %u_adc_wakeup_ctl_match_en.q, %u_adc_wakeup_ctl_match_en.ds, %u_adc_wakeup_ctl_match_en.qs = hw.instance "u_adc_wakeup_ctl_match_en" @prim_subreg_18(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_wakeup_ctl_cdc.dst_we_o: i1, wd: %321: i8, de: %false: i1, d: %c0_i8: i8) -> (qe: i1, q: i8, ds: i8, qs: i8)
    llhd.drv %324, %u_adc_wakeup_ctl_match_en.q after %1 : i8
    llhd.drv %aon_adc_wakeup_ctl_match_en_qs_int, %u_adc_wakeup_ctl_match_en.qs after %1 : i8
    %325 = comb.extract %u_adc_wakeup_ctl_cdc.dst_wd_o from 8 : (i9) -> i1
    %326 = llhd.sig.struct_extract %322["trans_en"] : <!hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>>
    %327 = llhd.sig.struct_extract %326["q"] : <!hw.struct<q: i1>>
    %u_adc_wakeup_ctl_trans_en.qe, %u_adc_wakeup_ctl_trans_en.q, %u_adc_wakeup_ctl_trans_en.ds, %u_adc_wakeup_ctl_trans_en.qs = hw.instance "u_adc_wakeup_ctl_trans_en" @prim_subreg_10(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_adc_wakeup_ctl_cdc.dst_we_o: i1, wd: %325: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %327, %u_adc_wakeup_ctl_trans_en.q after %1 : i1
    llhd.drv %aon_adc_wakeup_ctl_trans_en_qs_int, %u_adc_wakeup_ctl_trans_en.qs after %1 : i1
    %328 = comb.extract %u_filter_status_cdc.dst_wd_o from 0 : (i9) -> i8
    %filter_status = hw.struct_extract %hw2reg["filter_status"] : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, adc_chn_val: !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>, filter_status: !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_fsm_state: !hw.struct<d: i5>>
    %match = hw.struct_extract %filter_status["match"] : !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>
    %de_22 = hw.struct_extract %match["de"] : !hw.struct<d: i8, de: i1>
    %d_23 = hw.struct_extract %match["d"] : !hw.struct<d: i8, de: i1>
    %329 = llhd.sig.extract %filter_status_flds_we from %false : <i2> -> <i1>
    %330 = llhd.sig.struct_extract %reg2hw["filter_status"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>>
    %331 = llhd.sig.struct_extract %330["match"] : <!hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %332 = llhd.sig.struct_extract %331["q"] : <!hw.struct<q: i8>>
    %u_filter_status_match.qe, %u_filter_status_match.q, %u_filter_status_match.ds, %u_filter_status_match.qs = hw.instance "u_filter_status_match" @prim_subreg_19(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_filter_status_cdc.dst_we_o: i1, wd: %328: i8, de: %de_22: i1, d: %d_23: i8) -> (qe: i1, q: i8, ds: i8, qs: i8)
    llhd.drv %329, %u_filter_status_match.qe after %1 : i1
    llhd.drv %332, %u_filter_status_match.q after %1 : i8
    llhd.drv %aon_filter_status_match_ds_int, %u_filter_status_match.ds after %1 : i8
    llhd.drv %aon_filter_status_match_qs_int, %u_filter_status_match.qs after %1 : i8
    %333 = comb.extract %u_filter_status_cdc.dst_wd_o from 8 : (i9) -> i1
    %trans = hw.struct_extract %filter_status["trans"] : !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>
    %de_24 = hw.struct_extract %trans["de"] : !hw.struct<d: i1, de: i1>
    %d_25 = hw.struct_extract %trans["d"] : !hw.struct<d: i1, de: i1>
    %334 = llhd.sig.extract %filter_status_flds_we from %true : <i2> -> <i1>
    %335 = llhd.sig.struct_extract %330["trans"] : <!hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %336 = llhd.sig.struct_extract %335["q"] : <!hw.struct<q: i1>>
    %u_filter_status_trans.qe, %u_filter_status_trans.q, %u_filter_status_trans.ds, %u_filter_status_trans.qs = hw.instance "u_filter_status_trans" @prim_subreg_20(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_filter_status_cdc.dst_we_o: i1, wd: %333: i1, de: %de_24: i1, d: %d_25: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %334, %u_filter_status_trans.qe after %1 : i1
    llhd.drv %336, %u_filter_status_trans.q after %1 : i1
    llhd.drv %aon_filter_status_trans_ds_int, %u_filter_status_trans.ds after %1 : i1
    llhd.drv %aon_filter_status_trans_qs_int, %u_filter_status_trans.qs after %1 : i1
    %337 = llhd.prb %adc_intr_ctl_we : i1
    %338 = llhd.sig.struct_extract %reg2hw["adc_intr_ctl"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>>
    %339 = llhd.sig.struct_extract %338["match_en"] : <!hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>>
    %340 = llhd.sig.struct_extract %339["q"] : <!hw.struct<q: i8>>
    %u_adc_intr_ctl_match_en.qe, %u_adc_intr_ctl_match_en.q, %u_adc_intr_ctl_match_en.ds, %u_adc_intr_ctl_match_en.qs = hw.instance "u_adc_intr_ctl_match_en" @prim_subreg_18(clk_i: %3: i1, rst_ni: %4: i1, we: %337: i1, wd: %15: i8, de: %false: i1, d: %c0_i8: i8) -> (qe: i1, q: i8, ds: i8, qs: i8)
    llhd.drv %340, %u_adc_intr_ctl_match_en.q after %1 : i8
    llhd.drv %adc_intr_ctl_match_en_qs, %u_adc_intr_ctl_match_en.qs after %1 : i8
    %341 = llhd.sig.struct_extract %338["trans_en"] : <!hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>>
    %342 = llhd.sig.struct_extract %341["q"] : <!hw.struct<q: i1>>
    %u_adc_intr_ctl_trans_en.qe, %u_adc_intr_ctl_trans_en.q, %u_adc_intr_ctl_trans_en.ds, %u_adc_intr_ctl_trans_en.qs = hw.instance "u_adc_intr_ctl_trans_en" @prim_subreg_10(clk_i: %3: i1, rst_ni: %4: i1, we: %337: i1, wd: %528: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %342, %u_adc_intr_ctl_trans_en.q after %1 : i1
    llhd.drv %adc_intr_ctl_trans_en_qs, %u_adc_intr_ctl_trans_en.qs after %1 : i1
    %343 = llhd.sig.struct_extract %338["oneshot_en"] : <!hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>>
    %344 = llhd.sig.struct_extract %343["q"] : <!hw.struct<q: i1>>
    %u_adc_intr_ctl_oneshot_en.qe, %u_adc_intr_ctl_oneshot_en.q, %u_adc_intr_ctl_oneshot_en.ds, %u_adc_intr_ctl_oneshot_en.qs = hw.instance "u_adc_intr_ctl_oneshot_en" @prim_subreg_10(clk_i: %3: i1, rst_ni: %4: i1, we: %337: i1, wd: %529: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %344, %u_adc_intr_ctl_oneshot_en.q after %1 : i1
    llhd.drv %adc_intr_ctl_oneshot_en_qs, %u_adc_intr_ctl_oneshot_en.qs after %1 : i1
    %345 = llhd.prb %adc_intr_status_we : i1
    %adc_intr_status = hw.struct_extract %hw2reg["adc_intr_status"] : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, adc_chn_val: !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>, filter_status: !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_fsm_state: !hw.struct<d: i5>>
    %match_26 = hw.struct_extract %adc_intr_status["match"] : !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>
    %de_27 = hw.struct_extract %match_26["de"] : !hw.struct<d: i8, de: i1>
    %d_28 = hw.struct_extract %match_26["d"] : !hw.struct<d: i8, de: i1>
    %346 = llhd.sig.struct_extract %reg2hw["adc_intr_status"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>>
    %347 = llhd.sig.struct_extract %346["match"] : <!hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %348 = llhd.sig.struct_extract %347["q"] : <!hw.struct<q: i8>>
    %u_adc_intr_status_match.qe, %u_adc_intr_status_match.q, %u_adc_intr_status_match.ds, %u_adc_intr_status_match.qs = hw.instance "u_adc_intr_status_match" @prim_subreg_19(clk_i: %3: i1, rst_ni: %4: i1, we: %345: i1, wd: %15: i8, de: %de_27: i1, d: %d_28: i8) -> (qe: i1, q: i8, ds: i8, qs: i8)
    llhd.drv %348, %u_adc_intr_status_match.q after %1 : i8
    llhd.drv %adc_intr_status_match_qs, %u_adc_intr_status_match.qs after %1 : i8
    %trans_29 = hw.struct_extract %adc_intr_status["trans"] : !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>
    %de_30 = hw.struct_extract %trans_29["de"] : !hw.struct<d: i1, de: i1>
    %d_31 = hw.struct_extract %trans_29["d"] : !hw.struct<d: i1, de: i1>
    %349 = llhd.sig.struct_extract %346["trans"] : <!hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %350 = llhd.sig.struct_extract %349["q"] : <!hw.struct<q: i1>>
    %u_adc_intr_status_trans.qe, %u_adc_intr_status_trans.q, %u_adc_intr_status_trans.ds, %u_adc_intr_status_trans.qs = hw.instance "u_adc_intr_status_trans" @prim_subreg_20(clk_i: %3: i1, rst_ni: %4: i1, we: %345: i1, wd: %528: i1, de: %de_30: i1, d: %d_31: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %350, %u_adc_intr_status_trans.q after %1 : i1
    llhd.drv %adc_intr_status_trans_qs, %u_adc_intr_status_trans.qs after %1 : i1
    %oneshot = hw.struct_extract %adc_intr_status["oneshot"] : !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>
    %de_32 = hw.struct_extract %oneshot["de"] : !hw.struct<d: i1, de: i1>
    %d_33 = hw.struct_extract %oneshot["d"] : !hw.struct<d: i1, de: i1>
    %351 = llhd.sig.struct_extract %346["oneshot"] : <!hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %352 = llhd.sig.struct_extract %351["q"] : <!hw.struct<q: i1>>
    %u_adc_intr_status_oneshot.qe, %u_adc_intr_status_oneshot.q, %u_adc_intr_status_oneshot.ds, %u_adc_intr_status_oneshot.qs = hw.instance "u_adc_intr_status_oneshot" @prim_subreg_20(clk_i: %3: i1, rst_ni: %4: i1, we: %345: i1, wd: %529: i1, de: %de_32: i1, d: %d_33: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %352, %u_adc_intr_status_oneshot.q after %1 : i1
    llhd.drv %adc_intr_status_oneshot_qs, %u_adc_intr_status_oneshot.qs after %1 : i1
    %adc_fsm_state = hw.struct_extract %hw2reg["adc_fsm_state"] : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, adc_chn_val: !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>, filter_status: !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_fsm_state: !hw.struct<d: i5>>
    %d_34 = hw.struct_extract %adc_fsm_state["d"] : !hw.struct<d: i5>
    %u_adc_fsm_state.qe, %u_adc_fsm_state.qre, %u_adc_fsm_state.q, %u_adc_fsm_state.ds, %u_adc_fsm_state.qs = hw.instance "u_adc_fsm_state" @prim_subreg_ext_21(re: %u_adc_fsm_state_cdc.dst_re_o: i1, we: %false: i1, wd: %c0_i5: i5, d: %d_34: i5) -> (qe: i1, qre: i1, q: i5, ds: i5, qs: i5)
    llhd.drv %adc_fsm_state_flds_we, %u_adc_fsm_state.qe after %1 : i1
    llhd.drv %aon_adc_fsm_state_ds_int, %u_adc_fsm_state.ds after %1 : i5
    llhd.drv %aon_adc_fsm_state_qs_int, %u_adc_fsm_state.qs after %1 : i5
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %597 = llhd.prb %clk_i_0 : i1
      %598 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %599 = llhd.prb %clk_i_0 : i1
      %600 = comb.xor bin %597, %true : i1
      %601 = comb.and bin %600, %599 : i1
      %602 = llhd.prb %rst_ni_1 : i1
      %603 = comb.xor bin %602, %true : i1
      %604 = comb.and bin %598, %603 : i1
      %605 = comb.or bin %601, %604 : i1
      cf.cond_br %605, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %606 = llhd.prb %rst_ni_1 : i1
      %607 = comb.xor %606, %true : i1
      cf.cond_br %607, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %err_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %608 = llhd.prb %intg_err : i1
      %609 = llhd.prb %reg_we_err : i1
      %610 = comb.or %608, %609 : i1
      cf.cond_br %610, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %err_q, %true after %0 : i1
      cf.br ^bb1
    }
    %353 = llhd.prb %err_q : i1
    %354 = llhd.prb %intg_err : i1
    %355 = llhd.prb %reg_we_err : i1
    %356 = comb.or %353, %354, %355 : i1
    %357 = llhd.prb %reg_rdata_next {sv.namehint = "reg_rdata"} : i32
    %358 = llhd.prb %wr_err : i1
    %359 = comb.or %471, %358, %354 {sv.namehint = "reg_error"} : i1
    %360 = llhd.prb %aon_adc_en_ctl_adc_enable_qs_int : i1
    %361 = llhd.prb %aon_adc_en_ctl_oneshot_mode_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_en_ctl_qs, %c0_i2 after %1 : i2
      %597 = llhd.sig.extract %aon_adc_en_ctl_qs from %false : <i2> -> <i1>
      %598 = llhd.prb %aon_adc_en_ctl_adc_enable_qs_int : i1
      llhd.drv %597, %598 after %1 : i1
      %599 = llhd.sig.extract %aon_adc_en_ctl_qs from %true : <i2> -> <i1>
      %600 = llhd.prb %aon_adc_en_ctl_oneshot_mode_qs_int : i1
      llhd.drv %599, %600 after %1 : i1
      llhd.wait (%11, %360, %361 : i2, i1, i1), ^bb1
    }
    %362 = llhd.prb %aon_adc_pd_ctl_lp_mode_qs_int : i1
    %363 = llhd.prb %aon_adc_pd_ctl_pwrup_time_qs_int : i4
    %364 = llhd.prb %aon_adc_pd_ctl_wakeup_time_qs_int : i24
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_pd_ctl_qs, %c409712_i32 after %1 : i32
      %597 = llhd.sig.extract %aon_adc_pd_ctl_qs from %c0_i5 : <i32> -> <i1>
      %598 = llhd.prb %aon_adc_pd_ctl_lp_mode_qs_int : i1
      llhd.drv %597, %598 after %1 : i1
      %599 = llhd.sig.extract %aon_adc_pd_ctl_qs from %c4_i5 : <i32> -> <i4>
      %600 = llhd.prb %aon_adc_pd_ctl_pwrup_time_qs_int : i4
      llhd.drv %599, %600 after %1 : i4
      %601 = llhd.sig.extract %aon_adc_pd_ctl_qs from %c8_i5 : <i32> -> <i24>
      %602 = llhd.prb %aon_adc_pd_ctl_wakeup_time_qs_int : i24
      llhd.drv %601, %602 after %1 : i24
      llhd.wait (%13, %362, %363, %364 : i32, i1, i4, i24), ^bb1
    }
    %365 = llhd.prb %aon_adc_lp_sample_ctl_qs_int : i8
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_lp_sample_ctl_qs, %c4_i8 after %1 : i8
      %597 = llhd.prb %aon_adc_lp_sample_ctl_qs_int : i8
      llhd.drv %aon_adc_lp_sample_ctl_qs, %597 after %1 : i8
      llhd.wait (%16, %365 : i8, i8), ^bb1
    }
    %366 = llhd.prb %aon_adc_sample_ctl_qs_int : i16
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_sample_ctl_qs, %c155_i16 after %1 : i16
      %597 = llhd.prb %aon_adc_sample_ctl_qs_int : i16
      llhd.drv %aon_adc_sample_ctl_qs, %597 after %1 : i16
      llhd.wait (%19, %366 : i16, i16), ^bb1
    }
    %367 = llhd.prb %aon_adc_fsm_rst_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_fsm_rst_qs, %false after %1 : i1
      %597 = llhd.prb %aon_adc_fsm_rst_qs_int : i1
      llhd.drv %aon_adc_fsm_rst_qs, %597 after %1 : i1
      llhd.wait (%22, %367 : i1, i1), ^bb1
    }
    %368 = llhd.prb %aon_adc_chn0_filter_ctl_0_min_v_0_qs_int : i10
    %369 = llhd.prb %aon_adc_chn0_filter_ctl_0_cond_0_qs_int : i1
    %370 = llhd.prb %aon_adc_chn0_filter_ctl_0_max_v_0_qs_int : i10
    %371 = llhd.prb %aon_adc_chn0_filter_ctl_0_en_0_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_chn0_filter_ctl_0_qs, %c0_i32 after %1 : i32
      %597 = llhd.sig.extract %aon_adc_chn0_filter_ctl_0_qs from %c2_i5 : <i32> -> <i10>
      %598 = llhd.prb %aon_adc_chn0_filter_ctl_0_min_v_0_qs_int : i10
      llhd.drv %597, %598 after %1 : i10
      %599 = llhd.sig.extract %aon_adc_chn0_filter_ctl_0_qs from %c12_i5 : <i32> -> <i1>
      %600 = llhd.prb %aon_adc_chn0_filter_ctl_0_cond_0_qs_int : i1
      llhd.drv %599, %600 after %1 : i1
      %601 = llhd.sig.extract %aon_adc_chn0_filter_ctl_0_qs from %c-14_i5 : <i32> -> <i10>
      %602 = llhd.prb %aon_adc_chn0_filter_ctl_0_max_v_0_qs_int : i10
      llhd.drv %601, %602 after %1 : i10
      %603 = llhd.sig.extract %aon_adc_chn0_filter_ctl_0_qs from %c-1_i5 : <i32> -> <i1>
      %604 = llhd.prb %aon_adc_chn0_filter_ctl_0_en_0_qs_int : i1
      llhd.drv %603, %604 after %1 : i1
      llhd.wait (%24, %368, %369, %370, %371 : i32, i10, i1, i10, i1), ^bb1
    }
    %372 = llhd.prb %aon_adc_chn0_filter_ctl_1_min_v_1_qs_int : i10
    %373 = llhd.prb %aon_adc_chn0_filter_ctl_1_cond_1_qs_int : i1
    %374 = llhd.prb %aon_adc_chn0_filter_ctl_1_max_v_1_qs_int : i10
    %375 = llhd.prb %aon_adc_chn0_filter_ctl_1_en_1_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_chn0_filter_ctl_1_qs, %c0_i32 after %1 : i32
      %597 = llhd.sig.extract %aon_adc_chn0_filter_ctl_1_qs from %c2_i5 : <i32> -> <i10>
      %598 = llhd.prb %aon_adc_chn0_filter_ctl_1_min_v_1_qs_int : i10
      llhd.drv %597, %598 after %1 : i10
      %599 = llhd.sig.extract %aon_adc_chn0_filter_ctl_1_qs from %c12_i5 : <i32> -> <i1>
      %600 = llhd.prb %aon_adc_chn0_filter_ctl_1_cond_1_qs_int : i1
      llhd.drv %599, %600 after %1 : i1
      %601 = llhd.sig.extract %aon_adc_chn0_filter_ctl_1_qs from %c-14_i5 : <i32> -> <i10>
      %602 = llhd.prb %aon_adc_chn0_filter_ctl_1_max_v_1_qs_int : i10
      llhd.drv %601, %602 after %1 : i10
      %603 = llhd.sig.extract %aon_adc_chn0_filter_ctl_1_qs from %c-1_i5 : <i32> -> <i1>
      %604 = llhd.prb %aon_adc_chn0_filter_ctl_1_en_1_qs_int : i1
      llhd.drv %603, %604 after %1 : i1
      llhd.wait (%26, %372, %373, %374, %375 : i32, i10, i1, i10, i1), ^bb1
    }
    %376 = llhd.prb %aon_adc_chn0_filter_ctl_2_min_v_2_qs_int : i10
    %377 = llhd.prb %aon_adc_chn0_filter_ctl_2_cond_2_qs_int : i1
    %378 = llhd.prb %aon_adc_chn0_filter_ctl_2_max_v_2_qs_int : i10
    %379 = llhd.prb %aon_adc_chn0_filter_ctl_2_en_2_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_chn0_filter_ctl_2_qs, %c0_i32 after %1 : i32
      %597 = llhd.sig.extract %aon_adc_chn0_filter_ctl_2_qs from %c2_i5 : <i32> -> <i10>
      %598 = llhd.prb %aon_adc_chn0_filter_ctl_2_min_v_2_qs_int : i10
      llhd.drv %597, %598 after %1 : i10
      %599 = llhd.sig.extract %aon_adc_chn0_filter_ctl_2_qs from %c12_i5 : <i32> -> <i1>
      %600 = llhd.prb %aon_adc_chn0_filter_ctl_2_cond_2_qs_int : i1
      llhd.drv %599, %600 after %1 : i1
      %601 = llhd.sig.extract %aon_adc_chn0_filter_ctl_2_qs from %c-14_i5 : <i32> -> <i10>
      %602 = llhd.prb %aon_adc_chn0_filter_ctl_2_max_v_2_qs_int : i10
      llhd.drv %601, %602 after %1 : i10
      %603 = llhd.sig.extract %aon_adc_chn0_filter_ctl_2_qs from %c-1_i5 : <i32> -> <i1>
      %604 = llhd.prb %aon_adc_chn0_filter_ctl_2_en_2_qs_int : i1
      llhd.drv %603, %604 after %1 : i1
      llhd.wait (%28, %376, %377, %378, %379 : i32, i10, i1, i10, i1), ^bb1
    }
    %380 = llhd.prb %aon_adc_chn0_filter_ctl_3_min_v_3_qs_int : i10
    %381 = llhd.prb %aon_adc_chn0_filter_ctl_3_cond_3_qs_int : i1
    %382 = llhd.prb %aon_adc_chn0_filter_ctl_3_max_v_3_qs_int : i10
    %383 = llhd.prb %aon_adc_chn0_filter_ctl_3_en_3_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_chn0_filter_ctl_3_qs, %c0_i32 after %1 : i32
      %597 = llhd.sig.extract %aon_adc_chn0_filter_ctl_3_qs from %c2_i5 : <i32> -> <i10>
      %598 = llhd.prb %aon_adc_chn0_filter_ctl_3_min_v_3_qs_int : i10
      llhd.drv %597, %598 after %1 : i10
      %599 = llhd.sig.extract %aon_adc_chn0_filter_ctl_3_qs from %c12_i5 : <i32> -> <i1>
      %600 = llhd.prb %aon_adc_chn0_filter_ctl_3_cond_3_qs_int : i1
      llhd.drv %599, %600 after %1 : i1
      %601 = llhd.sig.extract %aon_adc_chn0_filter_ctl_3_qs from %c-14_i5 : <i32> -> <i10>
      %602 = llhd.prb %aon_adc_chn0_filter_ctl_3_max_v_3_qs_int : i10
      llhd.drv %601, %602 after %1 : i10
      %603 = llhd.sig.extract %aon_adc_chn0_filter_ctl_3_qs from %c-1_i5 : <i32> -> <i1>
      %604 = llhd.prb %aon_adc_chn0_filter_ctl_3_en_3_qs_int : i1
      llhd.drv %603, %604 after %1 : i1
      llhd.wait (%30, %380, %381, %382, %383 : i32, i10, i1, i10, i1), ^bb1
    }
    %384 = llhd.prb %aon_adc_chn0_filter_ctl_4_min_v_4_qs_int : i10
    %385 = llhd.prb %aon_adc_chn0_filter_ctl_4_cond_4_qs_int : i1
    %386 = llhd.prb %aon_adc_chn0_filter_ctl_4_max_v_4_qs_int : i10
    %387 = llhd.prb %aon_adc_chn0_filter_ctl_4_en_4_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_chn0_filter_ctl_4_qs, %c0_i32 after %1 : i32
      %597 = llhd.sig.extract %aon_adc_chn0_filter_ctl_4_qs from %c2_i5 : <i32> -> <i10>
      %598 = llhd.prb %aon_adc_chn0_filter_ctl_4_min_v_4_qs_int : i10
      llhd.drv %597, %598 after %1 : i10
      %599 = llhd.sig.extract %aon_adc_chn0_filter_ctl_4_qs from %c12_i5 : <i32> -> <i1>
      %600 = llhd.prb %aon_adc_chn0_filter_ctl_4_cond_4_qs_int : i1
      llhd.drv %599, %600 after %1 : i1
      %601 = llhd.sig.extract %aon_adc_chn0_filter_ctl_4_qs from %c-14_i5 : <i32> -> <i10>
      %602 = llhd.prb %aon_adc_chn0_filter_ctl_4_max_v_4_qs_int : i10
      llhd.drv %601, %602 after %1 : i10
      %603 = llhd.sig.extract %aon_adc_chn0_filter_ctl_4_qs from %c-1_i5 : <i32> -> <i1>
      %604 = llhd.prb %aon_adc_chn0_filter_ctl_4_en_4_qs_int : i1
      llhd.drv %603, %604 after %1 : i1
      llhd.wait (%32, %384, %385, %386, %387 : i32, i10, i1, i10, i1), ^bb1
    }
    %388 = llhd.prb %aon_adc_chn0_filter_ctl_5_min_v_5_qs_int : i10
    %389 = llhd.prb %aon_adc_chn0_filter_ctl_5_cond_5_qs_int : i1
    %390 = llhd.prb %aon_adc_chn0_filter_ctl_5_max_v_5_qs_int : i10
    %391 = llhd.prb %aon_adc_chn0_filter_ctl_5_en_5_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_chn0_filter_ctl_5_qs, %c0_i32 after %1 : i32
      %597 = llhd.sig.extract %aon_adc_chn0_filter_ctl_5_qs from %c2_i5 : <i32> -> <i10>
      %598 = llhd.prb %aon_adc_chn0_filter_ctl_5_min_v_5_qs_int : i10
      llhd.drv %597, %598 after %1 : i10
      %599 = llhd.sig.extract %aon_adc_chn0_filter_ctl_5_qs from %c12_i5 : <i32> -> <i1>
      %600 = llhd.prb %aon_adc_chn0_filter_ctl_5_cond_5_qs_int : i1
      llhd.drv %599, %600 after %1 : i1
      %601 = llhd.sig.extract %aon_adc_chn0_filter_ctl_5_qs from %c-14_i5 : <i32> -> <i10>
      %602 = llhd.prb %aon_adc_chn0_filter_ctl_5_max_v_5_qs_int : i10
      llhd.drv %601, %602 after %1 : i10
      %603 = llhd.sig.extract %aon_adc_chn0_filter_ctl_5_qs from %c-1_i5 : <i32> -> <i1>
      %604 = llhd.prb %aon_adc_chn0_filter_ctl_5_en_5_qs_int : i1
      llhd.drv %603, %604 after %1 : i1
      llhd.wait (%34, %388, %389, %390, %391 : i32, i10, i1, i10, i1), ^bb1
    }
    %392 = llhd.prb %aon_adc_chn0_filter_ctl_6_min_v_6_qs_int : i10
    %393 = llhd.prb %aon_adc_chn0_filter_ctl_6_cond_6_qs_int : i1
    %394 = llhd.prb %aon_adc_chn0_filter_ctl_6_max_v_6_qs_int : i10
    %395 = llhd.prb %aon_adc_chn0_filter_ctl_6_en_6_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_chn0_filter_ctl_6_qs, %c0_i32 after %1 : i32
      %597 = llhd.sig.extract %aon_adc_chn0_filter_ctl_6_qs from %c2_i5 : <i32> -> <i10>
      %598 = llhd.prb %aon_adc_chn0_filter_ctl_6_min_v_6_qs_int : i10
      llhd.drv %597, %598 after %1 : i10
      %599 = llhd.sig.extract %aon_adc_chn0_filter_ctl_6_qs from %c12_i5 : <i32> -> <i1>
      %600 = llhd.prb %aon_adc_chn0_filter_ctl_6_cond_6_qs_int : i1
      llhd.drv %599, %600 after %1 : i1
      %601 = llhd.sig.extract %aon_adc_chn0_filter_ctl_6_qs from %c-14_i5 : <i32> -> <i10>
      %602 = llhd.prb %aon_adc_chn0_filter_ctl_6_max_v_6_qs_int : i10
      llhd.drv %601, %602 after %1 : i10
      %603 = llhd.sig.extract %aon_adc_chn0_filter_ctl_6_qs from %c-1_i5 : <i32> -> <i1>
      %604 = llhd.prb %aon_adc_chn0_filter_ctl_6_en_6_qs_int : i1
      llhd.drv %603, %604 after %1 : i1
      llhd.wait (%36, %392, %393, %394, %395 : i32, i10, i1, i10, i1), ^bb1
    }
    %396 = llhd.prb %aon_adc_chn0_filter_ctl_7_min_v_7_qs_int : i10
    %397 = llhd.prb %aon_adc_chn0_filter_ctl_7_cond_7_qs_int : i1
    %398 = llhd.prb %aon_adc_chn0_filter_ctl_7_max_v_7_qs_int : i10
    %399 = llhd.prb %aon_adc_chn0_filter_ctl_7_en_7_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_chn0_filter_ctl_7_qs, %c0_i32 after %1 : i32
      %597 = llhd.sig.extract %aon_adc_chn0_filter_ctl_7_qs from %c2_i5 : <i32> -> <i10>
      %598 = llhd.prb %aon_adc_chn0_filter_ctl_7_min_v_7_qs_int : i10
      llhd.drv %597, %598 after %1 : i10
      %599 = llhd.sig.extract %aon_adc_chn0_filter_ctl_7_qs from %c12_i5 : <i32> -> <i1>
      %600 = llhd.prb %aon_adc_chn0_filter_ctl_7_cond_7_qs_int : i1
      llhd.drv %599, %600 after %1 : i1
      %601 = llhd.sig.extract %aon_adc_chn0_filter_ctl_7_qs from %c-14_i5 : <i32> -> <i10>
      %602 = llhd.prb %aon_adc_chn0_filter_ctl_7_max_v_7_qs_int : i10
      llhd.drv %601, %602 after %1 : i10
      %603 = llhd.sig.extract %aon_adc_chn0_filter_ctl_7_qs from %c-1_i5 : <i32> -> <i1>
      %604 = llhd.prb %aon_adc_chn0_filter_ctl_7_en_7_qs_int : i1
      llhd.drv %603, %604 after %1 : i1
      llhd.wait (%38, %396, %397, %398, %399 : i32, i10, i1, i10, i1), ^bb1
    }
    %400 = llhd.prb %aon_adc_chn1_filter_ctl_0_min_v_0_qs_int : i10
    %401 = llhd.prb %aon_adc_chn1_filter_ctl_0_cond_0_qs_int : i1
    %402 = llhd.prb %aon_adc_chn1_filter_ctl_0_max_v_0_qs_int : i10
    %403 = llhd.prb %aon_adc_chn1_filter_ctl_0_en_0_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_chn1_filter_ctl_0_qs, %c0_i32 after %1 : i32
      %597 = llhd.sig.extract %aon_adc_chn1_filter_ctl_0_qs from %c2_i5 : <i32> -> <i10>
      %598 = llhd.prb %aon_adc_chn1_filter_ctl_0_min_v_0_qs_int : i10
      llhd.drv %597, %598 after %1 : i10
      %599 = llhd.sig.extract %aon_adc_chn1_filter_ctl_0_qs from %c12_i5 : <i32> -> <i1>
      %600 = llhd.prb %aon_adc_chn1_filter_ctl_0_cond_0_qs_int : i1
      llhd.drv %599, %600 after %1 : i1
      %601 = llhd.sig.extract %aon_adc_chn1_filter_ctl_0_qs from %c-14_i5 : <i32> -> <i10>
      %602 = llhd.prb %aon_adc_chn1_filter_ctl_0_max_v_0_qs_int : i10
      llhd.drv %601, %602 after %1 : i10
      %603 = llhd.sig.extract %aon_adc_chn1_filter_ctl_0_qs from %c-1_i5 : <i32> -> <i1>
      %604 = llhd.prb %aon_adc_chn1_filter_ctl_0_en_0_qs_int : i1
      llhd.drv %603, %604 after %1 : i1
      llhd.wait (%40, %400, %401, %402, %403 : i32, i10, i1, i10, i1), ^bb1
    }
    %404 = llhd.prb %aon_adc_chn1_filter_ctl_1_min_v_1_qs_int : i10
    %405 = llhd.prb %aon_adc_chn1_filter_ctl_1_cond_1_qs_int : i1
    %406 = llhd.prb %aon_adc_chn1_filter_ctl_1_max_v_1_qs_int : i10
    %407 = llhd.prb %aon_adc_chn1_filter_ctl_1_en_1_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_chn1_filter_ctl_1_qs, %c0_i32 after %1 : i32
      %597 = llhd.sig.extract %aon_adc_chn1_filter_ctl_1_qs from %c2_i5 : <i32> -> <i10>
      %598 = llhd.prb %aon_adc_chn1_filter_ctl_1_min_v_1_qs_int : i10
      llhd.drv %597, %598 after %1 : i10
      %599 = llhd.sig.extract %aon_adc_chn1_filter_ctl_1_qs from %c12_i5 : <i32> -> <i1>
      %600 = llhd.prb %aon_adc_chn1_filter_ctl_1_cond_1_qs_int : i1
      llhd.drv %599, %600 after %1 : i1
      %601 = llhd.sig.extract %aon_adc_chn1_filter_ctl_1_qs from %c-14_i5 : <i32> -> <i10>
      %602 = llhd.prb %aon_adc_chn1_filter_ctl_1_max_v_1_qs_int : i10
      llhd.drv %601, %602 after %1 : i10
      %603 = llhd.sig.extract %aon_adc_chn1_filter_ctl_1_qs from %c-1_i5 : <i32> -> <i1>
      %604 = llhd.prb %aon_adc_chn1_filter_ctl_1_en_1_qs_int : i1
      llhd.drv %603, %604 after %1 : i1
      llhd.wait (%42, %404, %405, %406, %407 : i32, i10, i1, i10, i1), ^bb1
    }
    %408 = llhd.prb %aon_adc_chn1_filter_ctl_2_min_v_2_qs_int : i10
    %409 = llhd.prb %aon_adc_chn1_filter_ctl_2_cond_2_qs_int : i1
    %410 = llhd.prb %aon_adc_chn1_filter_ctl_2_max_v_2_qs_int : i10
    %411 = llhd.prb %aon_adc_chn1_filter_ctl_2_en_2_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_chn1_filter_ctl_2_qs, %c0_i32 after %1 : i32
      %597 = llhd.sig.extract %aon_adc_chn1_filter_ctl_2_qs from %c2_i5 : <i32> -> <i10>
      %598 = llhd.prb %aon_adc_chn1_filter_ctl_2_min_v_2_qs_int : i10
      llhd.drv %597, %598 after %1 : i10
      %599 = llhd.sig.extract %aon_adc_chn1_filter_ctl_2_qs from %c12_i5 : <i32> -> <i1>
      %600 = llhd.prb %aon_adc_chn1_filter_ctl_2_cond_2_qs_int : i1
      llhd.drv %599, %600 after %1 : i1
      %601 = llhd.sig.extract %aon_adc_chn1_filter_ctl_2_qs from %c-14_i5 : <i32> -> <i10>
      %602 = llhd.prb %aon_adc_chn1_filter_ctl_2_max_v_2_qs_int : i10
      llhd.drv %601, %602 after %1 : i10
      %603 = llhd.sig.extract %aon_adc_chn1_filter_ctl_2_qs from %c-1_i5 : <i32> -> <i1>
      %604 = llhd.prb %aon_adc_chn1_filter_ctl_2_en_2_qs_int : i1
      llhd.drv %603, %604 after %1 : i1
      llhd.wait (%44, %408, %409, %410, %411 : i32, i10, i1, i10, i1), ^bb1
    }
    %412 = llhd.prb %aon_adc_chn1_filter_ctl_3_min_v_3_qs_int : i10
    %413 = llhd.prb %aon_adc_chn1_filter_ctl_3_cond_3_qs_int : i1
    %414 = llhd.prb %aon_adc_chn1_filter_ctl_3_max_v_3_qs_int : i10
    %415 = llhd.prb %aon_adc_chn1_filter_ctl_3_en_3_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_chn1_filter_ctl_3_qs, %c0_i32 after %1 : i32
      %597 = llhd.sig.extract %aon_adc_chn1_filter_ctl_3_qs from %c2_i5 : <i32> -> <i10>
      %598 = llhd.prb %aon_adc_chn1_filter_ctl_3_min_v_3_qs_int : i10
      llhd.drv %597, %598 after %1 : i10
      %599 = llhd.sig.extract %aon_adc_chn1_filter_ctl_3_qs from %c12_i5 : <i32> -> <i1>
      %600 = llhd.prb %aon_adc_chn1_filter_ctl_3_cond_3_qs_int : i1
      llhd.drv %599, %600 after %1 : i1
      %601 = llhd.sig.extract %aon_adc_chn1_filter_ctl_3_qs from %c-14_i5 : <i32> -> <i10>
      %602 = llhd.prb %aon_adc_chn1_filter_ctl_3_max_v_3_qs_int : i10
      llhd.drv %601, %602 after %1 : i10
      %603 = llhd.sig.extract %aon_adc_chn1_filter_ctl_3_qs from %c-1_i5 : <i32> -> <i1>
      %604 = llhd.prb %aon_adc_chn1_filter_ctl_3_en_3_qs_int : i1
      llhd.drv %603, %604 after %1 : i1
      llhd.wait (%46, %412, %413, %414, %415 : i32, i10, i1, i10, i1), ^bb1
    }
    %416 = llhd.prb %aon_adc_chn1_filter_ctl_4_min_v_4_qs_int : i10
    %417 = llhd.prb %aon_adc_chn1_filter_ctl_4_cond_4_qs_int : i1
    %418 = llhd.prb %aon_adc_chn1_filter_ctl_4_max_v_4_qs_int : i10
    %419 = llhd.prb %aon_adc_chn1_filter_ctl_4_en_4_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_chn1_filter_ctl_4_qs, %c0_i32 after %1 : i32
      %597 = llhd.sig.extract %aon_adc_chn1_filter_ctl_4_qs from %c2_i5 : <i32> -> <i10>
      %598 = llhd.prb %aon_adc_chn1_filter_ctl_4_min_v_4_qs_int : i10
      llhd.drv %597, %598 after %1 : i10
      %599 = llhd.sig.extract %aon_adc_chn1_filter_ctl_4_qs from %c12_i5 : <i32> -> <i1>
      %600 = llhd.prb %aon_adc_chn1_filter_ctl_4_cond_4_qs_int : i1
      llhd.drv %599, %600 after %1 : i1
      %601 = llhd.sig.extract %aon_adc_chn1_filter_ctl_4_qs from %c-14_i5 : <i32> -> <i10>
      %602 = llhd.prb %aon_adc_chn1_filter_ctl_4_max_v_4_qs_int : i10
      llhd.drv %601, %602 after %1 : i10
      %603 = llhd.sig.extract %aon_adc_chn1_filter_ctl_4_qs from %c-1_i5 : <i32> -> <i1>
      %604 = llhd.prb %aon_adc_chn1_filter_ctl_4_en_4_qs_int : i1
      llhd.drv %603, %604 after %1 : i1
      llhd.wait (%48, %416, %417, %418, %419 : i32, i10, i1, i10, i1), ^bb1
    }
    %420 = llhd.prb %aon_adc_chn1_filter_ctl_5_min_v_5_qs_int : i10
    %421 = llhd.prb %aon_adc_chn1_filter_ctl_5_cond_5_qs_int : i1
    %422 = llhd.prb %aon_adc_chn1_filter_ctl_5_max_v_5_qs_int : i10
    %423 = llhd.prb %aon_adc_chn1_filter_ctl_5_en_5_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_chn1_filter_ctl_5_qs, %c0_i32 after %1 : i32
      %597 = llhd.sig.extract %aon_adc_chn1_filter_ctl_5_qs from %c2_i5 : <i32> -> <i10>
      %598 = llhd.prb %aon_adc_chn1_filter_ctl_5_min_v_5_qs_int : i10
      llhd.drv %597, %598 after %1 : i10
      %599 = llhd.sig.extract %aon_adc_chn1_filter_ctl_5_qs from %c12_i5 : <i32> -> <i1>
      %600 = llhd.prb %aon_adc_chn1_filter_ctl_5_cond_5_qs_int : i1
      llhd.drv %599, %600 after %1 : i1
      %601 = llhd.sig.extract %aon_adc_chn1_filter_ctl_5_qs from %c-14_i5 : <i32> -> <i10>
      %602 = llhd.prb %aon_adc_chn1_filter_ctl_5_max_v_5_qs_int : i10
      llhd.drv %601, %602 after %1 : i10
      %603 = llhd.sig.extract %aon_adc_chn1_filter_ctl_5_qs from %c-1_i5 : <i32> -> <i1>
      %604 = llhd.prb %aon_adc_chn1_filter_ctl_5_en_5_qs_int : i1
      llhd.drv %603, %604 after %1 : i1
      llhd.wait (%50, %420, %421, %422, %423 : i32, i10, i1, i10, i1), ^bb1
    }
    %424 = llhd.prb %aon_adc_chn1_filter_ctl_6_min_v_6_qs_int : i10
    %425 = llhd.prb %aon_adc_chn1_filter_ctl_6_cond_6_qs_int : i1
    %426 = llhd.prb %aon_adc_chn1_filter_ctl_6_max_v_6_qs_int : i10
    %427 = llhd.prb %aon_adc_chn1_filter_ctl_6_en_6_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_chn1_filter_ctl_6_qs, %c0_i32 after %1 : i32
      %597 = llhd.sig.extract %aon_adc_chn1_filter_ctl_6_qs from %c2_i5 : <i32> -> <i10>
      %598 = llhd.prb %aon_adc_chn1_filter_ctl_6_min_v_6_qs_int : i10
      llhd.drv %597, %598 after %1 : i10
      %599 = llhd.sig.extract %aon_adc_chn1_filter_ctl_6_qs from %c12_i5 : <i32> -> <i1>
      %600 = llhd.prb %aon_adc_chn1_filter_ctl_6_cond_6_qs_int : i1
      llhd.drv %599, %600 after %1 : i1
      %601 = llhd.sig.extract %aon_adc_chn1_filter_ctl_6_qs from %c-14_i5 : <i32> -> <i10>
      %602 = llhd.prb %aon_adc_chn1_filter_ctl_6_max_v_6_qs_int : i10
      llhd.drv %601, %602 after %1 : i10
      %603 = llhd.sig.extract %aon_adc_chn1_filter_ctl_6_qs from %c-1_i5 : <i32> -> <i1>
      %604 = llhd.prb %aon_adc_chn1_filter_ctl_6_en_6_qs_int : i1
      llhd.drv %603, %604 after %1 : i1
      llhd.wait (%52, %424, %425, %426, %427 : i32, i10, i1, i10, i1), ^bb1
    }
    %428 = llhd.prb %aon_adc_chn1_filter_ctl_7_min_v_7_qs_int : i10
    %429 = llhd.prb %aon_adc_chn1_filter_ctl_7_cond_7_qs_int : i1
    %430 = llhd.prb %aon_adc_chn1_filter_ctl_7_max_v_7_qs_int : i10
    %431 = llhd.prb %aon_adc_chn1_filter_ctl_7_en_7_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_chn1_filter_ctl_7_qs, %c0_i32 after %1 : i32
      %597 = llhd.sig.extract %aon_adc_chn1_filter_ctl_7_qs from %c2_i5 : <i32> -> <i10>
      %598 = llhd.prb %aon_adc_chn1_filter_ctl_7_min_v_7_qs_int : i10
      llhd.drv %597, %598 after %1 : i10
      %599 = llhd.sig.extract %aon_adc_chn1_filter_ctl_7_qs from %c12_i5 : <i32> -> <i1>
      %600 = llhd.prb %aon_adc_chn1_filter_ctl_7_cond_7_qs_int : i1
      llhd.drv %599, %600 after %1 : i1
      %601 = llhd.sig.extract %aon_adc_chn1_filter_ctl_7_qs from %c-14_i5 : <i32> -> <i10>
      %602 = llhd.prb %aon_adc_chn1_filter_ctl_7_max_v_7_qs_int : i10
      llhd.drv %601, %602 after %1 : i10
      %603 = llhd.sig.extract %aon_adc_chn1_filter_ctl_7_qs from %c-1_i5 : <i32> -> <i1>
      %604 = llhd.prb %aon_adc_chn1_filter_ctl_7_en_7_qs_int : i1
      llhd.drv %603, %604 after %1 : i1
      llhd.wait (%54, %428, %429, %430, %431 : i32, i10, i1, i10, i1), ^bb1
    }
    %432 = llhd.prb %aon_adc_chn_val_0_adc_chn_value_ext_0_ds_int : i2
    %433 = llhd.prb %aon_adc_chn_val_0_adc_chn_value_ext_0_qs_int : i2
    %434 = llhd.prb %aon_adc_chn_val_0_adc_chn_value_0_ds_int : i10
    %435 = llhd.prb %aon_adc_chn_val_0_adc_chn_value_0_qs_int : i10
    %436 = llhd.prb %aon_adc_chn_val_0_adc_chn_value_intr_ext_0_ds_int : i2
    %437 = llhd.prb %aon_adc_chn_val_0_adc_chn_value_intr_ext_0_qs_int : i2
    %438 = llhd.prb %aon_adc_chn_val_0_adc_chn_value_intr_0_ds_int : i10
    %439 = llhd.prb %aon_adc_chn_val_0_adc_chn_value_intr_0_qs_int : i10
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_chn_val_0_qs, %c0_i28 after %1 : i28
      llhd.drv %aon_adc_chn_val_0_ds, %c0_i28 after %1 : i28
      %597 = llhd.sig.extract %aon_adc_chn_val_0_ds from %c0_i5 : <i28> -> <i2>
      %598 = llhd.prb %aon_adc_chn_val_0_adc_chn_value_ext_0_ds_int : i2
      llhd.drv %597, %598 after %1 : i2
      %599 = llhd.sig.extract %aon_adc_chn_val_0_qs from %c0_i5 : <i28> -> <i2>
      %600 = llhd.prb %aon_adc_chn_val_0_adc_chn_value_ext_0_qs_int : i2
      llhd.drv %599, %600 after %1 : i2
      %601 = llhd.sig.extract %aon_adc_chn_val_0_ds from %c2_i5 : <i28> -> <i10>
      %602 = llhd.prb %aon_adc_chn_val_0_adc_chn_value_0_ds_int : i10
      llhd.drv %601, %602 after %1 : i10
      %603 = llhd.sig.extract %aon_adc_chn_val_0_qs from %c2_i5 : <i28> -> <i10>
      %604 = llhd.prb %aon_adc_chn_val_0_adc_chn_value_0_qs_int : i10
      llhd.drv %603, %604 after %1 : i10
      %605 = llhd.sig.extract %aon_adc_chn_val_0_ds from %c-16_i5 : <i28> -> <i2>
      %606 = llhd.prb %aon_adc_chn_val_0_adc_chn_value_intr_ext_0_ds_int : i2
      llhd.drv %605, %606 after %1 : i2
      %607 = llhd.sig.extract %aon_adc_chn_val_0_qs from %c-16_i5 : <i28> -> <i2>
      %608 = llhd.prb %aon_adc_chn_val_0_adc_chn_value_intr_ext_0_qs_int : i2
      llhd.drv %607, %608 after %1 : i2
      %609 = llhd.sig.extract %aon_adc_chn_val_0_ds from %c-14_i5 : <i28> -> <i10>
      %610 = llhd.prb %aon_adc_chn_val_0_adc_chn_value_intr_0_ds_int : i10
      llhd.drv %609, %610 after %1 : i10
      %611 = llhd.sig.extract %aon_adc_chn_val_0_qs from %c-14_i5 : <i28> -> <i10>
      %612 = llhd.prb %aon_adc_chn_val_0_adc_chn_value_intr_0_qs_int : i10
      llhd.drv %611, %612 after %1 : i10
      llhd.wait (%56, %55, %432, %433, %434, %435, %436, %437, %438, %439 : i28, i28, i2, i2, i10, i10, i2, i2, i10, i10), ^bb1
    }
    %440 = llhd.prb %aon_adc_chn_val_1_adc_chn_value_ext_1_ds_int : i2
    %441 = llhd.prb %aon_adc_chn_val_1_adc_chn_value_ext_1_qs_int : i2
    %442 = llhd.prb %aon_adc_chn_val_1_adc_chn_value_1_ds_int : i10
    %443 = llhd.prb %aon_adc_chn_val_1_adc_chn_value_1_qs_int : i10
    %444 = llhd.prb %aon_adc_chn_val_1_adc_chn_value_intr_ext_1_ds_int : i2
    %445 = llhd.prb %aon_adc_chn_val_1_adc_chn_value_intr_ext_1_qs_int : i2
    %446 = llhd.prb %aon_adc_chn_val_1_adc_chn_value_intr_1_ds_int : i10
    %447 = llhd.prb %aon_adc_chn_val_1_adc_chn_value_intr_1_qs_int : i10
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_chn_val_1_qs, %c0_i28 after %1 : i28
      llhd.drv %aon_adc_chn_val_1_ds, %c0_i28 after %1 : i28
      %597 = llhd.sig.extract %aon_adc_chn_val_1_ds from %c0_i5 : <i28> -> <i2>
      %598 = llhd.prb %aon_adc_chn_val_1_adc_chn_value_ext_1_ds_int : i2
      llhd.drv %597, %598 after %1 : i2
      %599 = llhd.sig.extract %aon_adc_chn_val_1_qs from %c0_i5 : <i28> -> <i2>
      %600 = llhd.prb %aon_adc_chn_val_1_adc_chn_value_ext_1_qs_int : i2
      llhd.drv %599, %600 after %1 : i2
      %601 = llhd.sig.extract %aon_adc_chn_val_1_ds from %c2_i5 : <i28> -> <i10>
      %602 = llhd.prb %aon_adc_chn_val_1_adc_chn_value_1_ds_int : i10
      llhd.drv %601, %602 after %1 : i10
      %603 = llhd.sig.extract %aon_adc_chn_val_1_qs from %c2_i5 : <i28> -> <i10>
      %604 = llhd.prb %aon_adc_chn_val_1_adc_chn_value_1_qs_int : i10
      llhd.drv %603, %604 after %1 : i10
      %605 = llhd.sig.extract %aon_adc_chn_val_1_ds from %c-16_i5 : <i28> -> <i2>
      %606 = llhd.prb %aon_adc_chn_val_1_adc_chn_value_intr_ext_1_ds_int : i2
      llhd.drv %605, %606 after %1 : i2
      %607 = llhd.sig.extract %aon_adc_chn_val_1_qs from %c-16_i5 : <i28> -> <i2>
      %608 = llhd.prb %aon_adc_chn_val_1_adc_chn_value_intr_ext_1_qs_int : i2
      llhd.drv %607, %608 after %1 : i2
      %609 = llhd.sig.extract %aon_adc_chn_val_1_ds from %c-14_i5 : <i28> -> <i10>
      %610 = llhd.prb %aon_adc_chn_val_1_adc_chn_value_intr_1_ds_int : i10
      llhd.drv %609, %610 after %1 : i10
      %611 = llhd.sig.extract %aon_adc_chn_val_1_qs from %c-14_i5 : <i28> -> <i10>
      %612 = llhd.prb %aon_adc_chn_val_1_adc_chn_value_intr_1_qs_int : i10
      llhd.drv %611, %612 after %1 : i10
      llhd.wait (%58, %57, %440, %441, %442, %443, %444, %445, %446, %447 : i28, i28, i2, i2, i10, i10, i2, i2, i10, i10), ^bb1
    }
    %448 = llhd.prb %aon_adc_wakeup_ctl_match_en_qs_int : i8
    %449 = llhd.prb %aon_adc_wakeup_ctl_trans_en_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_wakeup_ctl_qs, %c0_i9 after %1 : i9
      %597 = llhd.sig.extract %aon_adc_wakeup_ctl_qs from %c0_i4 : <i9> -> <i8>
      %598 = llhd.prb %aon_adc_wakeup_ctl_match_en_qs_int : i8
      llhd.drv %597, %598 after %1 : i8
      %599 = llhd.sig.extract %aon_adc_wakeup_ctl_qs from %c-8_i4 : <i9> -> <i1>
      %600 = llhd.prb %aon_adc_wakeup_ctl_trans_en_qs_int : i1
      llhd.drv %599, %600 after %1 : i1
      llhd.wait (%61, %448, %449 : i9, i8, i1), ^bb1
    }
    %450 = llhd.prb %aon_filter_status_match_ds_int : i8
    %451 = llhd.prb %aon_filter_status_match_qs_int : i8
    %452 = llhd.prb %aon_filter_status_trans_ds_int : i1
    %453 = llhd.prb %aon_filter_status_trans_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_filter_status_qs, %c0_i9 after %1 : i9
      llhd.drv %aon_filter_status_ds, %c0_i9 after %1 : i9
      %597 = llhd.sig.extract %aon_filter_status_ds from %c0_i4 : <i9> -> <i8>
      %598 = llhd.prb %aon_filter_status_match_ds_int : i8
      llhd.drv %597, %598 after %1 : i8
      %599 = llhd.sig.extract %aon_filter_status_qs from %c0_i4 : <i9> -> <i8>
      %600 = llhd.prb %aon_filter_status_match_qs_int : i8
      llhd.drv %599, %600 after %1 : i8
      %601 = llhd.sig.extract %aon_filter_status_ds from %c-8_i4 : <i9> -> <i1>
      %602 = llhd.prb %aon_filter_status_trans_ds_int : i1
      llhd.drv %601, %602 after %1 : i1
      %603 = llhd.sig.extract %aon_filter_status_qs from %c-8_i4 : <i9> -> <i1>
      %604 = llhd.prb %aon_filter_status_trans_qs_int : i1
      llhd.drv %603, %604 after %1 : i1
      llhd.wait (%64, %63, %450, %451, %452, %453 : i9, i9, i8, i8, i1, i1), ^bb1
    }
    %454 = llhd.prb %aon_adc_fsm_state_ds_int : i5
    %455 = llhd.prb %aon_adc_fsm_state_qs_int : i5
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_adc_fsm_state_qs, %c0_i5 after %1 : i5
      llhd.drv %aon_adc_fsm_state_ds, %c0_i5 after %1 : i5
      %597 = llhd.prb %aon_adc_fsm_state_ds_int : i5
      llhd.drv %aon_adc_fsm_state_ds, %597 after %1 : i5
      %598 = llhd.prb %aon_adc_fsm_state_qs_int : i5
      llhd.drv %aon_adc_fsm_state_qs, %598 after %1 : i5
      llhd.wait (%66, %65, %454, %455 : i5, i5, i5, i5), ^bb1
    }
    %456 = llhd.prb %intr_test_flds_we {sv.namehint = "intr_test_qe"} : i1
    %457 = llhd.sig.struct_extract %73["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %457, %456 after %1 : i1
    %458 = llhd.prb %alert_test_flds_we {sv.namehint = "alert_test_qe"} : i1
    %459 = llhd.sig.struct_extract %76["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %459, %458 after %1 : i1
    %460 = llhd.prb %adc_chn_val_0_flds_we : i4
    %461 = comb.icmp ne %460, %c0_i4 {sv.namehint = "aon_adc_chn_val_0_qe"} : i4
    %462 = llhd.prb %adc_chn_val_1_flds_we : i4
    %463 = comb.icmp ne %462, %c0_i4 {sv.namehint = "aon_adc_chn_val_1_qe"} : i4
    %464 = llhd.prb %filter_status_flds_we : i2
    %465 = comb.icmp ne %464, %c0_i2 {sv.namehint = "aon_filter_status_qe"} : i2
    %466 = llhd.prb %adc_fsm_state_flds_we {sv.namehint = "aon_adc_fsm_state_qe"} : i1
    %467 = llhd.prb %addr_hit : i32
    %468 = llhd.prb %reg_addr : i7
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %597 = llhd.sig.extract %addr_hit from %c0_i5 : <i32> -> <i1>
      %598 = llhd.prb %reg_addr : i7
      %599 = comb.icmp eq %598, %c0_i7 : i7
      llhd.drv %597, %599 after %1 : i1
      %600 = llhd.sig.extract %addr_hit from %c1_i5 : <i32> -> <i1>
      %601 = llhd.prb %reg_addr : i7
      %602 = comb.icmp eq %601, %c4_i7 : i7
      llhd.drv %600, %602 after %1 : i1
      %603 = llhd.sig.extract %addr_hit from %c2_i5 : <i32> -> <i1>
      %604 = llhd.prb %reg_addr : i7
      %605 = comb.icmp eq %604, %c8_i7 : i7
      llhd.drv %603, %605 after %1 : i1
      %606 = llhd.sig.extract %addr_hit from %c3_i5 : <i32> -> <i1>
      %607 = llhd.prb %reg_addr : i7
      %608 = comb.icmp eq %607, %c12_i7 : i7
      llhd.drv %606, %608 after %1 : i1
      %609 = llhd.sig.extract %addr_hit from %c4_i5 : <i32> -> <i1>
      %610 = llhd.prb %reg_addr : i7
      %611 = comb.icmp eq %610, %c16_i7 : i7
      llhd.drv %609, %611 after %1 : i1
      %612 = llhd.sig.extract %addr_hit from %c5_i5 : <i32> -> <i1>
      %613 = llhd.prb %reg_addr : i7
      %614 = comb.icmp eq %613, %c20_i7 : i7
      llhd.drv %612, %614 after %1 : i1
      %615 = llhd.sig.extract %addr_hit from %c6_i5 : <i32> -> <i1>
      %616 = llhd.prb %reg_addr : i7
      %617 = comb.icmp eq %616, %c24_i7 : i7
      llhd.drv %615, %617 after %1 : i1
      %618 = llhd.sig.extract %addr_hit from %c7_i5 : <i32> -> <i1>
      %619 = llhd.prb %reg_addr : i7
      %620 = comb.icmp eq %619, %c28_i7 : i7
      llhd.drv %618, %620 after %1 : i1
      %621 = llhd.sig.extract %addr_hit from %c8_i5 : <i32> -> <i1>
      %622 = llhd.prb %reg_addr : i7
      %623 = comb.icmp eq %622, %c32_i7 : i7
      llhd.drv %621, %623 after %1 : i1
      %624 = llhd.sig.extract %addr_hit from %c9_i5 : <i32> -> <i1>
      %625 = llhd.prb %reg_addr : i7
      %626 = comb.icmp eq %625, %c36_i7 : i7
      llhd.drv %624, %626 after %1 : i1
      %627 = llhd.sig.extract %addr_hit from %c10_i5 : <i32> -> <i1>
      %628 = llhd.prb %reg_addr : i7
      %629 = comb.icmp eq %628, %c40_i7 : i7
      llhd.drv %627, %629 after %1 : i1
      %630 = llhd.sig.extract %addr_hit from %c11_i5 : <i32> -> <i1>
      %631 = llhd.prb %reg_addr : i7
      %632 = comb.icmp eq %631, %c44_i7 : i7
      llhd.drv %630, %632 after %1 : i1
      %633 = llhd.sig.extract %addr_hit from %c12_i5 : <i32> -> <i1>
      %634 = llhd.prb %reg_addr : i7
      %635 = comb.icmp eq %634, %c48_i7 : i7
      llhd.drv %633, %635 after %1 : i1
      %636 = llhd.sig.extract %addr_hit from %c13_i5 : <i32> -> <i1>
      %637 = llhd.prb %reg_addr : i7
      %638 = comb.icmp eq %637, %c52_i7 : i7
      llhd.drv %636, %638 after %1 : i1
      %639 = llhd.sig.extract %addr_hit from %c14_i5 : <i32> -> <i1>
      %640 = llhd.prb %reg_addr : i7
      %641 = comb.icmp eq %640, %c56_i7 : i7
      llhd.drv %639, %641 after %1 : i1
      %642 = llhd.sig.extract %addr_hit from %c15_i5 : <i32> -> <i1>
      %643 = llhd.prb %reg_addr : i7
      %644 = comb.icmp eq %643, %c60_i7 : i7
      llhd.drv %642, %644 after %1 : i1
      %645 = llhd.sig.extract %addr_hit from %c-16_i5 : <i32> -> <i1>
      %646 = llhd.prb %reg_addr : i7
      %647 = comb.icmp eq %646, %c-64_i7 : i7
      llhd.drv %645, %647 after %1 : i1
      %648 = llhd.sig.extract %addr_hit from %c-15_i5 : <i32> -> <i1>
      %649 = llhd.prb %reg_addr : i7
      %650 = comb.icmp eq %649, %c-60_i7 : i7
      llhd.drv %648, %650 after %1 : i1
      %651 = llhd.sig.extract %addr_hit from %c-14_i5 : <i32> -> <i1>
      %652 = llhd.prb %reg_addr : i7
      %653 = comb.icmp eq %652, %c-56_i7 : i7
      llhd.drv %651, %653 after %1 : i1
      %654 = llhd.sig.extract %addr_hit from %c-13_i5 : <i32> -> <i1>
      %655 = llhd.prb %reg_addr : i7
      %656 = comb.icmp eq %655, %c-52_i7 : i7
      llhd.drv %654, %656 after %1 : i1
      %657 = llhd.sig.extract %addr_hit from %c-12_i5 : <i32> -> <i1>
      %658 = llhd.prb %reg_addr : i7
      %659 = comb.icmp eq %658, %c-48_i7 : i7
      llhd.drv %657, %659 after %1 : i1
      %660 = llhd.sig.extract %addr_hit from %c-11_i5 : <i32> -> <i1>
      %661 = llhd.prb %reg_addr : i7
      %662 = comb.icmp eq %661, %c-44_i7 : i7
      llhd.drv %660, %662 after %1 : i1
      %663 = llhd.sig.extract %addr_hit from %c-10_i5 : <i32> -> <i1>
      %664 = llhd.prb %reg_addr : i7
      %665 = comb.icmp eq %664, %c-40_i7 : i7
      llhd.drv %663, %665 after %1 : i1
      %666 = llhd.sig.extract %addr_hit from %c-9_i5 : <i32> -> <i1>
      %667 = llhd.prb %reg_addr : i7
      %668 = comb.icmp eq %667, %c-36_i7 : i7
      llhd.drv %666, %668 after %1 : i1
      %669 = llhd.sig.extract %addr_hit from %c-8_i5 : <i32> -> <i1>
      %670 = llhd.prb %reg_addr : i7
      %671 = comb.icmp eq %670, %c-32_i7 : i7
      llhd.drv %669, %671 after %1 : i1
      %672 = llhd.sig.extract %addr_hit from %c-7_i5 : <i32> -> <i1>
      %673 = llhd.prb %reg_addr : i7
      %674 = comb.icmp eq %673, %c-28_i7 : i7
      llhd.drv %672, %674 after %1 : i1
      %675 = llhd.sig.extract %addr_hit from %c-6_i5 : <i32> -> <i1>
      %676 = llhd.prb %reg_addr : i7
      %677 = comb.icmp eq %676, %c-24_i7 : i7
      llhd.drv %675, %677 after %1 : i1
      %678 = llhd.sig.extract %addr_hit from %c-5_i5 : <i32> -> <i1>
      %679 = llhd.prb %reg_addr : i7
      %680 = comb.icmp eq %679, %c-20_i7 : i7
      llhd.drv %678, %680 after %1 : i1
      %681 = llhd.sig.extract %addr_hit from %c-4_i5 : <i32> -> <i1>
      %682 = llhd.prb %reg_addr : i7
      %683 = comb.icmp eq %682, %c-16_i7 : i7
      llhd.drv %681, %683 after %1 : i1
      %684 = llhd.sig.extract %addr_hit from %c-3_i5 : <i32> -> <i1>
      %685 = llhd.prb %reg_addr : i7
      %686 = comb.icmp eq %685, %c-12_i7 : i7
      llhd.drv %684, %686 after %1 : i1
      %687 = llhd.sig.extract %addr_hit from %c-2_i5 : <i32> -> <i1>
      %688 = llhd.prb %reg_addr : i7
      %689 = comb.icmp eq %688, %c-8_i7 : i7
      llhd.drv %687, %689 after %1 : i1
      %690 = llhd.sig.extract %addr_hit from %c-1_i5 : <i32> -> <i1>
      %691 = llhd.prb %reg_addr : i7
      %692 = comb.icmp eq %691, %c-4_i7 : i7
      llhd.drv %690, %692 after %1 : i1
      llhd.wait (%467, %468 : i32, i7), ^bb1
    }
    %469 = comb.or %u_reg_if.re_o, %6 : i1
    %470 = comb.icmp eq %467, %c0_i32 : i32
    %471 = comb.and %469, %470 {sv.namehint = "addrmiss"} : i1
    %472 = llhd.prb %reg_be : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %597 = llhd.prb %reg_we : i1
      %598 = llhd.prb %addr_hit : i32
      %599 = comb.extract %598 from 0 : (i32) -> i1
      %600 = llhd.prb %reg_be : i4
      %601 = comb.extract %600 from 0 : (i4) -> i2
      %602 = comb.extract %600 from 0 : (i4) -> i1
      %603 = comb.xor %602, %true : i1
      %604 = comb.and %599, %603 : i1
      %605 = comb.extract %598 from 1 : (i32) -> i1
      %606 = comb.and %605, %603 : i1
      %607 = comb.extract %598 from 2 : (i32) -> i1
      %608 = comb.and %607, %603 : i1
      %609 = comb.extract %598 from 3 : (i32) -> i1
      %610 = comb.and %609, %603 : i1
      %611 = comb.extract %598 from 4 : (i32) -> i1
      %612 = comb.and %611, %603 : i1
      %613 = comb.extract %598 from 5 : (i32) -> i1
      %614 = comb.icmp ne %600, %c-1_i4 : i4
      %615 = comb.and %613, %614 : i1
      %616 = comb.extract %598 from 6 : (i32) -> i1
      %617 = comb.and %616, %603 : i1
      %618 = comb.extract %598 from 7 : (i32) -> i1
      %619 = comb.icmp ne %601, %c-1_i2 : i2
      %620 = comb.and %618, %619 : i1
      %621 = comb.extract %598 from 8 : (i32) -> i1
      %622 = comb.and %621, %603 : i1
      %623 = comb.extract %598 from 9 : (i32) -> i1
      %624 = comb.icmp ne %600, %c-1_i4 : i4
      %625 = comb.and %623, %624 : i1
      %626 = comb.extract %598 from 10 : (i32) -> i1
      %627 = comb.icmp ne %600, %c-1_i4 : i4
      %628 = comb.and %626, %627 : i1
      %629 = comb.extract %598 from 11 : (i32) -> i1
      %630 = comb.icmp ne %600, %c-1_i4 : i4
      %631 = comb.and %629, %630 : i1
      %632 = comb.extract %598 from 12 : (i32) -> i1
      %633 = comb.icmp ne %600, %c-1_i4 : i4
      %634 = comb.and %632, %633 : i1
      %635 = comb.extract %598 from 13 : (i32) -> i1
      %636 = comb.icmp ne %600, %c-1_i4 : i4
      %637 = comb.and %635, %636 : i1
      %638 = comb.extract %598 from 14 : (i32) -> i1
      %639 = comb.icmp ne %600, %c-1_i4 : i4
      %640 = comb.and %638, %639 : i1
      %641 = comb.extract %598 from 15 : (i32) -> i1
      %642 = comb.icmp ne %600, %c-1_i4 : i4
      %643 = comb.and %641, %642 : i1
      %644 = comb.extract %598 from 16 : (i32) -> i1
      %645 = comb.icmp ne %600, %c-1_i4 : i4
      %646 = comb.and %644, %645 : i1
      %647 = comb.extract %598 from 17 : (i32) -> i1
      %648 = comb.icmp ne %600, %c-1_i4 : i4
      %649 = comb.and %647, %648 : i1
      %650 = comb.extract %598 from 18 : (i32) -> i1
      %651 = comb.icmp ne %600, %c-1_i4 : i4
      %652 = comb.and %650, %651 : i1
      %653 = comb.extract %598 from 19 : (i32) -> i1
      %654 = comb.icmp ne %600, %c-1_i4 : i4
      %655 = comb.and %653, %654 : i1
      %656 = comb.extract %598 from 20 : (i32) -> i1
      %657 = comb.icmp ne %600, %c-1_i4 : i4
      %658 = comb.and %656, %657 : i1
      %659 = comb.extract %598 from 21 : (i32) -> i1
      %660 = comb.icmp ne %600, %c-1_i4 : i4
      %661 = comb.and %659, %660 : i1
      %662 = comb.extract %598 from 22 : (i32) -> i1
      %663 = comb.icmp ne %600, %c-1_i4 : i4
      %664 = comb.and %662, %663 : i1
      %665 = comb.extract %598 from 23 : (i32) -> i1
      %666 = comb.icmp ne %600, %c-1_i4 : i4
      %667 = comb.and %665, %666 : i1
      %668 = comb.extract %598 from 24 : (i32) -> i1
      %669 = comb.icmp ne %600, %c-1_i4 : i4
      %670 = comb.and %668, %669 : i1
      %671 = comb.extract %598 from 25 : (i32) -> i1
      %672 = comb.icmp ne %600, %c-1_i4 : i4
      %673 = comb.and %671, %672 : i1
      %674 = comb.extract %598 from 26 : (i32) -> i1
      %675 = comb.icmp ne %600, %c-1_i4 : i4
      %676 = comb.and %674, %675 : i1
      %677 = comb.extract %598 from 27 : (i32) -> i1
      %678 = comb.icmp ne %601, %c-1_i2 : i2
      %679 = comb.and %677, %678 : i1
      %680 = comb.extract %598 from 28 : (i32) -> i1
      %681 = comb.icmp ne %601, %c-1_i2 : i2
      %682 = comb.and %680, %681 : i1
      %683 = comb.extract %598 from 29 : (i32) -> i1
      %684 = comb.icmp ne %601, %c-1_i2 : i2
      %685 = comb.and %683, %684 : i1
      %686 = comb.extract %598 from 30 : (i32) -> i1
      %687 = comb.icmp ne %601, %c-1_i2 : i2
      %688 = comb.and %686, %687 : i1
      %689 = comb.extract %598 from 31 : (i32) -> i1
      %690 = comb.and %689, %603 : i1
      %691 = comb.or %604, %606, %608, %610, %612, %615, %617, %620, %622, %625, %628, %631, %634, %637, %640, %643, %646, %649, %652, %655, %658, %661, %664, %667, %670, %673, %676, %679, %682, %685, %688, %690 : i1
      %692 = comb.and %597, %691 : i1
      llhd.drv %wr_err, %692 after %1 : i1
      llhd.wait (%6, %467, %472, %358 : i1, i32, i4, i1), ^bb1
    }
    %473 = comb.extract %467 from 1 : (i32) -> i1
    %474 = comb.xor %359, %true : i1
    %475 = comb.and %473, %6, %474 : i1
    llhd.drv %intr_enable_we, %475 after %1 : i1
    %476 = comb.extract %467 from 2 : (i32) -> i1
    %477 = comb.and %476, %6, %474 : i1
    llhd.drv %intr_test_we, %477 after %1 : i1
    %478 = comb.extract %467 from 3 : (i32) -> i1
    %479 = comb.and %478, %6, %474 : i1
    llhd.drv %alert_test_we, %479 after %1 : i1
    %480 = comb.extract %467 from 4 : (i32) -> i1
    %481 = comb.and %480, %6, %474 : i1
    llhd.drv %adc_en_ctl_we, %481 after %1 : i1
    %482 = comb.extract %467 from 5 : (i32) -> i1
    %483 = comb.and %482, %6, %474 : i1
    llhd.drv %adc_pd_ctl_we, %483 after %1 : i1
    %484 = comb.extract %467 from 6 : (i32) -> i1
    %485 = comb.and %484, %6, %474 : i1
    llhd.drv %adc_lp_sample_ctl_we, %485 after %1 : i1
    %486 = comb.extract %467 from 7 : (i32) -> i1
    %487 = comb.and %486, %6, %474 : i1
    llhd.drv %adc_sample_ctl_we, %487 after %1 : i1
    %488 = comb.extract %467 from 8 : (i32) -> i1
    %489 = comb.and %488, %6, %474 : i1
    llhd.drv %adc_fsm_rst_we, %489 after %1 : i1
    %490 = comb.extract %467 from 9 : (i32) -> i1
    %491 = comb.and %490, %6, %474 : i1
    llhd.drv %adc_chn0_filter_ctl_0_we, %491 after %1 : i1
    %492 = comb.extract %467 from 10 : (i32) -> i1
    %493 = comb.and %492, %6, %474 : i1
    llhd.drv %adc_chn0_filter_ctl_1_we, %493 after %1 : i1
    %494 = comb.extract %467 from 11 : (i32) -> i1
    %495 = comb.and %494, %6, %474 : i1
    llhd.drv %adc_chn0_filter_ctl_2_we, %495 after %1 : i1
    %496 = comb.extract %467 from 12 : (i32) -> i1
    %497 = comb.and %496, %6, %474 : i1
    llhd.drv %adc_chn0_filter_ctl_3_we, %497 after %1 : i1
    %498 = comb.extract %467 from 13 : (i32) -> i1
    %499 = comb.and %498, %6, %474 : i1
    llhd.drv %adc_chn0_filter_ctl_4_we, %499 after %1 : i1
    %500 = comb.extract %467 from 14 : (i32) -> i1
    %501 = comb.and %500, %6, %474 : i1
    llhd.drv %adc_chn0_filter_ctl_5_we, %501 after %1 : i1
    %502 = comb.extract %467 from 15 : (i32) -> i1
    %503 = comb.and %502, %6, %474 : i1
    llhd.drv %adc_chn0_filter_ctl_6_we, %503 after %1 : i1
    %504 = comb.extract %467 from 16 : (i32) -> i1
    %505 = comb.and %504, %6, %474 : i1
    llhd.drv %adc_chn0_filter_ctl_7_we, %505 after %1 : i1
    %506 = comb.extract %467 from 17 : (i32) -> i1
    %507 = comb.and %506, %6, %474 : i1
    llhd.drv %adc_chn1_filter_ctl_0_we, %507 after %1 : i1
    %508 = comb.extract %467 from 18 : (i32) -> i1
    %509 = comb.and %508, %6, %474 : i1
    llhd.drv %adc_chn1_filter_ctl_1_we, %509 after %1 : i1
    %510 = comb.extract %467 from 19 : (i32) -> i1
    %511 = comb.and %510, %6, %474 : i1
    llhd.drv %adc_chn1_filter_ctl_2_we, %511 after %1 : i1
    %512 = comb.extract %467 from 20 : (i32) -> i1
    %513 = comb.and %512, %6, %474 : i1
    llhd.drv %adc_chn1_filter_ctl_3_we, %513 after %1 : i1
    %514 = comb.extract %467 from 21 : (i32) -> i1
    %515 = comb.and %514, %6, %474 : i1
    llhd.drv %adc_chn1_filter_ctl_4_we, %515 after %1 : i1
    %516 = comb.extract %467 from 22 : (i32) -> i1
    %517 = comb.and %516, %6, %474 : i1
    llhd.drv %adc_chn1_filter_ctl_5_we, %517 after %1 : i1
    %518 = comb.extract %467 from 23 : (i32) -> i1
    %519 = comb.and %518, %6, %474 : i1
    llhd.drv %adc_chn1_filter_ctl_6_we, %519 after %1 : i1
    %520 = comb.extract %467 from 24 : (i32) -> i1
    %521 = comb.and %520, %6, %474 : i1
    llhd.drv %adc_chn1_filter_ctl_7_we, %521 after %1 : i1
    %522 = comb.extract %467 from 27 : (i32) -> i1
    %523 = comb.and %522, %6, %474 : i1
    llhd.drv %adc_wakeup_ctl_we, %523 after %1 : i1
    %524 = comb.extract %467 from 28 : (i32) -> i1
    %525 = comb.and %524, %6, %474 : i1
    llhd.drv %filter_status_we, %525 after %1 : i1
    %526 = comb.extract %467 from 29 : (i32) -> i1
    %527 = comb.and %526, %6, %474 : i1
    llhd.drv %adc_intr_ctl_we, %527 after %1 : i1
    %528 = comb.extract %u_reg_if.wdata_o from 8 {sv.namehint = "adc_intr_status_trans_wd"} : (i32) -> i1
    %529 = comb.extract %u_reg_if.wdata_o from 9 {sv.namehint = "adc_intr_status_oneshot_wd"} : (i32) -> i1
    %530 = comb.extract %467 from 30 : (i32) -> i1
    %531 = comb.and %530, %6, %474 : i1
    llhd.drv %adc_intr_status_we, %531 after %1 : i1
    %532 = comb.extract %467 from 31 : (i32) -> i1
    %533 = comb.and %532, %u_reg_if.re_o, %474 {sv.namehint = "adc_fsm_state_re"} : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %597 = llhd.sig.extract %reg_we_check from %c0_i5 : <i32> -> <i1>
      llhd.drv %597, %false after %1 : i1
      %598 = llhd.sig.extract %reg_we_check from %c1_i5 : <i32> -> <i1>
      %599 = llhd.prb %intr_enable_we : i1
      llhd.drv %598, %599 after %1 : i1
      %600 = llhd.sig.extract %reg_we_check from %c2_i5 : <i32> -> <i1>
      %601 = llhd.prb %intr_test_we : i1
      llhd.drv %600, %601 after %1 : i1
      %602 = llhd.sig.extract %reg_we_check from %c3_i5 : <i32> -> <i1>
      %603 = llhd.prb %alert_test_we : i1
      llhd.drv %602, %603 after %1 : i1
      %604 = llhd.sig.extract %reg_we_check from %c4_i5 : <i32> -> <i1>
      %605 = llhd.prb %adc_en_ctl_we : i1
      llhd.drv %604, %605 after %1 : i1
      %606 = llhd.sig.extract %reg_we_check from %c5_i5 : <i32> -> <i1>
      %607 = llhd.prb %adc_pd_ctl_we : i1
      llhd.drv %606, %607 after %1 : i1
      %608 = llhd.sig.extract %reg_we_check from %c6_i5 : <i32> -> <i1>
      %609 = llhd.prb %adc_lp_sample_ctl_we : i1
      llhd.drv %608, %609 after %1 : i1
      %610 = llhd.sig.extract %reg_we_check from %c7_i5 : <i32> -> <i1>
      %611 = llhd.prb %adc_sample_ctl_we : i1
      llhd.drv %610, %611 after %1 : i1
      %612 = llhd.sig.extract %reg_we_check from %c8_i5 : <i32> -> <i1>
      %613 = llhd.prb %adc_fsm_rst_we : i1
      llhd.drv %612, %613 after %1 : i1
      %614 = llhd.sig.extract %reg_we_check from %c9_i5 : <i32> -> <i1>
      %615 = llhd.prb %adc_chn0_filter_ctl_0_we : i1
      llhd.drv %614, %615 after %1 : i1
      %616 = llhd.sig.extract %reg_we_check from %c10_i5 : <i32> -> <i1>
      %617 = llhd.prb %adc_chn0_filter_ctl_1_we : i1
      llhd.drv %616, %617 after %1 : i1
      %618 = llhd.sig.extract %reg_we_check from %c11_i5 : <i32> -> <i1>
      %619 = llhd.prb %adc_chn0_filter_ctl_2_we : i1
      llhd.drv %618, %619 after %1 : i1
      %620 = llhd.sig.extract %reg_we_check from %c12_i5 : <i32> -> <i1>
      %621 = llhd.prb %adc_chn0_filter_ctl_3_we : i1
      llhd.drv %620, %621 after %1 : i1
      %622 = llhd.sig.extract %reg_we_check from %c13_i5 : <i32> -> <i1>
      %623 = llhd.prb %adc_chn0_filter_ctl_4_we : i1
      llhd.drv %622, %623 after %1 : i1
      %624 = llhd.sig.extract %reg_we_check from %c14_i5 : <i32> -> <i1>
      %625 = llhd.prb %adc_chn0_filter_ctl_5_we : i1
      llhd.drv %624, %625 after %1 : i1
      %626 = llhd.sig.extract %reg_we_check from %c15_i5 : <i32> -> <i1>
      %627 = llhd.prb %adc_chn0_filter_ctl_6_we : i1
      llhd.drv %626, %627 after %1 : i1
      %628 = llhd.sig.extract %reg_we_check from %c-16_i5 : <i32> -> <i1>
      %629 = llhd.prb %adc_chn0_filter_ctl_7_we : i1
      llhd.drv %628, %629 after %1 : i1
      %630 = llhd.sig.extract %reg_we_check from %c-15_i5 : <i32> -> <i1>
      %631 = llhd.prb %adc_chn1_filter_ctl_0_we : i1
      llhd.drv %630, %631 after %1 : i1
      %632 = llhd.sig.extract %reg_we_check from %c-14_i5 : <i32> -> <i1>
      %633 = llhd.prb %adc_chn1_filter_ctl_1_we : i1
      llhd.drv %632, %633 after %1 : i1
      %634 = llhd.sig.extract %reg_we_check from %c-13_i5 : <i32> -> <i1>
      %635 = llhd.prb %adc_chn1_filter_ctl_2_we : i1
      llhd.drv %634, %635 after %1 : i1
      %636 = llhd.sig.extract %reg_we_check from %c-12_i5 : <i32> -> <i1>
      %637 = llhd.prb %adc_chn1_filter_ctl_3_we : i1
      llhd.drv %636, %637 after %1 : i1
      %638 = llhd.sig.extract %reg_we_check from %c-11_i5 : <i32> -> <i1>
      %639 = llhd.prb %adc_chn1_filter_ctl_4_we : i1
      llhd.drv %638, %639 after %1 : i1
      %640 = llhd.sig.extract %reg_we_check from %c-10_i5 : <i32> -> <i1>
      %641 = llhd.prb %adc_chn1_filter_ctl_5_we : i1
      llhd.drv %640, %641 after %1 : i1
      %642 = llhd.sig.extract %reg_we_check from %c-9_i5 : <i32> -> <i1>
      %643 = llhd.prb %adc_chn1_filter_ctl_6_we : i1
      llhd.drv %642, %643 after %1 : i1
      %644 = llhd.sig.extract %reg_we_check from %c-8_i5 : <i32> -> <i1>
      %645 = llhd.prb %adc_chn1_filter_ctl_7_we : i1
      llhd.drv %644, %645 after %1 : i1
      %646 = llhd.sig.extract %reg_we_check from %c-7_i5 : <i32> -> <i1>
      llhd.drv %646, %false after %1 : i1
      %647 = llhd.sig.extract %reg_we_check from %c-6_i5 : <i32> -> <i1>
      llhd.drv %647, %false after %1 : i1
      %648 = llhd.sig.extract %reg_we_check from %c-5_i5 : <i32> -> <i1>
      %649 = llhd.prb %adc_wakeup_ctl_we : i1
      llhd.drv %648, %649 after %1 : i1
      %650 = llhd.sig.extract %reg_we_check from %c-4_i5 : <i32> -> <i1>
      %651 = llhd.prb %filter_status_we : i1
      llhd.drv %650, %651 after %1 : i1
      %652 = llhd.sig.extract %reg_we_check from %c-3_i5 : <i32> -> <i1>
      %653 = llhd.prb %adc_intr_ctl_we : i1
      llhd.drv %652, %653 after %1 : i1
      %654 = llhd.sig.extract %reg_we_check from %c-2_i5 : <i32> -> <i1>
      %655 = llhd.prb %adc_intr_status_we : i1
      llhd.drv %654, %655 after %1 : i1
      %656 = llhd.sig.extract %reg_we_check from %c-1_i5 : <i32> -> <i1>
      llhd.drv %656, %false after %1 : i1
      llhd.wait (%5, %69, %72, %75, %9, %12, %14, %17, %20, %23, %25, %27, %29, %31, %33, %35, %37, %39, %41, %43, %45, %47, %49, %51, %53, %59, %62, %337, %345 : i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %534 = llhd.prb %intr_state_qs : i1
    %535 = llhd.prb %intr_enable_qs : i1
    %536 = llhd.prb %adc_en_ctl_qs : i2
    %537 = llhd.prb %adc_pd_ctl_qs : i32
    %538 = llhd.prb %adc_lp_sample_ctl_qs : i8
    %539 = llhd.prb %adc_sample_ctl_qs : i16
    %540 = llhd.prb %adc_fsm_rst_qs : i1
    %541 = llhd.prb %adc_chn0_filter_ctl_0_qs : i32
    %542 = llhd.prb %adc_chn0_filter_ctl_1_qs : i32
    %543 = llhd.prb %adc_chn0_filter_ctl_2_qs : i32
    %544 = llhd.prb %adc_chn0_filter_ctl_3_qs : i32
    %545 = llhd.prb %adc_chn0_filter_ctl_4_qs : i32
    %546 = llhd.prb %adc_chn0_filter_ctl_5_qs : i32
    %547 = llhd.prb %adc_chn0_filter_ctl_6_qs : i32
    %548 = llhd.prb %adc_chn0_filter_ctl_7_qs : i32
    %549 = llhd.prb %adc_chn1_filter_ctl_0_qs : i32
    %550 = llhd.prb %adc_chn1_filter_ctl_1_qs : i32
    %551 = llhd.prb %adc_chn1_filter_ctl_2_qs : i32
    %552 = llhd.prb %adc_chn1_filter_ctl_3_qs : i32
    %553 = llhd.prb %adc_chn1_filter_ctl_4_qs : i32
    %554 = llhd.prb %adc_chn1_filter_ctl_5_qs : i32
    %555 = llhd.prb %adc_chn1_filter_ctl_6_qs : i32
    %556 = llhd.prb %adc_chn1_filter_ctl_7_qs : i32
    %557 = llhd.prb %adc_chn_val_0_qs : i28
    %558 = llhd.prb %adc_chn_val_1_qs : i28
    %559 = llhd.prb %adc_wakeup_ctl_qs : i9
    %560 = llhd.prb %filter_status_qs : i9
    %561 = llhd.prb %adc_intr_ctl_match_en_qs : i8
    %562 = llhd.prb %adc_intr_ctl_trans_en_qs : i1
    %563 = llhd.prb %adc_intr_ctl_oneshot_en_qs : i1
    %564 = llhd.prb %adc_intr_status_match_qs : i8
    %565 = llhd.prb %adc_intr_status_trans_qs : i1
    %566 = llhd.prb %adc_intr_status_oneshot_qs : i1
    %567 = llhd.prb %adc_fsm_state_qs : i5
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb66
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      %597 = llhd.prb %addr_hit : i32
      %598 = comb.extract %597 from 0 : (i32) -> i1
      %599 = comb.icmp ceq %598, %true : i1
      cf.cond_br %599, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %600 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %601 = llhd.prb %intr_state_qs : i1
      llhd.drv %600, %601 after %1 : i1
      cf.br ^bb66
    ^bb3:  // pred: ^bb1
      %602 = llhd.prb %addr_hit : i32
      %603 = comb.extract %602 from 1 : (i32) -> i1
      %604 = comb.icmp ceq %603, %true : i1
      cf.cond_br %604, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %605 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %606 = llhd.prb %intr_enable_qs : i1
      llhd.drv %605, %606 after %1 : i1
      cf.br ^bb66
    ^bb5:  // pred: ^bb3
      %607 = llhd.prb %addr_hit : i32
      %608 = comb.extract %607 from 2 : (i32) -> i1
      %609 = comb.icmp ceq %608, %true : i1
      cf.cond_br %609, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %610 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %610, %false after %1 : i1
      cf.br ^bb66
    ^bb7:  // pred: ^bb5
      %611 = llhd.prb %addr_hit : i32
      %612 = comb.extract %611 from 3 : (i32) -> i1
      %613 = comb.icmp ceq %612, %true : i1
      cf.cond_br %613, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %614 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %614, %false after %1 : i1
      cf.br ^bb66
    ^bb9:  // pred: ^bb7
      %615 = llhd.prb %addr_hit : i32
      %616 = comb.extract %615 from 4 : (i32) -> i1
      %617 = comb.icmp ceq %616, %true : i1
      cf.cond_br %617, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %618 = llhd.prb %adc_en_ctl_qs : i2
      %619 = comb.concat %c0_i30, %618 : i30, i2
      llhd.drv %reg_rdata_next, %619 after %1 : i32
      cf.br ^bb66
    ^bb11:  // pred: ^bb9
      %620 = llhd.prb %addr_hit : i32
      %621 = comb.extract %620 from 5 : (i32) -> i1
      %622 = comb.icmp ceq %621, %true : i1
      cf.cond_br %622, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %623 = llhd.prb %adc_pd_ctl_qs : i32
      llhd.drv %reg_rdata_next, %623 after %1 : i32
      cf.br ^bb66
    ^bb13:  // pred: ^bb11
      %624 = llhd.prb %addr_hit : i32
      %625 = comb.extract %624 from 6 : (i32) -> i1
      %626 = comb.icmp ceq %625, %true : i1
      cf.cond_br %626, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %627 = llhd.prb %adc_lp_sample_ctl_qs : i8
      %628 = comb.concat %c0_i24, %627 : i24, i8
      llhd.drv %reg_rdata_next, %628 after %1 : i32
      cf.br ^bb66
    ^bb15:  // pred: ^bb13
      %629 = llhd.prb %addr_hit : i32
      %630 = comb.extract %629 from 7 : (i32) -> i1
      %631 = comb.icmp ceq %630, %true : i1
      cf.cond_br %631, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %632 = llhd.prb %adc_sample_ctl_qs : i16
      %633 = comb.concat %c0_i16, %632 : i16, i16
      llhd.drv %reg_rdata_next, %633 after %1 : i32
      cf.br ^bb66
    ^bb17:  // pred: ^bb15
      %634 = llhd.prb %addr_hit : i32
      %635 = comb.extract %634 from 8 : (i32) -> i1
      %636 = comb.icmp ceq %635, %true : i1
      cf.cond_br %636, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      %637 = llhd.prb %adc_fsm_rst_qs : i1
      %638 = comb.concat %c0_i31, %637 : i31, i1
      llhd.drv %reg_rdata_next, %638 after %1 : i32
      cf.br ^bb66
    ^bb19:  // pred: ^bb17
      %639 = llhd.prb %addr_hit : i32
      %640 = comb.extract %639 from 9 : (i32) -> i1
      %641 = comb.icmp ceq %640, %true : i1
      cf.cond_br %641, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %642 = llhd.prb %adc_chn0_filter_ctl_0_qs : i32
      llhd.drv %reg_rdata_next, %642 after %1 : i32
      cf.br ^bb66
    ^bb21:  // pred: ^bb19
      %643 = llhd.prb %addr_hit : i32
      %644 = comb.extract %643 from 10 : (i32) -> i1
      %645 = comb.icmp ceq %644, %true : i1
      cf.cond_br %645, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      %646 = llhd.prb %adc_chn0_filter_ctl_1_qs : i32
      llhd.drv %reg_rdata_next, %646 after %1 : i32
      cf.br ^bb66
    ^bb23:  // pred: ^bb21
      %647 = llhd.prb %addr_hit : i32
      %648 = comb.extract %647 from 11 : (i32) -> i1
      %649 = comb.icmp ceq %648, %true : i1
      cf.cond_br %649, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %650 = llhd.prb %adc_chn0_filter_ctl_2_qs : i32
      llhd.drv %reg_rdata_next, %650 after %1 : i32
      cf.br ^bb66
    ^bb25:  // pred: ^bb23
      %651 = llhd.prb %addr_hit : i32
      %652 = comb.extract %651 from 12 : (i32) -> i1
      %653 = comb.icmp ceq %652, %true : i1
      cf.cond_br %653, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      %654 = llhd.prb %adc_chn0_filter_ctl_3_qs : i32
      llhd.drv %reg_rdata_next, %654 after %1 : i32
      cf.br ^bb66
    ^bb27:  // pred: ^bb25
      %655 = llhd.prb %addr_hit : i32
      %656 = comb.extract %655 from 13 : (i32) -> i1
      %657 = comb.icmp ceq %656, %true : i1
      cf.cond_br %657, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      %658 = llhd.prb %adc_chn0_filter_ctl_4_qs : i32
      llhd.drv %reg_rdata_next, %658 after %1 : i32
      cf.br ^bb66
    ^bb29:  // pred: ^bb27
      %659 = llhd.prb %addr_hit : i32
      %660 = comb.extract %659 from 14 : (i32) -> i1
      %661 = comb.icmp ceq %660, %true : i1
      cf.cond_br %661, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %662 = llhd.prb %adc_chn0_filter_ctl_5_qs : i32
      llhd.drv %reg_rdata_next, %662 after %1 : i32
      cf.br ^bb66
    ^bb31:  // pred: ^bb29
      %663 = llhd.prb %addr_hit : i32
      %664 = comb.extract %663 from 15 : (i32) -> i1
      %665 = comb.icmp ceq %664, %true : i1
      cf.cond_br %665, ^bb32, ^bb33
    ^bb32:  // pred: ^bb31
      %666 = llhd.prb %adc_chn0_filter_ctl_6_qs : i32
      llhd.drv %reg_rdata_next, %666 after %1 : i32
      cf.br ^bb66
    ^bb33:  // pred: ^bb31
      %667 = llhd.prb %addr_hit : i32
      %668 = comb.extract %667 from 16 : (i32) -> i1
      %669 = comb.icmp ceq %668, %true : i1
      cf.cond_br %669, ^bb34, ^bb35
    ^bb34:  // pred: ^bb33
      %670 = llhd.prb %adc_chn0_filter_ctl_7_qs : i32
      llhd.drv %reg_rdata_next, %670 after %1 : i32
      cf.br ^bb66
    ^bb35:  // pred: ^bb33
      %671 = llhd.prb %addr_hit : i32
      %672 = comb.extract %671 from 17 : (i32) -> i1
      %673 = comb.icmp ceq %672, %true : i1
      cf.cond_br %673, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      %674 = llhd.prb %adc_chn1_filter_ctl_0_qs : i32
      llhd.drv %reg_rdata_next, %674 after %1 : i32
      cf.br ^bb66
    ^bb37:  // pred: ^bb35
      %675 = llhd.prb %addr_hit : i32
      %676 = comb.extract %675 from 18 : (i32) -> i1
      %677 = comb.icmp ceq %676, %true : i1
      cf.cond_br %677, ^bb38, ^bb39
    ^bb38:  // pred: ^bb37
      %678 = llhd.prb %adc_chn1_filter_ctl_1_qs : i32
      llhd.drv %reg_rdata_next, %678 after %1 : i32
      cf.br ^bb66
    ^bb39:  // pred: ^bb37
      %679 = llhd.prb %addr_hit : i32
      %680 = comb.extract %679 from 19 : (i32) -> i1
      %681 = comb.icmp ceq %680, %true : i1
      cf.cond_br %681, ^bb40, ^bb41
    ^bb40:  // pred: ^bb39
      %682 = llhd.prb %adc_chn1_filter_ctl_2_qs : i32
      llhd.drv %reg_rdata_next, %682 after %1 : i32
      cf.br ^bb66
    ^bb41:  // pred: ^bb39
      %683 = llhd.prb %addr_hit : i32
      %684 = comb.extract %683 from 20 : (i32) -> i1
      %685 = comb.icmp ceq %684, %true : i1
      cf.cond_br %685, ^bb42, ^bb43
    ^bb42:  // pred: ^bb41
      %686 = llhd.prb %adc_chn1_filter_ctl_3_qs : i32
      llhd.drv %reg_rdata_next, %686 after %1 : i32
      cf.br ^bb66
    ^bb43:  // pred: ^bb41
      %687 = llhd.prb %addr_hit : i32
      %688 = comb.extract %687 from 21 : (i32) -> i1
      %689 = comb.icmp ceq %688, %true : i1
      cf.cond_br %689, ^bb44, ^bb45
    ^bb44:  // pred: ^bb43
      %690 = llhd.prb %adc_chn1_filter_ctl_4_qs : i32
      llhd.drv %reg_rdata_next, %690 after %1 : i32
      cf.br ^bb66
    ^bb45:  // pred: ^bb43
      %691 = llhd.prb %addr_hit : i32
      %692 = comb.extract %691 from 22 : (i32) -> i1
      %693 = comb.icmp ceq %692, %true : i1
      cf.cond_br %693, ^bb46, ^bb47
    ^bb46:  // pred: ^bb45
      %694 = llhd.prb %adc_chn1_filter_ctl_5_qs : i32
      llhd.drv %reg_rdata_next, %694 after %1 : i32
      cf.br ^bb66
    ^bb47:  // pred: ^bb45
      %695 = llhd.prb %addr_hit : i32
      %696 = comb.extract %695 from 23 : (i32) -> i1
      %697 = comb.icmp ceq %696, %true : i1
      cf.cond_br %697, ^bb48, ^bb49
    ^bb48:  // pred: ^bb47
      %698 = llhd.prb %adc_chn1_filter_ctl_6_qs : i32
      llhd.drv %reg_rdata_next, %698 after %1 : i32
      cf.br ^bb66
    ^bb49:  // pred: ^bb47
      %699 = llhd.prb %addr_hit : i32
      %700 = comb.extract %699 from 24 : (i32) -> i1
      %701 = comb.icmp ceq %700, %true : i1
      cf.cond_br %701, ^bb50, ^bb51
    ^bb50:  // pred: ^bb49
      %702 = llhd.prb %adc_chn1_filter_ctl_7_qs : i32
      llhd.drv %reg_rdata_next, %702 after %1 : i32
      cf.br ^bb66
    ^bb51:  // pred: ^bb49
      %703 = llhd.prb %addr_hit : i32
      %704 = comb.extract %703 from 25 : (i32) -> i1
      %705 = comb.icmp ceq %704, %true : i1
      cf.cond_br %705, ^bb52, ^bb53
    ^bb52:  // pred: ^bb51
      %706 = llhd.prb %adc_chn_val_0_qs : i28
      %707 = comb.concat %c0_i4, %706 : i4, i28
      llhd.drv %reg_rdata_next, %707 after %1 : i32
      cf.br ^bb66
    ^bb53:  // pred: ^bb51
      %708 = llhd.prb %addr_hit : i32
      %709 = comb.extract %708 from 26 : (i32) -> i1
      %710 = comb.icmp ceq %709, %true : i1
      cf.cond_br %710, ^bb54, ^bb55
    ^bb54:  // pred: ^bb53
      %711 = llhd.prb %adc_chn_val_1_qs : i28
      %712 = comb.concat %c0_i4, %711 : i4, i28
      llhd.drv %reg_rdata_next, %712 after %1 : i32
      cf.br ^bb66
    ^bb55:  // pred: ^bb53
      %713 = llhd.prb %addr_hit : i32
      %714 = comb.extract %713 from 27 : (i32) -> i1
      %715 = comb.icmp ceq %714, %true : i1
      cf.cond_br %715, ^bb56, ^bb57
    ^bb56:  // pred: ^bb55
      %716 = llhd.prb %adc_wakeup_ctl_qs : i9
      %717 = comb.concat %c0_i23, %716 : i23, i9
      llhd.drv %reg_rdata_next, %717 after %1 : i32
      cf.br ^bb66
    ^bb57:  // pred: ^bb55
      %718 = llhd.prb %addr_hit : i32
      %719 = comb.extract %718 from 28 : (i32) -> i1
      %720 = comb.icmp ceq %719, %true : i1
      cf.cond_br %720, ^bb58, ^bb59
    ^bb58:  // pred: ^bb57
      %721 = llhd.prb %filter_status_qs : i9
      %722 = comb.concat %c0_i23, %721 : i23, i9
      llhd.drv %reg_rdata_next, %722 after %1 : i32
      cf.br ^bb66
    ^bb59:  // pred: ^bb57
      %723 = llhd.prb %addr_hit : i32
      %724 = comb.extract %723 from 29 : (i32) -> i1
      %725 = comb.icmp ceq %724, %true : i1
      cf.cond_br %725, ^bb60, ^bb61
    ^bb60:  // pred: ^bb59
      %726 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i8>
      %727 = llhd.prb %adc_intr_ctl_match_en_qs : i8
      llhd.drv %726, %727 after %1 : i8
      %728 = llhd.sig.extract %reg_rdata_next from %c8_i5 : <i32> -> <i1>
      %729 = llhd.prb %adc_intr_ctl_trans_en_qs : i1
      llhd.drv %728, %729 after %1 : i1
      %730 = llhd.sig.extract %reg_rdata_next from %c9_i5 : <i32> -> <i1>
      %731 = llhd.prb %adc_intr_ctl_oneshot_en_qs : i1
      llhd.drv %730, %731 after %1 : i1
      cf.br ^bb66
    ^bb61:  // pred: ^bb59
      %732 = llhd.prb %addr_hit : i32
      %733 = comb.extract %732 from 30 : (i32) -> i1
      %734 = comb.icmp ceq %733, %true : i1
      cf.cond_br %734, ^bb62, ^bb63
    ^bb62:  // pred: ^bb61
      %735 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i8>
      %736 = llhd.prb %adc_intr_status_match_qs : i8
      llhd.drv %735, %736 after %1 : i8
      %737 = llhd.sig.extract %reg_rdata_next from %c8_i5 : <i32> -> <i1>
      %738 = llhd.prb %adc_intr_status_trans_qs : i1
      llhd.drv %737, %738 after %1 : i1
      %739 = llhd.sig.extract %reg_rdata_next from %c9_i5 : <i32> -> <i1>
      %740 = llhd.prb %adc_intr_status_oneshot_qs : i1
      llhd.drv %739, %740 after %1 : i1
      cf.br ^bb66
    ^bb63:  // pred: ^bb61
      %741 = llhd.prb %addr_hit : i32
      %742 = comb.extract %741 from 31 : (i32) -> i1
      %743 = comb.icmp ceq %742, %true : i1
      cf.cond_br %743, ^bb64, ^bb65
    ^bb64:  // pred: ^bb63
      %744 = llhd.prb %adc_fsm_state_qs : i5
      %745 = comb.concat %c0_i27, %744 : i27, i5
      llhd.drv %reg_rdata_next, %745 after %1 : i32
      cf.br ^bb66
    ^bb65:  // pred: ^bb63
      llhd.drv %reg_rdata_next, %c-1_i32 after %1 : i32
      cf.br ^bb66
    ^bb66:  // 33 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb22, ^bb24, ^bb26, ^bb28, ^bb30, ^bb32, ^bb34, ^bb36, ^bb38, ^bb40, ^bb42, ^bb44, ^bb46, ^bb48, ^bb50, ^bb52, ^bb54, ^bb56, ^bb58, ^bb60, ^bb62, ^bb64, ^bb65
      llhd.wait (%357, %467, %534, %535, %536, %537, %538, %539, %540, %541, %542, %543, %544, %545, %546, %547, %548, %549, %550, %551, %552, %553, %554, %555, %556, %557, %558, %559, %560, %561, %562, %563, %564, %565, %566, %567 : i32, i32, i1, i1, i2, i32, i8, i16, i1, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i28, i28, i9, i9, i8, i1, i1, i8, i1, i1, i5), ^bb1
    }
    %568 = llhd.prb %reg_busy_sel : i1
    %a_valid = hw.struct_extract %tl_i["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %569 = comb.and %568, %a_valid {sv.namehint = "reg_busy"} : i1
    %570 = llhd.prb %adc_en_ctl_busy : i1
    %571 = llhd.prb %adc_pd_ctl_busy : i1
    %572 = llhd.prb %adc_lp_sample_ctl_busy : i1
    %573 = llhd.prb %adc_sample_ctl_busy : i1
    %574 = llhd.prb %adc_fsm_rst_busy : i1
    %575 = llhd.prb %adc_chn0_filter_ctl_0_busy : i1
    %576 = llhd.prb %adc_chn0_filter_ctl_1_busy : i1
    %577 = llhd.prb %adc_chn0_filter_ctl_2_busy : i1
    %578 = llhd.prb %adc_chn0_filter_ctl_3_busy : i1
    %579 = llhd.prb %adc_chn0_filter_ctl_4_busy : i1
    %580 = llhd.prb %adc_chn0_filter_ctl_5_busy : i1
    %581 = llhd.prb %adc_chn0_filter_ctl_6_busy : i1
    %582 = llhd.prb %adc_chn0_filter_ctl_7_busy : i1
    %583 = llhd.prb %adc_chn1_filter_ctl_0_busy : i1
    %584 = llhd.prb %adc_chn1_filter_ctl_1_busy : i1
    %585 = llhd.prb %adc_chn1_filter_ctl_2_busy : i1
    %586 = llhd.prb %adc_chn1_filter_ctl_3_busy : i1
    %587 = llhd.prb %adc_chn1_filter_ctl_4_busy : i1
    %588 = llhd.prb %adc_chn1_filter_ctl_5_busy : i1
    %589 = llhd.prb %adc_chn1_filter_ctl_6_busy : i1
    %590 = llhd.prb %adc_chn1_filter_ctl_7_busy : i1
    %591 = llhd.prb %adc_chn_val_0_busy : i1
    %592 = llhd.prb %adc_chn_val_1_busy : i1
    %593 = llhd.prb %adc_wakeup_ctl_busy : i1
    %594 = llhd.prb %filter_status_busy : i1
    %595 = llhd.prb %adc_fsm_state_busy : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb54
      llhd.drv %reg_busy_sel, %false after %1 : i1
      %597 = llhd.prb %addr_hit : i32
      %598 = comb.extract %597 from 4 : (i32) -> i1
      %599 = comb.icmp ceq %598, %true : i1
      cf.cond_br %599, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %600 = llhd.prb %adc_en_ctl_busy : i1
      llhd.drv %reg_busy_sel, %600 after %1 : i1
      cf.br ^bb54
    ^bb3:  // pred: ^bb1
      %601 = llhd.prb %addr_hit : i32
      %602 = comb.extract %601 from 5 : (i32) -> i1
      %603 = comb.icmp ceq %602, %true : i1
      cf.cond_br %603, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %604 = llhd.prb %adc_pd_ctl_busy : i1
      llhd.drv %reg_busy_sel, %604 after %1 : i1
      cf.br ^bb54
    ^bb5:  // pred: ^bb3
      %605 = llhd.prb %addr_hit : i32
      %606 = comb.extract %605 from 6 : (i32) -> i1
      %607 = comb.icmp ceq %606, %true : i1
      cf.cond_br %607, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %608 = llhd.prb %adc_lp_sample_ctl_busy : i1
      llhd.drv %reg_busy_sel, %608 after %1 : i1
      cf.br ^bb54
    ^bb7:  // pred: ^bb5
      %609 = llhd.prb %addr_hit : i32
      %610 = comb.extract %609 from 7 : (i32) -> i1
      %611 = comb.icmp ceq %610, %true : i1
      cf.cond_br %611, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %612 = llhd.prb %adc_sample_ctl_busy : i1
      llhd.drv %reg_busy_sel, %612 after %1 : i1
      cf.br ^bb54
    ^bb9:  // pred: ^bb7
      %613 = llhd.prb %addr_hit : i32
      %614 = comb.extract %613 from 8 : (i32) -> i1
      %615 = comb.icmp ceq %614, %true : i1
      cf.cond_br %615, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %616 = llhd.prb %adc_fsm_rst_busy : i1
      llhd.drv %reg_busy_sel, %616 after %1 : i1
      cf.br ^bb54
    ^bb11:  // pred: ^bb9
      %617 = llhd.prb %addr_hit : i32
      %618 = comb.extract %617 from 9 : (i32) -> i1
      %619 = comb.icmp ceq %618, %true : i1
      cf.cond_br %619, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %620 = llhd.prb %adc_chn0_filter_ctl_0_busy : i1
      llhd.drv %reg_busy_sel, %620 after %1 : i1
      cf.br ^bb54
    ^bb13:  // pred: ^bb11
      %621 = llhd.prb %addr_hit : i32
      %622 = comb.extract %621 from 10 : (i32) -> i1
      %623 = comb.icmp ceq %622, %true : i1
      cf.cond_br %623, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %624 = llhd.prb %adc_chn0_filter_ctl_1_busy : i1
      llhd.drv %reg_busy_sel, %624 after %1 : i1
      cf.br ^bb54
    ^bb15:  // pred: ^bb13
      %625 = llhd.prb %addr_hit : i32
      %626 = comb.extract %625 from 11 : (i32) -> i1
      %627 = comb.icmp ceq %626, %true : i1
      cf.cond_br %627, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %628 = llhd.prb %adc_chn0_filter_ctl_2_busy : i1
      llhd.drv %reg_busy_sel, %628 after %1 : i1
      cf.br ^bb54
    ^bb17:  // pred: ^bb15
      %629 = llhd.prb %addr_hit : i32
      %630 = comb.extract %629 from 12 : (i32) -> i1
      %631 = comb.icmp ceq %630, %true : i1
      cf.cond_br %631, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      %632 = llhd.prb %adc_chn0_filter_ctl_3_busy : i1
      llhd.drv %reg_busy_sel, %632 after %1 : i1
      cf.br ^bb54
    ^bb19:  // pred: ^bb17
      %633 = llhd.prb %addr_hit : i32
      %634 = comb.extract %633 from 13 : (i32) -> i1
      %635 = comb.icmp ceq %634, %true : i1
      cf.cond_br %635, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %636 = llhd.prb %adc_chn0_filter_ctl_4_busy : i1
      llhd.drv %reg_busy_sel, %636 after %1 : i1
      cf.br ^bb54
    ^bb21:  // pred: ^bb19
      %637 = llhd.prb %addr_hit : i32
      %638 = comb.extract %637 from 14 : (i32) -> i1
      %639 = comb.icmp ceq %638, %true : i1
      cf.cond_br %639, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      %640 = llhd.prb %adc_chn0_filter_ctl_5_busy : i1
      llhd.drv %reg_busy_sel, %640 after %1 : i1
      cf.br ^bb54
    ^bb23:  // pred: ^bb21
      %641 = llhd.prb %addr_hit : i32
      %642 = comb.extract %641 from 15 : (i32) -> i1
      %643 = comb.icmp ceq %642, %true : i1
      cf.cond_br %643, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %644 = llhd.prb %adc_chn0_filter_ctl_6_busy : i1
      llhd.drv %reg_busy_sel, %644 after %1 : i1
      cf.br ^bb54
    ^bb25:  // pred: ^bb23
      %645 = llhd.prb %addr_hit : i32
      %646 = comb.extract %645 from 16 : (i32) -> i1
      %647 = comb.icmp ceq %646, %true : i1
      cf.cond_br %647, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      %648 = llhd.prb %adc_chn0_filter_ctl_7_busy : i1
      llhd.drv %reg_busy_sel, %648 after %1 : i1
      cf.br ^bb54
    ^bb27:  // pred: ^bb25
      %649 = llhd.prb %addr_hit : i32
      %650 = comb.extract %649 from 17 : (i32) -> i1
      %651 = comb.icmp ceq %650, %true : i1
      cf.cond_br %651, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      %652 = llhd.prb %adc_chn1_filter_ctl_0_busy : i1
      llhd.drv %reg_busy_sel, %652 after %1 : i1
      cf.br ^bb54
    ^bb29:  // pred: ^bb27
      %653 = llhd.prb %addr_hit : i32
      %654 = comb.extract %653 from 18 : (i32) -> i1
      %655 = comb.icmp ceq %654, %true : i1
      cf.cond_br %655, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %656 = llhd.prb %adc_chn1_filter_ctl_1_busy : i1
      llhd.drv %reg_busy_sel, %656 after %1 : i1
      cf.br ^bb54
    ^bb31:  // pred: ^bb29
      %657 = llhd.prb %addr_hit : i32
      %658 = comb.extract %657 from 19 : (i32) -> i1
      %659 = comb.icmp ceq %658, %true : i1
      cf.cond_br %659, ^bb32, ^bb33
    ^bb32:  // pred: ^bb31
      %660 = llhd.prb %adc_chn1_filter_ctl_2_busy : i1
      llhd.drv %reg_busy_sel, %660 after %1 : i1
      cf.br ^bb54
    ^bb33:  // pred: ^bb31
      %661 = llhd.prb %addr_hit : i32
      %662 = comb.extract %661 from 20 : (i32) -> i1
      %663 = comb.icmp ceq %662, %true : i1
      cf.cond_br %663, ^bb34, ^bb35
    ^bb34:  // pred: ^bb33
      %664 = llhd.prb %adc_chn1_filter_ctl_3_busy : i1
      llhd.drv %reg_busy_sel, %664 after %1 : i1
      cf.br ^bb54
    ^bb35:  // pred: ^bb33
      %665 = llhd.prb %addr_hit : i32
      %666 = comb.extract %665 from 21 : (i32) -> i1
      %667 = comb.icmp ceq %666, %true : i1
      cf.cond_br %667, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      %668 = llhd.prb %adc_chn1_filter_ctl_4_busy : i1
      llhd.drv %reg_busy_sel, %668 after %1 : i1
      cf.br ^bb54
    ^bb37:  // pred: ^bb35
      %669 = llhd.prb %addr_hit : i32
      %670 = comb.extract %669 from 22 : (i32) -> i1
      %671 = comb.icmp ceq %670, %true : i1
      cf.cond_br %671, ^bb38, ^bb39
    ^bb38:  // pred: ^bb37
      %672 = llhd.prb %adc_chn1_filter_ctl_5_busy : i1
      llhd.drv %reg_busy_sel, %672 after %1 : i1
      cf.br ^bb54
    ^bb39:  // pred: ^bb37
      %673 = llhd.prb %addr_hit : i32
      %674 = comb.extract %673 from 23 : (i32) -> i1
      %675 = comb.icmp ceq %674, %true : i1
      cf.cond_br %675, ^bb40, ^bb41
    ^bb40:  // pred: ^bb39
      %676 = llhd.prb %adc_chn1_filter_ctl_6_busy : i1
      llhd.drv %reg_busy_sel, %676 after %1 : i1
      cf.br ^bb54
    ^bb41:  // pred: ^bb39
      %677 = llhd.prb %addr_hit : i32
      %678 = comb.extract %677 from 24 : (i32) -> i1
      %679 = comb.icmp ceq %678, %true : i1
      cf.cond_br %679, ^bb42, ^bb43
    ^bb42:  // pred: ^bb41
      %680 = llhd.prb %adc_chn1_filter_ctl_7_busy : i1
      llhd.drv %reg_busy_sel, %680 after %1 : i1
      cf.br ^bb54
    ^bb43:  // pred: ^bb41
      %681 = llhd.prb %addr_hit : i32
      %682 = comb.extract %681 from 25 : (i32) -> i1
      %683 = comb.icmp ceq %682, %true : i1
      cf.cond_br %683, ^bb44, ^bb45
    ^bb44:  // pred: ^bb43
      %684 = llhd.prb %adc_chn_val_0_busy : i1
      llhd.drv %reg_busy_sel, %684 after %1 : i1
      cf.br ^bb54
    ^bb45:  // pred: ^bb43
      %685 = llhd.prb %addr_hit : i32
      %686 = comb.extract %685 from 26 : (i32) -> i1
      %687 = comb.icmp ceq %686, %true : i1
      cf.cond_br %687, ^bb46, ^bb47
    ^bb46:  // pred: ^bb45
      %688 = llhd.prb %adc_chn_val_1_busy : i1
      llhd.drv %reg_busy_sel, %688 after %1 : i1
      cf.br ^bb54
    ^bb47:  // pred: ^bb45
      %689 = llhd.prb %addr_hit : i32
      %690 = comb.extract %689 from 27 : (i32) -> i1
      %691 = comb.icmp ceq %690, %true : i1
      cf.cond_br %691, ^bb48, ^bb49
    ^bb48:  // pred: ^bb47
      %692 = llhd.prb %adc_wakeup_ctl_busy : i1
      llhd.drv %reg_busy_sel, %692 after %1 : i1
      cf.br ^bb54
    ^bb49:  // pred: ^bb47
      %693 = llhd.prb %addr_hit : i32
      %694 = comb.extract %693 from 28 : (i32) -> i1
      %695 = comb.icmp ceq %694, %true : i1
      cf.cond_br %695, ^bb50, ^bb51
    ^bb50:  // pred: ^bb49
      %696 = llhd.prb %filter_status_busy : i1
      llhd.drv %reg_busy_sel, %696 after %1 : i1
      cf.br ^bb54
    ^bb51:  // pred: ^bb49
      %697 = llhd.prb %addr_hit : i32
      %698 = comb.extract %697 from 31 : (i32) -> i1
      %699 = comb.icmp ceq %698, %true : i1
      cf.cond_br %699, ^bb52, ^bb53
    ^bb52:  // pred: ^bb51
      %700 = llhd.prb %adc_fsm_state_busy : i1
      llhd.drv %reg_busy_sel, %700 after %1 : i1
      cf.br ^bb54
    ^bb53:  // pred: ^bb51
      llhd.drv %reg_busy_sel, %false after %1 : i1
      cf.br ^bb54
    ^bb54:  // 27 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb22, ^bb24, ^bb26, ^bb28, ^bb30, ^bb32, ^bb34, ^bb36, ^bb38, ^bb40, ^bb42, ^bb44, ^bb46, ^bb48, ^bb50, ^bb52, ^bb53
      llhd.wait (%568, %467, %570, %571, %572, %573, %574, %575, %576, %577, %578, %579, %580, %581, %582, %583, %584, %585, %586, %587, %588, %589, %590, %591, %592, %593, %594, %595 : i1, i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %596 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    hw.output %u_rsp_intg_gen.tl_o, %596, %356 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>, i1
  }
  hw.module @adc_ctrl(in %clk_i : i1, in %clk_aon_i : i1, in %rst_ni : i1, in %rst_aon_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %alert_rx_i : !hw.array<1xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, out alert_tx_o : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>, out adc_o : !hw.struct<channel_sel: i2, pd: i1>, in %adc_i : !hw.struct<data: i10, data_valid: i1>, out intr_match_pending_o : i1, out wkup_req_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i0 = hw.constant 0 : i0
    %false = hw.constant false
    %1 = hw.aggregate_constant [[false, false], [[[0 : i10, false], [0 : i2, false], [0 : i10, false], [0 : i2, false]], [[0 : i10, false], [0 : i2, false], [0 : i10, false], [0 : i2, false]]], [[false, false], [0 : i8, false]], [[false, false], [false, false], [0 : i8, false]], [0 : i5]] : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, adc_chn_val: !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>, filter_status: !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_fsm_state: !hw.struct<d: i5>>
    %2 = hw.aggregate_constant [[false, false]] : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %alert_tx_o = llhd.sig %2 : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %hw2reg = llhd.sig %1 : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, adc_chn_val: !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>, filter_status: !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_fsm_state: !hw.struct<d: i5>>
    %alerts = llhd.sig %false : i1
    %3 = llhd.prb %alerts : i1
    %4 = hw.array_get %alert_rx_i[%c0_i0] : !hw.array<1xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, i0
    %5 = llhd.sig.array_get %alert_tx_o[%c0_i0] : <!hw.array<1xstruct<alert_p: i1, alert_n: i1>>>
    %gen_alert_tx_0.u_prim_alert_sender.alert_ack_o, %gen_alert_tx_0.u_prim_alert_sender.alert_state_o, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o = hw.instance "gen_alert_tx_0.u_prim_alert_sender" @prim_alert_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, alert_test_i: %13: i1, alert_req_i: %3: i1, alert_rx_i: %4: !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>) -> (alert_ack_o: i1, alert_state_o: i1, alert_tx_o: !hw.struct<alert_p: i1, alert_n: i1>)
    llhd.drv %5, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o after %0 : !hw.struct<alert_p: i1, alert_n: i1>
    %6 = llhd.prb %hw2reg : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, adc_chn_val: !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>, filter_status: !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_fsm_state: !hw.struct<d: i5>>
    %u_reg.tl_o, %u_reg.reg2hw, %u_reg.intg_err_o = hw.instance "u_reg" @adc_ctrl_reg_top(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clk_aon_i: %clk_aon_i: i1, rst_aon_ni: %rst_aon_ni: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, hw2reg: %6: !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, adc_chn_val: !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>, filter_status: !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_fsm_state: !hw.struct<d: i5>>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, reg2hw: !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>, intg_err_o: i1) {sv.namehint = "reg2hw"}
    llhd.drv %alerts, %u_reg.intg_err_o after %0 : i1
    %7 = llhd.sig.struct_extract %hw2reg["intr_state"] : <!hw.struct<intr_state: !hw.struct<d: i1, de: i1>, adc_chn_val: !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>, filter_status: !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_fsm_state: !hw.struct<d: i5>>>
    %8 = llhd.sig.struct_extract %hw2reg["adc_chn_val"] : <!hw.struct<intr_state: !hw.struct<d: i1, de: i1>, adc_chn_val: !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>, filter_status: !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_fsm_state: !hw.struct<d: i5>>>
    %9 = llhd.sig.struct_extract %hw2reg["adc_intr_status"] : <!hw.struct<intr_state: !hw.struct<d: i1, de: i1>, adc_chn_val: !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>, filter_status: !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_fsm_state: !hw.struct<d: i5>>>
    %10 = llhd.sig.struct_extract %hw2reg["filter_status"] : <!hw.struct<intr_state: !hw.struct<d: i1, de: i1>, adc_chn_val: !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>, filter_status: !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_fsm_state: !hw.struct<d: i5>>>
    %11 = llhd.sig.struct_extract %hw2reg["adc_fsm_state"] : <!hw.struct<intr_state: !hw.struct<d: i1, de: i1>, adc_chn_val: !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>, filter_status: !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, adc_fsm_state: !hw.struct<d: i5>>>
    %12 = llhd.sig.struct_extract %11["d"] : <!hw.struct<d: i5>>
    %u_adc_ctrl_core.intr_state_o, %u_adc_ctrl_core.adc_chn_val_o, %u_adc_ctrl_core.adc_intr_status_o, %u_adc_ctrl_core.aon_filter_status_o, %u_adc_ctrl_core.wkup_req_o, %u_adc_ctrl_core.intr_o, %u_adc_ctrl_core.adc_o, %u_adc_ctrl_core.aon_fsm_state_o = hw.instance "u_adc_ctrl_core" @adc_ctrl_core(clk_aon_i: %clk_aon_i: i1, rst_aon_ni: %rst_aon_ni: i1, clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, reg2hw_i: %u_reg.reg2hw: !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>, adc_i: %adc_i: !hw.struct<data: i10, data_valid: i1>) -> (intr_state_o: !hw.struct<d: i1, de: i1>, adc_chn_val_o: !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>, adc_intr_status_o: !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, aon_filter_status_o: !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>, wkup_req_o: i1, intr_o: i1, adc_o: !hw.struct<channel_sel: i2, pd: i1>, aon_fsm_state_o: i5)
    llhd.drv %7, %u_adc_ctrl_core.intr_state_o after %0 : !hw.struct<d: i1, de: i1>
    llhd.drv %8, %u_adc_ctrl_core.adc_chn_val_o after %0 : !hw.array<2xstruct<adc_chn_value_intr: !hw.struct<d: i10, de: i1>, adc_chn_value_intr_ext: !hw.struct<d: i2, de: i1>, adc_chn_value: !hw.struct<d: i10, de: i1>, adc_chn_value_ext: !hw.struct<d: i2, de: i1>>>
    llhd.drv %9, %u_adc_ctrl_core.adc_intr_status_o after %0 : !hw.struct<oneshot: !hw.struct<d: i1, de: i1>, trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>
    llhd.drv %10, %u_adc_ctrl_core.aon_filter_status_o after %0 : !hw.struct<trans: !hw.struct<d: i1, de: i1>, match: !hw.struct<d: i8, de: i1>>
    llhd.drv %12, %u_adc_ctrl_core.aon_fsm_state_o after %0 : i5
    %alert_test = hw.struct_extract %u_reg.reg2hw["alert_test"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, adc_en_ctl: !hw.struct<oneshot_mode: !hw.struct<q: i1>, adc_enable: !hw.struct<q: i1>>, adc_pd_ctl: !hw.struct<wakeup_time: !hw.struct<q: i24>, pwrup_time: !hw.struct<q: i4>, lp_mode: !hw.struct<q: i1>>, adc_lp_sample_ctl: !hw.struct<q: i8>, adc_sample_ctl: !hw.struct<q: i16>, adc_fsm_rst: !hw.struct<q: i1>, adc_chn0_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_chn1_filter_ctl: !hw.array<8xstruct<en: !hw.struct<q: i1>, max_v: !hw.struct<q: i10>, cond: !hw.struct<q: i1>, min_v: !hw.struct<q: i10>>>, adc_wakeup_ctl: !hw.struct<trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, filter_status: !hw.struct<trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>, adc_intr_ctl: !hw.struct<oneshot_en: !hw.struct<q: i1>, trans_en: !hw.struct<q: i1>, match_en: !hw.struct<q: i8>>, adc_intr_status: !hw.struct<oneshot: !hw.struct<q: i1>, trans: !hw.struct<q: i1>, match: !hw.struct<q: i8>>>
    %q = hw.struct_extract %alert_test["q"] : !hw.struct<q: i1, qe: i1>
    %qe = hw.struct_extract %alert_test["qe"] : !hw.struct<q: i1, qe: i1>
    %13 = comb.and %q, %qe : i1
    %14 = llhd.prb %alert_tx_o : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    hw.output %u_reg.tl_o, %14, %u_adc_ctrl_core.adc_o, %u_adc_ctrl_core.intr_o, %u_adc_ctrl_core.wkup_req_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.array<1xstruct<alert_p: i1, alert_n: i1>>, !hw.struct<channel_sel: i2, pd: i1>, i1, i1
  }
}
