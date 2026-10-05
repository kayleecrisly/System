module {
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
  hw.module @rtc0_sec_top(in %aortc_paddr : i32, in %aortc_pclk : i1, in %aortc_penable : i1, in %aortc_pprot : i3, out aortc_prdata : i32, in %aortc_psel : i1, in %aortc_pwdata : i32, in %aortc_pwrite : i1, in %aortc_rst_n : i1, in %etb_rtc_trig : i1, in %i_rtc_ext_clk : i1, out rtc0_vic_intr : i1, out rtc_etb_trig : i1, in %test_mode : i1, in %tipc_rtc0_trust : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %aortc_prdata = llhd.sig %c0_i32 : i32
    %w_prdata = llhd.sig %c0_i32 : i32
    %x_rtc_pdu_top.pdu_aou_clr_reg, %x_rtc_pdu_top.pdu_aou_int_clr, %x_rtc_pdu_top.pdu_aou_wen_clr_sync, %x_rtc_pdu_top.pdu_aou_wen_cr, %x_rtc_pdu_top.pdu_aou_wen_div, %x_rtc_pdu_top.pdu_aou_wen_mr, %x_rtc_pdu_top.prdata = hw.instance "x_rtc_pdu_top" @rtc_pdu_top(aou_pdu_cnt: %x_rtc_aou_top.aou_pdu_cnt: i32, aou_pdu_cr_reg: %x_rtc_aou_top.aou_pdu_cr_reg: i4, aou_pdu_div_reg: %x_rtc_aou_top.aou_pdu_div_reg: i20, aou_pdu_intr_mask: %x_rtc_aou_top.aou_pdu_intr_mask: i1, aou_pdu_mr_reg: %x_rtc_aou_top.aou_pdu_mr_reg: i32, int_flag: %x_rtc_aou_top.int_flag: i1, paddr: %aortc_paddr: i32, pclk: %aortc_pclk: i1, penable: %aortc_penable: i1, presetn: %aortc_rst_n: i1, psel: %aortc_psel: i1, pwdata: %aortc_pwdata: i32, pwrite: %aortc_pwrite: i1, rtc_clk: %x_rtc_aou_top.rtc_clk: i1, test_mode: %test_mode: i1) -> (pdu_aou_clr_reg: i32, pdu_aou_int_clr: i1, pdu_aou_wen_clr_sync: i1, pdu_aou_wen_cr: i1, pdu_aou_wen_div: i1, pdu_aou_wen_mr: i1, prdata: i32) {sv.namehint = "pdu_aou_wen_mr"}
    llhd.drv %w_prdata, %x_rtc_pdu_top.prdata after %0 : i32
    %x_rtc_aou_top.aou_pdu_cnt, %x_rtc_aou_top.aou_pdu_cr_reg, %x_rtc_aou_top.aou_pdu_div_reg, %x_rtc_aou_top.aou_pdu_intr_mask, %x_rtc_aou_top.aou_pdu_mr_reg, %x_rtc_aou_top.int_flag, %x_rtc_aou_top.rtc0_vic_intr, %x_rtc_aou_top.rtc_clk, %x_rtc_aou_top.rtc_etb_trig = hw.instance "x_rtc_aou_top" @rtc_aou_top(etb_rtc_trig: %etb_rtc_trig: i1, i_rtc_ext_clk: %i_rtc_ext_clk: i1, pclk: %aortc_pclk: i1, pdu_aou_clr_reg: %x_rtc_pdu_top.pdu_aou_clr_reg: i32, pdu_aou_int_clr: %x_rtc_pdu_top.pdu_aou_int_clr: i1, pdu_aou_pwdata: %aortc_pwdata: i32, pdu_aou_wen_clr_sync: %x_rtc_pdu_top.pdu_aou_wen_clr_sync: i1, pdu_aou_wen_cr: %x_rtc_pdu_top.pdu_aou_wen_cr: i1, pdu_aou_wen_div: %x_rtc_pdu_top.pdu_aou_wen_div: i1, pdu_aou_wen_mr: %x_rtc_pdu_top.pdu_aou_wen_mr: i1, rtc_por_rst_n: %aortc_rst_n: i1, test_mode: %test_mode: i1) -> (aou_pdu_cnt: i32, aou_pdu_cr_reg: i4, aou_pdu_div_reg: i20, aou_pdu_intr_mask: i1, aou_pdu_mr_reg: i32, int_flag: i1, rtc0_vic_intr: i1, rtc_clk: i1, rtc_etb_trig: i1) {sv.namehint = "rtc_clk"}
    %1 = llhd.prb %w_prdata : i32
    llhd.drv %aortc_prdata, %1 after %0 : i32
    %2 = llhd.prb %aortc_prdata : i32
    hw.output %2, %x_rtc_aou_top.rtc0_vic_intr, %x_rtc_aou_top.rtc_etb_trig : i32, i1, i1
  }
  hw.module private @rtc_aou_apbif(out aou_pdu_cr_reg : i4, out aou_pdu_div_reg : i20, out aou_pdu_intr_mask : i1, out aou_pdu_mr_reg : i32, out cnt_en : i1, in %etb_rtc_trig : i1, out intr_en : i1, out intr_mask : i1, out match_val : i32, in %pclk : i1, in %pdu_aou_wen_cr : i1, in %pdu_aou_wen_div : i1, in %pdu_aou_wen_mr : i1, in %presetn : i1, in %pwdata : i32, out rtcclkdivcfg : i20, in %test_mode : i1, out wrap_en : i1) {
    %c-2_i2 = hw.constant -2 : i2
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i20 = hw.constant 0 : i20
    %c1_i20 = hw.constant 1 : i20
    %true = hw.constant true
    %c0_i4 = hw.constant 0 : i4
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %cr_reg = llhd.sig %c0_i4 : i4
    %div_reg = llhd.sig %c0_i20 : i20
    %mr_reg = llhd.sig %c0_i32 : i32
    %aou_pdu_cr_reg = llhd.sig %c0_i4 : i4
    %aou_pdu_div_reg = llhd.sig %c0_i20 : i20
    %aou_pdu_mr_reg = llhd.sig %c0_i32 : i32
    %etb_rtc_trig_0 = llhd.sig name "etb_rtc_trig" %false : i1
    %match_val = llhd.sig %c0_i32 : i32
    %pclk_gate = llhd.sig %false : i1
    %2 = llhd.prb %pclk_gate : i1
    %pdu_aou_wen_cr_1 = llhd.sig name "pdu_aou_wen_cr" %false : i1
    %pdu_aou_wen_div_2 = llhd.sig name "pdu_aou_wen_div" %false : i1
    %pdu_aou_wen_mr_3 = llhd.sig name "pdu_aou_wen_mr" %false : i1
    %presetn_4 = llhd.sig name "presetn" %false : i1
    %3 = llhd.prb %presetn_4 : i1
    %pwdata_5 = llhd.sig name "pwdata" %c0_i32 : i32
    %rtcclkdivcfg = llhd.sig %c0_i20 : i20
    %4 = llhd.prb %pdu_aou_wen_mr_3 : i1
    %5 = llhd.prb %pdu_aou_wen_cr_1 : i1
    %6 = llhd.prb %etb_rtc_trig_0 : i1
    %7 = llhd.prb %pdu_aou_wen_div_2 : i1
    %8 = comb.or %4, %5, %6, %7 {sv.namehint = "gate_en"} : i1
    %gatecell.clk_out = hw.instance "gatecell" @gated_clk_cell(clk_in: %pclk: i1, global_en: %false: i1, module_en: %false: i1, local_en: %false: i1, external_en: %8: i1, pad_yy_test_mode: %test_mode: i1, pad_yy_gate_clk_en_b: %false: i1) -> (clk_out: i1)
    llhd.drv %pclk_gate, %gatecell.clk_out after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %21 = llhd.prb %pclk_gate : i1
      %22 = llhd.prb %presetn_4 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %23 = llhd.prb %pclk_gate : i1
      %24 = comb.xor bin %21, %true : i1
      %25 = comb.and bin %24, %23 : i1
      %26 = llhd.prb %presetn_4 : i1
      %27 = comb.xor bin %26, %true : i1
      %28 = comb.and bin %22, %27 : i1
      %29 = comb.or bin %25, %28 : i1
      cf.cond_br %29, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %30 = llhd.prb %presetn_4 : i1
      %31 = comb.xor %30, %true : i1
      cf.cond_br %31, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %mr_reg, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %32 = llhd.prb %pdu_aou_wen_mr_3 : i1
      cf.cond_br %32, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %33 = llhd.prb %pwdata_5 : i32
      llhd.drv %mr_reg, %33 after %0 : i32
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %21 = llhd.prb %pclk_gate : i1
      %22 = llhd.prb %presetn_4 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %23 = llhd.prb %pclk_gate : i1
      %24 = comb.xor bin %21, %true : i1
      %25 = comb.and bin %24, %23 : i1
      %26 = llhd.prb %presetn_4 : i1
      %27 = comb.xor bin %26, %true : i1
      %28 = comb.and bin %22, %27 : i1
      %29 = comb.or bin %25, %28 : i1
      cf.cond_br %29, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %30 = llhd.prb %presetn_4 : i1
      %31 = comb.xor %30, %true : i1
      cf.cond_br %31, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cr_reg, %c0_i4 after %0 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %32 = llhd.prb %pdu_aou_wen_cr_1 : i1
      cf.cond_br %32, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %33 = llhd.prb %pwdata_5 : i32
      %34 = comb.extract %33 from 0 : (i32) -> i4
      llhd.drv %cr_reg, %34 after %0 : i4
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %35 = llhd.prb %etb_rtc_trig_0 : i1
      cf.cond_br %35, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %36 = llhd.sig.extract %cr_reg from %c-2_i2 : <i4> -> <i1>
      llhd.drv %36, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %21 = llhd.prb %pclk_gate : i1
      %22 = llhd.prb %presetn_4 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %23 = llhd.prb %pclk_gate : i1
      %24 = comb.xor bin %21, %true : i1
      %25 = comb.and bin %24, %23 : i1
      %26 = llhd.prb %presetn_4 : i1
      %27 = comb.xor bin %26, %true : i1
      %28 = comb.and bin %22, %27 : i1
      %29 = comb.or bin %25, %28 : i1
      cf.cond_br %29, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %30 = llhd.prb %presetn_4 : i1
      %31 = comb.xor %30, %true : i1
      cf.cond_br %31, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %div_reg, %c1_i20 after %0 : i20
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %32 = llhd.prb %pdu_aou_wen_div_2 : i1
      cf.cond_br %32, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %33 = llhd.prb %pwdata_5 : i32
      %34 = comb.extract %33 from 0 : (i32) -> i20
      llhd.drv %div_reg, %34 after %0 : i20
      cf.br ^bb1
    }
    %9 = llhd.prb %mr_reg : i32
    llhd.drv %aou_pdu_mr_reg, %9 after %1 : i32
    %10 = llhd.prb %cr_reg : i4
    llhd.drv %aou_pdu_cr_reg, %10 after %1 : i4
    %11 = llhd.prb %div_reg : i20
    llhd.drv %aou_pdu_div_reg, %11 after %1 : i20
    llhd.drv %match_val, %9 after %1 : i32
    %12 = comb.extract %10 from 3 : (i4) -> i1
    %13 = comb.extract %10 from 2 : (i4) -> i1
    %14 = comb.extract %10 from 1 : (i4) -> i1
    %15 = comb.extract %10 from 0 : (i4) -> i1
    llhd.drv %rtcclkdivcfg, %11 after %1 : i20
    %16 = llhd.prb %aou_pdu_cr_reg : i4
    %17 = llhd.prb %aou_pdu_div_reg : i20
    %18 = llhd.prb %aou_pdu_mr_reg : i32
    llhd.drv %etb_rtc_trig_0, %etb_rtc_trig after %1 : i1
    %19 = llhd.prb %match_val : i32
    llhd.drv %pdu_aou_wen_cr_1, %pdu_aou_wen_cr after %1 : i1
    llhd.drv %pdu_aou_wen_div_2, %pdu_aou_wen_div after %1 : i1
    llhd.drv %pdu_aou_wen_mr_3, %pdu_aou_wen_mr after %1 : i1
    llhd.drv %presetn_4, %presetn after %1 : i1
    llhd.drv %pwdata_5, %pwdata after %1 : i32
    %20 = llhd.prb %rtcclkdivcfg : i20
    hw.output %16, %17, %14, %18, %13, %15, %14, %19, %20, %12 : i4, i20, i1, i32, i1, i1, i1, i32, i20, i1
  }
  hw.module private @rtc_aou_top(out aou_pdu_cnt : i32, out aou_pdu_cr_reg : i4, out aou_pdu_div_reg : i20, out aou_pdu_intr_mask : i1, out aou_pdu_mr_reg : i32, in %etb_rtc_trig : i1, in %i_rtc_ext_clk : i1, out int_flag : i1, in %pclk : i1, in %pdu_aou_clr_reg : i32, in %pdu_aou_int_clr : i1, in %pdu_aou_pwdata : i32, in %pdu_aou_wen_clr_sync : i1, in %pdu_aou_wen_cr : i1, in %pdu_aou_wen_div : i1, in %pdu_aou_wen_mr : i1, out rtc0_vic_intr : i1, out rtc_clk : i1, out rtc_etb_trig : i1, in %rtc_por_rst_n : i1, in %test_mode : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %pwdata = llhd.sig %c0_i32 : i32
    %x_rtc_cnt.aou_pdu_cnt, %x_rtc_cnt.count_val = hw.instance "x_rtc_cnt" @rtc_cnt(cnt_en: %x_rtc_aou_apbif.cnt_en: i1, match_val: %x_rtc_aou_apbif.match_val: i32, pdu_aou_clr_reg: %pdu_aou_clr_reg: i32, pdu_aou_wen_clr_sync: %pdu_aou_wen_clr_sync: i1, presetn: %rtc_por_rst_n: i1, rtc_clk: %x_rtc_clk_div.rtc_clk: i1, wrap_en: %x_rtc_aou_apbif.wrap_en: i1) -> (aou_pdu_cnt: i32, count_val: i32) {sv.namehint = "count_val"}
    %x_rtc_ig.int_flag, %x_rtc_ig.rtc0_vic_intr, %x_rtc_ig.rtc_etb_trig = hw.instance "x_rtc_ig" @rtc_ig(cnt_en: %x_rtc_aou_apbif.cnt_en: i1, count_val: %x_rtc_cnt.count_val: i32, i_rtc_ext_clk: %i_rtc_ext_clk: i1, intr_en: %x_rtc_aou_apbif.intr_en: i1, intr_mask: %x_rtc_aou_apbif.intr_mask: i1, match_val: %x_rtc_aou_apbif.match_val: i32, pdu_aou_int_clr: %pdu_aou_int_clr: i1, rtc_por_rst_n: %rtc_por_rst_n: i1) -> (int_flag: i1, rtc0_vic_intr: i1, rtc_etb_trig: i1)
    %x_rtc_clk_div.rtc_clk = hw.instance "x_rtc_clk_div" @rtc_clk_div(cnt_en: %x_rtc_aou_apbif.cnt_en: i1, i_rtc_ext_clk: %i_rtc_ext_clk: i1, pclk: %pclk: i1, presetn: %rtc_por_rst_n: i1, rtcclkdivcfg: %x_rtc_aou_apbif.rtcclkdivcfg: i20, test_mode: %test_mode: i1) -> (rtc_clk: i1)
    %1 = llhd.prb %pwdata : i32
    %x_rtc_aou_apbif.aou_pdu_cr_reg, %x_rtc_aou_apbif.aou_pdu_div_reg, %x_rtc_aou_apbif.aou_pdu_intr_mask, %x_rtc_aou_apbif.aou_pdu_mr_reg, %x_rtc_aou_apbif.cnt_en, %x_rtc_aou_apbif.intr_en, %x_rtc_aou_apbif.intr_mask, %x_rtc_aou_apbif.match_val, %x_rtc_aou_apbif.rtcclkdivcfg, %x_rtc_aou_apbif.wrap_en = hw.instance "x_rtc_aou_apbif" @rtc_aou_apbif(etb_rtc_trig: %etb_rtc_trig: i1, pclk: %pclk: i1, pdu_aou_wen_cr: %pdu_aou_wen_cr: i1, pdu_aou_wen_div: %pdu_aou_wen_div: i1, pdu_aou_wen_mr: %pdu_aou_wen_mr: i1, presetn: %rtc_por_rst_n: i1, pwdata: %1: i32, test_mode: %test_mode: i1) -> (aou_pdu_cr_reg: i4, aou_pdu_div_reg: i20, aou_pdu_intr_mask: i1, aou_pdu_mr_reg: i32, cnt_en: i1, intr_en: i1, intr_mask: i1, match_val: i32, rtcclkdivcfg: i20, wrap_en: i1) {sv.namehint = "rtcclkdivcfg"}
    llhd.drv %pwdata, %pdu_aou_pwdata after %0 : i32
    hw.output %x_rtc_cnt.aou_pdu_cnt, %x_rtc_aou_apbif.aou_pdu_cr_reg, %x_rtc_aou_apbif.aou_pdu_div_reg, %x_rtc_aou_apbif.aou_pdu_intr_mask, %x_rtc_aou_apbif.aou_pdu_mr_reg, %x_rtc_ig.int_flag, %x_rtc_ig.rtc0_vic_intr, %x_rtc_clk_div.rtc_clk, %x_rtc_ig.rtc_etb_trig : i32, i4, i20, i1, i32, i1, i1, i1, i1
  }
  hw.module private @rtc_cdr_sync(in %aou_pdu_cnt : i32, out cnt_sync : i32, in %pclk : i1, in %presetn : i1, in %test_mode : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %cnt_reg1 = llhd.sig %false : i1
    %cnt_reg2 = llhd.sig %false : i1
    %cnt_reg3 = llhd.sig %false : i1
    %cnt_sync = llhd.sig %c0_i32 : i32
    %aou_pdu_cnt_0 = llhd.sig name "aou_pdu_cnt" %c0_i32 : i32
    %pclk_1 = llhd.sig name "pclk" %false : i1
    %2 = llhd.prb %pclk_1 : i1
    %pclk_sync = llhd.sig %false : i1
    %3 = llhd.prb %pclk_sync : i1
    %presetn_2 = llhd.sig name "presetn" %false : i1
    %4 = llhd.prb %presetn_2 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %9 = llhd.prb %pclk_1 : i1
      %10 = llhd.prb %presetn_2 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %11 = llhd.prb %pclk_1 : i1
      %12 = comb.xor bin %9, %true : i1
      %13 = comb.and bin %12, %11 : i1
      %14 = llhd.prb %presetn_2 : i1
      %15 = comb.xor bin %14, %true : i1
      %16 = comb.and bin %10, %15 : i1
      %17 = comb.or bin %13, %16 : i1
      cf.cond_br %17, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %18 = llhd.prb %presetn_2 : i1
      %19 = comb.xor %18, %true : i1
      cf.cond_br %19, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cnt_reg1, %false after %1 : i1
      llhd.drv %cnt_reg2, %false after %1 : i1
      llhd.drv %cnt_reg3, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %aou_pdu_cnt_0 : i32
      %21 = comb.extract %20 from 0 : (i32) -> i1
      llhd.drv %cnt_reg1, %21 after %1 : i1
      %22 = llhd.prb %cnt_reg1 : i1
      llhd.drv %cnt_reg2, %22 after %1 : i1
      %23 = llhd.prb %cnt_reg2 : i1
      llhd.drv %cnt_reg3, %23 after %1 : i1
      cf.br ^bb1
    }
    %5 = llhd.prb %cnt_reg2 : i1
    %6 = llhd.prb %cnt_reg3 : i1
    %7 = comb.xor %5, %6 {sv.namehint = "cnt_ed"} : i1
    %gatecell.clk_out = hw.instance "gatecell" @gated_clk_cell(clk_in: %2: i1, global_en: %false: i1, module_en: %false: i1, local_en: %false: i1, external_en: %7: i1, pad_yy_test_mode: %test_mode: i1, pad_yy_gate_clk_en_b: %false: i1) -> (clk_out: i1)
    llhd.drv %pclk_sync, %gatecell.clk_out after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %9 = llhd.prb %pclk_sync : i1
      %10 = llhd.prb %presetn_2 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %11 = llhd.prb %pclk_sync : i1
      %12 = comb.xor bin %9, %true : i1
      %13 = comb.and bin %12, %11 : i1
      %14 = llhd.prb %presetn_2 : i1
      %15 = comb.xor bin %14, %true : i1
      %16 = comb.and bin %10, %15 : i1
      %17 = comb.or bin %13, %16 : i1
      cf.cond_br %17, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %18 = llhd.prb %presetn_2 : i1
      %19 = comb.xor %18, %true : i1
      cf.cond_br %19, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cnt_sync, %c0_i32 after %1 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %aou_pdu_cnt_0 : i32
      llhd.drv %cnt_sync, %20 after %1 : i32
      cf.br ^bb1
    }
    llhd.drv %aou_pdu_cnt_0, %aou_pdu_cnt after %0 : i32
    %8 = llhd.prb %cnt_sync : i32
    llhd.drv %pclk_1, %pclk after %0 : i1
    llhd.drv %presetn_2, %presetn after %0 : i1
    hw.output %8 : i32
  }
  hw.module private @rtc_clk_div(in %cnt_en : i1, in %i_rtc_ext_clk : i1, in %pclk : i1, in %presetn : i1, out rtc_clk : i1, in %rtcclkdivcfg : i20, in %test_mode : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %c1_i20 = hw.constant 1 : i20
    %c0_i20 = hw.constant 0 : i20
    %cnt = llhd.sig %c0_i20 : i20
    %cntEq0 = llhd.sig %false : i1
    %cnt_en_0 = llhd.sig name "cnt_en" %false : i1
    %i_rtc_ext_clk_1 = llhd.sig name "i_rtc_ext_clk" %false : i1
    %2 = llhd.prb %i_rtc_ext_clk_1 : i1
    %pclk_2 = llhd.sig name "pclk" %false : i1
    %presetn_3 = llhd.sig name "presetn" %false : i1
    %3 = llhd.prb %presetn_3 : i1
    %rtc_clk_div = llhd.sig %false : i1
    %4 = llhd.prb %cnt : i20
    %5 = comb.icmp eq %4, %rtcclkdivcfg : i20
    llhd.drv %cntEq0, %5 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %10 = llhd.prb %i_rtc_ext_clk_1 : i1
      %11 = llhd.prb %presetn_3 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %12 = llhd.prb %i_rtc_ext_clk_1 : i1
      %13 = comb.xor bin %10, %true : i1
      %14 = comb.and bin %13, %12 : i1
      %15 = llhd.prb %presetn_3 : i1
      %16 = comb.xor bin %15, %true : i1
      %17 = comb.and bin %11, %16 : i1
      %18 = comb.or bin %14, %17 : i1
      cf.cond_br %18, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %19 = llhd.prb %presetn_3 : i1
      %20 = comb.xor %19, %true : i1
      cf.cond_br %20, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cnt, %c0_i20 after %0 : i20
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %21 = llhd.prb %cntEq0 : i1
      cf.cond_br %21, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %cnt, %c0_i20 after %0 : i20
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %22 = llhd.prb %cnt_en_0 : i1
      cf.cond_br %22, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %23 = llhd.prb %cnt : i20
      %24 = comb.add %23, %c1_i20 : i20
      llhd.drv %cnt, %24 after %0 : i20
      cf.br ^bb1
    }
    %6 = llhd.prb %cntEq0 {sv.namehint = "gate_en"} : i1
    %x_gatecell.clk_out = hw.instance "x_gatecell" @gated_clk_cell(clk_in: %2: i1, global_en: %false: i1, module_en: %false: i1, local_en: %false: i1, external_en: %6: i1, pad_yy_test_mode: %test_mode: i1, pad_yy_gate_clk_en_b: %false: i1) -> (clk_out: i1)
    llhd.drv %rtc_clk_div, %x_gatecell.clk_out after %1 : i1
    %7 = llhd.prb %pclk_2 : i1
    %8 = llhd.prb %rtc_clk_div : i1
    %9 = comb.mux %test_mode, %7, %8 : i1
    llhd.drv %cnt_en_0, %cnt_en after %1 : i1
    llhd.drv %i_rtc_ext_clk_1, %i_rtc_ext_clk after %1 : i1
    llhd.drv %pclk_2, %pclk after %1 : i1
    llhd.drv %presetn_3, %presetn after %1 : i1
    hw.output %9 : i1
  }
  hw.module private @rtc_clr_sync(in %pclk : i1, out pdu_aou_wen_clr_sync : i1, in %presetn : i1, in %rtc_clk : i1, in %test_mode : i1, in %wen_clr : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
    %false = hw.constant false
    %pclk_load_sync1 = llhd.sig %false : i1
    %pclk_load_sync2 = llhd.sig %false : i1
    %rtc_load_sync1 = llhd.sig %false : i1
    %rtc_load_sync2 = llhd.sig %false : i1
    %wen_clr_hold = llhd.sig %false : i1
    %load_done = llhd.sig %false : i1
    %pclk_sync = llhd.sig %false : i1
    %2 = llhd.prb %pclk_sync : i1
    %presetn_0 = llhd.sig name "presetn" %false : i1
    %3 = llhd.prb %presetn_0 : i1
    %rtc_clk_1 = llhd.sig name "rtc_clk" %false : i1
    %4 = llhd.prb %rtc_clk_1 : i1
    %wen_clr_2 = llhd.sig name "wen_clr" %false : i1
    %5 = llhd.prb %wen_clr_2 : i1
    %6 = llhd.prb %wen_clr_hold : i1
    %7 = llhd.prb %pclk_load_sync2 : i1
    %8 = comb.or %5, %6, %7 {sv.namehint = "gate_en"} : i1
    %gatecell.clk_out = hw.instance "gatecell" @gated_clk_cell(clk_in: %pclk: i1, global_en: %false: i1, module_en: %false: i1, local_en: %false: i1, external_en: %8: i1, pad_yy_test_mode: %test_mode: i1, pad_yy_gate_clk_en_b: %false: i1) -> (clk_out: i1)
    llhd.drv %pclk_sync, %gatecell.clk_out after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %10 = llhd.prb %pclk_sync : i1
      %11 = llhd.prb %presetn_0 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %12 = llhd.prb %pclk_sync : i1
      %13 = comb.xor bin %10, %true : i1
      %14 = comb.and bin %13, %12 : i1
      %15 = llhd.prb %presetn_0 : i1
      %16 = comb.xor bin %15, %true : i1
      %17 = comb.and bin %11, %16 : i1
      %18 = comb.or bin %14, %17 : i1
      cf.cond_br %18, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %19 = llhd.prb %presetn_0 : i1
      %20 = comb.xor %19, %true : i1
      cf.cond_br %20, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %wen_clr_hold, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %21 = llhd.prb %load_done : i1
      cf.cond_br %21, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %wen_clr_hold, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %22 = llhd.prb %wen_clr_2 : i1
      cf.cond_br %22, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %wen_clr_hold, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %10 = llhd.prb %rtc_clk_1 : i1
      %11 = llhd.prb %presetn_0 : i1
      llhd.wait (%4, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %12 = llhd.prb %rtc_clk_1 : i1
      %13 = comb.xor bin %10, %true : i1
      %14 = comb.and bin %13, %12 : i1
      %15 = llhd.prb %presetn_0 : i1
      %16 = comb.xor bin %15, %true : i1
      %17 = comb.and bin %11, %16 : i1
      %18 = comb.or bin %14, %17 : i1
      cf.cond_br %18, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %19 = llhd.prb %presetn_0 : i1
      %20 = comb.xor %19, %true : i1
      cf.cond_br %20, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rtc_load_sync1, %false after %0 : i1
      llhd.drv %rtc_load_sync2, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %21 = llhd.prb %wen_clr_hold : i1
      llhd.drv %rtc_load_sync1, %21 after %0 : i1
      %22 = llhd.prb %rtc_load_sync1 : i1
      llhd.drv %rtc_load_sync2, %22 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %10 = llhd.prb %pclk_sync : i1
      %11 = llhd.prb %presetn_0 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %12 = llhd.prb %pclk_sync : i1
      %13 = comb.xor bin %10, %true : i1
      %14 = comb.and bin %13, %12 : i1
      %15 = llhd.prb %presetn_0 : i1
      %16 = comb.xor bin %15, %true : i1
      %17 = comb.and bin %11, %16 : i1
      %18 = comb.or bin %14, %17 : i1
      cf.cond_br %18, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %19 = llhd.prb %presetn_0 : i1
      %20 = comb.xor %19, %true : i1
      cf.cond_br %20, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pclk_load_sync1, %false after %0 : i1
      llhd.drv %pclk_load_sync2, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %21 = llhd.prb %rtc_load_sync2 : i1
      llhd.drv %pclk_load_sync1, %21 after %0 : i1
      %22 = llhd.prb %pclk_load_sync1 : i1
      llhd.drv %pclk_load_sync2, %22 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %load_done, %7 after %1 : i1
    %9 = llhd.prb %rtc_load_sync2 : i1
    llhd.drv %presetn_0, %presetn after %1 : i1
    llhd.drv %rtc_clk_1, %rtc_clk after %1 : i1
    llhd.drv %wen_clr_2, %wen_clr after %1 : i1
    hw.output %9 : i1
  }
  hw.module private @rtc_cnt(out aou_pdu_cnt : i32, in %cnt_en : i1, out count_val : i32, in %match_val : i32, in %pdu_aou_clr_reg : i32, in %pdu_aou_wen_clr_sync : i1, in %presetn : i1, in %rtc_clk : i1, in %wrap_en : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c1_i32 = hw.constant 1 : i32
    %false = hw.constant false
    %c0_i32 = hw.constant 0 : i32
    %cnt = llhd.sig %c0_i32 : i32
    %aou_pdu_cnt = llhd.sig %c0_i32 : i32
    %cnt_en_0 = llhd.sig name "cnt_en" %false : i1
    %count_val = llhd.sig %c0_i32 : i32
    %match_val_1 = llhd.sig name "match_val" %c0_i32 : i32
    %pdu_aou_clr_reg_2 = llhd.sig name "pdu_aou_clr_reg" %c0_i32 : i32
    %pdu_aou_wen_clr_sync_3 = llhd.sig name "pdu_aou_wen_clr_sync" %false : i1
    %presetn_4 = llhd.sig name "presetn" %false : i1
    %2 = llhd.prb %presetn_4 : i1
    %rtc_clk_5 = llhd.sig name "rtc_clk" %false : i1
    %3 = llhd.prb %rtc_clk_5 : i1
    %wrap_en_6 = llhd.sig name "wrap_en" %false : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb9, ^bb10
      %7 = llhd.prb %rtc_clk_5 : i1
      %8 = llhd.prb %presetn_4 : i1
      llhd.wait (%3, %2 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %9 = llhd.prb %rtc_clk_5 : i1
      %10 = comb.xor bin %7, %true : i1
      %11 = comb.and bin %10, %9 : i1
      %12 = llhd.prb %presetn_4 : i1
      %13 = comb.xor bin %12, %true : i1
      %14 = comb.and bin %8, %13 : i1
      %15 = comb.or bin %11, %14 : i1
      cf.cond_br %15, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %16 = llhd.prb %presetn_4 : i1
      %17 = comb.xor %16, %true : i1
      cf.cond_br %17, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cnt, %c0_i32 after %1 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %18 = llhd.prb %pdu_aou_wen_clr_sync_3 : i1
      cf.cond_br %18, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %19 = llhd.prb %pdu_aou_clr_reg_2 : i32
      llhd.drv %cnt, %19 after %1 : i32
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %20 = llhd.prb %cnt_en_0 : i1
      cf.cond_br %20, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %21 = llhd.prb %cnt : i32
      %22 = llhd.prb %match_val_1 : i32
      %23 = comb.icmp eq %21, %22 : i32
      %24 = llhd.prb %wrap_en_6 : i1
      %25 = comb.and %23, %24 : i1
      cf.cond_br %25, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      llhd.drv %cnt, %c0_i32 after %1 : i32
      cf.br ^bb1
    ^bb10:  // pred: ^bb8
      %26 = llhd.prb %cnt : i32
      %27 = comb.add %26, %c1_i32 : i32
      llhd.drv %cnt, %27 after %1 : i32
      cf.br ^bb1
    }
    %4 = llhd.prb %cnt : i32
    llhd.drv %aou_pdu_cnt, %4 after %0 : i32
    llhd.drv %count_val, %4 after %0 : i32
    %5 = llhd.prb %aou_pdu_cnt : i32
    llhd.drv %cnt_en_0, %cnt_en after %0 : i1
    %6 = llhd.prb %count_val : i32
    llhd.drv %match_val_1, %match_val after %0 : i32
    llhd.drv %pdu_aou_clr_reg_2, %pdu_aou_clr_reg after %0 : i32
    llhd.drv %pdu_aou_wen_clr_sync_3, %pdu_aou_wen_clr_sync after %0 : i1
    llhd.drv %presetn_4, %presetn after %0 : i1
    llhd.drv %rtc_clk_5, %rtc_clk after %0 : i1
    llhd.drv %wrap_en_6, %wrap_en after %0 : i1
    hw.output %5, %6 : i32, i32
  }
  hw.module private @rtc_ig(in %cnt_en : i1, in %count_val : i32, in %i_rtc_ext_clk : i1, out int_flag : i1, in %intr_en : i1, in %intr_mask : i1, in %match_val : i32, in %pdu_aou_int_clr : i1, out rtc0_vic_intr : i1, out rtc_etb_trig : i1, in %rtc_por_rst_n : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %true = hw.constant true
    %cmp_res = llhd.sig %false : i1
    %int_flag = llhd.sig %false : i1
    %rtc_etb_trig = llhd.sig %false : i1
    %cnt_en_0 = llhd.sig name "cnt_en" %false : i1
    %2 = llhd.prb %cnt_en_0 : i1
    %count_val_1 = llhd.sig name "count_val" %c0_i32 : i32
    %3 = llhd.prb %count_val_1 : i32
    %i_rtc_ext_clk_2 = llhd.sig name "i_rtc_ext_clk" %false : i1
    %4 = llhd.prb %i_rtc_ext_clk_2 : i1
    %int_intr = llhd.sig %false : i1
    %match_val_3 = llhd.sig name "match_val" %c0_i32 : i32
    %5 = llhd.prb %match_val_3 : i32
    %pdu_aou_int_clr_4 = llhd.sig name "pdu_aou_int_clr" %false : i1
    %rtc_por_rst_n_5 = llhd.sig name "rtc_por_rst_n" %false : i1
    %6 = llhd.prb %rtc_por_rst_n_5 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 3 preds: ^bb0, ^bb3, ^bb4
      llhd.wait (%5, %3, %2 : i32, i32, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %15 = llhd.prb %match_val_3 : i32
      %16 = llhd.prb %count_val_1 : i32
      %17 = comb.icmp eq %15, %16 : i32
      %18 = llhd.prb %cnt_en_0 : i1
      %19 = comb.and %17, %18 : i1
      cf.cond_br %19, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %cmp_res, %true after %1 : i1
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      llhd.drv %cmp_res, %false after %1 : i1
      cf.br ^bb1
    }
    %7 = llhd.prb %cmp_res : i1
    %8 = comb.and %7, %intr_en : i1
    llhd.drv %int_intr, %8 after %1 : i1
    %9 = llhd.prb %int_flag : i1
    %10 = llhd.prb %pdu_aou_int_clr_4 : i1
    %11 = comb.xor %10, %true : i1
    %12 = comb.xor %intr_mask, %true : i1
    %13 = comb.and %12, %9, %11 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %15 = llhd.prb %i_rtc_ext_clk_2 : i1
      %16 = llhd.prb %rtc_por_rst_n_5 : i1
      llhd.wait (%4, %6 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %17 = llhd.prb %i_rtc_ext_clk_2 : i1
      %18 = comb.xor bin %15, %true : i1
      %19 = comb.and bin %18, %17 : i1
      %20 = llhd.prb %rtc_por_rst_n_5 : i1
      %21 = comb.xor bin %20, %true : i1
      %22 = comb.and bin %16, %21 : i1
      %23 = comb.or bin %19, %22 : i1
      cf.cond_br %23, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %24 = llhd.prb %rtc_por_rst_n_5 : i1
      %25 = comb.xor %24, %true : i1
      cf.cond_br %25, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_flag, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %26 = llhd.prb %int_intr : i1
      cf.cond_br %26, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %int_flag, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %27 = llhd.prb %pdu_aou_int_clr_4 : i1
      cf.cond_br %27, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %int_flag, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %15 = llhd.prb %i_rtc_ext_clk_2 : i1
      %16 = llhd.prb %rtc_por_rst_n_5 : i1
      llhd.wait (%4, %6 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %17 = llhd.prb %i_rtc_ext_clk_2 : i1
      %18 = comb.xor bin %15, %true : i1
      %19 = comb.and bin %18, %17 : i1
      %20 = llhd.prb %rtc_por_rst_n_5 : i1
      %21 = comb.xor bin %20, %true : i1
      %22 = comb.and bin %16, %21 : i1
      %23 = comb.or bin %19, %22 : i1
      cf.cond_br %23, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %24 = llhd.prb %rtc_por_rst_n_5 : i1
      %25 = comb.xor %24, %true : i1
      cf.cond_br %25, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rtc_etb_trig, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %26 = llhd.prb %cmp_res : i1
      cf.cond_br %26, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %rtc_etb_trig, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      llhd.drv %rtc_etb_trig, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %cnt_en_0, %cnt_en after %1 : i1
    llhd.drv %count_val_1, %count_val after %1 : i32
    llhd.drv %i_rtc_ext_clk_2, %i_rtc_ext_clk after %1 : i1
    llhd.drv %match_val_3, %match_val after %1 : i32
    llhd.drv %pdu_aou_int_clr_4, %pdu_aou_int_clr after %1 : i1
    %14 = llhd.prb %rtc_etb_trig : i1
    llhd.drv %rtc_por_rst_n_5, %rtc_por_rst_n after %1 : i1
    hw.output %9, %13, %14 : i1, i1, i1
  }
  hw.module private @rtc_pdu_apbif(in %aou_pdu_cr_reg : i4, in %aou_pdu_div_reg : i20, in %aou_pdu_intr_mask : i1, in %aou_pdu_mr_reg : i32, in %cnt_sync : i32, in %int_flag : i1, in %paddr : i32, in %pclk : i1, out pdu_aou_clr_reg : i32, out pdu_aou_int_clr : i1, out pdu_aou_wen_cr : i1, out pdu_aou_wen_div : i1, out pdu_aou_wen_mr : i1, in %penable : i1, out prdata : i32, in %presetn : i1, in %psel : i1, in %pwdata : i32, in %pwrite : i1, in %test_mode : i1, out wen_clr : i1) {
    %c7_i4 = hw.constant 7 : i4
    %c6_i4 = hw.constant 6 : i4
    %c5_i4 = hw.constant 5 : i4
    %c4_i4 = hw.constant 4 : i4
    %c-8_i4 = hw.constant -8 : i4
    %c3_i4 = hw.constant 3 : i4
    %c2_i4 = hw.constant 2 : i4
    %c1_i4 = hw.constant 1 : i4
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i20 = hw.constant 0 : i20
    %c0_i4 = hw.constant 0 : i4
    %c0_i12 = hw.constant 0 : i12
    %c842019114_i32 = hw.constant 842019114 : i32
    %c0_i31 = hw.constant 0 : i31
    %c0_i28 = hw.constant 0 : i28
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %true = hw.constant true
    %clr_reg = llhd.sig %c0_i32 : i32
    %2 = llhd.prb %clr_reg : i32
    %int_clr = llhd.sig %false : i1
    %int_state = llhd.sig %false : i1
    %prdata = llhd.sig %c0_i32 : i32
    %ren_cdr = llhd.sig %false : i1
    %3 = llhd.prb %ren_cdr : i1
    %ren_clr = llhd.sig %false : i1
    %4 = llhd.prb %ren_clr : i1
    %ren_cr = llhd.sig %false : i1
    %5 = llhd.prb %ren_cr : i1
    %ren_div = llhd.sig %false : i1
    %6 = llhd.prb %ren_div : i1
    %ren_eoi = llhd.sig %false : i1
    %7 = llhd.prb %ren_eoi : i1
    %ren_mr = llhd.sig %false : i1
    %8 = llhd.prb %ren_mr : i1
    %ren_rstat = llhd.sig %false : i1
    %9 = llhd.prb %ren_rstat : i1
    %ren_stat = llhd.sig %false : i1
    %10 = llhd.prb %ren_stat : i1
    %ren_vid = llhd.sig %false : i1
    %11 = llhd.prb %ren_vid : i1
    %wen_clr = llhd.sig %false : i1
    %wen_cr = llhd.sig %false : i1
    %wen_div = llhd.sig %false : i1
    %wen_mr = llhd.sig %false : i1
    %aou_pdu_rstat = llhd.sig %false : i1
    %12 = llhd.prb %aou_pdu_rstat : i1
    %aou_pdu_stat = llhd.sig %false : i1
    %13 = llhd.prb %aou_pdu_stat : i1
    %cdr_reg = llhd.sig %c0_i32 : i32
    %14 = llhd.prb %cdr_reg : i32
    %cr_reg = llhd.sig %c0_i4 : i4
    %15 = llhd.prb %cr_reg : i4
    %div_reg = llhd.sig %c0_i20 : i20
    %16 = llhd.prb %div_reg : i20
    %int_flag_0 = llhd.sig name "int_flag" %false : i1
    %mr_reg = llhd.sig %c0_i32 : i32
    %17 = llhd.prb %mr_reg : i32
    %paddr_1 = llhd.sig name "paddr" %c0_i32 : i32
    %18 = llhd.prb %paddr_1 : i32
    %pclk_2 = llhd.sig name "pclk" %false : i1
    %19 = llhd.prb %pclk_2 : i1
    %pclk_clr = llhd.sig %false : i1
    %20 = llhd.prb %pclk_clr : i1
    %pdu_aou_clr_reg = llhd.sig %c0_i32 : i32
    %pdu_aou_ren_eoi = llhd.sig %false : i1
    %penable_3 = llhd.sig name "penable" %false : i1
    %21 = llhd.prb %penable_3 : i1
    %presetn_4 = llhd.sig name "presetn" %false : i1
    %22 = llhd.prb %presetn_4 : i1
    %psel_5 = llhd.sig name "psel" %false : i1
    %23 = llhd.prb %psel_5 : i1
    %pwdata_6 = llhd.sig name "pwdata" %c0_i32 : i32
    %pwrite_7 = llhd.sig name "pwrite" %false : i1
    %24 = llhd.prb %pwrite_7 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 3 preds: ^bb0, ^bb3, ^bb4
      llhd.wait (%18, %23, %21, %24 : i32, i1, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %35 = llhd.prb %psel_5 : i1
      %36 = llhd.prb %penable_3 : i1
      %37 = llhd.prb %pwrite_7 : i1
      %38 = llhd.prb %paddr_1 : i32
      %39 = comb.extract %38 from 2 : (i32) -> i4
      %40 = comb.icmp eq %39, %c1_i4 : i4
      %41 = comb.and %35, %36, %37, %40 : i1
      cf.cond_br %41, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %wen_mr, %true after %1 : i1
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      llhd.drv %wen_mr, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 3 preds: ^bb0, ^bb3, ^bb4
      llhd.wait (%18, %23, %21, %24 : i32, i1, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %35 = llhd.prb %psel_5 : i1
      %36 = llhd.prb %penable_3 : i1
      %37 = llhd.prb %pwrite_7 : i1
      %38 = llhd.prb %paddr_1 : i32
      %39 = comb.extract %38 from 2 : (i32) -> i4
      %40 = comb.icmp eq %39, %c2_i4 : i4
      %41 = comb.and %35, %36, %37, %40 : i1
      cf.cond_br %41, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %wen_clr, %true after %1 : i1
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      llhd.drv %wen_clr, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 3 preds: ^bb0, ^bb3, ^bb4
      llhd.wait (%18, %23, %21, %24 : i32, i1, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %35 = llhd.prb %psel_5 : i1
      %36 = llhd.prb %penable_3 : i1
      %37 = llhd.prb %pwrite_7 : i1
      %38 = llhd.prb %paddr_1 : i32
      %39 = comb.extract %38 from 2 : (i32) -> i4
      %40 = comb.icmp eq %39, %c3_i4 : i4
      %41 = comb.and %35, %36, %37, %40 : i1
      cf.cond_br %41, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %wen_cr, %true after %1 : i1
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      llhd.drv %wen_cr, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 3 preds: ^bb0, ^bb3, ^bb4
      llhd.wait (%18, %23, %21, %24 : i32, i1, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %35 = llhd.prb %psel_5 : i1
      %36 = llhd.prb %penable_3 : i1
      %37 = llhd.prb %pwrite_7 : i1
      %38 = llhd.prb %paddr_1 : i32
      %39 = comb.extract %38 from 2 : (i32) -> i4
      %40 = comb.icmp eq %39, %c-8_i4 : i4
      %41 = comb.and %35, %36, %37, %40 : i1
      cf.cond_br %41, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %wen_div, %true after %1 : i1
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      llhd.drv %wen_div, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 3 preds: ^bb0, ^bb3, ^bb4
      llhd.wait (%18, %23, %21, %24 : i32, i1, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %35 = llhd.prb %psel_5 : i1
      %36 = llhd.prb %penable_3 : i1
      %37 = llhd.prb %pwrite_7 : i1
      %38 = comb.xor %37, %true : i1
      %39 = llhd.prb %paddr_1 : i32
      %40 = comb.extract %39 from 2 : (i32) -> i4
      %41 = comb.icmp eq %40, %c0_i4 : i4
      %42 = comb.and %35, %36, %38, %41 : i1
      cf.cond_br %42, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %ren_cdr, %true after %1 : i1
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      llhd.drv %ren_cdr, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 3 preds: ^bb0, ^bb3, ^bb4
      llhd.wait (%18, %23, %21, %24 : i32, i1, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %35 = llhd.prb %psel_5 : i1
      %36 = llhd.prb %penable_3 : i1
      %37 = llhd.prb %pwrite_7 : i1
      %38 = comb.xor %37, %true : i1
      %39 = llhd.prb %paddr_1 : i32
      %40 = comb.extract %39 from 2 : (i32) -> i4
      %41 = comb.icmp eq %40, %c1_i4 : i4
      %42 = comb.and %35, %36, %38, %41 : i1
      cf.cond_br %42, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %ren_mr, %true after %1 : i1
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      llhd.drv %ren_mr, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 3 preds: ^bb0, ^bb3, ^bb4
      llhd.wait (%18, %23, %21, %24 : i32, i1, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %35 = llhd.prb %psel_5 : i1
      %36 = llhd.prb %penable_3 : i1
      %37 = llhd.prb %pwrite_7 : i1
      %38 = comb.xor %37, %true : i1
      %39 = llhd.prb %paddr_1 : i32
      %40 = comb.extract %39 from 2 : (i32) -> i4
      %41 = comb.icmp eq %40, %c2_i4 : i4
      %42 = comb.and %35, %36, %38, %41 : i1
      cf.cond_br %42, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %ren_clr, %true after %1 : i1
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      llhd.drv %ren_clr, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 3 preds: ^bb0, ^bb3, ^bb4
      llhd.wait (%18, %23, %21, %24 : i32, i1, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %35 = llhd.prb %psel_5 : i1
      %36 = llhd.prb %penable_3 : i1
      %37 = llhd.prb %pwrite_7 : i1
      %38 = comb.xor %37, %true : i1
      %39 = llhd.prb %paddr_1 : i32
      %40 = comb.extract %39 from 2 : (i32) -> i4
      %41 = comb.icmp eq %40, %c3_i4 : i4
      %42 = comb.and %35, %36, %38, %41 : i1
      cf.cond_br %42, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %ren_cr, %true after %1 : i1
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      llhd.drv %ren_cr, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 3 preds: ^bb0, ^bb3, ^bb4
      llhd.wait (%18, %23, %21, %24 : i32, i1, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %35 = llhd.prb %psel_5 : i1
      %36 = llhd.prb %penable_3 : i1
      %37 = llhd.prb %pwrite_7 : i1
      %38 = comb.xor %37, %true : i1
      %39 = llhd.prb %paddr_1 : i32
      %40 = comb.extract %39 from 2 : (i32) -> i4
      %41 = comb.icmp eq %40, %c4_i4 : i4
      %42 = comb.and %35, %36, %38, %41 : i1
      cf.cond_br %42, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %ren_stat, %true after %1 : i1
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      llhd.drv %ren_stat, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 3 preds: ^bb0, ^bb3, ^bb4
      llhd.wait (%18, %23, %21, %24 : i32, i1, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %35 = llhd.prb %psel_5 : i1
      %36 = llhd.prb %penable_3 : i1
      %37 = llhd.prb %pwrite_7 : i1
      %38 = comb.xor %37, %true : i1
      %39 = llhd.prb %paddr_1 : i32
      %40 = comb.extract %39 from 2 : (i32) -> i4
      %41 = comb.icmp eq %40, %c5_i4 : i4
      %42 = comb.and %35, %36, %38, %41 : i1
      cf.cond_br %42, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %ren_rstat, %true after %1 : i1
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      llhd.drv %ren_rstat, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 3 preds: ^bb0, ^bb3, ^bb4
      llhd.wait (%18, %23, %21, %24 : i32, i1, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %35 = llhd.prb %psel_5 : i1
      %36 = llhd.prb %penable_3 : i1
      %37 = llhd.prb %pwrite_7 : i1
      %38 = comb.xor %37, %true : i1
      %39 = llhd.prb %paddr_1 : i32
      %40 = comb.extract %39 from 2 : (i32) -> i4
      %41 = comb.icmp eq %40, %c6_i4 : i4
      %42 = comb.and %35, %36, %38, %41 : i1
      cf.cond_br %42, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %ren_eoi, %true after %1 : i1
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      llhd.drv %ren_eoi, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 3 preds: ^bb0, ^bb3, ^bb4
      llhd.wait (%18, %23, %21, %24 : i32, i1, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %35 = llhd.prb %psel_5 : i1
      %36 = llhd.prb %penable_3 : i1
      %37 = llhd.prb %pwrite_7 : i1
      %38 = comb.xor %37, %true : i1
      %39 = llhd.prb %paddr_1 : i32
      %40 = comb.extract %39 from 2 : (i32) -> i4
      %41 = comb.icmp eq %40, %c7_i4 : i4
      %42 = comb.and %35, %36, %38, %41 : i1
      cf.cond_br %42, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %ren_vid, %true after %1 : i1
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      llhd.drv %ren_vid, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 3 preds: ^bb0, ^bb3, ^bb4
      llhd.wait (%18, %23, %21, %24 : i32, i1, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %35 = llhd.prb %psel_5 : i1
      %36 = llhd.prb %penable_3 : i1
      %37 = llhd.prb %pwrite_7 : i1
      %38 = comb.xor %37, %true : i1
      %39 = llhd.prb %paddr_1 : i32
      %40 = comb.extract %39 from 2 : (i32) -> i4
      %41 = comb.icmp eq %40, %c-8_i4 : i4
      %42 = comb.and %35, %36, %38, %41 : i1
      cf.cond_br %42, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %ren_div, %true after %1 : i1
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      llhd.drv %ren_div, %false after %1 : i1
      cf.br ^bb1
    }
    %25 = llhd.prb %wen_clr : i1
    %gatecell.clk_out = hw.instance "gatecell" @gated_clk_cell(clk_in: %19: i1, global_en: %false: i1, module_en: %false: i1, local_en: %false: i1, external_en: %25: i1, pad_yy_test_mode: %test_mode: i1, pad_yy_gate_clk_en_b: %false: i1) -> (clk_out: i1)
    llhd.drv %pclk_clr, %gatecell.clk_out after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %35 = llhd.prb %pclk_clr : i1
      %36 = llhd.prb %presetn_4 : i1
      llhd.wait (%20, %22 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %37 = llhd.prb %pclk_clr : i1
      %38 = comb.xor bin %35, %true : i1
      %39 = comb.and bin %38, %37 : i1
      %40 = llhd.prb %presetn_4 : i1
      %41 = comb.xor bin %40, %true : i1
      %42 = comb.and bin %36, %41 : i1
      %43 = comb.or bin %39, %42 : i1
      cf.cond_br %43, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %44 = llhd.prb %presetn_4 : i1
      %45 = comb.xor %44, %true : i1
      cf.cond_br %45, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %clr_reg, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %46 = llhd.prb %pwdata_6 : i32
      llhd.drv %clr_reg, %46 after %0 : i32
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 11 preds: ^bb0, ^bb3, ^bb5, ^bb7, ^bb9, ^bb11, ^bb13, ^bb15, ^bb17, ^bb19, ^bb20
      llhd.wait (%17, %5, %7, %15, %12, %14, %3, %9, %6, %16, %8, %2, %11, %4, %10, %13 : i32, i1, i1, i4, i1, i32, i1, i1, i1, i20, i1, i32, i1, i1, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %35 = llhd.prb %ren_cdr : i1
      cf.cond_br %35, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %36 = llhd.prb %cdr_reg : i32
      llhd.drv %prdata, %36 after %1 : i32
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      %37 = llhd.prb %ren_mr : i1
      cf.cond_br %37, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %38 = llhd.prb %mr_reg : i32
      llhd.drv %prdata, %38 after %1 : i32
      cf.br ^bb1
    ^bb6:  // pred: ^bb4
      %39 = llhd.prb %ren_clr : i1
      cf.cond_br %39, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %40 = llhd.prb %clr_reg : i32
      llhd.drv %prdata, %40 after %1 : i32
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %41 = llhd.prb %ren_cr : i1
      cf.cond_br %41, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %42 = llhd.prb %cr_reg : i4
      %43 = comb.concat %c0_i28, %42 : i28, i4
      llhd.drv %prdata, %43 after %1 : i32
      cf.br ^bb1
    ^bb10:  // pred: ^bb8
      %44 = llhd.prb %ren_stat : i1
      cf.cond_br %44, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %45 = llhd.prb %aou_pdu_stat : i1
      %46 = comb.concat %c0_i31, %45 : i31, i1
      llhd.drv %prdata, %46 after %1 : i32
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      %47 = llhd.prb %ren_rstat : i1
      cf.cond_br %47, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      %48 = llhd.prb %aou_pdu_rstat : i1
      %49 = comb.concat %c0_i31, %48 : i31, i1
      llhd.drv %prdata, %49 after %1 : i32
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      %50 = llhd.prb %ren_eoi : i1
      cf.cond_br %50, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      llhd.drv %prdata, %c0_i32 after %1 : i32
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      %51 = llhd.prb %ren_vid : i1
      cf.cond_br %51, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      llhd.drv %prdata, %c842019114_i32 after %1 : i32
      cf.br ^bb1
    ^bb18:  // pred: ^bb16
      %52 = llhd.prb %ren_div : i1
      cf.cond_br %52, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %53 = llhd.prb %div_reg : i20
      %54 = comb.concat %c0_i12, %53 : i12, i20
      llhd.drv %prdata, %54 after %1 : i32
      cf.br ^bb1
    ^bb20:  // pred: ^bb18
      llhd.drv %prdata, %c0_i32 after %1 : i32
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9
      %35 = llhd.prb %pclk_2 : i1
      %36 = llhd.prb %presetn_4 : i1
      llhd.wait (%19, %22 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %37 = llhd.prb %pclk_2 : i1
      %38 = comb.xor bin %35, %true : i1
      %39 = comb.and bin %38, %37 : i1
      %40 = llhd.prb %presetn_4 : i1
      %41 = comb.xor bin %40, %true : i1
      %42 = comb.and bin %36, %41 : i1
      %43 = comb.or bin %39, %42 : i1
      cf.cond_br %43, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %44 = llhd.prb %presetn_4 : i1
      %45 = comb.xor %44, %true : i1
      cf.cond_br %45, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_clr, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %46 = llhd.prb %int_flag_0 : i1
      %47 = llhd.prb %pdu_aou_ren_eoi : i1
      %48 = comb.and %46, %47 : i1
      cf.cond_br %48, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %int_clr, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %49 = llhd.prb %int_flag_0 : i1
      cf.cond_br %49, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %50 = llhd.prb %int_clr : i1
      llhd.drv %int_clr, %50 after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      llhd.drv %int_clr, %false after %0 : i1
      cf.br ^bb1
    }
    %26 = llhd.prb %int_clr : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %35 = llhd.prb %pclk_2 : i1
      %36 = llhd.prb %presetn_4 : i1
      llhd.wait (%19, %22 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %37 = llhd.prb %pclk_2 : i1
      %38 = comb.xor bin %35, %true : i1
      %39 = comb.and bin %38, %37 : i1
      %40 = llhd.prb %presetn_4 : i1
      %41 = comb.xor bin %40, %true : i1
      %42 = comb.and bin %36, %41 : i1
      %43 = comb.or bin %39, %42 : i1
      cf.cond_br %43, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %44 = llhd.prb %presetn_4 : i1
      %45 = comb.xor %44, %true : i1
      cf.cond_br %45, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_state, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %46 = llhd.prb %int_clr : i1
      cf.cond_br %46, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %int_state, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %47 = llhd.prb %int_flag_0 : i1
      cf.cond_br %47, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %int_state, %true after %0 : i1
      cf.br ^bb1
    }
    %27 = llhd.prb %int_state : i1
    llhd.drv %aou_pdu_rstat, %27 after %1 : i1
    %28 = comb.xor %aou_pdu_intr_mask, %true : i1
    %29 = comb.and %28, %27 : i1
    llhd.drv %aou_pdu_stat, %29 after %1 : i1
    llhd.drv %mr_reg, %aou_pdu_mr_reg after %1 : i32
    llhd.drv %cr_reg, %aou_pdu_cr_reg after %1 : i4
    llhd.drv %div_reg, %aou_pdu_div_reg after %1 : i20
    llhd.drv %cdr_reg, %cnt_sync after %1 : i32
    llhd.drv %pdu_aou_clr_reg, %2 after %1 : i32
    llhd.drv %pdu_aou_ren_eoi, %7 after %1 : i1
    %30 = llhd.prb %wen_mr : i1
    %31 = llhd.prb %wen_cr : i1
    %32 = llhd.prb %wen_div : i1
    llhd.drv %int_flag_0, %int_flag after %1 : i1
    llhd.drv %paddr_1, %paddr after %1 : i32
    llhd.drv %pclk_2, %pclk after %1 : i1
    %33 = llhd.prb %pdu_aou_clr_reg : i32
    llhd.drv %penable_3, %penable after %1 : i1
    %34 = llhd.prb %prdata : i32
    llhd.drv %presetn_4, %presetn after %1 : i1
    llhd.drv %psel_5, %psel after %1 : i1
    llhd.drv %pwdata_6, %pwdata after %1 : i32
    llhd.drv %pwrite_7, %pwrite after %1 : i1
    hw.output %33, %26, %31, %32, %30, %34, %25 : i32, i1, i1, i1, i1, i32, i1
  }
  hw.module private @rtc_pdu_top(in %aou_pdu_cnt : i32, in %aou_pdu_cr_reg : i4, in %aou_pdu_div_reg : i20, in %aou_pdu_intr_mask : i1, in %aou_pdu_mr_reg : i32, in %int_flag : i1, in %paddr : i32, in %pclk : i1, out pdu_aou_clr_reg : i32, out pdu_aou_int_clr : i1, out pdu_aou_wen_clr_sync : i1, out pdu_aou_wen_cr : i1, out pdu_aou_wen_div : i1, out pdu_aou_wen_mr : i1, in %penable : i1, out prdata : i32, in %presetn : i1, in %psel : i1, in %pwdata : i32, in %pwrite : i1, in %rtc_clk : i1, in %test_mode : i1) {
    %x_rtc_pdu_apbif.pdu_aou_clr_reg, %x_rtc_pdu_apbif.pdu_aou_int_clr, %x_rtc_pdu_apbif.pdu_aou_wen_cr, %x_rtc_pdu_apbif.pdu_aou_wen_div, %x_rtc_pdu_apbif.pdu_aou_wen_mr, %x_rtc_pdu_apbif.prdata, %x_rtc_pdu_apbif.wen_clr = hw.instance "x_rtc_pdu_apbif" @rtc_pdu_apbif(aou_pdu_cr_reg: %aou_pdu_cr_reg: i4, aou_pdu_div_reg: %aou_pdu_div_reg: i20, aou_pdu_intr_mask: %aou_pdu_intr_mask: i1, aou_pdu_mr_reg: %aou_pdu_mr_reg: i32, cnt_sync: %x_rtc_cdr_sync.cnt_sync: i32, int_flag: %int_flag: i1, paddr: %paddr: i32, pclk: %pclk: i1, penable: %penable: i1, presetn: %presetn: i1, psel: %psel: i1, pwdata: %pwdata: i32, pwrite: %pwrite: i1, test_mode: %test_mode: i1) -> (pdu_aou_clr_reg: i32, pdu_aou_int_clr: i1, pdu_aou_wen_cr: i1, pdu_aou_wen_div: i1, pdu_aou_wen_mr: i1, prdata: i32, wen_clr: i1) {sv.namehint = "wen_clr"}
    %x_rtc_cdr_sync.cnt_sync = hw.instance "x_rtc_cdr_sync" @rtc_cdr_sync(aou_pdu_cnt: %aou_pdu_cnt: i32, pclk: %pclk: i1, presetn: %presetn: i1, test_mode: %test_mode: i1) -> (cnt_sync: i32) {sv.namehint = "cnt_sync"}
    %x_rtc_clr_sync.pdu_aou_wen_clr_sync = hw.instance "x_rtc_clr_sync" @rtc_clr_sync(pclk: %pclk: i1, presetn: %presetn: i1, rtc_clk: %rtc_clk: i1, test_mode: %test_mode: i1, wen_clr: %x_rtc_pdu_apbif.wen_clr: i1) -> (pdu_aou_wen_clr_sync: i1)
    hw.output %x_rtc_pdu_apbif.pdu_aou_clr_reg, %x_rtc_pdu_apbif.pdu_aou_int_clr, %x_rtc_clr_sync.pdu_aou_wen_clr_sync, %x_rtc_pdu_apbif.pdu_aou_wen_cr, %x_rtc_pdu_apbif.pdu_aou_wen_div, %x_rtc_pdu_apbif.pdu_aou_wen_mr, %x_rtc_pdu_apbif.prdata : i32, i1, i1, i1, i1, i1, i32
  }
}
