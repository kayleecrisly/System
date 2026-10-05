module {
  hw.module private @wdt_biu(in %pclk : i1, in %presetn : i1, in %psel : i1, in %paddr : i8, in %pwrite : i1, in %penable : i1, in %pwdata : i32, out prdata : i32, in %iprdata : i32, out wr_en : i1, out rd_en : i1, out reg_addr : i6, out ipwdata : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %pclk_0 = llhd.sig name "pclk" %false : i1
    %2 = llhd.prb %pclk_0 : i1
    %presetn_1 = llhd.sig name "presetn" %false : i1
    %3 = llhd.prb %presetn_1 : i1
    %prdata = llhd.sig %c0_i32 : i32
    %iprdata_2 = llhd.sig name "iprdata" %c0_i32 : i32
    %rd_en = llhd.sig %false : i1
    %4 = comb.and %psel, %penable, %pwrite : i1
    %5 = comb.xor %penable, %true : i1
    %6 = comb.xor %pwrite, %true : i1
    %7 = comb.and %psel, %5, %6 : i1
    llhd.drv %rd_en, %7 after %1 : i1
    %8 = comb.extract %paddr from 2 : (i8) -> i6
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %11 = llhd.prb %pclk_0 : i1
      %12 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %13 = llhd.prb %pclk_0 : i1
      %14 = comb.xor bin %11, %true : i1
      %15 = comb.and bin %14, %13 : i1
      %16 = llhd.prb %presetn_1 : i1
      %17 = comb.xor bin %16, %true : i1
      %18 = comb.and bin %12, %17 : i1
      %19 = comb.or bin %15, %18 : i1
      cf.cond_br %19, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %20 = llhd.prb %presetn_1 : i1
      %21 = comb.xor %20, %true : i1
      cf.cond_br %21, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %prdata, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %22 = llhd.prb %rd_en : i1
      cf.cond_br %22, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %23 = llhd.prb %iprdata_2 : i32
      llhd.drv %prdata, %23 after %0 : i32
      cf.br ^bb1
    }
    llhd.drv %pclk_0, %pclk after %1 : i1
    llhd.drv %presetn_1, %presetn after %1 : i1
    %9 = llhd.prb %prdata : i32
    llhd.drv %iprdata_2, %iprdata after %1 : i32
    %10 = llhd.prb %rd_en : i1
    hw.output %9, %4, %10, %8, %pwdata : i32, i1, i1, i6, i32
  }
  hw.module private @wdt_cnt(in %clk : i1, in %clk_en : i1, in %rst_n : i1, in %start_val : i32, in %restart : i1, in %cnt_en : i1, in %pause : i1, in %speed_up : i1, in %scan_mode : i1, out cnt : i32) {
    %c0_i24 = hw.constant 0 : i24
    %c-1_i32 = hw.constant -1 : i32
    %c0_i5 = hw.constant 0 : i5
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c8_i5 = hw.constant 8 : i5
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i32 = hw.constant 0 : i32
    %c-1_i8 = hw.constant -1 : i8
    %false = hw.constant false
    %c65535_i32 = hw.constant 65535 : i32
    %clk_0 = llhd.sig name "clk" %false : i1
    %2 = llhd.prb %clk_0 : i1
    %clk_en_1 = llhd.sig name "clk_en" %false : i1
    %rst_n_2 = llhd.sig name "rst_n" %false : i1
    %3 = llhd.prb %rst_n_2 : i1
    %start_val_3 = llhd.sig name "start_val" %c0_i32 : i32
    %restart_4 = llhd.sig name "restart" %false : i1
    %cnt_en_5 = llhd.sig name "cnt_en" %false : i1
    %pause_6 = llhd.sig name "pause" %false : i1
    %speed_up_7 = llhd.sig name "speed_up" %false : i1
    %cnt = llhd.sig %c0_i32 : i32
    %ext_rise_edge = llhd.sig %false : i1
    %extend = llhd.sig %false : i1
    %prev_cnt_en = llhd.sig %false : i1
    %int_cnt_en = llhd.sig %false : i1
    %int_start_val = llhd.sig %c0_i32 : i32
    %ext_init_ld = llhd.sig %false : i1
    %ext_restart = llhd.sig %false : i1
    %initial_load = llhd.sig %false : i1
    %rise_edge_cnt_en = llhd.sig %false : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 8 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb7, ^bb9, ^bb10, ^bb11
      %25 = llhd.prb %clk_0 : i1
      %26 = llhd.prb %rst_n_2 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %27 = llhd.prb %clk_0 : i1
      %28 = comb.xor bin %25, %true : i1
      %29 = comb.and bin %28, %27 : i1
      %30 = llhd.prb %rst_n_2 : i1
      %31 = comb.xor bin %30, %true : i1
      %32 = comb.and bin %26, %31 : i1
      %33 = comb.or bin %29, %32 : i1
      cf.cond_br %33, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %34 = llhd.prb %rst_n_2 : i1
      %35 = comb.xor %34, %true : i1
      cf.cond_br %35, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cnt, %c65535_i32 after %1 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %36 = llhd.prb %clk_en_1 : i1
      cf.cond_br %36, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %37 = llhd.prb %initial_load : i1
      cf.cond_br %37, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %38 = llhd.prb %int_start_val : i32
      llhd.drv %cnt, %38 after %1 : i32
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %39 = llhd.prb %ext_restart : i1
      %40 = llhd.prb %cnt : i32
      %41 = comb.icmp eq %40, %c0_i32 : i32
      %42 = llhd.prb %pause_6 : i1
      %43 = comb.xor %42, %true : i1
      %44 = comb.and %41, %43 : i1
      %45 = comb.or %39, %44 : i1
      cf.cond_br %45, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %46 = llhd.prb %int_start_val : i32
      llhd.drv %cnt, %46 after %1 : i32
      cf.br ^bb1
    ^bb10:  // pred: ^bb8
      %47 = llhd.prb %int_cnt_en : i1
      cf.cond_br %47, ^bb11, ^bb1
    ^bb11:  // pred: ^bb10
      %48 = llhd.prb %cnt : i32
      %49 = comb.add %48, %c-1_i32 : i32
      llhd.drv %cnt, %49 after %1 : i32
      cf.br ^bb1
    }
    %4 = llhd.sig.extract %int_start_val from %c8_i5 : <i32> -> <i24>
    %5 = llhd.prb %start_val_3 : i32
    %6 = comb.extract %5 from 8 : (i32) -> i24
    %7 = comb.mux %14, %c0_i24, %6 : i24
    llhd.drv %4, %7 after %0 : i24
    %8 = llhd.sig.extract %int_start_val from %c0_i5 : <i32> -> <i8>
    %9 = comb.extract %5 from 0 : (i32) -> i8
    %10 = comb.mux %14, %c-1_i8, %9 : i8
    llhd.drv %8, %10 after %0 : i8
    %11 = llhd.prb %cnt : i32
    %12 = comb.extract %11 from 0 : (i32) -> i1
    %13 = llhd.prb %speed_up_7 : i1
    %14 = comb.mux %scan_mode, %12, %13 {sv.namehint = "int_speed_up"} : i1
    %15 = llhd.prb %cnt_en_5 : i1
    %16 = llhd.prb %pause_6 : i1
    %17 = comb.xor %16, %true : i1
    %18 = comb.and %15, %17 : i1
    llhd.drv %int_cnt_en, %18 after %0 : i1
    %19 = llhd.prb %ext_init_ld : i1
    llhd.drv %initial_load, %19 after %0 : i1
    %20 = llhd.prb %rise_edge_cnt_en : i1
    llhd.drv %ext_init_ld, %20 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %25 = llhd.prb %clk_0 : i1
      %26 = llhd.prb %rst_n_2 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %27 = llhd.prb %clk_0 : i1
      %28 = comb.xor bin %25, %true : i1
      %29 = comb.and bin %28, %27 : i1
      %30 = llhd.prb %rst_n_2 : i1
      %31 = comb.xor bin %30, %true : i1
      %32 = comb.and bin %26, %31 : i1
      %33 = comb.or bin %29, %32 : i1
      cf.cond_br %33, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %34 = llhd.prb %rst_n_2 : i1
      %35 = comb.xor %34, %true : i1
      cf.cond_br %35, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %ext_rise_edge, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %36 = llhd.prb %rise_edge_cnt_en : i1
      %37 = llhd.prb %clk_en_1 : i1
      %38 = comb.xor %37, %true : i1
      %39 = comb.and %36, %38 : i1
      %40 = llhd.prb %ext_init_ld : i1
      %41 = comb.or %39, %40 : i1
      %42 = comb.and %37, %40 : i1
      %43 = comb.xor %42, %true : i1
      %44 = comb.and %41, %43 : i1
      llhd.drv %ext_rise_edge, %44 after %1 : i1
      cf.br ^bb1
    }
    %21 = llhd.prb %prev_cnt_en : i1
    %22 = comb.xor %21, %true : i1
    %23 = comb.and %15, %22 : i1
    llhd.drv %rise_edge_cnt_en, %23 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %25 = llhd.prb %clk_0 : i1
      %26 = llhd.prb %rst_n_2 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %27 = llhd.prb %clk_0 : i1
      %28 = comb.xor bin %25, %true : i1
      %29 = comb.and bin %28, %27 : i1
      %30 = llhd.prb %rst_n_2 : i1
      %31 = comb.xor bin %30, %true : i1
      %32 = comb.and bin %26, %31 : i1
      %33 = comb.or bin %29, %32 : i1
      cf.cond_br %33, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %34 = llhd.prb %rst_n_2 : i1
      %35 = comb.xor %34, %true : i1
      cf.cond_br %35, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %prev_cnt_en, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %36 = llhd.prb %cnt_en_5 : i1
      llhd.drv %prev_cnt_en, %36 after %1 : i1
      cf.br ^bb1
    }
    %24 = llhd.prb %restart_4 : i1
    llhd.drv %ext_restart, %24 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %25 = llhd.prb %clk_0 : i1
      %26 = llhd.prb %rst_n_2 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %27 = llhd.prb %clk_0 : i1
      %28 = comb.xor bin %25, %true : i1
      %29 = comb.and bin %28, %27 : i1
      %30 = llhd.prb %rst_n_2 : i1
      %31 = comb.xor bin %30, %true : i1
      %32 = comb.and bin %26, %31 : i1
      %33 = comb.or bin %29, %32 : i1
      cf.cond_br %33, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %34 = llhd.prb %rst_n_2 : i1
      %35 = comb.xor %34, %true : i1
      cf.cond_br %35, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %extend, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %36 = llhd.prb %restart_4 : i1
      %37 = llhd.prb %clk_en_1 : i1
      %38 = comb.xor %37, %true : i1
      %39 = comb.and %36, %38 : i1
      %40 = llhd.prb %ext_restart : i1
      %41 = comb.or %39, %40 : i1
      %42 = comb.and %37, %40 : i1
      %43 = comb.xor %42, %true : i1
      %44 = comb.and %41, %43 : i1
      llhd.drv %extend, %44 after %1 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_0, %clk after %0 : i1
    llhd.drv %clk_en_1, %clk_en after %0 : i1
    llhd.drv %rst_n_2, %rst_n after %0 : i1
    llhd.drv %start_val_3, %start_val after %0 : i32
    llhd.drv %restart_4, %restart after %0 : i1
    llhd.drv %cnt_en_5, %cnt_en after %0 : i1
    llhd.drv %pause_6, %pause after %0 : i1
    llhd.drv %speed_up_7, %speed_up after %0 : i1
    hw.output %11 : i32
  }
  hw.module private @wdt_isrc(in %pclk : i1, in %presetn : i1, in %wdt_clk_en : i1, in %top : i32, in %restart : i1, in %wdt_en : i1, in %eoi_en : i1, in %rpl : i8, in %rmod : i1, in %pause : i1, in %speed_up : i1, in %scan_mode : i1, out cnt : i32, out wdt_int : i1, out sys_rst : i1) {
    %U_WDT_CNT.cnt = hw.instance "U_WDT_CNT" @wdt_cnt(clk: %pclk: i1, clk_en: %wdt_clk_en: i1, rst_n: %presetn: i1, start_val: %top: i32, restart: %restart: i1, cnt_en: %wdt_en: i1, pause: %pause: i1, speed_up: %speed_up: i1, scan_mode: %scan_mode: i1) -> (cnt: i32)
    %U_WDT_ISRG.wdt_int, %U_WDT_ISRG.sys_rst = hw.instance "U_WDT_ISRG" @wdt_isrg(clk: %pclk: i1, rst_n: %presetn: i1, clk_en: %wdt_clk_en: i1, cnt_val: %U_WDT_CNT.cnt: i32, eoi_en: %eoi_en: i1, restart: %restart: i1, rst_pulse_len: %rpl: i8, resp_mod: %rmod: i1, pause: %pause: i1) -> (wdt_int: i1, sys_rst: i1)
    hw.output %U_WDT_CNT.cnt, %U_WDT_ISRG.wdt_int, %U_WDT_ISRG.sys_rst : i32, i1, i1
  }
  hw.module private @wdt_isrg(in %clk : i1, in %rst_n : i1, in %clk_en : i1, in %cnt_val : i32, in %eoi_en : i1, in %restart : i1, in %rst_pulse_len : i8, in %resp_mod : i1, in %pause : i1, out wdt_int : i1, out sys_rst : i1) {
    %c0_i32 = hw.constant 0 : i32
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %c1_i8 = hw.constant 1 : i8
    %c0_i8 = hw.constant 0 : i8
    %false = hw.constant false
    %true = hw.constant true
    %clk_0 = llhd.sig name "clk" %false : i1
    %2 = llhd.prb %clk_0 : i1
    %rst_n_1 = llhd.sig name "rst_n" %false : i1
    %3 = llhd.prb %rst_n_1 : i1
    %clk_en_2 = llhd.sig name "clk_en" %false : i1
    %resp_mod_3 = llhd.sig name "resp_mod" %false : i1
    %pause_4 = llhd.sig name "pause" %false : i1
    %wdt_int = llhd.sig %false : i1
    %sys_rst = llhd.sig %false : i1
    %rst_cnt = llhd.sig %c0_i8 : i8
    %extend = llhd.sig %false : i1
    %clr_int = llhd.sig %false : i1
    %ext_clr_int = llhd.sig %false : i1
    %clr_sys_rst = llhd.sig %false : i1
    %zero_cnt = llhd.sig %false : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb7, ^bb8, ^bb9, ^bb10
      %11 = llhd.prb %clk_0 : i1
      %12 = llhd.prb %rst_n_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %13 = llhd.prb %clk_0 : i1
      %14 = comb.xor bin %11, %true : i1
      %15 = comb.and bin %14, %13 : i1
      %16 = llhd.prb %rst_n_1 : i1
      %17 = comb.xor bin %16, %true : i1
      %18 = comb.and bin %12, %17 : i1
      %19 = comb.or bin %15, %18 : i1
      cf.cond_br %19, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %20 = llhd.prb %rst_n_1 : i1
      %21 = comb.xor %20, %true : i1
      cf.cond_br %21, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %wdt_int, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %22 = llhd.prb %resp_mod_3 : i1
      cf.cond_br %22, ^bb6, ^bb10
    ^bb6:  // pred: ^bb5
      %23 = llhd.prb %ext_clr_int : i1
      cf.cond_br %23, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      llhd.drv %wdt_int, %false after %1 : i1
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %24 = llhd.prb %zero_cnt : i1
      %25 = llhd.prb %clk_en_2 : i1
      %26 = llhd.prb %pause_4 : i1
      %27 = comb.xor %26, %true : i1
      %28 = comb.and %24, %25, %27 : i1
      cf.cond_br %28, ^bb9, ^bb1
    ^bb9:  // pred: ^bb8
      llhd.drv %wdt_int, %true after %1 : i1
      cf.br ^bb1
    ^bb10:  // pred: ^bb5
      llhd.drv %wdt_int, %false after %1 : i1
      cf.br ^bb1
    }
    %4 = llhd.prb %clr_int : i1
    llhd.drv %ext_clr_int, %4 after %0 : i1
    %5 = comb.or %restart, %eoi_en : i1
    llhd.drv %clr_int, %5 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %11 = llhd.prb %clk_0 : i1
      %12 = llhd.prb %rst_n_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %13 = llhd.prb %clk_0 : i1
      %14 = comb.xor bin %11, %true : i1
      %15 = comb.and bin %14, %13 : i1
      %16 = llhd.prb %rst_n_1 : i1
      %17 = comb.xor bin %16, %true : i1
      %18 = comb.and bin %12, %17 : i1
      %19 = comb.or bin %15, %18 : i1
      cf.cond_br %19, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %20 = llhd.prb %rst_n_1 : i1
      %21 = comb.xor %20, %true : i1
      cf.cond_br %21, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %extend, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %22 = llhd.prb %clr_int : i1
      %23 = llhd.prb %clk_en_2 : i1
      %24 = comb.xor %23, %true : i1
      %25 = comb.and %22, %24 : i1
      %26 = llhd.prb %ext_clr_int : i1
      %27 = comb.or %25, %26 : i1
      %28 = comb.and %23, %26 : i1
      %29 = comb.xor %28, %true : i1
      %30 = comb.and %27, %29 : i1
      llhd.drv %extend, %30 after %1 : i1
      cf.br ^bb1
    }
    %6 = comb.icmp eq %cnt_val, %c0_i32 : i32
    llhd.drv %zero_cnt, %6 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb9, ^bb10
      %11 = llhd.prb %clk_0 : i1
      %12 = llhd.prb %rst_n_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %13 = llhd.prb %clk_0 : i1
      %14 = comb.xor bin %11, %true : i1
      %15 = comb.and bin %14, %13 : i1
      %16 = llhd.prb %rst_n_1 : i1
      %17 = comb.xor bin %16, %true : i1
      %18 = comb.and bin %12, %17 : i1
      %19 = comb.or bin %15, %18 : i1
      cf.cond_br %19, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %20 = llhd.prb %rst_n_1 : i1
      %21 = comb.xor %20, %true : i1
      cf.cond_br %21, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %sys_rst, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %22 = llhd.prb %clr_sys_rst : i1
      cf.cond_br %22, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %sys_rst, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %23 = llhd.prb %zero_cnt : i1
      %24 = llhd.prb %clk_en_2 : i1
      %25 = llhd.prb %pause_4 : i1
      %26 = comb.xor %25, %true : i1
      %27 = llhd.prb %ext_clr_int : i1
      %28 = comb.xor %27, %true : i1
      %29 = comb.and %23, %24, %26, %28 : i1
      cf.cond_br %29, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %30 = llhd.prb %resp_mod_3 : i1
      cf.cond_br %30, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %31 = llhd.prb %wdt_int : i1
      llhd.drv %sys_rst, %31 after %1 : i1
      cf.br ^bb1
    ^bb10:  // pred: ^bb8
      llhd.drv %sys_rst, %true after %1 : i1
      cf.br ^bb1
    }
    %7 = llhd.prb %rst_cnt : i8
    %8 = comb.icmp uge %7, %rst_pulse_len : i8
    llhd.drv %clr_sys_rst, %8 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %11 = llhd.prb %clk_0 : i1
      %12 = llhd.prb %rst_n_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %13 = llhd.prb %clk_0 : i1
      %14 = comb.xor bin %11, %true : i1
      %15 = comb.and bin %14, %13 : i1
      %16 = llhd.prb %rst_n_1 : i1
      %17 = comb.xor bin %16, %true : i1
      %18 = comb.and bin %12, %17 : i1
      %19 = comb.or bin %15, %18 : i1
      cf.cond_br %19, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %20 = llhd.prb %rst_n_1 : i1
      %21 = comb.xor %20, %true : i1
      cf.cond_br %21, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rst_cnt, %c0_i8 after %1 : i8
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %22 = llhd.prb %sys_rst : i1
      cf.cond_br %22, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %23 = llhd.prb %rst_cnt : i8
      %24 = comb.add %23, %c1_i8 : i8
      llhd.drv %rst_cnt, %24 after %1 : i8
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      llhd.drv %rst_cnt, %c0_i8 after %1 : i8
      cf.br ^bb1
    }
    llhd.drv %clk_0, %clk after %0 : i1
    llhd.drv %rst_n_1, %rst_n after %0 : i1
    llhd.drv %clk_en_2, %clk_en after %0 : i1
    llhd.drv %resp_mod_3, %resp_mod after %0 : i1
    llhd.drv %pause_4, %pause after %0 : i1
    %9 = llhd.prb %wdt_int : i1
    %10 = llhd.prb %sys_rst : i1
    hw.output %9, %10 : i1, i1
  }
  hw.module private @wdt_regfile(in %pclk : i1, in %presetn : i1, in %clk_en : i1, in %wdt_en_external : i1, in %wr_en : i1, in %rd_en : i1, in %reg_addr : i6, in %ipwdata : i32, out iprdata : i32, in %cnt : i32, in %wdt_int : i1, out top : i32, out restart : i1, out wdt_en : i1, out eoi_en : i1, out rpl : i8, out rmod : i1) {
    %c5_i6 = hw.constant 5 : i6
    %c4_i6 = hw.constant 4 : i6
    %c3_i6 = hw.constant 3 : i6
    %c2_i6 = hw.constant 2 : i6
    %c1_i6 = hw.constant 1 : i6
    %c0_i5 = hw.constant 0 : i5
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i6 = hw.constant 0 : i6
    %c1_i8 = hw.constant 1 : i8
    %c-1_i8 = hw.constant -1 : i8
    %c-1_i3 = hw.constant -1 : i3
    %c127_i8 = hw.constant 127 : i8
    %c-2_i3 = hw.constant -2 : i3
    %c63_i8 = hw.constant 63 : i8
    %c-3_i3 = hw.constant -3 : i3
    %c31_i8 = hw.constant 31 : i8
    %c-4_i3 = hw.constant -4 : i3
    %c15_i8 = hw.constant 15 : i8
    %c3_i3 = hw.constant 3 : i3
    %c7_i8 = hw.constant 7 : i8
    %c2_i3 = hw.constant 2 : i3
    %c3_i8 = hw.constant 3 : i8
    %c1_i3 = hw.constant 1 : i3
    %c65535_i32 = hw.constant 65535 : i32
    %c2147483647_i32 = hw.constant 2147483647 : i32
    %c-1_i4 = hw.constant -1 : i4
    %c1073741823_i32 = hw.constant 1073741823 : i32
    %c-2_i4 = hw.constant -2 : i4
    %c536870911_i32 = hw.constant 536870911 : i32
    %c-3_i4 = hw.constant -3 : i4
    %c268435455_i32 = hw.constant 268435455 : i32
    %c-4_i4 = hw.constant -4 : i4
    %c134217727_i32 = hw.constant 134217727 : i32
    %c-5_i4 = hw.constant -5 : i4
    %c67108863_i32 = hw.constant 67108863 : i32
    %c-6_i4 = hw.constant -6 : i4
    %c33554431_i32 = hw.constant 33554431 : i32
    %c-7_i4 = hw.constant -7 : i4
    %c16777215_i32 = hw.constant 16777215 : i32
    %c-8_i4 = hw.constant -8 : i4
    %c8388607_i32 = hw.constant 8388607 : i32
    %c7_i4 = hw.constant 7 : i4
    %c4194303_i32 = hw.constant 4194303 : i32
    %c6_i4 = hw.constant 6 : i4
    %c2097151_i32 = hw.constant 2097151 : i32
    %c5_i4 = hw.constant 5 : i4
    %c1048575_i32 = hw.constant 1048575 : i32
    %c4_i4 = hw.constant 4 : i4
    %c524287_i32 = hw.constant 524287 : i32
    %c3_i4 = hw.constant 3 : i4
    %c262143_i32 = hw.constant 262143 : i32
    %c2_i4 = hw.constant 2 : i4
    %c131071_i32 = hw.constant 131071 : i32
    %c1_i4 = hw.constant 1 : i4
    %c118_i8 = hw.constant 118 : i8
    %c0_i4 = hw.constant 0 : i4 {sv.namehint = "dflt_top_bus"}
    %c0_i8 = hw.constant 0 : i8
    %false = hw.constant false
    %c0_i3 = hw.constant 0 : i3
    %true = hw.constant true
    %c0_i32 = hw.constant 0 : i32
    %pclk_0 = llhd.sig name "pclk" %false : i1
    %2 = llhd.prb %pclk_0 : i1
    %presetn_1 = llhd.sig name "presetn" %false : i1
    %3 = llhd.prb %presetn_1 : i1
    %clk_en_2 = llhd.sig name "clk_en" %false : i1
    %wdt_en_external_3 = llhd.sig name "wdt_en_external" %false : i1
    %ipwdata_4 = llhd.sig name "ipwdata" %c0_i32 : i32
    %iprdata = llhd.sig %c0_i32 : i32
    %cnt_5 = llhd.sig name "cnt" %c0_i32 : i32
    %wdt_int_6 = llhd.sig name "wdt_int" %false : i1
    %wdt_en = llhd.sig %false : i1
    %rpl = llhd.sig %c0_i8 : i8
    %wdt_cr_en = llhd.sig %false : i1
    %wdt_torr_en = llhd.sig %false : i1
    %wdt_ccvr_en = llhd.sig %false : i1
    %wdt_stat_en = llhd.sig %false : i1
    %wdt_cr_we = llhd.sig %false : i1
    %wdt_torr_we = llhd.sig %false : i1
    %wdt_cr_ir = llhd.sig %c0_i6 : i6
    %wdt_cr = llhd.sig %c0_i6 : i6
    %wdt_torr_ir = llhd.sig %c0_i8 : i8
    %wdt_torr = llhd.sig %c0_i8 : i8
    %wdt_ccvr = llhd.sig %c0_i32 : i32
    %dflt_rpl = llhd.sig %c0_i3 : i3
    %dflt_rmod = llhd.sig %false : i1
    %dflt_wdt_en = llhd.sig %false : i1
    %dflt_top_init = llhd.sig %c0_i4 : i4
    %int_cnt = llhd.sig %c0_i32 : i32
    %wdt_eoi_rd = llhd.sig %false : i1
    %prev_wdt_eoi_rd = llhd.sig %false : i1
    %int_top = llhd.sig %c0_i32 : i32
    %int_top_init = llhd.sig %c0_i32 : i32
    %been_started = llhd.sig %false : i1
    %been_enabled = llhd.sig %false : i1
    %4 = comb.icmp eq %reg_addr, %c0_i6 : i6
    llhd.drv %wdt_cr_en, %4 after %1 : i1
    %5 = comb.icmp eq %reg_addr, %c1_i6 : i6
    llhd.drv %wdt_torr_en, %5 after %1 : i1
    %6 = comb.icmp eq %reg_addr, %c2_i6 : i6
    llhd.drv %wdt_ccvr_en, %6 after %1 : i1
    %7 = comb.icmp eq %reg_addr, %c3_i6 : i6
    %8 = comb.icmp eq %reg_addr, %c4_i6 : i6
    llhd.drv %wdt_stat_en, %8 after %1 : i1
    %9 = comb.icmp eq %reg_addr, %c5_i6 : i6
    %10 = llhd.prb %wdt_cr_en : i1
    %11 = comb.and %10, %wr_en : i1
    llhd.drv %wdt_cr_we, %11 after %1 : i1
    %12 = llhd.prb %wdt_torr_en : i1
    %13 = comb.and %12, %wr_en : i1
    llhd.drv %wdt_torr_we, %13 after %1 : i1
    llhd.drv %dflt_rpl, %c0_i3 after %1 : i3
    llhd.drv %dflt_rmod, %false after %1 : i1
    llhd.drv %dflt_wdt_en, %false after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %49 = llhd.prb %pclk_0 : i1
      %50 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %51 = llhd.prb %pclk_0 : i1
      %52 = comb.xor bin %49, %true : i1
      %53 = comb.and bin %52, %51 : i1
      %54 = llhd.prb %presetn_1 : i1
      %55 = comb.xor bin %54, %true : i1
      %56 = comb.and bin %50, %55 : i1
      %57 = comb.or bin %53, %56 : i1
      cf.cond_br %57, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %58 = llhd.prb %presetn_1 : i1
      %59 = comb.xor %58, %true : i1
      cf.cond_br %59, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %60 = llhd.prb %dflt_rpl : i3
      %61 = llhd.prb %dflt_rmod : i1
      %62 = llhd.prb %dflt_wdt_en : i1
      %63 = comb.concat %false, %60, %61, %62 : i1, i3, i1, i1
      llhd.drv %wdt_cr_ir, %63 after %0 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %64 = llhd.prb %wdt_cr_we : i1
      cf.cond_br %64, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %65 = llhd.sig.extract %wdt_cr_ir from %c1_i3 : <i6> -> <i5>
      %66 = llhd.prb %ipwdata_4 : i32
      %67 = comb.extract %66 from 1 : (i32) -> i5
      llhd.drv %65, %67 after %0 : i5
      %68 = llhd.sig.extract %wdt_cr_ir from %c0_i3 : <i6> -> <i1>
      %69 = llhd.prb %ipwdata_4 : i32
      %70 = comb.extract %69 from 0 : (i32) -> i1
      llhd.drv %68, %70 after %0 : i1
      cf.br ^bb1
    }
    %14 = llhd.sig.extract %wdt_cr from %c-3_i3 : <i6> -> <i1>
    %15 = llhd.prb %wdt_cr_ir : i6
    %16 = comb.extract %15 from 5 : (i6) -> i1
    llhd.drv %14, %16 after %1 : i1
    %17 = llhd.sig.extract %wdt_cr from %c2_i3 : <i6> -> <i3>
    %18 = comb.extract %15 from 2 : (i6) -> i3
    llhd.drv %17, %18 after %1 : i3
    %19 = llhd.sig.extract %wdt_cr from %c1_i3 : <i6> -> <i1>
    %20 = comb.extract %15 from 1 : (i6) -> i1
    llhd.drv %19, %20 after %1 : i1
    %21 = llhd.sig.extract %wdt_cr from %c0_i3 : <i6> -> <i1>
    %22 = comb.extract %15 from 0 : (i6) -> i1
    llhd.drv %21, %22 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %49 = llhd.prb %pclk_0 : i1
      %50 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %51 = llhd.prb %pclk_0 : i1
      %52 = comb.xor bin %49, %true : i1
      %53 = comb.and bin %52, %51 : i1
      %54 = llhd.prb %presetn_1 : i1
      %55 = comb.xor bin %54, %true : i1
      %56 = comb.and bin %50, %55 : i1
      %57 = comb.or bin %53, %56 : i1
      cf.cond_br %57, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %58 = llhd.prb %presetn_1 : i1
      %59 = comb.xor %58, %true : i1
      cf.cond_br %59, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %wdt_torr_ir, %c0_i8 after %0 : i8
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %60 = llhd.prb %wdt_torr_we : i1
      cf.cond_br %60, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %61 = llhd.prb %ipwdata_4 : i32
      %62 = comb.extract %61 from 0 : (i32) -> i8
      llhd.drv %wdt_torr_ir, %62 after %0 : i8
      cf.br ^bb1
    }
    llhd.drv %dflt_top_init, %c0_i4 after %1 : i4
    %23 = llhd.prb %wdt_torr_ir : i8
    llhd.drv %wdt_torr, %23 after %1 : i8
    %24 = llhd.prb %ipwdata_4 : i32
    %25 = comb.extract %24 from 0 : (i32) -> i8
    %26 = comb.icmp eq %25, %c118_i8 : i8
    %27 = comb.and %7, %wr_en, %26 : i1
    %28 = llhd.prb %int_cnt : i32
    %29 = llhd.prb %cnt_5 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %int_cnt, %c0_i32 after %1 : i32
      %49 = llhd.prb %cnt_5 : i32
      llhd.drv %int_cnt, %49 after %1 : i32
      llhd.wait (%28, %29 : i32, i32), ^bb1
    }
    llhd.drv %wdt_ccvr, %28 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %49 = llhd.prb %pclk_0 : i1
      %50 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %51 = llhd.prb %pclk_0 : i1
      %52 = comb.xor bin %49, %true : i1
      %53 = comb.and bin %52, %51 : i1
      %54 = llhd.prb %presetn_1 : i1
      %55 = comb.xor bin %54, %true : i1
      %56 = comb.and bin %50, %55 : i1
      %57 = comb.or bin %53, %56 : i1
      cf.cond_br %57, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %58 = llhd.prb %presetn_1 : i1
      %59 = comb.xor %58, %true : i1
      cf.cond_br %59, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %prev_wdt_eoi_rd, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %60 = llhd.prb %wdt_eoi_rd : i1
      llhd.drv %prev_wdt_eoi_rd, %60 after %0 : i1
      cf.br ^bb1
    }
    %30 = comb.and %9, %rd_en : i1
    llhd.drv %wdt_eoi_rd, %30 after %1 : i1
    %31 = llhd.prb %wdt_eoi_rd : i1
    %32 = llhd.prb %prev_wdt_eoi_rd : i1
    %33 = comb.xor %32, %true : i1
    %34 = comb.and %31, %33 : i1
    %35 = llhd.prb %iprdata : i32
    %36 = llhd.prb %wdt_cr : i6
    %37 = llhd.prb %wdt_torr : i8
    %38 = llhd.prb %wdt_ccvr_en : i1
    %39 = llhd.prb %wdt_ccvr : i32
    %40 = llhd.prb %wdt_stat_en : i1
    %41 = llhd.prb %wdt_int_6 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb9
      llhd.drv %iprdata, %c0_i32 after %1 : i32
      %49 = llhd.prb %wdt_cr_en : i1
      cf.cond_br %49, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %50 = llhd.sig.extract %iprdata from %c0_i5 : <i32> -> <i6>
      %51 = llhd.prb %wdt_cr : i6
      llhd.drv %50, %51 after %1 : i6
      cf.br ^bb9
    ^bb3:  // pred: ^bb1
      %52 = llhd.prb %wdt_torr_en : i1
      cf.cond_br %52, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %53 = llhd.sig.extract %iprdata from %c0_i5 : <i32> -> <i8>
      %54 = llhd.prb %wdt_torr : i8
      llhd.drv %53, %54 after %1 : i8
      cf.br ^bb9
    ^bb5:  // pred: ^bb3
      %55 = llhd.prb %wdt_ccvr_en : i1
      cf.cond_br %55, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %56 = llhd.prb %wdt_ccvr : i32
      llhd.drv %iprdata, %56 after %1 : i32
      cf.br ^bb9
    ^bb7:  // pred: ^bb5
      %57 = llhd.prb %wdt_stat_en : i1
      cf.cond_br %57, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %58 = llhd.sig.extract %iprdata from %c0_i5 : <i32> -> <i1>
      %59 = llhd.prb %wdt_int_6 : i1
      llhd.drv %58, %59 after %1 : i1
      cf.br ^bb9
    ^bb9:  // 5 preds: ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      llhd.wait (%35, %10, %36, %12, %37, %38, %39, %40, %41 : i32, i1, i6, i1, i8, i1, i32, i1, i1), ^bb1
    }
    %42 = llhd.prb %int_top : i32
    %43 = llhd.prb %int_top_init : i32
    %44 = comb.mux %45, %42, %43 : i32
    %45 = llhd.prb %been_started : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %49 = llhd.prb %pclk_0 : i1
      %50 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %51 = llhd.prb %pclk_0 : i1
      %52 = comb.xor bin %49, %true : i1
      %53 = comb.and bin %52, %51 : i1
      %54 = llhd.prb %presetn_1 : i1
      %55 = comb.xor bin %54, %true : i1
      %56 = comb.and bin %50, %55 : i1
      %57 = comb.or bin %53, %56 : i1
      cf.cond_br %57, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %58 = llhd.prb %presetn_1 : i1
      %59 = comb.xor %58, %true : i1
      cf.cond_br %59, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %been_started, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %60 = llhd.prb %clk_en_2 : i1
      cf.cond_br %60, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %61 = llhd.prb %been_enabled : i1
      llhd.drv %been_started, %61 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %49 = llhd.prb %pclk_0 : i1
      %50 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %51 = llhd.prb %pclk_0 : i1
      %52 = comb.xor bin %49, %true : i1
      %53 = comb.and bin %52, %51 : i1
      %54 = llhd.prb %presetn_1 : i1
      %55 = comb.xor bin %54, %true : i1
      %56 = comb.and bin %50, %55 : i1
      %57 = comb.or bin %53, %56 : i1
      cf.cond_br %57, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %58 = llhd.prb %presetn_1 : i1
      %59 = comb.xor %58, %true : i1
      cf.cond_br %59, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %been_enabled, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %60 = llhd.prb %wdt_en : i1
      cf.cond_br %60, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %been_enabled, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb32
      %49 = llhd.prb %wdt_torr : i8
      %50 = comb.extract %49 from 4 : (i8) -> i4
      %51 = comb.icmp ceq %50, %c1_i4 : i4
      cf.cond_br %51, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %int_top_init, %c131071_i32 after %1 : i32
      cf.br ^bb32
    ^bb3:  // pred: ^bb1
      %52 = comb.icmp ceq %50, %c2_i4 : i4
      cf.cond_br %52, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_top_init, %c262143_i32 after %1 : i32
      cf.br ^bb32
    ^bb5:  // pred: ^bb3
      %53 = comb.icmp ceq %50, %c3_i4 : i4
      cf.cond_br %53, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %int_top_init, %c524287_i32 after %1 : i32
      cf.br ^bb32
    ^bb7:  // pred: ^bb5
      %54 = comb.icmp ceq %50, %c4_i4 : i4
      cf.cond_br %54, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %int_top_init, %c1048575_i32 after %1 : i32
      cf.br ^bb32
    ^bb9:  // pred: ^bb7
      %55 = comb.icmp ceq %50, %c5_i4 : i4
      cf.cond_br %55, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      llhd.drv %int_top_init, %c2097151_i32 after %1 : i32
      cf.br ^bb32
    ^bb11:  // pred: ^bb9
      %56 = comb.icmp ceq %50, %c6_i4 : i4
      cf.cond_br %56, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      llhd.drv %int_top_init, %c4194303_i32 after %1 : i32
      cf.br ^bb32
    ^bb13:  // pred: ^bb11
      %57 = comb.icmp ceq %50, %c7_i4 : i4
      cf.cond_br %57, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      llhd.drv %int_top_init, %c8388607_i32 after %1 : i32
      cf.br ^bb32
    ^bb15:  // pred: ^bb13
      %58 = comb.icmp ceq %50, %c-8_i4 : i4
      cf.cond_br %58, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      llhd.drv %int_top_init, %c16777215_i32 after %1 : i32
      cf.br ^bb32
    ^bb17:  // pred: ^bb15
      %59 = comb.icmp ceq %50, %c-7_i4 : i4
      cf.cond_br %59, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      llhd.drv %int_top_init, %c33554431_i32 after %1 : i32
      cf.br ^bb32
    ^bb19:  // pred: ^bb17
      %60 = comb.icmp ceq %50, %c-6_i4 : i4
      cf.cond_br %60, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      llhd.drv %int_top_init, %c67108863_i32 after %1 : i32
      cf.br ^bb32
    ^bb21:  // pred: ^bb19
      %61 = comb.icmp ceq %50, %c-5_i4 : i4
      cf.cond_br %61, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      llhd.drv %int_top_init, %c134217727_i32 after %1 : i32
      cf.br ^bb32
    ^bb23:  // pred: ^bb21
      %62 = comb.icmp ceq %50, %c-4_i4 : i4
      cf.cond_br %62, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      llhd.drv %int_top_init, %c268435455_i32 after %1 : i32
      cf.br ^bb32
    ^bb25:  // pred: ^bb23
      %63 = comb.icmp ceq %50, %c-3_i4 : i4
      cf.cond_br %63, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      llhd.drv %int_top_init, %c536870911_i32 after %1 : i32
      cf.br ^bb32
    ^bb27:  // pred: ^bb25
      %64 = comb.icmp ceq %50, %c-2_i4 : i4
      cf.cond_br %64, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      llhd.drv %int_top_init, %c1073741823_i32 after %1 : i32
      cf.br ^bb32
    ^bb29:  // pred: ^bb27
      %65 = comb.icmp ceq %50, %c-1_i4 : i4
      cf.cond_br %65, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      llhd.drv %int_top_init, %c2147483647_i32 after %1 : i32
      cf.br ^bb32
    ^bb31:  // pred: ^bb29
      llhd.drv %int_top_init, %c65535_i32 after %1 : i32
      cf.br ^bb32
    ^bb32:  // 16 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb22, ^bb24, ^bb26, ^bb28, ^bb30, ^bb31
      llhd.wait (%false, %37, %43 : i1, i8, i32), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb32
      %49 = llhd.prb %wdt_torr : i8
      %50 = comb.extract %49 from 0 : (i8) -> i4
      %51 = comb.icmp ceq %50, %c1_i4 : i4
      cf.cond_br %51, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %int_top, %c131071_i32 after %1 : i32
      cf.br ^bb32
    ^bb3:  // pred: ^bb1
      %52 = comb.icmp ceq %50, %c2_i4 : i4
      cf.cond_br %52, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %int_top, %c262143_i32 after %1 : i32
      cf.br ^bb32
    ^bb5:  // pred: ^bb3
      %53 = comb.icmp ceq %50, %c3_i4 : i4
      cf.cond_br %53, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %int_top, %c524287_i32 after %1 : i32
      cf.br ^bb32
    ^bb7:  // pred: ^bb5
      %54 = comb.icmp ceq %50, %c4_i4 : i4
      cf.cond_br %54, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %int_top, %c1048575_i32 after %1 : i32
      cf.br ^bb32
    ^bb9:  // pred: ^bb7
      %55 = comb.icmp ceq %50, %c5_i4 : i4
      cf.cond_br %55, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      llhd.drv %int_top, %c2097151_i32 after %1 : i32
      cf.br ^bb32
    ^bb11:  // pred: ^bb9
      %56 = comb.icmp ceq %50, %c6_i4 : i4
      cf.cond_br %56, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      llhd.drv %int_top, %c4194303_i32 after %1 : i32
      cf.br ^bb32
    ^bb13:  // pred: ^bb11
      %57 = comb.icmp ceq %50, %c7_i4 : i4
      cf.cond_br %57, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      llhd.drv %int_top, %c8388607_i32 after %1 : i32
      cf.br ^bb32
    ^bb15:  // pred: ^bb13
      %58 = comb.icmp ceq %50, %c-8_i4 : i4
      cf.cond_br %58, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      llhd.drv %int_top, %c16777215_i32 after %1 : i32
      cf.br ^bb32
    ^bb17:  // pred: ^bb15
      %59 = comb.icmp ceq %50, %c-7_i4 : i4
      cf.cond_br %59, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      llhd.drv %int_top, %c33554431_i32 after %1 : i32
      cf.br ^bb32
    ^bb19:  // pred: ^bb17
      %60 = comb.icmp ceq %50, %c-6_i4 : i4
      cf.cond_br %60, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      llhd.drv %int_top, %c67108863_i32 after %1 : i32
      cf.br ^bb32
    ^bb21:  // pred: ^bb19
      %61 = comb.icmp ceq %50, %c-5_i4 : i4
      cf.cond_br %61, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      llhd.drv %int_top, %c134217727_i32 after %1 : i32
      cf.br ^bb32
    ^bb23:  // pred: ^bb21
      %62 = comb.icmp ceq %50, %c-4_i4 : i4
      cf.cond_br %62, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      llhd.drv %int_top, %c268435455_i32 after %1 : i32
      cf.br ^bb32
    ^bb25:  // pred: ^bb23
      %63 = comb.icmp ceq %50, %c-3_i4 : i4
      cf.cond_br %63, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      llhd.drv %int_top, %c536870911_i32 after %1 : i32
      cf.br ^bb32
    ^bb27:  // pred: ^bb25
      %64 = comb.icmp ceq %50, %c-2_i4 : i4
      cf.cond_br %64, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      llhd.drv %int_top, %c1073741823_i32 after %1 : i32
      cf.br ^bb32
    ^bb29:  // pred: ^bb27
      %65 = comb.icmp ceq %50, %c-1_i4 : i4
      cf.cond_br %65, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      llhd.drv %int_top, %c2147483647_i32 after %1 : i32
      cf.br ^bb32
    ^bb31:  // pred: ^bb29
      llhd.drv %int_top, %c65535_i32 after %1 : i32
      cf.br ^bb32
    ^bb32:  // 16 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb22, ^bb24, ^bb26, ^bb28, ^bb30, ^bb31
      llhd.wait (%false, %37, %42 : i1, i8, i32), ^bb1
    }
    %46 = llhd.prb %rpl : i8
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb16
      %49 = llhd.prb %wdt_cr : i6
      %50 = comb.extract %49 from 2 : (i6) -> i3
      %51 = comb.icmp ceq %50, %c1_i3 : i3
      cf.cond_br %51, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %rpl, %c3_i8 after %1 : i8
      cf.br ^bb16
    ^bb3:  // pred: ^bb1
      %52 = comb.icmp ceq %50, %c2_i3 : i3
      cf.cond_br %52, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rpl, %c7_i8 after %1 : i8
      cf.br ^bb16
    ^bb5:  // pred: ^bb3
      %53 = comb.icmp ceq %50, %c3_i3 : i3
      cf.cond_br %53, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %rpl, %c15_i8 after %1 : i8
      cf.br ^bb16
    ^bb7:  // pred: ^bb5
      %54 = comb.icmp ceq %50, %c-4_i3 : i3
      cf.cond_br %54, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %rpl, %c31_i8 after %1 : i8
      cf.br ^bb16
    ^bb9:  // pred: ^bb7
      %55 = comb.icmp ceq %50, %c-3_i3 : i3
      cf.cond_br %55, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      llhd.drv %rpl, %c63_i8 after %1 : i8
      cf.br ^bb16
    ^bb11:  // pred: ^bb9
      %56 = comb.icmp ceq %50, %c-2_i3 : i3
      cf.cond_br %56, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      llhd.drv %rpl, %c127_i8 after %1 : i8
      cf.br ^bb16
    ^bb13:  // pred: ^bb11
      %57 = comb.icmp ceq %50, %c-1_i3 : i3
      cf.cond_br %57, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      llhd.drv %rpl, %c-1_i8 after %1 : i8
      cf.br ^bb16
    ^bb15:  // pred: ^bb13
      llhd.drv %rpl, %c1_i8 after %1 : i8
      cf.br ^bb16
    ^bb16:  // 8 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb15
      llhd.wait (%36, %46 : i6, i8), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9
      %49 = llhd.prb %pclk_0 : i1
      %50 = llhd.prb %presetn_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %51 = llhd.prb %pclk_0 : i1
      %52 = comb.xor bin %49, %true : i1
      %53 = comb.and bin %52, %51 : i1
      %54 = llhd.prb %presetn_1 : i1
      %55 = comb.xor bin %54, %true : i1
      %56 = comb.and bin %50, %55 : i1
      %57 = comb.or bin %53, %56 : i1
      cf.cond_br %57, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %58 = llhd.prb %presetn_1 : i1
      %59 = comb.xor %58, %true : i1
      cf.cond_br %59, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %wdt_en, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %60 = llhd.prb %wdt_cr : i6
      %61 = comb.extract %60 from 0 : (i6) -> i1
      cf.cond_br %61, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %wdt_en, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %62 = llhd.prb %wdt_en_external_3 : i1
      cf.cond_br %62, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %wdt_en, %true after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      llhd.drv %wdt_en, %false after %0 : i1
      cf.br ^bb1
    }
    %47 = comb.extract %36 from 1 : (i6) -> i1
    llhd.drv %pclk_0, %pclk after %1 : i1
    llhd.drv %presetn_1, %presetn after %1 : i1
    llhd.drv %clk_en_2, %clk_en after %1 : i1
    llhd.drv %wdt_en_external_3, %wdt_en_external after %1 : i1
    llhd.drv %ipwdata_4, %ipwdata after %1 : i32
    llhd.drv %cnt_5, %cnt after %1 : i32
    llhd.drv %wdt_int_6, %wdt_int after %1 : i1
    %48 = llhd.prb %wdt_en : i1
    hw.output %35, %44, %27, %48, %34, %46, %47 : i32, i32, i1, i1, i1, i8, i1
  }
  hw.module @wdt_sec_top(out intr : i1, in %paddr : i32, in %pclk : i1, in %penable : i1, in %pprot : i3, out prdata : i32, in %prst_b : i1, in %psel : i1, in %pwdata : i32, in %pwrite : i1, in %scan_mode : i1, out sys_rst_b : i1, in %tipc_wdt_trust : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %c0_i8 = hw.constant 0 : i8
    %i_paddr = llhd.sig %c0_i8 : i8
    %prdata = llhd.sig %c0_i32 : i32
    %1 = llhd.prb %i_paddr : i8
    %x_wdt.wdt_int, %x_wdt.wdt_int_n, %x_wdt.wdt_sys_rst, %x_wdt.wdt_sys_rst_n, %x_wdt.prdata = hw.instance "x_wdt" @wdt(pclk: %pclk: i1, presetn: %prst_b: i1, penable: %penable: i1, pwrite: %pwrite: i1, pwdata: %pwdata: i32, paddr: %1: i8, psel: %psel: i1, speed_up: %false: i1, scan_mode: %scan_mode: i1, wdt_en_external: %false: i1) -> (wdt_int: i1, wdt_int_n: i1, wdt_sys_rst: i1, wdt_sys_rst_n: i1, prdata: i32) {sv.namehint = "i_prdata"}
    %2 = comb.extract %paddr from 0 : (i32) -> i8
    llhd.drv %i_paddr, %2 after %0 : i8
    llhd.drv %prdata, %x_wdt.prdata after %0 : i32
    %3 = llhd.prb %prdata : i32
    hw.output %x_wdt.wdt_int, %3, %x_wdt.wdt_sys_rst_n : i1, i32, i1
  }
  hw.module private @wdt(in %pclk : i1, in %presetn : i1, in %penable : i1, in %pwrite : i1, in %pwdata : i32, in %paddr : i8, in %psel : i1, in %speed_up : i1, in %scan_mode : i1, in %wdt_en_external : i1, out wdt_int : i1, out wdt_int_n : i1, out wdt_sys_rst : i1, out wdt_sys_rst_n : i1, out prdata : i32) {
    %false = hw.constant false
    %true = hw.constant true
    %U_WDT_BIU.prdata, %U_WDT_BIU.wr_en, %U_WDT_BIU.rd_en, %U_WDT_BIU.reg_addr, %U_WDT_BIU.ipwdata = hw.instance "U_WDT_BIU" @wdt_biu(pclk: %pclk: i1, presetn: %presetn: i1, psel: %psel: i1, paddr: %paddr: i8, pwrite: %pwrite: i1, penable: %penable: i1, pwdata: %pwdata: i32, iprdata: %U_WDT_REGFILE.iprdata: i32) -> (prdata: i32, wr_en: i1, rd_en: i1, reg_addr: i6, ipwdata: i32) {sv.namehint = "ipwdata"}
    %U_WDT_REGFILE.iprdata, %U_WDT_REGFILE.top, %U_WDT_REGFILE.restart, %U_WDT_REGFILE.wdt_en, %U_WDT_REGFILE.eoi_en, %U_WDT_REGFILE.rpl, %U_WDT_REGFILE.rmod = hw.instance "U_WDT_REGFILE" @wdt_regfile(pclk: %pclk: i1, presetn: %presetn: i1, clk_en: %true: i1, wdt_en_external: %wdt_en_external: i1, wr_en: %U_WDT_BIU.wr_en: i1, rd_en: %U_WDT_BIU.rd_en: i1, reg_addr: %U_WDT_BIU.reg_addr: i6, ipwdata: %U_WDT_BIU.ipwdata: i32, cnt: %U_WDT_ISRC.cnt: i32, wdt_int: %U_WDT_ISRC.wdt_int: i1) -> (iprdata: i32, top: i32, restart: i1, wdt_en: i1, eoi_en: i1, rpl: i8, rmod: i1) {sv.namehint = "rpl"}
    %U_WDT_ISRC.cnt, %U_WDT_ISRC.wdt_int, %U_WDT_ISRC.sys_rst = hw.instance "U_WDT_ISRC" @wdt_isrc(pclk: %pclk: i1, presetn: %presetn: i1, wdt_clk_en: %true: i1, top: %U_WDT_REGFILE.top: i32, restart: %U_WDT_REGFILE.restart: i1, wdt_en: %U_WDT_REGFILE.wdt_en: i1, eoi_en: %U_WDT_REGFILE.eoi_en: i1, rpl: %U_WDT_REGFILE.rpl: i8, rmod: %U_WDT_REGFILE.rmod: i1, pause: %false: i1, speed_up: %speed_up: i1, scan_mode: %scan_mode: i1) -> (cnt: i32, wdt_int: i1, sys_rst: i1) {sv.namehint = "cnt"}
    %0 = comb.xor %U_WDT_ISRC.wdt_int, %true : i1
    %1 = comb.xor %U_WDT_ISRC.sys_rst, %true : i1
    hw.output %U_WDT_ISRC.wdt_int, %0, %U_WDT_ISRC.sys_rst, %1, %U_WDT_BIU.prdata : i1, i1, i1, i1, i32
  }
}
