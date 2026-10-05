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
  hw.module @aou_top(in %apb1_gpio_psel_s5 : i1, in %apb1_pmu_psel_s15 : i1, in %apb1_rtc_psel_s6 : i1, in %apb1_xx_paddr : i32, in %apb1_xx_penable : i1, in %apb1_xx_pprot : i3, in %apb1_xx_pwdata : i32, in %apb1_xx_pwrite : i1, in %cpu_pmu_dfs_ack : i1, in %cpu_pmu_sleep_b : i1, out dft_clk : i1, in %ehs_pmu_clk : i1, in %els_pmu_clk : i1, out gpio_apb1_prdata : i32, out gpio_ioctl_porta_dr : i32, out gpio_wic_intr : i1, in %ioctl_gpio_ext_porta : i32, out pad_core_clk : i1, out pad_core_ctim_refclk : i1, out pad_core_rst_b : i1, out pad_gpio_ien : i32, out pad_gpio_oen : i32, in %pad_mcurst_b : i1, out pmu_apb0_pclk_en : i1, out pmu_apb0_s3clk : i1, out pmu_apb0_s3rst_b : i1, out pmu_apb1_pclk_en : i1, out pmu_apb1_prdata : i32, out pmu_apb1_s3clk : i1, out pmu_apb1_s3rst_b : i1, out pmu_cpu_dfs_req : i1, out pmu_dmac0_hclk : i1, out pmu_dmac0_hrst_b : i1, out pmu_dmemdummy0_hclk : i1, out pmu_dmemdummy0_hrst_b : i1, out pmu_dummy0_hclk : i1, out pmu_dummy0_hrst_b : i1, out pmu_dummy0_s3clk : i1, out pmu_dummy0_s3rst_b : i1, out pmu_dummy1_hclk : i1, out pmu_dummy1_hrst_b : i1, out pmu_dummy1_p0clk : i1, out pmu_dummy1_p0rst_b : i1, out pmu_dummy1_p1clk : i1, out pmu_dummy1_p1rst_b : i1, out pmu_dummy1_s3clk : i1, out pmu_dummy1_s3rst_b : i1, out pmu_dummy2_hclk : i1, out pmu_dummy2_hrst_b : i1, out pmu_dummy2_p0clk : i1, out pmu_dummy2_p0rst_b : i1, out pmu_dummy2_p1clk : i1, out pmu_dummy2_p1rst_b : i1, out pmu_dummy2_s3clk : i1, out pmu_dummy2_s3rst_b : i1, out pmu_dummy3_hclk : i1, out pmu_dummy3_hrst_b : i1, out pmu_dummy3_p0clk : i1, out pmu_dummy3_p0rst_b : i1, out pmu_dummy3_p1clk : i1, out pmu_dummy3_p1rst_b : i1, out pmu_dummy3_s3clk : i1, out pmu_dummy3_s3rst_b : i1, out pmu_dummy4_p0clk : i1, out pmu_dummy4_p0rst_b : i1, out pmu_dummy4_p1clk : i1, out pmu_dummy4_p1rst_b : i1, out pmu_dummy5_p0clk : i1, out pmu_dummy5_p0rst_b : i1, out pmu_dummy5_p1clk : i1, out pmu_dummy5_p1rst_b : i1, out pmu_dummy6_p1clk : i1, out pmu_dummy6_p1rst_b : i1, out pmu_dummy7_p0clk : i1, out pmu_dummy7_p0rst_b : i1, out pmu_dummy7_p1clk : i1, out pmu_dummy7_p1rst_b : i1, out pmu_dummy8_p0clk : i1, out pmu_dummy8_p0rst_b : i1, out pmu_dummy8_p1clk : i1, out pmu_dummy8_p1rst_b : i1, out pmu_dummy9_p0clk : i1, out pmu_dummy9_p0rst_b : i1, out pmu_hmain0_hclk : i1, out pmu_hmain0_hrst_b : i1, out pmu_imemdummy0_hclk : i1, out pmu_imemdummy0_hrst_b : i1, out pmu_lsbus_hclk : i1, out pmu_lsbus_hrst_b : i1, out pmu_mdummy0_hclk : i1, out pmu_mdummy0_hrst_b : i1, out pmu_mdummy1_hclk : i1, out pmu_mdummy1_hrst_b : i1, out pmu_mdummy2_hclk : i1, out pmu_mdummy2_hrst_b : i1, out pmu_pwm_p0clk : i1, out pmu_pwm_p0rst_b : i1, out pmu_smc_hclk : i1, out pmu_smc_hrst_b : i1, out pmu_sub3_s3clk : i1, out pmu_sub3_s3rst_b : i1, out pmu_tim0_p0clk : i1, out pmu_tim0_p0rst_b : i1, out pmu_tim1_p1clk : i1, out pmu_tim1_p1rst_b : i1, out pmu_tim2_p0clk : i1, out pmu_tim2_p0rst_b : i1, out pmu_tim3_p1clk : i1, out pmu_tim3_p1rst_b : i1, out pmu_tim4_p0clk : i1, out pmu_tim4_p0rst_b : i1, out pmu_tim5_p1clk : i1, out pmu_tim5_p1rst_b : i1, out pmu_tim6_p0clk : i1, out pmu_tim6_p0rst_b : i1, out pmu_tim7_p1clk : i1, out pmu_tim7_p1rst_b : i1, out pmu_usi0_p0clk : i1, out pmu_usi0_p0rst_b : i1, out pmu_usi1_p1clk : i1, out pmu_usi1_p1rst_b : i1, out pmu_usi2_p0clk : i1, out pmu_usi2_p0rst_b : i1, out pmu_wdt_p0clk : i1, out pmu_wdt_p0rst_b : i1, out pmu_wic_intr : i1, out rtc_apb1_prdata : i32, out rtc_wic_intr : i1, in %test_mode : i1, in %wdt_pmu_rst_b : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c-1_i32 = hw.constant -1 : i32
    %false = hw.constant false {sv.namehint = "tipc_rtc0_trust"}
    %c0_i32 = hw.constant 0 : i32
    %apb1_gpio_paddr = llhd.sig %c0_i32 : i32
    %apb1_gpio_pwdata = llhd.sig %c0_i32 : i32
    %apb1_pmu_paddr = llhd.sig %c0_i32 : i32
    %apb1_pmu_pwdata = llhd.sig %c0_i32 : i32
    %apb1_rtc_paddr = llhd.sig %c0_i32 : i32
    %apb1_rtc_pwdata = llhd.sig %c0_i32 : i32
    %pad_gpio_ien = llhd.sig %c0_i32 : i32
    %pad_gpio_oen = llhd.sig %c0_i32 : i32
    %1 = llhd.prb %apb1_pmu_paddr : i32
    %2 = llhd.prb %apb1_pmu_pwdata : i32
    %x_pmu_top.dft_clk, %x_pmu_top.pad_core_clk, %x_pmu_top.pad_core_ctim_refclk, %x_pmu_top.pad_core_rst_b, %x_pmu_top.pmu_apb0_pclk_en, %x_pmu_top.pmu_apb0_s3clk, %x_pmu_top.pmu_apb0_s3rst_b, %x_pmu_top.pmu_apb1_pclk_en, %x_pmu_top.pmu_apb1_s3clk, %x_pmu_top.pmu_apb1_s3rst_b, %x_pmu_top.pmu_cpu_dfs_req, %x_pmu_top.pmu_dmac0_hclk, %x_pmu_top.pmu_dmac0_hrst_b, %x_pmu_top.pmu_dmemdummy0_hclk, %x_pmu_top.pmu_dmemdummy0_hrst_b, %x_pmu_top.pmu_dummy0_hclk, %x_pmu_top.pmu_dummy0_hrst_b, %x_pmu_top.pmu_dummy0_s3clk, %x_pmu_top.pmu_dummy0_s3rst_b, %x_pmu_top.pmu_dummy1_hclk, %x_pmu_top.pmu_dummy1_hrst_b, %x_pmu_top.pmu_dummy1_p0clk, %x_pmu_top.pmu_dummy1_p0rst_b, %x_pmu_top.pmu_dummy1_p1clk, %x_pmu_top.pmu_dummy1_p1rst_b, %x_pmu_top.pmu_dummy1_s3clk, %x_pmu_top.pmu_dummy1_s3rst_b, %x_pmu_top.pmu_dummy2_hclk, %x_pmu_top.pmu_dummy2_hrst_b, %x_pmu_top.pmu_dummy2_p0clk, %x_pmu_top.pmu_dummy2_p0rst_b, %x_pmu_top.pmu_dummy2_p1clk, %x_pmu_top.pmu_dummy2_p1rst_b, %x_pmu_top.pmu_dummy2_s3clk, %x_pmu_top.pmu_dummy2_s3rst_b, %x_pmu_top.pmu_dummy3_hclk, %x_pmu_top.pmu_dummy3_hrst_b, %x_pmu_top.pmu_dummy3_p0clk, %x_pmu_top.pmu_dummy3_p0rst_b, %x_pmu_top.pmu_dummy3_p1clk, %x_pmu_top.pmu_dummy3_p1rst_b, %x_pmu_top.pmu_dummy3_s3clk, %x_pmu_top.pmu_dummy3_s3rst_b, %x_pmu_top.pmu_dummy4_p0clk, %x_pmu_top.pmu_dummy4_p0rst_b, %x_pmu_top.pmu_dummy4_p1clk, %x_pmu_top.pmu_dummy4_p1rst_b, %x_pmu_top.pmu_dummy5_p0clk, %x_pmu_top.pmu_dummy5_p0rst_b, %x_pmu_top.pmu_dummy5_p1clk, %x_pmu_top.pmu_dummy5_p1rst_b, %x_pmu_top.pmu_dummy6_p1clk, %x_pmu_top.pmu_dummy6_p1rst_b, %x_pmu_top.pmu_dummy7_p0clk, %x_pmu_top.pmu_dummy7_p0rst_b, %x_pmu_top.pmu_dummy7_p1clk, %x_pmu_top.pmu_dummy7_p1rst_b, %x_pmu_top.pmu_dummy8_p0clk, %x_pmu_top.pmu_dummy8_p0rst_b, %x_pmu_top.pmu_dummy8_p1clk, %x_pmu_top.pmu_dummy8_p1rst_b, %x_pmu_top.pmu_dummy9_p0clk, %x_pmu_top.pmu_dummy9_p0rst_b, %x_pmu_top.pmu_gpio_p1clk, %x_pmu_top.pmu_gpio_p1rst_b, %x_pmu_top.pmu_hmain0_hclk, %x_pmu_top.pmu_hmain0_hrst_b, %x_pmu_top.pmu_imemdummy0_hclk, %x_pmu_top.pmu_imemdummy0_hrst_b, %x_pmu_top.pmu_lsbus_hclk, %x_pmu_top.pmu_lsbus_hrst_b, %x_pmu_top.pmu_mdummy0_hclk, %x_pmu_top.pmu_mdummy0_hrst_b, %x_pmu_top.pmu_mdummy1_hclk, %x_pmu_top.pmu_mdummy1_hrst_b, %x_pmu_top.pmu_mdummy2_hclk, %x_pmu_top.pmu_mdummy2_hrst_b, %x_pmu_top.pmu_pwm_p0clk, %x_pmu_top.pmu_pwm_p0rst_b, %x_pmu_top.pmu_rtc_clk, %x_pmu_top.pmu_rtc_p1clk, %x_pmu_top.pmu_rtc_p1rst_b, %x_pmu_top.pmu_smc_hclk, %x_pmu_top.pmu_smc_hrst_b, %x_pmu_top.pmu_sub3_s3clk, %x_pmu_top.pmu_sub3_s3rst_b, %x_pmu_top.pmu_tim0_p0clk, %x_pmu_top.pmu_tim0_p0rst_b, %x_pmu_top.pmu_tim1_p1clk, %x_pmu_top.pmu_tim1_p1rst_b, %x_pmu_top.pmu_tim2_p0clk, %x_pmu_top.pmu_tim2_p0rst_b, %x_pmu_top.pmu_tim3_p1clk, %x_pmu_top.pmu_tim3_p1rst_b, %x_pmu_top.pmu_tim4_p0clk, %x_pmu_top.pmu_tim4_p0rst_b, %x_pmu_top.pmu_tim5_p1clk, %x_pmu_top.pmu_tim5_p1rst_b, %x_pmu_top.pmu_tim6_p0clk, %x_pmu_top.pmu_tim6_p0rst_b, %x_pmu_top.pmu_tim7_p1clk, %x_pmu_top.pmu_tim7_p1rst_b, %x_pmu_top.pmu_usi0_p0clk, %x_pmu_top.pmu_usi0_p0rst_b, %x_pmu_top.pmu_usi1_p1clk, %x_pmu_top.pmu_usi1_p1rst_b, %x_pmu_top.pmu_usi2_p0clk, %x_pmu_top.pmu_usi2_p0rst_b, %x_pmu_top.pmu_wdt_p0clk, %x_pmu_top.pmu_wdt_p0rst_b, %x_pmu_top.pmu_wic_intr, %x_pmu_top.prdata = hw.instance "x_pmu_top" @pmu_dummy_top(cpu_pmu_dfs_ack: %cpu_pmu_dfs_ack: i1, cpu_pmu_sleep_b: %cpu_pmu_sleep_b: i1, ehs_pmu_clk: %ehs_pmu_clk: i1, els_pmu_clk: %els_pmu_clk: i1, pad_mcurst_b: %pad_mcurst_b: i1, paddr: %1: i32, penable: %apb1_xx_penable: i1, pprot: %apb1_xx_pprot: i3, psel: %apb1_pmu_psel_s15: i1, pwdata: %2: i32, pwrite: %apb1_xx_pwrite: i1, wdt_pmu_rst_b: %wdt_pmu_rst_b: i1) -> (dft_clk: i1, pad_core_clk: i1, pad_core_ctim_refclk: i1, pad_core_rst_b: i1, pmu_apb0_pclk_en: i1, pmu_apb0_s3clk: i1, pmu_apb0_s3rst_b: i1, pmu_apb1_pclk_en: i1, pmu_apb1_s3clk: i1, pmu_apb1_s3rst_b: i1, pmu_cpu_dfs_req: i1, pmu_dmac0_hclk: i1, pmu_dmac0_hrst_b: i1, pmu_dmemdummy0_hclk: i1, pmu_dmemdummy0_hrst_b: i1, pmu_dummy0_hclk: i1, pmu_dummy0_hrst_b: i1, pmu_dummy0_s3clk: i1, pmu_dummy0_s3rst_b: i1, pmu_dummy1_hclk: i1, pmu_dummy1_hrst_b: i1, pmu_dummy1_p0clk: i1, pmu_dummy1_p0rst_b: i1, pmu_dummy1_p1clk: i1, pmu_dummy1_p1rst_b: i1, pmu_dummy1_s3clk: i1, pmu_dummy1_s3rst_b: i1, pmu_dummy2_hclk: i1, pmu_dummy2_hrst_b: i1, pmu_dummy2_p0clk: i1, pmu_dummy2_p0rst_b: i1, pmu_dummy2_p1clk: i1, pmu_dummy2_p1rst_b: i1, pmu_dummy2_s3clk: i1, pmu_dummy2_s3rst_b: i1, pmu_dummy3_hclk: i1, pmu_dummy3_hrst_b: i1, pmu_dummy3_p0clk: i1, pmu_dummy3_p0rst_b: i1, pmu_dummy3_p1clk: i1, pmu_dummy3_p1rst_b: i1, pmu_dummy3_s3clk: i1, pmu_dummy3_s3rst_b: i1, pmu_dummy4_p0clk: i1, pmu_dummy4_p0rst_b: i1, pmu_dummy4_p1clk: i1, pmu_dummy4_p1rst_b: i1, pmu_dummy5_p0clk: i1, pmu_dummy5_p0rst_b: i1, pmu_dummy5_p1clk: i1, pmu_dummy5_p1rst_b: i1, pmu_dummy6_p1clk: i1, pmu_dummy6_p1rst_b: i1, pmu_dummy7_p0clk: i1, pmu_dummy7_p0rst_b: i1, pmu_dummy7_p1clk: i1, pmu_dummy7_p1rst_b: i1, pmu_dummy8_p0clk: i1, pmu_dummy8_p0rst_b: i1, pmu_dummy8_p1clk: i1, pmu_dummy8_p1rst_b: i1, pmu_dummy9_p0clk: i1, pmu_dummy9_p0rst_b: i1, pmu_gpio_p1clk: i1, pmu_gpio_p1rst_b: i1, pmu_hmain0_hclk: i1, pmu_hmain0_hrst_b: i1, pmu_imemdummy0_hclk: i1, pmu_imemdummy0_hrst_b: i1, pmu_lsbus_hclk: i1, pmu_lsbus_hrst_b: i1, pmu_mdummy0_hclk: i1, pmu_mdummy0_hrst_b: i1, pmu_mdummy1_hclk: i1, pmu_mdummy1_hrst_b: i1, pmu_mdummy2_hclk: i1, pmu_mdummy2_hrst_b: i1, pmu_pwm_p0clk: i1, pmu_pwm_p0rst_b: i1, pmu_rtc_clk: i1, pmu_rtc_p1clk: i1, pmu_rtc_p1rst_b: i1, pmu_smc_hclk: i1, pmu_smc_hrst_b: i1, pmu_sub3_s3clk: i1, pmu_sub3_s3rst_b: i1, pmu_tim0_p0clk: i1, pmu_tim0_p0rst_b: i1, pmu_tim1_p1clk: i1, pmu_tim1_p1rst_b: i1, pmu_tim2_p0clk: i1, pmu_tim2_p0rst_b: i1, pmu_tim3_p1clk: i1, pmu_tim3_p1rst_b: i1, pmu_tim4_p0clk: i1, pmu_tim4_p0rst_b: i1, pmu_tim5_p1clk: i1, pmu_tim5_p1rst_b: i1, pmu_tim6_p0clk: i1, pmu_tim6_p0rst_b: i1, pmu_tim7_p1clk: i1, pmu_tim7_p1rst_b: i1, pmu_usi0_p0clk: i1, pmu_usi0_p0rst_b: i1, pmu_usi1_p1clk: i1, pmu_usi1_p1rst_b: i1, pmu_usi2_p0clk: i1, pmu_usi2_p0rst_b: i1, pmu_wdt_p0clk: i1, pmu_wdt_p0rst_b: i1, pmu_wic_intr: i1, prdata: i32) {sv.namehint = "pmu_rtc_clk"}
    %3 = llhd.prb %apb1_gpio_paddr : i32
    %4 = llhd.prb %apb1_gpio_pwdata : i32
    %x_gpio_sec_top.gpio0_etb_trig, %x_gpio_sec_top.gpio_intr_flag, %x_gpio_sec_top.gpio_intrclk_en, %x_gpio_sec_top.gpio_porta_ddr, %x_gpio_sec_top.gpio_porta_dr, %x_gpio_sec_top.prdata = hw.instance "x_gpio_sec_top" @gpio0_sec_top(gpio_ext_porta: %ioctl_gpio_ext_porta: i32, paddr: %3: i32, pclk: %x_pmu_top.pmu_gpio_p1clk: i1, pclk_intr: %x_pmu_top.pmu_gpio_p1clk: i1, penable: %apb1_xx_penable: i1, pprot: %apb1_xx_pprot: i3, presetn: %x_pmu_top.pmu_gpio_p1rst_b: i1, psel: %apb1_gpio_psel_s5: i1, pwdata: %4: i32, pwrite: %apb1_xx_pwrite: i1, tipc_gpio0_trust: %false: i1) -> (gpio0_etb_trig: i32, gpio_intr_flag: i1, gpio_intrclk_en: i1, gpio_porta_ddr: i32, gpio_porta_dr: i32, prdata: i32) {sv.namehint = "gpio0_etb_trig"}
    %5 = comb.xor %x_gpio_sec_top.gpio_porta_ddr, %c-1_i32 : i32
    llhd.drv %pad_gpio_oen, %5 after %0 : i32
    llhd.drv %pad_gpio_ien, %x_gpio_sec_top.gpio_porta_ddr after %0 : i32
    %6 = llhd.prb %apb1_rtc_paddr : i32
    %7 = llhd.prb %apb1_rtc_pwdata : i32
    %x_rtc0_sec_top.aortc_prdata, %x_rtc0_sec_top.rtc0_vic_intr, %x_rtc0_sec_top.rtc_etb_trig = hw.instance "x_rtc0_sec_top" @rtc0_sec_top(aortc_paddr: %6: i32, aortc_pclk: %x_pmu_top.pmu_rtc_p1clk: i1, aortc_penable: %apb1_xx_penable: i1, aortc_pprot: %apb1_xx_pprot: i3, aortc_psel: %apb1_rtc_psel_s6: i1, aortc_pwdata: %7: i32, aortc_pwrite: %apb1_xx_pwrite: i1, aortc_rst_n: %x_pmu_top.pmu_rtc_p1rst_b: i1, etb_rtc_trig: %false: i1, i_rtc_ext_clk: %x_pmu_top.pmu_rtc_clk: i1, test_mode: %test_mode: i1, tipc_rtc0_trust: %false: i1) -> (aortc_prdata: i32, rtc0_vic_intr: i1, rtc_etb_trig: i1) {sv.namehint = "rtc_etb_trig"}
    llhd.drv %apb1_pmu_paddr, %apb1_xx_paddr after %0 : i32
    llhd.drv %apb1_pmu_pwdata, %apb1_xx_pwdata after %0 : i32
    llhd.drv %apb1_gpio_paddr, %apb1_xx_paddr after %0 : i32
    llhd.drv %apb1_gpio_pwdata, %apb1_xx_pwdata after %0 : i32
    llhd.drv %apb1_rtc_paddr, %apb1_xx_paddr after %0 : i32
    llhd.drv %apb1_rtc_pwdata, %apb1_xx_pwdata after %0 : i32
    %8 = llhd.prb %pad_gpio_ien : i32
    %9 = llhd.prb %pad_gpio_oen : i32
    hw.output %x_pmu_top.dft_clk, %x_gpio_sec_top.prdata, %x_gpio_sec_top.gpio_porta_dr, %x_gpio_sec_top.gpio_intr_flag, %x_pmu_top.pad_core_clk, %x_pmu_top.pad_core_ctim_refclk, %x_pmu_top.pad_core_rst_b, %8, %9, %x_pmu_top.pmu_apb0_pclk_en, %x_pmu_top.pmu_apb0_s3clk, %x_pmu_top.pmu_apb0_s3rst_b, %x_pmu_top.pmu_apb1_pclk_en, %x_pmu_top.prdata, %x_pmu_top.pmu_apb1_s3clk, %x_pmu_top.pmu_apb1_s3rst_b, %x_pmu_top.pmu_cpu_dfs_req, %x_pmu_top.pmu_dmac0_hclk, %x_pmu_top.pmu_dmac0_hrst_b, %x_pmu_top.pmu_dmemdummy0_hclk, %x_pmu_top.pmu_dmemdummy0_hrst_b, %x_pmu_top.pmu_dummy0_hclk, %x_pmu_top.pmu_dummy0_hrst_b, %x_pmu_top.pmu_dummy0_s3clk, %x_pmu_top.pmu_dummy0_s3rst_b, %x_pmu_top.pmu_dummy1_hclk, %x_pmu_top.pmu_dummy1_hrst_b, %x_pmu_top.pmu_dummy1_p0clk, %x_pmu_top.pmu_dummy1_p0rst_b, %x_pmu_top.pmu_dummy1_p1clk, %x_pmu_top.pmu_dummy1_p1rst_b, %x_pmu_top.pmu_dummy1_s3clk, %x_pmu_top.pmu_dummy1_s3rst_b, %x_pmu_top.pmu_dummy2_hclk, %x_pmu_top.pmu_dummy2_hrst_b, %x_pmu_top.pmu_dummy2_p0clk, %x_pmu_top.pmu_dummy2_p0rst_b, %x_pmu_top.pmu_dummy2_p1clk, %x_pmu_top.pmu_dummy2_p1rst_b, %x_pmu_top.pmu_dummy2_s3clk, %x_pmu_top.pmu_dummy2_s3rst_b, %x_pmu_top.pmu_dummy3_hclk, %x_pmu_top.pmu_dummy3_hrst_b, %x_pmu_top.pmu_dummy3_p0clk, %x_pmu_top.pmu_dummy3_p0rst_b, %x_pmu_top.pmu_dummy3_p1clk, %x_pmu_top.pmu_dummy3_p1rst_b, %x_pmu_top.pmu_dummy3_s3clk, %x_pmu_top.pmu_dummy3_s3rst_b, %x_pmu_top.pmu_dummy4_p0clk, %x_pmu_top.pmu_dummy4_p0rst_b, %x_pmu_top.pmu_dummy4_p1clk, %x_pmu_top.pmu_dummy4_p1rst_b, %x_pmu_top.pmu_dummy5_p0clk, %x_pmu_top.pmu_dummy5_p0rst_b, %x_pmu_top.pmu_dummy5_p1clk, %x_pmu_top.pmu_dummy5_p1rst_b, %x_pmu_top.pmu_dummy6_p1clk, %x_pmu_top.pmu_dummy6_p1rst_b, %x_pmu_top.pmu_dummy7_p0clk, %x_pmu_top.pmu_dummy7_p0rst_b, %x_pmu_top.pmu_dummy7_p1clk, %x_pmu_top.pmu_dummy7_p1rst_b, %x_pmu_top.pmu_dummy8_p0clk, %x_pmu_top.pmu_dummy8_p0rst_b, %x_pmu_top.pmu_dummy8_p1clk, %x_pmu_top.pmu_dummy8_p1rst_b, %x_pmu_top.pmu_dummy9_p0clk, %x_pmu_top.pmu_dummy9_p0rst_b, %x_pmu_top.pmu_hmain0_hclk, %x_pmu_top.pmu_hmain0_hrst_b, %x_pmu_top.pmu_imemdummy0_hclk, %x_pmu_top.pmu_imemdummy0_hrst_b, %x_pmu_top.pmu_lsbus_hclk, %x_pmu_top.pmu_lsbus_hrst_b, %x_pmu_top.pmu_mdummy0_hclk, %x_pmu_top.pmu_mdummy0_hrst_b, %x_pmu_top.pmu_mdummy1_hclk, %x_pmu_top.pmu_mdummy1_hrst_b, %x_pmu_top.pmu_mdummy2_hclk, %x_pmu_top.pmu_mdummy2_hrst_b, %x_pmu_top.pmu_pwm_p0clk, %x_pmu_top.pmu_pwm_p0rst_b, %x_pmu_top.pmu_smc_hclk, %x_pmu_top.pmu_smc_hrst_b, %x_pmu_top.pmu_sub3_s3clk, %x_pmu_top.pmu_sub3_s3rst_b, %x_pmu_top.pmu_tim0_p0clk, %x_pmu_top.pmu_tim0_p0rst_b, %x_pmu_top.pmu_tim1_p1clk, %x_pmu_top.pmu_tim1_p1rst_b, %x_pmu_top.pmu_tim2_p0clk, %x_pmu_top.pmu_tim2_p0rst_b, %x_pmu_top.pmu_tim3_p1clk, %x_pmu_top.pmu_tim3_p1rst_b, %x_pmu_top.pmu_tim4_p0clk, %x_pmu_top.pmu_tim4_p0rst_b, %x_pmu_top.pmu_tim5_p1clk, %x_pmu_top.pmu_tim5_p1rst_b, %x_pmu_top.pmu_tim6_p0clk, %x_pmu_top.pmu_tim6_p0rst_b, %x_pmu_top.pmu_tim7_p1clk, %x_pmu_top.pmu_tim7_p1rst_b, %x_pmu_top.pmu_usi0_p0clk, %x_pmu_top.pmu_usi0_p0rst_b, %x_pmu_top.pmu_usi1_p1clk, %x_pmu_top.pmu_usi1_p1rst_b, %x_pmu_top.pmu_usi2_p0clk, %x_pmu_top.pmu_usi2_p0rst_b, %x_pmu_top.pmu_wdt_p0clk, %x_pmu_top.pmu_wdt_p0rst_b, %x_pmu_top.pmu_wic_intr, %x_rtc0_sec_top.aortc_prdata, %x_rtc0_sec_top.rtc0_vic_intr : i1, i32, i32, i1, i1, i1, i1, i32, i32, i1, i1, i1, i1, i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i32, i1
  }
  hw.module private @pmu_dummy_top(in %cpu_pmu_dfs_ack : i1, in %cpu_pmu_sleep_b : i1, out dft_clk : i1, in %ehs_pmu_clk : i1, in %els_pmu_clk : i1, out pad_core_clk : i1, out pad_core_ctim_refclk : i1, out pad_core_rst_b : i1, in %pad_mcurst_b : i1, in %paddr : i32, in %penable : i1, out pmu_apb0_pclk_en : i1, out pmu_apb0_s3clk : i1, out pmu_apb0_s3rst_b : i1, out pmu_apb1_pclk_en : i1, out pmu_apb1_s3clk : i1, out pmu_apb1_s3rst_b : i1, out pmu_cpu_dfs_req : i1, out pmu_dmac0_hclk : i1, out pmu_dmac0_hrst_b : i1, out pmu_dmemdummy0_hclk : i1, out pmu_dmemdummy0_hrst_b : i1, out pmu_dummy0_hclk : i1, out pmu_dummy0_hrst_b : i1, out pmu_dummy0_s3clk : i1, out pmu_dummy0_s3rst_b : i1, out pmu_dummy1_hclk : i1, out pmu_dummy1_hrst_b : i1, out pmu_dummy1_p0clk : i1, out pmu_dummy1_p0rst_b : i1, out pmu_dummy1_p1clk : i1, out pmu_dummy1_p1rst_b : i1, out pmu_dummy1_s3clk : i1, out pmu_dummy1_s3rst_b : i1, out pmu_dummy2_hclk : i1, out pmu_dummy2_hrst_b : i1, out pmu_dummy2_p0clk : i1, out pmu_dummy2_p0rst_b : i1, out pmu_dummy2_p1clk : i1, out pmu_dummy2_p1rst_b : i1, out pmu_dummy2_s3clk : i1, out pmu_dummy2_s3rst_b : i1, out pmu_dummy3_hclk : i1, out pmu_dummy3_hrst_b : i1, out pmu_dummy3_p0clk : i1, out pmu_dummy3_p0rst_b : i1, out pmu_dummy3_p1clk : i1, out pmu_dummy3_p1rst_b : i1, out pmu_dummy3_s3clk : i1, out pmu_dummy3_s3rst_b : i1, out pmu_dummy4_p0clk : i1, out pmu_dummy4_p0rst_b : i1, out pmu_dummy4_p1clk : i1, out pmu_dummy4_p1rst_b : i1, out pmu_dummy5_p0clk : i1, out pmu_dummy5_p0rst_b : i1, out pmu_dummy5_p1clk : i1, out pmu_dummy5_p1rst_b : i1, out pmu_dummy6_p1clk : i1, out pmu_dummy6_p1rst_b : i1, out pmu_dummy7_p0clk : i1, out pmu_dummy7_p0rst_b : i1, out pmu_dummy7_p1clk : i1, out pmu_dummy7_p1rst_b : i1, out pmu_dummy8_p0clk : i1, out pmu_dummy8_p0rst_b : i1, out pmu_dummy8_p1clk : i1, out pmu_dummy8_p1rst_b : i1, out pmu_dummy9_p0clk : i1, out pmu_dummy9_p0rst_b : i1, out pmu_gpio_p1clk : i1, out pmu_gpio_p1rst_b : i1, out pmu_hmain0_hclk : i1, out pmu_hmain0_hrst_b : i1, out pmu_imemdummy0_hclk : i1, out pmu_imemdummy0_hrst_b : i1, out pmu_lsbus_hclk : i1, out pmu_lsbus_hrst_b : i1, out pmu_mdummy0_hclk : i1, out pmu_mdummy0_hrst_b : i1, out pmu_mdummy1_hclk : i1, out pmu_mdummy1_hrst_b : i1, out pmu_mdummy2_hclk : i1, out pmu_mdummy2_hrst_b : i1, out pmu_pwm_p0clk : i1, out pmu_pwm_p0rst_b : i1, out pmu_rtc_clk : i1, out pmu_rtc_p1clk : i1, out pmu_rtc_p1rst_b : i1, out pmu_smc_hclk : i1, out pmu_smc_hrst_b : i1, out pmu_sub3_s3clk : i1, out pmu_sub3_s3rst_b : i1, out pmu_tim0_p0clk : i1, out pmu_tim0_p0rst_b : i1, out pmu_tim1_p1clk : i1, out pmu_tim1_p1rst_b : i1, out pmu_tim2_p0clk : i1, out pmu_tim2_p0rst_b : i1, out pmu_tim3_p1clk : i1, out pmu_tim3_p1rst_b : i1, out pmu_tim4_p0clk : i1, out pmu_tim4_p0rst_b : i1, out pmu_tim5_p1clk : i1, out pmu_tim5_p1rst_b : i1, out pmu_tim6_p0clk : i1, out pmu_tim6_p0rst_b : i1, out pmu_tim7_p1clk : i1, out pmu_tim7_p1rst_b : i1, out pmu_usi0_p0clk : i1, out pmu_usi0_p0rst_b : i1, out pmu_usi1_p1clk : i1, out pmu_usi1_p1rst_b : i1, out pmu_usi2_p0clk : i1, out pmu_usi2_p0rst_b : i1, out pmu_wdt_p0clk : i1, out pmu_wdt_p0rst_b : i1, out pmu_wic_intr : i1, in %pprot : i3, out prdata : i32, in %psel : i1, in %pwdata : i32, in %pwrite : i1, in %wdt_pmu_rst_b : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %prdata = llhd.sig %c0_i32 : i32
    llhd.drv %prdata, %c0_i32 after %0 : i32
    %1 = comb.and %pad_mcurst_b, %wdt_pmu_rst_b {sv.namehint = "sys_rst_b"} : i1
    %2 = llhd.prb %prdata : i32
    hw.output %ehs_pmu_clk, %ehs_pmu_clk, %ehs_pmu_clk, %1, %true, %ehs_pmu_clk, %1, %true, %ehs_pmu_clk, %1, %false, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %els_pmu_clk, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %ehs_pmu_clk, %1, %false, %2 : i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i32
  }
  hw.module private @gpio0(out gpio0_etb_trig : i32, in %gpio_ext_porta : i32, out gpio_intr_flag : i1, out gpio_intrclk_en : i1, out gpio_porta_ddr : i32, out gpio_porta_dr : i32, in %paddr : i32, in %pclk : i1, in %pclk_intr : i1, in %penable : i1, out prdata : i32, in %presetn : i1, in %psel : i1, in %pwdata : i32, in %pwrite : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %prdata = llhd.sig %c0_i32 : i32
    %1 = comb.extract %paddr from 0 : (i32) -> i7
    %x_gpio_top.gpio_etb_trig, %x_gpio_top.gpio_out_data, %x_gpio_top.gpio_out_en, %x_gpio_top.gpio_int_flag, %x_gpio_top.gpio_int_clk_en, %x_gpio_top.prdata = hw.instance "x_gpio_top" @gpio_top(pclk: %pclk: i1, pclk_int: %pclk_intr: i1, dbclk: %pclk: i1, dbclk_rstn: %presetn: i1, scan_mode: %false: i1, presetn: %presetn: i1, penable: %penable: i1, pwrite: %pwrite: i1, pwdata: %pwdata: i32, paddr: %1: i7, psel: %psel: i1, gpio_in_data: %gpio_ext_porta: i32) -> (gpio_etb_trig: i32, gpio_out_data: i32, gpio_out_en: i32, gpio_int_flag: i1, gpio_int_clk_en: i1, prdata: i32) {sv.namehint = "gpio0_prdata"}
    llhd.drv %prdata, %x_gpio_top.prdata after %0 : i32
    %2 = llhd.prb %prdata : i32
    hw.output %x_gpio_top.gpio_etb_trig, %x_gpio_top.gpio_int_flag, %x_gpio_top.gpio_int_clk_en, %x_gpio_top.gpio_out_en, %x_gpio_top.gpio_out_data, %2 : i32, i1, i1, i32, i32, i32
  }
  hw.module private @gpio0_sec_top(out gpio0_etb_trig : i32, in %gpio_ext_porta : i32, out gpio_intr_flag : i1, out gpio_intrclk_en : i1, out gpio_porta_ddr : i32, out gpio_porta_dr : i32, in %paddr : i32, in %pclk : i1, in %pclk_intr : i1, in %penable : i1, in %pprot : i3, out prdata : i32, in %presetn : i1, in %psel : i1, in %pwdata : i32, in %pwrite : i1, in %tipc_gpio0_trust : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %prdata = llhd.sig %c0_i32 : i32
    %x_gpio0.gpio0_etb_trig, %x_gpio0.gpio_intr_flag, %x_gpio0.gpio_intrclk_en, %x_gpio0.gpio_porta_ddr, %x_gpio0.gpio_porta_dr, %x_gpio0.prdata = hw.instance "x_gpio0" @gpio0(gpio_ext_porta: %gpio_ext_porta: i32, paddr: %paddr: i32, pclk: %pclk: i1, pclk_intr: %pclk_intr: i1, penable: %penable: i1, presetn: %presetn: i1, psel: %psel: i1, pwdata: %pwdata: i32, pwrite: %pwrite: i1) -> (gpio0_etb_trig: i32, gpio_intr_flag: i1, gpio_intrclk_en: i1, gpio_porta_ddr: i32, gpio_porta_dr: i32, prdata: i32) {sv.namehint = "i_prdata"}
    llhd.drv %prdata, %x_gpio0.prdata after %0 : i32
    %1 = llhd.prb %prdata : i32
    hw.output %x_gpio0.gpio0_etb_trig, %x_gpio0.gpio_intr_flag, %x_gpio0.gpio_intrclk_en, %x_gpio0.gpio_porta_ddr, %x_gpio0.gpio_porta_dr, %1 : i32, i1, i1, i32, i32, i32
  }
  hw.module private @gpio_apbif(in %pclk : i1, in %presetn : i1, in %penable : i1, in %pwrite : i1, in %pwdata : i32, in %paddr : i7, in %psel : i1, in %gpio_ext_data : i32, in %gpio_int_status : i32, in %gpio_raw_int_status : i32, out gpio_sw_data : i32, out gpio_sw_dir : i32, out gpio_int_en : i32, out gpio_int_mask : i32, out gpio_int_type : i32, out gpio_int_pol : i32, out gpio_debounce : i32, out gpio_int_clr : i32, out gpio_int_level_sync : i1, out prdata : i32) {
    %c0_i27 = hw.constant 0 : i27
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i7 = hw.constant 0 : i7
    %c20_i32 = hw.constant 20 : i32
    %c24_i32 = hw.constant 24 : i32
    %c18_i32 = hw.constant 18 : i32
    %c17_i32 = hw.constant 17 : i32
    %c16_i32 = hw.constant 16 : i32
    %c15_i32 = hw.constant 15 : i32
    %c14_i32 = hw.constant 14 : i32
    %c13_i32 = hw.constant 13 : i32
    %c12_i32 = hw.constant 12 : i32
    %c2_i32 = hw.constant 2 : i32
    %c1_i32 = hw.constant 1 : i32
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %c-8_i5 = hw.constant -8 : i5
    %c15_i5 = hw.constant 15 : i5
    %c14_i5 = hw.constant 14 : i5
    %c13_i5 = hw.constant 13 : i5
    %c12_i5 = hw.constant 12 : i5
    %c1_i5 = hw.constant 1 : i5
    %c0_i5 = hw.constant 0 : i5
    %true = hw.constant true
    %pclk_0 = llhd.sig name "pclk" %false : i1
    %2 = llhd.prb %pclk_0 : i1
    %presetn_1 = llhd.sig name "presetn" %false : i1
    %3 = llhd.prb %presetn_1 : i1
    %penable_2 = llhd.sig name "penable" %false : i1
    %pwrite_3 = llhd.sig name "pwrite" %false : i1
    %pwdata_4 = llhd.sig name "pwdata" %c0_i32 : i32
    %paddr_5 = llhd.sig name "paddr" %c0_i7 : i7
    %psel_6 = llhd.sig name "psel" %false : i1
    %gpio_ext_data_7 = llhd.sig name "gpio_ext_data" %c0_i32 : i32
    %gpio_int_status_8 = llhd.sig name "gpio_int_status" %c0_i32 : i32
    %gpio_raw_int_status_9 = llhd.sig name "gpio_raw_int_status" %c0_i32 : i32
    %gpio_sw_data = llhd.sig %c0_i32 : i32
    %gpio_sw_dir = llhd.sig %c0_i32 : i32
    %gpio_int_en = llhd.sig %c0_i32 : i32
    %gpio_int_mask = llhd.sig %c0_i32 : i32
    %gpio_int_type = llhd.sig %c0_i32 : i32
    %gpio_int_pol = llhd.sig %c0_i32 : i32
    %gpio_debounce = llhd.sig %c0_i32 : i32
    %gpio_int_clr = llhd.sig %c0_i32 : i32
    %gpio_int_level_sync = llhd.sig %false : i1
    %prdata = llhd.sig %c0_i32 : i32
    %gpio_sw_data_wen = llhd.sig %false : i1
    %gpio_sw_dir_wen = llhd.sig %false : i1
    %gpio_int_en_wen = llhd.sig %false : i1
    %gpio_int_mask_wen = llhd.sig %false : i1
    %gpio_int_type_wen = llhd.sig %false : i1
    %gpio_int_pol_wen = llhd.sig %false : i1
    %gpio_debounce_wen = llhd.sig %false : i1
    %gpio_int_level_sync_wen = llhd.sig %false : i1
    %gpio_int_clr_wen = llhd.sig %false : i1
    %ri_gpio_sw_data = llhd.sig %c0_i32 : i32
    %ri_gpio_sw_dir = llhd.sig %c0_i32 : i32
    %ri_gpio_int_en = llhd.sig %c0_i32 : i32
    %ri_gpio_int_mask = llhd.sig %c0_i32 : i32
    %ri_gpio_int_type = llhd.sig %c0_i32 : i32
    %ri_gpio_int_pol = llhd.sig %c0_i32 : i32
    %ri_gpio_debounce = llhd.sig %c0_i32 : i32
    %ri_gpio_int_level_sync = llhd.sig %c0_i32 : i32
    %ri_gpio_ext_data = llhd.sig %c0_i32 : i32
    %ri_gpio_raw_int_status = llhd.sig %c0_i32 : i32
    %ri_gpio_int_status = llhd.sig %c0_i32 : i32
    %zero_value = llhd.sig %false : i1
    llhd.drv %zero_value, %false after %1 : i1
    %4 = llhd.prb %psel_6 : i1
    %5 = llhd.prb %penable_2 : i1
    %6 = llhd.prb %pwrite_3 : i1
    %7 = llhd.prb %paddr_5 : i7
    %8 = llhd.prb %gpio_sw_data_wen : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %43 = llhd.prb %psel_6 : i1
      %44 = llhd.prb %penable_2 : i1
      %45 = llhd.prb %pwrite_3 : i1
      %46 = comb.and %43, %44, %45 : i1
      cf.cond_br %46, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %47 = llhd.prb %paddr_5 : i7
      %48 = comb.extract %47 from 2 : (i7) -> i5
      %49 = comb.icmp eq %48, %c0_i5 : i5
      cf.cond_br %49, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %gpio_sw_data_wen, %true after %1 : i1
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      llhd.drv %gpio_sw_data_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb5:  // pred: ^bb1
      llhd.drv %gpio_sw_data_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
      llhd.wait (%4, %5, %6, %7, %8 : i1, i1, i1, i7, i1), ^bb1
    }
    %9 = llhd.prb %gpio_sw_dir_wen : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %43 = llhd.prb %psel_6 : i1
      %44 = llhd.prb %penable_2 : i1
      %45 = llhd.prb %pwrite_3 : i1
      %46 = comb.and %43, %44, %45 : i1
      cf.cond_br %46, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %47 = llhd.prb %paddr_5 : i7
      %48 = comb.extract %47 from 2 : (i7) -> i5
      %49 = comb.icmp eq %48, %c1_i5 : i5
      cf.cond_br %49, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %gpio_sw_dir_wen, %true after %1 : i1
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      llhd.drv %gpio_sw_dir_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb5:  // pred: ^bb1
      llhd.drv %gpio_sw_dir_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
      llhd.wait (%4, %5, %6, %7, %9 : i1, i1, i1, i7, i1), ^bb1
    }
    %10 = llhd.prb %gpio_int_en_wen : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %43 = llhd.prb %psel_6 : i1
      %44 = llhd.prb %penable_2 : i1
      %45 = llhd.prb %pwrite_3 : i1
      %46 = comb.and %43, %44, %45 : i1
      cf.cond_br %46, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %47 = llhd.prb %paddr_5 : i7
      %48 = comb.extract %47 from 2 : (i7) -> i5
      %49 = comb.icmp eq %48, %c12_i5 : i5
      cf.cond_br %49, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %gpio_int_en_wen, %true after %1 : i1
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      llhd.drv %gpio_int_en_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb5:  // pred: ^bb1
      llhd.drv %gpio_int_en_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
      llhd.wait (%4, %5, %6, %7, %10 : i1, i1, i1, i7, i1), ^bb1
    }
    %11 = llhd.prb %gpio_int_mask_wen : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %43 = llhd.prb %psel_6 : i1
      %44 = llhd.prb %penable_2 : i1
      %45 = llhd.prb %pwrite_3 : i1
      %46 = comb.and %43, %44, %45 : i1
      cf.cond_br %46, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %47 = llhd.prb %paddr_5 : i7
      %48 = comb.extract %47 from 2 : (i7) -> i5
      %49 = comb.icmp eq %48, %c13_i5 : i5
      cf.cond_br %49, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %gpio_int_mask_wen, %true after %1 : i1
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      llhd.drv %gpio_int_mask_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb5:  // pred: ^bb1
      llhd.drv %gpio_int_mask_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
      llhd.wait (%4, %5, %6, %7, %11 : i1, i1, i1, i7, i1), ^bb1
    }
    %12 = llhd.prb %gpio_int_type_wen : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %43 = llhd.prb %psel_6 : i1
      %44 = llhd.prb %penable_2 : i1
      %45 = llhd.prb %pwrite_3 : i1
      %46 = comb.and %43, %44, %45 : i1
      cf.cond_br %46, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %47 = llhd.prb %paddr_5 : i7
      %48 = comb.extract %47 from 2 : (i7) -> i5
      %49 = comb.icmp eq %48, %c14_i5 : i5
      cf.cond_br %49, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %gpio_int_type_wen, %true after %1 : i1
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      llhd.drv %gpio_int_type_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb5:  // pred: ^bb1
      llhd.drv %gpio_int_type_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
      llhd.wait (%4, %5, %6, %7, %12 : i1, i1, i1, i7, i1), ^bb1
    }
    %13 = llhd.prb %gpio_int_pol_wen : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %43 = llhd.prb %psel_6 : i1
      %44 = llhd.prb %penable_2 : i1
      %45 = llhd.prb %pwrite_3 : i1
      %46 = comb.and %43, %44, %45 : i1
      cf.cond_br %46, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %47 = llhd.prb %paddr_5 : i7
      %48 = comb.extract %47 from 2 : (i7) -> i5
      %49 = comb.icmp eq %48, %c15_i5 : i5
      cf.cond_br %49, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %gpio_int_pol_wen, %true after %1 : i1
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      llhd.drv %gpio_int_pol_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb5:  // pred: ^bb1
      llhd.drv %gpio_int_pol_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
      llhd.wait (%4, %5, %6, %7, %13 : i1, i1, i1, i7, i1), ^bb1
    }
    %14 = llhd.prb %gpio_int_level_sync_wen : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %43 = llhd.prb %psel_6 : i1
      %44 = llhd.prb %penable_2 : i1
      %45 = llhd.prb %pwrite_3 : i1
      %46 = comb.and %43, %44, %45 : i1
      cf.cond_br %46, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %47 = llhd.prb %paddr_5 : i7
      %48 = comb.extract %47 from 2 : (i7) -> i5
      %49 = comb.icmp eq %48, %c-8_i5 : i5
      cf.cond_br %49, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %gpio_int_level_sync_wen, %true after %1 : i1
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      llhd.drv %gpio_int_level_sync_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb5:  // pred: ^bb1
      llhd.drv %gpio_int_level_sync_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
      llhd.wait (%4, %5, %6, %7, %14 : i1, i1, i1, i7, i1), ^bb1
    }
    %15 = llhd.prb %gpio_int_clr_wen : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %43 = llhd.prb %psel_6 : i1
      %44 = llhd.prb %penable_2 : i1
      %45 = llhd.prb %pwrite_3 : i1
      %46 = comb.and %43, %44, %45 : i1
      cf.cond_br %46, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %47 = llhd.prb %paddr_5 : i7
      %48 = comb.extract %47 from 2 : (i7) -> i5
      %49 = comb.icmp eq %48, %c-8_i5 : i5
      cf.cond_br %49, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %gpio_int_clr_wen, %true after %1 : i1
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      llhd.drv %gpio_int_clr_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb5:  // pred: ^bb1
      llhd.drv %gpio_int_clr_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
      llhd.wait (%4, %5, %6, %7, %15 : i1, i1, i1, i7, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %43 = llhd.prb %pclk_0 : i1
      %44 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %45 = llhd.prb %pclk_0 : i1
      %46 = comb.xor bin %43, %true : i1
      %47 = comb.and bin %46, %45 : i1
      %48 = llhd.prb %presetn_1 : i1
      %49 = comb.xor bin %48, %true : i1
      %50 = comb.and bin %44, %49 : i1
      %51 = comb.or bin %47, %50 : i1
      cf.cond_br %51, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %52 = llhd.prb %presetn_1 : i1
      %53 = comb.xor %52, %true : i1
      cf.cond_br %53, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gpio_int_en, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %54 = llhd.prb %gpio_int_en_wen : i1
      cf.cond_br %54, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %55 = llhd.prb %pwdata_4 : i32
      llhd.drv %gpio_int_en, %55 after %0 : i32
      cf.br ^bb1
    }
    %16 = llhd.prb %zero_value : i1
    %17 = llhd.prb %ri_gpio_int_en : i32
    %18 = llhd.prb %gpio_int_en : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %43 = llhd.prb %zero_value : i1
      %44 = comb.replicate %43 : (i1) -> i32
      llhd.drv %ri_gpio_int_en, %44 after %1 : i32
      %45 = llhd.prb %gpio_int_en : i32
      llhd.drv %ri_gpio_int_en, %45 after %1 : i32
      llhd.wait (%16, %17, %18 : i1, i32, i32), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %43 = llhd.prb %pclk_0 : i1
      %44 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %45 = llhd.prb %pclk_0 : i1
      %46 = comb.xor bin %43, %true : i1
      %47 = comb.and bin %46, %45 : i1
      %48 = llhd.prb %presetn_1 : i1
      %49 = comb.xor bin %48, %true : i1
      %50 = comb.and bin %44, %49 : i1
      %51 = comb.or bin %47, %50 : i1
      cf.cond_br %51, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %52 = llhd.prb %presetn_1 : i1
      %53 = comb.xor %52, %true : i1
      cf.cond_br %53, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gpio_int_mask, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %54 = llhd.prb %gpio_int_mask_wen : i1
      cf.cond_br %54, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %55 = llhd.prb %pwdata_4 : i32
      llhd.drv %gpio_int_mask, %55 after %0 : i32
      cf.br ^bb1
    }
    %19 = llhd.prb %ri_gpio_int_mask : i32
    %20 = llhd.prb %gpio_int_mask : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %43 = llhd.prb %zero_value : i1
      %44 = comb.replicate %43 : (i1) -> i32
      llhd.drv %ri_gpio_int_mask, %44 after %1 : i32
      %45 = llhd.prb %gpio_int_mask : i32
      llhd.drv %ri_gpio_int_mask, %45 after %1 : i32
      llhd.wait (%16, %19, %20 : i1, i32, i32), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %43 = llhd.prb %pclk_0 : i1
      %44 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %45 = llhd.prb %pclk_0 : i1
      %46 = comb.xor bin %43, %true : i1
      %47 = comb.and bin %46, %45 : i1
      %48 = llhd.prb %presetn_1 : i1
      %49 = comb.xor bin %48, %true : i1
      %50 = comb.and bin %44, %49 : i1
      %51 = comb.or bin %47, %50 : i1
      cf.cond_br %51, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %52 = llhd.prb %presetn_1 : i1
      %53 = comb.xor %52, %true : i1
      cf.cond_br %53, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gpio_int_type, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %54 = llhd.prb %gpio_int_type_wen : i1
      cf.cond_br %54, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %55 = llhd.prb %pwdata_4 : i32
      llhd.drv %gpio_int_type, %55 after %0 : i32
      cf.br ^bb1
    }
    %21 = llhd.prb %ri_gpio_int_type : i32
    %22 = llhd.prb %gpio_int_type : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %43 = llhd.prb %zero_value : i1
      %44 = comb.replicate %43 : (i1) -> i32
      llhd.drv %ri_gpio_int_type, %44 after %1 : i32
      %45 = llhd.prb %gpio_int_type : i32
      llhd.drv %ri_gpio_int_type, %45 after %1 : i32
      llhd.wait (%16, %21, %22 : i1, i32, i32), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %43 = llhd.prb %pclk_0 : i1
      %44 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %45 = llhd.prb %pclk_0 : i1
      %46 = comb.xor bin %43, %true : i1
      %47 = comb.and bin %46, %45 : i1
      %48 = llhd.prb %presetn_1 : i1
      %49 = comb.xor bin %48, %true : i1
      %50 = comb.and bin %44, %49 : i1
      %51 = comb.or bin %47, %50 : i1
      cf.cond_br %51, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %52 = llhd.prb %presetn_1 : i1
      %53 = comb.xor %52, %true : i1
      cf.cond_br %53, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gpio_int_pol, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %54 = llhd.prb %gpio_int_pol_wen : i1
      cf.cond_br %54, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %55 = llhd.prb %pwdata_4 : i32
      llhd.drv %gpio_int_pol, %55 after %0 : i32
      cf.br ^bb1
    }
    %23 = llhd.prb %ri_gpio_int_pol : i32
    %24 = llhd.prb %gpio_int_pol : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %43 = llhd.prb %zero_value : i1
      %44 = comb.replicate %43 : (i1) -> i32
      llhd.drv %ri_gpio_int_pol, %44 after %1 : i32
      %45 = llhd.prb %gpio_int_pol : i32
      llhd.drv %ri_gpio_int_pol, %45 after %1 : i32
      llhd.wait (%16, %23, %24 : i1, i32, i32), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %43 = llhd.prb %pclk_0 : i1
      %44 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %45 = llhd.prb %pclk_0 : i1
      %46 = comb.xor bin %43, %true : i1
      %47 = comb.and bin %46, %45 : i1
      %48 = llhd.prb %presetn_1 : i1
      %49 = comb.xor bin %48, %true : i1
      %50 = comb.and bin %44, %49 : i1
      %51 = comb.or bin %47, %50 : i1
      cf.cond_br %51, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %52 = llhd.prb %presetn_1 : i1
      %53 = comb.xor %52, %true : i1
      cf.cond_br %53, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gpio_int_level_sync, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %54 = llhd.prb %gpio_int_level_sync_wen : i1
      cf.cond_br %54, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %55 = llhd.prb %pwdata_4 : i32
      %56 = comb.extract %55 from 0 : (i32) -> i1
      llhd.drv %gpio_int_level_sync, %56 after %0 : i1
      cf.br ^bb1
    }
    %25 = llhd.prb %pwdata_4 : i32
    %26 = llhd.prb %gpio_int_clr : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb4
      %43 = llhd.prb %gpio_int_clr_wen : i1
      cf.cond_br %43, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %44 = llhd.prb %pwdata_4 : i32
      llhd.drv %gpio_int_clr, %44 after %1 : i32
      cf.br ^bb4
    ^bb3:  // pred: ^bb1
      llhd.drv %gpio_int_clr, %c0_i32 after %1 : i32
      cf.br ^bb4
    ^bb4:  // 2 preds: ^bb2, ^bb3
      llhd.wait (%15, %25, %26 : i1, i32, i32), ^bb1
    }
    %27 = llhd.prb %ri_gpio_int_level_sync : i32
    %28 = llhd.prb %gpio_int_level_sync : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %43 = llhd.prb %zero_value : i1
      %44 = comb.replicate %43 : (i1) -> i32
      llhd.drv %ri_gpio_int_level_sync, %44 after %1 : i32
      %45 = llhd.sig.extract %ri_gpio_int_level_sync from %c0_i5 : <i32> -> <i1>
      %46 = llhd.prb %gpio_int_level_sync : i1
      llhd.drv %45, %46 after %1 : i1
      llhd.wait (%16, %27, %28 : i1, i32, i1), ^bb1
    }
    %29 = llhd.prb %ri_gpio_int_status : i32
    %30 = llhd.prb %gpio_int_status_8 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %43 = llhd.prb %zero_value : i1
      %44 = comb.replicate %43 : (i1) -> i32
      llhd.drv %ri_gpio_int_status, %44 after %1 : i32
      %45 = llhd.prb %gpio_int_status_8 : i32
      llhd.drv %ri_gpio_int_status, %45 after %1 : i32
      llhd.wait (%16, %29, %30 : i1, i32, i32), ^bb1
    }
    %31 = llhd.prb %ri_gpio_raw_int_status : i32
    %32 = llhd.prb %gpio_raw_int_status_9 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %43 = llhd.prb %zero_value : i1
      %44 = comb.replicate %43 : (i1) -> i32
      llhd.drv %ri_gpio_raw_int_status, %44 after %1 : i32
      %45 = llhd.prb %gpio_raw_int_status_9 : i32
      llhd.drv %ri_gpio_raw_int_status, %45 after %1 : i32
      llhd.wait (%16, %31, %32 : i1, i32, i32), ^bb1
    }
    %33 = llhd.prb %gpio_debounce_wen : i1
    %34 = llhd.prb %gpio_debounce : i32
    %35 = llhd.prb %ri_gpio_debounce : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %43 = llhd.prb %zero_value : i1
      llhd.drv %gpio_debounce_wen, %43 after %1 : i1
      %44 = llhd.prb %zero_value : i1
      %45 = comb.replicate %44 : (i1) -> i32
      llhd.drv %gpio_debounce, %45 after %1 : i32
      %46 = llhd.prb %zero_value : i1
      %47 = comb.replicate %46 : (i1) -> i32
      llhd.drv %ri_gpio_debounce, %47 after %1 : i32
      llhd.wait (%16, %33, %34, %35 : i1, i1, i32, i32), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %43 = llhd.prb %pclk_0 : i1
      %44 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %45 = llhd.prb %pclk_0 : i1
      %46 = comb.xor bin %43, %true : i1
      %47 = comb.and bin %46, %45 : i1
      %48 = llhd.prb %presetn_1 : i1
      %49 = comb.xor bin %48, %true : i1
      %50 = comb.and bin %44, %49 : i1
      %51 = comb.or bin %47, %50 : i1
      cf.cond_br %51, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %52 = llhd.prb %presetn_1 : i1
      %53 = comb.xor %52, %true : i1
      cf.cond_br %53, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gpio_sw_data, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %54 = llhd.prb %gpio_sw_data_wen : i1
      cf.cond_br %54, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %55 = llhd.prb %pwdata_4 : i32
      llhd.drv %gpio_sw_data, %55 after %0 : i32
      cf.br ^bb1
    }
    %36 = llhd.prb %ri_gpio_sw_data : i32
    %37 = llhd.prb %gpio_sw_data : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %ri_gpio_sw_data, %c0_i32 after %1 : i32
      %43 = llhd.prb %gpio_sw_data : i32
      llhd.drv %ri_gpio_sw_data, %43 after %1 : i32
      llhd.wait (%36, %37 : i32, i32), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %43 = llhd.prb %pclk_0 : i1
      %44 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %45 = llhd.prb %pclk_0 : i1
      %46 = comb.xor bin %43, %true : i1
      %47 = comb.and bin %46, %45 : i1
      %48 = llhd.prb %presetn_1 : i1
      %49 = comb.xor bin %48, %true : i1
      %50 = comb.and bin %44, %49 : i1
      %51 = comb.or bin %47, %50 : i1
      cf.cond_br %51, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %52 = llhd.prb %presetn_1 : i1
      %53 = comb.xor %52, %true : i1
      cf.cond_br %53, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gpio_sw_dir, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %54 = llhd.prb %gpio_sw_dir_wen : i1
      cf.cond_br %54, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %55 = llhd.prb %pwdata_4 : i32
      llhd.drv %gpio_sw_dir, %55 after %0 : i32
      cf.br ^bb1
    }
    %38 = llhd.prb %ri_gpio_sw_dir : i32
    %39 = llhd.prb %gpio_sw_dir : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %ri_gpio_sw_dir, %c0_i32 after %1 : i32
      %43 = llhd.prb %gpio_sw_dir : i32
      llhd.drv %ri_gpio_sw_dir, %43 after %1 : i32
      llhd.wait (%38, %39 : i32, i32), ^bb1
    }
    %40 = llhd.prb %ri_gpio_ext_data : i32
    %41 = llhd.prb %gpio_ext_data_7 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %ri_gpio_ext_data, %c0_i32 after %1 : i32
      %43 = llhd.prb %gpio_ext_data_7 : i32
      llhd.drv %ri_gpio_ext_data, %43 after %1 : i32
      llhd.wait (%40, %41 : i32, i32), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 17 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb7, ^bb9, ^bb11, ^bb13, ^bb15, ^bb17, ^bb19, ^bb21, ^bb23, ^bb25, ^bb27, ^bb29, ^bb30
      %43 = llhd.prb %pclk_0 : i1
      %44 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %45 = llhd.prb %pclk_0 : i1
      %46 = comb.xor bin %43, %true : i1
      %47 = comb.and bin %46, %45 : i1
      %48 = llhd.prb %presetn_1 : i1
      %49 = comb.xor bin %48, %true : i1
      %50 = comb.and bin %44, %49 : i1
      %51 = comb.or bin %47, %50 : i1
      cf.cond_br %51, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %52 = llhd.prb %presetn_1 : i1
      %53 = comb.xor %52, %true : i1
      cf.cond_br %53, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %prdata, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %54 = llhd.prb %pwrite_3 : i1
      %55 = comb.xor %54, %true : i1
      %56 = llhd.prb %psel_6 : i1
      %57 = llhd.prb %penable_2 : i1
      %58 = comb.xor %57, %true : i1
      %59 = comb.and %55, %56, %58 : i1
      cf.cond_br %59, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %60 = llhd.prb %paddr_5 : i7
      %61 = comb.extract %60 from 2 : (i7) -> i5
      %62 = comb.concat %c0_i27, %61 : i27, i5
      %63 = comb.icmp ceq %62, %c0_i32 : i32
      cf.cond_br %63, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %64 = llhd.prb %ri_gpio_sw_data : i32
      llhd.drv %prdata, %64 after %0 : i32
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %65 = comb.icmp ceq %62, %c1_i32 : i32
      cf.cond_br %65, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %66 = llhd.prb %ri_gpio_sw_dir : i32
      llhd.drv %prdata, %66 after %0 : i32
      cf.br ^bb1
    ^bb10:  // pred: ^bb8
      %67 = comb.icmp ceq %62, %c2_i32 : i32
      cf.cond_br %67, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      llhd.drv %prdata, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      %68 = comb.icmp ceq %62, %c12_i32 : i32
      cf.cond_br %68, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      %69 = llhd.prb %ri_gpio_int_en : i32
      llhd.drv %prdata, %69 after %0 : i32
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      %70 = comb.icmp ceq %62, %c13_i32 : i32
      cf.cond_br %70, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      %71 = llhd.prb %ri_gpio_int_mask : i32
      llhd.drv %prdata, %71 after %0 : i32
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      %72 = comb.icmp ceq %62, %c14_i32 : i32
      cf.cond_br %72, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      %73 = llhd.prb %ri_gpio_int_type : i32
      llhd.drv %prdata, %73 after %0 : i32
      cf.br ^bb1
    ^bb18:  // pred: ^bb16
      %74 = comb.icmp ceq %62, %c15_i32 : i32
      cf.cond_br %74, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %75 = llhd.prb %ri_gpio_int_pol : i32
      llhd.drv %prdata, %75 after %0 : i32
      cf.br ^bb1
    ^bb20:  // pred: ^bb18
      %76 = comb.icmp ceq %62, %c16_i32 : i32
      cf.cond_br %76, ^bb21, ^bb22
    ^bb21:  // pred: ^bb20
      %77 = llhd.prb %ri_gpio_int_status : i32
      llhd.drv %prdata, %77 after %0 : i32
      cf.br ^bb1
    ^bb22:  // pred: ^bb20
      %78 = comb.icmp ceq %62, %c17_i32 : i32
      cf.cond_br %78, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      %79 = llhd.prb %ri_gpio_raw_int_status : i32
      llhd.drv %prdata, %79 after %0 : i32
      cf.br ^bb1
    ^bb24:  // pred: ^bb22
      %80 = comb.icmp ceq %62, %c18_i32 : i32
      cf.cond_br %80, ^bb25, ^bb26
    ^bb25:  // pred: ^bb24
      %81 = llhd.prb %ri_gpio_debounce : i32
      llhd.drv %prdata, %81 after %0 : i32
      cf.br ^bb1
    ^bb26:  // pred: ^bb24
      %82 = comb.icmp ceq %62, %c24_i32 : i32
      cf.cond_br %82, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      %83 = llhd.prb %ri_gpio_int_level_sync : i32
      llhd.drv %prdata, %83 after %0 : i32
      cf.br ^bb1
    ^bb28:  // pred: ^bb26
      %84 = comb.icmp ceq %62, %c20_i32 : i32
      cf.cond_br %84, ^bb29, ^bb30
    ^bb29:  // pred: ^bb28
      %85 = llhd.prb %ri_gpio_ext_data : i32
      llhd.drv %prdata, %85 after %0 : i32
      cf.br ^bb1
    ^bb30:  // pred: ^bb28
      llhd.drv %prdata, %c0_i32 after %0 : i32
      cf.br ^bb1
    }
    llhd.drv %pclk_0, %pclk after %1 : i1
    llhd.drv %presetn_1, %presetn after %1 : i1
    llhd.drv %penable_2, %penable after %1 : i1
    llhd.drv %pwrite_3, %pwrite after %1 : i1
    llhd.drv %pwdata_4, %pwdata after %1 : i32
    llhd.drv %paddr_5, %paddr after %1 : i7
    llhd.drv %psel_6, %psel after %1 : i1
    llhd.drv %gpio_ext_data_7, %gpio_ext_data after %1 : i32
    llhd.drv %gpio_int_status_8, %gpio_int_status after %1 : i32
    llhd.drv %gpio_raw_int_status_9, %gpio_raw_int_status after %1 : i32
    %42 = llhd.prb %prdata : i32
    hw.output %37, %39, %18, %20, %22, %24, %34, %26, %28, %42 : i32, i32, i32, i32, i32, i32, i32, i32, i1, i32
  }
  hw.module private @gpio_ctrl(in %pclk : i1, in %pclk_int : i1, in %dbclk : i1, in %presetn : i1, in %dbclk_rstn : i1, in %scan_mode : i1, in %gpio_sw_data : i32, in %gpio_sw_dir : i32, in %gpio_int_en : i32, in %gpio_int_mask : i32, in %gpio_int_type : i32, in %gpio_int_pol : i32, in %gpio_debounce : i32, in %gpio_int_clr : i32, in %gpio_rx_data : i32, in %gpio_int_level_sync : i1, out gpio_tx_data : i32, out gpio_tx_en : i32, out gpio_ext_data : i32, out gpio_int_flag : i1, out gpio_int_flag_n : i1, out gpio_int_status : i32, out gpio_int : i32, out gpio_int_n : i32, out gpio_raw_int_status : i32, out gpio_int_clk_en : i1, out gpio_etb_trig : i32) {
    %c-1_i32 = hw.constant -1 : i32
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i5 = hw.constant -1 : i5
    %c0_i27 = hw.constant 0 : i27
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
    %false = hw.constant false
    %c1_i32 = hw.constant 1 : i32
    %c32_i32 = hw.constant 32 : i32
    %c0_i32 = hw.constant 0 : i32
    %pclk_0 = llhd.sig name "pclk" %false : i1
    %2 = llhd.prb %pclk_0 : i1
    %pclk_int_1 = llhd.sig name "pclk_int" %false : i1
    %3 = llhd.prb %pclk_int_1 : i1
    %presetn_2 = llhd.sig name "presetn" %false : i1
    %4 = llhd.prb %presetn_2 : i1
    %gpio_sw_data_3 = llhd.sig name "gpio_sw_data" %c0_i32 : i32
    %gpio_sw_dir_4 = llhd.sig name "gpio_sw_dir" %c0_i32 : i32
    %gpio_int_en_5 = llhd.sig name "gpio_int_en" %c0_i32 : i32
    %gpio_int_type_6 = llhd.sig name "gpio_int_type" %c0_i32 : i32
    %gpio_int_pol_7 = llhd.sig name "gpio_int_pol" %c0_i32 : i32
    %gpio_debounce_8 = llhd.sig name "gpio_debounce" %c0_i32 : i32
    %gpio_int_clr_9 = llhd.sig name "gpio_int_clr" %c0_i32 : i32
    %gpio_rx_data_10 = llhd.sig name "gpio_rx_data" %c0_i32 : i32
    %gpio_int_level_sync_11 = llhd.sig name "gpio_int_level_sync" %false : i1
    %gpio_tx_data = llhd.sig %c0_i32 : i32
    %gpio_tx_en = llhd.sig %c0_i32 : i32
    %gpio_ext_data = llhd.sig %c0_i32 : i32
    %gpio_int_status = llhd.sig %c0_i32 : i32
    %gpio_raw_int_status = llhd.sig %c0_i32 : i32
    %gpio_int_clk_en = llhd.sig %false : i1
    %gpio_rx_data_int = llhd.sig %c0_i32 : i32
    %int_level_sync_in = llhd.sig %c0_i32 : i32
    %int_edge_out = llhd.sig %c0_i32 : i32
    %debounce_d2 = llhd.sig %c0_i32 : i32
    %int_level = llhd.sig %c0_i32 : i32
    %gpio_ext_data_tmp = llhd.sig %c0_i32 : i32
    %zero_value = llhd.sig %false : i1
    %gpio_int_flag_tmp = llhd.sig %false : i1
    llhd.drv %zero_value, %false after %1 : i1
    %int_clk_en = llhd.sig %c0_i32 : i32
    %int_level_ff1 = llhd.sig %c0_i32 : i32
    %gpio_int_status_edge = llhd.sig %c0_i32 : i32
    %gpio_int_status_level = llhd.sig %c0_i32 : i32
    %gpio_int_clk_en_tmp = llhd.sig %false : i1
    %int_edge = llhd.sig %c0_i32 : i32
    %int_k = llhd.sig %c0_i32 : i32
    %5 = llhd.prb %gpio_int_en_5 : i32
    %6 = llhd.prb %gpio_int_type_6 : i32
    %7 = llhd.prb %int_clk_en : i32
    %8 = llhd.prb %gpio_int_level_sync_11 : i1
    llhd.process {
      cf.br ^bb2(%c0_i32 : i32)
    ^bb1:  // pred: ^bb9
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%39: i32):  // 3 preds: ^bb0, ^bb1, ^bb8
      %40 = comb.icmp ult %39, %c32_i32 : i32
      cf.cond_br %40, ^bb3, ^bb9
    ^bb3:  // pred: ^bb2
      %41 = llhd.prb %gpio_int_en_5 : i32
      %42 = comb.shru %41, %39 : i32
      %43 = comb.extract %42 from 0 : (i32) -> i1
      cf.cond_br %43, ^bb4, ^bb7
    ^bb4:  // pred: ^bb3
      %44 = llhd.prb %gpio_int_type_6 : i32
      %45 = comb.shru %44, %39 : i32
      %46 = comb.extract %45 from 0 : (i32) -> i1
      cf.cond_br %46, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %47 = comb.extract %39 from 5 : (i32) -> i27
      %48 = comb.icmp eq %47, %c0_i27 : i27
      %49 = comb.extract %39 from 0 : (i32) -> i5
      %50 = comb.mux %48, %49, %c-1_i5 : i5
      %51 = llhd.sig.extract %int_clk_en from %50 : <i32> -> <i1>
      llhd.drv %51, %true after %1 : i1
      cf.br ^bb8
    ^bb6:  // pred: ^bb4
      %52 = comb.extract %39 from 5 : (i32) -> i27
      %53 = comb.icmp eq %52, %c0_i27 : i27
      %54 = comb.extract %39 from 0 : (i32) -> i5
      %55 = comb.mux %53, %54, %c-1_i5 : i5
      %56 = llhd.sig.extract %int_clk_en from %55 : <i32> -> <i1>
      %57 = llhd.prb %gpio_int_level_sync_11 : i1
      llhd.drv %56, %57 after %1 : i1
      cf.br ^bb8
    ^bb7:  // pred: ^bb3
      %58 = comb.extract %39 from 5 : (i32) -> i27
      %59 = comb.icmp eq %58, %c0_i27 : i27
      %60 = comb.extract %39 from 0 : (i32) -> i5
      %61 = comb.mux %59, %60, %c-1_i5 : i5
      %62 = llhd.sig.extract %int_clk_en from %61 : <i32> -> <i1>
      llhd.drv %62, %false after %1 : i1
      cf.br ^bb8
    ^bb8:  // 3 preds: ^bb5, ^bb6, ^bb7
      %63 = comb.add %39, %c1_i32 : i32
      cf.br ^bb2(%63 : i32)
    ^bb9:  // pred: ^bb2
      llhd.wait (%5, %6, %7, %8 : i32, i32, i32, i1), ^bb1
    }
    %9 = comb.icmp ne %7, %c0_i32 : i32
    llhd.drv %gpio_int_clk_en_tmp, %9 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %39 = llhd.prb %pclk_0 : i1
      %40 = llhd.prb %presetn_2 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %41 = llhd.prb %pclk_0 : i1
      %42 = comb.xor bin %39, %true : i1
      %43 = comb.and bin %42, %41 : i1
      %44 = llhd.prb %presetn_2 : i1
      %45 = comb.xor bin %44, %true : i1
      %46 = comb.and bin %40, %45 : i1
      %47 = comb.or bin %43, %46 : i1
      cf.cond_br %47, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %48 = llhd.prb %presetn_2 : i1
      %49 = comb.xor %48, %true : i1
      cf.cond_br %49, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gpio_int_clk_en, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %50 = llhd.prb %gpio_int_clk_en_tmp : i1
      llhd.drv %gpio_int_clk_en, %50 after %0 : i1
      cf.br ^bb1
    }
    %10 = llhd.prb %gpio_rx_data_int : i32
    %11 = llhd.prb %gpio_int_pol_7 : i32
    %12 = llhd.prb %gpio_rx_data_10 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb7
      llhd.drv %gpio_rx_data_int, %c0_i32 after %1 : i32
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%39: i32):  // 2 preds: ^bb1, ^bb6
      %40 = comb.icmp ult %39, %c32_i32 : i32
      cf.cond_br %40, ^bb3, ^bb7
    ^bb3:  // pred: ^bb2
      %41 = llhd.prb %gpio_int_pol_7 : i32
      %42 = comb.shru %41, %39 : i32
      %43 = comb.extract %42 from 0 : (i32) -> i1
      %44 = comb.xor %43, %true : i1
      cf.cond_br %44, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %45 = comb.extract %39 from 5 : (i32) -> i27
      %46 = comb.icmp eq %45, %c0_i27 : i27
      %47 = comb.extract %39 from 0 : (i32) -> i5
      %48 = comb.mux %46, %47, %c-1_i5 : i5
      %49 = llhd.sig.extract %gpio_rx_data_int from %48 : <i32> -> <i1>
      %50 = llhd.prb %gpio_rx_data_10 : i32
      %51 = comb.shru %50, %39 : i32
      %52 = comb.extract %51 from 0 : (i32) -> i1
      %53 = comb.xor %52, %true : i1
      llhd.drv %49, %53 after %1 : i1
      cf.br ^bb6
    ^bb5:  // pred: ^bb3
      %54 = comb.extract %39 from 5 : (i32) -> i27
      %55 = comb.icmp eq %54, %c0_i27 : i27
      %56 = comb.extract %39 from 0 : (i32) -> i5
      %57 = comb.mux %55, %56, %c-1_i5 : i5
      %58 = llhd.sig.extract %gpio_rx_data_int from %57 : <i32> -> <i1>
      %59 = llhd.prb %gpio_rx_data_10 : i32
      %60 = comb.shru %59, %39 : i32
      %61 = comb.extract %60 from 0 : (i32) -> i1
      llhd.drv %58, %61 after %1 : i1
      cf.br ^bb6
    ^bb6:  // 2 preds: ^bb4, ^bb5
      %62 = comb.add %39, %c1_i32 : i32
      cf.br ^bb2(%62 : i32)
    ^bb7:  // pred: ^bb2
      llhd.wait (%10, %11, %12 : i32, i32, i32), ^bb1
    }
    %13 = llhd.prb %int_level_sync_in : i32
    %14 = llhd.prb %gpio_debounce_8 : i32
    %15 = llhd.prb %debounce_d2 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %int_level_sync_in, %c0_i32 after %1 : i32
      %39 = llhd.prb %gpio_rx_data_int : i32
      llhd.drv %int_level_sync_in, %39 after %1 : i32
      llhd.wait (%13, %10, %14, %15 : i32, i32, i32, i32), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %39 = llhd.prb %pclk_int_1 : i1
      %40 = llhd.prb %presetn_2 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %41 = llhd.prb %pclk_int_1 : i1
      %42 = comb.xor bin %39, %true : i1
      %43 = comb.and bin %42, %41 : i1
      %44 = llhd.prb %presetn_2 : i1
      %45 = comb.xor bin %44, %true : i1
      %46 = comb.and bin %40, %45 : i1
      %47 = comb.or bin %43, %46 : i1
      cf.cond_br %47, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %48 = llhd.prb %presetn_2 : i1
      %49 = comb.xor %48, %true : i1
      cf.cond_br %49, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_level_ff1, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %50 = llhd.prb %int_level : i32
      llhd.drv %int_level_ff1, %50 after %0 : i32
      cf.br ^bb1
    }
    %16 = llhd.prb %int_level : i32
    %17 = llhd.prb %int_level_ff1 : i32
    %18 = comb.xor %16, %17 : i32
    llhd.drv %int_edge, %18 after %1 : i32
    %19 = llhd.prb %int_edge_out : i32
    %20 = llhd.prb %int_edge : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb4
      llhd.drv %int_edge_out, %c0_i32 after %1 : i32
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%39: i32):  // 2 preds: ^bb1, ^bb3
      %40 = comb.icmp ult %39, %c32_i32 : i32
      cf.cond_br %40, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %41 = comb.extract %39 from 5 : (i32) -> i27
      %42 = comb.icmp eq %41, %c0_i27 : i27
      %43 = comb.extract %39 from 0 : (i32) -> i5
      %44 = comb.mux %42, %43, %c-1_i5 : i5
      %45 = llhd.sig.extract %int_edge_out from %44 : <i32> -> <i1>
      %46 = llhd.prb %int_edge : i32
      %47 = comb.shru %46, %39 : i32
      %48 = comb.extract %47 from 0 : (i32) -> i1
      %49 = llhd.prb %int_level : i32
      %50 = comb.shru %49, %39 : i32
      %51 = comb.extract %50 from 0 : (i32) -> i1
      %52 = comb.and %48, %51 : i1
      llhd.drv %45, %52 after %1 : i1
      %53 = comb.add %39, %c1_i32 : i32
      cf.br ^bb2(%53 : i32)
    ^bb4:  // pred: ^bb2
      llhd.wait (%19, %20, %16 : i32, i32, i32), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb6
      %39 = llhd.prb %pclk_0 : i1
      %40 = llhd.prb %presetn_2 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %41 = llhd.prb %pclk_0 : i1
      %42 = comb.xor bin %39, %true : i1
      %43 = comb.and bin %42, %41 : i1
      %44 = llhd.prb %presetn_2 : i1
      %45 = comb.xor bin %44, %true : i1
      %46 = comb.and bin %40, %45 : i1
      %47 = comb.or bin %43, %46 : i1
      cf.cond_br %47, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %48 = llhd.prb %presetn_2 : i1
      %49 = comb.xor %48, %true : i1
      cf.cond_br %49, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gpio_int_status_edge, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      llhd.drv %int_k, %c0_i32 after %1 : i32
      cf.br ^bb6
    ^bb6:  // 2 preds: ^bb5, ^bb13
      %50 = llhd.prb %int_k : i32
      %51 = comb.icmp ult %50, %c32_i32 : i32
      cf.cond_br %51, ^bb7, ^bb1
    ^bb7:  // pred: ^bb6
      %52 = llhd.prb %gpio_int_en_5 : i32
      %53 = llhd.prb %int_k : i32
      %54 = comb.shru %52, %53 : i32
      %55 = comb.extract %54 from 0 : (i32) -> i1
      %56 = comb.xor %55, %true : i1
      cf.cond_br %56, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %57 = llhd.prb %int_k : i32
      %58 = comb.extract %57 from 5 : (i32) -> i27
      %59 = comb.icmp eq %58, %c0_i27 : i27
      %60 = comb.extract %57 from 0 : (i32) -> i5
      %61 = comb.mux %59, %60, %c-1_i5 : i5
      %62 = llhd.sig.extract %gpio_int_status_edge from %61 : <i32> -> <i1>
      llhd.drv %62, %false after %0 : i1
      cf.br ^bb13
    ^bb9:  // pred: ^bb7
      %63 = llhd.prb %int_edge_out : i32
      %64 = llhd.prb %int_k : i32
      %65 = comb.shru %63, %64 : i32
      %66 = comb.extract %65 from 0 : (i32) -> i1
      %67 = llhd.prb %gpio_int_en_5 : i32
      %68 = comb.shru %67, %64 : i32
      %69 = comb.extract %68 from 0 : (i32) -> i1
      %70 = llhd.prb %gpio_sw_dir_4 : i32
      %71 = comb.shru %70, %64 : i32
      %72 = comb.extract %71 from 0 : (i32) -> i1
      %73 = comb.xor %72, %true : i1
      %74 = comb.and %66, %69, %73 : i1
      cf.cond_br %74, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %75 = llhd.prb %int_k : i32
      %76 = comb.extract %75 from 5 : (i32) -> i27
      %77 = comb.icmp eq %76, %c0_i27 : i27
      %78 = comb.extract %75 from 0 : (i32) -> i5
      %79 = comb.mux %77, %78, %c-1_i5 : i5
      %80 = llhd.sig.extract %gpio_int_status_edge from %79 : <i32> -> <i1>
      llhd.drv %80, %true after %0 : i1
      cf.br ^bb13
    ^bb11:  // pred: ^bb9
      %81 = llhd.prb %gpio_int_clr_9 : i32
      %82 = llhd.prb %int_k : i32
      %83 = comb.shru %81, %82 : i32
      %84 = comb.extract %83 from 0 : (i32) -> i1
      cf.cond_br %84, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %85 = llhd.prb %int_k : i32
      %86 = comb.extract %85 from 5 : (i32) -> i27
      %87 = comb.icmp eq %86, %c0_i27 : i27
      %88 = comb.extract %85 from 0 : (i32) -> i5
      %89 = comb.mux %87, %88, %c-1_i5 : i5
      %90 = llhd.sig.extract %gpio_int_status_edge from %89 : <i32> -> <i1>
      llhd.drv %90, %false after %0 : i1
      cf.br ^bb13
    ^bb13:  // 4 preds: ^bb8, ^bb10, ^bb11, ^bb12
      %91 = llhd.prb %int_k : i32
      %92 = comb.add %91, %c1_i32 : i32
      llhd.drv %int_k, %92 after %1 : i32
      cf.br ^bb6
    }
    %21 = llhd.prb %gpio_int_status_level : i32
    %22 = llhd.prb %gpio_sw_dir_4 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb9
      llhd.drv %gpio_int_status_level, %c0_i32 after %1 : i32
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%39: i32):  // 2 preds: ^bb1, ^bb8
      %40 = comb.icmp ult %39, %c32_i32 : i32
      cf.cond_br %40, ^bb3, ^bb9
    ^bb3:  // pred: ^bb2
      %41 = llhd.prb %gpio_sw_dir_4 : i32
      %42 = comb.shru %41, %39 : i32
      %43 = comb.extract %42 from 0 : (i32) -> i1
      cf.cond_br %43, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %44 = comb.extract %39 from 5 : (i32) -> i27
      %45 = comb.icmp eq %44, %c0_i27 : i27
      %46 = comb.extract %39 from 0 : (i32) -> i5
      %47 = comb.mux %45, %46, %c-1_i5 : i5
      %48 = llhd.sig.extract %gpio_int_status_level from %47 : <i32> -> <i1>
      llhd.drv %48, %false after %1 : i1
      cf.br ^bb8
    ^bb5:  // pred: ^bb3
      %49 = llhd.prb %gpio_int_level_sync_11 : i1
      cf.cond_br %49, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %50 = comb.extract %39 from 5 : (i32) -> i27
      %51 = comb.icmp eq %50, %c0_i27 : i27
      %52 = comb.extract %39 from 0 : (i32) -> i5
      %53 = comb.mux %51, %52, %c-1_i5 : i5
      %54 = llhd.sig.extract %gpio_int_status_level from %53 : <i32> -> <i1>
      %55 = llhd.prb %int_level : i32
      %56 = comb.shru %55, %39 : i32
      %57 = comb.extract %56 from 0 : (i32) -> i1
      llhd.drv %54, %57 after %1 : i1
      cf.br ^bb8
    ^bb7:  // pred: ^bb5
      %58 = comb.extract %39 from 5 : (i32) -> i27
      %59 = comb.icmp eq %58, %c0_i27 : i27
      %60 = comb.extract %39 from 0 : (i32) -> i5
      %61 = comb.mux %59, %60, %c-1_i5 : i5
      %62 = llhd.sig.extract %gpio_int_status_level from %61 : <i32> -> <i1>
      %63 = llhd.prb %int_level_sync_in : i32
      %64 = comb.shru %63, %39 : i32
      %65 = comb.extract %64 from 0 : (i32) -> i1
      llhd.drv %62, %65 after %1 : i1
      cf.br ^bb8
    ^bb8:  // 3 preds: ^bb4, ^bb6, ^bb7
      %66 = comb.add %39, %c1_i32 : i32
      cf.br ^bb2(%66 : i32)
    ^bb9:  // pred: ^bb2
      llhd.wait (%21, %22, %8, %16, %13 : i32, i32, i1, i32, i32), ^bb1
    }
    %23 = llhd.prb %gpio_raw_int_status : i32
    %24 = llhd.prb %gpio_int_status_edge : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb9
      llhd.drv %gpio_raw_int_status, %c0_i32 after %1 : i32
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%39: i32):  // 2 preds: ^bb1, ^bb8
      %40 = comb.icmp ult %39, %c32_i32 : i32
      cf.cond_br %40, ^bb3, ^bb9
    ^bb3:  // pred: ^bb2
      %41 = llhd.prb %gpio_int_en_5 : i32
      %42 = comb.shru %41, %39 : i32
      %43 = comb.extract %42 from 0 : (i32) -> i1
      %44 = comb.xor %43, %true : i1
      cf.cond_br %44, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %45 = comb.extract %39 from 5 : (i32) -> i27
      %46 = comb.icmp eq %45, %c0_i27 : i27
      %47 = comb.extract %39 from 0 : (i32) -> i5
      %48 = comb.mux %46, %47, %c-1_i5 : i5
      %49 = llhd.sig.extract %gpio_raw_int_status from %48 : <i32> -> <i1>
      llhd.drv %49, %false after %1 : i1
      cf.br ^bb8
    ^bb5:  // pred: ^bb3
      %50 = llhd.prb %gpio_int_type_6 : i32
      %51 = comb.shru %50, %39 : i32
      %52 = comb.extract %51 from 0 : (i32) -> i1
      cf.cond_br %52, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %53 = comb.extract %39 from 5 : (i32) -> i27
      %54 = comb.icmp eq %53, %c0_i27 : i27
      %55 = comb.extract %39 from 0 : (i32) -> i5
      %56 = comb.mux %54, %55, %c-1_i5 : i5
      %57 = llhd.sig.extract %gpio_raw_int_status from %56 : <i32> -> <i1>
      %58 = llhd.prb %gpio_int_status_edge : i32
      %59 = comb.shru %58, %39 : i32
      %60 = comb.extract %59 from 0 : (i32) -> i1
      llhd.drv %57, %60 after %1 : i1
      cf.br ^bb8
    ^bb7:  // pred: ^bb5
      %61 = comb.extract %39 from 5 : (i32) -> i27
      %62 = comb.icmp eq %61, %c0_i27 : i27
      %63 = comb.extract %39 from 0 : (i32) -> i5
      %64 = comb.mux %62, %63, %c-1_i5 : i5
      %65 = llhd.sig.extract %gpio_raw_int_status from %64 : <i32> -> <i1>
      %66 = llhd.prb %gpio_int_status_level : i32
      %67 = comb.shru %66, %39 : i32
      %68 = comb.extract %67 from 0 : (i32) -> i1
      llhd.drv %65, %68 after %1 : i1
      cf.br ^bb8
    ^bb8:  // 3 preds: ^bb4, ^bb6, ^bb7
      %69 = comb.add %39, %c1_i32 : i32
      cf.br ^bb2(%69 : i32)
    ^bb9:  // pred: ^bb2
      llhd.wait (%23, %5, %6, %24, %21 : i32, i32, i32, i32, i32), ^bb1
    }
    %25 = comb.xor %gpio_int_mask, %c-1_i32 : i32
    %26 = comb.and %23, %25 : i32
    llhd.drv %gpio_int_status, %26 after %1 : i32
    %27 = llhd.prb %gpio_int_status : i32
    %28 = comb.icmp ne %27, %c0_i32 : i32
    llhd.drv %gpio_int_flag_tmp, %28 after %1 : i1
    %29 = llhd.prb %gpio_int_flag_tmp : i1
    %SUPPORT_INT_LEVEL_SYNC_PROC.int_level_sync_in_ff1 = llhd.sig %c0_i32 : i32
    %SUPPORT_INT_LEVEL_SYNC_PROC.int_level_sync_in_ff2 = llhd.sig %c0_i32 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %39 = llhd.prb %pclk_int_1 : i1
      %40 = llhd.prb %presetn_2 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %41 = llhd.prb %pclk_int_1 : i1
      %42 = comb.xor bin %39, %true : i1
      %43 = comb.and bin %42, %41 : i1
      %44 = llhd.prb %presetn_2 : i1
      %45 = comb.xor bin %44, %true : i1
      %46 = comb.and bin %40, %45 : i1
      %47 = comb.or bin %43, %46 : i1
      cf.cond_br %47, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %48 = llhd.prb %presetn_2 : i1
      %49 = comb.xor %48, %true : i1
      cf.cond_br %49, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %SUPPORT_INT_LEVEL_SYNC_PROC.int_level_sync_in_ff1, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %50 = llhd.prb %int_level_sync_in : i32
      llhd.drv %SUPPORT_INT_LEVEL_SYNC_PROC.int_level_sync_in_ff1, %50 after %0 : i32
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %39 = llhd.prb %pclk_int_1 : i1
      %40 = llhd.prb %presetn_2 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %41 = llhd.prb %pclk_int_1 : i1
      %42 = comb.xor bin %39, %true : i1
      %43 = comb.and bin %42, %41 : i1
      %44 = llhd.prb %presetn_2 : i1
      %45 = comb.xor bin %44, %true : i1
      %46 = comb.and bin %40, %45 : i1
      %47 = comb.or bin %43, %46 : i1
      cf.cond_br %47, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %48 = llhd.prb %presetn_2 : i1
      %49 = comb.xor %48, %true : i1
      cf.cond_br %49, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %SUPPORT_INT_LEVEL_SYNC_PROC.int_level_sync_in_ff2, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %50 = llhd.prb %SUPPORT_INT_LEVEL_SYNC_PROC.int_level_sync_in_ff1 : i32
      llhd.drv %SUPPORT_INT_LEVEL_SYNC_PROC.int_level_sync_in_ff2, %50 after %0 : i32
      cf.br ^bb1
    }
    %30 = llhd.prb %SUPPORT_INT_LEVEL_SYNC_PROC.int_level_sync_in_ff2 : i32
    %31 = comb.mux %8, %30, %13 : i32
    llhd.drv %int_level, %31 after %1 : i32
    %32 = llhd.prb %zero_value : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %39 = llhd.prb %zero_value : i1
      %40 = comb.replicate %39 : (i1) -> i32
      llhd.drv %debounce_d2, %40 after %1 : i32
      llhd.wait (%32, %15 : i1, i32), ^bb1
    }
    %33 = llhd.prb %gpio_tx_data : i32
    %34 = llhd.prb %gpio_sw_data_3 : i32
    llhd.process {
      cf.br ^bb2(%c0_i32 : i32)
    ^bb1:  // pred: ^bb4
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%39: i32):  // 3 preds: ^bb0, ^bb1, ^bb3
      %40 = comb.icmp ult %39, %c32_i32 : i32
      cf.cond_br %40, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %41 = comb.extract %39 from 5 : (i32) -> i27
      %42 = comb.icmp eq %41, %c0_i27 : i27
      %43 = comb.extract %39 from 0 : (i32) -> i5
      %44 = comb.mux %42, %43, %c-1_i5 : i5
      %45 = llhd.sig.extract %gpio_tx_data from %44 : <i32> -> <i1>
      %46 = llhd.prb %gpio_sw_data_3 : i32
      %47 = comb.shru %46, %39 : i32
      %48 = comb.extract %47 from 0 : (i32) -> i1
      llhd.drv %45, %48 after %1 : i1
      %49 = comb.add %39, %c1_i32 : i32
      cf.br ^bb2(%49 : i32)
    ^bb4:  // pred: ^bb2
      llhd.wait (%33, %34 : i32, i32), ^bb1
    }
    %35 = llhd.prb %gpio_tx_en : i32
    llhd.process {
      cf.br ^bb2(%c0_i32 : i32)
    ^bb1:  // pred: ^bb4
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%39: i32):  // 3 preds: ^bb0, ^bb1, ^bb3
      %40 = comb.icmp ult %39, %c32_i32 : i32
      cf.cond_br %40, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %41 = comb.extract %39 from 5 : (i32) -> i27
      %42 = comb.icmp eq %41, %c0_i27 : i27
      %43 = comb.extract %39 from 0 : (i32) -> i5
      %44 = comb.mux %42, %43, %c-1_i5 : i5
      %45 = llhd.sig.extract %gpio_tx_en from %44 : <i32> -> <i1>
      %46 = llhd.prb %gpio_sw_dir_4 : i32
      %47 = comb.shru %46, %39 : i32
      %48 = comb.extract %47 from 0 : (i32) -> i1
      llhd.drv %45, %48 after %1 : i1
      %49 = comb.add %39, %c1_i32 : i32
      cf.br ^bb2(%49 : i32)
    ^bb4:  // pred: ^bb2
      llhd.wait (%35, %22 : i32, i32), ^bb1
    }
    llhd.drv %gpio_ext_data_tmp, %12 after %1 : i32
    %36 = llhd.prb %gpio_ext_data : i32
    %37 = llhd.prb %gpio_ext_data_tmp : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb7
      %39 = llhd.prb %zero_value : i1
      %40 = comb.replicate %39 : (i1) -> i32
      llhd.drv %gpio_ext_data, %40 after %1 : i32
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%41: i32):  // 2 preds: ^bb1, ^bb6
      %42 = comb.icmp ult %41, %c32_i32 : i32
      cf.cond_br %42, ^bb3, ^bb7
    ^bb3:  // pred: ^bb2
      %43 = llhd.prb %gpio_tx_en : i32
      %44 = comb.shru %43, %41 : i32
      %45 = comb.extract %44 from 0 : (i32) -> i1
      cf.cond_br %45, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %46 = comb.extract %41 from 5 : (i32) -> i27
      %47 = comb.icmp eq %46, %c0_i27 : i27
      %48 = comb.extract %41 from 0 : (i32) -> i5
      %49 = comb.mux %47, %48, %c-1_i5 : i5
      %50 = llhd.sig.extract %gpio_ext_data from %49 : <i32> -> <i1>
      %51 = llhd.prb %gpio_sw_data_3 : i32
      %52 = comb.shru %51, %41 : i32
      %53 = comb.extract %52 from 0 : (i32) -> i1
      llhd.drv %50, %53 after %1 : i1
      cf.br ^bb6
    ^bb5:  // pred: ^bb3
      %54 = comb.extract %41 from 5 : (i32) -> i27
      %55 = comb.icmp eq %54, %c0_i27 : i27
      %56 = comb.extract %41 from 0 : (i32) -> i5
      %57 = comb.mux %55, %56, %c-1_i5 : i5
      %58 = llhd.sig.extract %gpio_ext_data from %57 : <i32> -> <i1>
      %59 = llhd.prb %gpio_ext_data_tmp : i32
      %60 = comb.shru %59, %41 : i32
      %61 = comb.extract %60 from 0 : (i32) -> i1
      llhd.drv %58, %61 after %1 : i1
      cf.br ^bb6
    ^bb6:  // 2 preds: ^bb4, ^bb5
      %62 = comb.add %41, %c1_i32 : i32
      cf.br ^bb2(%62 : i32)
    ^bb7:  // pred: ^bb2
      llhd.wait (%32, %36, %35, %34, %37 : i1, i32, i32, i32, i32), ^bb1
    }
    llhd.drv %pclk_0, %pclk after %1 : i1
    llhd.drv %pclk_int_1, %pclk_int after %1 : i1
    llhd.drv %presetn_2, %presetn after %1 : i1
    llhd.drv %gpio_sw_data_3, %gpio_sw_data after %1 : i32
    llhd.drv %gpio_sw_dir_4, %gpio_sw_dir after %1 : i32
    llhd.drv %gpio_int_en_5, %gpio_int_en after %1 : i32
    llhd.drv %gpio_int_type_6, %gpio_int_type after %1 : i32
    llhd.drv %gpio_int_pol_7, %gpio_int_pol after %1 : i32
    llhd.drv %gpio_debounce_8, %gpio_debounce after %1 : i32
    llhd.drv %gpio_int_clr_9, %gpio_int_clr after %1 : i32
    llhd.drv %gpio_rx_data_10, %gpio_rx_data after %1 : i32
    llhd.drv %gpio_int_level_sync_11, %gpio_int_level_sync after %1 : i1
    %38 = llhd.prb %gpio_int_clk_en : i1
    hw.output %33, %35, %36, %29, %29, %27, %27, %27, %23, %38, %16 : i32, i32, i32, i1, i1, i32, i32, i32, i32, i1, i32
  }
  hw.module private @gpio_top(out gpio_etb_trig : i32, in %pclk : i1, in %pclk_int : i1, in %dbclk : i1, in %dbclk_rstn : i1, in %scan_mode : i1, in %presetn : i1, in %penable : i1, in %pwrite : i1, in %pwdata : i32, in %paddr : i7, in %psel : i1, in %gpio_in_data : i32, out gpio_out_data : i32, out gpio_out_en : i32, out gpio_int_flag : i1, out gpio_int_clk_en : i1, out prdata : i32) {
    %U_GPIO_APBIF.gpio_sw_data, %U_GPIO_APBIF.gpio_sw_dir, %U_GPIO_APBIF.gpio_int_en, %U_GPIO_APBIF.gpio_int_mask, %U_GPIO_APBIF.gpio_int_type, %U_GPIO_APBIF.gpio_int_pol, %U_GPIO_APBIF.gpio_debounce, %U_GPIO_APBIF.gpio_int_clr, %U_GPIO_APBIF.gpio_int_level_sync, %U_GPIO_APBIF.prdata = hw.instance "U_GPIO_APBIF" @gpio_apbif(pclk: %pclk: i1, presetn: %presetn: i1, penable: %penable: i1, pwrite: %pwrite: i1, pwdata: %pwdata: i32, paddr: %paddr: i7, psel: %psel: i1, gpio_ext_data: %U_GPIO_CTRL.gpio_ext_data: i32, gpio_int_status: %U_GPIO_CTRL.gpio_int_status: i32, gpio_raw_int_status: %U_GPIO_CTRL.gpio_raw_int_status: i32) -> (gpio_sw_data: i32, gpio_sw_dir: i32, gpio_int_en: i32, gpio_int_mask: i32, gpio_int_type: i32, gpio_int_pol: i32, gpio_debounce: i32, gpio_int_clr: i32, gpio_int_level_sync: i1, prdata: i32) {sv.namehint = "gpio_debounce"}
    %U_GPIO_CTRL.gpio_tx_data, %U_GPIO_CTRL.gpio_tx_en, %U_GPIO_CTRL.gpio_ext_data, %U_GPIO_CTRL.gpio_int_flag, %U_GPIO_CTRL.gpio_int_flag_n, %U_GPIO_CTRL.gpio_int_status, %U_GPIO_CTRL.gpio_int, %U_GPIO_CTRL.gpio_int_n, %U_GPIO_CTRL.gpio_raw_int_status, %U_GPIO_CTRL.gpio_int_clk_en, %U_GPIO_CTRL.gpio_etb_trig = hw.instance "U_GPIO_CTRL" @gpio_ctrl(pclk: %pclk: i1, pclk_int: %pclk_int: i1, dbclk: %dbclk: i1, presetn: %presetn: i1, dbclk_rstn: %dbclk_rstn: i1, scan_mode: %scan_mode: i1, gpio_sw_data: %U_GPIO_APBIF.gpio_sw_data: i32, gpio_sw_dir: %U_GPIO_APBIF.gpio_sw_dir: i32, gpio_int_en: %U_GPIO_APBIF.gpio_int_en: i32, gpio_int_mask: %U_GPIO_APBIF.gpio_int_mask: i32, gpio_int_type: %U_GPIO_APBIF.gpio_int_type: i32, gpio_int_pol: %U_GPIO_APBIF.gpio_int_pol: i32, gpio_debounce: %U_GPIO_APBIF.gpio_debounce: i32, gpio_int_clr: %U_GPIO_APBIF.gpio_int_clr: i32, gpio_rx_data: %gpio_in_data: i32, gpio_int_level_sync: %U_GPIO_APBIF.gpio_int_level_sync: i1) -> (gpio_tx_data: i32, gpio_tx_en: i32, gpio_ext_data: i32, gpio_int_flag: i1, gpio_int_flag_n: i1, gpio_int_status: i32, gpio_int: i32, gpio_int_n: i32, gpio_raw_int_status: i32, gpio_int_clk_en: i1, gpio_etb_trig: i32) {sv.namehint = "gpio_int"}
    hw.output %U_GPIO_CTRL.gpio_etb_trig, %U_GPIO_CTRL.gpio_tx_data, %U_GPIO_CTRL.gpio_tx_en, %U_GPIO_CTRL.gpio_int_flag, %U_GPIO_CTRL.gpio_int_clk_en, %U_GPIO_APBIF.prdata : i32, i32, i32, i1, i1, i32
  }
  hw.module private @rtc0_sec_top(in %aortc_paddr : i32, in %aortc_pclk : i1, in %aortc_penable : i1, in %aortc_pprot : i3, out aortc_prdata : i32, in %aortc_psel : i1, in %aortc_pwdata : i32, in %aortc_pwrite : i1, in %aortc_rst_n : i1, in %etb_rtc_trig : i1, in %i_rtc_ext_clk : i1, out rtc0_vic_intr : i1, out rtc_etb_trig : i1, in %test_mode : i1, in %tipc_rtc0_trust : i1) {
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
