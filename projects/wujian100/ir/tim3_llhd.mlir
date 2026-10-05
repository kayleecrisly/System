module {
  hw.module @tim3_sec_top(in %etb_tim1_trig_en_off : i1, in %etb_tim1_trig_en_on : i1, in %etb_tim2_trig_en_off : i1, in %etb_tim2_trig_en_on : i1, out intr : i2, in %paddr : i32, in %pclk : i1, in %penable : i1, in %pprot : i3, out prdata : i32, in %presetn : i1, in %psel : i1, in %pwdata : i32, in %pwrite : i1, in %scan_mode : i1, out tim1_etb_trig : i1, out tim2_etb_trig : i1, in %tipc_tim3_trust : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %prdata = llhd.sig %c0_i32 : i32
    %x_tim3_tim_top.intr, %x_tim3_tim_top.prdata, %x_tim3_tim_top.tim1_etb_trig, %x_tim3_tim_top.tim2_etb_trig = hw.instance "x_tim3_tim_top" @tim3_tim_top(etb_tim1_trig_en_off: %etb_tim1_trig_en_off: i1, etb_tim1_trig_en_on: %etb_tim1_trig_en_on: i1, etb_tim2_trig_en_off: %etb_tim2_trig_en_off: i1, etb_tim2_trig_en_on: %etb_tim2_trig_en_on: i1, paddr: %paddr: i32, pclk: %pclk: i1, penable: %penable: i1, presetn: %presetn: i1, psel: %psel: i1, pwdata: %pwdata: i32, pwrite: %pwrite: i1, scan_mode: %scan_mode: i1) -> (intr: i2, prdata: i32, tim1_etb_trig: i1, tim2_etb_trig: i1) {sv.namehint = "i_prdata"}
    llhd.drv %prdata, %x_tim3_tim_top.prdata after %0 : i32
    %1 = llhd.prb %prdata : i32
    hw.output %x_tim3_tim_top.intr, %1, %x_tim3_tim_top.tim1_etb_trig, %x_tim3_tim_top.tim2_etb_trig : i2, i32, i1, i1
  }
  hw.module private @tim3_tim_top(in %etb_tim1_trig_en_off : i1, in %etb_tim1_trig_en_on : i1, in %etb_tim2_trig_en_off : i1, in %etb_tim2_trig_en_on : i1, out intr : i2, in %paddr : i32, in %pclk : i1, in %penable : i1, out prdata : i32, in %presetn : i1, in %psel : i1, in %pwdata : i32, in %pwrite : i1, in %scan_mode : i1, out tim1_etb_trig : i1, out tim2_etb_trig : i1) {
    %0 = comb.extract %paddr from 0 : (i32) -> i8
    %x_timers_top.timer_en, %x_timers_top.timertrig, %x_timers_top.timer_int, %x_timers_top.timer_int_n, %x_timers_top.timer_int_flag, %x_timers_top.timer_int_flag_n, %x_timers_top.tim1_etb_trig, %x_timers_top.tim2_etb_trig, %x_timers_top.prdata = hw.instance "x_timers_top" @timers_top(pclk: %pclk: i1, presetn: %presetn: i1, penable: %penable: i1, psel: %psel: i1, pwrite: %pwrite: i1, paddr: %0: i8, pwdata: %pwdata: i32, scan_mode: %scan_mode: i1, timer_1_clk: %pclk: i1, timer_2_clk: %pclk: i1, timer_1_resetn: %presetn: i1, timer_2_resetn: %presetn: i1, etb_tim1_trig_en_on: %etb_tim1_trig_en_on: i1, etb_tim1_trig_en_off: %etb_tim1_trig_en_off: i1, etb_tim2_trig_en_on: %etb_tim2_trig_en_on: i1, etb_tim2_trig_en_off: %etb_tim2_trig_en_off: i1) -> (timer_en: i2, timertrig: i2, timer_int: i2, timer_int_n: i2, timer_int_flag: i1, timer_int_flag_n: i1, tim1_etb_trig: i1, tim2_etb_trig: i1, prdata: i32) {sv.namehint = "timertrig"}
    hw.output %x_timers_top.timer_int, %x_timers_top.prdata, %x_timers_top.tim1_etb_trig, %x_timers_top.tim2_etb_trig : i2, i32, i1, i1
  }
  hw.module private @timers_apbif(in %pclk : i1, in %presetn : i1, in %penable : i1, in %pwrite : i1, in %pwdata : i32, in %paddr : i8, in %psel : i1, out timer1loadcount : i32, out timer2loadcount : i32, out timer_en : i2, out timer_mode : i2, out timer_hwen : i2, out timer_int_flag : i1, out timer_int_flag_n : i1, out timer_int : i2, out timer_int_n : i2, in %bus_current_value : i64, in %bus_interrupts : i2, out prdata : i32, in %etb_tim1_trig_en_on : i1, in %etb_tim2_trig_en_on : i1, in %etb_tim1_trig_en_off : i1, in %etb_tim2_trig_en_off : i1, out tim1_etb_trig : i1, out tim2_etb_trig : i1) {
    %c8_i6 = hw.constant 8 : i6
    %c7_i6 = hw.constant 7 : i6
    %c5_i6 = hw.constant 5 : i6
    %c3_i6 = hw.constant 3 : i6
    %c2_i6 = hw.constant 2 : i6
    %c0_i6 = hw.constant 0 : i6
    %c0_i31 = hw.constant 0 : i31
    %c0_i30 = hw.constant 0 : i30
    %c-1_i2 = hw.constant -1 : i2
    %c0_i3 = hw.constant 0 : i3
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i5 = hw.constant 0 : i5
    %c2_i32 = hw.constant 2 : i32
    %c0_i2 = hw.constant 0 : i2
    %c1_i32 = hw.constant 1 : i32
    %c42_i8 = hw.constant 42 : i8
    %c40_i8 = hw.constant 40 : i8
    %c9_i8 = hw.constant 9 : i8
    %c6_i8 = hw.constant 6 : i8
    %c4_i8 = hw.constant 4 : i8
    %c1_i8 = hw.constant 1 : i8
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %c41_i8 = hw.constant 41 : i8
    %c7_i8 = hw.constant 7 : i8
    %c5_i8 = hw.constant 5 : i8
    %c2_i8 = hw.constant 2 : i8
    %c0_i8 = hw.constant 0 : i8
    %true = hw.constant true
    %pclk_0 = llhd.sig name "pclk" %false : i1
    %2 = llhd.prb %pclk_0 : i1
    %presetn_1 = llhd.sig name "presetn" %false : i1
    %3 = llhd.prb %presetn_1 : i1
    %penable_2 = llhd.sig name "penable" %false : i1
    %pwrite_3 = llhd.sig name "pwrite" %false : i1
    %pwdata_4 = llhd.sig name "pwdata" %c0_i32 : i32
    %paddr_5 = llhd.sig name "paddr" %c0_i8 : i8
    %psel_6 = llhd.sig name "psel" %false : i1
    %timer1loadcount = llhd.sig %c0_i32 : i32
    %timer2loadcount = llhd.sig %c0_i32 : i32
    %bus_interrupts_7 = llhd.sig name "bus_interrupts" %c0_i2 : i2
    %prdata = llhd.sig %c0_i32 : i32
    %etb_tim1_trig_en_on_8 = llhd.sig name "etb_tim1_trig_en_on" %false : i1
    %etb_tim2_trig_en_on_9 = llhd.sig name "etb_tim2_trig_en_on" %false : i1
    %etb_tim1_trig_en_off_10 = llhd.sig name "etb_tim1_trig_en_off" %false : i1
    %etb_tim2_trig_en_off_11 = llhd.sig name "etb_tim2_trig_en_off" %false : i1
    %tim1_etb_trig = llhd.sig %false : i1
    %tim2_etb_trig = llhd.sig %false : i1
    %timer1controlreg = llhd.sig %c0_i5 : i5
    %timer2controlreg = llhd.sig %c0_i5 : i5
    %timer1loadcount_wen = llhd.sig %false : i1
    %timer1controlreg_wen = llhd.sig %false : i1
    %timer1eoi_ren = llhd.sig %false : i1
    %timer2loadcount_wen = llhd.sig %false : i1
    %timer2controlreg_wen = llhd.sig %false : i1
    %timer2eoi_ren = llhd.sig %false : i1
    %timerseoi_ren = llhd.sig %false : i1
    %ri_timer1loadcount = llhd.sig %c0_i32 : i32
    %ri_timer1currentvalue = llhd.sig %c0_i32 : i32
    %ri_timer1controlreg = llhd.sig %c0_i32 : i32
    %ri_timer1intstatus = llhd.sig %c0_i32 : i32
    %ri_timer2loadcount = llhd.sig %c0_i32 : i32
    %ri_timer2currentvalue = llhd.sig %c0_i32 : i32
    %ri_timer2controlreg = llhd.sig %c0_i32 : i32
    %ri_timer2intstatus = llhd.sig %c0_i32 : i32
    %timer1_int_ff1 = llhd.sig %false : i1
    %timer1_int_ff2 = llhd.sig %false : i1
    %timer2_int_ff1 = llhd.sig %false : i1
    %timer2_int_ff2 = llhd.sig %false : i1
    %timer_int_tmp = llhd.sig %c0_i2 : i2
    %int_sync_ff1 = llhd.sig %c0_i2 : i2
    %ri_timer_int = llhd.sig %c0_i32 : i32
    %ri_timersintstatus = llhd.sig %c0_i32 : i32
    %timer1currentvalue = llhd.sig %c0_i32 : i32
    %timer2currentvalue = llhd.sig %c0_i32 : i32
    %int_sync = llhd.sig %c0_i2 : i2
    %timereoi = llhd.sig %c0_i2 : i2
    %timerseoi = llhd.sig %false : i1
    %timeren = llhd.sig %c0_i2 : i2
    %timerintmask = llhd.sig %c0_i2 : i2
    %edge_detected = llhd.sig %c0_i2 : i2
    %i = llhd.sig %c0_i32 : i32
    %4 = llhd.prb %psel_6 : i1
    %5 = llhd.prb %penable_2 : i1
    %6 = llhd.prb %pwrite_3 : i1
    %7 = llhd.prb %paddr_5 : i8
    %8 = llhd.prb %timer1loadcount_wen : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %66 = llhd.prb %psel_6 : i1
      %67 = llhd.prb %penable_2 : i1
      %68 = llhd.prb %pwrite_3 : i1
      %69 = comb.and %66, %67, %68 : i1
      cf.cond_br %69, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %70 = llhd.prb %paddr_5 : i8
      %71 = comb.extract %70 from 2 : (i8) -> i6
      %72 = comb.icmp eq %71, %c0_i6 : i6
      cf.cond_br %72, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %timer1loadcount_wen, %true after %1 : i1
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      llhd.drv %timer1loadcount_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb5:  // pred: ^bb1
      llhd.drv %timer1loadcount_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
      llhd.wait (%4, %5, %6, %7, %8 : i1, i1, i1, i8, i1), ^bb1
    }
    %9 = llhd.prb %timer1controlreg_wen : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %66 = llhd.prb %psel_6 : i1
      %67 = llhd.prb %penable_2 : i1
      %68 = llhd.prb %pwrite_3 : i1
      %69 = comb.and %66, %67, %68 : i1
      cf.cond_br %69, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %70 = llhd.prb %paddr_5 : i8
      %71 = comb.extract %70 from 2 : (i8) -> i6
      %72 = comb.icmp eq %71, %c2_i6 : i6
      cf.cond_br %72, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %timer1controlreg_wen, %true after %1 : i1
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      llhd.drv %timer1controlreg_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb5:  // pred: ^bb1
      llhd.drv %timer1controlreg_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
      llhd.wait (%4, %5, %6, %7, %9 : i1, i1, i1, i8, i1), ^bb1
    }
    %10 = llhd.prb %timer1eoi_ren : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %66 = llhd.prb %psel_6 : i1
      %67 = llhd.prb %penable_2 : i1
      %68 = comb.xor %67, %true : i1
      %69 = llhd.prb %pwrite_3 : i1
      %70 = comb.xor %69, %true : i1
      %71 = comb.and %66, %68, %70 : i1
      cf.cond_br %71, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %72 = llhd.prb %paddr_5 : i8
      %73 = comb.extract %72 from 2 : (i8) -> i6
      %74 = comb.icmp eq %73, %c3_i6 : i6
      cf.cond_br %74, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %timer1eoi_ren, %true after %1 : i1
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      llhd.drv %timer1eoi_ren, %false after %1 : i1
      cf.br ^bb6
    ^bb5:  // pred: ^bb1
      llhd.drv %timer1eoi_ren, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
      llhd.wait (%4, %5, %6, %7, %10 : i1, i1, i1, i8, i1), ^bb1
    }
    %11 = llhd.prb %timer2loadcount_wen : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %66 = llhd.prb %psel_6 : i1
      %67 = llhd.prb %penable_2 : i1
      %68 = llhd.prb %pwrite_3 : i1
      %69 = comb.and %66, %67, %68 : i1
      cf.cond_br %69, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %70 = llhd.prb %paddr_5 : i8
      %71 = comb.extract %70 from 2 : (i8) -> i6
      %72 = comb.icmp eq %71, %c5_i6 : i6
      cf.cond_br %72, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %timer2loadcount_wen, %true after %1 : i1
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      llhd.drv %timer2loadcount_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb5:  // pred: ^bb1
      llhd.drv %timer2loadcount_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
      llhd.wait (%4, %5, %6, %7, %11 : i1, i1, i1, i8, i1), ^bb1
    }
    %12 = llhd.prb %timer2controlreg_wen : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %66 = llhd.prb %psel_6 : i1
      %67 = llhd.prb %penable_2 : i1
      %68 = llhd.prb %pwrite_3 : i1
      %69 = comb.and %66, %67, %68 : i1
      cf.cond_br %69, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %70 = llhd.prb %paddr_5 : i8
      %71 = comb.extract %70 from 2 : (i8) -> i6
      %72 = comb.icmp eq %71, %c7_i6 : i6
      cf.cond_br %72, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %timer2controlreg_wen, %true after %1 : i1
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      llhd.drv %timer2controlreg_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb5:  // pred: ^bb1
      llhd.drv %timer2controlreg_wen, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
      llhd.wait (%4, %5, %6, %7, %12 : i1, i1, i1, i8, i1), ^bb1
    }
    %13 = llhd.prb %timer2eoi_ren : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %66 = llhd.prb %psel_6 : i1
      %67 = llhd.prb %penable_2 : i1
      %68 = comb.xor %67, %true : i1
      %69 = llhd.prb %pwrite_3 : i1
      %70 = comb.xor %69, %true : i1
      %71 = comb.and %66, %68, %70 : i1
      cf.cond_br %71, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %72 = llhd.prb %paddr_5 : i8
      %73 = comb.extract %72 from 2 : (i8) -> i6
      %74 = comb.icmp eq %73, %c8_i6 : i6
      cf.cond_br %74, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %timer2eoi_ren, %true after %1 : i1
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      llhd.drv %timer2eoi_ren, %false after %1 : i1
      cf.br ^bb6
    ^bb5:  // pred: ^bb1
      llhd.drv %timer2eoi_ren, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
      llhd.wait (%4, %5, %6, %7, %13 : i1, i1, i1, i8, i1), ^bb1
    }
    %14 = llhd.prb %timerseoi_ren : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %66 = llhd.prb %psel_6 : i1
      %67 = llhd.prb %penable_2 : i1
      %68 = comb.xor %67, %true : i1
      %69 = llhd.prb %pwrite_3 : i1
      %70 = comb.xor %69, %true : i1
      %71 = comb.and %66, %68, %70 : i1
      cf.cond_br %71, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %72 = llhd.prb %paddr_5 : i8
      %73 = comb.icmp eq %72, %c41_i8 : i8
      cf.cond_br %73, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %timerseoi_ren, %true after %1 : i1
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      llhd.drv %timerseoi_ren, %false after %1 : i1
      cf.br ^bb6
    ^bb5:  // pred: ^bb1
      llhd.drv %timerseoi_ren, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
      llhd.wait (%4, %5, %6, %7, %14 : i1, i1, i1, i8, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %66 = llhd.prb %pclk_0 : i1
      %67 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %68 = llhd.prb %pclk_0 : i1
      %69 = comb.xor bin %66, %true : i1
      %70 = comb.and bin %69, %68 : i1
      %71 = llhd.prb %presetn_1 : i1
      %72 = comb.xor bin %71, %true : i1
      %73 = comb.and bin %67, %72 : i1
      %74 = comb.or bin %70, %73 : i1
      cf.cond_br %74, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %75 = llhd.prb %presetn_1 : i1
      %76 = comb.xor %75, %true : i1
      cf.cond_br %76, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %timer1loadcount, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %77 = llhd.prb %timer1loadcount_wen : i1
      cf.cond_br %77, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %78 = llhd.prb %pwdata_4 : i32
      llhd.drv %timer1loadcount, %78 after %0 : i32
      cf.br ^bb1
    }
    %15 = llhd.prb %ri_timer1loadcount : i32
    %16 = llhd.prb %timer1loadcount : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %ri_timer1loadcount, %c0_i32 after %1 : i32
      %66 = llhd.prb %timer1loadcount : i32
      llhd.drv %ri_timer1loadcount, %66 after %1 : i32
      llhd.wait (%15, %16 : i32, i32), ^bb1
    }
    %17 = llhd.prb %ri_timer1currentvalue : i32
    %18 = llhd.prb %timer1currentvalue : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %ri_timer1currentvalue, %c0_i32 after %1 : i32
      %66 = llhd.prb %timer1currentvalue : i32
      llhd.drv %ri_timer1currentvalue, %66 after %1 : i32
      llhd.wait (%17, %18 : i32, i32), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %66 = llhd.prb %pclk_0 : i1
      %67 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %68 = llhd.prb %pclk_0 : i1
      %69 = comb.xor bin %66, %true : i1
      %70 = comb.and bin %69, %68 : i1
      %71 = llhd.prb %presetn_1 : i1
      %72 = comb.xor bin %71, %true : i1
      %73 = comb.and bin %67, %72 : i1
      %74 = comb.or bin %70, %73 : i1
      cf.cond_br %74, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %75 = llhd.prb %presetn_1 : i1
      %76 = comb.xor %75, %true : i1
      cf.cond_br %76, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %timer1controlreg, %c0_i5 after %0 : i5
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %77 = llhd.prb %timer1controlreg_wen : i1
      cf.cond_br %77, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %78 = llhd.prb %pwdata_4 : i32
      %79 = comb.extract %78 from 0 : (i32) -> i5
      llhd.drv %timer1controlreg, %79 after %0 : i5
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %80 = llhd.prb %etb_tim1_trig_en_off_10 : i1
      cf.cond_br %80, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %81 = llhd.sig.extract %timer1controlreg from %c0_i3 : <i5> -> <i1>
      llhd.drv %81, %false after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %82 = llhd.prb %etb_tim1_trig_en_on_8 : i1
      cf.cond_br %82, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %83 = llhd.sig.extract %timer1controlreg from %c0_i3 : <i5> -> <i1>
      llhd.drv %83, %true after %0 : i1
      cf.br ^bb1
    }
    %19 = llhd.prb %ri_timer1controlreg : i32
    %20 = llhd.prb %timer1controlreg : i5
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %ri_timer1controlreg, %c0_i32 after %1 : i32
      %66 = llhd.sig.extract %ri_timer1controlreg from %c0_i5 : <i32> -> <i5>
      %67 = llhd.prb %timer1controlreg : i5
      llhd.drv %66, %67 after %1 : i5
      llhd.wait (%19, %20 : i32, i5), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %66 = llhd.prb %pclk_0 : i1
      %67 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %68 = llhd.prb %pclk_0 : i1
      %69 = comb.xor bin %66, %true : i1
      %70 = comb.and bin %69, %68 : i1
      %71 = llhd.prb %presetn_1 : i1
      %72 = comb.xor bin %71, %true : i1
      %73 = comb.and bin %67, %72 : i1
      %74 = comb.or bin %70, %73 : i1
      cf.cond_br %74, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %75 = llhd.prb %presetn_1 : i1
      %76 = comb.xor %75, %true : i1
      cf.cond_br %76, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %timer2loadcount, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %77 = llhd.prb %timer2loadcount_wen : i1
      cf.cond_br %77, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %78 = llhd.prb %pwdata_4 : i32
      llhd.drv %timer2loadcount, %78 after %0 : i32
      cf.br ^bb1
    }
    %21 = llhd.prb %ri_timer2loadcount : i32
    %22 = llhd.prb %timer2loadcount : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %ri_timer2loadcount, %c0_i32 after %1 : i32
      %66 = llhd.prb %timer2loadcount : i32
      llhd.drv %ri_timer2loadcount, %66 after %1 : i32
      llhd.wait (%21, %22 : i32, i32), ^bb1
    }
    %23 = llhd.prb %ri_timer2currentvalue : i32
    %24 = llhd.prb %timer2currentvalue : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %ri_timer2currentvalue, %c0_i32 after %1 : i32
      %66 = llhd.prb %timer2currentvalue : i32
      llhd.drv %ri_timer2currentvalue, %66 after %1 : i32
      llhd.wait (%23, %24 : i32, i32), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %66 = llhd.prb %pclk_0 : i1
      %67 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %68 = llhd.prb %pclk_0 : i1
      %69 = comb.xor bin %66, %true : i1
      %70 = comb.and bin %69, %68 : i1
      %71 = llhd.prb %presetn_1 : i1
      %72 = comb.xor bin %71, %true : i1
      %73 = comb.and bin %67, %72 : i1
      %74 = comb.or bin %70, %73 : i1
      cf.cond_br %74, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %75 = llhd.prb %presetn_1 : i1
      %76 = comb.xor %75, %true : i1
      cf.cond_br %76, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %timer2controlreg, %c0_i5 after %0 : i5
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %77 = llhd.prb %timer2controlreg_wen : i1
      cf.cond_br %77, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %78 = llhd.prb %pwdata_4 : i32
      %79 = comb.extract %78 from 0 : (i32) -> i5
      llhd.drv %timer2controlreg, %79 after %0 : i5
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %80 = llhd.prb %etb_tim2_trig_en_off_11 : i1
      cf.cond_br %80, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %81 = llhd.sig.extract %timer2controlreg from %c0_i3 : <i5> -> <i1>
      llhd.drv %81, %false after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %82 = llhd.prb %etb_tim2_trig_en_on_9 : i1
      cf.cond_br %82, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %83 = llhd.sig.extract %timer2controlreg from %c0_i3 : <i5> -> <i1>
      llhd.drv %83, %true after %0 : i1
      cf.br ^bb1
    }
    %25 = llhd.prb %ri_timer2controlreg : i32
    %26 = llhd.prb %timer2controlreg : i5
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %ri_timer2controlreg, %c0_i32 after %1 : i32
      %66 = llhd.sig.extract %ri_timer2controlreg from %c0_i5 : <i32> -> <i5>
      %67 = llhd.prb %timer2controlreg : i5
      llhd.drv %66, %67 after %1 : i5
      llhd.wait (%25, %26 : i32, i5), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 15 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb7, ^bb9, ^bb11, ^bb13, ^bb15, ^bb17, ^bb19, ^bb21, ^bb23, ^bb25, ^bb26
      %66 = llhd.prb %pclk_0 : i1
      %67 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %68 = llhd.prb %pclk_0 : i1
      %69 = comb.xor bin %66, %true : i1
      %70 = comb.and bin %69, %68 : i1
      %71 = llhd.prb %presetn_1 : i1
      %72 = comb.xor bin %71, %true : i1
      %73 = comb.and bin %67, %72 : i1
      %74 = comb.or bin %70, %73 : i1
      cf.cond_br %74, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %75 = llhd.prb %presetn_1 : i1
      %76 = comb.xor %75, %true : i1
      cf.cond_br %76, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %prdata, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %77 = llhd.prb %pwrite_3 : i1
      %78 = comb.xor %77, %true : i1
      %79 = llhd.prb %psel_6 : i1
      %80 = llhd.prb %penable_2 : i1
      %81 = comb.xor %80, %true : i1
      %82 = comb.and %78, %79, %81 : i1
      cf.cond_br %82, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %83 = llhd.prb %paddr_5 : i8
      %84 = comb.extract %83 from 2 : (i8) -> i6
      %85 = comb.concat %c0_i2, %84 : i2, i6
      %86 = comb.icmp ceq %85, %c0_i8 : i8
      cf.cond_br %86, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %87 = llhd.prb %ri_timer1loadcount : i32
      llhd.drv %prdata, %87 after %0 : i32
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %88 = comb.icmp ceq %85, %c1_i8 : i8
      cf.cond_br %88, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %89 = llhd.prb %ri_timer1currentvalue : i32
      llhd.drv %prdata, %89 after %0 : i32
      cf.br ^bb1
    ^bb10:  // pred: ^bb8
      %90 = comb.icmp ceq %85, %c2_i8 : i8
      cf.cond_br %90, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %91 = llhd.prb %ri_timer1controlreg : i32
      llhd.drv %prdata, %91 after %0 : i32
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      %92 = comb.icmp ceq %85, %c4_i8 : i8
      cf.cond_br %92, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      %93 = llhd.prb %ri_timer1intstatus : i32
      llhd.drv %prdata, %93 after %0 : i32
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      %94 = comb.icmp ceq %85, %c5_i8 : i8
      cf.cond_br %94, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      %95 = llhd.prb %ri_timer2loadcount : i32
      llhd.drv %prdata, %95 after %0 : i32
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      %96 = comb.icmp ceq %85, %c6_i8 : i8
      cf.cond_br %96, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      %97 = llhd.prb %ri_timer2currentvalue : i32
      llhd.drv %prdata, %97 after %0 : i32
      cf.br ^bb1
    ^bb18:  // pred: ^bb16
      %98 = comb.icmp ceq %85, %c7_i8 : i8
      cf.cond_br %98, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %99 = llhd.prb %ri_timer2controlreg : i32
      llhd.drv %prdata, %99 after %0 : i32
      cf.br ^bb1
    ^bb20:  // pred: ^bb18
      %100 = comb.icmp ceq %85, %c9_i8 : i8
      cf.cond_br %100, ^bb21, ^bb22
    ^bb21:  // pred: ^bb20
      %101 = llhd.prb %ri_timer2intstatus : i32
      llhd.drv %prdata, %101 after %0 : i32
      cf.br ^bb1
    ^bb22:  // pred: ^bb20
      %102 = comb.icmp ceq %85, %c40_i8 : i8
      cf.cond_br %102, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      %103 = llhd.prb %ri_timersintstatus : i32
      llhd.drv %prdata, %103 after %0 : i32
      cf.br ^bb1
    ^bb24:  // pred: ^bb22
      %104 = comb.icmp ceq %85, %c42_i8 : i8
      cf.cond_br %104, ^bb25, ^bb26
    ^bb25:  // pred: ^bb24
      %105 = llhd.prb %ri_timer_int : i32
      llhd.drv %prdata, %105 after %0 : i32
      cf.br ^bb1
    ^bb26:  // pred: ^bb24
      llhd.drv %prdata, %c0_i32 after %0 : i32
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %66 = llhd.prb %pclk_0 : i1
      %67 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %68 = llhd.prb %pclk_0 : i1
      %69 = comb.xor bin %66, %true : i1
      %70 = comb.and bin %69, %68 : i1
      %71 = llhd.prb %presetn_1 : i1
      %72 = comb.xor bin %71, %true : i1
      %73 = comb.and bin %67, %72 : i1
      %74 = comb.or bin %70, %73 : i1
      cf.cond_br %74, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %75 = llhd.prb %presetn_1 : i1
      %76 = comb.xor %75, %true : i1
      cf.cond_br %76, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %timer1_int_ff1, %false after %0 : i1
      llhd.drv %timer1_int_ff2, %false after %0 : i1
      llhd.drv %timer2_int_ff1, %false after %0 : i1
      llhd.drv %timer2_int_ff2, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %77 = llhd.prb %bus_interrupts_7 : i2
      %78 = comb.extract %77 from 0 : (i2) -> i1
      llhd.drv %timer1_int_ff1, %78 after %0 : i1
      %79 = llhd.prb %bus_interrupts_7 : i2
      %80 = comb.extract %79 from 1 : (i2) -> i1
      llhd.drv %timer2_int_ff1, %80 after %0 : i1
      %81 = llhd.prb %timer1_int_ff1 : i1
      llhd.drv %timer1_int_ff2, %81 after %0 : i1
      %82 = llhd.prb %timer2_int_ff1 : i1
      llhd.drv %timer2_int_ff2, %82 after %0 : i1
      cf.br ^bb1
    }
    %27 = llhd.sig.extract %int_sync from %false : <i2> -> <i1>
    %28 = llhd.prb %bus_interrupts_7 : i2
    %29 = comb.extract %28 from 0 : (i2) -> i1
    llhd.drv %27, %29 after %1 : i1
    %30 = llhd.sig.extract %int_sync from %true : <i2> -> <i1>
    %31 = comb.extract %28 from 1 : (i2) -> i1
    llhd.drv %30, %31 after %1 : i1
    %32 = comb.extract %bus_current_value from 0 : (i64) -> i32
    llhd.drv %timer1currentvalue, %32 after %1 : i32
    %33 = comb.extract %bus_current_value from 32 : (i64) -> i32
    llhd.drv %timer2currentvalue, %33 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %66 = llhd.prb %pclk_0 : i1
      %67 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %68 = llhd.prb %pclk_0 : i1
      %69 = comb.xor bin %66, %true : i1
      %70 = comb.and bin %69, %68 : i1
      %71 = llhd.prb %presetn_1 : i1
      %72 = comb.xor bin %71, %true : i1
      %73 = comb.and bin %67, %72 : i1
      %74 = comb.or bin %70, %73 : i1
      cf.cond_br %74, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %75 = llhd.prb %presetn_1 : i1
      %76 = comb.xor %75, %true : i1
      cf.cond_br %76, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_sync_ff1, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %77 = llhd.prb %int_sync : i2
      llhd.drv %int_sync_ff1, %77 after %0 : i2
      cf.br ^bb1
    }
    %34 = llhd.prb %int_sync : i2
    %35 = llhd.prb %int_sync_ff1 : i2
    %36 = comb.xor %35, %c-1_i2 : i2
    %37 = comb.and %34, %36 : i2
    llhd.drv %edge_detected, %37 after %1 : i2
    %38 = comb.concat %13, %10 : i1, i1
    llhd.drv %timereoi, %38 after %1 : i2
    llhd.drv %timerseoi, %14 after %1 : i1
    %39 = comb.extract %26 from 0 : (i5) -> i1
    %40 = comb.extract %20 from 0 : (i5) -> i1
    %41 = comb.concat %39, %40 : i1, i1
    llhd.drv %timeren, %41 after %1 : i2
    %42 = comb.extract %26 from 1 : (i5) -> i1
    %43 = comb.extract %20 from 1 : (i5) -> i1
    %44 = comb.concat %42, %43 {sv.namehint = "timermode"} : i1, i1
    %45 = comb.extract %26 from 4 : (i5) -> i1
    %46 = comb.extract %20 from 4 : (i5) -> i1
    %47 = comb.concat %45, %46 {sv.namehint = "timerhwen"} : i1, i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb6
      %66 = llhd.prb %pclk_0 : i1
      %67 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %68 = llhd.prb %pclk_0 : i1
      %69 = comb.xor bin %66, %true : i1
      %70 = comb.and bin %69, %68 : i1
      %71 = llhd.prb %presetn_1 : i1
      %72 = comb.xor bin %71, %true : i1
      %73 = comb.and bin %67, %72 : i1
      %74 = comb.or bin %70, %73 : i1
      cf.cond_br %74, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %75 = llhd.prb %presetn_1 : i1
      %76 = comb.xor %75, %true : i1
      cf.cond_br %76, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %timer_int_tmp, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      llhd.drv %i, %c0_i32 after %1 : i32
      cf.br ^bb6
    ^bb6:  // 2 preds: ^bb5, ^bb13
      %77 = llhd.prb %i : i32
      %78 = comb.icmp slt %77, %c2_i32 : i32
      cf.cond_br %78, ^bb7, ^bb1
    ^bb7:  // pred: ^bb6
      %79 = llhd.prb %edge_detected : i2
      %80 = llhd.prb %i : i32
      %81 = comb.extract %80 from 2 : (i32) -> i30
      %82 = comb.icmp eq %81, %c0_i30 : i30
      %83 = comb.extract %80 from 0 : (i32) -> i2
      %84 = comb.mux %82, %83, %c-1_i2 : i2
      %85 = comb.shru %79, %84 : i2
      %86 = comb.extract %85 from 0 : (i2) -> i1
      cf.cond_br %86, ^bb8, ^bb11
    ^bb8:  // pred: ^bb7
      %87 = llhd.prb %timeren : i2
      %88 = llhd.prb %i : i32
      %89 = comb.extract %88 from 2 : (i32) -> i30
      %90 = comb.icmp eq %89, %c0_i30 : i30
      %91 = comb.extract %88 from 0 : (i32) -> i2
      %92 = comb.mux %90, %91, %c-1_i2 : i2
      %93 = comb.shru %87, %92 : i2
      %94 = comb.extract %93 from 0 : (i2) -> i1
      cf.cond_br %94, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %95 = llhd.prb %i : i32
      %96 = comb.extract %95 from 1 : (i32) -> i31
      %97 = comb.extract %95 from 0 : (i32) -> i1
      %98 = comb.icmp ne %96, %c0_i31 : i31
      %99 = comb.or %98, %97 : i1
      %100 = llhd.sig.extract %timer_int_tmp from %99 : <i2> -> <i1>
      llhd.drv %100, %true after %0 : i1
      cf.br ^bb13
    ^bb10:  // pred: ^bb8
      %101 = llhd.prb %i : i32
      %102 = comb.extract %101 from 1 : (i32) -> i31
      %103 = comb.extract %101 from 0 : (i32) -> i1
      %104 = comb.icmp ne %102, %c0_i31 : i31
      %105 = comb.or %104, %103 : i1
      %106 = llhd.sig.extract %timer_int_tmp from %105 : <i2> -> <i1>
      llhd.drv %106, %false after %0 : i1
      cf.br ^bb13
    ^bb11:  // pred: ^bb7
      %107 = llhd.prb %timereoi : i2
      %108 = llhd.prb %i : i32
      %109 = comb.extract %108 from 2 : (i32) -> i30
      %110 = comb.icmp eq %109, %c0_i30 : i30
      %111 = comb.extract %108 from 0 : (i32) -> i2
      %112 = comb.mux %110, %111, %c-1_i2 : i2
      %113 = comb.shru %107, %112 : i2
      %114 = comb.extract %113 from 0 : (i2) -> i1
      %115 = llhd.prb %timerseoi : i1
      %116 = llhd.prb %timeren : i2
      %117 = comb.shru %116, %112 : i2
      %118 = comb.extract %117 from 0 : (i2) -> i1
      %119 = comb.xor %118, %true : i1
      %120 = comb.or %114, %115, %119 : i1
      cf.cond_br %120, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %121 = llhd.prb %i : i32
      %122 = comb.extract %121 from 1 : (i32) -> i31
      %123 = comb.extract %121 from 0 : (i32) -> i1
      %124 = comb.icmp ne %122, %c0_i31 : i31
      %125 = comb.or %124, %123 : i1
      %126 = llhd.sig.extract %timer_int_tmp from %125 : <i2> -> <i1>
      llhd.drv %126, %false after %0 : i1
      cf.br ^bb13
    ^bb13:  // 4 preds: ^bb9, ^bb10, ^bb11, ^bb12
      %127 = llhd.prb %i : i32
      %128 = comb.add %127, %c1_i32 : i32
      llhd.drv %i, %128 after %1 : i32
      cf.br ^bb6
    }
    %48 = llhd.prb %ri_timer_int : i32
    %49 = llhd.prb %timer_int_tmp : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %ri_timer_int, %c0_i32 after %1 : i32
      %66 = llhd.sig.extract %ri_timer_int from %c0_i5 : <i32> -> <i2>
      %67 = llhd.prb %timer_int_tmp : i2
      llhd.drv %66, %67 after %1 : i2
      llhd.wait (%48, %49 : i32, i2), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %66 = llhd.prb %pclk_0 : i1
      %67 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %68 = llhd.prb %pclk_0 : i1
      %69 = comb.xor bin %66, %true : i1
      %70 = comb.and bin %69, %68 : i1
      %71 = llhd.prb %presetn_1 : i1
      %72 = comb.xor bin %71, %true : i1
      %73 = comb.and bin %67, %72 : i1
      %74 = comb.or bin %70, %73 : i1
      cf.cond_br %74, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %75 = llhd.prb %presetn_1 : i1
      %76 = comb.xor %75, %true : i1
      cf.cond_br %76, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %tim1_etb_trig, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %77 = llhd.prb %edge_detected : i2
      %78 = comb.extract %77 from 0 : (i2) -> i1
      cf.cond_br %78, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %tim1_etb_trig, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      llhd.drv %tim1_etb_trig, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %66 = llhd.prb %pclk_0 : i1
      %67 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %68 = llhd.prb %pclk_0 : i1
      %69 = comb.xor bin %66, %true : i1
      %70 = comb.and bin %69, %68 : i1
      %71 = llhd.prb %presetn_1 : i1
      %72 = comb.xor bin %71, %true : i1
      %73 = comb.and bin %67, %72 : i1
      %74 = comb.or bin %70, %73 : i1
      cf.cond_br %74, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %75 = llhd.prb %presetn_1 : i1
      %76 = comb.xor %75, %true : i1
      cf.cond_br %76, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %tim2_etb_trig, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %77 = llhd.prb %edge_detected : i2
      %78 = comb.extract %77 from 1 : (i2) -> i1
      cf.cond_br %78, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %tim2_etb_trig, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      llhd.drv %tim2_etb_trig, %false after %0 : i1
      cf.br ^bb1
    }
    %50 = llhd.sig.extract %timerintmask from %false : <i2> -> <i1>
    %51 = comb.extract %20 from 2 : (i5) -> i1
    llhd.drv %50, %51 after %1 : i1
    %52 = llhd.sig.extract %timerintmask from %true : <i2> -> <i1>
    %53 = comb.extract %26 from 2 : (i5) -> i1
    llhd.drv %52, %53 after %1 : i1
    %54 = llhd.prb %ri_timer1intstatus : i32
    %55 = llhd.prb %ri_timer2intstatus : i32
    %56 = llhd.prb %ri_timersintstatus : i32
    %57 = llhd.prb %timerintmask : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %ri_timer1intstatus, %c0_i32 after %1 : i32
      llhd.drv %ri_timer2intstatus, %c0_i32 after %1 : i32
      llhd.drv %ri_timersintstatus, %c0_i32 after %1 : i32
      %66 = llhd.sig.extract %ri_timer1intstatus from %c0_i5 : <i32> -> <i1>
      %67 = llhd.prb %ri_timer_int : i32
      %68 = comb.extract %67 from 0 : (i32) -> i1
      %69 = llhd.prb %timerintmask : i2
      %70 = comb.extract %69 from 0 : (i2) -> i1
      %71 = comb.xor %70, %true : i1
      %72 = comb.and %68, %71 : i1
      llhd.drv %66, %72 after %1 : i1
      %73 = llhd.sig.extract %ri_timer2intstatus from %c0_i5 : <i32> -> <i1>
      %74 = llhd.prb %ri_timer_int : i32
      %75 = comb.extract %74 from 1 : (i32) -> i1
      %76 = llhd.prb %timerintmask : i2
      %77 = comb.extract %76 from 1 : (i2) -> i1
      %78 = comb.xor %77, %true : i1
      %79 = comb.and %75, %78 : i1
      llhd.drv %73, %79 after %1 : i1
      %80 = llhd.sig.extract %ri_timersintstatus from %c0_i5 : <i32> -> <i2>
      %81 = llhd.prb %ri_timer_int : i32
      %82 = comb.extract %81 from 0 : (i32) -> i2
      %83 = llhd.prb %timerintmask : i2
      %84 = comb.xor %83, %c-1_i2 : i2
      %85 = comb.and %82, %84 : i2
      llhd.drv %80, %85 after %1 : i2
      llhd.wait (%54, %55, %56, %48, %57 : i32, i32, i32, i32, i2), ^bb1
    }
    %58 = comb.icmp ne %56, %c0_i32 : i32
    %59 = comb.xor %58, %true : i1
    %60 = comb.extract %56 from 0 : (i32) -> i2
    %61 = comb.xor %60, %c-1_i2 : i2
    %62 = llhd.prb %timeren : i2
    llhd.drv %pclk_0, %pclk after %1 : i1
    llhd.drv %presetn_1, %presetn after %1 : i1
    llhd.drv %penable_2, %penable after %1 : i1
    llhd.drv %pwrite_3, %pwrite after %1 : i1
    llhd.drv %pwdata_4, %pwdata after %1 : i32
    llhd.drv %paddr_5, %paddr after %1 : i8
    llhd.drv %psel_6, %psel after %1 : i1
    llhd.drv %bus_interrupts_7, %bus_interrupts after %1 : i2
    %63 = llhd.prb %prdata : i32
    llhd.drv %etb_tim1_trig_en_on_8, %etb_tim1_trig_en_on after %1 : i1
    llhd.drv %etb_tim2_trig_en_on_9, %etb_tim2_trig_en_on after %1 : i1
    llhd.drv %etb_tim1_trig_en_off_10, %etb_tim1_trig_en_off after %1 : i1
    llhd.drv %etb_tim2_trig_en_off_11, %etb_tim2_trig_en_off after %1 : i1
    %64 = llhd.prb %tim1_etb_trig : i1
    %65 = llhd.prb %tim2_etb_trig : i1
    hw.output %16, %22, %62, %44, %47, %58, %59, %60, %61, %63, %64, %65 : i32, i32, i2, i2, i2, i1, i1, i2, i2, i32, i1, i1
  }
  hw.module private @timers_frc(in %timer_clk : i1, in %timer_resetn : i1, in %timer_en : i1, in %timer_mode : i1, in %timerhwen : i1, in %load_value : i32, out current_value : i32, out toggle : i1, out interrupt : i1, out timertrig : i1) {
    %c-1_i32 = hw.constant -1 : i32
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %true = hw.constant true
    %timer_clk_0 = llhd.sig name "timer_clk" %false : i1
    %2 = llhd.prb %timer_clk_0 : i1
    %timer_resetn_1 = llhd.sig name "timer_resetn" %false : i1
    %3 = llhd.prb %timer_resetn_1 : i1
    %timer_en_2 = llhd.sig name "timer_en" %false : i1
    %timer_mode_3 = llhd.sig name "timer_mode" %false : i1
    %load_value_4 = llhd.sig name "load_value" %c0_i32 : i32
    %current_value = llhd.sig %c0_i32 : i32
    %toggle = llhd.sig %false : i1
    %rising_edge = llhd.sig %false : i1
    %atzero = llhd.sig %false : i1
    %timer = llhd.sig %c0_i32 : i32
    %extend1 = llhd.sig %false : i1
    %extend2 = llhd.sig %false : i1
    %extend3 = llhd.sig %false : i1
    %load = llhd.sig %false : i1
    %raw_interrupt = llhd.sig %false : i1
    %interrupt_extd1 = llhd.sig %false : i1
    %interrupt_extd2 = llhd.sig %false : i1
    %interrupt_extd3 = llhd.sig %false : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %22 = llhd.prb %timer_clk_0 : i1
      %23 = llhd.prb %timer_resetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %24 = llhd.prb %timer_clk_0 : i1
      %25 = comb.xor bin %22, %true : i1
      %26 = comb.and bin %25, %24 : i1
      %27 = llhd.prb %timer_resetn_1 : i1
      %28 = comb.xor bin %27, %true : i1
      %29 = comb.and bin %23, %28 : i1
      %30 = comb.or bin %26, %29 : i1
      cf.cond_br %30, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %31 = llhd.prb %timer_resetn_1 : i1
      %32 = comb.xor %31, %true : i1
      cf.cond_br %32, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rising_edge, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %33 = llhd.prb %timer_en_2 : i1
      llhd.drv %rising_edge, %33 after %1 : i1
      cf.br ^bb1
    }
    %4 = llhd.prb %timer_en_2 : i1
    %5 = llhd.prb %rising_edge : i1
    %6 = comb.xor %5, %true : i1
    %7 = comb.and %4, %6 : i1
    llhd.drv %load, %7 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 8 preds: ^bb0, ^bb2, ^bb4, ^bb7, ^bb10, ^bb11, ^bb12, ^bb13
      %22 = llhd.prb %timer_clk_0 : i1
      %23 = llhd.prb %timer_resetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %24 = llhd.prb %timer_clk_0 : i1
      %25 = comb.xor bin %22, %true : i1
      %26 = comb.and bin %25, %24 : i1
      %27 = llhd.prb %timer_resetn_1 : i1
      %28 = comb.xor bin %27, %true : i1
      %29 = comb.and bin %23, %28 : i1
      %30 = comb.or bin %26, %29 : i1
      cf.cond_br %30, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %31 = llhd.prb %timer_resetn_1 : i1
      %32 = comb.xor %31, %true : i1
      cf.cond_br %32, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %timer, %c-1_i32 after %1 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %33 = llhd.prb %timer_en_2 : i1
      cf.cond_br %33, ^bb6, ^bb13
    ^bb6:  // pred: ^bb5
      %34 = llhd.prb %load : i1
      cf.cond_br %34, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %35 = llhd.prb %load_value_4 : i32
      llhd.drv %timer, %35 after %1 : i32
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %36 = llhd.prb %timer : i32
      %37 = comb.icmp eq %36, %c0_i32 : i32
      cf.cond_br %37, ^bb9, ^bb12
    ^bb9:  // pred: ^bb8
      %38 = llhd.prb %timer_mode_3 : i1
      %39 = comb.xor %38, %true : i1
      cf.cond_br %39, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      llhd.drv %timer, %c-1_i32 after %1 : i32
      cf.br ^bb1
    ^bb11:  // pred: ^bb9
      %40 = llhd.prb %load_value_4 : i32
      llhd.drv %timer, %40 after %1 : i32
      cf.br ^bb1
    ^bb12:  // pred: ^bb8
      %41 = llhd.prb %timer : i32
      %42 = comb.add %41, %c-1_i32 : i32
      llhd.drv %timer, %42 after %1 : i32
      cf.br ^bb1
    ^bb13:  // pred: ^bb5
      llhd.drv %timer, %c-1_i32 after %1 : i32
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %22 = llhd.prb %timer_clk_0 : i1
      %23 = llhd.prb %timer_resetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %24 = llhd.prb %timer_clk_0 : i1
      %25 = comb.xor bin %22, %true : i1
      %26 = comb.and bin %25, %24 : i1
      %27 = llhd.prb %timer_resetn_1 : i1
      %28 = comb.xor bin %27, %true : i1
      %29 = comb.and bin %23, %28 : i1
      %30 = comb.or bin %26, %29 : i1
      cf.cond_br %30, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %31 = llhd.prb %timer_resetn_1 : i1
      %32 = comb.xor %31, %true : i1
      cf.cond_br %32, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %atzero, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %33 = llhd.prb %timer : i32
      %34 = comb.icmp eq %33, %c0_i32 : i32
      llhd.drv %atzero, %34 after %1 : i1
      cf.br ^bb1
    }
    %8 = llhd.prb %atzero : i1
    llhd.drv %raw_interrupt, %8 after %0 : i1
    %9 = comb.and %8, %timerhwen : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %22 = llhd.prb %timer_clk_0 : i1
      %23 = llhd.prb %timer_resetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %24 = llhd.prb %timer_clk_0 : i1
      %25 = comb.xor bin %22, %true : i1
      %26 = comb.and bin %25, %24 : i1
      %27 = llhd.prb %timer_resetn_1 : i1
      %28 = comb.xor bin %27, %true : i1
      %29 = comb.and bin %23, %28 : i1
      %30 = comb.or bin %26, %29 : i1
      cf.cond_br %30, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %31 = llhd.prb %timer_resetn_1 : i1
      %32 = comb.xor %31, %true : i1
      cf.cond_br %32, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %toggle, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %33 = llhd.prb %timer : i32
      %34 = comb.icmp eq %33, %c0_i32 : i32
      cf.cond_br %34, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %35 = llhd.prb %toggle : i1
      %36 = comb.xor %35, %true : i1
      llhd.drv %toggle, %36 after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %22 = llhd.prb %timer_clk_0 : i1
      %23 = llhd.prb %timer_resetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %24 = llhd.prb %timer_clk_0 : i1
      %25 = comb.xor bin %22, %true : i1
      %26 = comb.and bin %25, %24 : i1
      %27 = llhd.prb %timer_resetn_1 : i1
      %28 = comb.xor bin %27, %true : i1
      %29 = comb.and bin %23, %28 : i1
      %30 = comb.or bin %26, %29 : i1
      cf.cond_br %30, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %31 = llhd.prb %timer_resetn_1 : i1
      %32 = comb.xor %31, %true : i1
      cf.cond_br %32, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %extend1, %false after %1 : i1
      llhd.drv %extend2, %false after %1 : i1
      llhd.drv %extend3, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %33 = llhd.prb %raw_interrupt : i1
      llhd.drv %extend1, %33 after %1 : i1
      %34 = llhd.prb %extend1 : i1
      llhd.drv %extend2, %34 after %1 : i1
      %35 = llhd.prb %extend2 : i1
      llhd.drv %extend3, %35 after %1 : i1
      cf.br ^bb1
    }
    %10 = llhd.prb %raw_interrupt : i1
    %11 = llhd.prb %extend1 : i1
    %12 = comb.or %10, %11 : i1
    llhd.drv %interrupt_extd1, %12 after %0 : i1
    %13 = llhd.prb %interrupt_extd1 : i1
    %14 = llhd.prb %extend2 : i1
    %15 = comb.or %13, %14 : i1
    llhd.drv %interrupt_extd2, %15 after %0 : i1
    %16 = llhd.prb %interrupt_extd2 : i1
    %17 = llhd.prb %extend3 : i1
    %18 = comb.or %16, %17 : i1
    llhd.drv %interrupt_extd3, %18 after %0 : i1
    %19 = llhd.prb %current_value : i32
    %20 = llhd.prb %timer : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb3
      llhd.drv %current_value, %c0_i32 after %0 : i32
      %22 = llhd.prb %timer_en_2 : i1
      cf.cond_br %22, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %23 = llhd.prb %timer : i32
      llhd.drv %current_value, %23 after %0 : i32
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      llhd.wait (%19, %4, %20 : i32, i1, i32), ^bb1
    }
    llhd.drv %timer_clk_0, %timer_clk after %0 : i1
    llhd.drv %timer_resetn_1, %timer_resetn after %0 : i1
    llhd.drv %timer_en_2, %timer_en after %0 : i1
    llhd.drv %timer_mode_3, %timer_mode after %0 : i1
    llhd.drv %load_value_4, %load_value after %0 : i32
    %21 = llhd.prb %toggle : i1
    hw.output %19, %21, %13, %9 : i32, i1, i1, i1
  }
  hw.module private @timers_top(in %pclk : i1, in %presetn : i1, in %penable : i1, in %psel : i1, in %pwrite : i1, in %paddr : i8, in %pwdata : i32, in %scan_mode : i1, in %timer_1_clk : i1, in %timer_2_clk : i1, in %timer_1_resetn : i1, in %timer_2_resetn : i1, out timer_en : i2, out timertrig : i2, out timer_int : i2, out timer_int_n : i2, out timer_int_flag : i1, out timer_int_flag_n : i1, in %etb_tim1_trig_en_on : i1, in %etb_tim1_trig_en_off : i1, in %etb_tim2_trig_en_on : i1, in %etb_tim2_trig_en_off : i1, out tim1_etb_trig : i1, out tim2_etb_trig : i1, out prdata : i32) {
    %true = hw.constant true
    %c-32_i6 = hw.constant -32 : i6
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %c0_i6 = hw.constant 0 : i6
    %c0_i64 = hw.constant 0 : i64
    %c0_i2 = hw.constant 0 : i2
    %timertrig = llhd.sig %c0_i2 : i2
    %bus_current_value = llhd.sig %c0_i64 : i64
    %bus_interrupt = llhd.sig %c0_i2 : i2
    %1 = llhd.prb %bus_current_value : i64
    %2 = llhd.prb %bus_interrupt : i2
    %U_TIMERS_APBIF.timer1loadcount, %U_TIMERS_APBIF.timer2loadcount, %U_TIMERS_APBIF.timer_en, %U_TIMERS_APBIF.timer_mode, %U_TIMERS_APBIF.timer_hwen, %U_TIMERS_APBIF.timer_int_flag, %U_TIMERS_APBIF.timer_int_flag_n, %U_TIMERS_APBIF.timer_int, %U_TIMERS_APBIF.timer_int_n, %U_TIMERS_APBIF.prdata, %U_TIMERS_APBIF.tim1_etb_trig, %U_TIMERS_APBIF.tim2_etb_trig = hw.instance "U_TIMERS_APBIF" @timers_apbif(pclk: %pclk: i1, presetn: %presetn: i1, penable: %penable: i1, pwrite: %pwrite: i1, pwdata: %pwdata: i32, paddr: %paddr: i8, psel: %psel: i1, bus_current_value: %1: i64, bus_interrupts: %2: i2, etb_tim1_trig_en_on: %etb_tim1_trig_en_on: i1, etb_tim2_trig_en_on: %etb_tim2_trig_en_on: i1, etb_tim1_trig_en_off: %etb_tim1_trig_en_off: i1, etb_tim2_trig_en_off: %etb_tim2_trig_en_off: i1) -> (timer1loadcount: i32, timer2loadcount: i32, timer_en: i2, timer_mode: i2, timer_hwen: i2, timer_int_flag: i1, timer_int_flag_n: i1, timer_int: i2, timer_int_n: i2, prdata: i32, tim1_etb_trig: i1, tim2_etb_trig: i1) {sv.namehint = "timer2loadcount"}
    %3 = comb.extract %U_TIMERS_APBIF.timer_en from 0 : (i2) -> i1
    %4 = comb.extract %U_TIMERS_APBIF.timer_mode from 0 : (i2) -> i1
    %5 = comb.extract %U_TIMERS_APBIF.timer_hwen from 0 : (i2) -> i1
    %6 = llhd.sig.extract %bus_current_value from %c0_i6 : <i64> -> <i32>
    %7 = llhd.sig.extract %bus_interrupt from %false : <i2> -> <i1>
    %8 = llhd.sig.extract %timertrig from %false : <i2> -> <i1>
    %U_TIMER0.current_value, %U_TIMER0.toggle, %U_TIMER0.interrupt, %U_TIMER0.timertrig = hw.instance "U_TIMER0" @timers_frc(timer_clk: %timer_1_clk: i1, timer_resetn: %timer_1_resetn: i1, timer_en: %3: i1, timer_mode: %4: i1, timerhwen: %5: i1, load_value: %U_TIMERS_APBIF.timer1loadcount: i32) -> (current_value: i32, toggle: i1, interrupt: i1, timertrig: i1) {sv.namehint = "timer_1_toggle"}
    llhd.drv %6, %U_TIMER0.current_value after %0 : i32
    llhd.drv %7, %U_TIMER0.interrupt after %0 : i1
    llhd.drv %8, %U_TIMER0.timertrig after %0 : i1
    %9 = comb.extract %U_TIMERS_APBIF.timer_en from 1 : (i2) -> i1
    %10 = comb.extract %U_TIMERS_APBIF.timer_mode from 1 : (i2) -> i1
    %11 = comb.extract %U_TIMERS_APBIF.timer_hwen from 1 : (i2) -> i1
    %12 = llhd.sig.extract %bus_current_value from %c-32_i6 : <i64> -> <i32>
    %13 = llhd.sig.extract %bus_interrupt from %true : <i2> -> <i1>
    %14 = llhd.sig.extract %timertrig from %true : <i2> -> <i1>
    %U_TIMER1.current_value, %U_TIMER1.toggle, %U_TIMER1.interrupt, %U_TIMER1.timertrig = hw.instance "U_TIMER1" @timers_frc(timer_clk: %timer_2_clk: i1, timer_resetn: %timer_2_resetn: i1, timer_en: %9: i1, timer_mode: %10: i1, timerhwen: %11: i1, load_value: %U_TIMERS_APBIF.timer2loadcount: i32) -> (current_value: i32, toggle: i1, interrupt: i1, timertrig: i1) {sv.namehint = "timer_2_toggle"}
    llhd.drv %12, %U_TIMER1.current_value after %0 : i32
    llhd.drv %13, %U_TIMER1.interrupt after %0 : i1
    llhd.drv %14, %U_TIMER1.timertrig after %0 : i1
    %15 = llhd.prb %timertrig : i2
    hw.output %U_TIMERS_APBIF.timer_en, %15, %U_TIMERS_APBIF.timer_int, %U_TIMERS_APBIF.timer_int_n, %U_TIMERS_APBIF.timer_int_flag, %U_TIMERS_APBIF.timer_int_flag_n, %U_TIMERS_APBIF.tim1_etb_trig, %U_TIMERS_APBIF.tim2_etb_trig, %U_TIMERS_APBIF.prdata : i2, i2, i2, i2, i1, i1, i1, i1, i32
  }
}
