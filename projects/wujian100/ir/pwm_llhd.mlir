module {
  hw.module private @clk_mux2(in %clk_sel : i1, in %clk_a : i1, in %clk_b : i1, out clk_out : i1) {
    %x_STD_clkmux2.X = hw.instance "x_STD_clkmux2" @Standard_Cell_CLK_MUX2(S: %clk_sel: i1, D0: %clk_a: i1, D1: %clk_b: i1) -> (X: i1)
    hw.output %x_STD_clkmux2.X : i1
  }
  hw.module private @gated_clk_cell(in %clk_in : i1, in %global_en : i1, in %module_en : i1, in %local_en : i1, in %external_en : i1, in %pad_yy_test_mode : i1, in %pad_yy_gate_clk_en_b : i1, out clk_out : i1) {
    %0 = comb.or %module_en, %local_en : i1
    %1 = comb.and %global_en, %0 : i1
    %2 = comb.or %1, %external_en {sv.namehint = "clk_en_bf_latch"} : i1
    %3 = comb.or %pad_yy_test_mode, %pad_yy_gate_clk_en_b {sv.namehint = "SE"} : i1
    %x_gated_clk_cell.Q = hw.instance "x_gated_clk_cell" @Standard_Cell_CLK_GATE(CK: %clk_in: i1, EN: %2: i1, SE: %3: i1) -> (Q: i1)
    hw.output %x_gated_clk_cell.Q : i1
  }
  hw.module private @Standard_Cell_CLK_GATE(out Q : i1, in %CK : i1, in %EN : i1, in %SE : i1) {
    %true = hw.constant true
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %CK_0 = llhd.sig name "CK" %false : i1
    %1 = llhd.prb %CK_0 : i1
    %E = llhd.sig %false : i1
    %2 = llhd.prb %E : i1
    %q_tmp = llhd.sig %false : i1
    %3 = comb.or %SE, %EN : i1
    llhd.drv %E, %3 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 3 preds: ^bb0, ^bb2, ^bb3
      llhd.wait (%2, %1 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %6 = llhd.prb %CK_0 : i1
      %7 = comb.xor %6, %true : i1
      cf.cond_br %7, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %8 = llhd.prb %E : i1
      llhd.drv %q_tmp, %8 after %0 : i1
      cf.br ^bb1
    }
    %4 = llhd.prb %q_tmp : i1
    %5 = comb.and %4, %1 : i1
    llhd.drv %CK_0, %CK after %0 : i1
    hw.output %5 : i1
  }
  hw.module private @Standard_Cell_CLK_MUX2(out X : i1, in %S : i1, in %D0 : i1, in %D1 : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %D0_0 = llhd.sig name "D0" %false : i1
    %D1_1 = llhd.sig name "D1" %false : i1
    %1 = llhd.prb %D1_1 : i1
    %2 = llhd.prb %D0_0 : i1
    %3 = comb.mux %S, %1, %2 : i1
    llhd.drv %D0_0, %D0 after %0 : i1
    llhd.drv %D1_1, %D1 after %0 : i1
    hw.output %3 : i1
  }
  hw.module private @pwm(in %etb_pwm_trig_tim0_off : i1, in %etb_pwm_trig_tim0_on : i1, in %etb_pwm_trig_tim1_off : i1, in %etb_pwm_trig_tim1_on : i1, in %etb_pwm_trig_tim2_off : i1, in %etb_pwm_trig_tim2_on : i1, in %etb_pwm_trig_tim3_off : i1, in %etb_pwm_trig_tim3_on : i1, in %etb_pwm_trig_tim4_off : i1, in %etb_pwm_trig_tim4_on : i1, in %etb_pwm_trig_tim5_off : i1, in %etb_pwm_trig_tim5_on : i1, in %fault : i1, in %i_capedge0 : i1, in %i_capedge10 : i1, in %i_capedge2 : i1, in %i_capedge4 : i1, in %i_capedge6 : i1, in %i_capedge8 : i1, out o_pwm0 : i1, out o_pwm1 : i1, out o_pwm10 : i1, out o_pwm11 : i1, out o_pwm2 : i1, out o_pwm3 : i1, out o_pwm4 : i1, out o_pwm5 : i1, out o_pwm6 : i1, out o_pwm7 : i1, out o_pwm8 : i1, out o_pwm9 : i1, in %paddr : i32, in %pclk : i1, in %penable : i1, out prdata : i32, in %presetn : i1, in %psel : i1, in %pwdata : i32, out pwm0oe_n : i1, out pwm10oe_n : i1, out pwm11oe_n : i1, out pwm1oe_n : i1, out pwm2oe_n : i1, out pwm3oe_n : i1, out pwm4oe_n : i1, out pwm5oe_n : i1, out pwm6oe_n : i1, out pwm7oe_n : i1, out pwm8oe_n : i1, out pwm9oe_n : i1, out pwm_idle : i1, out pwm_tim0_etb_trig : i1, out pwm_tim1_etb_trig : i1, out pwm_tim2_etb_trig : i1, out pwm_tim3_etb_trig : i1, out pwm_tim4_etb_trig : i1, out pwm_tim5_etb_trig : i1, out pwm_xx_trig : i1, out pwmint : i1, in %pwrite : i1, in %test_mode : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %false = hw.constant false
    %fault_d = llhd.sig %false : i1
    %fault_d2 = llhd.sig %false : i1
    %fault_0 = llhd.sig name "fault" %false : i1
    %pclk_1 = llhd.sig name "pclk" %false : i1
    %2 = llhd.prb %pclk_1 : i1
    %presetn_2 = llhd.sig name "presetn" %false : i1
    %3 = llhd.prb %presetn_2 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %17 = llhd.prb %pclk_1 : i1
      %18 = llhd.prb %presetn_2 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %19 = llhd.prb %pclk_1 : i1
      %20 = comb.xor bin %17, %true : i1
      %21 = comb.and bin %20, %19 : i1
      %22 = llhd.prb %presetn_2 : i1
      %23 = comb.xor bin %22, %true : i1
      %24 = comb.and bin %18, %23 : i1
      %25 = comb.or bin %21, %24 : i1
      cf.cond_br %25, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %26 = llhd.prb %presetn_2 : i1
      %27 = comb.xor %26, %true : i1
      cf.cond_br %27, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %fault_d, %false after %1 : i1
      llhd.drv %fault_d2, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %28 = llhd.prb %fault_0 : i1
      llhd.drv %fault_d, %28 after %1 : i1
      %29 = llhd.prb %fault_d : i1
      llhd.drv %fault_d2, %29 after %1 : i1
      cf.br ^bb1
    }
    %4 = llhd.prb %fault_d2 : i1
    %x_pwm_ctrl.cap01t, %x_pwm_ctrl.cap01t_h, %x_pwm_ctrl.cap23t, %x_pwm_ctrl.cap23t_h, %x_pwm_ctrl.cap45t, %x_pwm_ctrl.cap45t_h, %x_pwm_ctrl.capis, %x_pwm_ctrl.capris, %x_pwm_ctrl.cnt0val, %x_pwm_ctrl.cnt1val, %x_pwm_ctrl.cnt2val, %x_pwm_ctrl.cnt3val, %x_pwm_ctrl.cnt4val, %x_pwm_ctrl.cnt5val, %x_pwm_ctrl.pwm01count, %x_pwm_ctrl.pwm01count_h, %x_pwm_ctrl.pwm23count, %x_pwm_ctrl.pwm23count_h, %x_pwm_ctrl.pwm45count, %x_pwm_ctrl.pwm45count_h, %x_pwm_ctrl.pwm_0_oe, %x_pwm_ctrl.pwm_0_out, %x_pwm_ctrl.pwm_10_oe, %x_pwm_ctrl.pwm_10_out, %x_pwm_ctrl.pwm_11_oe, %x_pwm_ctrl.pwm_11_out, %x_pwm_ctrl.pwm_1_oe, %x_pwm_ctrl.pwm_1_out, %x_pwm_ctrl.pwm_2_oe, %x_pwm_ctrl.pwm_2_out, %x_pwm_ctrl.pwm_3_oe, %x_pwm_ctrl.pwm_3_out, %x_pwm_ctrl.pwm_4_oe, %x_pwm_ctrl.pwm_4_out, %x_pwm_ctrl.pwm_5_oe, %x_pwm_ctrl.pwm_5_out, %x_pwm_ctrl.pwm_6_oe, %x_pwm_ctrl.pwm_6_out, %x_pwm_ctrl.pwm_7_oe, %x_pwm_ctrl.pwm_7_out, %x_pwm_ctrl.pwm_8_oe, %x_pwm_ctrl.pwm_8_out, %x_pwm_ctrl.pwm_9_oe, %x_pwm_ctrl.pwm_9_out, %x_pwm_ctrl.pwm_idle, %x_pwm_ctrl.pwm_tim0_etb_trig, %x_pwm_ctrl.pwm_tim1_etb_trig, %x_pwm_ctrl.pwm_tim2_etb_trig, %x_pwm_ctrl.pwm_tim3_etb_trig, %x_pwm_ctrl.pwm_tim4_etb_trig, %x_pwm_ctrl.pwm_tim5_etb_trig, %x_pwm_ctrl.pwm_xx_trig, %x_pwm_ctrl.pwmint, %x_pwm_ctrl.pwmis1, %x_pwm_ctrl.pwmis2, %x_pwm_ctrl.pwmris1, %x_pwm_ctrl.pwmris2, %x_pwm_ctrl.tim01count, %x_pwm_ctrl.tim01count_h, %x_pwm_ctrl.tim23count, %x_pwm_ctrl.tim23count_h, %x_pwm_ctrl.tim45count, %x_pwm_ctrl.tim45count_h, %x_pwm_ctrl.timis, %x_pwm_ctrl.timris = hw.instance "x_pwm_ctrl" @pwm_ctrl(cap0cntic: %x_pwm_apbif.cap0cntic: i1, cap0cntie: %x_pwm_apbif.cap0cntie: i1, cap0en: %x_pwm_apbif.cap0en: i1, cap0eventa: %x_pwm_apbif.cap0eventa: i2, cap0match: %x_pwm_apbif.cap0match: i32, cap0mode: %x_pwm_apbif.cap0mode: i1, cap0timic: %x_pwm_apbif.cap0timic: i1, cap0timie: %x_pwm_apbif.cap0timie: i1, cap1cntic: %x_pwm_apbif.cap1cntic: i1, cap1cntie: %x_pwm_apbif.cap1cntie: i1, cap1en: %x_pwm_apbif.cap1en: i1, cap1eventa: %x_pwm_apbif.cap1eventa: i2, cap1match: %x_pwm_apbif.cap1match: i32, cap1mode: %x_pwm_apbif.cap1mode: i1, cap1timic: %x_pwm_apbif.cap1timic: i1, cap1timie: %x_pwm_apbif.cap1timie: i1, cap2cntic: %x_pwm_apbif.cap2cntic: i1, cap2cntie: %x_pwm_apbif.cap2cntie: i1, cap2en: %x_pwm_apbif.cap2en: i1, cap2eventa: %x_pwm_apbif.cap2eventa: i2, cap2match: %x_pwm_apbif.cap2match: i32, cap2mode: %x_pwm_apbif.cap2mode: i1, cap2timic: %x_pwm_apbif.cap2timic: i1, cap2timie: %x_pwm_apbif.cap2timie: i1, cap3cntic: %x_pwm_apbif.cap3cntic: i1, cap3cntie: %x_pwm_apbif.cap3cntie: i1, cap3en: %x_pwm_apbif.cap3en: i1, cap3eventa: %x_pwm_apbif.cap3eventa: i2, cap3match: %x_pwm_apbif.cap3match: i32, cap3mode: %x_pwm_apbif.cap3mode: i1, cap3timic: %x_pwm_apbif.cap3timic: i1, cap3timie: %x_pwm_apbif.cap3timie: i1, cap4cntic: %x_pwm_apbif.cap4cntic: i1, cap4cntie: %x_pwm_apbif.cap4cntie: i1, cap4en: %x_pwm_apbif.cap4en: i1, cap4eventa: %x_pwm_apbif.cap4eventa: i2, cap4match: %x_pwm_apbif.cap4match: i32, cap4mode: %x_pwm_apbif.cap4mode: i1, cap4timic: %x_pwm_apbif.cap4timic: i1, cap4timie: %x_pwm_apbif.cap4timie: i1, cap5cntic: %x_pwm_apbif.cap5cntic: i1, cap5cntie: %x_pwm_apbif.cap5cntie: i1, cap5en: %x_pwm_apbif.cap5en: i1, cap5eventa: %x_pwm_apbif.cap5eventa: i2, cap5match: %x_pwm_apbif.cap5match: i32, cap5mode: %x_pwm_apbif.cap5mode: i1, cap5timic: %x_pwm_apbif.cap5timic: i1, cap5timie: %x_pwm_apbif.cap5timie: i1, cntdiv: %x_pwm_apbif.cntdiv: i3, cntdiven: %x_pwm_apbif.cntdiven: i1, compa_val_0: %x_pwm_apbif.compa_val_0: i32, compa_val_1: %x_pwm_apbif.compa_val_1: i32, compa_val_2: %x_pwm_apbif.compa_val_2: i32, compa_val_3: %x_pwm_apbif.compa_val_3: i32, compa_val_4: %x_pwm_apbif.compa_val_4: i32, compa_val_5: %x_pwm_apbif.compa_val_5: i32, compb_val_0: %x_pwm_apbif.compb_val_0: i32, compb_val_1: %x_pwm_apbif.compb_val_1: i32, compb_val_2: %x_pwm_apbif.compb_val_2: i32, compb_val_3: %x_pwm_apbif.compb_val_3: i32, compb_val_4: %x_pwm_apbif.compb_val_4: i32, compb_val_5: %x_pwm_apbif.compb_val_5: i32, db0en: %x_pwm_apbif.db0en: i1, db1en: %x_pwm_apbif.db1en: i1, db2en: %x_pwm_apbif.db2en: i1, db3en: %x_pwm_apbif.db3en: i1, db4en: %x_pwm_apbif.db4en: i1, db5en: %x_pwm_apbif.db5en: i1, delay0: %x_pwm_apbif.delay0: i12, delay1: %x_pwm_apbif.delay1: i12, delay2: %x_pwm_apbif.delay2: i12, delay3: %x_pwm_apbif.delay3: i12, delay4: %x_pwm_apbif.delay4: i12, delay5: %x_pwm_apbif.delay5: i12, fault: %4: i1, i_capture_0: %i_capedge0: i1, i_capture_10: %i_capedge10: i1, i_capture_2: %i_capedge2: i1, i_capture_4: %i_capedge4: i1, i_capture_6: %i_capedge6: i1, i_capture_8: %i_capedge8: i1, int0encmpad: %x_pwm_apbif.int0encmpad: i1, int0encmpau: %x_pwm_apbif.int0encmpau: i1, int0encmpbd: %x_pwm_apbif.int0encmpbd: i1, int0encmpbu: %x_pwm_apbif.int0encmpbu: i1, int0encntload: %x_pwm_apbif.int0encntload: i1, int0encntzero: %x_pwm_apbif.int0encntzero: i1, int1encmpad: %x_pwm_apbif.int1encmpad: i1, int1encmpau: %x_pwm_apbif.int1encmpau: i1, int1encmpbd: %x_pwm_apbif.int1encmpbd: i1, int1encmpbu: %x_pwm_apbif.int1encmpbu: i1, int1encntload: %x_pwm_apbif.int1encntload: i1, int1encntzero: %x_pwm_apbif.int1encntzero: i1, int2encmpad: %x_pwm_apbif.int2encmpad: i1, int2encmpau: %x_pwm_apbif.int2encmpau: i1, int2encmpbd: %x_pwm_apbif.int2encmpbd: i1, int2encmpbu: %x_pwm_apbif.int2encmpbu: i1, int2encntload: %x_pwm_apbif.int2encntload: i1, int2encntzero: %x_pwm_apbif.int2encntzero: i1, int3encmpad: %x_pwm_apbif.int3encmpad: i1, int3encmpau: %x_pwm_apbif.int3encmpau: i1, int3encmpbd: %x_pwm_apbif.int3encmpbd: i1, int3encmpbu: %x_pwm_apbif.int3encmpbu: i1, int3encntload: %x_pwm_apbif.int3encntload: i1, int3encntzero: %x_pwm_apbif.int3encntzero: i1, int4encmpad: %x_pwm_apbif.int4encmpad: i1, int4encmpau: %x_pwm_apbif.int4encmpau: i1, int4encmpbd: %x_pwm_apbif.int4encmpbd: i1, int4encmpbu: %x_pwm_apbif.int4encmpbu: i1, int4encntload: %x_pwm_apbif.int4encntload: i1, int4encntzero: %x_pwm_apbif.int4encntzero: i1, int5encmpad: %x_pwm_apbif.int5encmpad: i1, int5encmpau: %x_pwm_apbif.int5encmpau: i1, int5encmpbd: %x_pwm_apbif.int5encmpbd: i1, int5encmpbu: %x_pwm_apbif.int5encmpbu: i1, int5encntload: %x_pwm_apbif.int5encntload: i1, int5encntzero: %x_pwm_apbif.int5encntzero: i1, intenfault: %x_pwm_apbif.intenfault: i1, intic0cmpad: %x_pwm_apbif.intic0cmpad: i1, intic0cmpau: %x_pwm_apbif.intic0cmpau: i1, intic0cmpbd: %x_pwm_apbif.intic0cmpbd: i1, intic0cmpbu: %x_pwm_apbif.intic0cmpbu: i1, intic0cntload: %x_pwm_apbif.intic0cntload: i1, intic0cntzero: %x_pwm_apbif.intic0cntzero: i1, intic1cmpad: %x_pwm_apbif.intic1cmpad: i1, intic1cmpau: %x_pwm_apbif.intic1cmpau: i1, intic1cmpbd: %x_pwm_apbif.intic1cmpbd: i1, intic1cmpbu: %x_pwm_apbif.intic1cmpbu: i1, intic1cntload: %x_pwm_apbif.intic1cntload: i1, intic1cntzero: %x_pwm_apbif.intic1cntzero: i1, intic2cmpad: %x_pwm_apbif.intic2cmpad: i1, intic2cmpau: %x_pwm_apbif.intic2cmpau: i1, intic2cmpbd: %x_pwm_apbif.intic2cmpbd: i1, intic2cmpbu: %x_pwm_apbif.intic2cmpbu: i1, intic2cntload: %x_pwm_apbif.intic2cntload: i1, intic2cntzero: %x_pwm_apbif.intic2cntzero: i1, intic3cmpad: %x_pwm_apbif.intic3cmpad: i1, intic3cmpau: %x_pwm_apbif.intic3cmpau: i1, intic3cmpbd: %x_pwm_apbif.intic3cmpbd: i1, intic3cmpbu: %x_pwm_apbif.intic3cmpbu: i1, intic3cntload: %x_pwm_apbif.intic3cntload: i1, intic3cntzero: %x_pwm_apbif.intic3cntzero: i1, intic4cmpad: %x_pwm_apbif.intic4cmpad: i1, intic4cmpau: %x_pwm_apbif.intic4cmpau: i1, intic4cmpbd: %x_pwm_apbif.intic4cmpbd: i1, intic4cmpbu: %x_pwm_apbif.intic4cmpbu: i1, intic4cntload: %x_pwm_apbif.intic4cntload: i1, intic4cntzero: %x_pwm_apbif.intic4cntzero: i1, intic5cmpad: %x_pwm_apbif.intic5cmpad: i1, intic5cmpau: %x_pwm_apbif.intic5cmpau: i1, intic5cmpbd: %x_pwm_apbif.intic5cmpbd: i1, intic5cmpbu: %x_pwm_apbif.intic5cmpbu: i1, intic5cntload: %x_pwm_apbif.intic5cntload: i1, intic5cntzero: %x_pwm_apbif.intic5cntzero: i1, inticfault: %x_pwm_apbif.inticfault: i1, pclk: %2: i1, presetn: %3: i1, pwm0en: %x_pwm_apbif.pwm0en: i1, pwm0inv: %x_pwm_apbif.pwm0inv: i1, pwm0load: %x_pwm_apbif.pwm0load: i32, pwm0mode: %x_pwm_apbif.pwm0mode: i1, pwm0trig_val: %x_pwm_apbif.pwm0trig_val: i32, pwm10en: %x_pwm_apbif.pwm10en: i1, pwm10inv: %x_pwm_apbif.pwm10inv: i1, pwm11en: %x_pwm_apbif.pwm11en: i1, pwm11inv: %x_pwm_apbif.pwm11inv: i1, pwm1en: %x_pwm_apbif.pwm1en: i1, pwm1inv: %x_pwm_apbif.pwm1inv: i1, pwm1load: %x_pwm_apbif.pwm1load: i32, pwm1mode: %x_pwm_apbif.pwm1mode: i1, pwm1trig_val: %x_pwm_apbif.pwm1trig_val: i32, pwm2en: %x_pwm_apbif.pwm2en: i1, pwm2inv: %x_pwm_apbif.pwm2inv: i1, pwm2load: %x_pwm_apbif.pwm2load: i32, pwm2mode: %x_pwm_apbif.pwm2mode: i1, pwm2trig_val: %x_pwm_apbif.pwm2trig_val: i32, pwm3en: %x_pwm_apbif.pwm3en: i1, pwm3inv: %x_pwm_apbif.pwm3inv: i1, pwm3load: %x_pwm_apbif.pwm3load: i32, pwm3mode: %x_pwm_apbif.pwm3mode: i1, pwm3trig_val: %x_pwm_apbif.pwm3trig_val: i32, pwm4en: %x_pwm_apbif.pwm4en: i1, pwm4inv: %x_pwm_apbif.pwm4inv: i1, pwm4load: %x_pwm_apbif.pwm4load: i32, pwm4mode: %x_pwm_apbif.pwm4mode: i1, pwm4trig_val: %x_pwm_apbif.pwm4trig_val: i32, pwm5en: %x_pwm_apbif.pwm5en: i1, pwm5inv: %x_pwm_apbif.pwm5inv: i1, pwm5load: %x_pwm_apbif.pwm5load: i32, pwm5mode: %x_pwm_apbif.pwm5mode: i1, pwm5trig_val: %x_pwm_apbif.pwm5trig_val: i32, pwm6en: %x_pwm_apbif.pwm6en: i1, pwm6inv: %x_pwm_apbif.pwm6inv: i1, pwm7en: %x_pwm_apbif.pwm7en: i1, pwm7inv: %x_pwm_apbif.pwm7inv: i1, pwm8en: %x_pwm_apbif.pwm8en: i1, pwm8inv: %x_pwm_apbif.pwm8inv: i1, pwm9en: %x_pwm_apbif.pwm9en: i1, pwm9inv: %x_pwm_apbif.pwm9inv: i1, sync0mode: %x_pwm_apbif.sync0mode: i2, sync1mode: %x_pwm_apbif.sync1mode: i2, sync2mode: %x_pwm_apbif.sync2mode: i2, sync3mode: %x_pwm_apbif.sync3mode: i2, sync4mode: %x_pwm_apbif.sync4mode: i2, sync5mode: %x_pwm_apbif.sync5mode: i2, test_mode: %test_mode: i1, tim0en: %x_pwm_apbif.tim0en: i1, tim0ic: %x_pwm_apbif.tim0ic: i1, tim0ie: %x_pwm_apbif.tim0ie: i1, tim0load: %x_pwm_apbif.tim0load: i32, tim1en: %x_pwm_apbif.tim1en: i1, tim1ic: %x_pwm_apbif.tim1ic: i1, tim1ie: %x_pwm_apbif.tim1ie: i1, tim1load: %x_pwm_apbif.tim1load: i32, tim2en: %x_pwm_apbif.tim2en: i1, tim2ic: %x_pwm_apbif.tim2ic: i1, tim2ie: %x_pwm_apbif.tim2ie: i1, tim2load: %x_pwm_apbif.tim2load: i32, tim3en: %x_pwm_apbif.tim3en: i1, tim3ic: %x_pwm_apbif.tim3ic: i1, tim3ie: %x_pwm_apbif.tim3ie: i1, tim3load: %x_pwm_apbif.tim3load: i32, tim4en: %x_pwm_apbif.tim4en: i1, tim4ic: %x_pwm_apbif.tim4ic: i1, tim4ie: %x_pwm_apbif.tim4ie: i1, tim4load: %x_pwm_apbif.tim4load: i32, tim5en: %x_pwm_apbif.tim5en: i1, tim5ic: %x_pwm_apbif.tim5ic: i1, tim5ie: %x_pwm_apbif.tim5ie: i1, tim5load: %x_pwm_apbif.tim5load: i32, tr0end: %x_pwm_apbif.tr0end: i1, tr0enu: %x_pwm_apbif.tr0enu: i1, tr1end: %x_pwm_apbif.tr1end: i1, tr1enu: %x_pwm_apbif.tr1enu: i1, tr2end: %x_pwm_apbif.tr2end: i1, tr2enu: %x_pwm_apbif.tr2enu: i1, tr3end: %x_pwm_apbif.tr3end: i1, tr3enu: %x_pwm_apbif.tr3enu: i1, tr4end: %x_pwm_apbif.tr4end: i1, tr4enu: %x_pwm_apbif.tr4enu: i1, tr5end: %x_pwm_apbif.tr5end: i1, tr5enu: %x_pwm_apbif.tr5enu: i1, triginv: %x_pwm_apbif.triginv: i1) -> (cap01t: i32, cap01t_h: i32, cap23t: i32, cap23t_h: i32, cap45t: i32, cap45t_h: i32, capis: i32, capris: i32, cnt0val: i32, cnt1val: i32, cnt2val: i32, cnt3val: i32, cnt4val: i32, cnt5val: i32, pwm01count: i32, pwm01count_h: i32, pwm23count: i32, pwm23count_h: i32, pwm45count: i32, pwm45count_h: i32, pwm_0_oe: i1, pwm_0_out: i1, pwm_10_oe: i1, pwm_10_out: i1, pwm_11_oe: i1, pwm_11_out: i1, pwm_1_oe: i1, pwm_1_out: i1, pwm_2_oe: i1, pwm_2_out: i1, pwm_3_oe: i1, pwm_3_out: i1, pwm_4_oe: i1, pwm_4_out: i1, pwm_5_oe: i1, pwm_5_out: i1, pwm_6_oe: i1, pwm_6_out: i1, pwm_7_oe: i1, pwm_7_out: i1, pwm_8_oe: i1, pwm_8_out: i1, pwm_9_oe: i1, pwm_9_out: i1, pwm_idle: i1, pwm_tim0_etb_trig: i1, pwm_tim1_etb_trig: i1, pwm_tim2_etb_trig: i1, pwm_tim3_etb_trig: i1, pwm_tim4_etb_trig: i1, pwm_tim5_etb_trig: i1, pwm_xx_trig: i1, pwmint: i1, pwmis1: i32, pwmis2: i32, pwmris1: i32, pwmris2: i32, tim01count: i32, tim01count_h: i32, tim23count: i32, tim23count_h: i32, tim45count: i32, tim45count_h: i32, timis: i32, timris: i32) {sv.namehint = "timis"}
    %x_pwm_apbif.cap0cntic, %x_pwm_apbif.cap0cntie, %x_pwm_apbif.cap0en, %x_pwm_apbif.cap0eventa, %x_pwm_apbif.cap0match, %x_pwm_apbif.cap0mode, %x_pwm_apbif.cap0timic, %x_pwm_apbif.cap0timie, %x_pwm_apbif.cap1cntic, %x_pwm_apbif.cap1cntie, %x_pwm_apbif.cap1en, %x_pwm_apbif.cap1eventa, %x_pwm_apbif.cap1match, %x_pwm_apbif.cap1mode, %x_pwm_apbif.cap1timic, %x_pwm_apbif.cap1timie, %x_pwm_apbif.cap2cntic, %x_pwm_apbif.cap2cntie, %x_pwm_apbif.cap2en, %x_pwm_apbif.cap2eventa, %x_pwm_apbif.cap2match, %x_pwm_apbif.cap2mode, %x_pwm_apbif.cap2timic, %x_pwm_apbif.cap2timie, %x_pwm_apbif.cap3cntic, %x_pwm_apbif.cap3cntie, %x_pwm_apbif.cap3en, %x_pwm_apbif.cap3eventa, %x_pwm_apbif.cap3match, %x_pwm_apbif.cap3mode, %x_pwm_apbif.cap3timic, %x_pwm_apbif.cap3timie, %x_pwm_apbif.cap4cntic, %x_pwm_apbif.cap4cntie, %x_pwm_apbif.cap4en, %x_pwm_apbif.cap4eventa, %x_pwm_apbif.cap4match, %x_pwm_apbif.cap4mode, %x_pwm_apbif.cap4timic, %x_pwm_apbif.cap4timie, %x_pwm_apbif.cap5cntic, %x_pwm_apbif.cap5cntie, %x_pwm_apbif.cap5en, %x_pwm_apbif.cap5eventa, %x_pwm_apbif.cap5match, %x_pwm_apbif.cap5mode, %x_pwm_apbif.cap5timic, %x_pwm_apbif.cap5timie, %x_pwm_apbif.cntdiv, %x_pwm_apbif.cntdiven, %x_pwm_apbif.compa_val_0, %x_pwm_apbif.compa_val_1, %x_pwm_apbif.compa_val_2, %x_pwm_apbif.compa_val_3, %x_pwm_apbif.compa_val_4, %x_pwm_apbif.compa_val_5, %x_pwm_apbif.compb_val_0, %x_pwm_apbif.compb_val_1, %x_pwm_apbif.compb_val_2, %x_pwm_apbif.compb_val_3, %x_pwm_apbif.compb_val_4, %x_pwm_apbif.compb_val_5, %x_pwm_apbif.db0en, %x_pwm_apbif.db1en, %x_pwm_apbif.db2en, %x_pwm_apbif.db3en, %x_pwm_apbif.db4en, %x_pwm_apbif.db5en, %x_pwm_apbif.delay0, %x_pwm_apbif.delay1, %x_pwm_apbif.delay2, %x_pwm_apbif.delay3, %x_pwm_apbif.delay4, %x_pwm_apbif.delay5, %x_pwm_apbif.int0encmpad, %x_pwm_apbif.int0encmpau, %x_pwm_apbif.int0encmpbd, %x_pwm_apbif.int0encmpbu, %x_pwm_apbif.int0encntload, %x_pwm_apbif.int0encntzero, %x_pwm_apbif.int1encmpad, %x_pwm_apbif.int1encmpau, %x_pwm_apbif.int1encmpbd, %x_pwm_apbif.int1encmpbu, %x_pwm_apbif.int1encntload, %x_pwm_apbif.int1encntzero, %x_pwm_apbif.int2encmpad, %x_pwm_apbif.int2encmpau, %x_pwm_apbif.int2encmpbd, %x_pwm_apbif.int2encmpbu, %x_pwm_apbif.int2encntload, %x_pwm_apbif.int2encntzero, %x_pwm_apbif.int3encmpad, %x_pwm_apbif.int3encmpau, %x_pwm_apbif.int3encmpbd, %x_pwm_apbif.int3encmpbu, %x_pwm_apbif.int3encntload, %x_pwm_apbif.int3encntzero, %x_pwm_apbif.int4encmpad, %x_pwm_apbif.int4encmpau, %x_pwm_apbif.int4encmpbd, %x_pwm_apbif.int4encmpbu, %x_pwm_apbif.int4encntload, %x_pwm_apbif.int4encntzero, %x_pwm_apbif.int5encmpad, %x_pwm_apbif.int5encmpau, %x_pwm_apbif.int5encmpbd, %x_pwm_apbif.int5encmpbu, %x_pwm_apbif.int5encntload, %x_pwm_apbif.int5encntzero, %x_pwm_apbif.intenfault, %x_pwm_apbif.intic0cmpad, %x_pwm_apbif.intic0cmpau, %x_pwm_apbif.intic0cmpbd, %x_pwm_apbif.intic0cmpbu, %x_pwm_apbif.intic0cntload, %x_pwm_apbif.intic0cntzero, %x_pwm_apbif.intic1cmpad, %x_pwm_apbif.intic1cmpau, %x_pwm_apbif.intic1cmpbd, %x_pwm_apbif.intic1cmpbu, %x_pwm_apbif.intic1cntload, %x_pwm_apbif.intic1cntzero, %x_pwm_apbif.intic2cmpad, %x_pwm_apbif.intic2cmpau, %x_pwm_apbif.intic2cmpbd, %x_pwm_apbif.intic2cmpbu, %x_pwm_apbif.intic2cntload, %x_pwm_apbif.intic2cntzero, %x_pwm_apbif.intic3cmpad, %x_pwm_apbif.intic3cmpau, %x_pwm_apbif.intic3cmpbd, %x_pwm_apbif.intic3cmpbu, %x_pwm_apbif.intic3cntload, %x_pwm_apbif.intic3cntzero, %x_pwm_apbif.intic4cmpad, %x_pwm_apbif.intic4cmpau, %x_pwm_apbif.intic4cmpbd, %x_pwm_apbif.intic4cmpbu, %x_pwm_apbif.intic4cntload, %x_pwm_apbif.intic4cntzero, %x_pwm_apbif.intic5cmpad, %x_pwm_apbif.intic5cmpau, %x_pwm_apbif.intic5cmpbd, %x_pwm_apbif.intic5cmpbu, %x_pwm_apbif.intic5cntload, %x_pwm_apbif.intic5cntzero, %x_pwm_apbif.inticfault, %x_pwm_apbif.prdata, %x_pwm_apbif.pwm0en, %x_pwm_apbif.pwm0inv, %x_pwm_apbif.pwm0load, %x_pwm_apbif.pwm0mode, %x_pwm_apbif.pwm0trig_val, %x_pwm_apbif.pwm10en, %x_pwm_apbif.pwm10inv, %x_pwm_apbif.pwm11en, %x_pwm_apbif.pwm11inv, %x_pwm_apbif.pwm1en, %x_pwm_apbif.pwm1inv, %x_pwm_apbif.pwm1load, %x_pwm_apbif.pwm1mode, %x_pwm_apbif.pwm1trig_val, %x_pwm_apbif.pwm2en, %x_pwm_apbif.pwm2inv, %x_pwm_apbif.pwm2load, %x_pwm_apbif.pwm2mode, %x_pwm_apbif.pwm2trig_val, %x_pwm_apbif.pwm3en, %x_pwm_apbif.pwm3inv, %x_pwm_apbif.pwm3load, %x_pwm_apbif.pwm3mode, %x_pwm_apbif.pwm3trig_val, %x_pwm_apbif.pwm4en, %x_pwm_apbif.pwm4inv, %x_pwm_apbif.pwm4load, %x_pwm_apbif.pwm4mode, %x_pwm_apbif.pwm4trig_val, %x_pwm_apbif.pwm5en, %x_pwm_apbif.pwm5inv, %x_pwm_apbif.pwm5load, %x_pwm_apbif.pwm5mode, %x_pwm_apbif.pwm5trig_val, %x_pwm_apbif.pwm6en, %x_pwm_apbif.pwm6inv, %x_pwm_apbif.pwm7en, %x_pwm_apbif.pwm7inv, %x_pwm_apbif.pwm8en, %x_pwm_apbif.pwm8inv, %x_pwm_apbif.pwm9en, %x_pwm_apbif.pwm9inv, %x_pwm_apbif.sync0mode, %x_pwm_apbif.sync1mode, %x_pwm_apbif.sync2mode, %x_pwm_apbif.sync3mode, %x_pwm_apbif.sync4mode, %x_pwm_apbif.sync5mode, %x_pwm_apbif.tim0en, %x_pwm_apbif.tim0ic, %x_pwm_apbif.tim0ie, %x_pwm_apbif.tim0load, %x_pwm_apbif.tim1en, %x_pwm_apbif.tim1ic, %x_pwm_apbif.tim1ie, %x_pwm_apbif.tim1load, %x_pwm_apbif.tim2en, %x_pwm_apbif.tim2ic, %x_pwm_apbif.tim2ie, %x_pwm_apbif.tim2load, %x_pwm_apbif.tim3en, %x_pwm_apbif.tim3ic, %x_pwm_apbif.tim3ie, %x_pwm_apbif.tim3load, %x_pwm_apbif.tim4en, %x_pwm_apbif.tim4ic, %x_pwm_apbif.tim4ie, %x_pwm_apbif.tim4load, %x_pwm_apbif.tim5en, %x_pwm_apbif.tim5ic, %x_pwm_apbif.tim5ie, %x_pwm_apbif.tim5load, %x_pwm_apbif.tr0end, %x_pwm_apbif.tr0enu, %x_pwm_apbif.tr1end, %x_pwm_apbif.tr1enu, %x_pwm_apbif.tr2end, %x_pwm_apbif.tr2enu, %x_pwm_apbif.tr3end, %x_pwm_apbif.tr3enu, %x_pwm_apbif.tr4end, %x_pwm_apbif.tr4enu, %x_pwm_apbif.tr5end, %x_pwm_apbif.tr5enu, %x_pwm_apbif.triginv = hw.instance "x_pwm_apbif" @pwm_apbif(cap01t: %x_pwm_ctrl.cap01t: i32, cap01t_h: %x_pwm_ctrl.cap01t_h: i32, cap23t: %x_pwm_ctrl.cap23t: i32, cap23t_h: %x_pwm_ctrl.cap23t_h: i32, cap45t: %x_pwm_ctrl.cap45t: i32, cap45t_h: %x_pwm_ctrl.cap45t_h: i32, capis: %x_pwm_ctrl.capis: i32, capris: %x_pwm_ctrl.capris: i32, cnt0val: %x_pwm_ctrl.cnt0val: i32, cnt1val: %x_pwm_ctrl.cnt1val: i32, cnt2val: %x_pwm_ctrl.cnt2val: i32, cnt3val: %x_pwm_ctrl.cnt3val: i32, cnt4val: %x_pwm_ctrl.cnt4val: i32, cnt5val: %x_pwm_ctrl.cnt5val: i32, etb_pwm_trig_tim0_off: %etb_pwm_trig_tim0_off: i1, etb_pwm_trig_tim0_on: %etb_pwm_trig_tim0_on: i1, etb_pwm_trig_tim1_off: %etb_pwm_trig_tim1_off: i1, etb_pwm_trig_tim1_on: %etb_pwm_trig_tim1_on: i1, etb_pwm_trig_tim2_off: %etb_pwm_trig_tim2_off: i1, etb_pwm_trig_tim2_on: %etb_pwm_trig_tim2_on: i1, etb_pwm_trig_tim3_off: %etb_pwm_trig_tim3_off: i1, etb_pwm_trig_tim3_on: %etb_pwm_trig_tim3_on: i1, etb_pwm_trig_tim4_off: %etb_pwm_trig_tim4_off: i1, etb_pwm_trig_tim4_on: %etb_pwm_trig_tim4_on: i1, etb_pwm_trig_tim5_off: %etb_pwm_trig_tim5_off: i1, etb_pwm_trig_tim5_on: %etb_pwm_trig_tim5_on: i1, paddr: %paddr: i32, pclk: %2: i1, penable: %penable: i1, presetn: %3: i1, psel: %psel: i1, pwdata: %pwdata: i32, pwm01count: %x_pwm_ctrl.pwm01count: i32, pwm01count_h: %x_pwm_ctrl.pwm01count_h: i32, pwm23count: %x_pwm_ctrl.pwm23count: i32, pwm23count_h: %x_pwm_ctrl.pwm23count_h: i32, pwm45count: %x_pwm_ctrl.pwm45count: i32, pwm45count_h: %x_pwm_ctrl.pwm45count_h: i32, pwmis1: %x_pwm_ctrl.pwmis1: i32, pwmis2: %x_pwm_ctrl.pwmis2: i32, pwmris1: %x_pwm_ctrl.pwmris1: i32, pwmris2: %x_pwm_ctrl.pwmris2: i32, pwrite: %pwrite: i1, tim01count: %x_pwm_ctrl.tim01count: i32, tim01count_h: %x_pwm_ctrl.tim01count_h: i32, tim23count: %x_pwm_ctrl.tim23count: i32, tim23count_h: %x_pwm_ctrl.tim23count_h: i32, tim45count: %x_pwm_ctrl.tim45count: i32, tim45count_h: %x_pwm_ctrl.tim45count_h: i32, timis: %x_pwm_ctrl.timis: i32, timris: %x_pwm_ctrl.timris: i32) -> (cap0cntic: i1, cap0cntie: i1, cap0en: i1, cap0eventa: i2, cap0match: i32, cap0mode: i1, cap0timic: i1, cap0timie: i1, cap1cntic: i1, cap1cntie: i1, cap1en: i1, cap1eventa: i2, cap1match: i32, cap1mode: i1, cap1timic: i1, cap1timie: i1, cap2cntic: i1, cap2cntie: i1, cap2en: i1, cap2eventa: i2, cap2match: i32, cap2mode: i1, cap2timic: i1, cap2timie: i1, cap3cntic: i1, cap3cntie: i1, cap3en: i1, cap3eventa: i2, cap3match: i32, cap3mode: i1, cap3timic: i1, cap3timie: i1, cap4cntic: i1, cap4cntie: i1, cap4en: i1, cap4eventa: i2, cap4match: i32, cap4mode: i1, cap4timic: i1, cap4timie: i1, cap5cntic: i1, cap5cntie: i1, cap5en: i1, cap5eventa: i2, cap5match: i32, cap5mode: i1, cap5timic: i1, cap5timie: i1, cntdiv: i3, cntdiven: i1, compa_val_0: i32, compa_val_1: i32, compa_val_2: i32, compa_val_3: i32, compa_val_4: i32, compa_val_5: i32, compb_val_0: i32, compb_val_1: i32, compb_val_2: i32, compb_val_3: i32, compb_val_4: i32, compb_val_5: i32, db0en: i1, db1en: i1, db2en: i1, db3en: i1, db4en: i1, db5en: i1, delay0: i12, delay1: i12, delay2: i12, delay3: i12, delay4: i12, delay5: i12, int0encmpad: i1, int0encmpau: i1, int0encmpbd: i1, int0encmpbu: i1, int0encntload: i1, int0encntzero: i1, int1encmpad: i1, int1encmpau: i1, int1encmpbd: i1, int1encmpbu: i1, int1encntload: i1, int1encntzero: i1, int2encmpad: i1, int2encmpau: i1, int2encmpbd: i1, int2encmpbu: i1, int2encntload: i1, int2encntzero: i1, int3encmpad: i1, int3encmpau: i1, int3encmpbd: i1, int3encmpbu: i1, int3encntload: i1, int3encntzero: i1, int4encmpad: i1, int4encmpau: i1, int4encmpbd: i1, int4encmpbu: i1, int4encntload: i1, int4encntzero: i1, int5encmpad: i1, int5encmpau: i1, int5encmpbd: i1, int5encmpbu: i1, int5encntload: i1, int5encntzero: i1, intenfault: i1, intic0cmpad: i1, intic0cmpau: i1, intic0cmpbd: i1, intic0cmpbu: i1, intic0cntload: i1, intic0cntzero: i1, intic1cmpad: i1, intic1cmpau: i1, intic1cmpbd: i1, intic1cmpbu: i1, intic1cntload: i1, intic1cntzero: i1, intic2cmpad: i1, intic2cmpau: i1, intic2cmpbd: i1, intic2cmpbu: i1, intic2cntload: i1, intic2cntzero: i1, intic3cmpad: i1, intic3cmpau: i1, intic3cmpbd: i1, intic3cmpbu: i1, intic3cntload: i1, intic3cntzero: i1, intic4cmpad: i1, intic4cmpau: i1, intic4cmpbd: i1, intic4cmpbu: i1, intic4cntload: i1, intic4cntzero: i1, intic5cmpad: i1, intic5cmpau: i1, intic5cmpbd: i1, intic5cmpbu: i1, intic5cntload: i1, intic5cntzero: i1, inticfault: i1, prdata: i32, pwm0en: i1, pwm0inv: i1, pwm0load: i32, pwm0mode: i1, pwm0trig_val: i32, pwm10en: i1, pwm10inv: i1, pwm11en: i1, pwm11inv: i1, pwm1en: i1, pwm1inv: i1, pwm1load: i32, pwm1mode: i1, pwm1trig_val: i32, pwm2en: i1, pwm2inv: i1, pwm2load: i32, pwm2mode: i1, pwm2trig_val: i32, pwm3en: i1, pwm3inv: i1, pwm3load: i32, pwm3mode: i1, pwm3trig_val: i32, pwm4en: i1, pwm4inv: i1, pwm4load: i32, pwm4mode: i1, pwm4trig_val: i32, pwm5en: i1, pwm5inv: i1, pwm5load: i32, pwm5mode: i1, pwm5trig_val: i32, pwm6en: i1, pwm6inv: i1, pwm7en: i1, pwm7inv: i1, pwm8en: i1, pwm8inv: i1, pwm9en: i1, pwm9inv: i1, sync0mode: i2, sync1mode: i2, sync2mode: i2, sync3mode: i2, sync4mode: i2, sync5mode: i2, tim0en: i1, tim0ic: i1, tim0ie: i1, tim0load: i32, tim1en: i1, tim1ic: i1, tim1ie: i1, tim1load: i32, tim2en: i1, tim2ic: i1, tim2ie: i1, tim2load: i32, tim3en: i1, tim3ic: i1, tim3ie: i1, tim3load: i32, tim4en: i1, tim4ic: i1, tim4ie: i1, tim4load: i32, tim5en: i1, tim5ic: i1, tim5ie: i1, tim5load: i32, tr0end: i1, tr0enu: i1, tr1end: i1, tr1enu: i1, tr2end: i1, tr2enu: i1, tr3end: i1, tr3enu: i1, tr4end: i1, tr4enu: i1, tr5end: i1, tr5enu: i1, triginv: i1) {sv.namehint = "db5en"}
    %5 = comb.xor %x_pwm_ctrl.pwm_0_oe, %true : i1
    %6 = comb.xor %x_pwm_ctrl.pwm_1_oe, %true : i1
    %7 = comb.xor %x_pwm_ctrl.pwm_2_oe, %true : i1
    %8 = comb.xor %x_pwm_ctrl.pwm_3_oe, %true : i1
    %9 = comb.xor %x_pwm_ctrl.pwm_4_oe, %true : i1
    %10 = comb.xor %x_pwm_ctrl.pwm_5_oe, %true : i1
    %11 = comb.xor %x_pwm_ctrl.pwm_6_oe, %true : i1
    %12 = comb.xor %x_pwm_ctrl.pwm_7_oe, %true : i1
    %13 = comb.xor %x_pwm_ctrl.pwm_8_oe, %true : i1
    %14 = comb.xor %x_pwm_ctrl.pwm_9_oe, %true : i1
    %15 = comb.xor %x_pwm_ctrl.pwm_10_oe, %true : i1
    %16 = comb.xor %x_pwm_ctrl.pwm_11_oe, %true : i1
    llhd.drv %fault_0, %fault after %0 : i1
    llhd.drv %pclk_1, %pclk after %0 : i1
    llhd.drv %presetn_2, %presetn after %0 : i1
    hw.output %x_pwm_ctrl.pwm_0_out, %x_pwm_ctrl.pwm_1_out, %x_pwm_ctrl.pwm_10_out, %x_pwm_ctrl.pwm_11_out, %x_pwm_ctrl.pwm_2_out, %x_pwm_ctrl.pwm_3_out, %x_pwm_ctrl.pwm_4_out, %x_pwm_ctrl.pwm_5_out, %x_pwm_ctrl.pwm_6_out, %x_pwm_ctrl.pwm_7_out, %x_pwm_ctrl.pwm_8_out, %x_pwm_ctrl.pwm_9_out, %x_pwm_apbif.prdata, %5, %15, %16, %6, %7, %8, %9, %10, %11, %12, %13, %14, %x_pwm_ctrl.pwm_idle, %x_pwm_ctrl.pwm_tim0_etb_trig, %x_pwm_ctrl.pwm_tim1_etb_trig, %x_pwm_ctrl.pwm_tim2_etb_trig, %x_pwm_ctrl.pwm_tim3_etb_trig, %x_pwm_ctrl.pwm_tim4_etb_trig, %x_pwm_ctrl.pwm_tim5_etb_trig, %x_pwm_ctrl.pwm_xx_trig, %x_pwm_ctrl.pwmint : i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1
  }
  hw.module private @pwm_apbif(in %cap01t : i32, in %cap01t_h : i32, out cap0cntic : i1, out cap0cntie : i1, out cap0en : i1, out cap0eventa : i2, out cap0match : i32, out cap0mode : i1, out cap0timic : i1, out cap0timie : i1, out cap1cntic : i1, out cap1cntie : i1, out cap1en : i1, out cap1eventa : i2, out cap1match : i32, out cap1mode : i1, out cap1timic : i1, out cap1timie : i1, in %cap23t : i32, in %cap23t_h : i32, out cap2cntic : i1, out cap2cntie : i1, out cap2en : i1, out cap2eventa : i2, out cap2match : i32, out cap2mode : i1, out cap2timic : i1, out cap2timie : i1, out cap3cntic : i1, out cap3cntie : i1, out cap3en : i1, out cap3eventa : i2, out cap3match : i32, out cap3mode : i1, out cap3timic : i1, out cap3timie : i1, in %cap45t : i32, in %cap45t_h : i32, out cap4cntic : i1, out cap4cntie : i1, out cap4en : i1, out cap4eventa : i2, out cap4match : i32, out cap4mode : i1, out cap4timic : i1, out cap4timie : i1, out cap5cntic : i1, out cap5cntie : i1, out cap5en : i1, out cap5eventa : i2, out cap5match : i32, out cap5mode : i1, out cap5timic : i1, out cap5timie : i1, in %capis : i32, in %capris : i32, in %cnt0val : i32, in %cnt1val : i32, in %cnt2val : i32, in %cnt3val : i32, in %cnt4val : i32, in %cnt5val : i32, out cntdiv : i3, out cntdiven : i1, out compa_val_0 : i32, out compa_val_1 : i32, out compa_val_2 : i32, out compa_val_3 : i32, out compa_val_4 : i32, out compa_val_5 : i32, out compb_val_0 : i32, out compb_val_1 : i32, out compb_val_2 : i32, out compb_val_3 : i32, out compb_val_4 : i32, out compb_val_5 : i32, out db0en : i1, out db1en : i1, out db2en : i1, out db3en : i1, out db4en : i1, out db5en : i1, out delay0 : i12, out delay1 : i12, out delay2 : i12, out delay3 : i12, out delay4 : i12, out delay5 : i12, in %etb_pwm_trig_tim0_off : i1, in %etb_pwm_trig_tim0_on : i1, in %etb_pwm_trig_tim1_off : i1, in %etb_pwm_trig_tim1_on : i1, in %etb_pwm_trig_tim2_off : i1, in %etb_pwm_trig_tim2_on : i1, in %etb_pwm_trig_tim3_off : i1, in %etb_pwm_trig_tim3_on : i1, in %etb_pwm_trig_tim4_off : i1, in %etb_pwm_trig_tim4_on : i1, in %etb_pwm_trig_tim5_off : i1, in %etb_pwm_trig_tim5_on : i1, out int0encmpad : i1, out int0encmpau : i1, out int0encmpbd : i1, out int0encmpbu : i1, out int0encntload : i1, out int0encntzero : i1, out int1encmpad : i1, out int1encmpau : i1, out int1encmpbd : i1, out int1encmpbu : i1, out int1encntload : i1, out int1encntzero : i1, out int2encmpad : i1, out int2encmpau : i1, out int2encmpbd : i1, out int2encmpbu : i1, out int2encntload : i1, out int2encntzero : i1, out int3encmpad : i1, out int3encmpau : i1, out int3encmpbd : i1, out int3encmpbu : i1, out int3encntload : i1, out int3encntzero : i1, out int4encmpad : i1, out int4encmpau : i1, out int4encmpbd : i1, out int4encmpbu : i1, out int4encntload : i1, out int4encntzero : i1, out int5encmpad : i1, out int5encmpau : i1, out int5encmpbd : i1, out int5encmpbu : i1, out int5encntload : i1, out int5encntzero : i1, out intenfault : i1, out intic0cmpad : i1, out intic0cmpau : i1, out intic0cmpbd : i1, out intic0cmpbu : i1, out intic0cntload : i1, out intic0cntzero : i1, out intic1cmpad : i1, out intic1cmpau : i1, out intic1cmpbd : i1, out intic1cmpbu : i1, out intic1cntload : i1, out intic1cntzero : i1, out intic2cmpad : i1, out intic2cmpau : i1, out intic2cmpbd : i1, out intic2cmpbu : i1, out intic2cntload : i1, out intic2cntzero : i1, out intic3cmpad : i1, out intic3cmpau : i1, out intic3cmpbd : i1, out intic3cmpbu : i1, out intic3cntload : i1, out intic3cntzero : i1, out intic4cmpad : i1, out intic4cmpau : i1, out intic4cmpbd : i1, out intic4cmpbu : i1, out intic4cntload : i1, out intic4cntzero : i1, out intic5cmpad : i1, out intic5cmpau : i1, out intic5cmpbd : i1, out intic5cmpbu : i1, out intic5cntload : i1, out intic5cntzero : i1, out inticfault : i1, in %paddr : i32, in %pclk : i1, in %penable : i1, out prdata : i32, in %presetn : i1, in %psel : i1, in %pwdata : i32, in %pwm01count : i32, in %pwm01count_h : i32, out pwm0en : i1, out pwm0inv : i1, out pwm0load : i32, out pwm0mode : i1, out pwm0trig_val : i32, out pwm10en : i1, out pwm10inv : i1, out pwm11en : i1, out pwm11inv : i1, out pwm1en : i1, out pwm1inv : i1, out pwm1load : i32, out pwm1mode : i1, out pwm1trig_val : i32, in %pwm23count : i32, in %pwm23count_h : i32, out pwm2en : i1, out pwm2inv : i1, out pwm2load : i32, out pwm2mode : i1, out pwm2trig_val : i32, out pwm3en : i1, out pwm3inv : i1, out pwm3load : i32, out pwm3mode : i1, out pwm3trig_val : i32, in %pwm45count : i32, in %pwm45count_h : i32, out pwm4en : i1, out pwm4inv : i1, out pwm4load : i32, out pwm4mode : i1, out pwm4trig_val : i32, out pwm5en : i1, out pwm5inv : i1, out pwm5load : i32, out pwm5mode : i1, out pwm5trig_val : i32, out pwm6en : i1, out pwm6inv : i1, out pwm7en : i1, out pwm7inv : i1, out pwm8en : i1, out pwm8inv : i1, out pwm9en : i1, out pwm9inv : i1, in %pwmis1 : i32, in %pwmis2 : i32, in %pwmris1 : i32, in %pwmris2 : i32, in %pwrite : i1, out sync0mode : i2, out sync1mode : i2, out sync2mode : i2, out sync3mode : i2, out sync4mode : i2, out sync5mode : i2, in %tim01count : i32, in %tim01count_h : i32, out tim0en : i1, out tim0ic : i1, out tim0ie : i1, out tim0load : i32, out tim1en : i1, out tim1ic : i1, out tim1ie : i1, out tim1load : i32, in %tim23count : i32, in %tim23count_h : i32, out tim2en : i1, out tim2ic : i1, out tim2ie : i1, out tim2load : i32, out tim3en : i1, out tim3ic : i1, out tim3ie : i1, out tim3load : i32, in %tim45count : i32, in %tim45count_h : i32, out tim4en : i1, out tim4ic : i1, out tim4ie : i1, out tim4load : i32, out tim5en : i1, out tim5ic : i1, out tim5ie : i1, out tim5load : i32, in %timis : i32, in %timris : i32, out tr0end : i1, out tr0enu : i1, out tr1end : i1, out tr1enu : i1, out tr2end : i1, out tr2enu : i1, out tr3end : i1, out tr3enu : i1, out tr4end : i1, out tr4enu : i1, out tr5end : i1, out tr5enu : i1, out triginv : i1) {
    %c-8_i5 = hw.constant -8 : i5
    %c-16_i5 = hw.constant -16 : i5
    %c8_i5 = hw.constant 8 : i5
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c0_i5 = hw.constant 0 : i5
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i25 = hw.constant 0 : i25
    %c0_i22 = hw.constant 0 : i22
    %c0_i30 = hw.constant 0 : i30
    %c0_i28 = hw.constant 0 : i28
    %c0_i12 = hw.constant 0 : i12
    %c0_i32 = hw.constant 0 : i32
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
    %c57_i7 = hw.constant 57 : i7
    %c56_i7 = hw.constant 56 : i7
    %c52_i7 = hw.constant 52 : i7
    %c51_i7 = hw.constant 51 : i7
    %c50_i7 = hw.constant 50 : i7
    %c49_i7 = hw.constant 49 : i7
    %c48_i7 = hw.constant 48 : i7
    %c47_i7 = hw.constant 47 : i7
    %c43_i7 = hw.constant 43 : i7
    %c41_i7 = hw.constant 41 : i7
    %c0_i26 = hw.constant 0 : i26
    %c36_i7 = hw.constant 36 : i7
    %c35_i7 = hw.constant 35 : i7
    %c34_i7 = hw.constant 34 : i7
    %c33_i7 = hw.constant 33 : i7
    %c31_i7 = hw.constant 31 : i7
    %c0_i20 = hw.constant 0 : i20
    %c0_i6 = hw.constant 0 : i6
    %c19_i7 = hw.constant 19 : i7
    %c18_i7 = hw.constant 18 : i7
    %c17_i7 = hw.constant 17 : i7
    %c0_i14 = hw.constant 0 : i14
    %c12_i7 = hw.constant 12 : i7
    %c11_i7 = hw.constant 11 : i7
    %c8_i7 = hw.constant 8 : i7
    %c7_i7 = hw.constant 7 : i7
    %c0_i10 = hw.constant 0 : i10
    %c0_i2 = hw.constant 0 : i2
    %c0_i7 = hw.constant 0 : i7
    %c-64_i7 = hw.constant -64 : i7
    %c63_i7 = hw.constant 63 : i7
    %c62_i7 = hw.constant 62 : i7
    %c-58_i7 = hw.constant -58 : i7
    %c-59_i7 = hw.constant -59 : i7
    %c-60_i7 = hw.constant -60 : i7
    %c61_i7 = hw.constant 61 : i7
    %c60_i7 = hw.constant 60 : i7
    %c59_i7 = hw.constant 59 : i7
    %c58_i7 = hw.constant 58 : i7
    %c-7_i6 = hw.constant -7 : i6
    %c-8_i6 = hw.constant -8 : i6
    %c-61_i7 = hw.constant -61 : i7
    %c-62_i7 = hw.constant -62 : i7
    %c-63_i7 = hw.constant -63 : i7
    %c55_i7 = hw.constant 55 : i7
    %c54_i7 = hw.constant 54 : i7
    %c53_i7 = hw.constant 53 : i7
    %c0_i18 = hw.constant 0 : i18
    %c0_i4 = hw.constant 0 : i4
    %true = hw.constant true
    %false = hw.constant false
    %c46_i7 = hw.constant 46 : i7
    %c45_i7 = hw.constant 45 : i7
    %c44_i7 = hw.constant 44 : i7
    %c42_i7 = hw.constant 42 : i7
    %c40_i7 = hw.constant 40 : i7
    %c39_i7 = hw.constant 39 : i7
    %c38_i7 = hw.constant 38 : i7
    %c37_i7 = hw.constant 37 : i7
    %c32_i7 = hw.constant 32 : i7
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
    %c16_i7 = hw.constant 16 : i7
    %c15_i7 = hw.constant 15 : i7
    %c14_i7 = hw.constant 14 : i7
    %c13_i7 = hw.constant 13 : i7
    %c10_i7 = hw.constant 10 : i7
    %c9_i7 = hw.constant 9 : i7
    %c6_i7 = hw.constant 6 : i7
    %c5_i7 = hw.constant 5 : i7
    %c4_i7 = hw.constant 4 : i7
    %c3_i7 = hw.constant 3 : i7
    %c2_i7 = hw.constant 2 : i7
    %c1_i7 = hw.constant 1 : i7
    %c0_i3 = hw.constant 0 : i3
    %etb_pwmcfg18 = llhd.sig %false : i1
    %etb_pwmcfg19 = llhd.sig %false : i1
    %etb_pwmcfg20 = llhd.sig %false : i1
    %etb_pwmcfg21 = llhd.sig %false : i1
    %etb_pwmcfg22 = llhd.sig %false : i1
    %etb_pwmcfg23 = llhd.sig %false : i1
    %int_cap01match = llhd.sig %c0_i32 : i32
    %int_cap01match_h = llhd.sig %c0_i32 : i32
    %int_cap23match = llhd.sig %c0_i32 : i32
    %int_cap23match_h = llhd.sig %c0_i32 : i32
    %int_cap45match = llhd.sig %c0_i32 : i32
    %int_cap45match_h = llhd.sig %c0_i32 : i32
    %int_capctl = llhd.sig %c0_i18 : i18
    %int_capic = llhd.sig %c0_i12 : i12
    %int_capinten = llhd.sig %c0_i12 : i12
    %int_pwm01db = llhd.sig %c0_i26 : i26
    %int_pwm01load = llhd.sig %c0_i32 : i32
    %int_pwm01load_h = llhd.sig %c0_i32 : i32
    %int_pwm01trig = llhd.sig %c0_i32 : i32
    %int_pwm01trig_h = llhd.sig %c0_i32 : i32
    %int_pwm0cmp = llhd.sig %c0_i32 : i32
    %int_pwm0cmp_h = llhd.sig %c0_i32 : i32
    %int_pwm1cmp = llhd.sig %c0_i32 : i32
    %int_pwm1cmp_h = llhd.sig %c0_i32 : i32
    %int_pwm23db = llhd.sig %c0_i26 : i26
    %int_pwm23load = llhd.sig %c0_i32 : i32
    %int_pwm23load_h = llhd.sig %c0_i32 : i32
    %int_pwm23trig = llhd.sig %c0_i32 : i32
    %int_pwm23trig_h = llhd.sig %c0_i32 : i32
    %int_pwm2cmp = llhd.sig %c0_i32 : i32
    %int_pwm2cmp_h = llhd.sig %c0_i32 : i32
    %int_pwm3cmp = llhd.sig %c0_i32 : i32
    %int_pwm3cmp_h = llhd.sig %c0_i32 : i32
    %int_pwm45db = llhd.sig %c0_i26 : i26
    %int_pwm45load = llhd.sig %c0_i32 : i32
    %int_pwm45load_h = llhd.sig %c0_i32 : i32
    %int_pwm45trig = llhd.sig %c0_i32 : i32
    %int_pwm45trig_h = llhd.sig %c0_i32 : i32
    %int_pwm4cmp = llhd.sig %c0_i32 : i32
    %int_pwm4cmp_h = llhd.sig %c0_i32 : i32
    %int_pwm5cmp = llhd.sig %c0_i32 : i32
    %int_pwm5cmp_h = llhd.sig %c0_i32 : i32
    %int_pwmcfg = llhd.sig %c0_i28 : i28
    %int_pwmctl = llhd.sig %c0_i18 : i18
    %int_pwmic1 = llhd.sig %c0_i30 : i30
    %int_pwmic2 = llhd.sig %c0_i22 : i22
    %int_pwminten1 = llhd.sig %c0_i30 : i30
    %int_pwminten2 = llhd.sig %c0_i22 : i22
    %int_pwminverttrig = llhd.sig %c0_i25 : i25
    %int_tim01load = llhd.sig %c0_i32 : i32
    %int_tim01load_h = llhd.sig %c0_i32 : i32
    %int_tim23load = llhd.sig %c0_i32 : i32
    %int_tim23load_h = llhd.sig %c0_i32 : i32
    %int_tim45load = llhd.sig %c0_i32 : i32
    %int_tim45load_h = llhd.sig %c0_i32 : i32
    %int_timic = llhd.sig %c0_i6 : i6
    %int_timinten = llhd.sig %c0_i6 : i6
    %iprdata = llhd.sig %c0_i32 : i32
    %cap01match = llhd.sig %c0_i32 : i32
    %cap01match_h = llhd.sig %c0_i32 : i32
    %cap01match_wen = llhd.sig %false : i1
    %cap01t_0 = llhd.sig name "cap01t" %c0_i32 : i32
    %cap01t_h_1 = llhd.sig name "cap01t_h" %c0_i32 : i32
    %cap0eventa = llhd.sig %c0_i2 : i2
    %cap0match = llhd.sig %c0_i32 : i32
    %cap1eventa = llhd.sig %c0_i2 : i2
    %cap1match = llhd.sig %c0_i32 : i32
    %cap23match = llhd.sig %c0_i32 : i32
    %cap23match_h = llhd.sig %c0_i32 : i32
    %cap23match_wen = llhd.sig %false : i1
    %cap23t_2 = llhd.sig name "cap23t" %c0_i32 : i32
    %cap23t_h_3 = llhd.sig name "cap23t_h" %c0_i32 : i32
    %cap2eventa = llhd.sig %c0_i2 : i2
    %cap2match = llhd.sig %c0_i32 : i32
    %cap3eventa = llhd.sig %c0_i2 : i2
    %cap3match = llhd.sig %c0_i32 : i32
    %cap45match = llhd.sig %c0_i32 : i32
    %cap45match_h = llhd.sig %c0_i32 : i32
    %cap45match_wen = llhd.sig %false : i1
    %cap45t_4 = llhd.sig name "cap45t" %c0_i32 : i32
    %cap45t_h_5 = llhd.sig name "cap45t_h" %c0_i32 : i32
    %cap4eventa = llhd.sig %c0_i2 : i2
    %cap4match = llhd.sig %c0_i32 : i32
    %cap5eventa = llhd.sig %c0_i2 : i2
    %cap5match = llhd.sig %c0_i32 : i32
    %capctl = llhd.sig %c0_i18 : i18
    %capctl_wen = llhd.sig %false : i1
    %capic = llhd.sig %c0_i12 : i12
    %capic_wen = llhd.sig %false : i1
    %capinten = llhd.sig %c0_i12 : i12
    %capinten_wen = llhd.sig %false : i1
    %capis_6 = llhd.sig name "capis" %c0_i32 : i32
    %capris_7 = llhd.sig name "capris" %c0_i32 : i32
    %cnt0val_8 = llhd.sig name "cnt0val" %c0_i32 : i32
    %cnt1val_9 = llhd.sig name "cnt1val" %c0_i32 : i32
    %cnt2val_10 = llhd.sig name "cnt2val" %c0_i32 : i32
    %cnt3val_11 = llhd.sig name "cnt3val" %c0_i32 : i32
    %cnt4val_12 = llhd.sig name "cnt4val" %c0_i32 : i32
    %cnt5val_13 = llhd.sig name "cnt5val" %c0_i32 : i32
    %cntdiv = llhd.sig %c0_i3 : i3
    %compa_val_0 = llhd.sig %c0_i32 : i32
    %compa_val_1 = llhd.sig %c0_i32 : i32
    %compa_val_2 = llhd.sig %c0_i32 : i32
    %compa_val_3 = llhd.sig %c0_i32 : i32
    %compa_val_4 = llhd.sig %c0_i32 : i32
    %compa_val_5 = llhd.sig %c0_i32 : i32
    %compb_val_0 = llhd.sig %c0_i32 : i32
    %compb_val_1 = llhd.sig %c0_i32 : i32
    %compb_val_2 = llhd.sig %c0_i32 : i32
    %compb_val_3 = llhd.sig %c0_i32 : i32
    %compb_val_4 = llhd.sig %c0_i32 : i32
    %compb_val_5 = llhd.sig %c0_i32 : i32
    %delay0 = llhd.sig %c0_i12 : i12
    %delay1 = llhd.sig %c0_i12 : i12
    %delay2 = llhd.sig %c0_i12 : i12
    %delay3 = llhd.sig %c0_i12 : i12
    %delay4 = llhd.sig %c0_i12 : i12
    %delay5 = llhd.sig %c0_i12 : i12
    %etb_pwm_trig_tim0_off_14 = llhd.sig name "etb_pwm_trig_tim0_off" %false : i1
    %etb_pwm_trig_tim0_on_15 = llhd.sig name "etb_pwm_trig_tim0_on" %false : i1
    %etb_pwm_trig_tim1_off_16 = llhd.sig name "etb_pwm_trig_tim1_off" %false : i1
    %etb_pwm_trig_tim1_on_17 = llhd.sig name "etb_pwm_trig_tim1_on" %false : i1
    %etb_pwm_trig_tim2_off_18 = llhd.sig name "etb_pwm_trig_tim2_off" %false : i1
    %etb_pwm_trig_tim2_on_19 = llhd.sig name "etb_pwm_trig_tim2_on" %false : i1
    %etb_pwm_trig_tim3_off_20 = llhd.sig name "etb_pwm_trig_tim3_off" %false : i1
    %etb_pwm_trig_tim3_on_21 = llhd.sig name "etb_pwm_trig_tim3_on" %false : i1
    %etb_pwm_trig_tim4_off_22 = llhd.sig name "etb_pwm_trig_tim4_off" %false : i1
    %etb_pwm_trig_tim4_on_23 = llhd.sig name "etb_pwm_trig_tim4_on" %false : i1
    %etb_pwm_trig_tim5_off_24 = llhd.sig name "etb_pwm_trig_tim5_off" %false : i1
    %etb_pwm_trig_tim5_on_25 = llhd.sig name "etb_pwm_trig_tim5_on" %false : i1
    %paddr_26 = llhd.sig name "paddr" %c0_i32 : i32
    %pclk_27 = llhd.sig name "pclk" %false : i1
    %2 = llhd.prb %pclk_27 : i1
    %penable_28 = llhd.sig name "penable" %false : i1
    %prdata = llhd.sig %c0_i32 : i32
    %presetn_29 = llhd.sig name "presetn" %false : i1
    %3 = llhd.prb %presetn_29 : i1
    %psel_30 = llhd.sig name "psel" %false : i1
    %pwdata_31 = llhd.sig name "pwdata" %c0_i32 : i32
    %pwm01count_32 = llhd.sig name "pwm01count" %c0_i32 : i32
    %pwm01count_h_33 = llhd.sig name "pwm01count_h" %c0_i32 : i32
    %pwm01db = llhd.sig %c0_i26 : i26
    %pwm01db_wen = llhd.sig %false : i1
    %pwm01load = llhd.sig %c0_i32 : i32
    %pwm01load_h = llhd.sig %c0_i32 : i32
    %pwm01load_wen = llhd.sig %false : i1
    %pwm01trig = llhd.sig %c0_i32 : i32
    %pwm01trig_h = llhd.sig %c0_i32 : i32
    %pwm01trig_wen = llhd.sig %false : i1
    %pwm0cmp = llhd.sig %c0_i32 : i32
    %pwm0cmp_h = llhd.sig %c0_i32 : i32
    %pwm0cmp_wen = llhd.sig %false : i1
    %pwm0load = llhd.sig %c0_i32 : i32
    %pwm0trig_val = llhd.sig %c0_i32 : i32
    %pwm1cmp = llhd.sig %c0_i32 : i32
    %pwm1cmp_h = llhd.sig %c0_i32 : i32
    %pwm1cmp_wen = llhd.sig %false : i1
    %pwm1load = llhd.sig %c0_i32 : i32
    %pwm1trig_val = llhd.sig %c0_i32 : i32
    %pwm23count_34 = llhd.sig name "pwm23count" %c0_i32 : i32
    %pwm23count_h_35 = llhd.sig name "pwm23count_h" %c0_i32 : i32
    %pwm23db = llhd.sig %c0_i26 : i26
    %pwm23db_wen = llhd.sig %false : i1
    %pwm23load = llhd.sig %c0_i32 : i32
    %pwm23load_h = llhd.sig %c0_i32 : i32
    %pwm23load_wen = llhd.sig %false : i1
    %pwm23trig = llhd.sig %c0_i32 : i32
    %pwm23trig_h = llhd.sig %c0_i32 : i32
    %pwm23trig_wen = llhd.sig %false : i1
    %pwm2cmp = llhd.sig %c0_i32 : i32
    %pwm2cmp_h = llhd.sig %c0_i32 : i32
    %pwm2cmp_wen = llhd.sig %false : i1
    %pwm2load = llhd.sig %c0_i32 : i32
    %pwm2trig_val = llhd.sig %c0_i32 : i32
    %pwm3cmp = llhd.sig %c0_i32 : i32
    %pwm3cmp_h = llhd.sig %c0_i32 : i32
    %pwm3cmp_wen = llhd.sig %false : i1
    %pwm3load = llhd.sig %c0_i32 : i32
    %pwm3trig_val = llhd.sig %c0_i32 : i32
    %pwm45count_36 = llhd.sig name "pwm45count" %c0_i32 : i32
    %pwm45count_h_37 = llhd.sig name "pwm45count_h" %c0_i32 : i32
    %pwm45db = llhd.sig %c0_i26 : i26
    %pwm45db_wen = llhd.sig %false : i1
    %pwm45load = llhd.sig %c0_i32 : i32
    %pwm45load_h = llhd.sig %c0_i32 : i32
    %pwm45load_wen = llhd.sig %false : i1
    %pwm45trig = llhd.sig %c0_i32 : i32
    %pwm45trig_h = llhd.sig %c0_i32 : i32
    %pwm45trig_wen = llhd.sig %false : i1
    %pwm4cmp = llhd.sig %c0_i32 : i32
    %pwm4cmp_h = llhd.sig %c0_i32 : i32
    %pwm4cmp_wen = llhd.sig %false : i1
    %pwm4load = llhd.sig %c0_i32 : i32
    %pwm4trig_val = llhd.sig %c0_i32 : i32
    %pwm5cmp = llhd.sig %c0_i32 : i32
    %pwm5cmp_h = llhd.sig %c0_i32 : i32
    %pwm5cmp_wen = llhd.sig %false : i1
    %pwm5load = llhd.sig %c0_i32 : i32
    %pwm5trig_val = llhd.sig %c0_i32 : i32
    %pwmcfg = llhd.sig %c0_i28 : i28
    %pwmcfg_wen = llhd.sig %false : i1
    %pwmctl = llhd.sig %c0_i18 : i18
    %pwmctl_wen = llhd.sig %false : i1
    %pwmic1_wen = llhd.sig %false : i1
    %pwmic2_wen = llhd.sig %false : i1
    %pwminten1_wen = llhd.sig %false : i1
    %pwminten2_wen = llhd.sig %false : i1
    %pwminverttrig = llhd.sig %c0_i25 : i25
    %pwminverttrig_wen = llhd.sig %false : i1
    %pwmis1_38 = llhd.sig name "pwmis1" %c0_i32 : i32
    %pwmis2_39 = llhd.sig name "pwmis2" %c0_i32 : i32
    %pwmris1_40 = llhd.sig name "pwmris1" %c0_i32 : i32
    %pwmris2_41 = llhd.sig name "pwmris2" %c0_i32 : i32
    %pwrite_42 = llhd.sig name "pwrite" %false : i1
    %sync0mode = llhd.sig %c0_i2 : i2
    %sync1mode = llhd.sig %c0_i2 : i2
    %sync2mode = llhd.sig %c0_i2 : i2
    %sync3mode = llhd.sig %c0_i2 : i2
    %sync4mode = llhd.sig %c0_i2 : i2
    %sync5mode = llhd.sig %c0_i2 : i2
    %tim01count_43 = llhd.sig name "tim01count" %c0_i32 : i32
    %tim01count_h_44 = llhd.sig name "tim01count_h" %c0_i32 : i32
    %tim01load = llhd.sig %c0_i32 : i32
    %tim01load_h = llhd.sig %c0_i32 : i32
    %tim01load_wen = llhd.sig %false : i1
    %tim0load = llhd.sig %c0_i32 : i32
    %tim1load = llhd.sig %c0_i32 : i32
    %tim23count_45 = llhd.sig name "tim23count" %c0_i32 : i32
    %tim23count_h_46 = llhd.sig name "tim23count_h" %c0_i32 : i32
    %tim23load = llhd.sig %c0_i32 : i32
    %tim23load_h = llhd.sig %c0_i32 : i32
    %tim23load_wen = llhd.sig %false : i1
    %tim2load = llhd.sig %c0_i32 : i32
    %tim3load = llhd.sig %c0_i32 : i32
    %tim45count_47 = llhd.sig name "tim45count" %c0_i32 : i32
    %tim45count_h_48 = llhd.sig name "tim45count_h" %c0_i32 : i32
    %tim45load = llhd.sig %c0_i32 : i32
    %tim45load_h = llhd.sig %c0_i32 : i32
    %tim45load_wen = llhd.sig %false : i1
    %tim4load = llhd.sig %c0_i32 : i32
    %tim5load = llhd.sig %c0_i32 : i32
    %timic = llhd.sig %c0_i6 : i6
    %timic_wen = llhd.sig %false : i1
    %timinten = llhd.sig %c0_i6 : i6
    %timinten_wen = llhd.sig %false : i1
    %timis_49 = llhd.sig name "timis" %c0_i32 : i32
    %timris_50 = llhd.sig name "timris" %c0_i32 : i32
    %write_reg_sel = llhd.sig %false : i1
    %4 = llhd.prb %psel_30 : i1
    %5 = llhd.prb %penable_28 : i1
    %6 = llhd.prb %pwrite_42 : i1
    %7 = llhd.prb %paddr_26 : i32
    %8 = comb.extract %7 from 9 : (i32) -> i3
    %9 = comb.icmp eq %8, %c0_i3 : i3
    %10 = comb.and %4, %5, %6, %9 : i1
    llhd.drv %write_reg_sel, %10 after %1 : i1
    %11 = llhd.prb %write_reg_sel : i1
    %12 = comb.extract %7 from 2 : (i32) -> i7
    %13 = comb.icmp eq %12, %c0_i7 : i7
    %14 = comb.and %11, %13 : i1
    llhd.drv %pwmcfg_wen, %14 after %1 : i1
    %15 = comb.icmp eq %12, %c1_i7 : i7
    %16 = comb.and %11, %15 : i1
    llhd.drv %pwminverttrig_wen, %16 after %1 : i1
    %17 = comb.icmp eq %12, %c2_i7 : i7
    %18 = comb.and %11, %17 : i1
    llhd.drv %pwm01trig_wen, %18 after %1 : i1
    %19 = comb.icmp eq %12, %c3_i7 : i7
    %20 = comb.and %11, %19 : i1
    llhd.drv %pwm23trig_wen, %20 after %1 : i1
    %21 = comb.icmp eq %12, %c4_i7 : i7
    %22 = comb.and %11, %21 : i1
    llhd.drv %pwm45trig_wen, %22 after %1 : i1
    %23 = comb.icmp eq %12, %c5_i7 : i7
    %24 = comb.and %11, %23 : i1
    llhd.drv %pwminten1_wen, %24 after %1 : i1
    %25 = comb.icmp eq %12, %c6_i7 : i7
    %26 = comb.and %11, %25 : i1
    llhd.drv %pwminten2_wen, %26 after %1 : i1
    %27 = comb.icmp eq %12, %c9_i7 : i7
    %28 = comb.and %11, %27 : i1
    llhd.drv %pwmic1_wen, %28 after %1 : i1
    %29 = comb.icmp eq %12, %c10_i7 : i7
    %30 = comb.and %11, %29 : i1
    llhd.drv %pwmic2_wen, %30 after %1 : i1
    %31 = comb.icmp eq %12, %c13_i7 : i7
    %32 = comb.and %11, %31 : i1
    llhd.drv %pwmctl_wen, %32 after %1 : i1
    %33 = comb.icmp eq %12, %c14_i7 : i7
    %34 = comb.and %11, %33 : i1
    llhd.drv %pwm01load_wen, %34 after %1 : i1
    %35 = comb.icmp eq %12, %c15_i7 : i7
    %36 = comb.and %11, %35 : i1
    llhd.drv %pwm23load_wen, %36 after %1 : i1
    %37 = comb.icmp eq %12, %c16_i7 : i7
    %38 = comb.and %11, %37 : i1
    llhd.drv %pwm45load_wen, %38 after %1 : i1
    %39 = comb.icmp eq %12, %c20_i7 : i7
    %40 = comb.and %11, %39 : i1
    llhd.drv %pwm0cmp_wen, %40 after %1 : i1
    %41 = comb.icmp eq %12, %c21_i7 : i7
    %42 = comb.and %11, %41 : i1
    llhd.drv %pwm1cmp_wen, %42 after %1 : i1
    %43 = comb.icmp eq %12, %c22_i7 : i7
    %44 = comb.and %11, %43 : i1
    llhd.drv %pwm2cmp_wen, %44 after %1 : i1
    %45 = comb.icmp eq %12, %c23_i7 : i7
    %46 = comb.and %11, %45 : i1
    llhd.drv %pwm3cmp_wen, %46 after %1 : i1
    %47 = comb.icmp eq %12, %c24_i7 : i7
    %48 = comb.and %11, %47 : i1
    llhd.drv %pwm4cmp_wen, %48 after %1 : i1
    %49 = comb.icmp eq %12, %c25_i7 : i7
    %50 = comb.and %11, %49 : i1
    llhd.drv %pwm5cmp_wen, %50 after %1 : i1
    %51 = comb.icmp eq %12, %c26_i7 : i7
    %52 = comb.and %11, %51 : i1
    llhd.drv %pwm01db_wen, %52 after %1 : i1
    %53 = comb.icmp eq %12, %c27_i7 : i7
    %54 = comb.and %11, %53 : i1
    llhd.drv %pwm23db_wen, %54 after %1 : i1
    %55 = comb.icmp eq %12, %c28_i7 : i7
    %56 = comb.and %11, %55 : i1
    llhd.drv %pwm45db_wen, %56 after %1 : i1
    %57 = comb.icmp eq %12, %c29_i7 : i7
    %58 = comb.and %11, %57 : i1
    llhd.drv %capctl_wen, %58 after %1 : i1
    %59 = comb.icmp eq %12, %c30_i7 : i7
    %60 = comb.and %11, %59 : i1
    llhd.drv %capinten_wen, %60 after %1 : i1
    %61 = comb.icmp eq %12, %c32_i7 : i7
    %62 = comb.and %11, %61 : i1
    llhd.drv %capic_wen, %62 after %1 : i1
    %63 = comb.icmp eq %12, %c37_i7 : i7
    %64 = comb.and %11, %63 : i1
    llhd.drv %cap01match_wen, %64 after %1 : i1
    %65 = comb.icmp eq %12, %c38_i7 : i7
    %66 = comb.and %11, %65 : i1
    llhd.drv %cap23match_wen, %66 after %1 : i1
    %67 = comb.icmp eq %12, %c39_i7 : i7
    %68 = comb.and %11, %67 : i1
    llhd.drv %cap45match_wen, %68 after %1 : i1
    %69 = comb.icmp eq %12, %c40_i7 : i7
    %70 = comb.and %11, %69 : i1
    llhd.drv %timinten_wen, %70 after %1 : i1
    %71 = comb.icmp eq %12, %c42_i7 : i7
    %72 = comb.and %11, %71 : i1
    llhd.drv %timic_wen, %72 after %1 : i1
    %73 = comb.icmp eq %12, %c44_i7 : i7
    %74 = comb.and %11, %73 : i1
    llhd.drv %tim01load_wen, %74 after %1 : i1
    %75 = comb.icmp eq %12, %c45_i7 : i7
    %76 = comb.and %11, %75 : i1
    llhd.drv %tim23load_wen, %76 after %1 : i1
    %77 = comb.icmp eq %12, %c46_i7 : i7
    %78 = comb.and %11, %77 : i1
    llhd.drv %tim45load_wen, %78 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwmcfg, %c0_i28 after %0 : i28
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwmcfg_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      %560 = comb.extract %559 from 0 : (i32) -> i28
      llhd.drv %int_pwmcfg, %560 after %0 : i28
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %etb_pwmcfg18, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwmcfg_wen : i1
      cf.cond_br %558, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      %560 = comb.extract %559 from 18 : (i32) -> i1
      llhd.drv %etb_pwmcfg18, %560 after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %561 = llhd.prb %etb_pwm_trig_tim0_on_15 : i1
      cf.cond_br %561, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %etb_pwmcfg18, %true after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %562 = llhd.prb %etb_pwm_trig_tim0_off_14 : i1
      cf.cond_br %562, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      llhd.drv %etb_pwmcfg18, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %etb_pwmcfg19, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwmcfg_wen : i1
      cf.cond_br %558, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      %560 = comb.extract %559 from 19 : (i32) -> i1
      llhd.drv %etb_pwmcfg19, %560 after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %561 = llhd.prb %etb_pwm_trig_tim1_on_17 : i1
      cf.cond_br %561, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %etb_pwmcfg19, %true after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %562 = llhd.prb %etb_pwm_trig_tim1_off_16 : i1
      cf.cond_br %562, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      llhd.drv %etb_pwmcfg19, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %etb_pwmcfg20, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwmcfg_wen : i1
      cf.cond_br %558, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      %560 = comb.extract %559 from 20 : (i32) -> i1
      llhd.drv %etb_pwmcfg20, %560 after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %561 = llhd.prb %etb_pwm_trig_tim2_on_19 : i1
      cf.cond_br %561, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %etb_pwmcfg20, %true after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %562 = llhd.prb %etb_pwm_trig_tim2_off_18 : i1
      cf.cond_br %562, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      llhd.drv %etb_pwmcfg20, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %etb_pwmcfg21, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwmcfg_wen : i1
      cf.cond_br %558, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      %560 = comb.extract %559 from 21 : (i32) -> i1
      llhd.drv %etb_pwmcfg21, %560 after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %561 = llhd.prb %etb_pwm_trig_tim3_on_21 : i1
      cf.cond_br %561, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %etb_pwmcfg21, %true after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %562 = llhd.prb %etb_pwm_trig_tim3_off_20 : i1
      cf.cond_br %562, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      llhd.drv %etb_pwmcfg21, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %etb_pwmcfg22, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwmcfg_wen : i1
      cf.cond_br %558, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      %560 = comb.extract %559 from 22 : (i32) -> i1
      llhd.drv %etb_pwmcfg22, %560 after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %561 = llhd.prb %etb_pwm_trig_tim4_on_23 : i1
      cf.cond_br %561, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %etb_pwmcfg22, %true after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %562 = llhd.prb %etb_pwm_trig_tim4_off_22 : i1
      cf.cond_br %562, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      llhd.drv %etb_pwmcfg22, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %etb_pwmcfg23, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwmcfg_wen : i1
      cf.cond_br %558, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      %560 = comb.extract %559 from 23 : (i32) -> i1
      llhd.drv %etb_pwmcfg23, %560 after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %561 = llhd.prb %etb_pwm_trig_tim5_on_25 : i1
      cf.cond_br %561, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %etb_pwmcfg23, %true after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %562 = llhd.prb %etb_pwm_trig_tim5_off_24 : i1
      cf.cond_br %562, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      llhd.drv %etb_pwmcfg23, %false after %0 : i1
      cf.br ^bb1
    }
    %79 = llhd.prb %int_pwmcfg : i28
    %80 = llhd.prb %etb_pwmcfg23 : i1
    %81 = llhd.prb %etb_pwmcfg22 : i1
    %82 = llhd.prb %etb_pwmcfg21 : i1
    %83 = llhd.prb %etb_pwmcfg20 : i1
    %84 = llhd.prb %etb_pwmcfg19 : i1
    %85 = llhd.prb %etb_pwmcfg18 : i1
    %86 = comb.concat %c0_i4, %80, %81, %82, %83, %84, %85, %c0_i18 : i4, i1, i1, i1, i1, i1, i1, i18
    %87 = comb.or %79, %86 : i28
    llhd.drv %pwmcfg, %87 after %1 : i28
    %88 = llhd.prb %pwmcfg : i28
    %89 = comb.extract %88 from 0 : (i28) -> i1
    %90 = comb.extract %88 from 1 : (i28) -> i1
    %91 = comb.extract %88 from 2 : (i28) -> i1
    %92 = comb.extract %88 from 3 : (i28) -> i1
    %93 = comb.extract %88 from 4 : (i28) -> i1
    %94 = comb.extract %88 from 5 : (i28) -> i1
    %95 = comb.extract %88 from 6 : (i28) -> i1
    %96 = comb.extract %88 from 7 : (i28) -> i1
    %97 = comb.extract %88 from 8 : (i28) -> i1
    %98 = comb.extract %88 from 9 : (i28) -> i1
    %99 = comb.extract %88 from 10 : (i28) -> i1
    %100 = comb.extract %88 from 11 : (i28) -> i1
    %101 = comb.extract %88 from 12 : (i28) -> i1
    %102 = comb.extract %88 from 13 : (i28) -> i1
    %103 = comb.extract %88 from 14 : (i28) -> i1
    %104 = comb.extract %88 from 15 : (i28) -> i1
    %105 = comb.extract %88 from 16 : (i28) -> i1
    %106 = comb.extract %88 from 17 : (i28) -> i1
    %107 = comb.extract %88 from 18 : (i28) -> i1
    %108 = comb.extract %88 from 19 : (i28) -> i1
    %109 = comb.extract %88 from 20 : (i28) -> i1
    %110 = comb.extract %88 from 21 : (i28) -> i1
    %111 = comb.extract %88 from 22 : (i28) -> i1
    %112 = comb.extract %88 from 23 : (i28) -> i1
    %113 = comb.extract %88 from 24 : (i28) -> i3
    llhd.drv %cntdiv, %113 after %1 : i3
    %114 = comb.extract %88 from 27 : (i28) -> i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwminverttrig, %c0_i25 after %0 : i25
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwminverttrig_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      %560 = comb.extract %559 from 0 : (i32) -> i25
      llhd.drv %int_pwminverttrig, %560 after %0 : i25
      cf.br ^bb1
    }
    %115 = llhd.prb %int_pwminverttrig : i25
    llhd.drv %pwminverttrig, %115 after %1 : i25
    %116 = llhd.prb %pwminverttrig : i25
    %117 = comb.extract %116 from 0 : (i25) -> i1
    %118 = comb.extract %116 from 1 : (i25) -> i1
    %119 = comb.extract %116 from 2 : (i25) -> i1
    %120 = comb.extract %116 from 3 : (i25) -> i1
    %121 = comb.extract %116 from 4 : (i25) -> i1
    %122 = comb.extract %116 from 5 : (i25) -> i1
    %123 = comb.extract %116 from 6 : (i25) -> i1
    %124 = comb.extract %116 from 7 : (i25) -> i1
    %125 = comb.extract %116 from 8 : (i25) -> i1
    %126 = comb.extract %116 from 9 : (i25) -> i1
    %127 = comb.extract %116 from 10 : (i25) -> i1
    %128 = comb.extract %116 from 11 : (i25) -> i1
    %129 = comb.extract %116 from 12 : (i25) -> i1
    %130 = comb.extract %116 from 13 : (i25) -> i1
    %131 = comb.extract %116 from 14 : (i25) -> i1
    %132 = comb.extract %116 from 15 : (i25) -> i1
    %133 = comb.extract %116 from 16 : (i25) -> i1
    %134 = comb.extract %116 from 17 : (i25) -> i1
    %135 = comb.extract %116 from 18 : (i25) -> i1
    %136 = comb.extract %116 from 19 : (i25) -> i1
    %137 = comb.extract %116 from 20 : (i25) -> i1
    %138 = comb.extract %116 from 21 : (i25) -> i1
    %139 = comb.extract %116 from 22 : (i25) -> i1
    %140 = comb.extract %116 from 23 : (i25) -> i1
    %141 = comb.extract %116 from 24 : (i25) -> i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm01trig, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwm01trig_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm01trig, %559 after %0 : i32
      cf.br ^bb1
    }
    %142 = llhd.prb %int_pwm01trig : i32
    llhd.drv %pwm01trig, %142 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm23trig, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwm23trig_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm23trig, %559 after %0 : i32
      cf.br ^bb1
    }
    %143 = llhd.prb %int_pwm23trig : i32
    llhd.drv %pwm23trig, %143 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm45trig, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwm45trig_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm45trig, %559 after %0 : i32
      cf.br ^bb1
    }
    %144 = llhd.prb %int_pwm45trig : i32
    llhd.drv %pwm45trig, %144 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm01trig_h, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %write_reg_sel : i1
      %559 = llhd.prb %paddr_26 : i32
      %560 = comb.extract %559 from 2 : (i32) -> i7
      %561 = comb.icmp eq %560, %c53_i7 : i7
      %562 = comb.and %558, %561 : i1
      cf.cond_br %562, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %563 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm01trig_h, %563 after %0 : i32
      cf.br ^bb1
    }
    %145 = llhd.prb %int_pwm01trig_h : i32
    llhd.drv %pwm01trig_h, %145 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm23trig_h, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %write_reg_sel : i1
      %559 = llhd.prb %paddr_26 : i32
      %560 = comb.extract %559 from 2 : (i32) -> i7
      %561 = comb.icmp eq %560, %c54_i7 : i7
      %562 = comb.and %558, %561 : i1
      cf.cond_br %562, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %563 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm23trig_h, %563 after %0 : i32
      cf.br ^bb1
    }
    %146 = llhd.prb %int_pwm23trig_h : i32
    llhd.drv %pwm23trig_h, %146 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm45trig_h, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %write_reg_sel : i1
      %559 = llhd.prb %paddr_26 : i32
      %560 = comb.extract %559 from 2 : (i32) -> i7
      %561 = comb.icmp eq %560, %c55_i7 : i7
      %562 = comb.and %558, %561 : i1
      cf.cond_br %562, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %563 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm45trig_h, %563 after %0 : i32
      cf.br ^bb1
    }
    %147 = llhd.prb %int_pwm45trig_h : i32
    llhd.drv %pwm45trig_h, %147 after %1 : i32
    %148 = llhd.prb %pwm01trig_h : i32
    %149 = comb.extract %148 from 0 : (i32) -> i16
    %150 = llhd.prb %pwm01trig : i32
    %151 = comb.extract %150 from 0 : (i32) -> i16
    %152 = comb.concat %149, %151 : i16, i16
    llhd.drv %pwm0trig_val, %152 after %1 : i32
    %153 = comb.extract %148 from 16 : (i32) -> i16
    %154 = comb.extract %150 from 16 : (i32) -> i16
    %155 = comb.concat %153, %154 : i16, i16
    llhd.drv %pwm1trig_val, %155 after %1 : i32
    %156 = llhd.prb %pwm23trig_h : i32
    %157 = comb.extract %156 from 0 : (i32) -> i16
    %158 = llhd.prb %pwm23trig : i32
    %159 = comb.extract %158 from 0 : (i32) -> i16
    %160 = comb.concat %157, %159 : i16, i16
    llhd.drv %pwm2trig_val, %160 after %1 : i32
    %161 = comb.extract %156 from 16 : (i32) -> i16
    %162 = comb.extract %158 from 16 : (i32) -> i16
    %163 = comb.concat %161, %162 : i16, i16
    llhd.drv %pwm3trig_val, %163 after %1 : i32
    %164 = llhd.prb %pwm45trig_h : i32
    %165 = comb.extract %164 from 0 : (i32) -> i16
    %166 = llhd.prb %pwm45trig : i32
    %167 = comb.extract %166 from 0 : (i32) -> i16
    %168 = comb.concat %165, %167 : i16, i16
    llhd.drv %pwm4trig_val, %168 after %1 : i32
    %169 = comb.extract %164 from 16 : (i32) -> i16
    %170 = comb.extract %166 from 16 : (i32) -> i16
    %171 = comb.concat %169, %170 : i16, i16
    llhd.drv %pwm5trig_val, %171 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %558 = llhd.sig.extract %int_pwminten1 from %c0_i5 : <i30> -> <i1>
      llhd.drv %558, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %559 = llhd.prb %pwminten1_wen : i1
      cf.cond_br %559, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %560 = llhd.sig.extract %int_pwminten1 from %c0_i5 : <i30> -> <i1>
      %561 = llhd.prb %pwdata_31 : i32
      %562 = comb.extract %561 from 0 : (i32) -> i1
      llhd.drv %560, %562 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %558 = llhd.sig.extract %int_pwminten1 from %c8_i5 : <i30> -> <i6>
      llhd.drv %558, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %559 = llhd.prb %pwminten1_wen : i1
      cf.cond_br %559, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %560 = llhd.sig.extract %int_pwminten1 from %c8_i5 : <i30> -> <i6>
      %561 = llhd.prb %pwdata_31 : i32
      %562 = comb.extract %561 from 8 : (i32) -> i6
      llhd.drv %560, %562 after %0 : i6
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %558 = llhd.sig.extract %int_pwminten1 from %c-16_i5 : <i30> -> <i6>
      llhd.drv %558, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %559 = llhd.prb %pwminten1_wen : i1
      cf.cond_br %559, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %560 = llhd.sig.extract %int_pwminten1 from %c-16_i5 : <i30> -> <i6>
      %561 = llhd.prb %pwdata_31 : i32
      %562 = comb.extract %561 from 16 : (i32) -> i6
      llhd.drv %560, %562 after %0 : i6
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %558 = llhd.sig.extract %int_pwminten1 from %c-8_i5 : <i30> -> <i6>
      llhd.drv %558, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %559 = llhd.prb %pwminten1_wen : i1
      cf.cond_br %559, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %560 = llhd.sig.extract %int_pwminten1 from %c-8_i5 : <i30> -> <i6>
      %561 = llhd.prb %pwdata_31 : i32
      %562 = comb.extract %561 from 24 : (i32) -> i6
      llhd.drv %560, %562 after %0 : i6
      cf.br ^bb1
    }
    %172 = llhd.prb %int_pwminten1 : i30
    %173 = comb.extract %172 from 0 : (i30) -> i1
    %174 = comb.extract %172 from 8 : (i30) -> i1
    %175 = comb.extract %172 from 9 : (i30) -> i1
    %176 = comb.extract %172 from 10 : (i30) -> i1
    %177 = comb.extract %172 from 11 : (i30) -> i1
    %178 = comb.extract %172 from 12 : (i30) -> i1
    %179 = comb.extract %172 from 13 : (i30) -> i1
    %180 = comb.extract %172 from 16 : (i30) -> i1
    %181 = comb.extract %172 from 17 : (i30) -> i1
    %182 = comb.extract %172 from 18 : (i30) -> i1
    %183 = comb.extract %172 from 19 : (i30) -> i1
    %184 = comb.extract %172 from 20 : (i30) -> i1
    %185 = comb.extract %172 from 21 : (i30) -> i1
    %186 = comb.extract %172 from 24 : (i30) -> i1
    %187 = comb.extract %172 from 25 : (i30) -> i1
    %188 = comb.extract %172 from 26 : (i30) -> i1
    %189 = comb.extract %172 from 27 : (i30) -> i1
    %190 = comb.extract %172 from 28 : (i30) -> i1
    %191 = comb.extract %172 from 29 : (i30) -> i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %558 = llhd.sig.extract %int_pwminten2 from %c0_i5 : <i22> -> <i6>
      llhd.drv %558, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %559 = llhd.prb %pwminten2_wen : i1
      cf.cond_br %559, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %560 = llhd.sig.extract %int_pwminten2 from %c0_i5 : <i22> -> <i6>
      %561 = llhd.prb %pwdata_31 : i32
      %562 = comb.extract %561 from 0 : (i32) -> i6
      llhd.drv %560, %562 after %0 : i6
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %558 = llhd.sig.extract %int_pwminten2 from %c8_i5 : <i22> -> <i6>
      llhd.drv %558, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %559 = llhd.prb %pwminten2_wen : i1
      cf.cond_br %559, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %560 = llhd.sig.extract %int_pwminten2 from %c8_i5 : <i22> -> <i6>
      %561 = llhd.prb %pwdata_31 : i32
      %562 = comb.extract %561 from 8 : (i32) -> i6
      llhd.drv %560, %562 after %0 : i6
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %558 = llhd.sig.extract %int_pwminten2 from %c-16_i5 : <i22> -> <i6>
      llhd.drv %558, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %559 = llhd.prb %pwminten2_wen : i1
      cf.cond_br %559, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %560 = llhd.sig.extract %int_pwminten2 from %c-16_i5 : <i22> -> <i6>
      %561 = llhd.prb %pwdata_31 : i32
      %562 = comb.extract %561 from 16 : (i32) -> i6
      llhd.drv %560, %562 after %0 : i6
      cf.br ^bb1
    }
    %192 = llhd.prb %int_pwminten2 : i22
    %193 = comb.extract %192 from 0 : (i22) -> i1
    %194 = comb.extract %192 from 1 : (i22) -> i1
    %195 = comb.extract %192 from 2 : (i22) -> i1
    %196 = comb.extract %192 from 3 : (i22) -> i1
    %197 = comb.extract %192 from 4 : (i22) -> i1
    %198 = comb.extract %192 from 5 : (i22) -> i1
    %199 = comb.extract %192 from 8 : (i22) -> i1
    %200 = comb.extract %192 from 9 : (i22) -> i1
    %201 = comb.extract %192 from 10 : (i22) -> i1
    %202 = comb.extract %192 from 11 : (i22) -> i1
    %203 = comb.extract %192 from 12 : (i22) -> i1
    %204 = comb.extract %192 from 13 : (i22) -> i1
    %205 = comb.extract %192 from 16 : (i22) -> i1
    %206 = comb.extract %192 from 17 : (i22) -> i1
    %207 = comb.extract %192 from 18 : (i22) -> i1
    %208 = comb.extract %192 from 19 : (i22) -> i1
    %209 = comb.extract %192 from 20 : (i22) -> i1
    %210 = comb.extract %192 from 21 : (i22) -> i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %558 = llhd.sig.extract %int_pwmic1 from %c0_i5 : <i30> -> <i1>
      llhd.drv %558, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %559 = llhd.prb %pwmic1_wen : i1
      cf.cond_br %559, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %560 = llhd.sig.extract %int_pwmic1 from %c0_i5 : <i30> -> <i1>
      %561 = llhd.prb %pwdata_31 : i32
      %562 = comb.extract %561 from 0 : (i32) -> i1
      llhd.drv %560, %562 after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %563 = llhd.sig.extract %int_pwmic1 from %c0_i5 : <i30> -> <i1>
      llhd.drv %563, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %558 = llhd.sig.extract %int_pwmic1 from %c8_i5 : <i30> -> <i6>
      llhd.drv %558, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %559 = llhd.prb %pwmic1_wen : i1
      cf.cond_br %559, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %560 = llhd.sig.extract %int_pwmic1 from %c8_i5 : <i30> -> <i6>
      %561 = llhd.prb %pwdata_31 : i32
      %562 = comb.extract %561 from 8 : (i32) -> i6
      llhd.drv %560, %562 after %0 : i6
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %563 = llhd.sig.extract %int_pwmic1 from %c8_i5 : <i30> -> <i6>
      llhd.drv %563, %c0_i6 after %0 : i6
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %558 = llhd.sig.extract %int_pwmic1 from %c-16_i5 : <i30> -> <i6>
      llhd.drv %558, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %559 = llhd.prb %pwmic1_wen : i1
      cf.cond_br %559, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %560 = llhd.sig.extract %int_pwmic1 from %c-16_i5 : <i30> -> <i6>
      %561 = llhd.prb %pwdata_31 : i32
      %562 = comb.extract %561 from 16 : (i32) -> i6
      llhd.drv %560, %562 after %0 : i6
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %563 = llhd.sig.extract %int_pwmic1 from %c-16_i5 : <i30> -> <i6>
      llhd.drv %563, %c0_i6 after %0 : i6
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %558 = llhd.sig.extract %int_pwmic1 from %c-8_i5 : <i30> -> <i6>
      llhd.drv %558, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %559 = llhd.prb %pwmic1_wen : i1
      cf.cond_br %559, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %560 = llhd.sig.extract %int_pwmic1 from %c-8_i5 : <i30> -> <i6>
      %561 = llhd.prb %pwdata_31 : i32
      %562 = comb.extract %561 from 24 : (i32) -> i6
      llhd.drv %560, %562 after %0 : i6
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %563 = llhd.sig.extract %int_pwmic1 from %c-8_i5 : <i30> -> <i6>
      llhd.drv %563, %c0_i6 after %0 : i6
      cf.br ^bb1
    }
    %211 = llhd.prb %int_pwmic1 : i30
    %212 = comb.extract %211 from 0 : (i30) -> i1
    %213 = comb.extract %211 from 8 : (i30) -> i1
    %214 = comb.extract %211 from 9 : (i30) -> i1
    %215 = comb.extract %211 from 10 : (i30) -> i1
    %216 = comb.extract %211 from 11 : (i30) -> i1
    %217 = comb.extract %211 from 12 : (i30) -> i1
    %218 = comb.extract %211 from 13 : (i30) -> i1
    %219 = comb.extract %211 from 16 : (i30) -> i1
    %220 = comb.extract %211 from 17 : (i30) -> i1
    %221 = comb.extract %211 from 18 : (i30) -> i1
    %222 = comb.extract %211 from 19 : (i30) -> i1
    %223 = comb.extract %211 from 20 : (i30) -> i1
    %224 = comb.extract %211 from 21 : (i30) -> i1
    %225 = comb.extract %211 from 24 : (i30) -> i1
    %226 = comb.extract %211 from 25 : (i30) -> i1
    %227 = comb.extract %211 from 26 : (i30) -> i1
    %228 = comb.extract %211 from 27 : (i30) -> i1
    %229 = comb.extract %211 from 28 : (i30) -> i1
    %230 = comb.extract %211 from 29 : (i30) -> i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %558 = llhd.sig.extract %int_pwmic2 from %c0_i5 : <i22> -> <i6>
      llhd.drv %558, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %559 = llhd.prb %pwmic2_wen : i1
      cf.cond_br %559, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %560 = llhd.sig.extract %int_pwmic2 from %c0_i5 : <i22> -> <i6>
      %561 = llhd.prb %pwdata_31 : i32
      %562 = comb.extract %561 from 0 : (i32) -> i6
      llhd.drv %560, %562 after %0 : i6
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %563 = llhd.sig.extract %int_pwmic2 from %c0_i5 : <i22> -> <i6>
      llhd.drv %563, %c0_i6 after %0 : i6
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %558 = llhd.sig.extract %int_pwmic2 from %c8_i5 : <i22> -> <i6>
      llhd.drv %558, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %559 = llhd.prb %pwmic2_wen : i1
      cf.cond_br %559, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %560 = llhd.sig.extract %int_pwmic2 from %c8_i5 : <i22> -> <i6>
      %561 = llhd.prb %pwdata_31 : i32
      %562 = comb.extract %561 from 8 : (i32) -> i6
      llhd.drv %560, %562 after %0 : i6
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %563 = llhd.sig.extract %int_pwmic2 from %c8_i5 : <i22> -> <i6>
      llhd.drv %563, %c0_i6 after %0 : i6
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %558 = llhd.sig.extract %int_pwmic2 from %c-16_i5 : <i22> -> <i6>
      llhd.drv %558, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %559 = llhd.prb %pwmic2_wen : i1
      cf.cond_br %559, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %560 = llhd.sig.extract %int_pwmic2 from %c-16_i5 : <i22> -> <i6>
      %561 = llhd.prb %pwdata_31 : i32
      %562 = comb.extract %561 from 16 : (i32) -> i6
      llhd.drv %560, %562 after %0 : i6
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %563 = llhd.sig.extract %int_pwmic2 from %c-16_i5 : <i22> -> <i6>
      llhd.drv %563, %c0_i6 after %0 : i6
      cf.br ^bb1
    }
    %231 = llhd.prb %int_pwmic2 : i22
    %232 = comb.extract %231 from 0 : (i22) -> i1
    %233 = comb.extract %231 from 1 : (i22) -> i1
    %234 = comb.extract %231 from 2 : (i22) -> i1
    %235 = comb.extract %231 from 3 : (i22) -> i1
    %236 = comb.extract %231 from 4 : (i22) -> i1
    %237 = comb.extract %231 from 5 : (i22) -> i1
    %238 = comb.extract %231 from 8 : (i22) -> i1
    %239 = comb.extract %231 from 9 : (i22) -> i1
    %240 = comb.extract %231 from 10 : (i22) -> i1
    %241 = comb.extract %231 from 11 : (i22) -> i1
    %242 = comb.extract %231 from 12 : (i22) -> i1
    %243 = comb.extract %231 from 13 : (i22) -> i1
    %244 = comb.extract %231 from 16 : (i22) -> i1
    %245 = comb.extract %231 from 17 : (i22) -> i1
    %246 = comb.extract %231 from 18 : (i22) -> i1
    %247 = comb.extract %231 from 19 : (i22) -> i1
    %248 = comb.extract %231 from 20 : (i22) -> i1
    %249 = comb.extract %231 from 21 : (i22) -> i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwmctl, %c0_i18 after %0 : i18
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwmctl_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      %560 = comb.extract %559 from 0 : (i32) -> i18
      llhd.drv %int_pwmctl, %560 after %0 : i18
      cf.br ^bb1
    }
    %250 = llhd.prb %int_pwmctl : i18
    llhd.drv %pwmctl, %250 after %1 : i18
    %251 = llhd.prb %pwmctl : i18
    %252 = comb.extract %251 from 0 : (i18) -> i1
    %253 = comb.extract %251 from 1 : (i18) -> i1
    %254 = comb.extract %251 from 2 : (i18) -> i1
    %255 = comb.extract %251 from 3 : (i18) -> i1
    %256 = comb.extract %251 from 4 : (i18) -> i1
    %257 = comb.extract %251 from 5 : (i18) -> i1
    %258 = comb.extract %251 from 6 : (i18) -> i2
    llhd.drv %sync0mode, %258 after %1 : i2
    %259 = comb.extract %251 from 8 : (i18) -> i2
    llhd.drv %sync1mode, %259 after %1 : i2
    %260 = comb.extract %251 from 10 : (i18) -> i2
    llhd.drv %sync2mode, %260 after %1 : i2
    %261 = comb.extract %251 from 12 : (i18) -> i2
    llhd.drv %sync3mode, %261 after %1 : i2
    %262 = comb.extract %251 from 14 : (i18) -> i2
    llhd.drv %sync4mode, %262 after %1 : i2
    %263 = comb.extract %251 from 16 : (i18) -> i2
    llhd.drv %sync5mode, %263 after %1 : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm01load, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwm01load_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm01load, %559 after %0 : i32
      cf.br ^bb1
    }
    %264 = llhd.prb %int_pwm01load : i32
    llhd.drv %pwm01load, %264 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm23load, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwm23load_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm23load, %559 after %0 : i32
      cf.br ^bb1
    }
    %265 = llhd.prb %int_pwm23load : i32
    llhd.drv %pwm23load, %265 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm45load, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwm45load_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm45load, %559 after %0 : i32
      cf.br ^bb1
    }
    %266 = llhd.prb %int_pwm45load : i32
    llhd.drv %pwm45load, %266 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm01load_h, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %write_reg_sel : i1
      %559 = llhd.prb %paddr_26 : i32
      %560 = comb.extract %559 from 2 : (i32) -> i7
      %561 = comb.icmp eq %560, %c-63_i7 : i7
      %562 = comb.and %558, %561 : i1
      cf.cond_br %562, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %563 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm01load_h, %563 after %0 : i32
      cf.br ^bb1
    }
    %267 = llhd.prb %int_pwm01load_h : i32
    llhd.drv %pwm01load_h, %267 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm23load_h, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %write_reg_sel : i1
      %559 = llhd.prb %paddr_26 : i32
      %560 = comb.extract %559 from 2 : (i32) -> i7
      %561 = comb.icmp eq %560, %c-62_i7 : i7
      %562 = comb.and %558, %561 : i1
      cf.cond_br %562, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %563 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm23load_h, %563 after %0 : i32
      cf.br ^bb1
    }
    %268 = llhd.prb %int_pwm23load_h : i32
    llhd.drv %pwm23load_h, %268 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm45load_h, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %write_reg_sel : i1
      %559 = llhd.prb %paddr_26 : i32
      %560 = comb.extract %559 from 2 : (i32) -> i7
      %561 = comb.icmp eq %560, %c-61_i7 : i7
      %562 = comb.and %558, %561 : i1
      cf.cond_br %562, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %563 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm45load_h, %563 after %0 : i32
      cf.br ^bb1
    }
    %269 = llhd.prb %int_pwm45load_h : i32
    llhd.drv %pwm45load_h, %269 after %1 : i32
    %270 = llhd.prb %pwm01load_h : i32
    %271 = comb.extract %270 from 0 : (i32) -> i16
    %272 = llhd.prb %pwm01load : i32
    %273 = comb.extract %272 from 0 : (i32) -> i16
    %274 = comb.concat %271, %273 : i16, i16
    llhd.drv %pwm0load, %274 after %1 : i32
    %275 = comb.extract %270 from 16 : (i32) -> i16
    %276 = comb.extract %272 from 16 : (i32) -> i16
    %277 = comb.concat %275, %276 : i16, i16
    llhd.drv %pwm1load, %277 after %1 : i32
    %278 = llhd.prb %pwm23load_h : i32
    %279 = comb.extract %278 from 0 : (i32) -> i16
    %280 = llhd.prb %pwm23load : i32
    %281 = comb.extract %280 from 0 : (i32) -> i16
    %282 = comb.concat %279, %281 : i16, i16
    llhd.drv %pwm2load, %282 after %1 : i32
    %283 = comb.extract %278 from 16 : (i32) -> i16
    %284 = comb.extract %280 from 16 : (i32) -> i16
    %285 = comb.concat %283, %284 : i16, i16
    llhd.drv %pwm3load, %285 after %1 : i32
    %286 = llhd.prb %pwm45load_h : i32
    %287 = comb.extract %286 from 0 : (i32) -> i16
    %288 = llhd.prb %pwm45load : i32
    %289 = comb.extract %288 from 0 : (i32) -> i16
    %290 = comb.concat %287, %289 : i16, i16
    llhd.drv %pwm4load, %290 after %1 : i32
    %291 = comb.extract %286 from 16 : (i32) -> i16
    %292 = comb.extract %288 from 16 : (i32) -> i16
    %293 = comb.concat %291, %292 : i16, i16
    llhd.drv %pwm5load, %293 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm0cmp, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwm0cmp_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm0cmp, %559 after %0 : i32
      cf.br ^bb1
    }
    %294 = llhd.prb %int_pwm0cmp : i32
    llhd.drv %pwm0cmp, %294 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm1cmp, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwm1cmp_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm1cmp, %559 after %0 : i32
      cf.br ^bb1
    }
    %295 = llhd.prb %int_pwm1cmp : i32
    llhd.drv %pwm1cmp, %295 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm2cmp, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwm2cmp_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm2cmp, %559 after %0 : i32
      cf.br ^bb1
    }
    %296 = llhd.prb %int_pwm2cmp : i32
    llhd.drv %pwm2cmp, %296 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm3cmp, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwm3cmp_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm3cmp, %559 after %0 : i32
      cf.br ^bb1
    }
    %297 = llhd.prb %int_pwm3cmp : i32
    llhd.drv %pwm3cmp, %297 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm4cmp, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwm4cmp_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm4cmp, %559 after %0 : i32
      cf.br ^bb1
    }
    %298 = llhd.prb %int_pwm4cmp : i32
    llhd.drv %pwm4cmp, %298 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm5cmp, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwm5cmp_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm5cmp, %559 after %0 : i32
      cf.br ^bb1
    }
    %299 = llhd.prb %int_pwm5cmp : i32
    llhd.drv %pwm5cmp, %299 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm0cmp_h, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %write_reg_sel : i1
      %559 = llhd.prb %paddr_26 : i32
      %560 = comb.extract %559 from 2 : (i32) -> i6
      %561 = comb.icmp eq %560, %c-8_i6 : i6
      %562 = comb.and %558, %561 : i1
      cf.cond_br %562, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %563 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm0cmp_h, %563 after %0 : i32
      cf.br ^bb1
    }
    %300 = llhd.prb %int_pwm0cmp_h : i32
    llhd.drv %pwm0cmp_h, %300 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm1cmp_h, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %write_reg_sel : i1
      %559 = llhd.prb %paddr_26 : i32
      %560 = comb.extract %559 from 2 : (i32) -> i6
      %561 = comb.icmp eq %560, %c-7_i6 : i6
      %562 = comb.and %558, %561 : i1
      cf.cond_br %562, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %563 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm1cmp_h, %563 after %0 : i32
      cf.br ^bb1
    }
    %301 = llhd.prb %int_pwm1cmp_h : i32
    llhd.drv %pwm1cmp_h, %301 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm2cmp_h, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %write_reg_sel : i1
      %559 = llhd.prb %paddr_26 : i32
      %560 = comb.extract %559 from 2 : (i32) -> i7
      %561 = comb.icmp eq %560, %c58_i7 : i7
      %562 = comb.and %558, %561 : i1
      cf.cond_br %562, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %563 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm2cmp_h, %563 after %0 : i32
      cf.br ^bb1
    }
    %302 = llhd.prb %int_pwm2cmp_h : i32
    llhd.drv %pwm2cmp_h, %302 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm3cmp_h, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %write_reg_sel : i1
      %559 = llhd.prb %paddr_26 : i32
      %560 = comb.extract %559 from 2 : (i32) -> i7
      %561 = comb.icmp eq %560, %c59_i7 : i7
      %562 = comb.and %558, %561 : i1
      cf.cond_br %562, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %563 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm3cmp_h, %563 after %0 : i32
      cf.br ^bb1
    }
    %303 = llhd.prb %int_pwm3cmp_h : i32
    llhd.drv %pwm3cmp_h, %303 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm4cmp_h, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %write_reg_sel : i1
      %559 = llhd.prb %paddr_26 : i32
      %560 = comb.extract %559 from 2 : (i32) -> i7
      %561 = comb.icmp eq %560, %c60_i7 : i7
      %562 = comb.and %558, %561 : i1
      cf.cond_br %562, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %563 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm4cmp_h, %563 after %0 : i32
      cf.br ^bb1
    }
    %304 = llhd.prb %int_pwm4cmp_h : i32
    llhd.drv %pwm4cmp_h, %304 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm5cmp_h, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %write_reg_sel : i1
      %559 = llhd.prb %paddr_26 : i32
      %560 = comb.extract %559 from 2 : (i32) -> i7
      %561 = comb.icmp eq %560, %c61_i7 : i7
      %562 = comb.and %558, %561 : i1
      cf.cond_br %562, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %563 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_pwm5cmp_h, %563 after %0 : i32
      cf.br ^bb1
    }
    %305 = llhd.prb %int_pwm5cmp_h : i32
    llhd.drv %pwm5cmp_h, %305 after %1 : i32
    %306 = llhd.prb %pwm0cmp_h : i32
    %307 = comb.extract %306 from 0 : (i32) -> i16
    %308 = llhd.prb %pwm0cmp : i32
    %309 = comb.extract %308 from 0 : (i32) -> i16
    %310 = comb.concat %307, %309 : i16, i16
    llhd.drv %compa_val_0, %310 after %1 : i32
    %311 = llhd.prb %pwm1cmp_h : i32
    %312 = comb.extract %311 from 0 : (i32) -> i16
    %313 = llhd.prb %pwm1cmp : i32
    %314 = comb.extract %313 from 0 : (i32) -> i16
    %315 = comb.concat %312, %314 : i16, i16
    llhd.drv %compa_val_1, %315 after %1 : i32
    %316 = llhd.prb %pwm2cmp_h : i32
    %317 = comb.extract %316 from 0 : (i32) -> i16
    %318 = llhd.prb %pwm2cmp : i32
    %319 = comb.extract %318 from 0 : (i32) -> i16
    %320 = comb.concat %317, %319 : i16, i16
    llhd.drv %compa_val_2, %320 after %1 : i32
    %321 = llhd.prb %pwm3cmp_h : i32
    %322 = comb.extract %321 from 0 : (i32) -> i16
    %323 = llhd.prb %pwm3cmp : i32
    %324 = comb.extract %323 from 0 : (i32) -> i16
    %325 = comb.concat %322, %324 : i16, i16
    llhd.drv %compa_val_3, %325 after %1 : i32
    %326 = llhd.prb %pwm4cmp_h : i32
    %327 = comb.extract %326 from 0 : (i32) -> i16
    %328 = llhd.prb %pwm4cmp : i32
    %329 = comb.extract %328 from 0 : (i32) -> i16
    %330 = comb.concat %327, %329 : i16, i16
    llhd.drv %compa_val_4, %330 after %1 : i32
    %331 = llhd.prb %pwm5cmp_h : i32
    %332 = comb.extract %331 from 0 : (i32) -> i16
    %333 = llhd.prb %pwm5cmp : i32
    %334 = comb.extract %333 from 0 : (i32) -> i16
    %335 = comb.concat %332, %334 : i16, i16
    llhd.drv %compa_val_5, %335 after %1 : i32
    %336 = comb.extract %306 from 16 : (i32) -> i16
    %337 = comb.extract %308 from 16 : (i32) -> i16
    %338 = comb.concat %336, %337 : i16, i16
    llhd.drv %compb_val_0, %338 after %1 : i32
    %339 = comb.extract %311 from 16 : (i32) -> i16
    %340 = comb.extract %313 from 16 : (i32) -> i16
    %341 = comb.concat %339, %340 : i16, i16
    llhd.drv %compb_val_1, %341 after %1 : i32
    %342 = comb.extract %316 from 16 : (i32) -> i16
    %343 = comb.extract %318 from 16 : (i32) -> i16
    %344 = comb.concat %342, %343 : i16, i16
    llhd.drv %compb_val_2, %344 after %1 : i32
    %345 = comb.extract %321 from 16 : (i32) -> i16
    %346 = comb.extract %323 from 16 : (i32) -> i16
    %347 = comb.concat %345, %346 : i16, i16
    llhd.drv %compb_val_3, %347 after %1 : i32
    %348 = comb.extract %326 from 16 : (i32) -> i16
    %349 = comb.extract %328 from 16 : (i32) -> i16
    %350 = comb.concat %348, %349 : i16, i16
    llhd.drv %compb_val_4, %350 after %1 : i32
    %351 = comb.extract %331 from 16 : (i32) -> i16
    %352 = comb.extract %333 from 16 : (i32) -> i16
    %353 = comb.concat %351, %352 : i16, i16
    llhd.drv %compb_val_5, %353 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm01db, %c0_i26 after %0 : i26
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwm01db_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      %560 = comb.extract %559 from 0 : (i32) -> i26
      llhd.drv %int_pwm01db, %560 after %0 : i26
      cf.br ^bb1
    }
    %354 = llhd.prb %int_pwm01db : i26
    llhd.drv %pwm01db, %354 after %1 : i26
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm23db, %c0_i26 after %0 : i26
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwm23db_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      %560 = comb.extract %559 from 0 : (i32) -> i26
      llhd.drv %int_pwm23db, %560 after %0 : i26
      cf.br ^bb1
    }
    %355 = llhd.prb %int_pwm23db : i26
    llhd.drv %pwm23db, %355 after %1 : i26
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm45db, %c0_i26 after %0 : i26
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwm45db_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      %560 = comb.extract %559 from 0 : (i32) -> i26
      llhd.drv %int_pwm45db, %560 after %0 : i26
      cf.br ^bb1
    }
    %356 = llhd.prb %int_pwm45db : i26
    llhd.drv %pwm45db, %356 after %1 : i26
    %357 = llhd.prb %pwm01db : i26
    %358 = comb.extract %357 from 24 : (i26) -> i1
    %359 = comb.extract %357 from 25 : (i26) -> i1
    %360 = llhd.prb %pwm23db : i26
    %361 = comb.extract %360 from 24 : (i26) -> i1
    %362 = comb.extract %360 from 25 : (i26) -> i1
    %363 = llhd.prb %pwm45db : i26
    %364 = comb.extract %363 from 24 : (i26) -> i1
    %365 = comb.extract %363 from 25 : (i26) -> i1
    %366 = comb.extract %357 from 0 : (i26) -> i12
    llhd.drv %delay0, %366 after %1 : i12
    %367 = comb.extract %357 from 12 : (i26) -> i12
    llhd.drv %delay1, %367 after %1 : i12
    %368 = comb.extract %360 from 0 : (i26) -> i12
    llhd.drv %delay2, %368 after %1 : i12
    %369 = comb.extract %360 from 12 : (i26) -> i12
    llhd.drv %delay3, %369 after %1 : i12
    %370 = comb.extract %363 from 0 : (i26) -> i12
    llhd.drv %delay4, %370 after %1 : i12
    %371 = comb.extract %363 from 12 : (i26) -> i12
    llhd.drv %delay5, %371 after %1 : i12
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_capctl, %c0_i18 after %0 : i18
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %capctl_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      %560 = comb.extract %559 from 0 : (i32) -> i18
      llhd.drv %int_capctl, %560 after %0 : i18
      cf.br ^bb1
    }
    %372 = llhd.prb %int_capctl : i18
    llhd.drv %capctl, %372 after %1 : i18
    %373 = llhd.prb %capctl : i18
    %374 = comb.extract %373 from 0 : (i18) -> i1
    %375 = comb.extract %373 from 1 : (i18) -> i1
    %376 = comb.extract %373 from 2 : (i18) -> i1
    %377 = comb.extract %373 from 3 : (i18) -> i1
    %378 = comb.extract %373 from 4 : (i18) -> i1
    %379 = comb.extract %373 from 5 : (i18) -> i1
    %380 = comb.extract %373 from 6 : (i18) -> i2
    llhd.drv %cap0eventa, %380 after %1 : i2
    %381 = comb.extract %373 from 8 : (i18) -> i2
    llhd.drv %cap1eventa, %381 after %1 : i2
    %382 = comb.extract %373 from 10 : (i18) -> i2
    llhd.drv %cap2eventa, %382 after %1 : i2
    %383 = comb.extract %373 from 12 : (i18) -> i2
    llhd.drv %cap3eventa, %383 after %1 : i2
    %384 = comb.extract %373 from 14 : (i18) -> i2
    llhd.drv %cap4eventa, %384 after %1 : i2
    %385 = comb.extract %373 from 16 : (i18) -> i2
    llhd.drv %cap5eventa, %385 after %1 : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_capinten, %c0_i12 after %0 : i12
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %capinten_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      %560 = comb.extract %559 from 0 : (i32) -> i12
      llhd.drv %int_capinten, %560 after %0 : i12
      cf.br ^bb1
    }
    %386 = llhd.prb %int_capinten : i12
    llhd.drv %capinten, %386 after %1 : i12
    %387 = llhd.prb %capinten : i12
    %388 = comb.extract %387 from 0 : (i12) -> i1
    %389 = comb.extract %387 from 1 : (i12) -> i1
    %390 = comb.extract %387 from 2 : (i12) -> i1
    %391 = comb.extract %387 from 3 : (i12) -> i1
    %392 = comb.extract %387 from 4 : (i12) -> i1
    %393 = comb.extract %387 from 5 : (i12) -> i1
    %394 = comb.extract %387 from 6 : (i12) -> i1
    %395 = comb.extract %387 from 7 : (i12) -> i1
    %396 = comb.extract %387 from 8 : (i12) -> i1
    %397 = comb.extract %387 from 9 : (i12) -> i1
    %398 = comb.extract %387 from 10 : (i12) -> i1
    %399 = comb.extract %387 from 11 : (i12) -> i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_capic, %c0_i12 after %0 : i12
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %capic_wen : i1
      cf.cond_br %558, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      %560 = comb.extract %559 from 0 : (i32) -> i12
      llhd.drv %int_capic, %560 after %0 : i12
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      llhd.drv %int_capic, %c0_i12 after %0 : i12
      cf.br ^bb1
    }
    %400 = llhd.prb %int_capic : i12
    llhd.drv %capic, %400 after %1 : i12
    %401 = llhd.prb %capic : i12
    %402 = comb.extract %401 from 0 : (i12) -> i1
    %403 = comb.extract %401 from 1 : (i12) -> i1
    %404 = comb.extract %401 from 2 : (i12) -> i1
    %405 = comb.extract %401 from 3 : (i12) -> i1
    %406 = comb.extract %401 from 4 : (i12) -> i1
    %407 = comb.extract %401 from 5 : (i12) -> i1
    %408 = comb.extract %401 from 6 : (i12) -> i1
    %409 = comb.extract %401 from 7 : (i12) -> i1
    %410 = comb.extract %401 from 8 : (i12) -> i1
    %411 = comb.extract %401 from 9 : (i12) -> i1
    %412 = comb.extract %401 from 10 : (i12) -> i1
    %413 = comb.extract %401 from 11 : (i12) -> i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_cap01match, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %cap01match_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_cap01match, %559 after %0 : i32
      cf.br ^bb1
    }
    %414 = llhd.prb %int_cap01match : i32
    llhd.drv %cap01match, %414 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_cap23match, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %cap23match_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_cap23match, %559 after %0 : i32
      cf.br ^bb1
    }
    %415 = llhd.prb %int_cap23match : i32
    llhd.drv %cap23match, %415 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_cap45match, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %cap45match_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_cap45match, %559 after %0 : i32
      cf.br ^bb1
    }
    %416 = llhd.prb %int_cap45match : i32
    llhd.drv %cap45match, %416 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_cap01match_h, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %write_reg_sel : i1
      %559 = llhd.prb %paddr_26 : i32
      %560 = comb.extract %559 from 2 : (i32) -> i7
      %561 = comb.icmp eq %560, %c-60_i7 : i7
      %562 = comb.and %558, %561 : i1
      cf.cond_br %562, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %563 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_cap01match_h, %563 after %0 : i32
      cf.br ^bb1
    }
    %417 = llhd.prb %int_cap01match_h : i32
    llhd.drv %cap01match_h, %417 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_cap23match_h, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %write_reg_sel : i1
      %559 = llhd.prb %paddr_26 : i32
      %560 = comb.extract %559 from 2 : (i32) -> i7
      %561 = comb.icmp eq %560, %c-59_i7 : i7
      %562 = comb.and %558, %561 : i1
      cf.cond_br %562, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %563 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_cap23match_h, %563 after %0 : i32
      cf.br ^bb1
    }
    %418 = llhd.prb %int_cap23match_h : i32
    llhd.drv %cap23match_h, %418 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_cap45match_h, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %write_reg_sel : i1
      %559 = llhd.prb %paddr_26 : i32
      %560 = comb.extract %559 from 2 : (i32) -> i7
      %561 = comb.icmp eq %560, %c-58_i7 : i7
      %562 = comb.and %558, %561 : i1
      cf.cond_br %562, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %563 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_cap45match_h, %563 after %0 : i32
      cf.br ^bb1
    }
    %419 = llhd.prb %int_cap45match_h : i32
    llhd.drv %cap45match_h, %419 after %1 : i32
    %420 = llhd.prb %cap01match_h : i32
    %421 = comb.extract %420 from 0 : (i32) -> i16
    %422 = llhd.prb %cap01match : i32
    %423 = comb.extract %422 from 0 : (i32) -> i16
    %424 = comb.concat %421, %423 : i16, i16
    llhd.drv %cap0match, %424 after %1 : i32
    %425 = comb.extract %420 from 16 : (i32) -> i16
    %426 = comb.extract %422 from 16 : (i32) -> i16
    %427 = comb.concat %425, %426 : i16, i16
    llhd.drv %cap1match, %427 after %1 : i32
    %428 = llhd.prb %cap23match_h : i32
    %429 = comb.extract %428 from 0 : (i32) -> i16
    %430 = llhd.prb %cap23match : i32
    %431 = comb.extract %430 from 0 : (i32) -> i16
    %432 = comb.concat %429, %431 : i16, i16
    llhd.drv %cap2match, %432 after %1 : i32
    %433 = comb.extract %428 from 16 : (i32) -> i16
    %434 = comb.extract %430 from 16 : (i32) -> i16
    %435 = comb.concat %433, %434 : i16, i16
    llhd.drv %cap3match, %435 after %1 : i32
    %436 = llhd.prb %cap45match_h : i32
    %437 = comb.extract %436 from 0 : (i32) -> i16
    %438 = llhd.prb %cap45match : i32
    %439 = comb.extract %438 from 0 : (i32) -> i16
    %440 = comb.concat %437, %439 : i16, i16
    llhd.drv %cap4match, %440 after %1 : i32
    %441 = comb.extract %436 from 16 : (i32) -> i16
    %442 = comb.extract %438 from 16 : (i32) -> i16
    %443 = comb.concat %441, %442 : i16, i16
    llhd.drv %cap5match, %443 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_timinten, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %timinten_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      %560 = comb.extract %559 from 0 : (i32) -> i6
      llhd.drv %int_timinten, %560 after %0 : i6
      cf.br ^bb1
    }
    %444 = llhd.prb %int_timinten : i6
    llhd.drv %timinten, %444 after %1 : i6
    %445 = llhd.prb %timinten : i6
    %446 = comb.extract %445 from 0 : (i6) -> i1
    %447 = comb.extract %445 from 1 : (i6) -> i1
    %448 = comb.extract %445 from 2 : (i6) -> i1
    %449 = comb.extract %445 from 3 : (i6) -> i1
    %450 = comb.extract %445 from 4 : (i6) -> i1
    %451 = comb.extract %445 from 5 : (i6) -> i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_timic, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %timic_wen : i1
      cf.cond_br %558, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      %560 = comb.extract %559 from 0 : (i32) -> i6
      llhd.drv %int_timic, %560 after %0 : i6
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      llhd.drv %int_timic, %c0_i6 after %0 : i6
      cf.br ^bb1
    }
    %452 = llhd.prb %int_timic : i6
    llhd.drv %timic, %452 after %1 : i6
    %453 = llhd.prb %timic : i6
    %454 = comb.extract %453 from 0 : (i6) -> i1
    %455 = comb.extract %453 from 1 : (i6) -> i1
    %456 = comb.extract %453 from 2 : (i6) -> i1
    %457 = comb.extract %453 from 3 : (i6) -> i1
    %458 = comb.extract %453 from 4 : (i6) -> i1
    %459 = comb.extract %453 from 5 : (i6) -> i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_tim01load, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %tim01load_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_tim01load, %559 after %0 : i32
      cf.br ^bb1
    }
    %460 = llhd.prb %int_tim01load : i32
    llhd.drv %tim01load, %460 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_tim23load, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %tim23load_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_tim23load, %559 after %0 : i32
      cf.br ^bb1
    }
    %461 = llhd.prb %int_tim23load : i32
    llhd.drv %tim23load, %461 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_tim45load, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %tim45load_wen : i1
      cf.cond_br %558, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %559 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_tim45load, %559 after %0 : i32
      cf.br ^bb1
    }
    %462 = llhd.prb %int_tim45load : i32
    llhd.drv %tim45load, %462 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_tim01load_h, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %write_reg_sel : i1
      %559 = llhd.prb %paddr_26 : i32
      %560 = comb.extract %559 from 2 : (i32) -> i7
      %561 = comb.icmp eq %560, %c62_i7 : i7
      %562 = comb.and %558, %561 : i1
      cf.cond_br %562, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %563 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_tim01load_h, %563 after %0 : i32
      cf.br ^bb1
    }
    %463 = llhd.prb %int_tim01load_h : i32
    llhd.drv %tim01load_h, %463 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_tim23load_h, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %write_reg_sel : i1
      %559 = llhd.prb %paddr_26 : i32
      %560 = comb.extract %559 from 2 : (i32) -> i7
      %561 = comb.icmp eq %560, %c63_i7 : i7
      %562 = comb.and %558, %561 : i1
      cf.cond_br %562, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %563 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_tim23load_h, %563 after %0 : i32
      cf.br ^bb1
    }
    %464 = llhd.prb %int_tim23load_h : i32
    llhd.drv %tim23load_h, %464 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_tim45load_h, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %write_reg_sel : i1
      %559 = llhd.prb %paddr_26 : i32
      %560 = comb.extract %559 from 2 : (i32) -> i7
      %561 = comb.icmp eq %560, %c-64_i7 : i7
      %562 = comb.and %558, %561 : i1
      cf.cond_br %562, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %563 = llhd.prb %pwdata_31 : i32
      llhd.drv %int_tim45load_h, %563 after %0 : i32
      cf.br ^bb1
    }
    %465 = llhd.prb %int_tim45load_h : i32
    llhd.drv %tim45load_h, %465 after %1 : i32
    %466 = llhd.prb %tim01load_h : i32
    %467 = comb.extract %466 from 0 : (i32) -> i16
    %468 = llhd.prb %tim01load : i32
    %469 = comb.extract %468 from 0 : (i32) -> i16
    %470 = comb.concat %467, %469 : i16, i16
    llhd.drv %tim0load, %470 after %1 : i32
    %471 = comb.extract %466 from 16 : (i32) -> i16
    %472 = comb.extract %468 from 16 : (i32) -> i16
    %473 = comb.concat %471, %472 : i16, i16
    llhd.drv %tim1load, %473 after %1 : i32
    %474 = llhd.prb %tim23load_h : i32
    %475 = comb.extract %474 from 0 : (i32) -> i16
    %476 = llhd.prb %tim23load : i32
    %477 = comb.extract %476 from 0 : (i32) -> i16
    %478 = comb.concat %475, %477 : i16, i16
    llhd.drv %tim2load, %478 after %1 : i32
    %479 = comb.extract %474 from 16 : (i32) -> i16
    %480 = comb.extract %476 from 16 : (i32) -> i16
    %481 = comb.concat %479, %480 : i16, i16
    llhd.drv %tim3load, %481 after %1 : i32
    %482 = llhd.prb %tim45load_h : i32
    %483 = comb.extract %482 from 0 : (i32) -> i16
    %484 = llhd.prb %tim45load : i32
    %485 = comb.extract %484 from 0 : (i32) -> i16
    %486 = comb.concat %483, %485 : i16, i16
    llhd.drv %tim4load, %486 after %1 : i32
    %487 = comb.extract %482 from 16 : (i32) -> i16
    %488 = comb.extract %484 from 16 : (i32) -> i16
    %489 = comb.concat %487, %488 : i16, i16
    llhd.drv %tim5load, %489 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 88 preds: ^bb0, ^bb2, ^bb4, ^bb7, ^bb9, ^bb11, ^bb13, ^bb15, ^bb17, ^bb19, ^bb21, ^bb23, ^bb25, ^bb27, ^bb29, ^bb31, ^bb33, ^bb35, ^bb37, ^bb39, ^bb41, ^bb43, ^bb45, ^bb47, ^bb49, ^bb51, ^bb53, ^bb55, ^bb57, ^bb59, ^bb61, ^bb63, ^bb65, ^bb67, ^bb69, ^bb71, ^bb73, ^bb75, ^bb77, ^bb79, ^bb81, ^bb83, ^bb85, ^bb87, ^bb89, ^bb91, ^bb93, ^bb95, ^bb97, ^bb99, ^bb101, ^bb103, ^bb105, ^bb107, ^bb109, ^bb111, ^bb113, ^bb115, ^bb117, ^bb119, ^bb121, ^bb123, ^bb125, ^bb127, ^bb129, ^bb131, ^bb133, ^bb135, ^bb137, ^bb139, ^bb141, ^bb143, ^bb145, ^bb147, ^bb149, ^bb151, ^bb153, ^bb155, ^bb157, ^bb159, ^bb161, ^bb163, ^bb165, ^bb167, ^bb169, ^bb171, ^bb172, ^bb173
      %547 = llhd.prb %pclk_27 : i1
      %548 = llhd.prb %presetn_29 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %549 = llhd.prb %pclk_27 : i1
      %550 = comb.xor bin %547, %true : i1
      %551 = comb.and bin %550, %549 : i1
      %552 = llhd.prb %presetn_29 : i1
      %553 = comb.xor bin %552, %true : i1
      %554 = comb.and bin %548, %553 : i1
      %555 = comb.or bin %551, %554 : i1
      cf.cond_br %555, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %556 = llhd.prb %presetn_29 : i1
      %557 = comb.xor %556, %true : i1
      cf.cond_br %557, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %iprdata, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %558 = llhd.prb %pwrite_42 : i1
      %559 = comb.xor %558, %true : i1
      %560 = llhd.prb %psel_30 : i1
      %561 = llhd.prb %penable_28 : i1
      %562 = comb.xor %561, %true : i1
      %563 = llhd.prb %paddr_26 : i32
      %564 = comb.extract %563 from 9 : (i32) -> i3
      %565 = comb.icmp eq %564, %c0_i3 : i3
      %566 = comb.and %559, %560, %562, %565 : i1
      cf.cond_br %566, ^bb6, ^bb173
    ^bb6:  // pred: ^bb5
      %567 = llhd.prb %paddr_26 : i32
      %568 = comb.extract %567 from 2 : (i32) -> i7
      %569 = comb.icmp ceq %568, %c0_i7 : i7
      cf.cond_br %569, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %570 = llhd.prb %pwmcfg : i28
      %571 = comb.concat %c0_i4, %570 : i4, i28
      llhd.drv %iprdata, %571 after %0 : i32
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %572 = comb.icmp ceq %568, %c1_i7 : i7
      cf.cond_br %572, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %573 = llhd.prb %pwminverttrig : i25
      %574 = comb.concat %c0_i7, %573 : i7, i25
      llhd.drv %iprdata, %574 after %0 : i32
      cf.br ^bb1
    ^bb10:  // pred: ^bb8
      %575 = comb.icmp ceq %568, %c5_i7 : i7
      cf.cond_br %575, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %576 = llhd.prb %int_pwminten1 : i30
      %577 = comb.extract %576 from 24 : (i30) -> i6
      %578 = comb.extract %576 from 16 : (i30) -> i6
      %579 = comb.extract %576 from 8 : (i30) -> i6
      %580 = comb.extract %576 from 0 : (i30) -> i1
      %581 = comb.concat %c0_i2, %577, %c0_i2, %578, %c0_i2, %579, %c0_i7, %580 : i2, i6, i2, i6, i2, i6, i7, i1
      llhd.drv %iprdata, %581 after %0 : i32
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      %582 = comb.icmp ceq %568, %c6_i7 : i7
      cf.cond_br %582, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      %583 = llhd.prb %int_pwminten2 : i22
      %584 = comb.extract %583 from 16 : (i22) -> i6
      %585 = comb.extract %583 from 8 : (i22) -> i6
      %586 = comb.extract %583 from 0 : (i22) -> i6
      %587 = comb.concat %c0_i10, %584, %c0_i2, %585, %c0_i2, %586 : i10, i6, i2, i6, i2, i6
      llhd.drv %iprdata, %587 after %0 : i32
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      %588 = comb.icmp ceq %568, %c7_i7 : i7
      cf.cond_br %588, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      %589 = llhd.prb %pwmris1_40 : i32
      llhd.drv %iprdata, %589 after %0 : i32
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      %590 = comb.icmp ceq %568, %c8_i7 : i7
      cf.cond_br %590, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      %591 = llhd.prb %pwmris2_41 : i32
      llhd.drv %iprdata, %591 after %0 : i32
      cf.br ^bb1
    ^bb18:  // pred: ^bb16
      %592 = comb.icmp ceq %568, %c9_i7 : i7
      cf.cond_br %592, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %593 = llhd.prb %int_pwmic1 : i30
      %594 = comb.extract %593 from 24 : (i30) -> i6
      %595 = comb.extract %593 from 16 : (i30) -> i6
      %596 = comb.extract %593 from 8 : (i30) -> i6
      %597 = comb.extract %593 from 0 : (i30) -> i1
      %598 = comb.concat %c0_i2, %594, %c0_i2, %595, %c0_i2, %596, %c0_i7, %597 : i2, i6, i2, i6, i2, i6, i7, i1
      llhd.drv %iprdata, %598 after %0 : i32
      cf.br ^bb1
    ^bb20:  // pred: ^bb18
      %599 = comb.icmp ceq %568, %c10_i7 : i7
      cf.cond_br %599, ^bb21, ^bb22
    ^bb21:  // pred: ^bb20
      %600 = llhd.prb %int_pwmic2 : i22
      %601 = comb.extract %600 from 16 : (i22) -> i6
      %602 = comb.extract %600 from 8 : (i22) -> i6
      %603 = comb.extract %600 from 0 : (i22) -> i6
      %604 = comb.concat %c0_i10, %601, %c0_i2, %602, %c0_i2, %603 : i10, i6, i2, i6, i2, i6
      llhd.drv %iprdata, %604 after %0 : i32
      cf.br ^bb1
    ^bb22:  // pred: ^bb20
      %605 = comb.icmp ceq %568, %c11_i7 : i7
      cf.cond_br %605, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      %606 = llhd.prb %pwmis1_38 : i32
      llhd.drv %iprdata, %606 after %0 : i32
      cf.br ^bb1
    ^bb24:  // pred: ^bb22
      %607 = comb.icmp ceq %568, %c12_i7 : i7
      cf.cond_br %607, ^bb25, ^bb26
    ^bb25:  // pred: ^bb24
      %608 = llhd.prb %pwmis2_39 : i32
      llhd.drv %iprdata, %608 after %0 : i32
      cf.br ^bb1
    ^bb26:  // pred: ^bb24
      %609 = comb.icmp ceq %568, %c13_i7 : i7
      cf.cond_br %609, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      %610 = llhd.prb %pwmctl : i18
      %611 = comb.concat %c0_i14, %610 : i14, i18
      llhd.drv %iprdata, %611 after %0 : i32
      cf.br ^bb1
    ^bb28:  // pred: ^bb26
      %612 = comb.icmp ceq %568, %c14_i7 : i7
      cf.cond_br %612, ^bb29, ^bb30
    ^bb29:  // pred: ^bb28
      %613 = llhd.prb %pwm01load : i32
      llhd.drv %iprdata, %613 after %0 : i32
      cf.br ^bb1
    ^bb30:  // pred: ^bb28
      %614 = comb.icmp ceq %568, %c15_i7 : i7
      cf.cond_br %614, ^bb31, ^bb32
    ^bb31:  // pred: ^bb30
      %615 = llhd.prb %pwm23load : i32
      llhd.drv %iprdata, %615 after %0 : i32
      cf.br ^bb1
    ^bb32:  // pred: ^bb30
      %616 = comb.icmp ceq %568, %c16_i7 : i7
      cf.cond_br %616, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      %617 = llhd.prb %pwm45load : i32
      llhd.drv %iprdata, %617 after %0 : i32
      cf.br ^bb1
    ^bb34:  // pred: ^bb32
      %618 = comb.icmp ceq %568, %c17_i7 : i7
      cf.cond_br %618, ^bb35, ^bb36
    ^bb35:  // pred: ^bb34
      %619 = llhd.prb %pwm01count_32 : i32
      llhd.drv %iprdata, %619 after %0 : i32
      cf.br ^bb1
    ^bb36:  // pred: ^bb34
      %620 = comb.icmp ceq %568, %c18_i7 : i7
      cf.cond_br %620, ^bb37, ^bb38
    ^bb37:  // pred: ^bb36
      %621 = llhd.prb %pwm23count_34 : i32
      llhd.drv %iprdata, %621 after %0 : i32
      cf.br ^bb1
    ^bb38:  // pred: ^bb36
      %622 = comb.icmp ceq %568, %c19_i7 : i7
      cf.cond_br %622, ^bb39, ^bb40
    ^bb39:  // pred: ^bb38
      %623 = llhd.prb %pwm45count_36 : i32
      llhd.drv %iprdata, %623 after %0 : i32
      cf.br ^bb1
    ^bb40:  // pred: ^bb38
      %624 = comb.icmp ceq %568, %c20_i7 : i7
      cf.cond_br %624, ^bb41, ^bb42
    ^bb41:  // pred: ^bb40
      %625 = llhd.prb %pwm0cmp : i32
      llhd.drv %iprdata, %625 after %0 : i32
      cf.br ^bb1
    ^bb42:  // pred: ^bb40
      %626 = comb.icmp ceq %568, %c21_i7 : i7
      cf.cond_br %626, ^bb43, ^bb44
    ^bb43:  // pred: ^bb42
      %627 = llhd.prb %pwm1cmp : i32
      llhd.drv %iprdata, %627 after %0 : i32
      cf.br ^bb1
    ^bb44:  // pred: ^bb42
      %628 = comb.icmp ceq %568, %c22_i7 : i7
      cf.cond_br %628, ^bb45, ^bb46
    ^bb45:  // pred: ^bb44
      %629 = llhd.prb %pwm2cmp : i32
      llhd.drv %iprdata, %629 after %0 : i32
      cf.br ^bb1
    ^bb46:  // pred: ^bb44
      %630 = comb.icmp ceq %568, %c23_i7 : i7
      cf.cond_br %630, ^bb47, ^bb48
    ^bb47:  // pred: ^bb46
      %631 = llhd.prb %pwm3cmp : i32
      llhd.drv %iprdata, %631 after %0 : i32
      cf.br ^bb1
    ^bb48:  // pred: ^bb46
      %632 = comb.icmp ceq %568, %c24_i7 : i7
      cf.cond_br %632, ^bb49, ^bb50
    ^bb49:  // pred: ^bb48
      %633 = llhd.prb %pwm4cmp : i32
      llhd.drv %iprdata, %633 after %0 : i32
      cf.br ^bb1
    ^bb50:  // pred: ^bb48
      %634 = comb.icmp ceq %568, %c25_i7 : i7
      cf.cond_br %634, ^bb51, ^bb52
    ^bb51:  // pred: ^bb50
      %635 = llhd.prb %pwm5cmp : i32
      llhd.drv %iprdata, %635 after %0 : i32
      cf.br ^bb1
    ^bb52:  // pred: ^bb50
      %636 = comb.icmp ceq %568, %c26_i7 : i7
      cf.cond_br %636, ^bb53, ^bb54
    ^bb53:  // pred: ^bb52
      %637 = llhd.prb %pwm01db : i26
      %638 = comb.concat %c0_i6, %637 : i6, i26
      llhd.drv %iprdata, %638 after %0 : i32
      cf.br ^bb1
    ^bb54:  // pred: ^bb52
      %639 = comb.icmp ceq %568, %c27_i7 : i7
      cf.cond_br %639, ^bb55, ^bb56
    ^bb55:  // pred: ^bb54
      %640 = llhd.prb %pwm23db : i26
      %641 = comb.concat %c0_i6, %640 : i6, i26
      llhd.drv %iprdata, %641 after %0 : i32
      cf.br ^bb1
    ^bb56:  // pred: ^bb54
      %642 = comb.icmp ceq %568, %c28_i7 : i7
      cf.cond_br %642, ^bb57, ^bb58
    ^bb57:  // pred: ^bb56
      %643 = llhd.prb %pwm45db : i26
      %644 = comb.concat %c0_i6, %643 : i6, i26
      llhd.drv %iprdata, %644 after %0 : i32
      cf.br ^bb1
    ^bb58:  // pred: ^bb56
      %645 = comb.icmp ceq %568, %c29_i7 : i7
      cf.cond_br %645, ^bb59, ^bb60
    ^bb59:  // pred: ^bb58
      %646 = llhd.prb %capctl : i18
      %647 = comb.concat %c0_i14, %646 : i14, i18
      llhd.drv %iprdata, %647 after %0 : i32
      cf.br ^bb1
    ^bb60:  // pred: ^bb58
      %648 = comb.icmp ceq %568, %c30_i7 : i7
      cf.cond_br %648, ^bb61, ^bb62
    ^bb61:  // pred: ^bb60
      %649 = llhd.prb %capinten : i12
      %650 = comb.concat %c0_i20, %649 : i20, i12
      llhd.drv %iprdata, %650 after %0 : i32
      cf.br ^bb1
    ^bb62:  // pred: ^bb60
      %651 = comb.icmp ceq %568, %c31_i7 : i7
      cf.cond_br %651, ^bb63, ^bb64
    ^bb63:  // pred: ^bb62
      %652 = llhd.prb %capris_7 : i32
      llhd.drv %iprdata, %652 after %0 : i32
      cf.br ^bb1
    ^bb64:  // pred: ^bb62
      %653 = comb.icmp ceq %568, %c32_i7 : i7
      cf.cond_br %653, ^bb65, ^bb66
    ^bb65:  // pred: ^bb64
      %654 = llhd.prb %capic : i12
      %655 = comb.concat %c0_i20, %654 : i20, i12
      llhd.drv %iprdata, %655 after %0 : i32
      cf.br ^bb1
    ^bb66:  // pred: ^bb64
      %656 = comb.icmp ceq %568, %c33_i7 : i7
      cf.cond_br %656, ^bb67, ^bb68
    ^bb67:  // pred: ^bb66
      %657 = llhd.prb %capis_6 : i32
      llhd.drv %iprdata, %657 after %0 : i32
      cf.br ^bb1
    ^bb68:  // pred: ^bb66
      %658 = comb.icmp ceq %568, %c34_i7 : i7
      cf.cond_br %658, ^bb69, ^bb70
    ^bb69:  // pred: ^bb68
      %659 = llhd.prb %cap01t_0 : i32
      llhd.drv %iprdata, %659 after %0 : i32
      cf.br ^bb1
    ^bb70:  // pred: ^bb68
      %660 = comb.icmp ceq %568, %c35_i7 : i7
      cf.cond_br %660, ^bb71, ^bb72
    ^bb71:  // pred: ^bb70
      %661 = llhd.prb %cap23t_2 : i32
      llhd.drv %iprdata, %661 after %0 : i32
      cf.br ^bb1
    ^bb72:  // pred: ^bb70
      %662 = comb.icmp ceq %568, %c36_i7 : i7
      cf.cond_br %662, ^bb73, ^bb74
    ^bb73:  // pred: ^bb72
      %663 = llhd.prb %cap45t_4 : i32
      llhd.drv %iprdata, %663 after %0 : i32
      cf.br ^bb1
    ^bb74:  // pred: ^bb72
      %664 = comb.icmp ceq %568, %c37_i7 : i7
      cf.cond_br %664, ^bb75, ^bb76
    ^bb75:  // pred: ^bb74
      %665 = llhd.prb %cap01match : i32
      llhd.drv %iprdata, %665 after %0 : i32
      cf.br ^bb1
    ^bb76:  // pred: ^bb74
      %666 = comb.icmp ceq %568, %c38_i7 : i7
      cf.cond_br %666, ^bb77, ^bb78
    ^bb77:  // pred: ^bb76
      %667 = llhd.prb %cap23match : i32
      llhd.drv %iprdata, %667 after %0 : i32
      cf.br ^bb1
    ^bb78:  // pred: ^bb76
      %668 = comb.icmp ceq %568, %c39_i7 : i7
      cf.cond_br %668, ^bb79, ^bb80
    ^bb79:  // pred: ^bb78
      %669 = llhd.prb %cap45match : i32
      llhd.drv %iprdata, %669 after %0 : i32
      cf.br ^bb1
    ^bb80:  // pred: ^bb78
      %670 = comb.icmp ceq %568, %c40_i7 : i7
      cf.cond_br %670, ^bb81, ^bb82
    ^bb81:  // pred: ^bb80
      %671 = llhd.prb %timinten : i6
      %672 = comb.concat %c0_i26, %671 : i26, i6
      llhd.drv %iprdata, %672 after %0 : i32
      cf.br ^bb1
    ^bb82:  // pred: ^bb80
      %673 = comb.icmp ceq %568, %c41_i7 : i7
      cf.cond_br %673, ^bb83, ^bb84
    ^bb83:  // pred: ^bb82
      %674 = llhd.prb %timris_50 : i32
      llhd.drv %iprdata, %674 after %0 : i32
      cf.br ^bb1
    ^bb84:  // pred: ^bb82
      %675 = comb.icmp ceq %568, %c42_i7 : i7
      cf.cond_br %675, ^bb85, ^bb86
    ^bb85:  // pred: ^bb84
      %676 = llhd.prb %timic : i6
      %677 = comb.concat %c0_i26, %676 : i26, i6
      llhd.drv %iprdata, %677 after %0 : i32
      cf.br ^bb1
    ^bb86:  // pred: ^bb84
      %678 = comb.icmp ceq %568, %c43_i7 : i7
      cf.cond_br %678, ^bb87, ^bb88
    ^bb87:  // pred: ^bb86
      %679 = llhd.prb %timis_49 : i32
      llhd.drv %iprdata, %679 after %0 : i32
      cf.br ^bb1
    ^bb88:  // pred: ^bb86
      %680 = comb.icmp ceq %568, %c44_i7 : i7
      cf.cond_br %680, ^bb89, ^bb90
    ^bb89:  // pred: ^bb88
      %681 = llhd.prb %tim01load : i32
      llhd.drv %iprdata, %681 after %0 : i32
      cf.br ^bb1
    ^bb90:  // pred: ^bb88
      %682 = comb.icmp ceq %568, %c45_i7 : i7
      cf.cond_br %682, ^bb91, ^bb92
    ^bb91:  // pred: ^bb90
      %683 = llhd.prb %tim23load : i32
      llhd.drv %iprdata, %683 after %0 : i32
      cf.br ^bb1
    ^bb92:  // pred: ^bb90
      %684 = comb.icmp ceq %568, %c46_i7 : i7
      cf.cond_br %684, ^bb93, ^bb94
    ^bb93:  // pred: ^bb92
      %685 = llhd.prb %tim45load : i32
      llhd.drv %iprdata, %685 after %0 : i32
      cf.br ^bb1
    ^bb94:  // pred: ^bb92
      %686 = comb.icmp ceq %568, %c2_i7 : i7
      cf.cond_br %686, ^bb95, ^bb96
    ^bb95:  // pred: ^bb94
      %687 = llhd.prb %pwm01trig : i32
      llhd.drv %iprdata, %687 after %0 : i32
      cf.br ^bb1
    ^bb96:  // pred: ^bb94
      %688 = comb.icmp ceq %568, %c3_i7 : i7
      cf.cond_br %688, ^bb97, ^bb98
    ^bb97:  // pred: ^bb96
      %689 = llhd.prb %pwm23trig : i32
      llhd.drv %iprdata, %689 after %0 : i32
      cf.br ^bb1
    ^bb98:  // pred: ^bb96
      %690 = comb.icmp ceq %568, %c4_i7 : i7
      cf.cond_br %690, ^bb99, ^bb100
    ^bb99:  // pred: ^bb98
      %691 = llhd.prb %pwm45trig : i32
      llhd.drv %iprdata, %691 after %0 : i32
      cf.br ^bb1
    ^bb100:  // pred: ^bb98
      %692 = comb.icmp ceq %568, %c47_i7 : i7
      cf.cond_br %692, ^bb101, ^bb102
    ^bb101:  // pred: ^bb100
      %693 = llhd.prb %tim01count_43 : i32
      llhd.drv %iprdata, %693 after %0 : i32
      cf.br ^bb1
    ^bb102:  // pred: ^bb100
      %694 = comb.icmp ceq %568, %c48_i7 : i7
      cf.cond_br %694, ^bb103, ^bb104
    ^bb103:  // pred: ^bb102
      %695 = llhd.prb %tim23count_45 : i32
      llhd.drv %iprdata, %695 after %0 : i32
      cf.br ^bb1
    ^bb104:  // pred: ^bb102
      %696 = comb.icmp ceq %568, %c49_i7 : i7
      cf.cond_br %696, ^bb105, ^bb106
    ^bb105:  // pred: ^bb104
      %697 = llhd.prb %tim45count_47 : i32
      llhd.drv %iprdata, %697 after %0 : i32
      cf.br ^bb1
    ^bb106:  // pred: ^bb104
      %698 = comb.icmp ceq %568, %c50_i7 : i7
      cf.cond_br %698, ^bb107, ^bb108
    ^bb107:  // pred: ^bb106
      %699 = llhd.prb %cnt1val_9 : i32
      %700 = comb.extract %699 from 0 : (i32) -> i16
      %701 = llhd.prb %cnt0val_8 : i32
      %702 = comb.extract %701 from 0 : (i32) -> i16
      %703 = comb.concat %700, %702 : i16, i16
      llhd.drv %iprdata, %703 after %0 : i32
      cf.br ^bb1
    ^bb108:  // pred: ^bb106
      %704 = comb.icmp ceq %568, %c51_i7 : i7
      cf.cond_br %704, ^bb109, ^bb110
    ^bb109:  // pred: ^bb108
      %705 = llhd.prb %cnt3val_11 : i32
      %706 = comb.extract %705 from 0 : (i32) -> i16
      %707 = llhd.prb %cnt2val_10 : i32
      %708 = comb.extract %707 from 0 : (i32) -> i16
      %709 = comb.concat %706, %708 : i16, i16
      llhd.drv %iprdata, %709 after %0 : i32
      cf.br ^bb1
    ^bb110:  // pred: ^bb108
      %710 = comb.icmp ceq %568, %c52_i7 : i7
      cf.cond_br %710, ^bb111, ^bb112
    ^bb111:  // pred: ^bb110
      %711 = llhd.prb %cnt5val_13 : i32
      %712 = comb.extract %711 from 0 : (i32) -> i16
      %713 = llhd.prb %cnt4val_12 : i32
      %714 = comb.extract %713 from 0 : (i32) -> i16
      %715 = comb.concat %712, %714 : i16, i16
      llhd.drv %iprdata, %715 after %0 : i32
      cf.br ^bb1
    ^bb112:  // pred: ^bb110
      %716 = comb.icmp ceq %568, %c53_i7 : i7
      cf.cond_br %716, ^bb113, ^bb114
    ^bb113:  // pred: ^bb112
      %717 = llhd.prb %pwm01trig_h : i32
      llhd.drv %iprdata, %717 after %0 : i32
      cf.br ^bb1
    ^bb114:  // pred: ^bb112
      %718 = comb.icmp ceq %568, %c54_i7 : i7
      cf.cond_br %718, ^bb115, ^bb116
    ^bb115:  // pred: ^bb114
      %719 = llhd.prb %pwm23trig_h : i32
      llhd.drv %iprdata, %719 after %0 : i32
      cf.br ^bb1
    ^bb116:  // pred: ^bb114
      %720 = comb.icmp ceq %568, %c55_i7 : i7
      cf.cond_br %720, ^bb117, ^bb118
    ^bb117:  // pred: ^bb116
      %721 = llhd.prb %pwm45trig_h : i32
      llhd.drv %iprdata, %721 after %0 : i32
      cf.br ^bb1
    ^bb118:  // pred: ^bb116
      %722 = comb.icmp ceq %568, %c56_i7 : i7
      cf.cond_br %722, ^bb119, ^bb120
    ^bb119:  // pred: ^bb118
      %723 = llhd.prb %pwm0cmp_h : i32
      llhd.drv %iprdata, %723 after %0 : i32
      cf.br ^bb1
    ^bb120:  // pred: ^bb118
      %724 = comb.icmp ceq %568, %c57_i7 : i7
      cf.cond_br %724, ^bb121, ^bb122
    ^bb121:  // pred: ^bb120
      %725 = llhd.prb %pwm1cmp_h : i32
      llhd.drv %iprdata, %725 after %0 : i32
      cf.br ^bb1
    ^bb122:  // pred: ^bb120
      %726 = comb.icmp ceq %568, %c58_i7 : i7
      cf.cond_br %726, ^bb123, ^bb124
    ^bb123:  // pred: ^bb122
      %727 = llhd.prb %pwm2cmp_h : i32
      llhd.drv %iprdata, %727 after %0 : i32
      cf.br ^bb1
    ^bb124:  // pred: ^bb122
      %728 = comb.icmp ceq %568, %c59_i7 : i7
      cf.cond_br %728, ^bb125, ^bb126
    ^bb125:  // pred: ^bb124
      %729 = llhd.prb %pwm3cmp_h : i32
      llhd.drv %iprdata, %729 after %0 : i32
      cf.br ^bb1
    ^bb126:  // pred: ^bb124
      %730 = comb.icmp ceq %568, %c60_i7 : i7
      cf.cond_br %730, ^bb127, ^bb128
    ^bb127:  // pred: ^bb126
      %731 = llhd.prb %pwm4cmp_h : i32
      llhd.drv %iprdata, %731 after %0 : i32
      cf.br ^bb1
    ^bb128:  // pred: ^bb126
      %732 = comb.icmp ceq %568, %c61_i7 : i7
      cf.cond_br %732, ^bb129, ^bb130
    ^bb129:  // pred: ^bb128
      %733 = llhd.prb %pwm5cmp_h : i32
      llhd.drv %iprdata, %733 after %0 : i32
      cf.br ^bb1
    ^bb130:  // pred: ^bb128
      %734 = comb.icmp ceq %568, %c62_i7 : i7
      cf.cond_br %734, ^bb131, ^bb132
    ^bb131:  // pred: ^bb130
      %735 = llhd.prb %tim01load_h : i32
      llhd.drv %iprdata, %735 after %0 : i32
      cf.br ^bb1
    ^bb132:  // pred: ^bb130
      %736 = comb.icmp ceq %568, %c63_i7 : i7
      cf.cond_br %736, ^bb133, ^bb134
    ^bb133:  // pred: ^bb132
      %737 = llhd.prb %tim23load_h : i32
      llhd.drv %iprdata, %737 after %0 : i32
      cf.br ^bb1
    ^bb134:  // pred: ^bb132
      %738 = comb.icmp ceq %568, %c-64_i7 : i7
      cf.cond_br %738, ^bb135, ^bb136
    ^bb135:  // pred: ^bb134
      %739 = llhd.prb %tim45load_h : i32
      llhd.drv %iprdata, %739 after %0 : i32
      cf.br ^bb1
    ^bb136:  // pred: ^bb134
      %740 = comb.icmp ceq %568, %c-63_i7 : i7
      cf.cond_br %740, ^bb137, ^bb138
    ^bb137:  // pred: ^bb136
      %741 = llhd.prb %pwm01load_h : i32
      llhd.drv %iprdata, %741 after %0 : i32
      cf.br ^bb1
    ^bb138:  // pred: ^bb136
      %742 = comb.icmp ceq %568, %c-62_i7 : i7
      cf.cond_br %742, ^bb139, ^bb140
    ^bb139:  // pred: ^bb138
      %743 = llhd.prb %pwm23load_h : i32
      llhd.drv %iprdata, %743 after %0 : i32
      cf.br ^bb1
    ^bb140:  // pred: ^bb138
      %744 = comb.icmp ceq %568, %c-61_i7 : i7
      cf.cond_br %744, ^bb141, ^bb142
    ^bb141:  // pred: ^bb140
      %745 = llhd.prb %pwm45load_h : i32
      llhd.drv %iprdata, %745 after %0 : i32
      cf.br ^bb1
    ^bb142:  // pred: ^bb140
      %746 = comb.icmp ceq %568, %c-60_i7 : i7
      cf.cond_br %746, ^bb143, ^bb144
    ^bb143:  // pred: ^bb142
      %747 = llhd.prb %cap01match_h : i32
      llhd.drv %iprdata, %747 after %0 : i32
      cf.br ^bb1
    ^bb144:  // pred: ^bb142
      %748 = comb.icmp ceq %568, %c-59_i7 : i7
      cf.cond_br %748, ^bb145, ^bb146
    ^bb145:  // pred: ^bb144
      %749 = llhd.prb %cap23match_h : i32
      llhd.drv %iprdata, %749 after %0 : i32
      cf.br ^bb1
    ^bb146:  // pred: ^bb144
      %750 = comb.icmp ceq %568, %c-58_i7 : i7
      cf.cond_br %750, ^bb147, ^bb148
    ^bb147:  // pred: ^bb146
      %751 = llhd.prb %cap45match_h : i32
      llhd.drv %iprdata, %751 after %0 : i32
      cf.br ^bb1
    ^bb148:  // pred: ^bb146
      %752 = comb.icmp ceq %568, %c-57_i7 : i7
      cf.cond_br %752, ^bb149, ^bb150
    ^bb149:  // pred: ^bb148
      %753 = llhd.prb %pwm01count_h_33 : i32
      llhd.drv %iprdata, %753 after %0 : i32
      cf.br ^bb1
    ^bb150:  // pred: ^bb148
      %754 = comb.icmp ceq %568, %c-56_i7 : i7
      cf.cond_br %754, ^bb151, ^bb152
    ^bb151:  // pred: ^bb150
      %755 = llhd.prb %pwm23count_h_35 : i32
      llhd.drv %iprdata, %755 after %0 : i32
      cf.br ^bb1
    ^bb152:  // pred: ^bb150
      %756 = comb.icmp ceq %568, %c-55_i7 : i7
      cf.cond_br %756, ^bb153, ^bb154
    ^bb153:  // pred: ^bb152
      %757 = llhd.prb %pwm45count_h_37 : i32
      llhd.drv %iprdata, %757 after %0 : i32
      cf.br ^bb1
    ^bb154:  // pred: ^bb152
      %758 = comb.icmp ceq %568, %c-54_i7 : i7
      cf.cond_br %758, ^bb155, ^bb156
    ^bb155:  // pred: ^bb154
      %759 = llhd.prb %cap01t_h_1 : i32
      llhd.drv %iprdata, %759 after %0 : i32
      cf.br ^bb1
    ^bb156:  // pred: ^bb154
      %760 = comb.icmp ceq %568, %c-53_i7 : i7
      cf.cond_br %760, ^bb157, ^bb158
    ^bb157:  // pred: ^bb156
      %761 = llhd.prb %cap23t_h_3 : i32
      llhd.drv %iprdata, %761 after %0 : i32
      cf.br ^bb1
    ^bb158:  // pred: ^bb156
      %762 = comb.icmp ceq %568, %c-52_i7 : i7
      cf.cond_br %762, ^bb159, ^bb160
    ^bb159:  // pred: ^bb158
      %763 = llhd.prb %cap45t_h_5 : i32
      llhd.drv %iprdata, %763 after %0 : i32
      cf.br ^bb1
    ^bb160:  // pred: ^bb158
      %764 = comb.icmp ceq %568, %c-51_i7 : i7
      cf.cond_br %764, ^bb161, ^bb162
    ^bb161:  // pred: ^bb160
      %765 = llhd.prb %tim01count_h_44 : i32
      llhd.drv %iprdata, %765 after %0 : i32
      cf.br ^bb1
    ^bb162:  // pred: ^bb160
      %766 = comb.icmp ceq %568, %c-50_i7 : i7
      cf.cond_br %766, ^bb163, ^bb164
    ^bb163:  // pred: ^bb162
      %767 = llhd.prb %tim23count_h_46 : i32
      llhd.drv %iprdata, %767 after %0 : i32
      cf.br ^bb1
    ^bb164:  // pred: ^bb162
      %768 = comb.icmp ceq %568, %c-49_i7 : i7
      cf.cond_br %768, ^bb165, ^bb166
    ^bb165:  // pred: ^bb164
      %769 = llhd.prb %tim45count_h_48 : i32
      llhd.drv %iprdata, %769 after %0 : i32
      cf.br ^bb1
    ^bb166:  // pred: ^bb164
      %770 = comb.icmp ceq %568, %c-48_i7 : i7
      cf.cond_br %770, ^bb167, ^bb168
    ^bb167:  // pred: ^bb166
      %771 = llhd.prb %cnt1val_9 : i32
      %772 = comb.extract %771 from 16 : (i32) -> i16
      %773 = llhd.prb %cnt0val_8 : i32
      %774 = comb.extract %773 from 16 : (i32) -> i16
      %775 = comb.concat %772, %774 : i16, i16
      llhd.drv %iprdata, %775 after %0 : i32
      cf.br ^bb1
    ^bb168:  // pred: ^bb166
      %776 = comb.icmp ceq %568, %c-47_i7 : i7
      cf.cond_br %776, ^bb169, ^bb170
    ^bb169:  // pred: ^bb168
      %777 = llhd.prb %cnt3val_11 : i32
      %778 = comb.extract %777 from 16 : (i32) -> i16
      %779 = llhd.prb %cnt2val_10 : i32
      %780 = comb.extract %779 from 16 : (i32) -> i16
      %781 = comb.concat %778, %780 : i16, i16
      llhd.drv %iprdata, %781 after %0 : i32
      cf.br ^bb1
    ^bb170:  // pred: ^bb168
      %782 = comb.icmp ceq %568, %c-46_i7 : i7
      cf.cond_br %782, ^bb171, ^bb172
    ^bb171:  // pred: ^bb170
      %783 = llhd.prb %cnt5val_13 : i32
      %784 = comb.extract %783 from 16 : (i32) -> i16
      %785 = llhd.prb %cnt4val_12 : i32
      %786 = comb.extract %785 from 16 : (i32) -> i16
      %787 = comb.concat %784, %786 : i16, i16
      llhd.drv %iprdata, %787 after %0 : i32
      cf.br ^bb1
    ^bb172:  // pred: ^bb170
      llhd.drv %iprdata, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb173:  // pred: ^bb5
      llhd.drv %iprdata, %c0_i32 after %0 : i32
      cf.br ^bb1
    }
    %490 = llhd.prb %iprdata : i32
    llhd.drv %prdata, %490 after %1 : i32
    llhd.drv %cap01t_0, %cap01t after %1 : i32
    llhd.drv %cap01t_h_1, %cap01t_h after %1 : i32
    %491 = llhd.prb %cap0eventa : i2
    %492 = llhd.prb %cap0match : i32
    %493 = llhd.prb %cap1eventa : i2
    %494 = llhd.prb %cap1match : i32
    llhd.drv %cap23t_2, %cap23t after %1 : i32
    llhd.drv %cap23t_h_3, %cap23t_h after %1 : i32
    %495 = llhd.prb %cap2eventa : i2
    %496 = llhd.prb %cap2match : i32
    %497 = llhd.prb %cap3eventa : i2
    %498 = llhd.prb %cap3match : i32
    llhd.drv %cap45t_4, %cap45t after %1 : i32
    llhd.drv %cap45t_h_5, %cap45t_h after %1 : i32
    %499 = llhd.prb %cap4eventa : i2
    %500 = llhd.prb %cap4match : i32
    %501 = llhd.prb %cap5eventa : i2
    %502 = llhd.prb %cap5match : i32
    llhd.drv %capis_6, %capis after %1 : i32
    llhd.drv %capris_7, %capris after %1 : i32
    llhd.drv %cnt0val_8, %cnt0val after %1 : i32
    llhd.drv %cnt1val_9, %cnt1val after %1 : i32
    llhd.drv %cnt2val_10, %cnt2val after %1 : i32
    llhd.drv %cnt3val_11, %cnt3val after %1 : i32
    llhd.drv %cnt4val_12, %cnt4val after %1 : i32
    llhd.drv %cnt5val_13, %cnt5val after %1 : i32
    %503 = llhd.prb %cntdiv : i3
    %504 = llhd.prb %compa_val_0 : i32
    %505 = llhd.prb %compa_val_1 : i32
    %506 = llhd.prb %compa_val_2 : i32
    %507 = llhd.prb %compa_val_3 : i32
    %508 = llhd.prb %compa_val_4 : i32
    %509 = llhd.prb %compa_val_5 : i32
    %510 = llhd.prb %compb_val_0 : i32
    %511 = llhd.prb %compb_val_1 : i32
    %512 = llhd.prb %compb_val_2 : i32
    %513 = llhd.prb %compb_val_3 : i32
    %514 = llhd.prb %compb_val_4 : i32
    %515 = llhd.prb %compb_val_5 : i32
    %516 = llhd.prb %delay0 : i12
    %517 = llhd.prb %delay1 : i12
    %518 = llhd.prb %delay2 : i12
    %519 = llhd.prb %delay3 : i12
    %520 = llhd.prb %delay4 : i12
    %521 = llhd.prb %delay5 : i12
    llhd.drv %etb_pwm_trig_tim0_off_14, %etb_pwm_trig_tim0_off after %1 : i1
    llhd.drv %etb_pwm_trig_tim0_on_15, %etb_pwm_trig_tim0_on after %1 : i1
    llhd.drv %etb_pwm_trig_tim1_off_16, %etb_pwm_trig_tim1_off after %1 : i1
    llhd.drv %etb_pwm_trig_tim1_on_17, %etb_pwm_trig_tim1_on after %1 : i1
    llhd.drv %etb_pwm_trig_tim2_off_18, %etb_pwm_trig_tim2_off after %1 : i1
    llhd.drv %etb_pwm_trig_tim2_on_19, %etb_pwm_trig_tim2_on after %1 : i1
    llhd.drv %etb_pwm_trig_tim3_off_20, %etb_pwm_trig_tim3_off after %1 : i1
    llhd.drv %etb_pwm_trig_tim3_on_21, %etb_pwm_trig_tim3_on after %1 : i1
    llhd.drv %etb_pwm_trig_tim4_off_22, %etb_pwm_trig_tim4_off after %1 : i1
    llhd.drv %etb_pwm_trig_tim4_on_23, %etb_pwm_trig_tim4_on after %1 : i1
    llhd.drv %etb_pwm_trig_tim5_off_24, %etb_pwm_trig_tim5_off after %1 : i1
    llhd.drv %etb_pwm_trig_tim5_on_25, %etb_pwm_trig_tim5_on after %1 : i1
    llhd.drv %paddr_26, %paddr after %1 : i32
    llhd.drv %pclk_27, %pclk after %1 : i1
    llhd.drv %penable_28, %penable after %1 : i1
    %522 = llhd.prb %prdata : i32
    llhd.drv %presetn_29, %presetn after %1 : i1
    llhd.drv %psel_30, %psel after %1 : i1
    llhd.drv %pwdata_31, %pwdata after %1 : i32
    llhd.drv %pwm01count_32, %pwm01count after %1 : i32
    llhd.drv %pwm01count_h_33, %pwm01count_h after %1 : i32
    %523 = llhd.prb %pwm0load : i32
    %524 = llhd.prb %pwm0trig_val : i32
    %525 = llhd.prb %pwm1load : i32
    %526 = llhd.prb %pwm1trig_val : i32
    llhd.drv %pwm23count_34, %pwm23count after %1 : i32
    llhd.drv %pwm23count_h_35, %pwm23count_h after %1 : i32
    %527 = llhd.prb %pwm2load : i32
    %528 = llhd.prb %pwm2trig_val : i32
    %529 = llhd.prb %pwm3load : i32
    %530 = llhd.prb %pwm3trig_val : i32
    llhd.drv %pwm45count_36, %pwm45count after %1 : i32
    llhd.drv %pwm45count_h_37, %pwm45count_h after %1 : i32
    %531 = llhd.prb %pwm4load : i32
    %532 = llhd.prb %pwm4trig_val : i32
    %533 = llhd.prb %pwm5load : i32
    %534 = llhd.prb %pwm5trig_val : i32
    llhd.drv %pwmis1_38, %pwmis1 after %1 : i32
    llhd.drv %pwmis2_39, %pwmis2 after %1 : i32
    llhd.drv %pwmris1_40, %pwmris1 after %1 : i32
    llhd.drv %pwmris2_41, %pwmris2 after %1 : i32
    llhd.drv %pwrite_42, %pwrite after %1 : i1
    %535 = llhd.prb %sync0mode : i2
    %536 = llhd.prb %sync1mode : i2
    %537 = llhd.prb %sync2mode : i2
    %538 = llhd.prb %sync3mode : i2
    %539 = llhd.prb %sync4mode : i2
    %540 = llhd.prb %sync5mode : i2
    llhd.drv %tim01count_43, %tim01count after %1 : i32
    llhd.drv %tim01count_h_44, %tim01count_h after %1 : i32
    %541 = llhd.prb %tim0load : i32
    %542 = llhd.prb %tim1load : i32
    llhd.drv %tim23count_45, %tim23count after %1 : i32
    llhd.drv %tim23count_h_46, %tim23count_h after %1 : i32
    %543 = llhd.prb %tim2load : i32
    %544 = llhd.prb %tim3load : i32
    llhd.drv %tim45count_47, %tim45count after %1 : i32
    llhd.drv %tim45count_h_48, %tim45count_h after %1 : i32
    %545 = llhd.prb %tim4load : i32
    %546 = llhd.prb %tim5load : i32
    llhd.drv %timis_49, %timis after %1 : i32
    llhd.drv %timris_50, %timris after %1 : i32
    hw.output %402, %388, %101, %491, %492, %374, %408, %394, %403, %389, %102, %493, %494, %375, %409, %395, %404, %390, %103, %495, %496, %376, %410, %396, %405, %391, %104, %497, %498, %377, %411, %397, %406, %392, %105, %499, %500, %378, %412, %398, %407, %393, %106, %501, %502, %379, %413, %399, %503, %114, %504, %505, %506, %507, %508, %509, %510, %511, %512, %513, %514, %515, %358, %359, %361, %362, %364, %365, %516, %517, %518, %519, %520, %521, %178, %176, %179, %177, %175, %174, %184, %182, %185, %183, %181, %180, %190, %188, %191, %189, %187, %186, %197, %195, %198, %196, %194, %193, %203, %201, %204, %202, %200, %199, %209, %207, %210, %208, %206, %205, %173, %217, %215, %218, %216, %214, %213, %223, %221, %224, %222, %220, %219, %229, %227, %230, %228, %226, %225, %236, %234, %237, %235, %233, %232, %242, %240, %243, %241, %239, %238, %248, %246, %249, %247, %245, %244, %212, %522, %89, %117, %523, %252, %524, %99, %127, %100, %128, %90, %118, %525, %253, %526, %91, %119, %527, %254, %528, %92, %120, %529, %255, %530, %93, %121, %531, %256, %532, %94, %122, %533, %257, %534, %95, %123, %96, %124, %97, %125, %98, %126, %535, %536, %537, %538, %539, %540, %107, %454, %446, %541, %108, %455, %447, %542, %109, %456, %448, %543, %110, %457, %449, %544, %111, %458, %450, %545, %112, %459, %451, %546, %131, %130, %133, %132, %135, %134, %137, %136, %139, %138, %141, %140, %129 : i1, i1, i1, i2, i32, i1, i1, i1, i1, i1, i1, i2, i32, i1, i1, i1, i1, i1, i1, i2, i32, i1, i1, i1, i1, i1, i1, i2, i32, i1, i1, i1, i1, i1, i1, i2, i32, i1, i1, i1, i1, i1, i1, i2, i32, i1, i1, i1, i3, i1, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1, i1, i1, i1, i1, i12, i12, i12, i12, i12, i12, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i32, i1, i1, i32, i1, i32, i1, i1, i1, i1, i1, i1, i32, i1, i32, i1, i1, i32, i1, i32, i1, i1, i32, i1, i32, i1, i1, i32, i1, i32, i1, i1, i32, i1, i32, i1, i1, i1, i1, i1, i1, i1, i1, i2, i2, i2, i2, i2, i2, i1, i1, i1, i32, i1, i1, i1, i32, i1, i1, i1, i32, i1, i1, i1, i32, i1, i1, i1, i32, i1, i1, i1, i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1
  }
  hw.module private @pwm_ctrl(out cap01t : i32, out cap01t_h : i32, in %cap0cntic : i1, in %cap0cntie : i1, in %cap0en : i1, in %cap0eventa : i2, in %cap0match : i32, in %cap0mode : i1, in %cap0timic : i1, in %cap0timie : i1, in %cap1cntic : i1, in %cap1cntie : i1, in %cap1en : i1, in %cap1eventa : i2, in %cap1match : i32, in %cap1mode : i1, in %cap1timic : i1, in %cap1timie : i1, out cap23t : i32, out cap23t_h : i32, in %cap2cntic : i1, in %cap2cntie : i1, in %cap2en : i1, in %cap2eventa : i2, in %cap2match : i32, in %cap2mode : i1, in %cap2timic : i1, in %cap2timie : i1, in %cap3cntic : i1, in %cap3cntie : i1, in %cap3en : i1, in %cap3eventa : i2, in %cap3match : i32, in %cap3mode : i1, in %cap3timic : i1, in %cap3timie : i1, out cap45t : i32, out cap45t_h : i32, in %cap4cntic : i1, in %cap4cntie : i1, in %cap4en : i1, in %cap4eventa : i2, in %cap4match : i32, in %cap4mode : i1, in %cap4timic : i1, in %cap4timie : i1, in %cap5cntic : i1, in %cap5cntie : i1, in %cap5en : i1, in %cap5eventa : i2, in %cap5match : i32, in %cap5mode : i1, in %cap5timic : i1, in %cap5timie : i1, out capis : i32, out capris : i32, out cnt0val : i32, out cnt1val : i32, out cnt2val : i32, out cnt3val : i32, out cnt4val : i32, out cnt5val : i32, in %cntdiv : i3, in %cntdiven : i1, in %compa_val_0 : i32, in %compa_val_1 : i32, in %compa_val_2 : i32, in %compa_val_3 : i32, in %compa_val_4 : i32, in %compa_val_5 : i32, in %compb_val_0 : i32, in %compb_val_1 : i32, in %compb_val_2 : i32, in %compb_val_3 : i32, in %compb_val_4 : i32, in %compb_val_5 : i32, in %db0en : i1, in %db1en : i1, in %db2en : i1, in %db3en : i1, in %db4en : i1, in %db5en : i1, in %delay0 : i12, in %delay1 : i12, in %delay2 : i12, in %delay3 : i12, in %delay4 : i12, in %delay5 : i12, in %fault : i1, in %i_capture_0 : i1, in %i_capture_10 : i1, in %i_capture_2 : i1, in %i_capture_4 : i1, in %i_capture_6 : i1, in %i_capture_8 : i1, in %int0encmpad : i1, in %int0encmpau : i1, in %int0encmpbd : i1, in %int0encmpbu : i1, in %int0encntload : i1, in %int0encntzero : i1, in %int1encmpad : i1, in %int1encmpau : i1, in %int1encmpbd : i1, in %int1encmpbu : i1, in %int1encntload : i1, in %int1encntzero : i1, in %int2encmpad : i1, in %int2encmpau : i1, in %int2encmpbd : i1, in %int2encmpbu : i1, in %int2encntload : i1, in %int2encntzero : i1, in %int3encmpad : i1, in %int3encmpau : i1, in %int3encmpbd : i1, in %int3encmpbu : i1, in %int3encntload : i1, in %int3encntzero : i1, in %int4encmpad : i1, in %int4encmpau : i1, in %int4encmpbd : i1, in %int4encmpbu : i1, in %int4encntload : i1, in %int4encntzero : i1, in %int5encmpad : i1, in %int5encmpau : i1, in %int5encmpbd : i1, in %int5encmpbu : i1, in %int5encntload : i1, in %int5encntzero : i1, in %intenfault : i1, in %intic0cmpad : i1, in %intic0cmpau : i1, in %intic0cmpbd : i1, in %intic0cmpbu : i1, in %intic0cntload : i1, in %intic0cntzero : i1, in %intic1cmpad : i1, in %intic1cmpau : i1, in %intic1cmpbd : i1, in %intic1cmpbu : i1, in %intic1cntload : i1, in %intic1cntzero : i1, in %intic2cmpad : i1, in %intic2cmpau : i1, in %intic2cmpbd : i1, in %intic2cmpbu : i1, in %intic2cntload : i1, in %intic2cntzero : i1, in %intic3cmpad : i1, in %intic3cmpau : i1, in %intic3cmpbd : i1, in %intic3cmpbu : i1, in %intic3cntload : i1, in %intic3cntzero : i1, in %intic4cmpad : i1, in %intic4cmpau : i1, in %intic4cmpbd : i1, in %intic4cmpbu : i1, in %intic4cntload : i1, in %intic4cntzero : i1, in %intic5cmpad : i1, in %intic5cmpau : i1, in %intic5cmpbd : i1, in %intic5cmpbu : i1, in %intic5cntload : i1, in %intic5cntzero : i1, in %inticfault : i1, in %pclk : i1, in %presetn : i1, out pwm01count : i32, out pwm01count_h : i32, in %pwm0en : i1, in %pwm0inv : i1, in %pwm0load : i32, in %pwm0mode : i1, in %pwm0trig_val : i32, in %pwm10en : i1, in %pwm10inv : i1, in %pwm11en : i1, in %pwm11inv : i1, in %pwm1en : i1, in %pwm1inv : i1, in %pwm1load : i32, in %pwm1mode : i1, in %pwm1trig_val : i32, out pwm23count : i32, out pwm23count_h : i32, in %pwm2en : i1, in %pwm2inv : i1, in %pwm2load : i32, in %pwm2mode : i1, in %pwm2trig_val : i32, in %pwm3en : i1, in %pwm3inv : i1, in %pwm3load : i32, in %pwm3mode : i1, in %pwm3trig_val : i32, out pwm45count : i32, out pwm45count_h : i32, in %pwm4en : i1, in %pwm4inv : i1, in %pwm4load : i32, in %pwm4mode : i1, in %pwm4trig_val : i32, in %pwm5en : i1, in %pwm5inv : i1, in %pwm5load : i32, in %pwm5mode : i1, in %pwm5trig_val : i32, in %pwm6en : i1, in %pwm6inv : i1, in %pwm7en : i1, in %pwm7inv : i1, in %pwm8en : i1, in %pwm8inv : i1, in %pwm9en : i1, in %pwm9inv : i1, out pwm_0_oe : i1, out pwm_0_out : i1, out pwm_10_oe : i1, out pwm_10_out : i1, out pwm_11_oe : i1, out pwm_11_out : i1, out pwm_1_oe : i1, out pwm_1_out : i1, out pwm_2_oe : i1, out pwm_2_out : i1, out pwm_3_oe : i1, out pwm_3_out : i1, out pwm_4_oe : i1, out pwm_4_out : i1, out pwm_5_oe : i1, out pwm_5_out : i1, out pwm_6_oe : i1, out pwm_6_out : i1, out pwm_7_oe : i1, out pwm_7_out : i1, out pwm_8_oe : i1, out pwm_8_out : i1, out pwm_9_oe : i1, out pwm_9_out : i1, out pwm_idle : i1, out pwm_tim0_etb_trig : i1, out pwm_tim1_etb_trig : i1, out pwm_tim2_etb_trig : i1, out pwm_tim3_etb_trig : i1, out pwm_tim4_etb_trig : i1, out pwm_tim5_etb_trig : i1, out pwm_xx_trig : i1, out pwmint : i1, out pwmis1 : i32, out pwmis2 : i32, out pwmris1 : i32, out pwmris2 : i32, in %sync0mode : i2, in %sync1mode : i2, in %sync2mode : i2, in %sync3mode : i2, in %sync4mode : i2, in %sync5mode : i2, in %test_mode : i1, out tim01count : i32, out tim01count_h : i32, in %tim0en : i1, in %tim0ic : i1, in %tim0ie : i1, in %tim0load : i32, in %tim1en : i1, in %tim1ic : i1, in %tim1ie : i1, in %tim1load : i32, out tim23count : i32, out tim23count_h : i32, in %tim2en : i1, in %tim2ic : i1, in %tim2ie : i1, in %tim2load : i32, in %tim3en : i1, in %tim3ic : i1, in %tim3ie : i1, in %tim3load : i32, out tim45count : i32, out tim45count_h : i32, in %tim4en : i1, in %tim4ic : i1, in %tim4ie : i1, in %tim4load : i32, in %tim5en : i1, in %tim5ic : i1, in %tim5ie : i1, in %tim5load : i32, out timis : i32, out timris : i32, in %tr0end : i1, in %tr0enu : i1, in %tr1end : i1, in %tr1enu : i1, in %tr2end : i1, in %tr2enu : i1, in %tr3end : i1, in %tr3enu : i1, in %tr4end : i1, in %tr4enu : i1, in %tr5end : i1, in %tr5enu : i1, in %triginv : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c0_i26 = hw.constant 0 : i26
    %c0_i10 = hw.constant 0 : i10
    %c0_i7 = hw.constant 0 : i7
    %c0_i2 = hw.constant 0 : i2
    %c0_i20 = hw.constant 0 : i20
    %true = hw.constant true
    %false = hw.constant false
    %c-1_i7 = hw.constant -1 : i7
    %c-2_i3 = hw.constant -2 : i3
    %c63_i7 = hw.constant 63 : i7
    %c-3_i3 = hw.constant -3 : i3
    %c31_i7 = hw.constant 31 : i7
    %c-4_i3 = hw.constant -4 : i3
    %c15_i7 = hw.constant 15 : i7
    %c3_i3 = hw.constant 3 : i3
    %c7_i7 = hw.constant 7 : i7
    %c2_i3 = hw.constant 2 : i3
    %c3_i7 = hw.constant 3 : i7
    %c1_i3 = hw.constant 1 : i3
    %c1_i7 = hw.constant 1 : i7
    %c0_i3 = hw.constant 0 : i3
    %cap0en_d = llhd.sig %false : i1
    %cap1en_d = llhd.sig %false : i1
    %cap2en_d = llhd.sig %false : i1
    %cap3en_d = llhd.sig %false : i1
    %cap4en_d = llhd.sig %false : i1
    %cap5en_d = llhd.sig %false : i1
    %clkcnt = llhd.sig %c0_i7 : i7
    %clkdiv_en = llhd.sig %false : i1
    %clkspec = llhd.sig %c0_i7 : i7
    %int_fault = llhd.sig %false : i1
    %pwm0en_d = llhd.sig %false : i1
    %pwm10en_d = llhd.sig %false : i1
    %pwm11en_d = llhd.sig %false : i1
    %pwm1en_d = llhd.sig %false : i1
    %pwm2en_d = llhd.sig %false : i1
    %pwm3en_d = llhd.sig %false : i1
    %pwm4en_d = llhd.sig %false : i1
    %pwm5en_d = llhd.sig %false : i1
    %pwm6en_d = llhd.sig %false : i1
    %pwm7en_d = llhd.sig %false : i1
    %pwm8en_d = llhd.sig %false : i1
    %pwm9en_d = llhd.sig %false : i1
    %tim0en_d = llhd.sig %false : i1
    %tim1en_d = llhd.sig %false : i1
    %tim2en_d = llhd.sig %false : i1
    %tim3en_d = llhd.sig %false : i1
    %tim4en_d = llhd.sig %false : i1
    %tim5en_d = llhd.sig %false : i1
    %cap01t = llhd.sig %c0_i32 : i32
    %cap01t_h = llhd.sig %c0_i32 : i32
    %cap0en_0 = llhd.sig name "cap0en" %false : i1
    %cap1en_1 = llhd.sig name "cap1en" %false : i1
    %cap23t = llhd.sig %c0_i32 : i32
    %cap23t_h = llhd.sig %c0_i32 : i32
    %cap2en_2 = llhd.sig name "cap2en" %false : i1
    %cap3en_3 = llhd.sig name "cap3en" %false : i1
    %cap45t = llhd.sig %c0_i32 : i32
    %cap45t_h = llhd.sig %c0_i32 : i32
    %cap4en_4 = llhd.sig name "cap4en" %false : i1
    %cap5en_5 = llhd.sig name "cap5en" %false : i1
    %capis = llhd.sig %c0_i32 : i32
    %capris = llhd.sig %c0_i32 : i32
    %cnt0val = llhd.sig %c0_i32 : i32
    %cnt1val = llhd.sig %c0_i32 : i32
    %cnt2val = llhd.sig %c0_i32 : i32
    %cnt3val = llhd.sig %c0_i32 : i32
    %cnt4val = llhd.sig %c0_i32 : i32
    %cnt5val = llhd.sig %c0_i32 : i32
    %cntdiv_6 = llhd.sig name "cntdiv" %c0_i3 : i3
    %2 = llhd.prb %cntdiv_6 : i3
    %ctrl_clk = llhd.sig %false : i1
    %3 = llhd.prb %ctrl_clk : i1
    %fault_7 = llhd.sig name "fault" %false : i1
    %intenfault_8 = llhd.sig name "intenfault" %false : i1
    %inticfault_9 = llhd.sig name "inticfault" %false : i1
    %pclk_10 = llhd.sig name "pclk" %false : i1
    %4 = llhd.prb %pclk_10 : i1
    %presetn_11 = llhd.sig name "presetn" %false : i1
    %5 = llhd.prb %presetn_11 : i1
    %pwm01count = llhd.sig %c0_i32 : i32
    %pwm01count_h = llhd.sig %c0_i32 : i32
    %pwm0en_12 = llhd.sig name "pwm0en" %false : i1
    %pwm10en_13 = llhd.sig name "pwm10en" %false : i1
    %pwm11en_14 = llhd.sig name "pwm11en" %false : i1
    %pwm1en_15 = llhd.sig name "pwm1en" %false : i1
    %pwm23count = llhd.sig %c0_i32 : i32
    %pwm23count_h = llhd.sig %c0_i32 : i32
    %pwm2en_16 = llhd.sig name "pwm2en" %false : i1
    %pwm3en_17 = llhd.sig name "pwm3en" %false : i1
    %pwm45count = llhd.sig %c0_i32 : i32
    %pwm45count_h = llhd.sig %c0_i32 : i32
    %pwm4en_18 = llhd.sig name "pwm4en" %false : i1
    %pwm5en_19 = llhd.sig name "pwm5en" %false : i1
    %pwm6en_20 = llhd.sig name "pwm6en" %false : i1
    %pwm7en_21 = llhd.sig name "pwm7en" %false : i1
    %pwm8en_22 = llhd.sig name "pwm8en" %false : i1
    %pwm9en_23 = llhd.sig name "pwm9en" %false : i1
    %pwm_xx_trig_pre = llhd.sig %false : i1
    %pwmis1 = llhd.sig %c0_i32 : i32
    %pwmis2 = llhd.sig %c0_i32 : i32
    %pwmris1 = llhd.sig %c0_i32 : i32
    %pwmris2 = llhd.sig %c0_i32 : i32
    %tim01count = llhd.sig %c0_i32 : i32
    %tim01count_h = llhd.sig %c0_i32 : i32
    %tim0en_24 = llhd.sig name "tim0en" %false : i1
    %tim1en_25 = llhd.sig name "tim1en" %false : i1
    %tim23count = llhd.sig %c0_i32 : i32
    %tim23count_h = llhd.sig %c0_i32 : i32
    %tim2en_26 = llhd.sig name "tim2en" %false : i1
    %tim3en_27 = llhd.sig name "tim3en" %false : i1
    %tim45count = llhd.sig %c0_i32 : i32
    %tim45count_h = llhd.sig %c0_i32 : i32
    %tim4en_28 = llhd.sig name "tim4en" %false : i1
    %tim5en_29 = llhd.sig name "tim5en" %false : i1
    %timis = llhd.sig %c0_i32 : i32
    %timris = llhd.sig %c0_i32 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 9 preds: ^bb0, ^bb3, ^bb5, ^bb7, ^bb9, ^bb11, ^bb13, ^bb15, ^bb16
      llhd.wait (%2 : i3), ^bb2
    ^bb2:  // pred: ^bb1
      %112 = llhd.prb %cntdiv_6 : i3
      %113 = comb.icmp ceq %112, %c0_i3 : i3
      cf.cond_br %113, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %clkspec, %c1_i7 after %1 : i7
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      %114 = comb.icmp ceq %112, %c1_i3 : i3
      cf.cond_br %114, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %clkspec, %c3_i7 after %1 : i7
      cf.br ^bb1
    ^bb6:  // pred: ^bb4
      %115 = comb.icmp ceq %112, %c2_i3 : i3
      cf.cond_br %115, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      llhd.drv %clkspec, %c7_i7 after %1 : i7
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %116 = comb.icmp ceq %112, %c3_i3 : i3
      cf.cond_br %116, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      llhd.drv %clkspec, %c15_i7 after %1 : i7
      cf.br ^bb1
    ^bb10:  // pred: ^bb8
      %117 = comb.icmp ceq %112, %c-4_i3 : i3
      cf.cond_br %117, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      llhd.drv %clkspec, %c31_i7 after %1 : i7
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      %118 = comb.icmp ceq %112, %c-3_i3 : i3
      cf.cond_br %118, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      llhd.drv %clkspec, %c63_i7 after %1 : i7
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      %119 = comb.icmp ceq %112, %c-2_i3 : i3
      cf.cond_br %119, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      llhd.drv %clkspec, %c-1_i7 after %1 : i7
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      llhd.drv %clkspec, %c-1_i7 after %1 : i7
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %112 = llhd.prb %pclk_10 : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %pclk_10 : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %clkcnt, %c0_i7 after %0 : i7
      llhd.drv %clkdiv_en, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %clkcnt : i7
      %124 = llhd.prb %clkspec : i7
      %125 = comb.icmp eq %123, %124 : i7
      cf.cond_br %125, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %clkcnt, %c0_i7 after %0 : i7
      llhd.drv %clkdiv_en, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %126 = llhd.prb %clkcnt : i7
      %127 = comb.add %126, %c1_i7 : i7
      llhd.drv %clkcnt, %127 after %0 : i7
      llhd.drv %clkdiv_en, %false after %0 : i1
      cf.br ^bb1
    }
    %6 = llhd.prb %clkdiv_en : i1
    %x_cpu_gated_clk.clk_out = hw.instance "x_cpu_gated_clk" @gated_clk_cell(clk_in: %4: i1, global_en: %false: i1, module_en: %false: i1, local_en: %false: i1, external_en: %6: i1, pad_yy_test_mode: %test_mode: i1, pad_yy_gate_clk_en_b: %false: i1) -> (clk_out: i1) {sv.namehint = "clkdiv"}
    %7 = comb.xor %test_mode, %true : i1
    %8 = comb.and %cntdiven, %7 {sv.namehint = "clk_sel"} : i1
    %x_pwm_clkmux.clk_out = hw.instance "x_pwm_clkmux" @clk_mux2(clk_sel: %8: i1, clk_a: %4: i1, clk_b: %x_cpu_gated_clk.clk_out: i1) -> (clk_out: i1) {sv.namehint = "clksrc_tmp"}
    llhd.drv %ctrl_clk, %x_pwm_clkmux.clk_out after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pwm0en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %pwm0en_12 : i1
      llhd.drv %pwm0en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pwm1en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %pwm1en_15 : i1
      llhd.drv %pwm1en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pwm2en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %pwm2en_16 : i1
      llhd.drv %pwm2en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pwm3en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %pwm3en_17 : i1
      llhd.drv %pwm3en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pwm4en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %pwm4en_18 : i1
      llhd.drv %pwm4en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pwm5en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %pwm5en_19 : i1
      llhd.drv %pwm5en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pwm6en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %pwm6en_20 : i1
      llhd.drv %pwm6en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pwm7en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %pwm7en_21 : i1
      llhd.drv %pwm7en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pwm8en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %pwm8en_22 : i1
      llhd.drv %pwm8en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pwm9en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %pwm9en_23 : i1
      llhd.drv %pwm9en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pwm10en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %pwm10en_13 : i1
      llhd.drv %pwm10en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pwm11en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %pwm11en_14 : i1
      llhd.drv %pwm11en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cap0en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %cap0en_0 : i1
      llhd.drv %cap0en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cap1en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %cap1en_1 : i1
      llhd.drv %cap1en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cap2en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %cap2en_2 : i1
      llhd.drv %cap2en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cap3en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %cap3en_3 : i1
      llhd.drv %cap3en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cap4en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %cap4en_4 : i1
      llhd.drv %cap4en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cap5en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %cap5en_5 : i1
      llhd.drv %cap5en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %tim0en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %tim0en_24 : i1
      llhd.drv %tim0en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %tim1en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %tim1en_25 : i1
      llhd.drv %tim1en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %tim2en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %tim2en_26 : i1
      llhd.drv %tim2en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %tim3en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %tim3en_27 : i1
      llhd.drv %tim3en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %tim4en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %tim4en_28 : i1
      llhd.drv %tim4en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %112 = llhd.prb %ctrl_clk : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %ctrl_clk : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %tim5en_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %tim5en_29 : i1
      llhd.drv %tim5en_d, %123 after %0 : i1
      cf.br ^bb1
    }
    %9 = llhd.prb %cap0en_d : i1
    %10 = llhd.prb %pwm0en_d : i1
    %11 = llhd.prb %pwm1en_d : i1
    %12 = llhd.prb %tim0en_d : i1
    %pwm_0_inst.cap_cnt, %pwm_0_inst.int_cap_cnt_add, %pwm_0_inst.int_cap_cnt_match, %pwm_0_inst.int_pwm_cnt_load, %pwm_0_inst.int_pwm_cnt_zero, %pwm_0_inst.int_pwm_compa_down, %pwm_0_inst.int_pwm_compa_up, %pwm_0_inst.int_pwm_compb_down, %pwm_0_inst.int_pwm_compb_up, %pwm_0_inst.int_tim_cnt_match, %pwm_0_inst.pwm_0_oe, %pwm_0_inst.pwm_0_out, %pwm_0_inst.pwm_1_oe, %pwm_0_inst.pwm_1_out, %pwm_0_inst.pwm_cnt, %pwm_0_inst.pwm_tim_etb_trig, %pwm_0_inst.trigger = hw.instance "pwm_0_inst" @pwm_gen(cap_en: %9: i1, cap_load_value: %cap0match: i32, cap_mode: %cap0mode: i1, cap_select: %cap0eventa: i2, clk: %3: i1, compa_val: %compa_val_0: i32, compb_val: %compb_val_0: i32, deadband_delay_cnt: %delay0: i12, deadband_en: %db0en: i1, i_capture: %i_capture_0: i1, int_clr_cap_cnt_add: %cap0timic: i1, int_clr_cap_cnt_match: %cap0cntic: i1, int_clr_pwm_cnt_load: %intic0cntload: i1, int_clr_pwm_cnt_zero: %intic0cntzero: i1, int_clr_pwm_compa_down: %intic0cmpad: i1, int_clr_pwm_compa_up: %intic0cmpau: i1, int_clr_pwm_compb_down: %intic0cmpbd: i1, int_clr_pwm_compb_up: %intic0cmpbu: i1, int_clr_tim_cnt_match: %tim0ic: i1, int_en_cap_cnt_add: %cap0timie: i1, int_en_cap_cnt_match: %cap0cntie: i1, int_en_pwm_cnt_load: %int0encntload: i1, int_en_pwm_cnt_zero: %int0encntzero: i1, int_en_pwm_compa_down: %int0encmpad: i1, int_en_pwm_compa_up: %int0encmpau: i1, int_en_pwm_compb_down: %int0encmpbd: i1, int_en_pwm_compb_up: %int0encmpbu: i1, int_en_tim_cnt_match: %tim0ie: i1, pclk: %4: i1, pwm0_en: %10: i1, pwm0_inv: %pwm0inv: i1, pwm1_en: %11: i1, pwm1_inv: %pwm1inv: i1, pwm_load_value: %pwm0load: i32, pwm_mode: %pwm0mode: i1, rstn: %5: i1, sync_mode: %sync0mode: i2, tim_en: %12: i1, tim_load_value: %tim0load: i32, trend: %tr0end: i1, trenu: %tr0enu: i1, trig_val: %pwm0trig_val: i32) -> (cap_cnt: i32, int_cap_cnt_add: i1, int_cap_cnt_match: i1, int_pwm_cnt_load: i1, int_pwm_cnt_zero: i1, int_pwm_compa_down: i1, int_pwm_compa_up: i1, int_pwm_compb_down: i1, int_pwm_compb_up: i1, int_tim_cnt_match: i1, pwm_0_oe: i1, pwm_0_out: i1, pwm_1_oe: i1, pwm_1_out: i1, pwm_cnt: i32, pwm_tim_etb_trig: i1, trigger: i1) {sv.namehint = "trigger0"}
    %13 = llhd.prb %cap1en_d : i1
    %14 = llhd.prb %pwm2en_d : i1
    %15 = llhd.prb %pwm3en_d : i1
    %16 = llhd.prb %tim1en_d : i1
    %pwm_1_inst.cap_cnt, %pwm_1_inst.int_cap_cnt_add, %pwm_1_inst.int_cap_cnt_match, %pwm_1_inst.int_pwm_cnt_load, %pwm_1_inst.int_pwm_cnt_zero, %pwm_1_inst.int_pwm_compa_down, %pwm_1_inst.int_pwm_compa_up, %pwm_1_inst.int_pwm_compb_down, %pwm_1_inst.int_pwm_compb_up, %pwm_1_inst.int_tim_cnt_match, %pwm_1_inst.pwm_0_oe, %pwm_1_inst.pwm_0_out, %pwm_1_inst.pwm_1_oe, %pwm_1_inst.pwm_1_out, %pwm_1_inst.pwm_cnt, %pwm_1_inst.pwm_tim_etb_trig, %pwm_1_inst.trigger = hw.instance "pwm_1_inst" @pwm_gen(cap_en: %13: i1, cap_load_value: %cap1match: i32, cap_mode: %cap1mode: i1, cap_select: %cap1eventa: i2, clk: %3: i1, compa_val: %compa_val_1: i32, compb_val: %compb_val_1: i32, deadband_delay_cnt: %delay1: i12, deadband_en: %db1en: i1, i_capture: %i_capture_2: i1, int_clr_cap_cnt_add: %cap1timic: i1, int_clr_cap_cnt_match: %cap1cntic: i1, int_clr_pwm_cnt_load: %intic1cntload: i1, int_clr_pwm_cnt_zero: %intic1cntzero: i1, int_clr_pwm_compa_down: %intic1cmpad: i1, int_clr_pwm_compa_up: %intic1cmpau: i1, int_clr_pwm_compb_down: %intic1cmpbd: i1, int_clr_pwm_compb_up: %intic1cmpbu: i1, int_clr_tim_cnt_match: %tim1ic: i1, int_en_cap_cnt_add: %cap1timie: i1, int_en_cap_cnt_match: %cap1cntie: i1, int_en_pwm_cnt_load: %int1encntload: i1, int_en_pwm_cnt_zero: %int1encntzero: i1, int_en_pwm_compa_down: %int1encmpad: i1, int_en_pwm_compa_up: %int1encmpau: i1, int_en_pwm_compb_down: %int1encmpbd: i1, int_en_pwm_compb_up: %int1encmpbu: i1, int_en_tim_cnt_match: %tim1ie: i1, pclk: %4: i1, pwm0_en: %14: i1, pwm0_inv: %pwm2inv: i1, pwm1_en: %15: i1, pwm1_inv: %pwm3inv: i1, pwm_load_value: %pwm1load: i32, pwm_mode: %pwm1mode: i1, rstn: %5: i1, sync_mode: %sync1mode: i2, tim_en: %16: i1, tim_load_value: %tim1load: i32, trend: %tr1end: i1, trenu: %tr1enu: i1, trig_val: %pwm1trig_val: i32) -> (cap_cnt: i32, int_cap_cnt_add: i1, int_cap_cnt_match: i1, int_pwm_cnt_load: i1, int_pwm_cnt_zero: i1, int_pwm_compa_down: i1, int_pwm_compa_up: i1, int_pwm_compb_down: i1, int_pwm_compb_up: i1, int_tim_cnt_match: i1, pwm_0_oe: i1, pwm_0_out: i1, pwm_1_oe: i1, pwm_1_out: i1, pwm_cnt: i32, pwm_tim_etb_trig: i1, trigger: i1) {sv.namehint = "trigger1"}
    %17 = llhd.prb %cap2en_d : i1
    %18 = llhd.prb %pwm4en_d : i1
    %19 = llhd.prb %pwm5en_d : i1
    %20 = llhd.prb %tim2en_d : i1
    %pwm_2_inst.cap_cnt, %pwm_2_inst.int_cap_cnt_add, %pwm_2_inst.int_cap_cnt_match, %pwm_2_inst.int_pwm_cnt_load, %pwm_2_inst.int_pwm_cnt_zero, %pwm_2_inst.int_pwm_compa_down, %pwm_2_inst.int_pwm_compa_up, %pwm_2_inst.int_pwm_compb_down, %pwm_2_inst.int_pwm_compb_up, %pwm_2_inst.int_tim_cnt_match, %pwm_2_inst.pwm_0_oe, %pwm_2_inst.pwm_0_out, %pwm_2_inst.pwm_1_oe, %pwm_2_inst.pwm_1_out, %pwm_2_inst.pwm_cnt, %pwm_2_inst.pwm_tim_etb_trig, %pwm_2_inst.trigger = hw.instance "pwm_2_inst" @pwm_gen(cap_en: %17: i1, cap_load_value: %cap2match: i32, cap_mode: %cap2mode: i1, cap_select: %cap2eventa: i2, clk: %3: i1, compa_val: %compa_val_2: i32, compb_val: %compb_val_2: i32, deadband_delay_cnt: %delay2: i12, deadband_en: %db2en: i1, i_capture: %i_capture_4: i1, int_clr_cap_cnt_add: %cap2timic: i1, int_clr_cap_cnt_match: %cap2cntic: i1, int_clr_pwm_cnt_load: %intic2cntload: i1, int_clr_pwm_cnt_zero: %intic2cntzero: i1, int_clr_pwm_compa_down: %intic2cmpad: i1, int_clr_pwm_compa_up: %intic2cmpau: i1, int_clr_pwm_compb_down: %intic2cmpbd: i1, int_clr_pwm_compb_up: %intic2cmpbu: i1, int_clr_tim_cnt_match: %tim2ic: i1, int_en_cap_cnt_add: %cap2timie: i1, int_en_cap_cnt_match: %cap2cntie: i1, int_en_pwm_cnt_load: %int2encntload: i1, int_en_pwm_cnt_zero: %int2encntzero: i1, int_en_pwm_compa_down: %int2encmpad: i1, int_en_pwm_compa_up: %int2encmpau: i1, int_en_pwm_compb_down: %int2encmpbd: i1, int_en_pwm_compb_up: %int2encmpbu: i1, int_en_tim_cnt_match: %tim2ie: i1, pclk: %4: i1, pwm0_en: %18: i1, pwm0_inv: %pwm4inv: i1, pwm1_en: %19: i1, pwm1_inv: %pwm5inv: i1, pwm_load_value: %pwm2load: i32, pwm_mode: %pwm2mode: i1, rstn: %5: i1, sync_mode: %sync2mode: i2, tim_en: %20: i1, tim_load_value: %tim2load: i32, trend: %tr2end: i1, trenu: %tr2enu: i1, trig_val: %pwm2trig_val: i32) -> (cap_cnt: i32, int_cap_cnt_add: i1, int_cap_cnt_match: i1, int_pwm_cnt_load: i1, int_pwm_cnt_zero: i1, int_pwm_compa_down: i1, int_pwm_compa_up: i1, int_pwm_compb_down: i1, int_pwm_compb_up: i1, int_tim_cnt_match: i1, pwm_0_oe: i1, pwm_0_out: i1, pwm_1_oe: i1, pwm_1_out: i1, pwm_cnt: i32, pwm_tim_etb_trig: i1, trigger: i1) {sv.namehint = "trigger2"}
    %21 = llhd.prb %cap3en_d : i1
    %22 = llhd.prb %pwm6en_d : i1
    %23 = llhd.prb %pwm7en_d : i1
    %24 = llhd.prb %tim3en_d : i1
    %pwm_3_inst.cap_cnt, %pwm_3_inst.int_cap_cnt_add, %pwm_3_inst.int_cap_cnt_match, %pwm_3_inst.int_pwm_cnt_load, %pwm_3_inst.int_pwm_cnt_zero, %pwm_3_inst.int_pwm_compa_down, %pwm_3_inst.int_pwm_compa_up, %pwm_3_inst.int_pwm_compb_down, %pwm_3_inst.int_pwm_compb_up, %pwm_3_inst.int_tim_cnt_match, %pwm_3_inst.pwm_0_oe, %pwm_3_inst.pwm_0_out, %pwm_3_inst.pwm_1_oe, %pwm_3_inst.pwm_1_out, %pwm_3_inst.pwm_cnt, %pwm_3_inst.pwm_tim_etb_trig, %pwm_3_inst.trigger = hw.instance "pwm_3_inst" @pwm_gen(cap_en: %21: i1, cap_load_value: %cap3match: i32, cap_mode: %cap3mode: i1, cap_select: %cap3eventa: i2, clk: %3: i1, compa_val: %compa_val_3: i32, compb_val: %compb_val_3: i32, deadband_delay_cnt: %delay3: i12, deadband_en: %db3en: i1, i_capture: %i_capture_6: i1, int_clr_cap_cnt_add: %cap3timic: i1, int_clr_cap_cnt_match: %cap3cntic: i1, int_clr_pwm_cnt_load: %intic3cntload: i1, int_clr_pwm_cnt_zero: %intic3cntzero: i1, int_clr_pwm_compa_down: %intic3cmpad: i1, int_clr_pwm_compa_up: %intic3cmpau: i1, int_clr_pwm_compb_down: %intic3cmpbd: i1, int_clr_pwm_compb_up: %intic3cmpbu: i1, int_clr_tim_cnt_match: %tim3ic: i1, int_en_cap_cnt_add: %cap3timie: i1, int_en_cap_cnt_match: %cap3cntie: i1, int_en_pwm_cnt_load: %int3encntload: i1, int_en_pwm_cnt_zero: %int3encntzero: i1, int_en_pwm_compa_down: %int3encmpad: i1, int_en_pwm_compa_up: %int3encmpau: i1, int_en_pwm_compb_down: %int3encmpbd: i1, int_en_pwm_compb_up: %int3encmpbu: i1, int_en_tim_cnt_match: %tim3ie: i1, pclk: %4: i1, pwm0_en: %22: i1, pwm0_inv: %pwm6inv: i1, pwm1_en: %23: i1, pwm1_inv: %pwm7inv: i1, pwm_load_value: %pwm3load: i32, pwm_mode: %pwm3mode: i1, rstn: %5: i1, sync_mode: %sync3mode: i2, tim_en: %24: i1, tim_load_value: %tim3load: i32, trend: %tr3end: i1, trenu: %tr3enu: i1, trig_val: %pwm3trig_val: i32) -> (cap_cnt: i32, int_cap_cnt_add: i1, int_cap_cnt_match: i1, int_pwm_cnt_load: i1, int_pwm_cnt_zero: i1, int_pwm_compa_down: i1, int_pwm_compa_up: i1, int_pwm_compb_down: i1, int_pwm_compb_up: i1, int_tim_cnt_match: i1, pwm_0_oe: i1, pwm_0_out: i1, pwm_1_oe: i1, pwm_1_out: i1, pwm_cnt: i32, pwm_tim_etb_trig: i1, trigger: i1) {sv.namehint = "trigger3"}
    %25 = llhd.prb %cap4en_d : i1
    %26 = llhd.prb %pwm8en_d : i1
    %27 = llhd.prb %pwm9en_d : i1
    %28 = llhd.prb %tim4en_d : i1
    %pwm_4_inst.cap_cnt, %pwm_4_inst.int_cap_cnt_add, %pwm_4_inst.int_cap_cnt_match, %pwm_4_inst.int_pwm_cnt_load, %pwm_4_inst.int_pwm_cnt_zero, %pwm_4_inst.int_pwm_compa_down, %pwm_4_inst.int_pwm_compa_up, %pwm_4_inst.int_pwm_compb_down, %pwm_4_inst.int_pwm_compb_up, %pwm_4_inst.int_tim_cnt_match, %pwm_4_inst.pwm_0_oe, %pwm_4_inst.pwm_0_out, %pwm_4_inst.pwm_1_oe, %pwm_4_inst.pwm_1_out, %pwm_4_inst.pwm_cnt, %pwm_4_inst.pwm_tim_etb_trig, %pwm_4_inst.trigger = hw.instance "pwm_4_inst" @pwm_gen(cap_en: %25: i1, cap_load_value: %cap4match: i32, cap_mode: %cap4mode: i1, cap_select: %cap4eventa: i2, clk: %3: i1, compa_val: %compa_val_4: i32, compb_val: %compb_val_4: i32, deadband_delay_cnt: %delay4: i12, deadband_en: %db4en: i1, i_capture: %i_capture_8: i1, int_clr_cap_cnt_add: %cap4timic: i1, int_clr_cap_cnt_match: %cap4cntic: i1, int_clr_pwm_cnt_load: %intic4cntload: i1, int_clr_pwm_cnt_zero: %intic4cntzero: i1, int_clr_pwm_compa_down: %intic4cmpad: i1, int_clr_pwm_compa_up: %intic4cmpau: i1, int_clr_pwm_compb_down: %intic4cmpbd: i1, int_clr_pwm_compb_up: %intic4cmpbu: i1, int_clr_tim_cnt_match: %tim4ic: i1, int_en_cap_cnt_add: %cap4timie: i1, int_en_cap_cnt_match: %cap4cntie: i1, int_en_pwm_cnt_load: %int4encntload: i1, int_en_pwm_cnt_zero: %int4encntzero: i1, int_en_pwm_compa_down: %int4encmpad: i1, int_en_pwm_compa_up: %int4encmpau: i1, int_en_pwm_compb_down: %int4encmpbd: i1, int_en_pwm_compb_up: %int4encmpbu: i1, int_en_tim_cnt_match: %tim4ie: i1, pclk: %4: i1, pwm0_en: %26: i1, pwm0_inv: %pwm8inv: i1, pwm1_en: %27: i1, pwm1_inv: %pwm9inv: i1, pwm_load_value: %pwm4load: i32, pwm_mode: %pwm4mode: i1, rstn: %5: i1, sync_mode: %sync4mode: i2, tim_en: %28: i1, tim_load_value: %tim4load: i32, trend: %tr4end: i1, trenu: %tr4enu: i1, trig_val: %pwm4trig_val: i32) -> (cap_cnt: i32, int_cap_cnt_add: i1, int_cap_cnt_match: i1, int_pwm_cnt_load: i1, int_pwm_cnt_zero: i1, int_pwm_compa_down: i1, int_pwm_compa_up: i1, int_pwm_compb_down: i1, int_pwm_compb_up: i1, int_tim_cnt_match: i1, pwm_0_oe: i1, pwm_0_out: i1, pwm_1_oe: i1, pwm_1_out: i1, pwm_cnt: i32, pwm_tim_etb_trig: i1, trigger: i1) {sv.namehint = "trigger4"}
    %29 = llhd.prb %cap5en_d : i1
    %30 = llhd.prb %pwm10en_d : i1
    %31 = llhd.prb %pwm11en_d : i1
    %32 = llhd.prb %tim5en_d : i1
    %pwm_5_inst.cap_cnt, %pwm_5_inst.int_cap_cnt_add, %pwm_5_inst.int_cap_cnt_match, %pwm_5_inst.int_pwm_cnt_load, %pwm_5_inst.int_pwm_cnt_zero, %pwm_5_inst.int_pwm_compa_down, %pwm_5_inst.int_pwm_compa_up, %pwm_5_inst.int_pwm_compb_down, %pwm_5_inst.int_pwm_compb_up, %pwm_5_inst.int_tim_cnt_match, %pwm_5_inst.pwm_0_oe, %pwm_5_inst.pwm_0_out, %pwm_5_inst.pwm_1_oe, %pwm_5_inst.pwm_1_out, %pwm_5_inst.pwm_cnt, %pwm_5_inst.pwm_tim_etb_trig, %pwm_5_inst.trigger = hw.instance "pwm_5_inst" @pwm_gen(cap_en: %29: i1, cap_load_value: %cap5match: i32, cap_mode: %cap5mode: i1, cap_select: %cap5eventa: i2, clk: %3: i1, compa_val: %compa_val_5: i32, compb_val: %compb_val_5: i32, deadband_delay_cnt: %delay5: i12, deadband_en: %db5en: i1, i_capture: %i_capture_10: i1, int_clr_cap_cnt_add: %cap5timic: i1, int_clr_cap_cnt_match: %cap5cntic: i1, int_clr_pwm_cnt_load: %intic5cntload: i1, int_clr_pwm_cnt_zero: %intic5cntzero: i1, int_clr_pwm_compa_down: %intic5cmpad: i1, int_clr_pwm_compa_up: %intic5cmpau: i1, int_clr_pwm_compb_down: %intic5cmpbd: i1, int_clr_pwm_compb_up: %intic5cmpbu: i1, int_clr_tim_cnt_match: %tim5ic: i1, int_en_cap_cnt_add: %cap5timie: i1, int_en_cap_cnt_match: %cap5cntie: i1, int_en_pwm_cnt_load: %int5encntload: i1, int_en_pwm_cnt_zero: %int5encntzero: i1, int_en_pwm_compa_down: %int5encmpad: i1, int_en_pwm_compa_up: %int5encmpau: i1, int_en_pwm_compb_down: %int5encmpbd: i1, int_en_pwm_compb_up: %int5encmpbu: i1, int_en_tim_cnt_match: %tim5ie: i1, pclk: %4: i1, pwm0_en: %30: i1, pwm0_inv: %pwm10inv: i1, pwm1_en: %31: i1, pwm1_inv: %pwm11inv: i1, pwm_load_value: %pwm5load: i32, pwm_mode: %pwm5mode: i1, rstn: %5: i1, sync_mode: %sync5mode: i2, tim_en: %32: i1, tim_load_value: %tim5load: i32, trend: %tr5end: i1, trenu: %tr5enu: i1, trig_val: %pwm5trig_val: i32) -> (cap_cnt: i32, int_cap_cnt_add: i1, int_cap_cnt_match: i1, int_pwm_cnt_load: i1, int_pwm_cnt_zero: i1, int_pwm_compa_down: i1, int_pwm_compa_up: i1, int_pwm_compb_down: i1, int_pwm_compb_up: i1, int_tim_cnt_match: i1, pwm_0_oe: i1, pwm_0_out: i1, pwm_1_oe: i1, pwm_1_out: i1, pwm_cnt: i32, pwm_tim_etb_trig: i1, trigger: i1) {sv.namehint = "trigger5"}
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %112 = llhd.prb %pclk_10 : i1
      %113 = llhd.prb %presetn_11 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %114 = llhd.prb %pclk_10 : i1
      %115 = comb.xor bin %112, %true : i1
      %116 = comb.and bin %115, %114 : i1
      %117 = llhd.prb %presetn_11 : i1
      %118 = comb.xor bin %117, %true : i1
      %119 = comb.and bin %113, %118 : i1
      %120 = comb.or bin %116, %119 : i1
      cf.cond_br %120, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %121 = llhd.prb %presetn_11 : i1
      %122 = comb.xor %121, %true : i1
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_fault, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %123 = llhd.prb %inticfault_9 : i1
      cf.cond_br %123, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %int_fault, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %124 = llhd.prb %fault_7 : i1
      %125 = llhd.prb %intenfault_8 : i1
      %126 = comb.and %124, %125 : i1
      cf.cond_br %126, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %int_fault, %true after %0 : i1
      cf.br ^bb1
    }
    %33 = llhd.prb %int_fault : i1
    %34 = comb.or %pwm_0_inst.int_pwm_compb_down, %pwm_0_inst.int_pwm_compa_down, %pwm_0_inst.int_pwm_compb_up, %pwm_0_inst.int_pwm_compa_up, %pwm_0_inst.int_pwm_cnt_load, %pwm_0_inst.int_pwm_cnt_zero, %pwm_0_inst.int_cap_cnt_add, %pwm_0_inst.int_cap_cnt_match, %pwm_0_inst.int_tim_cnt_match, %pwm_1_inst.int_pwm_compb_down, %pwm_1_inst.int_pwm_compa_down, %pwm_1_inst.int_pwm_compb_up, %pwm_1_inst.int_pwm_compa_up, %pwm_1_inst.int_pwm_cnt_load, %pwm_1_inst.int_pwm_cnt_zero, %pwm_1_inst.int_cap_cnt_add, %pwm_1_inst.int_cap_cnt_match, %pwm_1_inst.int_tim_cnt_match, %pwm_2_inst.int_pwm_compb_down, %pwm_2_inst.int_pwm_compa_down, %pwm_2_inst.int_pwm_compb_up, %pwm_2_inst.int_pwm_compa_up, %pwm_2_inst.int_pwm_cnt_load, %pwm_2_inst.int_pwm_cnt_zero, %pwm_2_inst.int_cap_cnt_add, %pwm_2_inst.int_cap_cnt_match, %pwm_2_inst.int_tim_cnt_match, %pwm_3_inst.int_pwm_compb_down, %pwm_3_inst.int_pwm_compa_down, %pwm_3_inst.int_pwm_compb_up, %pwm_3_inst.int_pwm_compa_up, %pwm_3_inst.int_pwm_cnt_load, %pwm_3_inst.int_pwm_cnt_zero, %pwm_3_inst.int_cap_cnt_add, %pwm_3_inst.int_cap_cnt_match, %pwm_3_inst.int_tim_cnt_match, %pwm_4_inst.int_pwm_compb_down, %pwm_4_inst.int_pwm_compa_down, %pwm_4_inst.int_pwm_compb_up, %pwm_4_inst.int_pwm_compa_up, %pwm_4_inst.int_pwm_cnt_load, %pwm_4_inst.int_pwm_cnt_zero, %pwm_4_inst.int_cap_cnt_add, %pwm_4_inst.int_cap_cnt_match, %pwm_4_inst.int_tim_cnt_match, %pwm_5_inst.int_pwm_compb_down, %pwm_5_inst.int_pwm_compa_down, %pwm_5_inst.int_pwm_compb_up, %pwm_5_inst.int_pwm_compa_up, %pwm_5_inst.int_pwm_cnt_load, %pwm_5_inst.int_pwm_cnt_zero, %pwm_5_inst.int_cap_cnt_add, %pwm_5_inst.int_cap_cnt_match, %pwm_5_inst.int_tim_cnt_match, %33 : i1
    %35 = comb.extract %pwm_1_inst.cap_cnt from 0 : (i32) -> i16
    %36 = comb.extract %pwm_0_inst.cap_cnt from 0 : (i32) -> i16
    %37 = comb.concat %35, %36 : i16, i16
    llhd.drv %cap01t, %37 after %1 : i32
    %38 = comb.extract %pwm_3_inst.cap_cnt from 0 : (i32) -> i16
    %39 = comb.extract %pwm_2_inst.cap_cnt from 0 : (i32) -> i16
    %40 = comb.concat %38, %39 : i16, i16
    llhd.drv %cap23t, %40 after %1 : i32
    %41 = comb.extract %pwm_5_inst.cap_cnt from 0 : (i32) -> i16
    %42 = comb.extract %pwm_4_inst.cap_cnt from 0 : (i32) -> i16
    %43 = comb.concat %41, %42 : i16, i16
    llhd.drv %cap45t, %43 after %1 : i32
    %44 = comb.extract %pwm_1_inst.cap_cnt from 16 : (i32) -> i16
    %45 = comb.extract %pwm_0_inst.cap_cnt from 16 : (i32) -> i16
    %46 = comb.concat %44, %45 : i16, i16
    llhd.drv %cap01t_h, %46 after %1 : i32
    %47 = comb.extract %pwm_3_inst.cap_cnt from 16 : (i32) -> i16
    %48 = comb.extract %pwm_2_inst.cap_cnt from 16 : (i32) -> i16
    %49 = comb.concat %47, %48 : i16, i16
    llhd.drv %cap23t_h, %49 after %1 : i32
    %50 = comb.extract %pwm_5_inst.cap_cnt from 16 : (i32) -> i16
    %51 = comb.extract %pwm_4_inst.cap_cnt from 16 : (i32) -> i16
    %52 = comb.concat %50, %51 : i16, i16
    llhd.drv %cap45t_h, %52 after %1 : i32
    %53 = comb.concat %c0_i20, %pwm_5_inst.int_cap_cnt_add, %pwm_4_inst.int_cap_cnt_add, %pwm_3_inst.int_cap_cnt_add, %pwm_2_inst.int_cap_cnt_add, %pwm_1_inst.int_cap_cnt_add, %pwm_0_inst.int_cap_cnt_add, %pwm_5_inst.int_cap_cnt_match, %pwm_4_inst.int_cap_cnt_match, %pwm_3_inst.int_cap_cnt_match, %pwm_2_inst.int_cap_cnt_match, %pwm_1_inst.int_cap_cnt_match, %pwm_0_inst.int_cap_cnt_match : i20, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1
    llhd.drv %capis, %53 after %1 : i32
    %54 = llhd.prb %capis : i32
    llhd.drv %capris, %54 after %1 : i32
    llhd.drv %cnt0val, %pwm_0_inst.pwm_cnt after %1 : i32
    llhd.drv %cnt1val, %pwm_1_inst.pwm_cnt after %1 : i32
    llhd.drv %cnt2val, %pwm_2_inst.pwm_cnt after %1 : i32
    llhd.drv %cnt3val, %pwm_3_inst.pwm_cnt after %1 : i32
    llhd.drv %cnt4val, %pwm_4_inst.pwm_cnt after %1 : i32
    llhd.drv %cnt5val, %pwm_5_inst.pwm_cnt after %1 : i32
    %55 = comb.extract %pwm_1_inst.pwm_cnt from 0 : (i32) -> i16
    %56 = comb.extract %pwm_0_inst.pwm_cnt from 0 : (i32) -> i16
    %57 = comb.concat %55, %56 : i16, i16
    llhd.drv %pwm01count, %57 after %1 : i32
    %58 = comb.extract %pwm_3_inst.pwm_cnt from 0 : (i32) -> i16
    %59 = comb.extract %pwm_2_inst.pwm_cnt from 0 : (i32) -> i16
    %60 = comb.concat %58, %59 : i16, i16
    llhd.drv %pwm23count, %60 after %1 : i32
    %61 = comb.extract %pwm_5_inst.pwm_cnt from 0 : (i32) -> i16
    %62 = comb.extract %pwm_4_inst.pwm_cnt from 0 : (i32) -> i16
    %63 = comb.concat %61, %62 : i16, i16
    llhd.drv %pwm45count, %63 after %1 : i32
    %64 = comb.extract %pwm_1_inst.pwm_cnt from 16 : (i32) -> i16
    %65 = comb.extract %pwm_0_inst.pwm_cnt from 16 : (i32) -> i16
    %66 = comb.concat %64, %65 : i16, i16
    llhd.drv %pwm01count_h, %66 after %1 : i32
    %67 = comb.extract %pwm_3_inst.pwm_cnt from 16 : (i32) -> i16
    %68 = comb.extract %pwm_2_inst.pwm_cnt from 16 : (i32) -> i16
    %69 = comb.concat %67, %68 : i16, i16
    llhd.drv %pwm23count_h, %69 after %1 : i32
    %70 = comb.extract %pwm_5_inst.pwm_cnt from 16 : (i32) -> i16
    %71 = comb.extract %pwm_4_inst.pwm_cnt from 16 : (i32) -> i16
    %72 = comb.concat %70, %71 : i16, i16
    llhd.drv %pwm45count_h, %72 after %1 : i32
    %73 = comb.concat %c0_i2, %pwm_2_inst.int_pwm_compb_down, %pwm_2_inst.int_pwm_compa_down, %pwm_2_inst.int_pwm_compb_up, %pwm_2_inst.int_pwm_compa_up, %pwm_2_inst.int_pwm_cnt_load, %pwm_2_inst.int_pwm_cnt_zero, %c0_i2, %pwm_1_inst.int_pwm_compb_down, %pwm_1_inst.int_pwm_compa_down, %pwm_1_inst.int_pwm_compb_up, %pwm_1_inst.int_pwm_compa_up, %pwm_1_inst.int_pwm_cnt_load, %pwm_1_inst.int_pwm_cnt_zero, %c0_i2, %pwm_0_inst.int_pwm_compb_down, %pwm_0_inst.int_pwm_compa_down, %pwm_0_inst.int_pwm_compb_up, %pwm_0_inst.int_pwm_compa_up, %pwm_0_inst.int_pwm_cnt_load, %pwm_0_inst.int_pwm_cnt_zero, %c0_i7, %33 : i2, i1, i1, i1, i1, i1, i1, i2, i1, i1, i1, i1, i1, i1, i2, i1, i1, i1, i1, i1, i1, i7, i1
    llhd.drv %pwmris1, %73 after %1 : i32
    %74 = comb.concat %c0_i10, %pwm_5_inst.int_pwm_compb_down, %pwm_5_inst.int_pwm_compa_down, %pwm_5_inst.int_pwm_compb_up, %pwm_5_inst.int_pwm_compa_up, %pwm_5_inst.int_pwm_cnt_load, %pwm_5_inst.int_pwm_cnt_zero, %c0_i2, %pwm_4_inst.int_pwm_compb_down, %pwm_4_inst.int_pwm_compa_down, %pwm_4_inst.int_pwm_compb_up, %pwm_4_inst.int_pwm_compa_up, %pwm_4_inst.int_pwm_cnt_load, %pwm_4_inst.int_pwm_cnt_zero, %c0_i2, %pwm_3_inst.int_pwm_compb_down, %pwm_3_inst.int_pwm_compa_down, %pwm_3_inst.int_pwm_compb_up, %pwm_3_inst.int_pwm_compa_up, %pwm_3_inst.int_pwm_cnt_load, %pwm_3_inst.int_pwm_cnt_zero : i10, i1, i1, i1, i1, i1, i1, i2, i1, i1, i1, i1, i1, i1, i2, i1, i1, i1, i1, i1, i1
    llhd.drv %pwmris2, %74 after %1 : i32
    %75 = llhd.prb %pwmris1 : i32
    llhd.drv %pwmis1, %75 after %1 : i32
    %76 = llhd.prb %pwmris2 : i32
    llhd.drv %pwmis2, %76 after %1 : i32
    llhd.drv %tim01count, %57 after %1 : i32
    llhd.drv %tim23count, %60 after %1 : i32
    llhd.drv %tim45count, %63 after %1 : i32
    llhd.drv %tim01count_h, %66 after %1 : i32
    llhd.drv %tim23count_h, %69 after %1 : i32
    llhd.drv %tim45count_h, %72 after %1 : i32
    %77 = comb.concat %c0_i26, %pwm_5_inst.int_tim_cnt_match, %pwm_4_inst.int_tim_cnt_match, %pwm_3_inst.int_tim_cnt_match, %pwm_2_inst.int_tim_cnt_match, %pwm_1_inst.int_tim_cnt_match, %pwm_0_inst.int_tim_cnt_match : i26, i1, i1, i1, i1, i1, i1
    llhd.drv %timis, %77 after %1 : i32
    %78 = llhd.prb %timis : i32
    llhd.drv %timris, %78 after %1 : i32
    %79 = comb.or %pwm_0_inst.trigger, %pwm_1_inst.trigger, %pwm_2_inst.trigger, %pwm_3_inst.trigger, %pwm_4_inst.trigger, %pwm_5_inst.trigger : i1
    llhd.drv %pwm_xx_trig_pre, %79 after %1 : i1
    %80 = llhd.prb %pwm_xx_trig_pre : i1
    %81 = comb.xor %triginv, %80 : i1
    %82 = comb.or %10, %11, %14, %15, %18, %19, %22, %23, %26, %27, %30, %31, %9, %13, %17, %21, %25, %29, %12, %16, %20, %24, %28, %32 : i1
    %83 = comb.xor %82, %true : i1
    %84 = llhd.prb %cap01t : i32
    %85 = llhd.prb %cap01t_h : i32
    llhd.drv %cap0en_0, %cap0en after %1 : i1
    llhd.drv %cap1en_1, %cap1en after %1 : i1
    %86 = llhd.prb %cap23t : i32
    %87 = llhd.prb %cap23t_h : i32
    llhd.drv %cap2en_2, %cap2en after %1 : i1
    llhd.drv %cap3en_3, %cap3en after %1 : i1
    %88 = llhd.prb %cap45t : i32
    %89 = llhd.prb %cap45t_h : i32
    llhd.drv %cap4en_4, %cap4en after %1 : i1
    llhd.drv %cap5en_5, %cap5en after %1 : i1
    %90 = llhd.prb %capris : i32
    %91 = llhd.prb %cnt0val : i32
    %92 = llhd.prb %cnt1val : i32
    %93 = llhd.prb %cnt2val : i32
    %94 = llhd.prb %cnt3val : i32
    %95 = llhd.prb %cnt4val : i32
    %96 = llhd.prb %cnt5val : i32
    llhd.drv %cntdiv_6, %cntdiv after %1 : i3
    llhd.drv %fault_7, %fault after %1 : i1
    llhd.drv %intenfault_8, %intenfault after %1 : i1
    llhd.drv %inticfault_9, %inticfault after %1 : i1
    llhd.drv %pclk_10, %pclk after %1 : i1
    llhd.drv %presetn_11, %presetn after %1 : i1
    %97 = llhd.prb %pwm01count : i32
    %98 = llhd.prb %pwm01count_h : i32
    llhd.drv %pwm0en_12, %pwm0en after %1 : i1
    llhd.drv %pwm10en_13, %pwm10en after %1 : i1
    llhd.drv %pwm11en_14, %pwm11en after %1 : i1
    llhd.drv %pwm1en_15, %pwm1en after %1 : i1
    %99 = llhd.prb %pwm23count : i32
    %100 = llhd.prb %pwm23count_h : i32
    llhd.drv %pwm2en_16, %pwm2en after %1 : i1
    llhd.drv %pwm3en_17, %pwm3en after %1 : i1
    %101 = llhd.prb %pwm45count : i32
    %102 = llhd.prb %pwm45count_h : i32
    llhd.drv %pwm4en_18, %pwm4en after %1 : i1
    llhd.drv %pwm5en_19, %pwm5en after %1 : i1
    llhd.drv %pwm6en_20, %pwm6en after %1 : i1
    llhd.drv %pwm7en_21, %pwm7en after %1 : i1
    llhd.drv %pwm8en_22, %pwm8en after %1 : i1
    llhd.drv %pwm9en_23, %pwm9en after %1 : i1
    %103 = llhd.prb %pwmis1 : i32
    %104 = llhd.prb %pwmis2 : i32
    %105 = llhd.prb %tim01count : i32
    %106 = llhd.prb %tim01count_h : i32
    llhd.drv %tim0en_24, %tim0en after %1 : i1
    llhd.drv %tim1en_25, %tim1en after %1 : i1
    %107 = llhd.prb %tim23count : i32
    %108 = llhd.prb %tim23count_h : i32
    llhd.drv %tim2en_26, %tim2en after %1 : i1
    llhd.drv %tim3en_27, %tim3en after %1 : i1
    %109 = llhd.prb %tim45count : i32
    %110 = llhd.prb %tim45count_h : i32
    llhd.drv %tim4en_28, %tim4en after %1 : i1
    llhd.drv %tim5en_29, %tim5en after %1 : i1
    %111 = llhd.prb %timris : i32
    hw.output %84, %85, %86, %87, %88, %89, %54, %90, %91, %92, %93, %94, %95, %96, %97, %98, %99, %100, %101, %102, %pwm_0_inst.pwm_0_oe, %pwm_0_inst.pwm_0_out, %pwm_5_inst.pwm_0_oe, %pwm_5_inst.pwm_0_out, %pwm_5_inst.pwm_1_oe, %pwm_5_inst.pwm_1_out, %pwm_0_inst.pwm_1_oe, %pwm_0_inst.pwm_1_out, %pwm_1_inst.pwm_0_oe, %pwm_1_inst.pwm_0_out, %pwm_1_inst.pwm_1_oe, %pwm_1_inst.pwm_1_out, %pwm_2_inst.pwm_0_oe, %pwm_2_inst.pwm_0_out, %pwm_2_inst.pwm_1_oe, %pwm_2_inst.pwm_1_out, %pwm_3_inst.pwm_0_oe, %pwm_3_inst.pwm_0_out, %pwm_3_inst.pwm_1_oe, %pwm_3_inst.pwm_1_out, %pwm_4_inst.pwm_0_oe, %pwm_4_inst.pwm_0_out, %pwm_4_inst.pwm_1_oe, %pwm_4_inst.pwm_1_out, %83, %pwm_0_inst.pwm_tim_etb_trig, %pwm_1_inst.pwm_tim_etb_trig, %pwm_2_inst.pwm_tim_etb_trig, %pwm_3_inst.pwm_tim_etb_trig, %pwm_4_inst.pwm_tim_etb_trig, %pwm_5_inst.pwm_tim_etb_trig, %81, %34, %103, %104, %75, %76, %105, %106, %107, %108, %109, %110, %78, %111 : i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32
  }
  hw.module private @pwm_gen(out cap_cnt : i32, in %cap_en : i1, in %cap_load_value : i32, in %cap_mode : i1, in %cap_select : i2, in %clk : i1, in %compa_val : i32, in %compb_val : i32, in %deadband_delay_cnt : i12, in %deadband_en : i1, in %i_capture : i1, out int_cap_cnt_add : i1, out int_cap_cnt_match : i1, in %int_clr_cap_cnt_add : i1, in %int_clr_cap_cnt_match : i1, in %int_clr_pwm_cnt_load : i1, in %int_clr_pwm_cnt_zero : i1, in %int_clr_pwm_compa_down : i1, in %int_clr_pwm_compa_up : i1, in %int_clr_pwm_compb_down : i1, in %int_clr_pwm_compb_up : i1, in %int_clr_tim_cnt_match : i1, in %int_en_cap_cnt_add : i1, in %int_en_cap_cnt_match : i1, in %int_en_pwm_cnt_load : i1, in %int_en_pwm_cnt_zero : i1, in %int_en_pwm_compa_down : i1, in %int_en_pwm_compa_up : i1, in %int_en_pwm_compb_down : i1, in %int_en_pwm_compb_up : i1, in %int_en_tim_cnt_match : i1, out int_pwm_cnt_load : i1, out int_pwm_cnt_zero : i1, out int_pwm_compa_down : i1, out int_pwm_compa_up : i1, out int_pwm_compb_down : i1, out int_pwm_compb_up : i1, out int_tim_cnt_match : i1, in %pclk : i1, in %pwm0_en : i1, in %pwm0_inv : i1, in %pwm1_en : i1, in %pwm1_inv : i1, out pwm_0_oe : i1, out pwm_0_out : i1, out pwm_1_oe : i1, out pwm_1_out : i1, out pwm_cnt : i32, in %pwm_load_value : i32, in %pwm_mode : i1, out pwm_tim_etb_trig : i1, in %rstn : i1, in %sync_mode : i2, in %tim_en : i1, in %tim_load_value : i32, in %trend : i1, in %trenu : i1, in %trig_val : i32, out trigger : i1) {
    %c1_i12 = hw.constant 1 : i12
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i12 = hw.constant 0 : i12
    %c-1_i32 = hw.constant -1 : i32
    %c-2_i2 = hw.constant -2 : i2
    %true = hw.constant true
    %c-1_i2 = hw.constant -1 : i2
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %false = hw.constant false
    %c1_i32 = hw.constant 1 : i32
    %c0_i32 = hw.constant 0 : i32
    %cap_cnt = llhd.sig %c0_i32 : i32
    %cap_cnt_add_flag_d = llhd.sig %false : i1
    %cap_cnt_match_flag_d = llhd.sig %false : i1
    %cap_edge = llhd.sig %false : i1
    %compa = llhd.sig %c0_i32 : i32
    %compa_down_flag_d = llhd.sig %false : i1
    %compa_up_flag_d = llhd.sig %false : i1
    %compb = llhd.sig %c0_i32 : i32
    %compb_down_flag_d = llhd.sig %false : i1
    %compb_up_flag_d = llhd.sig %false : i1
    %deadband_cnt_0 = llhd.sig %c0_i12 : i12
    %deadband_cnt_1 = llhd.sig %c0_i12 : i12
    %i_capture_d = llhd.sig %false : i1
    %i_capture_d2 = llhd.sig %false : i1
    %i_capture_d3 = llhd.sig %false : i1
    %inc_flag = llhd.sig %false : i1
    %int_cap_cnt_add = llhd.sig %false : i1
    %int_cap_cnt_match = llhd.sig %false : i1
    %int_pwm_cnt_load = llhd.sig %false : i1
    %int_pwm_cnt_zero = llhd.sig %false : i1
    %int_pwm_compa_down = llhd.sig %false : i1
    %int_pwm_compa_up = llhd.sig %false : i1
    %int_pwm_compb_down = llhd.sig %false : i1
    %int_pwm_compb_up = llhd.sig %false : i1
    %int_tim_cnt_match = llhd.sig %false : i1
    %load_cnt = llhd.sig %c0_i32 : i32
    %pwm_0_d = llhd.sig %false : i1
    %pwm_0_db = llhd.sig %false : i1
    %pwm_1_d = llhd.sig %false : i1
    %pwm_1_db = llhd.sig %false : i1
    %pwm_cnt = llhd.sig %c0_i32 : i32
    %pwm_cnt_load_d = llhd.sig %false : i1
    %pwm_cnt_zero_d = llhd.sig %false : i1
    %tim_cnt_match_flag_d = llhd.sig %false : i1
    %trigger_down_d = llhd.sig %false : i1
    %trigger_up_d = llhd.sig %false : i1
    %trigval = llhd.sig %c0_i32 : i32
    %updatereg = llhd.sig %false : i1
    %cap_cnt_add_flag = llhd.sig %false : i1
    %cap_cnt_add_flag_divedge = llhd.sig %false : i1
    %cap_cnt_match_flag = llhd.sig %false : i1
    %cap_cnt_match_flag_divedge = llhd.sig %false : i1
    %cap_en_0 = llhd.sig name "cap_en" %false : i1
    %cap_load_value_1 = llhd.sig name "cap_load_value" %c0_i32 : i32
    %cap_mode_2 = llhd.sig name "cap_mode" %false : i1
    %cap_select_3 = llhd.sig name "cap_select" %c0_i2 : i2
    %clk_4 = llhd.sig name "clk" %false : i1
    %2 = llhd.prb %clk_4 : i1
    %compa_down_flag = llhd.sig %false : i1
    %compa_down_flag_divedge = llhd.sig %false : i1
    %compa_up_flag = llhd.sig %false : i1
    %compa_up_flag_divedge = llhd.sig %false : i1
    %compa_val_5 = llhd.sig name "compa_val" %c0_i32 : i32
    %compb_down_flag = llhd.sig %false : i1
    %compb_down_flag_divedge = llhd.sig %false : i1
    %compb_up_flag = llhd.sig %false : i1
    %compb_up_flag_divedge = llhd.sig %false : i1
    %compb_val_6 = llhd.sig name "compb_val" %c0_i32 : i32
    %deadband_delay_cnt_7 = llhd.sig name "deadband_delay_cnt" %c0_i12 : i12
    %end_flag = llhd.sig %false : i1
    %i_capture_8 = llhd.sig name "i_capture" %false : i1
    %i_capture_fall_edge = llhd.sig %false : i1
    %i_capture_rise_edge = llhd.sig %false : i1
    %int_clr_cap_cnt_add_9 = llhd.sig name "int_clr_cap_cnt_add" %false : i1
    %int_clr_cap_cnt_match_10 = llhd.sig name "int_clr_cap_cnt_match" %false : i1
    %int_clr_pwm_cnt_load_11 = llhd.sig name "int_clr_pwm_cnt_load" %false : i1
    %int_clr_pwm_cnt_zero_12 = llhd.sig name "int_clr_pwm_cnt_zero" %false : i1
    %int_clr_pwm_compa_down_13 = llhd.sig name "int_clr_pwm_compa_down" %false : i1
    %int_clr_pwm_compa_up_14 = llhd.sig name "int_clr_pwm_compa_up" %false : i1
    %int_clr_pwm_compb_down_15 = llhd.sig name "int_clr_pwm_compb_down" %false : i1
    %int_clr_pwm_compb_up_16 = llhd.sig name "int_clr_pwm_compb_up" %false : i1
    %int_clr_tim_cnt_match_17 = llhd.sig name "int_clr_tim_cnt_match" %false : i1
    %int_en_cap_cnt_add_18 = llhd.sig name "int_en_cap_cnt_add" %false : i1
    %int_en_cap_cnt_match_19 = llhd.sig name "int_en_cap_cnt_match" %false : i1
    %int_en_pwm_cnt_load_20 = llhd.sig name "int_en_pwm_cnt_load" %false : i1
    %int_en_pwm_cnt_zero_21 = llhd.sig name "int_en_pwm_cnt_zero" %false : i1
    %int_en_pwm_compa_down_22 = llhd.sig name "int_en_pwm_compa_down" %false : i1
    %int_en_pwm_compa_up_23 = llhd.sig name "int_en_pwm_compa_up" %false : i1
    %int_en_pwm_compb_down_24 = llhd.sig name "int_en_pwm_compb_down" %false : i1
    %int_en_pwm_compb_up_25 = llhd.sig name "int_en_pwm_compb_up" %false : i1
    %int_en_tim_cnt_match_26 = llhd.sig name "int_en_tim_cnt_match" %false : i1
    %load_flag = llhd.sig %false : i1
    %pclk_27 = llhd.sig name "pclk" %false : i1
    %3 = llhd.prb %pclk_27 : i1
    %pwm_0 = llhd.sig %false : i1
    %pwm_0_out_pre = llhd.sig %false : i1
    %pwm_1 = llhd.sig %false : i1
    %pwm_1_out_pre = llhd.sig %false : i1
    %pwm_cnt_load = llhd.sig %false : i1
    %pwm_cnt_load_divedge = llhd.sig %false : i1
    %pwm_cnt_zero = llhd.sig %false : i1
    %pwm_cnt_zero_divedge = llhd.sig %false : i1
    %pwm_en = llhd.sig %false : i1
    %pwm_load_value_28 = llhd.sig name "pwm_load_value" %c0_i32 : i32
    %pwm_mode_29 = llhd.sig name "pwm_mode" %false : i1
    %rstn_30 = llhd.sig name "rstn" %false : i1
    %4 = llhd.prb %rstn_30 : i1
    %sync_mode_31 = llhd.sig name "sync_mode" %c0_i2 : i2
    %tim_cnt_match_flag = llhd.sig %false : i1
    %tim_cnt_match_flag_divedge = llhd.sig %false : i1
    %tim_en_32 = llhd.sig name "tim_en" %false : i1
    %tim_load_value_33 = llhd.sig name "tim_load_value" %c0_i32 : i32
    %trig_val_34 = llhd.sig name "trig_val" %c0_i32 : i32
    %trigger_down = llhd.sig %false : i1
    %trigger_up = llhd.sig %false : i1
    %zero_flag = llhd.sig %false : i1
    %5 = comb.or %pwm1_en, %pwm0_en : i1
    llhd.drv %pwm_en, %5 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 15 preds: ^bb0, ^bb2, ^bb4, ^bb8, ^bb9, ^bb11, ^bb13, ^bb14, ^bb18, ^bb19, ^bb20, ^bb21, ^bb24, ^bb25, ^bb26
      %140 = llhd.prb %clk_4 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %clk_4 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pwm_cnt, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %pwm_en : i1
      cf.cond_br %151, ^bb6, ^bb15
    ^bb6:  // pred: ^bb5
      %152 = llhd.prb %pwm_mode_29 : i1
      %153 = comb.xor %152, %true : i1
      cf.cond_br %153, ^bb7, ^bb10
    ^bb7:  // pred: ^bb6
      %154 = llhd.prb %pwm_cnt : i32
      %155 = llhd.prb %load_cnt : i32
      %156 = comb.icmp eq %154, %155 : i32
      cf.cond_br %156, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %pwm_cnt, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %157 = llhd.prb %pwm_cnt : i32
      %158 = comb.add %157, %c1_i32 : i32
      llhd.drv %pwm_cnt, %158 after %0 : i32
      cf.br ^bb1
    ^bb10:  // pred: ^bb6
      %159 = llhd.prb %load_cnt : i32
      %160 = comb.icmp eq %159, %c0_i32 : i32
      cf.cond_br %160, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      llhd.drv %pwm_cnt, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      %161 = llhd.prb %inc_flag : i1
      cf.cond_br %161, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      %162 = llhd.prb %pwm_cnt : i32
      %163 = comb.add %162, %c1_i32 : i32
      llhd.drv %pwm_cnt, %163 after %0 : i32
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      %164 = llhd.prb %pwm_cnt : i32
      %165 = comb.add %164, %c-1_i32 : i32
      llhd.drv %pwm_cnt, %165 after %0 : i32
      cf.br ^bb1
    ^bb15:  // pred: ^bb5
      %166 = llhd.prb %cap_en_0 : i1
      cf.cond_br %166, ^bb16, ^bb22
    ^bb16:  // pred: ^bb15
      %167 = llhd.prb %cap_mode_2 : i1
      cf.cond_br %167, ^bb17, ^bb21
    ^bb17:  // pred: ^bb16
      %168 = llhd.prb %pwm_cnt : i32
      %169 = llhd.prb %cap_load_value_1 : i32
      %170 = comb.icmp eq %168, %169 : i32
      %171 = llhd.prb %cap_edge : i1
      %172 = comb.and %170, %171 : i1
      cf.cond_br %172, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      llhd.drv %pwm_cnt, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb19:  // pred: ^bb17
      %173 = llhd.prb %cap_edge : i1
      cf.cond_br %173, ^bb20, ^bb1
    ^bb20:  // pred: ^bb19
      %174 = llhd.prb %pwm_cnt : i32
      %175 = comb.add %174, %c1_i32 : i32
      llhd.drv %pwm_cnt, %175 after %0 : i32
      cf.br ^bb1
    ^bb21:  // pred: ^bb16
      %176 = llhd.prb %pwm_cnt : i32
      %177 = comb.add %176, %c1_i32 : i32
      llhd.drv %pwm_cnt, %177 after %0 : i32
      cf.br ^bb1
    ^bb22:  // pred: ^bb15
      %178 = llhd.prb %tim_en_32 : i1
      cf.cond_br %178, ^bb23, ^bb26
    ^bb23:  // pred: ^bb22
      %179 = llhd.prb %pwm_cnt : i32
      %180 = llhd.prb %tim_load_value_33 : i32
      %181 = comb.icmp eq %179, %180 : i32
      cf.cond_br %181, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      llhd.drv %pwm_cnt, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb25:  // pred: ^bb23
      %182 = llhd.prb %pwm_cnt : i32
      %183 = comb.add %182, %c1_i32 : i32
      llhd.drv %pwm_cnt, %183 after %0 : i32
      cf.br ^bb1
    ^bb26:  // pred: ^bb22
      llhd.drv %pwm_cnt, %c0_i32 after %0 : i32
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %140 = llhd.prb %clk_4 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %clk_4 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cap_cnt, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %cap_edge : i1
      cf.cond_br %151, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %152 = llhd.prb %pwm_cnt : i32
      llhd.drv %cap_cnt, %152 after %0 : i32
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %140 = llhd.prb %clk_4 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %clk_4 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i_capture_d, %false after %0 : i1
      llhd.drv %i_capture_d2, %false after %0 : i1
      llhd.drv %i_capture_d3, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %i_capture_8 : i1
      llhd.drv %i_capture_d, %151 after %0 : i1
      %152 = llhd.prb %i_capture_d : i1
      llhd.drv %i_capture_d2, %152 after %0 : i1
      %153 = llhd.prb %i_capture_d2 : i1
      llhd.drv %i_capture_d3, %153 after %0 : i1
      cf.br ^bb1
    }
    %6 = llhd.prb %i_capture_d2 : i1
    %7 = llhd.prb %i_capture_d3 : i1
    %8 = comb.xor %7, %true : i1
    %9 = comb.and %6, %8 : i1
    llhd.drv %i_capture_rise_edge, %9 after %1 : i1
    %10 = comb.xor %6, %true : i1
    %11 = comb.and %10, %7 : i1
    llhd.drv %i_capture_fall_edge, %11 after %1 : i1
    %12 = llhd.prb %cap_select_3 : i2
    %13 = llhd.prb %i_capture_rise_edge : i1
    %14 = llhd.prb %cap_edge : i1
    %15 = llhd.prb %i_capture_fall_edge : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb8
      %140 = llhd.prb %cap_select_3 : i2
      %141 = comb.icmp ceq %140, %c0_i2 : i2
      cf.cond_br %141, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %i_capture_rise_edge : i1
      llhd.drv %cap_edge, %142 after %1 : i1
      cf.br ^bb8
    ^bb3:  // pred: ^bb1
      %143 = comb.icmp ceq %140, %c1_i2 : i2
      cf.cond_br %143, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %144 = llhd.prb %i_capture_fall_edge : i1
      llhd.drv %cap_edge, %144 after %1 : i1
      cf.br ^bb8
    ^bb5:  // pred: ^bb3
      %145 = comb.icmp ceq %140, %c-1_i2 : i2
      cf.cond_br %145, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %146 = llhd.prb %i_capture_rise_edge : i1
      %147 = llhd.prb %i_capture_fall_edge : i1
      %148 = comb.or %146, %147 : i1
      llhd.drv %cap_edge, %148 after %1 : i1
      cf.br ^bb8
    ^bb7:  // pred: ^bb5
      llhd.drv %cap_edge, %false after %1 : i1
      cf.br ^bb8
    ^bb8:  // 4 preds: ^bb2, ^bb4, ^bb6, ^bb7
      llhd.wait (%12, %13, %14, %15 : i2, i1, i1, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %140 = llhd.prb %clk_4 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %clk_4 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %inc_flag, %true after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %pwm_en : i1
      %152 = comb.xor %151, %true : i1
      cf.cond_br %152, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %inc_flag, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %153 = llhd.prb %pwm_mode_29 : i1
      %154 = llhd.prb %pwm_cnt : i32
      %155 = llhd.prb %load_cnt : i32
      %156 = comb.add %155, %c-1_i32 : i32
      %157 = comb.icmp eq %154, %156 : i32
      %158 = comb.and %153, %157 : i1
      cf.cond_br %158, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %inc_flag, %false after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %159 = llhd.prb %pwm_mode_29 : i1
      %160 = llhd.prb %inc_flag : i1
      %161 = comb.xor %160, %true : i1
      %162 = llhd.prb %pwm_cnt : i32
      %163 = comb.icmp eq %162, %c1_i32 : i32
      %164 = comb.and %159, %161, %163 : i1
      cf.cond_br %164, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      llhd.drv %inc_flag, %true after %0 : i1
      cf.br ^bb1
    }
    %16 = llhd.prb %sync_mode_31 : i2
    %17 = llhd.prb %zero_flag : i1
    %18 = llhd.prb %updatereg : i1
    %19 = llhd.prb %load_flag : i1
    %20 = llhd.prb %end_flag : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb8
      %140 = llhd.prb %sync_mode_31 : i2
      %141 = comb.icmp ceq %140, %c0_i2 : i2
      cf.cond_br %141, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %zero_flag : i1
      llhd.drv %updatereg, %142 after %1 : i1
      cf.br ^bb8
    ^bb3:  // pred: ^bb1
      %143 = comb.icmp ceq %140, %c1_i2 : i2
      cf.cond_br %143, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %144 = llhd.prb %load_flag : i1
      llhd.drv %updatereg, %144 after %1 : i1
      cf.br ^bb8
    ^bb5:  // pred: ^bb3
      %145 = comb.icmp ceq %140, %c-2_i2 : i2
      cf.cond_br %145, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %146 = llhd.prb %zero_flag : i1
      %147 = llhd.prb %load_flag : i1
      %148 = comb.or %146, %147 : i1
      llhd.drv %updatereg, %148 after %1 : i1
      cf.br ^bb8
    ^bb7:  // pred: ^bb5
      %149 = llhd.prb %end_flag : i1
      llhd.drv %updatereg, %149 after %1 : i1
      cf.br ^bb8
    ^bb8:  // 4 preds: ^bb2, ^bb4, ^bb6, ^bb7
      llhd.wait (%16, %17, %18, %19, %20 : i2, i1, i1, i1, i1), ^bb1
    }
    %21 = llhd.prb %pwm_en : i1
    %22 = llhd.prb %tim_en_32 : i1
    %23 = llhd.prb %cap_en_0 : i1
    %24 = comb.and %23, %14 : i1
    %25 = comb.or %21, %22, %24 {sv.namehint = "flag"} : i1
    %26 = llhd.prb %pwm_cnt : i32
    %27 = comb.icmp eq %26, %c0_i32 : i32
    %28 = comb.and %25, %27 : i1
    llhd.drv %zero_flag, %28 after %1 : i1
    %29 = llhd.prb %load_cnt : i32
    %30 = comb.icmp eq %26, %29 : i32
    %31 = comb.and %25, %30 : i1
    llhd.drv %load_flag, %31 after %1 : i1
    %32 = llhd.prb %pwm_mode_29 : i1
    %33 = comb.and %21, %32 : i1
    %34 = llhd.prb %inc_flag : i1
    %35 = comb.xor %34, %true : i1
    %36 = comb.icmp eq %26, %c1_i32 : i32
    %37 = comb.and %35, %36 : i1
    %38 = comb.mux %33, %37, %19 : i1
    llhd.drv %end_flag, %38 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %140 = llhd.prb %clk_4 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %clk_4 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %load_cnt, %c-1_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %updatereg : i1
      %152 = llhd.prb %pwm_en : i1
      %153 = comb.xor %152, %true : i1
      %154 = comb.or %151, %153 : i1
      cf.cond_br %154, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %155 = llhd.prb %pwm_load_value_28 : i32
      llhd.drv %load_cnt, %155 after %0 : i32
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %140 = llhd.prb %clk_4 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %clk_4 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %compa, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %updatereg : i1
      %152 = llhd.prb %pwm_en : i1
      %153 = comb.xor %152, %true : i1
      %154 = comb.or %151, %153 : i1
      cf.cond_br %154, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %155 = llhd.prb %compa_val_5 : i32
      llhd.drv %compa, %155 after %0 : i32
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %140 = llhd.prb %clk_4 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %clk_4 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %compb, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %updatereg : i1
      %152 = llhd.prb %pwm_en : i1
      %153 = comb.xor %152, %true : i1
      %154 = comb.or %151, %153 : i1
      cf.cond_br %154, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %155 = llhd.prb %compb_val_6 : i32
      llhd.drv %compb, %155 after %0 : i32
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %140 = llhd.prb %clk_4 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %clk_4 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %trigval, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %updatereg : i1
      %152 = llhd.prb %pwm_en : i1
      %153 = comb.xor %152, %true : i1
      %154 = comb.or %151, %153 : i1
      cf.cond_br %154, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %155 = llhd.prb %trig_val_34 : i32
      llhd.drv %trigval, %155 after %0 : i32
      cf.br ^bb1
    }
    %39 = llhd.prb %compa : i32
    %40 = comb.icmp uge %26, %39 : i32
    %41 = comb.and %34, %40 : i1
    %42 = comb.icmp ugt %26, %39 : i32
    %43 = comb.and %35, %42 : i1
    %44 = comb.or %41, %43 : i1
    %45 = comb.and %pwm0_en, %44 : i1
    llhd.drv %pwm_0, %45 after %1 : i1
    %46 = llhd.prb %compb : i32
    %47 = comb.icmp uge %26, %46 : i32
    %48 = comb.and %34, %47 : i1
    %49 = comb.icmp ugt %26, %46 : i32
    %50 = comb.and %35, %49 : i1
    %51 = comb.or %48, %50 : i1
    %52 = comb.and %pwm1_en, %51 : i1
    llhd.drv %pwm_1, %52 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %140 = llhd.prb %clk_4 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %clk_4 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pwm_0_d, %false after %0 : i1
      llhd.drv %pwm_1_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %pwm_0 : i1
      llhd.drv %pwm_0_d, %151 after %0 : i1
      %152 = llhd.prb %pwm_1 : i1
      llhd.drv %pwm_1_d, %152 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb11
      %140 = llhd.prb %clk_4 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %clk_4 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %deadband_cnt_0, %c0_i12 after %0 : i12
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %pwm_en : i1
      %152 = comb.xor %151, %true : i1
      cf.cond_br %152, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %deadband_cnt_0, %c0_i12 after %0 : i12
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %153 = llhd.prb %pwm_0 : i1
      %154 = llhd.prb %deadband_cnt_0 : i12
      %155 = llhd.prb %deadband_delay_cnt_7 : i12
      %156 = comb.icmp eq %154, %155 : i12
      %157 = comb.and %153, %156 : i1
      cf.cond_br %157, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %deadband_cnt_0, %c0_i12 after %0 : i12
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %158 = llhd.prb %pwm_0 : i1
      cf.cond_br %158, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %159 = llhd.prb %deadband_cnt_0 : i12
      %160 = comb.add %159, %c1_i12 : i12
      llhd.drv %deadband_cnt_0, %160 after %0 : i12
      cf.br ^bb1
    ^bb11:  // pred: ^bb9
      llhd.drv %deadband_cnt_0, %c0_i12 after %0 : i12
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %140 = llhd.prb %clk_4 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %clk_4 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pwm_0_db, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %pwm_en : i1
      %152 = comb.xor %151, %true : i1
      cf.cond_br %152, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %pwm_0_db, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %153 = llhd.prb %pwm_0 : i1
      %154 = comb.xor %153, %true : i1
      %155 = llhd.prb %pwm_0_d : i1
      %156 = comb.and %154, %155 : i1
      cf.cond_br %156, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %pwm_0_db, %false after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %157 = llhd.prb %pwm_0 : i1
      %158 = llhd.prb %deadband_cnt_0 : i12
      %159 = llhd.prb %deadband_delay_cnt_7 : i12
      %160 = comb.icmp eq %158, %159 : i12
      %161 = comb.and %157, %160 : i1
      cf.cond_br %161, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      llhd.drv %pwm_0_db, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb11
      %140 = llhd.prb %clk_4 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %clk_4 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %deadband_cnt_1, %c0_i12 after %0 : i12
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %pwm_en : i1
      %152 = comb.xor %151, %true : i1
      cf.cond_br %152, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %deadband_cnt_1, %c0_i12 after %0 : i12
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %153 = llhd.prb %pwm_0 : i1
      %154 = comb.xor %153, %true : i1
      %155 = llhd.prb %deadband_cnt_1 : i12
      %156 = llhd.prb %deadband_delay_cnt_7 : i12
      %157 = comb.icmp eq %155, %156 : i12
      %158 = comb.and %154, %157 : i1
      cf.cond_br %158, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %deadband_cnt_1, %c0_i12 after %0 : i12
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %159 = llhd.prb %pwm_0 : i1
      %160 = comb.xor %159, %true : i1
      cf.cond_br %160, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %161 = llhd.prb %deadband_cnt_1 : i12
      %162 = comb.add %161, %c1_i12 : i12
      llhd.drv %deadband_cnt_1, %162 after %0 : i12
      cf.br ^bb1
    ^bb11:  // pred: ^bb9
      llhd.drv %deadband_cnt_1, %c0_i12 after %0 : i12
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %140 = llhd.prb %clk_4 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %clk_4 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pwm_1_db, %true after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %pwm_en : i1
      %152 = comb.xor %151, %true : i1
      cf.cond_br %152, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %pwm_1_db, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %153 = llhd.prb %pwm_0 : i1
      %154 = llhd.prb %pwm_0_d : i1
      %155 = comb.xor %154, %true : i1
      %156 = comb.and %153, %155 : i1
      cf.cond_br %156, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %pwm_1_db, %false after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %157 = llhd.prb %pwm_0 : i1
      %158 = comb.xor %157, %true : i1
      %159 = llhd.prb %deadband_cnt_1 : i12
      %160 = llhd.prb %deadband_delay_cnt_7 : i12
      %161 = comb.icmp eq %159, %160 : i12
      %162 = comb.and %158, %161 : i1
      cf.cond_br %162, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      llhd.drv %pwm_1_db, %true after %0 : i1
      cf.br ^bb1
    }
    %53 = llhd.prb %pwm_0_db : i1
    %54 = llhd.prb %pwm_0_d : i1
    %55 = comb.mux %deadband_en, %53, %54 : i1
    llhd.drv %pwm_0_out_pre, %55 after %1 : i1
    %56 = llhd.prb %pwm_1_db : i1
    %57 = llhd.prb %pwm_1_d : i1
    %58 = comb.mux %deadband_en, %56, %57 : i1
    llhd.drv %pwm_1_out_pre, %58 after %1 : i1
    %59 = llhd.prb %pwm_0_out_pre : i1
    %60 = comb.xor %pwm0_inv, %59 : i1
    %61 = llhd.prb %pwm_1_out_pre : i1
    %62 = comb.xor %pwm1_inv, %61 : i1
    %63 = comb.and %21, %17 : i1
    llhd.drv %pwm_cnt_zero, %63 after %1 : i1
    %64 = comb.and %21, %19 : i1
    llhd.drv %pwm_cnt_load, %64 after %1 : i1
    %65 = comb.icmp eq %26, %39 : i32
    %66 = comb.and %21, %65 : i1
    %67 = comb.and %66, %34 : i1
    llhd.drv %compa_up_flag, %67 after %1 : i1
    %68 = comb.and %66, %35 : i1
    llhd.drv %compa_down_flag, %68 after %1 : i1
    %69 = comb.icmp eq %26, %46 : i32
    %70 = comb.and %21, %69 : i1
    %71 = comb.and %70, %34 : i1
    llhd.drv %compb_up_flag, %71 after %1 : i1
    %72 = comb.and %70, %35 : i1
    llhd.drv %compb_down_flag, %72 after %1 : i1
    %73 = comb.and %23, %14 : i1
    %74 = llhd.prb %cap_load_value_1 : i32
    %75 = comb.icmp eq %26, %74 : i32
    %76 = comb.and %73, %75 : i1
    llhd.drv %cap_cnt_match_flag, %76 after %1 : i1
    llhd.drv %cap_cnt_add_flag, %73 after %1 : i1
    %77 = llhd.prb %tim_load_value_33 : i32
    %78 = comb.icmp eq %26, %77 : i32
    %79 = comb.and %22, %78 : i1
    llhd.drv %tim_cnt_match_flag, %79 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %140 = llhd.prb %pclk_27 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %pclk_27 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pwm_cnt_zero_d, %false after %0 : i1
      llhd.drv %pwm_cnt_load_d, %false after %0 : i1
      llhd.drv %compa_up_flag_d, %false after %0 : i1
      llhd.drv %compa_down_flag_d, %false after %0 : i1
      llhd.drv %compb_up_flag_d, %false after %0 : i1
      llhd.drv %compb_down_flag_d, %false after %0 : i1
      llhd.drv %cap_cnt_match_flag_d, %false after %0 : i1
      llhd.drv %cap_cnt_add_flag_d, %false after %0 : i1
      llhd.drv %tim_cnt_match_flag_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %pwm_cnt_zero : i1
      llhd.drv %pwm_cnt_zero_d, %151 after %0 : i1
      %152 = llhd.prb %pwm_cnt_load : i1
      llhd.drv %pwm_cnt_load_d, %152 after %0 : i1
      %153 = llhd.prb %compa_up_flag : i1
      llhd.drv %compa_up_flag_d, %153 after %0 : i1
      %154 = llhd.prb %compa_down_flag : i1
      llhd.drv %compa_down_flag_d, %154 after %0 : i1
      %155 = llhd.prb %compb_up_flag : i1
      llhd.drv %compb_up_flag_d, %155 after %0 : i1
      %156 = llhd.prb %compb_down_flag : i1
      llhd.drv %compb_down_flag_d, %156 after %0 : i1
      %157 = llhd.prb %cap_cnt_match_flag : i1
      llhd.drv %cap_cnt_match_flag_d, %157 after %0 : i1
      %158 = llhd.prb %cap_cnt_add_flag : i1
      llhd.drv %cap_cnt_add_flag_d, %158 after %0 : i1
      %159 = llhd.prb %tim_cnt_match_flag : i1
      llhd.drv %tim_cnt_match_flag_d, %159 after %0 : i1
      cf.br ^bb1
    }
    %80 = llhd.prb %pwm_cnt_zero : i1
    %81 = comb.xor %80, %true : i1
    %82 = llhd.prb %pwm_cnt_zero_d : i1
    %83 = comb.and %81, %82 : i1
    llhd.drv %pwm_cnt_zero_divedge, %83 after %1 : i1
    %84 = llhd.prb %pwm_cnt_load : i1
    %85 = comb.xor %84, %true : i1
    %86 = llhd.prb %pwm_cnt_load_d : i1
    %87 = comb.and %85, %86 : i1
    llhd.drv %pwm_cnt_load_divedge, %87 after %1 : i1
    %88 = llhd.prb %compa_up_flag : i1
    %89 = comb.xor %88, %true : i1
    %90 = llhd.prb %compa_up_flag_d : i1
    %91 = comb.and %89, %90 : i1
    llhd.drv %compa_up_flag_divedge, %91 after %1 : i1
    %92 = llhd.prb %compa_down_flag : i1
    %93 = comb.xor %92, %true : i1
    %94 = llhd.prb %compa_down_flag_d : i1
    %95 = comb.and %93, %94 : i1
    llhd.drv %compa_down_flag_divedge, %95 after %1 : i1
    %96 = llhd.prb %compb_up_flag : i1
    %97 = comb.xor %96, %true : i1
    %98 = llhd.prb %compb_up_flag_d : i1
    %99 = comb.and %97, %98 : i1
    llhd.drv %compb_up_flag_divedge, %99 after %1 : i1
    %100 = llhd.prb %compb_down_flag : i1
    %101 = comb.xor %100, %true : i1
    %102 = llhd.prb %compb_down_flag_d : i1
    %103 = comb.and %101, %102 : i1
    llhd.drv %compb_down_flag_divedge, %103 after %1 : i1
    %104 = llhd.prb %cap_cnt_match_flag : i1
    %105 = llhd.prb %cap_cnt_match_flag_d : i1
    %106 = comb.xor %105, %true : i1
    %107 = comb.and %104, %106 : i1
    llhd.drv %cap_cnt_match_flag_divedge, %107 after %1 : i1
    %108 = llhd.prb %cap_cnt_add_flag : i1
    %109 = comb.xor %108, %true : i1
    %110 = llhd.prb %cap_cnt_add_flag_d : i1
    %111 = comb.and %109, %110 : i1
    llhd.drv %cap_cnt_add_flag_divedge, %111 after %1 : i1
    %112 = llhd.prb %tim_cnt_match_flag : i1
    %113 = comb.xor %112, %true : i1
    %114 = llhd.prb %tim_cnt_match_flag_d : i1
    %115 = comb.and %113, %114 : i1
    llhd.drv %tim_cnt_match_flag_divedge, %115 after %1 : i1
    %116 = llhd.prb %tim_cnt_match_flag_divedge : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %140 = llhd.prb %pclk_27 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %pclk_27 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm_cnt_zero, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %int_clr_pwm_cnt_zero_12 : i1
      cf.cond_br %151, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %int_pwm_cnt_zero, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %152 = llhd.prb %pwm_cnt_zero_divedge : i1
      %153 = llhd.prb %int_en_pwm_cnt_zero_21 : i1
      %154 = comb.and %152, %153 : i1
      cf.cond_br %154, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %int_pwm_cnt_zero, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %140 = llhd.prb %pclk_27 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %pclk_27 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm_cnt_load, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %int_clr_pwm_cnt_load_11 : i1
      cf.cond_br %151, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %int_pwm_cnt_load, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %152 = llhd.prb %pwm_cnt_load_divedge : i1
      %153 = llhd.prb %int_en_pwm_cnt_load_20 : i1
      %154 = comb.and %152, %153 : i1
      cf.cond_br %154, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %int_pwm_cnt_load, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %140 = llhd.prb %pclk_27 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %pclk_27 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm_compa_up, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %int_clr_pwm_compa_up_14 : i1
      cf.cond_br %151, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %int_pwm_compa_up, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %152 = llhd.prb %compa_up_flag_divedge : i1
      %153 = llhd.prb %int_en_pwm_compa_up_23 : i1
      %154 = comb.and %152, %153 : i1
      cf.cond_br %154, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %int_pwm_compa_up, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %140 = llhd.prb %pclk_27 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %pclk_27 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm_compa_down, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %int_clr_pwm_compa_down_13 : i1
      cf.cond_br %151, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %int_pwm_compa_down, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %152 = llhd.prb %compa_down_flag_divedge : i1
      %153 = llhd.prb %int_en_pwm_compa_down_22 : i1
      %154 = comb.and %152, %153 : i1
      cf.cond_br %154, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %int_pwm_compa_down, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %140 = llhd.prb %pclk_27 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %pclk_27 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm_compb_up, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %int_clr_pwm_compb_up_16 : i1
      cf.cond_br %151, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %int_pwm_compb_up, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %152 = llhd.prb %compb_up_flag_divedge : i1
      %153 = llhd.prb %int_en_pwm_compb_up_25 : i1
      %154 = comb.and %152, %153 : i1
      cf.cond_br %154, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %int_pwm_compb_up, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %140 = llhd.prb %pclk_27 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %pclk_27 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_pwm_compb_down, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %int_clr_pwm_compb_down_15 : i1
      cf.cond_br %151, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %int_pwm_compb_down, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %152 = llhd.prb %compb_down_flag_divedge : i1
      %153 = llhd.prb %int_en_pwm_compb_down_24 : i1
      %154 = comb.and %152, %153 : i1
      cf.cond_br %154, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %int_pwm_compb_down, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %140 = llhd.prb %pclk_27 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %pclk_27 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_cap_cnt_match, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %int_clr_cap_cnt_match_10 : i1
      cf.cond_br %151, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %int_cap_cnt_match, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %152 = llhd.prb %cap_cnt_match_flag_divedge : i1
      %153 = llhd.prb %int_en_cap_cnt_match_19 : i1
      %154 = comb.and %152, %153 : i1
      cf.cond_br %154, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %int_cap_cnt_match, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %140 = llhd.prb %pclk_27 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %pclk_27 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_cap_cnt_add, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %int_clr_cap_cnt_add_9 : i1
      cf.cond_br %151, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %int_cap_cnt_add, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %152 = llhd.prb %cap_cnt_add_flag_divedge : i1
      %153 = llhd.prb %int_en_cap_cnt_add_18 : i1
      %154 = comb.and %152, %153 : i1
      cf.cond_br %154, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %int_cap_cnt_add, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %140 = llhd.prb %pclk_27 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %pclk_27 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_tim_cnt_match, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %int_clr_tim_cnt_match_17 : i1
      cf.cond_br %151, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %int_tim_cnt_match, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %152 = llhd.prb %tim_cnt_match_flag_divedge : i1
      %153 = llhd.prb %int_en_tim_cnt_match_26 : i1
      %154 = comb.and %152, %153 : i1
      cf.cond_br %154, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %int_tim_cnt_match, %true after %0 : i1
      cf.br ^bb1
    }
    %117 = llhd.prb %trigval : i32
    %118 = comb.icmp eq %26, %117 : i32
    %119 = comb.and %34, %118, %25 : i1
    llhd.drv %trigger_up, %119 after %1 : i1
    %120 = comb.and %35, %118, %25 : i1
    llhd.drv %trigger_down, %120 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %140 = llhd.prb %pclk_27 : i1
      %141 = llhd.prb %rstn_30 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %142 = llhd.prb %pclk_27 : i1
      %143 = comb.xor bin %140, %true : i1
      %144 = comb.and bin %143, %142 : i1
      %145 = llhd.prb %rstn_30 : i1
      %146 = comb.xor bin %145, %true : i1
      %147 = comb.and bin %141, %146 : i1
      %148 = comb.or bin %144, %147 : i1
      cf.cond_br %148, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %149 = llhd.prb %rstn_30 : i1
      %150 = comb.xor %149, %true : i1
      cf.cond_br %150, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %trigger_up_d, %false after %0 : i1
      llhd.drv %trigger_down_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %151 = llhd.prb %trigger_up : i1
      llhd.drv %trigger_up_d, %151 after %0 : i1
      %152 = llhd.prb %trigger_down : i1
      llhd.drv %trigger_down_d, %152 after %0 : i1
      cf.br ^bb1
    }
    %121 = llhd.prb %trigger_up : i1
    %122 = comb.xor %121, %true : i1
    %123 = llhd.prb %trigger_up_d : i1
    %124 = comb.and %122, %123, %trenu : i1
    %125 = llhd.prb %trigger_down : i1
    %126 = comb.xor %125, %true : i1
    %127 = llhd.prb %trigger_down_d : i1
    %128 = comb.and %126, %127, %trend : i1
    %129 = comb.or %124, %128 : i1
    %130 = llhd.prb %cap_cnt : i32
    llhd.drv %cap_en_0, %cap_en after %1 : i1
    llhd.drv %cap_load_value_1, %cap_load_value after %1 : i32
    llhd.drv %cap_mode_2, %cap_mode after %1 : i1
    llhd.drv %cap_select_3, %cap_select after %1 : i2
    llhd.drv %clk_4, %clk after %1 : i1
    llhd.drv %compa_val_5, %compa_val after %1 : i32
    llhd.drv %compb_val_6, %compb_val after %1 : i32
    llhd.drv %deadband_delay_cnt_7, %deadband_delay_cnt after %1 : i12
    llhd.drv %i_capture_8, %i_capture after %1 : i1
    %131 = llhd.prb %int_cap_cnt_add : i1
    %132 = llhd.prb %int_cap_cnt_match : i1
    llhd.drv %int_clr_cap_cnt_add_9, %int_clr_cap_cnt_add after %1 : i1
    llhd.drv %int_clr_cap_cnt_match_10, %int_clr_cap_cnt_match after %1 : i1
    llhd.drv %int_clr_pwm_cnt_load_11, %int_clr_pwm_cnt_load after %1 : i1
    llhd.drv %int_clr_pwm_cnt_zero_12, %int_clr_pwm_cnt_zero after %1 : i1
    llhd.drv %int_clr_pwm_compa_down_13, %int_clr_pwm_compa_down after %1 : i1
    llhd.drv %int_clr_pwm_compa_up_14, %int_clr_pwm_compa_up after %1 : i1
    llhd.drv %int_clr_pwm_compb_down_15, %int_clr_pwm_compb_down after %1 : i1
    llhd.drv %int_clr_pwm_compb_up_16, %int_clr_pwm_compb_up after %1 : i1
    llhd.drv %int_clr_tim_cnt_match_17, %int_clr_tim_cnt_match after %1 : i1
    llhd.drv %int_en_cap_cnt_add_18, %int_en_cap_cnt_add after %1 : i1
    llhd.drv %int_en_cap_cnt_match_19, %int_en_cap_cnt_match after %1 : i1
    llhd.drv %int_en_pwm_cnt_load_20, %int_en_pwm_cnt_load after %1 : i1
    llhd.drv %int_en_pwm_cnt_zero_21, %int_en_pwm_cnt_zero after %1 : i1
    llhd.drv %int_en_pwm_compa_down_22, %int_en_pwm_compa_down after %1 : i1
    llhd.drv %int_en_pwm_compa_up_23, %int_en_pwm_compa_up after %1 : i1
    llhd.drv %int_en_pwm_compb_down_24, %int_en_pwm_compb_down after %1 : i1
    llhd.drv %int_en_pwm_compb_up_25, %int_en_pwm_compb_up after %1 : i1
    llhd.drv %int_en_tim_cnt_match_26, %int_en_tim_cnt_match after %1 : i1
    %133 = llhd.prb %int_pwm_cnt_load : i1
    %134 = llhd.prb %int_pwm_cnt_zero : i1
    %135 = llhd.prb %int_pwm_compa_down : i1
    %136 = llhd.prb %int_pwm_compa_up : i1
    %137 = llhd.prb %int_pwm_compb_down : i1
    %138 = llhd.prb %int_pwm_compb_up : i1
    %139 = llhd.prb %int_tim_cnt_match : i1
    llhd.drv %pclk_27, %pclk after %1 : i1
    llhd.drv %pwm_load_value_28, %pwm_load_value after %1 : i32
    llhd.drv %pwm_mode_29, %pwm_mode after %1 : i1
    llhd.drv %rstn_30, %rstn after %1 : i1
    llhd.drv %sync_mode_31, %sync_mode after %1 : i2
    llhd.drv %tim_en_32, %tim_en after %1 : i1
    llhd.drv %tim_load_value_33, %tim_load_value after %1 : i32
    llhd.drv %trig_val_34, %trig_val after %1 : i32
    hw.output %130, %131, %132, %133, %134, %135, %136, %137, %138, %139, %pwm0_en, %60, %pwm1_en, %62, %26, %116, %129 : i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i32, i1, i1
  }
  hw.module @pwm_sec_top(in %etb_pwm_trig_tim0_off : i1, in %etb_pwm_trig_tim0_on : i1, in %etb_pwm_trig_tim1_off : i1, in %etb_pwm_trig_tim1_on : i1, in %etb_pwm_trig_tim2_off : i1, in %etb_pwm_trig_tim2_on : i1, in %etb_pwm_trig_tim3_off : i1, in %etb_pwm_trig_tim3_on : i1, in %etb_pwm_trig_tim4_off : i1, in %etb_pwm_trig_tim4_on : i1, in %etb_pwm_trig_tim5_off : i1, in %etb_pwm_trig_tim5_on : i1, in %fault : i1, in %i_capedge0 : i1, in %i_capedge10 : i1, in %i_capedge2 : i1, in %i_capedge4 : i1, in %i_capedge6 : i1, in %i_capedge8 : i1, out o_pwm0 : i1, out o_pwm1 : i1, out o_pwm10 : i1, out o_pwm11 : i1, out o_pwm2 : i1, out o_pwm3 : i1, out o_pwm4 : i1, out o_pwm5 : i1, out o_pwm6 : i1, out o_pwm7 : i1, out o_pwm8 : i1, out o_pwm9 : i1, in %paddr : i32, in %pclk : i1, in %penable : i1, in %pprot : i3, out prdata : i32, in %presetn : i1, in %psel : i1, in %pwdata : i32, out pwm0oe_n : i1, out pwm10oe_n : i1, out pwm11oe_n : i1, out pwm1oe_n : i1, out pwm2oe_n : i1, out pwm3oe_n : i1, out pwm4oe_n : i1, out pwm5oe_n : i1, out pwm6oe_n : i1, out pwm7oe_n : i1, out pwm8oe_n : i1, out pwm9oe_n : i1, out pwm_idle : i1, out pwm_tim0_etb_trig : i1, out pwm_tim1_etb_trig : i1, out pwm_tim2_etb_trig : i1, out pwm_tim3_etb_trig : i1, out pwm_tim4_etb_trig : i1, out pwm_tim5_etb_trig : i1, out pwm_xx_trig : i1, out pwmint : i1, in %pwrite : i1, in %test_mode : i1, in %tipc_pwm_trust : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %prdata = llhd.sig %c0_i32 : i32
    %x_pwm.o_pwm0, %x_pwm.o_pwm1, %x_pwm.o_pwm10, %x_pwm.o_pwm11, %x_pwm.o_pwm2, %x_pwm.o_pwm3, %x_pwm.o_pwm4, %x_pwm.o_pwm5, %x_pwm.o_pwm6, %x_pwm.o_pwm7, %x_pwm.o_pwm8, %x_pwm.o_pwm9, %x_pwm.prdata, %x_pwm.pwm0oe_n, %x_pwm.pwm10oe_n, %x_pwm.pwm11oe_n, %x_pwm.pwm1oe_n, %x_pwm.pwm2oe_n, %x_pwm.pwm3oe_n, %x_pwm.pwm4oe_n, %x_pwm.pwm5oe_n, %x_pwm.pwm6oe_n, %x_pwm.pwm7oe_n, %x_pwm.pwm8oe_n, %x_pwm.pwm9oe_n, %x_pwm.pwm_idle, %x_pwm.pwm_tim0_etb_trig, %x_pwm.pwm_tim1_etb_trig, %x_pwm.pwm_tim2_etb_trig, %x_pwm.pwm_tim3_etb_trig, %x_pwm.pwm_tim4_etb_trig, %x_pwm.pwm_tim5_etb_trig, %x_pwm.pwm_xx_trig, %x_pwm.pwmint = hw.instance "x_pwm" @pwm(etb_pwm_trig_tim0_off: %etb_pwm_trig_tim0_off: i1, etb_pwm_trig_tim0_on: %etb_pwm_trig_tim0_on: i1, etb_pwm_trig_tim1_off: %etb_pwm_trig_tim1_off: i1, etb_pwm_trig_tim1_on: %etb_pwm_trig_tim1_on: i1, etb_pwm_trig_tim2_off: %etb_pwm_trig_tim2_off: i1, etb_pwm_trig_tim2_on: %etb_pwm_trig_tim2_on: i1, etb_pwm_trig_tim3_off: %etb_pwm_trig_tim3_off: i1, etb_pwm_trig_tim3_on: %etb_pwm_trig_tim3_on: i1, etb_pwm_trig_tim4_off: %etb_pwm_trig_tim4_off: i1, etb_pwm_trig_tim4_on: %etb_pwm_trig_tim4_on: i1, etb_pwm_trig_tim5_off: %etb_pwm_trig_tim5_off: i1, etb_pwm_trig_tim5_on: %etb_pwm_trig_tim5_on: i1, fault: %fault: i1, i_capedge0: %i_capedge0: i1, i_capedge10: %i_capedge10: i1, i_capedge2: %i_capedge2: i1, i_capedge4: %i_capedge4: i1, i_capedge6: %i_capedge6: i1, i_capedge8: %i_capedge8: i1, paddr: %paddr: i32, pclk: %pclk: i1, penable: %penable: i1, presetn: %presetn: i1, psel: %psel: i1, pwdata: %pwdata: i32, pwrite: %pwrite: i1, test_mode: %test_mode: i1) -> (o_pwm0: i1, o_pwm1: i1, o_pwm10: i1, o_pwm11: i1, o_pwm2: i1, o_pwm3: i1, o_pwm4: i1, o_pwm5: i1, o_pwm6: i1, o_pwm7: i1, o_pwm8: i1, o_pwm9: i1, prdata: i32, pwm0oe_n: i1, pwm10oe_n: i1, pwm11oe_n: i1, pwm1oe_n: i1, pwm2oe_n: i1, pwm3oe_n: i1, pwm4oe_n: i1, pwm5oe_n: i1, pwm6oe_n: i1, pwm7oe_n: i1, pwm8oe_n: i1, pwm9oe_n: i1, pwm_idle: i1, pwm_tim0_etb_trig: i1, pwm_tim1_etb_trig: i1, pwm_tim2_etb_trig: i1, pwm_tim3_etb_trig: i1, pwm_tim4_etb_trig: i1, pwm_tim5_etb_trig: i1, pwm_xx_trig: i1, pwmint: i1) {sv.namehint = "i_prdata"}
    llhd.drv %prdata, %x_pwm.prdata after %0 : i32
    %1 = llhd.prb %prdata : i32
    hw.output %x_pwm.o_pwm0, %x_pwm.o_pwm1, %x_pwm.o_pwm10, %x_pwm.o_pwm11, %x_pwm.o_pwm2, %x_pwm.o_pwm3, %x_pwm.o_pwm4, %x_pwm.o_pwm5, %x_pwm.o_pwm6, %x_pwm.o_pwm7, %x_pwm.o_pwm8, %x_pwm.o_pwm9, %1, %x_pwm.pwm0oe_n, %x_pwm.pwm10oe_n, %x_pwm.pwm11oe_n, %x_pwm.pwm1oe_n, %x_pwm.pwm2oe_n, %x_pwm.pwm3oe_n, %x_pwm.pwm4oe_n, %x_pwm.pwm5oe_n, %x_pwm.pwm6oe_n, %x_pwm.pwm7oe_n, %x_pwm.pwm8oe_n, %x_pwm.pwm9oe_n, %x_pwm.pwm_idle, %x_pwm.pwm_tim0_etb_trig, %x_pwm.pwm_tim1_etb_trig, %x_pwm.pwm_tim2_etb_trig, %x_pwm.pwm_tim3_etb_trig, %x_pwm.pwm_tim4_etb_trig, %x_pwm.pwm_tim5_etb_trig, %x_pwm.pwm_xx_trig, %x_pwm.pwmint : i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1
  }
}
