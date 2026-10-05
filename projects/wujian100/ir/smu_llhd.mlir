module {
  hw.module private @fpga_byte_spram(in %A : i14, in %CEN : i1, in %CLK : i1, in %D : i8, out Q : i8, in %WEN : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i131072 = hw.constant 0 : i131072
    %c0_i8 = hw.constant 0 : i8
    %false = hw.constant false
    %c0_i14 = hw.constant 0 : i14
    %A_0 = llhd.sig name "A" %c0_i14 : i14
    %CEN_1 = llhd.sig name "CEN" %false : i1
    %CLK_2 = llhd.sig name "CLK" %false : i1
    %2 = llhd.prb %CLK_2 : i1
    %D_3 = llhd.sig name "D" %c0_i8 : i8
    %WEN_4 = llhd.sig name "WEN" %false : i1
    %Q = llhd.sig %c0_i8 : i8
    %3 = hw.bitcast %c0_i131072 : (i131072) -> !hw.array<16384xi8>
    %mem = llhd.sig %3 : !hw.array<16384xi8>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb3, ^bb5, ^bb6
      %5 = llhd.prb %CLK_2 : i1
      llhd.wait (%2 : i1), ^bb2
    ^bb2:  // pred: ^bb1
      %6 = llhd.prb %CLK_2 : i1
      %7 = comb.xor bin %5, %true : i1
      %8 = comb.and bin %7, %6 : i1
      cf.cond_br %8, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %9 = llhd.prb %CEN_1 : i1
      %10 = comb.xor %9, %true : i1
      cf.cond_br %10, ^bb4, ^bb1
    ^bb4:  // pred: ^bb3
      %11 = llhd.prb %WEN_4 : i1
      %12 = comb.xor %11, %true : i1
      cf.cond_br %12, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %13 = llhd.prb %A_0 : i14
      %14 = llhd.sig.array_get %mem[%13] : <!hw.array<16384xi8>>
      %15 = llhd.prb %D_3 : i8
      llhd.drv %14, %15 after %1 : i8
      %16 = llhd.prb %D_3 : i8
      llhd.drv %Q, %16 after %1 : i8
      cf.br ^bb1
    ^bb6:  // pred: ^bb4
      %17 = llhd.prb %mem : !hw.array<16384xi8>
      %18 = llhd.prb %A_0 : i14
      %19 = hw.array_get %17[%18] : !hw.array<16384xi8>, i14
      llhd.drv %Q, %19 after %1 : i8
      cf.br ^bb1
    }
    llhd.drv %A_0, %A after %0 : i14
    llhd.drv %CEN_1, %CEN after %0 : i1
    llhd.drv %CLK_2, %CLK after %0 : i1
    llhd.drv %D_3, %D after %0 : i8
    %4 = llhd.prb %Q : i8
    llhd.drv %WEN_4, %WEN after %0 : i1
    hw.output %4 : i8
  }
  hw.module private @fpga_spram(in %A : i14, in %CEN : i1, in %CLK : i1, in %D : i32, out Q : i32, in %BWEN : i4) {
    %c-8_i5 = hw.constant -8 : i5
    %c-16_i5 = hw.constant -16 : i5
    %c8_i5 = hw.constant 8 : i5
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i5 = hw.constant 0 : i5
    %c0_i32 = hw.constant 0 : i32
    %Q = llhd.sig %c0_i32 : i32
    %1 = comb.extract %D from 0 : (i32) -> i8
    %2 = llhd.sig.extract %Q from %c0_i5 : <i32> -> <i8>
    %3 = comb.extract %BWEN from 0 : (i4) -> i1
    %x_fpga_byte0_spram.Q = hw.instance "x_fpga_byte0_spram" @fpga_byte_spram(A: %A: i14, CEN: %CEN: i1, CLK: %CLK: i1, D: %1: i8, WEN: %3: i1) -> (Q: i8)
    llhd.drv %2, %x_fpga_byte0_spram.Q after %0 : i8
    %4 = comb.extract %D from 8 : (i32) -> i8
    %5 = llhd.sig.extract %Q from %c8_i5 : <i32> -> <i8>
    %6 = comb.extract %BWEN from 1 : (i4) -> i1
    %x_fpga_byte1_spram.Q = hw.instance "x_fpga_byte1_spram" @fpga_byte_spram(A: %A: i14, CEN: %CEN: i1, CLK: %CLK: i1, D: %4: i8, WEN: %6: i1) -> (Q: i8)
    llhd.drv %5, %x_fpga_byte1_spram.Q after %0 : i8
    %7 = comb.extract %D from 16 : (i32) -> i8
    %8 = llhd.sig.extract %Q from %c-16_i5 : <i32> -> <i8>
    %9 = comb.extract %BWEN from 2 : (i4) -> i1
    %x_fpga_byte2_spram.Q = hw.instance "x_fpga_byte2_spram" @fpga_byte_spram(A: %A: i14, CEN: %CEN: i1, CLK: %CLK: i1, D: %7: i8, WEN: %9: i1) -> (Q: i8)
    llhd.drv %8, %x_fpga_byte2_spram.Q after %0 : i8
    %10 = comb.extract %D from 24 : (i32) -> i8
    %11 = llhd.sig.extract %Q from %c-8_i5 : <i32> -> <i8>
    %12 = comb.extract %BWEN from 3 : (i4) -> i1
    %x_fpga_byte3_spram.Q = hw.instance "x_fpga_byte3_spram" @fpga_byte_spram(A: %A: i14, CEN: %CEN: i1, CLK: %CLK: i1, D: %10: i8, WEN: %12: i1) -> (Q: i8)
    llhd.drv %11, %x_fpga_byte3_spram.Q after %0 : i8
    %13 = llhd.prb %Q : i32
    hw.output %13 : i32
  }
  hw.module private @sms_bank_64k_top(in %big_endian_b : i1, in %mem_haddr : i32, in %mem_hclk : i1, in %mem_hprot : i4, out mem_hrdata : i32, in %mem_hready : i1, out mem_hready_resp : i1, out mem_hresp : i2, in %mem_hrst_b : i1, in %mem_hsel : i1, in %mem_hsize : i3, in %mem_htrans : i2, in %mem_hwdata : i32, in %mem_hwrite : i1, in %region_rd_deny_flag : i1, in %region_wr_deny_flag : i1, out sms_idle0 : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %c-8_i4 = hw.constant -8 : i4
    %c1_i2 = hw.constant 1 : i2
    %true = hw.constant true
    %c0_i2 = hw.constant 0 : i2
    %false = hw.constant false
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %rd_deny_resp = llhd.sig %false : i1
    %rd_deny_resp_2_cycle = llhd.sig %false : i1
    %wr_deny_resp = llhd.sig %false : i1
    %wr_deny_resp_2_cycle = llhd.sig %false : i1
    %a_act_burst = llhd.sig %false : i1
    %deny_hready_resp = llhd.sig %false : i1
    %deny_hresp = llhd.sig %c0_i2 : i2
    %mem_hclk_0 = llhd.sig name "mem_hclk" %false : i1
    %2 = llhd.prb %mem_hclk_0 : i1
    %mem_hresp = llhd.sig %c0_i2 : i2
    %mem_hrst_b_1 = llhd.sig name "mem_hrst_b" %false : i1
    %3 = llhd.prb %mem_hrst_b_1 : i1
    %mem_hsel_2 = llhd.sig name "mem_hsel" %false : i1
    %mem_htrans_3 = llhd.sig name "mem_htrans" %c0_i2 : i2
    %mem_htrans_deny = llhd.sig %c0_i2 : i2
    %mem_hwrite_4 = llhd.sig name "mem_hwrite" %false : i1
    %region_rd_deny_flag_5 = llhd.sig name "region_rd_deny_flag" %false : i1
    %region_wr_deny_flag_6 = llhd.sig name "region_wr_deny_flag" %false : i1
    %resp_cfg = llhd.sig %c0_i4 : i4
    %4 = llhd.prb %mem_htrans_3 : i2
    %5 = comb.icmp eq %4, %c-2_i2 {sv.namehint = "a_nonseq"} : i2
    %6 = comb.icmp eq %4, %c-1_i2 {sv.namehint = "a_seq"} : i2
    %7 = comb.or %5, %6 : i1
    %8 = llhd.prb %mem_hsel_2 : i1
    %9 = comb.and %7, %8, %mem_hready : i1
    llhd.drv %a_act_burst, %9 after %1 : i1
    %10 = llhd.prb %a_act_burst : i1
    %11 = llhd.prb %mem_hwrite_4 : i1
    %12 = llhd.prb %region_wr_deny_flag_6 : i1
    %13 = comb.and %10, %11, %12 : i1
    %14 = comb.xor %11, %true : i1
    %15 = llhd.prb %region_rd_deny_flag_5 : i1
    %16 = comb.and %10, %14, %15 : i1
    %17 = comb.or %13, %16 : i1
    %18 = comb.xor %17, %true : i1
    %19 = comb.and %18, %8 {sv.namehint = "mem_hsel_deny"} : i1
    %20 = comb.mux %17, %c0_i2, %4 : i2
    llhd.drv %mem_htrans_deny, %20 after %1 : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %34 = llhd.prb %mem_hclk_0 : i1
      %35 = llhd.prb %mem_hrst_b_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %36 = llhd.prb %mem_hclk_0 : i1
      %37 = comb.xor bin %34, %true : i1
      %38 = comb.and bin %37, %36 : i1
      %39 = llhd.prb %mem_hrst_b_1 : i1
      %40 = comb.xor bin %39, %true : i1
      %41 = comb.and bin %35, %40 : i1
      %42 = comb.or bin %38, %41 : i1
      cf.cond_br %42, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %43 = llhd.prb %mem_hrst_b_1 : i1
      %44 = comb.xor %43, %true : i1
      cf.cond_br %44, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %wr_deny_resp, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %45 = llhd.prb %wr_deny_resp : i1
      %46 = llhd.prb %wr_deny_resp_2_cycle : i1
      %47 = comb.and %45, %46 : i1
      cf.cond_br %47, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %wr_deny_resp, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %48 = llhd.prb %a_act_burst : i1
      %49 = llhd.prb %mem_hwrite_4 : i1
      %50 = llhd.prb %region_wr_deny_flag_6 : i1
      %51 = comb.and %48, %49, %50 : i1
      cf.cond_br %51, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %wr_deny_resp, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %34 = llhd.prb %mem_hclk_0 : i1
      %35 = llhd.prb %mem_hrst_b_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %36 = llhd.prb %mem_hclk_0 : i1
      %37 = comb.xor bin %34, %true : i1
      %38 = comb.and bin %37, %36 : i1
      %39 = llhd.prb %mem_hrst_b_1 : i1
      %40 = comb.xor bin %39, %true : i1
      %41 = comb.and bin %35, %40 : i1
      %42 = comb.or bin %38, %41 : i1
      cf.cond_br %42, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %43 = llhd.prb %mem_hrst_b_1 : i1
      %44 = comb.xor %43, %true : i1
      cf.cond_br %44, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %wr_deny_resp_2_cycle, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %45 = llhd.prb %wr_deny_resp : i1
      %46 = llhd.prb %wr_deny_resp_2_cycle : i1
      %47 = comb.and %45, %46 : i1
      cf.cond_br %47, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %wr_deny_resp_2_cycle, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %48 = llhd.prb %wr_deny_resp : i1
      cf.cond_br %48, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %wr_deny_resp_2_cycle, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %34 = llhd.prb %mem_hclk_0 : i1
      %35 = llhd.prb %mem_hrst_b_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %36 = llhd.prb %mem_hclk_0 : i1
      %37 = comb.xor bin %34, %true : i1
      %38 = comb.and bin %37, %36 : i1
      %39 = llhd.prb %mem_hrst_b_1 : i1
      %40 = comb.xor bin %39, %true : i1
      %41 = comb.and bin %35, %40 : i1
      %42 = comb.or bin %38, %41 : i1
      cf.cond_br %42, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %43 = llhd.prb %mem_hrst_b_1 : i1
      %44 = comb.xor %43, %true : i1
      cf.cond_br %44, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rd_deny_resp, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %45 = llhd.prb %rd_deny_resp : i1
      %46 = llhd.prb %rd_deny_resp_2_cycle : i1
      %47 = comb.and %45, %46 : i1
      cf.cond_br %47, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %rd_deny_resp, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %48 = llhd.prb %a_act_burst : i1
      %49 = llhd.prb %mem_hwrite_4 : i1
      %50 = comb.xor %49, %true : i1
      %51 = llhd.prb %region_rd_deny_flag_5 : i1
      %52 = comb.and %48, %50, %51 : i1
      cf.cond_br %52, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %rd_deny_resp, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %34 = llhd.prb %mem_hclk_0 : i1
      %35 = llhd.prb %mem_hrst_b_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %36 = llhd.prb %mem_hclk_0 : i1
      %37 = comb.xor bin %34, %true : i1
      %38 = comb.and bin %37, %36 : i1
      %39 = llhd.prb %mem_hrst_b_1 : i1
      %40 = comb.xor bin %39, %true : i1
      %41 = comb.and bin %35, %40 : i1
      %42 = comb.or bin %38, %41 : i1
      cf.cond_br %42, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %43 = llhd.prb %mem_hrst_b_1 : i1
      %44 = comb.xor %43, %true : i1
      cf.cond_br %44, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rd_deny_resp_2_cycle, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %45 = llhd.prb %rd_deny_resp : i1
      %46 = llhd.prb %rd_deny_resp_2_cycle : i1
      %47 = comb.and %45, %46 : i1
      cf.cond_br %47, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %rd_deny_resp_2_cycle, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %48 = llhd.prb %rd_deny_resp : i1
      cf.cond_br %48, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %rd_deny_resp_2_cycle, %true after %0 : i1
      cf.br ^bb1
    }
    %21 = llhd.prb %rd_deny_resp : i1
    %22 = llhd.prb %rd_deny_resp_2_cycle : i1
    %23 = llhd.prb %wr_deny_resp : i1
    %24 = llhd.prb %wr_deny_resp_2_cycle : i1
    %25 = llhd.prb %deny_hready_resp : i1
    %26 = comb.mux %23, %24, %25 : i1
    %27 = comb.mux %21, %22, %26 : i1
    %28 = llhd.prb %deny_hresp : i2
    %29 = comb.or %21, %23 : i1
    %30 = comb.mux %29, %c1_i2, %28 : i2
    llhd.drv %mem_hresp, %30 after %1 : i2
    %31 = llhd.prb %mem_htrans_deny : i2
    %32 = llhd.prb %resp_cfg : i4
    %x_sms_sms_ahbs.ahbs_harb_hrdata, %x_sms_sms_ahbs.ahbs_harb_hready, %x_sms_sms_ahbs.ahbs_harb_hresp, %x_sms_sms_ahbs.ram_addr, %x_sms_sms_ahbs.ram_idle, %x_sms_sms_ahbs.ram_sel, %x_sms_sms_ahbs.ram_size, %x_sms_sms_ahbs.ram_wdata, %x_sms_sms_ahbs.ram_write = hw.instance "x_sms_sms_ahbs" @sms_sms_ahbs_bk2(harb_ahbs_hsel: %19: i1, harb_xx_haddr: %mem_haddr: i32, harb_xx_hready: %mem_hready: i1, harb_xx_hsize: %mem_hsize: i3, harb_xx_htrans: %31: i2, harb_xx_hwdata: %mem_hwdata: i32, harb_xx_hwrite: %11: i1, i_sys_hclk: %2: i1, i_sys_rst_b: %3: i1, little_endian_trans: %big_endian_b: i1, mem_hprot: %mem_hprot: i4, ram_rdata: %x_sms_sram.ram_rdata: i32, resp_cfg: %32: i4) -> (ahbs_harb_hrdata: i32, ahbs_harb_hready: i1, ahbs_harb_hresp: i2, ram_addr: i16, ram_idle: i1, ram_sel: i1, ram_size: i3, ram_wdata: i32, ram_write: i1) {sv.namehint = "ram_sel"}
    llhd.drv %deny_hready_resp, %x_sms_sms_ahbs.ahbs_harb_hready after %1 : i1
    llhd.drv %deny_hresp, %x_sms_sms_ahbs.ahbs_harb_hresp after %1 : i2
    %x_sms_sram.ram_rdata = hw.instance "x_sms_sram" @sms_sram_bk2(hrst_b: %3: i1, ram_addr: %x_sms_sms_ahbs.ram_addr: i16, ram_clk: %2: i1, ram_sel: %x_sms_sms_ahbs.ram_sel: i1, ram_size: %x_sms_sms_ahbs.ram_size: i3, ram_wdata: %x_sms_sms_ahbs.ram_wdata: i32, ram_write: %x_sms_sms_ahbs.ram_write: i1) -> (ram_rdata: i32) {sv.namehint = "ram_rdata"}
    llhd.drv %resp_cfg, %c-8_i4 after %1 : i4
    llhd.drv %mem_hclk_0, %mem_hclk after %1 : i1
    %33 = llhd.prb %mem_hresp : i2
    llhd.drv %mem_hrst_b_1, %mem_hrst_b after %1 : i1
    llhd.drv %mem_hsel_2, %mem_hsel after %1 : i1
    llhd.drv %mem_htrans_3, %mem_htrans after %1 : i2
    llhd.drv %mem_hwrite_4, %mem_hwrite after %1 : i1
    llhd.drv %region_rd_deny_flag_5, %region_rd_deny_flag after %1 : i1
    llhd.drv %region_wr_deny_flag_6, %region_wr_deny_flag after %1 : i1
    hw.output %x_sms_sms_ahbs.ahbs_harb_hrdata, %27, %33, %x_sms_sms_ahbs.ram_idle : i32, i1, i2, i1
  }
  hw.module private @sms_sms_ahbs_bk2(out ahbs_harb_hrdata : i32, out ahbs_harb_hready : i1, out ahbs_harb_hresp : i2, in %harb_ahbs_hsel : i1, in %harb_xx_haddr : i32, in %harb_xx_hready : i1, in %harb_xx_hsize : i3, in %harb_xx_htrans : i2, in %harb_xx_hwdata : i32, in %harb_xx_hwrite : i1, in %i_sys_hclk : i1, in %i_sys_rst_b : i1, in %little_endian_trans : i1, in %mem_hprot : i4, out ram_addr : i16, out ram_idle : i1, in %ram_rdata : i32, out ram_sel : i1, out ram_size : i3, out ram_wdata : i32, out ram_write : i1, in %resp_cfg : i4) {
    %c-3_i4 = hw.constant -3 : i4
    %c-7_i4 = hw.constant -7 : i4
    %c3_i5 = hw.constant 3 : i5
    %c7_i5 = hw.constant 7 : i5
    %c12_i5 = hw.constant 12 : i5
    %c8_i5 = hw.constant 8 : i5
    %c2_i5 = hw.constant 2 : i5
    %c-5_i5 = hw.constant -5 : i5
    %c-13_i5 = hw.constant -13 : i5
    %c-16_i5 = hw.constant -16 : i5
    %c-14_i5 = hw.constant -14 : i5
    %c0_i5 = hw.constant 0 : i5
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %c0_i4 = hw.constant 0 : i4
    %c14_i5 = hw.constant 14 : i5
    %c10_i5 = hw.constant 10 : i5
    %c0_i2 = hw.constant 0 : i2
    %c0_i16 = hw.constant 0 : i16
    %c0_i8 = hw.constant 0 : i8
    %c1_i2 = hw.constant 1 : i2
    %c0_i24 = hw.constant 0 : i24
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %true = hw.constant true
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %harb_xx_hwdata_0 = llhd.sig name "harb_xx_hwdata" %c0_i32 : i32
    %2 = llhd.prb %harb_xx_hwdata_0 : i32
    %little_endian_trans_1 = llhd.sig name "little_endian_trans" %false : i1
    %3 = llhd.prb %little_endian_trans_1 : i1
    %ahbs_harb_hready_s = llhd.sig %false : i1
    %ahbs_harb_hresp = llhd.sig %c0_i2 : i2
    %harb_ahbs_hsel_r = llhd.sig %false : i1
    %4 = llhd.prb %harb_ahbs_hsel_r : i1
    %harb_xx_haddr_r = llhd.sig %c0_i16 : i16
    %5 = llhd.prb %harb_xx_haddr_r : i16
    %harb_xx_hsize_r = llhd.sig %c0_i3 : i3
    %read_after_write_access = llhd.sig %false : i1
    %rty_first = llhd.sig %false : i1
    %6 = llhd.prb %rty_first : i1
    %rty_flag = llhd.sig %false : i1
    %w_ram_addr_tmp = llhd.sig %c0_i16 : i16
    %w_ram_sel_tmp = llhd.sig %false : i1
    %w_ram_size_tmp = llhd.sig %c0_i3 : i3
    %w_ram_write_tmp = llhd.sig %false : i1
    %a_act_burst = llhd.sig %false : i1
    %a_byte = llhd.sig %false : i1
    %7 = llhd.prb %a_byte : i1
    %a_halfword = llhd.sig %false : i1
    %8 = llhd.prb %a_halfword : i1
    %a_word = llhd.sig %false : i1
    %9 = llhd.prb %a_word : i1
    %ahbs_harb_hready = llhd.sig %false : i1
    %harb_ahbs_hsel_2 = llhd.sig name "harb_ahbs_hsel" %false : i1
    %harb_xx_haddr_3 = llhd.sig name "harb_xx_haddr" %c0_i32 : i32
    %harb_xx_hready_4 = llhd.sig name "harb_xx_hready" %false : i1
    %harb_xx_hsize_5 = llhd.sig name "harb_xx_hsize" %c0_i3 : i3
    %harb_xx_hwrite_6 = llhd.sig name "harb_xx_hwrite" %false : i1
    %hready_s = llhd.sig %false : i1
    %10 = llhd.prb %hready_s : i1
    %i_sys_hclk_7 = llhd.sig name "i_sys_hclk" %false : i1
    %11 = llhd.prb %i_sys_hclk_7 : i1
    %i_sys_rst_b_8 = llhd.sig name "i_sys_rst_b" %false : i1
    %12 = llhd.prb %i_sys_rst_b_8 : i1
    %r_ram_addr = llhd.sig %c0_i16 : i16
    %r_ram_sel = llhd.sig %false : i1
    %r_ram_size = llhd.sig %c0_i3 : i3
    %r_ram_write = llhd.sig %false : i1
    %ram_addr = llhd.sig %c0_i16 : i16
    %ram_size = llhd.sig %c0_i3 : i3
    %ram_wdata = llhd.sig %c0_i32 : i32
    %reg_slave_rdata = llhd.sig %c0_i32 : i32
    %13 = llhd.prb %reg_slave_rdata : i32
    %resp_cfg_9 = llhd.sig name "resp_cfg" %c0_i4 : i4
    %14 = llhd.prb %resp_cfg_9 : i4
    %slave_reg_wdata_t = llhd.sig %c0_i32 : i32
    %sms_resp = llhd.sig %c0_i2 : i2
    %15 = llhd.prb %sms_resp : i2
    %w_ram_addr = llhd.sig %c0_i16 : i16
    %w_ram_sel = llhd.sig %false : i1
    %w_ram_size = llhd.sig %c0_i3 : i3
    %w_ram_write = llhd.sig %false : i1
    %16 = comb.icmp eq %harb_xx_htrans, %c-2_i2 {sv.namehint = "a_nonseq"} : i2
    %17 = comb.icmp eq %harb_xx_htrans, %c-1_i2 {sv.namehint = "a_seq"} : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %64 = llhd.prb %i_sys_hclk_7 : i1
      %65 = llhd.prb %i_sys_rst_b_8 : i1
      llhd.wait (%11, %12 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %66 = llhd.prb %i_sys_hclk_7 : i1
      %67 = comb.xor bin %64, %true : i1
      %68 = comb.and bin %67, %66 : i1
      %69 = llhd.prb %i_sys_rst_b_8 : i1
      %70 = comb.xor bin %69, %true : i1
      %71 = comb.and bin %65, %70 : i1
      %72 = comb.or bin %68, %71 : i1
      cf.cond_br %72, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %73 = llhd.prb %i_sys_rst_b_8 : i1
      %74 = comb.xor %73, %true : i1
      cf.cond_br %74, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %harb_xx_hsize_r, %c0_i3 after %1 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %75 = llhd.prb %harb_xx_hready_4 : i1
      cf.cond_br %75, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %76 = llhd.prb %harb_xx_hsize_5 : i3
      llhd.drv %harb_xx_hsize_r, %76 after %1 : i3
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %77 = llhd.prb %harb_xx_hsize_r : i3
      llhd.drv %harb_xx_hsize_r, %77 after %1 : i3
      cf.br ^bb1
    }
    %18 = llhd.prb %harb_xx_hsize_r : i3
    %19 = comb.icmp eq %18, %c0_i3 : i3
    llhd.drv %a_byte, %19 after %0 : i1
    %20 = comb.icmp eq %18, %c1_i3 : i3
    llhd.drv %a_halfword, %20 after %0 : i1
    %21 = comb.icmp eq %18, %c2_i3 : i3
    llhd.drv %a_word, %21 after %0 : i1
    %22 = comb.or %16, %17 : i1
    %23 = llhd.prb %harb_ahbs_hsel_2 : i1
    %24 = llhd.prb %harb_xx_hready_4 : i1
    %25 = comb.and %22, %23, %24 : i1
    llhd.drv %a_act_burst, %25 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %64 = llhd.prb %i_sys_hclk_7 : i1
      %65 = llhd.prb %i_sys_rst_b_8 : i1
      llhd.wait (%11, %12 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %66 = llhd.prb %i_sys_hclk_7 : i1
      %67 = comb.xor bin %64, %true : i1
      %68 = comb.and bin %67, %66 : i1
      %69 = llhd.prb %i_sys_rst_b_8 : i1
      %70 = comb.xor bin %69, %true : i1
      %71 = comb.and bin %65, %70 : i1
      %72 = comb.or bin %68, %71 : i1
      cf.cond_br %72, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %73 = llhd.prb %i_sys_rst_b_8 : i1
      %74 = comb.xor %73, %true : i1
      cf.cond_br %74, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %harb_ahbs_hsel_r, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %75 = llhd.prb %harb_ahbs_hsel_2 : i1
      cf.cond_br %75, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %harb_ahbs_hsel_r, %true after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %76 = llhd.prb %ahbs_harb_hready : i1
      cf.cond_br %76, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %harb_ahbs_hsel_r, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %64 = llhd.prb %i_sys_hclk_7 : i1
      %65 = llhd.prb %i_sys_rst_b_8 : i1
      llhd.wait (%11, %12 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %66 = llhd.prb %i_sys_hclk_7 : i1
      %67 = comb.xor bin %64, %true : i1
      %68 = comb.and bin %67, %66 : i1
      %69 = llhd.prb %i_sys_rst_b_8 : i1
      %70 = comb.xor bin %69, %true : i1
      %71 = comb.and bin %65, %70 : i1
      %72 = comb.or bin %68, %71 : i1
      cf.cond_br %72, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %73 = llhd.prb %i_sys_rst_b_8 : i1
      %74 = comb.xor %73, %true : i1
      cf.cond_br %74, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %harb_xx_haddr_r, %c0_i16 after %1 : i16
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %75 = llhd.prb %ahbs_harb_hready : i1
      cf.cond_br %75, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %76 = llhd.prb %harb_xx_haddr_3 : i32
      %77 = comb.extract %76 from 0 : (i32) -> i16
      llhd.drv %harb_xx_haddr_r, %77 after %1 : i16
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %78 = llhd.prb %harb_xx_haddr_r : i16
      llhd.drv %harb_xx_haddr_r, %78 after %1 : i16
      cf.br ^bb1
    }
    %ahbs_harb_hrdata = llhd.sig %c0_i32 : i32
    %slave_reg_wdata = llhd.sig %c0_i32 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 12 preds: ^bb0, ^bb3, ^bb7, ^bb9, ^bb11, ^bb12, ^bb15, ^bb16, ^bb17, ^bb18, ^bb19, ^bb20
      llhd.wait (%3, %4, %7, %8, %9, %13, %5, %2 : i1, i1, i1, i1, i1, i32, i16, i32), ^bb2
    ^bb2:  // pred: ^bb1
      %64 = llhd.prb %little_endian_trans_1 : i1
      %65 = llhd.prb %harb_ahbs_hsel_r : i1
      %66 = comb.and %64, %65 : i1
      cf.cond_br %66, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %67 = llhd.prb %reg_slave_rdata : i32
      llhd.drv %ahbs_harb_hrdata, %67 after %0 : i32
      %68 = llhd.prb %harb_xx_hwdata_0 : i32
      llhd.drv %slave_reg_wdata, %68 after %0 : i32
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      %69 = llhd.prb %little_endian_trans_1 : i1
      %70 = comb.xor %69, %true : i1
      %71 = llhd.prb %harb_ahbs_hsel_r : i1
      %72 = comb.and %70, %71 : i1
      cf.cond_br %72, ^bb5, ^bb20
    ^bb5:  // pred: ^bb4
      llhd.drv %ahbs_harb_hrdata, %c0_i32 after %0 : i32
      llhd.drv %slave_reg_wdata, %c0_i32 after %0 : i32
      %73 = llhd.prb %a_byte : i1
      %74 = comb.icmp ceq %73, %true : i1
      cf.cond_br %74, ^bb6, ^bb13
    ^bb6:  // pred: ^bb5
      %75 = llhd.prb %harb_xx_haddr_r : i16
      %76 = comb.extract %75 from 0 : (i16) -> i2
      %77 = comb.icmp eq %76, %c0_i2 : i2
      cf.cond_br %77, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %78 = llhd.prb %reg_slave_rdata : i32
      %79 = comb.extract %78 from 0 : (i32) -> i8
      %80 = comb.concat %79, %c0_i24 : i8, i24
      llhd.drv %ahbs_harb_hrdata, %80 after %0 : i32
      %81 = llhd.prb %harb_xx_hwdata_0 : i32
      %82 = comb.extract %81 from 24 : (i32) -> i8
      %83 = comb.concat %c0_i24, %82 : i24, i8
      llhd.drv %slave_reg_wdata, %83 after %0 : i32
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %84 = llhd.prb %harb_xx_haddr_r : i16
      %85 = comb.extract %84 from 0 : (i16) -> i2
      %86 = comb.icmp eq %85, %c1_i2 : i2
      cf.cond_br %86, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %87 = llhd.prb %reg_slave_rdata : i32
      %88 = comb.extract %87 from 8 : (i32) -> i8
      %89 = comb.concat %c0_i8, %88, %c0_i16 : i8, i8, i16
      llhd.drv %ahbs_harb_hrdata, %89 after %0 : i32
      %90 = llhd.prb %harb_xx_hwdata_0 : i32
      %91 = comb.extract %90 from 16 : (i32) -> i8
      %92 = comb.concat %c0_i16, %91, %c0_i8 : i16, i8, i8
      llhd.drv %slave_reg_wdata, %92 after %0 : i32
      cf.br ^bb1
    ^bb10:  // pred: ^bb8
      %93 = llhd.prb %harb_xx_haddr_r : i16
      %94 = comb.extract %93 from 0 : (i16) -> i2
      %95 = comb.icmp eq %94, %c-2_i2 : i2
      cf.cond_br %95, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %96 = llhd.prb %reg_slave_rdata : i32
      %97 = comb.extract %96 from 16 : (i32) -> i8
      %98 = comb.concat %c0_i16, %97, %c0_i8 : i16, i8, i8
      llhd.drv %ahbs_harb_hrdata, %98 after %0 : i32
      %99 = llhd.prb %harb_xx_hwdata_0 : i32
      %100 = comb.extract %99 from 8 : (i32) -> i8
      %101 = comb.concat %c0_i8, %100, %c0_i16 : i8, i8, i16
      llhd.drv %slave_reg_wdata, %101 after %0 : i32
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      %102 = llhd.prb %reg_slave_rdata : i32
      %103 = comb.extract %102 from 24 : (i32) -> i8
      %104 = comb.concat %c0_i24, %103 : i24, i8
      llhd.drv %ahbs_harb_hrdata, %104 after %0 : i32
      %105 = llhd.prb %harb_xx_hwdata_0 : i32
      %106 = comb.extract %105 from 0 : (i32) -> i8
      %107 = comb.concat %106, %c0_i24 : i8, i24
      llhd.drv %slave_reg_wdata, %107 after %0 : i32
      cf.br ^bb1
    ^bb13:  // pred: ^bb5
      %108 = llhd.prb %a_halfword : i1
      %109 = comb.icmp ceq %108, %true : i1
      cf.cond_br %109, ^bb14, ^bb18
    ^bb14:  // pred: ^bb13
      %110 = llhd.prb %harb_xx_haddr_r : i16
      %111 = comb.extract %110 from 0 : (i16) -> i2
      %112 = comb.icmp eq %111, %c0_i2 : i2
      cf.cond_br %112, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      %113 = llhd.prb %reg_slave_rdata : i32
      %114 = comb.extract %113 from 0 : (i32) -> i16
      %115 = comb.concat %114, %c0_i16 : i16, i16
      llhd.drv %ahbs_harb_hrdata, %115 after %0 : i32
      %116 = llhd.prb %harb_xx_hwdata_0 : i32
      %117 = comb.extract %116 from 16 : (i32) -> i16
      %118 = comb.concat %c0_i16, %117 : i16, i16
      llhd.drv %slave_reg_wdata, %118 after %0 : i32
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      %119 = llhd.prb %harb_xx_haddr_r : i16
      %120 = comb.extract %119 from 0 : (i16) -> i2
      %121 = comb.icmp eq %120, %c-2_i2 : i2
      cf.cond_br %121, ^bb17, ^bb1
    ^bb17:  // pred: ^bb16
      %122 = llhd.prb %reg_slave_rdata : i32
      %123 = comb.extract %122 from 16 : (i32) -> i16
      %124 = comb.concat %c0_i16, %123 : i16, i16
      llhd.drv %ahbs_harb_hrdata, %124 after %0 : i32
      %125 = llhd.prb %harb_xx_hwdata_0 : i32
      %126 = comb.extract %125 from 0 : (i32) -> i16
      %127 = comb.concat %126, %c0_i16 : i16, i16
      llhd.drv %slave_reg_wdata, %127 after %0 : i32
      cf.br ^bb1
    ^bb18:  // pred: ^bb13
      %128 = llhd.prb %a_word : i1
      %129 = comb.icmp ceq %128, %true : i1
      cf.cond_br %129, ^bb19, ^bb1
    ^bb19:  // pred: ^bb18
      %130 = llhd.prb %reg_slave_rdata : i32
      llhd.drv %ahbs_harb_hrdata, %130 after %0 : i32
      %131 = llhd.prb %harb_xx_hwdata_0 : i32
      llhd.drv %slave_reg_wdata, %131 after %0 : i32
      cf.br ^bb1
    ^bb20:  // pred: ^bb4
      %132 = llhd.prb %reg_slave_rdata : i32
      llhd.drv %ahbs_harb_hrdata, %132 after %0 : i32
      %133 = llhd.prb %harb_xx_hwdata_0 : i32
      llhd.drv %slave_reg_wdata, %133 after %0 : i32
      cf.br ^bb1
    }
    %26 = llhd.prb %slave_reg_wdata : i32
    llhd.drv %slave_reg_wdata_t, %26 after %0 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb7, ^bb8, ^bb10, ^bb11
      %64 = llhd.prb %i_sys_hclk_7 : i1
      %65 = llhd.prb %i_sys_rst_b_8 : i1
      llhd.wait (%11, %12 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %66 = llhd.prb %i_sys_hclk_7 : i1
      %67 = comb.xor bin %64, %true : i1
      %68 = comb.and bin %67, %66 : i1
      %69 = llhd.prb %i_sys_rst_b_8 : i1
      %70 = comb.xor bin %69, %true : i1
      %71 = comb.and bin %65, %70 : i1
      %72 = comb.or bin %68, %71 : i1
      cf.cond_br %72, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %73 = llhd.prb %i_sys_rst_b_8 : i1
      %74 = comb.xor %73, %true : i1
      cf.cond_br %74, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %w_ram_sel_tmp, %false after %1 : i1
      llhd.drv %w_ram_size_tmp, %c0_i3 after %1 : i3
      llhd.drv %w_ram_addr_tmp, %c0_i16 after %1 : i16
      llhd.drv %w_ram_write_tmp, %false after %1 : i1
      llhd.drv %read_after_write_access, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %75 = llhd.prb %harb_xx_hwrite_6 : i1
      cf.cond_br %75, ^bb6, ^bb9
    ^bb6:  // pred: ^bb5
      %76 = llhd.prb %a_act_burst : i1
      llhd.drv %w_ram_sel_tmp, %76 after %1 : i1
      %77 = llhd.prb %harb_xx_hsize_5 : i3
      llhd.drv %w_ram_size_tmp, %77 after %1 : i3
      %78 = llhd.prb %harb_xx_haddr_3 : i32
      %79 = comb.extract %78 from 0 : (i32) -> i16
      llhd.drv %w_ram_addr_tmp, %79 after %1 : i16
      llhd.drv %w_ram_write_tmp, %true after %1 : i1
      %80 = llhd.prb %read_after_write_access : i1
      cf.cond_br %80, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      llhd.drv %read_after_write_access, %false after %1 : i1
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %81 = llhd.prb %read_after_write_access : i1
      llhd.drv %read_after_write_access, %81 after %1 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb5
      %82 = llhd.prb %w_ram_sel : i1
      %83 = llhd.prb %w_ram_write : i1
      %84 = llhd.prb %r_ram_sel : i1
      %85 = comb.and %82, %83, %84 : i1
      cf.cond_br %85, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %86 = llhd.prb %a_act_burst : i1
      llhd.drv %w_ram_sel_tmp, %86 after %1 : i1
      %87 = llhd.prb %harb_xx_hsize_5 : i3
      llhd.drv %w_ram_size_tmp, %87 after %1 : i3
      %88 = llhd.prb %harb_xx_haddr_3 : i32
      %89 = comb.extract %88 from 0 : (i32) -> i16
      llhd.drv %w_ram_addr_tmp, %89 after %1 : i16
      llhd.drv %w_ram_write_tmp, %false after %1 : i1
      llhd.drv %read_after_write_access, %true after %1 : i1
      cf.br ^bb1
    ^bb11:  // pred: ^bb9
      llhd.drv %w_ram_sel_tmp, %false after %1 : i1
      llhd.drv %w_ram_size_tmp, %c0_i3 after %1 : i3
      llhd.drv %w_ram_addr_tmp, %c0_i16 after %1 : i16
      llhd.drv %w_ram_write_tmp, %false after %1 : i1
      llhd.drv %read_after_write_access, %false after %1 : i1
      cf.br ^bb1
    }
    %27 = llhd.prb %w_ram_size_tmp : i3
    llhd.drv %w_ram_size, %27 after %0 : i3
    %28 = llhd.prb %w_ram_addr_tmp : i16
    llhd.drv %w_ram_addr, %28 after %0 : i16
    %29 = llhd.prb %w_ram_sel_tmp : i1
    llhd.drv %w_ram_sel, %29 after %0 : i1
    %30 = llhd.prb %w_ram_write_tmp : i1
    llhd.drv %w_ram_write, %30 after %0 : i1
    %31 = llhd.prb %slave_reg_wdata_t : i32
    llhd.drv %ram_wdata, %31 after %0 : i32
    %32 = llhd.prb %a_act_burst : i1
    %33 = llhd.prb %r_ram_write : i1
    %34 = comb.xor %33, %true : i1
    %35 = comb.and %32, %34 : i1
    llhd.drv %r_ram_sel, %35 after %0 : i1
    %36 = llhd.prb %harb_xx_hwrite_6 : i1
    llhd.drv %r_ram_write, %36 after %0 : i1
    %37 = llhd.prb %harb_xx_hsize_5 : i3
    llhd.drv %r_ram_size, %37 after %0 : i3
    %38 = llhd.prb %harb_xx_haddr_3 : i32
    %39 = comb.extract %38 from 0 : (i32) -> i16
    llhd.drv %r_ram_addr, %39 after %0 : i16
    llhd.drv %reg_slave_rdata, %ram_rdata after %0 : i32
    %40 = llhd.prb %w_ram_sel : i1
    %41 = llhd.prb %r_ram_sel : i1
    %42 = comb.or %40, %41 : i1
    %43 = llhd.prb %w_ram_write : i1
    %44 = comb.mux %40, %43, %33 : i1
    %45 = llhd.prb %w_ram_size : i3
    %46 = llhd.prb %r_ram_size : i3
    %47 = comb.mux %40, %45, %46 : i3
    llhd.drv %ram_size, %47 after %0 : i3
    %48 = llhd.prb %w_ram_addr : i16
    %49 = llhd.prb %r_ram_addr : i16
    %50 = comb.mux %40, %48, %49 : i16
    llhd.drv %ram_addr, %50 after %0 : i16
    %51 = comb.xor %32, %true : i1
    %52 = comb.xor %40, %true : i1
    %53 = comb.and %51, %52 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %64 = llhd.prb %i_sys_hclk_7 : i1
      %65 = llhd.prb %i_sys_rst_b_8 : i1
      llhd.wait (%11, %12 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %66 = llhd.prb %i_sys_hclk_7 : i1
      %67 = comb.xor bin %64, %true : i1
      %68 = comb.and bin %67, %66 : i1
      %69 = llhd.prb %i_sys_rst_b_8 : i1
      %70 = comb.xor bin %69, %true : i1
      %71 = comb.and bin %65, %70 : i1
      %72 = comb.or bin %68, %71 : i1
      cf.cond_br %72, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %73 = llhd.prb %i_sys_rst_b_8 : i1
      %74 = comb.xor %73, %true : i1
      cf.cond_br %74, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rty_first, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %75 = llhd.prb %rty_flag : i1
      llhd.drv %rty_first, %75 after %1 : i1
      cf.br ^bb1
    }
    %54 = llhd.prb %read_after_write_access : i1
    %55 = comb.xor %54, %true : i1
    %56 = llhd.prb %ahbs_harb_hready_s : i1
    %57 = comb.and %55, %56 : i1
    llhd.drv %ahbs_harb_hready, %57 after %0 : i1
    llhd.drv %sms_resp, %c0_i2 after %0 : i2
    llhd.drv %hready_s, %true after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 8 preds: ^bb0, ^bb4, ^bb7, ^bb10, ^bb13, ^bb15, ^bb17, ^bb18
      llhd.wait (%10, %15, %14, %6 : i1, i2, i4, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %64 = llhd.prb %resp_cfg_9 : i4
      %65 = comb.extract %64 from 2 : (i4) -> i2
      %66 = llhd.prb %rty_first : i1
      %67 = comb.extract %64 from 0 : (i4) -> i2
      %68 = comb.concat %65, %66, %67 : i2, i1, i2
      %69 = comb.extract %64 from 1 : (i4) -> i1
      %70 = comb.concat %65, %66, %69 : i2, i1, i1
      %71 = comb.and %70, %c-7_i4 : i4
      %72 = comb.concat %71, %false : i4, i1
      %73 = comb.icmp ceq %72, %c-16_i5 : i5
      cf.cond_br %73, ^bb4, ^bb3
    ^bb3:  // pred: ^bb2
      %74 = comb.and %68, %c-13_i5 : i5
      %75 = comb.icmp ceq %74, %c-14_i5 : i5
      cf.cond_br %75, ^bb4, ^bb5
    ^bb4:  // 2 preds: ^bb2, ^bb3
      llhd.drv %rty_flag, %false after %0 : i1
      %76 = llhd.prb %hready_s : i1
      llhd.drv %ahbs_harb_hready_s, %76 after %0 : i1
      %77 = llhd.prb %sms_resp : i2
      llhd.drv %ahbs_harb_hresp, %77 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %78 = comb.and %68, %c-5_i5 : i5
      %79 = comb.icmp ceq %78, %c2_i5 : i5
      cf.cond_br %79, ^bb7, ^bb6
    ^bb6:  // pred: ^bb5
      %80 = comb.extract %64 from 1 : (i4) -> i1
      %81 = comb.concat %65, %66, %80 : i2, i1, i1
      %82 = comb.and %81, %c-3_i4 : i4
      %83 = comb.concat %82, %false : i4, i1
      %84 = comb.icmp ceq %83, %c0_i5 : i5
      cf.cond_br %84, ^bb7, ^bb8
    ^bb7:  // 2 preds: ^bb5, ^bb6
      llhd.drv %rty_flag, %false after %0 : i1
      llhd.drv %ahbs_harb_hready_s, %false after %0 : i1
      llhd.drv %ahbs_harb_hresp, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %85 = comb.extract %64 from 1 : (i4) -> i1
      %86 = comb.concat %65, %66, %85, %false : i2, i1, i1, i1
      %87 = comb.icmp ceq %86, %c8_i5 : i5
      cf.cond_br %87, ^bb10, ^bb9
    ^bb9:  // pred: ^bb8
      %88 = comb.icmp ceq %68, %c10_i5 : i5
      cf.cond_br %88, ^bb10, ^bb11
    ^bb10:  // 2 preds: ^bb8, ^bb9
      llhd.drv %rty_flag, %true after %0 : i1
      llhd.drv %ahbs_harb_hready_s, %false after %0 : i1
      llhd.drv %ahbs_harb_hresp, %c-2_i2 after %0 : i2
      cf.br ^bb1
    ^bb11:  // pred: ^bb9
      %89 = comb.icmp ceq %86, %c12_i5 : i5
      cf.cond_br %89, ^bb13, ^bb12
    ^bb12:  // pred: ^bb11
      %90 = comb.icmp ceq %68, %c14_i5 : i5
      cf.cond_br %90, ^bb13, ^bb14
    ^bb13:  // 2 preds: ^bb11, ^bb12
      llhd.drv %rty_flag, %false after %0 : i1
      llhd.drv %ahbs_harb_hready_s, %true after %0 : i1
      llhd.drv %ahbs_harb_hresp, %c-2_i2 after %0 : i2
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      %91 = comb.concat %c0_i2, %66, %67 : i2, i1, i2
      %92 = comb.icmp ceq %91, %c3_i5 : i5
      cf.cond_br %92, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      llhd.drv %rty_flag, %true after %0 : i1
      llhd.drv %ahbs_harb_hready_s, %false after %0 : i1
      llhd.drv %ahbs_harb_hresp, %c1_i2 after %0 : i2
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      %93 = comb.icmp ceq %91, %c7_i5 : i5
      cf.cond_br %93, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      llhd.drv %rty_flag, %false after %0 : i1
      llhd.drv %ahbs_harb_hready_s, %true after %0 : i1
      llhd.drv %ahbs_harb_hresp, %c1_i2 after %0 : i2
      cf.br ^bb1
    ^bb18:  // pred: ^bb16
      llhd.drv %rty_flag, %false after %0 : i1
      llhd.drv %ahbs_harb_hready_s, %true after %0 : i1
      llhd.drv %ahbs_harb_hresp, %c0_i2 after %0 : i2
      cf.br ^bb1
    }
    %58 = llhd.prb %ahbs_harb_hrdata : i32
    %59 = llhd.prb %ahbs_harb_hready : i1
    %60 = llhd.prb %ahbs_harb_hresp : i2
    llhd.drv %harb_ahbs_hsel_2, %harb_ahbs_hsel after %0 : i1
    llhd.drv %harb_xx_haddr_3, %harb_xx_haddr after %0 : i32
    llhd.drv %harb_xx_hready_4, %harb_xx_hready after %0 : i1
    llhd.drv %harb_xx_hsize_5, %harb_xx_hsize after %0 : i3
    llhd.drv %harb_xx_hwdata_0, %harb_xx_hwdata after %0 : i32
    llhd.drv %harb_xx_hwrite_6, %harb_xx_hwrite after %0 : i1
    llhd.drv %i_sys_hclk_7, %i_sys_hclk after %0 : i1
    llhd.drv %i_sys_rst_b_8, %i_sys_rst_b after %0 : i1
    llhd.drv %little_endian_trans_1, %little_endian_trans after %0 : i1
    %61 = llhd.prb %ram_addr : i16
    %62 = llhd.prb %ram_size : i3
    %63 = llhd.prb %ram_wdata : i32
    llhd.drv %resp_cfg_9, %resp_cfg after %0 : i4
    hw.output %58, %59, %60, %61, %53, %42, %62, %63, %44 : i32, i1, i2, i16, i1, i1, i3, i32, i1
  }
  hw.module private @sms_sram_bk2(in %hrst_b : i1, in %ram_addr : i16, in %ram_clk : i1, out ram_rdata : i32, in %ram_sel : i1, in %ram_size : i3, in %ram_wdata : i32, in %ram_write : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
    %c0_i16 = hw.constant 0 : i16
    %c0_i32 = hw.constant 0 : i32
    %c-1_i4 = hw.constant -1 : i4
    %c0_i4 = hw.constant 0 : i4
    %c2_i3 = hw.constant 2 : i3
    %c3_i4 = hw.constant 3 : i4
    %c-4_i4 = hw.constant -4 : i4
    %false = hw.constant false
    %c1_i3 = hw.constant 1 : i3
    %c7_i4 = hw.constant 7 : i4
    %c-5_i4 = hw.constant -5 : i4
    %c-2_i2 = hw.constant -2 : i2
    %c-3_i4 = hw.constant -3 : i4
    %c1_i2 = hw.constant 1 : i2
    %c-2_i4 = hw.constant -2 : i4
    %c0_i2 = hw.constant 0 : i2
    %c0_i3 = hw.constant 0 : i3
    %byte_sel_b = llhd.sig %c0_i4 : i4
    %mbk_cen_f_b = llhd.sig %false : i1
    %2 = llhd.prb %mbk_cen_f_b : i1
    %ram_rdata = llhd.sig %c0_i32 : i32
    %byte_wen_b = llhd.sig %c0_i4 : i4
    %hrst_b_0 = llhd.sig name "hrst_b" %false : i1
    %3 = llhd.prb %hrst_b_0 : i1
    %mbk_cen_b = llhd.sig %false : i1
    %ram0_rdata = llhd.sig %c0_i32 : i32
    %4 = llhd.prb %ram0_rdata : i32
    %ram_addr_1 = llhd.sig name "ram_addr" %c0_i16 : i16
    %5 = llhd.prb %ram_addr_1 : i16
    %ram_clk_2 = llhd.sig name "ram_clk" %false : i1
    %6 = llhd.prb %ram_clk_2 : i1
    %ram_size_3 = llhd.sig name "ram_size" %c0_i3 : i3
    %7 = llhd.prb %ram_size_3 : i3
    %8 = comb.xor %ram_sel, %true : i1
    llhd.drv %mbk_cen_b, %8 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 9 preds: ^bb0, ^bb4, ^bb6, ^bb8, ^bb9, ^bb12, ^bb13, ^bb15, ^bb16
      llhd.wait (%5, %7 : i16, i3), ^bb2
    ^bb2:  // pred: ^bb1
      %17 = llhd.prb %ram_size_3 : i3
      %18 = comb.icmp ceq %17, %c0_i3 : i3
      cf.cond_br %18, ^bb3, ^bb10
    ^bb3:  // pred: ^bb2
      %19 = llhd.prb %ram_addr_1 : i16
      %20 = comb.extract %19 from 0 : (i16) -> i2
      %21 = comb.icmp ceq %20, %c0_i2 : i2
      cf.cond_br %21, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %byte_sel_b, %c-2_i4 after %1 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %22 = comb.icmp ceq %20, %c1_i2 : i2
      cf.cond_br %22, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %byte_sel_b, %c-3_i4 after %1 : i4
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %23 = comb.icmp ceq %20, %c-2_i2 : i2
      cf.cond_br %23, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %byte_sel_b, %c-5_i4 after %1 : i4
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      llhd.drv %byte_sel_b, %c7_i4 after %1 : i4
      cf.br ^bb1
    ^bb10:  // pred: ^bb2
      %24 = comb.icmp ceq %17, %c1_i3 : i3
      cf.cond_br %24, ^bb11, ^bb14
    ^bb11:  // pred: ^bb10
      %25 = llhd.prb %ram_addr_1 : i16
      %26 = comb.extract %25 from 1 : (i16) -> i1
      %27 = comb.icmp ceq %26, %false : i1
      cf.cond_br %27, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      llhd.drv %byte_sel_b, %c-4_i4 after %1 : i4
      cf.br ^bb1
    ^bb13:  // pred: ^bb11
      llhd.drv %byte_sel_b, %c3_i4 after %1 : i4
      cf.br ^bb1
    ^bb14:  // pred: ^bb10
      %28 = comb.icmp ceq %17, %c2_i3 : i3
      cf.cond_br %28, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      llhd.drv %byte_sel_b, %c0_i4 after %1 : i4
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      llhd.drv %byte_sel_b, %c-1_i4 after %1 : i4
      cf.br ^bb1
    }
    %9 = comb.xor %ram_write, %true {sv.namehint = "mbk_wen_b"} : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %17 = llhd.prb %ram_clk_2 : i1
      %18 = llhd.prb %hrst_b_0 : i1
      llhd.wait (%6, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %19 = llhd.prb %ram_clk_2 : i1
      %20 = comb.xor bin %17, %true : i1
      %21 = comb.and bin %20, %19 : i1
      %22 = llhd.prb %hrst_b_0 : i1
      %23 = comb.xor bin %22, %true : i1
      %24 = comb.and bin %18, %23 : i1
      %25 = comb.or bin %21, %24 : i1
      cf.cond_br %25, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %26 = llhd.prb %hrst_b_0 : i1
      %27 = comb.xor %26, %true : i1
      cf.cond_br %27, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %mbk_cen_f_b, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %28 = llhd.prb %mbk_cen_b : i1
      llhd.drv %mbk_cen_f_b, %28 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 3 preds: ^bb0, ^bb3, ^bb4
      llhd.wait (%2, %4 : i1, i32), ^bb2
    ^bb2:  // pred: ^bb1
      %17 = llhd.prb %mbk_cen_f_b : i1
      %18 = comb.icmp ceq %17, %false : i1
      cf.cond_br %18, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %19 = llhd.prb %ram0_rdata : i32
      llhd.drv %ram_rdata, %19 after %1 : i32
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      llhd.drv %ram_rdata, %c0_i32 after %1 : i32
      cf.br ^bb1
    }
    %10 = llhd.prb %byte_sel_b : i4
    %11 = comb.replicate %9 : (i1) -> i4
    %12 = comb.or %10, %11 : i4
    llhd.drv %byte_wen_b, %12 after %1 : i4
    %13 = comb.extract %5 from 2 : (i16) -> i14
    %14 = llhd.prb %mbk_cen_b : i1
    %15 = llhd.prb %byte_wen_b : i4
    %x_fpga_spram.Q = hw.instance "x_fpga_spram" @fpga_spram(A: %13: i14, CEN: %14: i1, CLK: %6: i1, D: %ram_wdata: i32, BWEN: %15: i4) -> (Q: i32)
    llhd.drv %ram0_rdata, %x_fpga_spram.Q after %1 : i32
    llhd.drv %hrst_b_0, %hrst_b after %1 : i1
    llhd.drv %ram_addr_1, %ram_addr after %1 : i16
    llhd.drv %ram_clk_2, %ram_clk after %1 : i1
    %16 = llhd.prb %ram_rdata : i32
    llhd.drv %ram_size_3, %ram_size after %1 : i3
    hw.output %16 : i32
  }
  hw.module private @sms_top(in %ahb_sms0_haddr : i32, in %ahb_sms0_hprot : i4, in %ahb_sms0_hsel : i1, in %ahb_sms0_hsize : i3, in %ahb_sms0_htrans : i2, in %ahb_sms0_hwdata : i32, in %ahb_sms0_hwrite : i1, in %ahb_sms1_haddr : i32, in %ahb_sms1_hprot : i4, in %ahb_sms1_hsel : i1, in %ahb_sms1_hsize : i3, in %ahb_sms1_htrans : i2, in %ahb_sms1_hwdata : i32, in %ahb_sms1_hwrite : i1, in %ahb_sms2_haddr : i32, in %ahb_sms2_hprot : i4, in %ahb_sms2_hsel : i1, in %ahb_sms2_hsize : i3, in %ahb_sms2_htrans : i2, in %ahb_sms2_hwdata : i32, in %ahb_sms2_hwrite : i1, in %ahb_sms3_haddr : i32, in %ahb_sms3_hprot : i4, in %ahb_sms3_hsel : i1, in %ahb_sms3_hsize : i3, in %ahb_sms3_htrans : i2, in %ahb_sms3_hwdata : i32, in %ahb_sms3_hwrite : i1, in %pmu_sms_hclk : i1, in %pmu_sms_hrst_b : i1, out sms0_ahb_hrdata : i32, out sms0_ahb_hready : i1, out sms0_ahb_hresp : i2, out sms0_idle : i1, out sms1_ahb_hrdata : i32, out sms1_ahb_hready : i1, out sms1_ahb_hresp : i2, out sms1_idle : i1, out sms2_ahb_hrdata : i32, out sms2_ahb_hready : i1, out sms2_ahb_hresp : i2, out sms2_idle : i1, out sms3_ahb_hrdata : i32, out sms3_ahb_hready : i1, out sms3_ahb_hresp : i2, out sms3_idle : i1, in %sms_big_endian_b : i1) {
    %false = hw.constant false {sv.namehint = "region_wr_deny_flag3"}
    %true = hw.constant true
    %x_sms0_top.mem_hrdata, %x_sms0_top.mem_hready_resp, %x_sms0_top.mem_hresp, %x_sms0_top.sms_idle0 = hw.instance "x_sms0_top" @sms_bank_64k_top(big_endian_b: %sms_big_endian_b: i1, mem_haddr: %ahb_sms0_haddr: i32, mem_hclk: %pmu_sms_hclk: i1, mem_hprot: %ahb_sms0_hprot: i4, mem_hready: %true: i1, mem_hrst_b: %pmu_sms_hrst_b: i1, mem_hsel: %ahb_sms0_hsel: i1, mem_hsize: %ahb_sms0_hsize: i3, mem_htrans: %ahb_sms0_htrans: i2, mem_hwdata: %ahb_sms0_hwdata: i32, mem_hwrite: %ahb_sms0_hwrite: i1, region_rd_deny_flag: %false: i1, region_wr_deny_flag: %false: i1) -> (mem_hrdata: i32, mem_hready_resp: i1, mem_hresp: i2, sms_idle0: i1)
    %x_sms1_top.mem_hrdata, %x_sms1_top.mem_hready_resp, %x_sms1_top.mem_hresp, %x_sms1_top.sms_idle0 = hw.instance "x_sms1_top" @sms_bank_64k_top(big_endian_b: %sms_big_endian_b: i1, mem_haddr: %ahb_sms1_haddr: i32, mem_hclk: %pmu_sms_hclk: i1, mem_hprot: %ahb_sms1_hprot: i4, mem_hready: %true: i1, mem_hrst_b: %pmu_sms_hrst_b: i1, mem_hsel: %ahb_sms1_hsel: i1, mem_hsize: %ahb_sms1_hsize: i3, mem_htrans: %ahb_sms1_htrans: i2, mem_hwdata: %ahb_sms1_hwdata: i32, mem_hwrite: %ahb_sms1_hwrite: i1, region_rd_deny_flag: %false: i1, region_wr_deny_flag: %false: i1) -> (mem_hrdata: i32, mem_hready_resp: i1, mem_hresp: i2, sms_idle0: i1)
    %x_sms2_top.mem_hrdata, %x_sms2_top.mem_hready_resp, %x_sms2_top.mem_hresp, %x_sms2_top.sms_idle0 = hw.instance "x_sms2_top" @sms_bank_64k_top(big_endian_b: %sms_big_endian_b: i1, mem_haddr: %ahb_sms2_haddr: i32, mem_hclk: %pmu_sms_hclk: i1, mem_hprot: %ahb_sms2_hprot: i4, mem_hready: %true: i1, mem_hrst_b: %pmu_sms_hrst_b: i1, mem_hsel: %ahb_sms2_hsel: i1, mem_hsize: %ahb_sms2_hsize: i3, mem_htrans: %ahb_sms2_htrans: i2, mem_hwdata: %ahb_sms2_hwdata: i32, mem_hwrite: %ahb_sms2_hwrite: i1, region_rd_deny_flag: %false: i1, region_wr_deny_flag: %false: i1) -> (mem_hrdata: i32, mem_hready_resp: i1, mem_hresp: i2, sms_idle0: i1)
    %x_isram_top.mem_hrdata, %x_isram_top.mem_hready_resp, %x_isram_top.mem_hresp, %x_isram_top.sms_idle0 = hw.instance "x_isram_top" @sms_bank_64k_top(big_endian_b: %sms_big_endian_b: i1, mem_haddr: %ahb_sms3_haddr: i32, mem_hclk: %pmu_sms_hclk: i1, mem_hprot: %ahb_sms3_hprot: i4, mem_hready: %true: i1, mem_hrst_b: %pmu_sms_hrst_b: i1, mem_hsel: %ahb_sms3_hsel: i1, mem_hsize: %ahb_sms3_hsize: i3, mem_htrans: %ahb_sms3_htrans: i2, mem_hwdata: %ahb_sms3_hwdata: i32, mem_hwrite: %ahb_sms3_hwrite: i1, region_rd_deny_flag: %false: i1, region_wr_deny_flag: %false: i1) -> (mem_hrdata: i32, mem_hready_resp: i1, mem_hresp: i2, sms_idle0: i1)
    hw.output %x_sms0_top.mem_hrdata, %x_sms0_top.mem_hready_resp, %x_sms0_top.mem_hresp, %x_sms0_top.sms_idle0, %x_sms1_top.mem_hrdata, %x_sms1_top.mem_hready_resp, %x_sms1_top.mem_hresp, %x_sms1_top.sms_idle0, %x_sms2_top.mem_hrdata, %x_sms2_top.mem_hready_resp, %x_sms2_top.mem_hresp, %x_sms2_top.sms_idle0, %x_isram_top.mem_hrdata, %x_isram_top.mem_hready_resp, %x_isram_top.mem_hresp, %x_isram_top.sms_idle0 : i32, i1, i2, i1, i32, i1, i2, i1, i32, i1, i2, i1, i32, i1, i2, i1
  }
  hw.module @smu_top(in %hmain0_ismc_s0_haddr : i32, in %hmain0_ismc_s0_hprot : i4, in %hmain0_ismc_s0_hsel : i1, in %hmain0_ismc_s0_hsize : i3, in %hmain0_ismc_s0_htrans : i2, in %hmain0_ismc_s0_hwdata : i32, in %hmain0_ismc_s0_hwrite : i1, in %hmain0_smc_s2_haddr : i32, in %hmain0_smc_s2_hprot : i4, in %hmain0_smc_s2_hsel : i1, in %hmain0_smc_s2_hsize : i3, in %hmain0_smc_s2_htrans : i2, in %hmain0_smc_s2_hwdata : i32, in %hmain0_smc_s2_hwrite : i1, in %hmain0_smc_s3_haddr : i32, in %hmain0_smc_s3_hprot : i4, in %hmain0_smc_s3_hsel : i1, in %hmain0_smc_s3_hsize : i3, in %hmain0_smc_s3_htrans : i2, in %hmain0_smc_s3_hwdata : i32, in %hmain0_smc_s3_hwrite : i1, in %hmain0_smc_s4_haddr : i32, in %hmain0_smc_s4_hprot : i4, in %hmain0_smc_s4_hsel : i1, in %hmain0_smc_s4_hsize : i3, in %hmain0_smc_s4_htrans : i2, in %hmain0_smc_s4_hwdata : i32, in %hmain0_smc_s4_hwrite : i1, out ismc_hmain0_s0_hrdata : i32, out ismc_hmain0_s0_hready : i1, out ismc_hmain0_s0_hresp : i2, in %pmu_smc_hclk : i1, in %pmu_smc_hrst_b : i1, out smc_hmain0_s2_hrdata : i32, out smc_hmain0_s2_hready : i1, out smc_hmain0_s2_hresp : i2, out smc_hmain0_s3_hrdata : i32, out smc_hmain0_s3_hready : i1, out smc_hmain0_s3_hresp : i2, out smc_hmain0_s4_hrdata : i32, out smc_hmain0_s4_hready : i1, out smc_hmain0_s4_hresp : i2) {
    %true = hw.constant true {sv.namehint = "sms_big_endian_b"}
    %x_sms_top.sms0_ahb_hrdata, %x_sms_top.sms0_ahb_hready, %x_sms_top.sms0_ahb_hresp, %x_sms_top.sms0_idle, %x_sms_top.sms1_ahb_hrdata, %x_sms_top.sms1_ahb_hready, %x_sms_top.sms1_ahb_hresp, %x_sms_top.sms1_idle, %x_sms_top.sms2_ahb_hrdata, %x_sms_top.sms2_ahb_hready, %x_sms_top.sms2_ahb_hresp, %x_sms_top.sms2_idle, %x_sms_top.sms3_ahb_hrdata, %x_sms_top.sms3_ahb_hready, %x_sms_top.sms3_ahb_hresp, %x_sms_top.sms3_idle = hw.instance "x_sms_top" @sms_top(ahb_sms0_haddr: %hmain0_smc_s2_haddr: i32, ahb_sms0_hprot: %hmain0_smc_s2_hprot: i4, ahb_sms0_hsel: %hmain0_smc_s2_hsel: i1, ahb_sms0_hsize: %hmain0_smc_s2_hsize: i3, ahb_sms0_htrans: %hmain0_smc_s2_htrans: i2, ahb_sms0_hwdata: %hmain0_smc_s2_hwdata: i32, ahb_sms0_hwrite: %hmain0_smc_s2_hwrite: i1, ahb_sms1_haddr: %hmain0_smc_s3_haddr: i32, ahb_sms1_hprot: %hmain0_smc_s3_hprot: i4, ahb_sms1_hsel: %hmain0_smc_s3_hsel: i1, ahb_sms1_hsize: %hmain0_smc_s3_hsize: i3, ahb_sms1_htrans: %hmain0_smc_s3_htrans: i2, ahb_sms1_hwdata: %hmain0_smc_s3_hwdata: i32, ahb_sms1_hwrite: %hmain0_smc_s3_hwrite: i1, ahb_sms2_haddr: %hmain0_smc_s4_haddr: i32, ahb_sms2_hprot: %hmain0_smc_s4_hprot: i4, ahb_sms2_hsel: %hmain0_smc_s4_hsel: i1, ahb_sms2_hsize: %hmain0_smc_s4_hsize: i3, ahb_sms2_htrans: %hmain0_smc_s4_htrans: i2, ahb_sms2_hwdata: %hmain0_smc_s4_hwdata: i32, ahb_sms2_hwrite: %hmain0_smc_s4_hwrite: i1, ahb_sms3_haddr: %hmain0_ismc_s0_haddr: i32, ahb_sms3_hprot: %hmain0_ismc_s0_hprot: i4, ahb_sms3_hsel: %hmain0_ismc_s0_hsel: i1, ahb_sms3_hsize: %hmain0_ismc_s0_hsize: i3, ahb_sms3_htrans: %hmain0_ismc_s0_htrans: i2, ahb_sms3_hwdata: %hmain0_ismc_s0_hwdata: i32, ahb_sms3_hwrite: %hmain0_ismc_s0_hwrite: i1, pmu_sms_hclk: %pmu_smc_hclk: i1, pmu_sms_hrst_b: %pmu_smc_hrst_b: i1, sms_big_endian_b: %true: i1) -> (sms0_ahb_hrdata: i32, sms0_ahb_hready: i1, sms0_ahb_hresp: i2, sms0_idle: i1, sms1_ahb_hrdata: i32, sms1_ahb_hready: i1, sms1_ahb_hresp: i2, sms1_idle: i1, sms2_ahb_hrdata: i32, sms2_ahb_hready: i1, sms2_ahb_hresp: i2, sms2_idle: i1, sms3_ahb_hrdata: i32, sms3_ahb_hready: i1, sms3_ahb_hresp: i2, sms3_idle: i1) {sv.namehint = "sms3_idle"}
    hw.output %x_sms_top.sms3_ahb_hrdata, %x_sms_top.sms3_ahb_hready, %x_sms_top.sms3_ahb_hresp, %x_sms_top.sms0_ahb_hrdata, %x_sms_top.sms0_ahb_hready, %x_sms_top.sms0_ahb_hresp, %x_sms_top.sms1_ahb_hrdata, %x_sms_top.sms1_ahb_hready, %x_sms_top.sms1_ahb_hresp, %x_sms_top.sms2_ahb_hrdata, %x_sms_top.sms2_ahb_hready, %x_sms_top.sms2_ahb_hresp : i32, i1, i2, i32, i1, i2, i32, i1, i2, i32, i1, i2
  }
}
