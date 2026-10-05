module {
  hw.module private @apb_if(in %clk : i1, out clk_div0 : i24, out cpha : i1, out cpol : i1, out fifo_intr_en : i10, out i2c_addr : i10, out i2c_aerr_clr : i1, in %i2c_aerr_intr : i1, out i2c_en : i1, out i2c_fs_div : i8, out i2c_hcnt : i24, out i2c_hold : i8, out i2c_intr_en : i5, out i2c_lcnt : i24, out i2c_mode : i1, out i2c_nack_clr : i1, in %i2c_nack_intr : i1, out i2c_stop_clr : i1, in %i2c_stop_intr : i1, out i2cm_amode : i1, out i2cm_code : i3, in %i2cm_data : i1, out i2cm_en : i1, out i2cm_gcall : i1, out i2cm_hs : i1, out i2cm_lose_arbi_clr : i1, in %i2cm_lose_arbi_intr : i1, out i2cm_sbyte : i1, out i2cm_stop : i1, in %i2cm_work : i1, out i2cs_amode : i1, out i2cs_en : i1, out i2cs_gcall : i1, out i2cs_gcall_clr : i1, in %i2cs_gcall_intr : i1, out i2cs_hs : i1, out i2cs_sbyte : i1, in %i2cs_work : i1, out intr_edge : i1, out nss_toggle : i1, in %paddr : i32, in %penable : i1, out prdata : i32, in %psel : i1, in %pwdata : i32, in %pwrite : i1, in %rst_n : i1, in %rx_data_cnt : i5, out rx_dma_en : i1, out rx_dma_th : i5, in %rx_empty : i1, out rx_empty_clr : i1, in %rx_empty_intr : i1, out rx_fifo_en : i1, out rx_fifo_th : i2, in %rx_full : i1, out rx_full_clr : i1, in %rx_full_intr : i1, in %rx_rd_data : i16, out rx_read_err_clr : i1, in %rx_read_err_intr : i1, out rx_ren : i1, out rx_thold_clr : i1, in %rx_thold_intr : i1, out rx_write_err_clr : i1, in %rx_write_err_intr : i1, in %rxd_work : i1, out sdata_en : i1, out spi_data_size : i4, out spi_en : i1, out spi_intr_en : i1, out spi_rx_en : i1, out spi_stop_clr : i1, in %spi_stop_intr : i1, out spi_tx_en : i1, in %spi_work : i1, out spim_en : i1, out spis_en : i1, in %tx_data_cnt : i5, out tx_dma_en : i1, out tx_dma_th : i5, in %tx_empty : i1, out tx_empty_clr : i1, in %tx_empty_intr : i1, out tx_fifo_en : i1, out tx_fifo_th : i2, in %tx_full : i1, out tx_full_clr : i1, in %tx_full_intr : i1, out tx_read_err_clr : i1, in %tx_read_err_intr : i1, out tx_thold_clr : i1, in %tx_thold_intr : i1, out tx_wen : i1, out tx_write_err_clr : i1, in %tx_write_err_intr : i1, in %txd_work : i1, out uart_dbit : i2, out uart_div : i24, out uart_en : i1, out uart_eps : i1, out uart_intr_en : i2, out uart_pbit : i2, out uart_pen : i1, out uart_perr_clr : i1, in %uart_perr_intr : i1, out uart_stop_clr : i1, in %uart_stop_intr : i1, out usi_ctrl : i4, out usi_intr : i1, out wr_clk_div : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %c0_i9 = hw.constant 0 : i9
    %c0_i10 = hw.constant 0 : i10
    %c7_i4 = hw.constant 7 : i4
    %c3_i4 = hw.constant 3 : i4
    %c-2_i2 = hw.constant -2 : i2
    %c96_i12 = hw.constant 96 : i12
    %c8_i5 = hw.constant 8 : i5
    %c0_i18 = hw.constant 0 : i18
    %c1_i2 = hw.constant 1 : i2
    %c7_i9 = hw.constant 7 : i9
    %c5_i8 = hw.constant 5 : i8
    %false = hw.constant false
    %c1_i3 = hw.constant 1 : i3
    %c0_i5 = hw.constant 0 : i5
    %c307_i10 = hw.constant 307 : i10
    %true = hw.constant true
    %c3_i6 = hw.constant 3 : i6
    %c48_i24 = hw.constant 48 : i24
    %c32_i24 = hw.constant 32 : i24
    %c0_i2 = hw.constant 0 : i2
    %c0_i4 = hw.constant 0 : i4
    %c0_i19 = hw.constant 0 : i19
    %c104_i12 = hw.constant 104 : i12
    %c100_i12 = hw.constant 100 : i12
    %c92_i12 = hw.constant 92 : i12
    %c88_i12 = hw.constant 88 : i12
    %c84_i12 = hw.constant 84 : i12
    %c0_i14 = hw.constant 0 : i14
    %c80_i12 = hw.constant 80 : i12
    %c0_i15 = hw.constant 0 : i15
    %c76_i12 = hw.constant 76 : i12
    %c72_i12 = hw.constant 72 : i12
    %c68_i12 = hw.constant 68 : i12
    %c64_i12 = hw.constant 64 : i12
    %c0_i6 = hw.constant 0 : i6
    %c0_i23 = hw.constant 0 : i23
    %c60_i12 = hw.constant 60 : i12
    %c56_i12 = hw.constant 56 : i12
    %c0_i24 = hw.constant 0 : i24
    %c52_i12 = hw.constant 52 : i12
    %c48_i12 = hw.constant 48 : i12
    %c0_i29 = hw.constant 0 : i29
    %c44_i12 = hw.constant 44 : i12
    %c0_i27 = hw.constant 0 : i27
    %c40_i12 = hw.constant 40 : i12
    %c0_i22 = hw.constant 0 : i22
    %c36_i12 = hw.constant 36 : i12
    %c0_i31 = hw.constant 0 : i31
    %c32_i12 = hw.constant 32 : i12
    %c28_i12 = hw.constant 28 : i12
    %c0_i26 = hw.constant 0 : i26
    %c24_i12 = hw.constant 24 : i12
    %c20_i12 = hw.constant 20 : i12
    %c0_i8 = hw.constant 0 : i8
    %c16_i12 = hw.constant 16 : i12
    %c0_i3 = hw.constant 0 : i3
    %c0_i11 = hw.constant 0 : i11
    %c12_i12 = hw.constant 12 : i12
    %c0_i16 = hw.constant 0 : i16
    %c8_i12 = hw.constant 8 : i12
    %c0_i30 = hw.constant 0 : i30
    %c4_i12 = hw.constant 4 : i12
    %c0_i28 = hw.constant 0 : i28
    %c0_i12 = hw.constant 0 : i12
    %c0_i32 = hw.constant 0 : i32
    %clk_div0 = llhd.sig %c0_i24 : i24
    %clk_div1 = llhd.sig %c0_i24 : i24
    %dma_ctrl = llhd.sig %c0_i2 : i2
    %i2c_addr = llhd.sig %c0_i10 : i10
    %i2c_en = llhd.sig %false : i1
    %i2c_fs_div = llhd.sig %c0_i8 : i8
    %i2c_hold = llhd.sig %c0_i8 : i8
    %i2c_mode = llhd.sig %false : i1
    %i2cm_code = llhd.sig %c0_i3 : i3
    %i2cm_ctrl = llhd.sig %c0_i5 : i5
    %i2cm_en = llhd.sig %false : i1
    %i2cs_ctrl = llhd.sig %false : i1
    %i2cs_en = llhd.sig %false : i1
    %intr_edge = llhd.sig %false : i1
    %intr_en = llhd.sig %c0_i18 : i18
    %intr_mask = llhd.sig %c0_i18 : i18
    %mode_sel = llhd.sig %c0_i2 : i2
    %prdata = llhd.sig %c0_i32 : i32
    %rx_dma_th = llhd.sig %c0_i5 : i5
    %rx_fifo_th = llhd.sig %c0_i2 : i2
    %spi_ctrl = llhd.sig %c0_i9 : i9
    %spi_en = llhd.sig %false : i1
    %spi_mode = llhd.sig %false : i1
    %spim_en = llhd.sig %false : i1
    %spis_en = llhd.sig %false : i1
    %tx_dma_th = llhd.sig %c0_i5 : i5
    %tx_fifo_th = llhd.sig %c0_i2 : i2
    %uart_ctrl = llhd.sig %c0_i6 : i6
    %uart_en = llhd.sig %false : i1
    %usi_ctrl = llhd.sig %c0_i4 : i4
    %apb_ren = llhd.sig %false : i1
    %apb_wen = llhd.sig %false : i1
    %clk_0 = llhd.sig name "clk" %false : i1
    %2 = llhd.prb %clk_0 : i1
    %fifo_intr_en = llhd.sig %c0_i10 : i10
    %i2c_hcnt = llhd.sig %c0_i24 : i24
    %i2c_intr_en = llhd.sig %c0_i5 : i5
    %i2c_lcnt = llhd.sig %c0_i24 : i24
    %i2cm_data_1 = llhd.sig name "i2cm_data" %false : i1
    %i2cm_work_2 = llhd.sig name "i2cm_work" %false : i1
    %i2cs_work_3 = llhd.sig name "i2cs_work" %false : i1
    %intr_sta = llhd.sig %c0_i18 : i18
    %paddr_4 = llhd.sig name "paddr" %c0_i32 : i32
    %pwdata_5 = llhd.sig name "pwdata" %c0_i32 : i32
    %raw_intr_sta = llhd.sig %c0_i18 : i18
    %rst_n_6 = llhd.sig name "rst_n" %false : i1
    %3 = llhd.prb %rst_n_6 : i1
    %rx_data_cnt_7 = llhd.sig name "rx_data_cnt" %c0_i5 : i5
    %rx_empty_8 = llhd.sig name "rx_empty" %false : i1
    %rx_full_9 = llhd.sig name "rx_full" %false : i1
    %rx_rd_data_10 = llhd.sig name "rx_rd_data" %c0_i16 : i16
    %rxd_work_11 = llhd.sig name "rxd_work" %false : i1
    %spi_data_size = llhd.sig %c0_i4 : i4
    %spi_work_12 = llhd.sig name "spi_work" %false : i1
    %tx_data_cnt_13 = llhd.sig name "tx_data_cnt" %c0_i5 : i5
    %tx_empty_14 = llhd.sig name "tx_empty" %false : i1
    %tx_full_15 = llhd.sig name "tx_full" %false : i1
    %txd_work_16 = llhd.sig name "txd_work" %false : i1
    %uart_dbit = llhd.sig %c0_i2 : i2
    %uart_div = llhd.sig %c0_i24 : i24
    %uart_intr_en = llhd.sig %c0_i2 : i2
    %uart_pbit = llhd.sig %c0_i2 : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 31 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb7, ^bb9, ^bb11, ^bb13, ^bb15, ^bb17, ^bb19, ^bb21, ^bb23, ^bb25, ^bb27, ^bb29, ^bb31, ^bb33, ^bb35, ^bb37, ^bb39, ^bb41, ^bb43, ^bb45, ^bb47, ^bb49, ^bb51, ^bb53, ^bb55, ^bb57, ^bb58
      %134 = llhd.prb %clk_0 : i1
      %135 = llhd.prb %rst_n_6 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %136 = llhd.prb %clk_0 : i1
      %137 = comb.xor bin %134, %true : i1
      %138 = comb.and bin %137, %136 : i1
      %139 = llhd.prb %rst_n_6 : i1
      %140 = comb.xor bin %139, %true : i1
      %141 = comb.and bin %135, %140 : i1
      %142 = comb.or bin %138, %141 : i1
      cf.cond_br %142, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %143 = llhd.prb %rst_n_6 : i1
      %144 = comb.xor %143, %true : i1
      cf.cond_br %144, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %prdata, %c0_i32 after %1 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %145 = llhd.prb %apb_ren : i1
      cf.cond_br %145, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %146 = llhd.prb %paddr_4 : i32
      %147 = comb.extract %146 from 0 : (i32) -> i12
      %148 = comb.icmp ceq %147, %c0_i12 : i12
      cf.cond_br %148, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %149 = llhd.prb %usi_ctrl : i4
      %150 = comb.concat %c0_i28, %149 : i28, i4
      llhd.drv %prdata, %150 after %1 : i32
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %151 = comb.icmp ceq %147, %c4_i12 : i12
      cf.cond_br %151, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %152 = llhd.prb %mode_sel : i2
      %153 = comb.concat %c0_i30, %152 : i30, i2
      llhd.drv %prdata, %153 after %1 : i32
      cf.br ^bb1
    ^bb10:  // pred: ^bb8
      %154 = comb.icmp ceq %147, %c8_i12 : i12
      cf.cond_br %154, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %155 = llhd.prb %rx_rd_data_10 : i16
      %156 = comb.concat %c0_i16, %155 : i16, i16
      llhd.drv %prdata, %156 after %1 : i32
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      %157 = comb.icmp ceq %147, %c12_i12 : i12
      cf.cond_br %157, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      %158 = llhd.prb %rx_data_cnt_7 : i5
      %159 = llhd.prb %tx_data_cnt_13 : i5
      %160 = llhd.prb %rx_full_9 : i1
      %161 = llhd.prb %rx_empty_8 : i1
      %162 = llhd.prb %tx_full_15 : i1
      %163 = llhd.prb %tx_empty_14 : i1
      %164 = comb.concat %c0_i11, %158, %c0_i3, %159, %c0_i4, %160, %161, %162, %163 : i11, i5, i3, i5, i4, i1, i1, i1, i1
      llhd.drv %prdata, %164 after %1 : i32
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      %165 = comb.icmp ceq %147, %c16_i12 : i12
      cf.cond_br %165, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      %166 = llhd.prb %clk_div0 : i24
      %167 = comb.concat %c0_i8, %166 : i8, i24
      llhd.drv %prdata, %167 after %1 : i32
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      %168 = comb.icmp ceq %147, %c20_i12 : i12
      cf.cond_br %168, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      %169 = llhd.prb %clk_div1 : i24
      %170 = comb.concat %c0_i8, %169 : i8, i24
      llhd.drv %prdata, %170 after %1 : i32
      cf.br ^bb1
    ^bb18:  // pred: ^bb16
      %171 = comb.icmp ceq %147, %c24_i12 : i12
      cf.cond_br %171, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %172 = llhd.prb %uart_ctrl : i6
      %173 = comb.concat %c0_i26, %172 : i26, i6
      llhd.drv %prdata, %173 after %1 : i32
      cf.br ^bb1
    ^bb20:  // pred: ^bb18
      %174 = comb.icmp ceq %147, %c28_i12 : i12
      cf.cond_br %174, ^bb21, ^bb22
    ^bb21:  // pred: ^bb20
      %175 = llhd.prb %rxd_work_11 : i1
      %176 = llhd.prb %txd_work_16 : i1
      %177 = comb.concat %c0_i30, %175, %176 : i30, i1, i1
      llhd.drv %prdata, %177 after %1 : i32
      cf.br ^bb1
    ^bb22:  // pred: ^bb20
      %178 = comb.icmp ceq %147, %c32_i12 : i12
      cf.cond_br %178, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      %179 = llhd.prb %i2c_mode : i1
      %180 = comb.concat %c0_i31, %179 : i31, i1
      llhd.drv %prdata, %180 after %1 : i32
      cf.br ^bb1
    ^bb24:  // pred: ^bb22
      %181 = comb.icmp ceq %147, %c36_i12 : i12
      cf.cond_br %181, ^bb25, ^bb26
    ^bb25:  // pred: ^bb24
      %182 = llhd.prb %i2c_addr : i10
      %183 = comb.concat %c0_i22, %182 : i22, i10
      llhd.drv %prdata, %183 after %1 : i32
      cf.br ^bb1
    ^bb26:  // pred: ^bb24
      %184 = comb.icmp ceq %147, %c40_i12 : i12
      cf.cond_br %184, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      %185 = llhd.prb %i2cm_ctrl : i5
      %186 = comb.concat %c0_i27, %185 : i27, i5
      llhd.drv %prdata, %186 after %1 : i32
      cf.br ^bb1
    ^bb28:  // pred: ^bb26
      %187 = comb.icmp ceq %147, %c44_i12 : i12
      cf.cond_br %187, ^bb29, ^bb30
    ^bb29:  // pred: ^bb28
      %188 = llhd.prb %i2cm_code : i3
      %189 = comb.concat %c0_i29, %188 : i29, i3
      llhd.drv %prdata, %189 after %1 : i32
      cf.br ^bb1
    ^bb30:  // pred: ^bb28
      %190 = comb.icmp ceq %147, %c48_i12 : i12
      cf.cond_br %190, ^bb31, ^bb32
    ^bb31:  // pred: ^bb30
      %191 = llhd.prb %i2cs_ctrl : i1
      %192 = comb.concat %c0_i31, %191 : i31, i1
      llhd.drv %prdata, %192 after %1 : i32
      cf.br ^bb1
    ^bb32:  // pred: ^bb30
      %193 = comb.icmp ceq %147, %c52_i12 : i12
      cf.cond_br %193, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      %194 = llhd.prb %i2c_fs_div : i8
      %195 = comb.concat %c0_i24, %194 : i24, i8
      llhd.drv %prdata, %195 after %1 : i32
      cf.br ^bb1
    ^bb34:  // pred: ^bb32
      %196 = comb.icmp ceq %147, %c56_i12 : i12
      cf.cond_br %196, ^bb35, ^bb36
    ^bb35:  // pred: ^bb34
      %197 = llhd.prb %i2c_hold : i8
      %198 = comb.concat %c0_i24, %197 : i24, i8
      llhd.drv %prdata, %198 after %1 : i32
      cf.br ^bb1
    ^bb36:  // pred: ^bb34
      %199 = comb.icmp ceq %147, %c60_i12 : i12
      cf.cond_br %199, ^bb37, ^bb38
    ^bb37:  // pred: ^bb36
      %200 = llhd.prb %i2cs_work_3 : i1
      %201 = llhd.prb %i2cm_data_1 : i1
      %202 = llhd.prb %i2cm_work_2 : i1
      %203 = comb.concat %c0_i23, %200, %c0_i6, %201, %202 : i23, i1, i6, i1, i1
      llhd.drv %prdata, %203 after %1 : i32
      cf.br ^bb1
    ^bb38:  // pred: ^bb36
      %204 = comb.icmp ceq %147, %c64_i12 : i12
      cf.cond_br %204, ^bb39, ^bb40
    ^bb39:  // pred: ^bb38
      %205 = llhd.prb %spi_mode : i1
      %206 = comb.concat %c0_i31, %205 : i31, i1
      llhd.drv %prdata, %206 after %1 : i32
      cf.br ^bb1
    ^bb40:  // pred: ^bb38
      %207 = comb.icmp ceq %147, %c68_i12 : i12
      cf.cond_br %207, ^bb41, ^bb42
    ^bb41:  // pred: ^bb40
      %208 = llhd.prb %spi_ctrl : i9
      %209 = comb.concat %c0_i23, %208 : i23, i9
      llhd.drv %prdata, %209 after %1 : i32
      cf.br ^bb1
    ^bb42:  // pred: ^bb40
      %210 = comb.icmp ceq %147, %c72_i12 : i12
      cf.cond_br %210, ^bb43, ^bb44
    ^bb43:  // pred: ^bb42
      %211 = llhd.prb %spi_work_12 : i1
      %212 = comb.concat %c0_i31, %211 : i31, i1
      llhd.drv %prdata, %212 after %1 : i32
      cf.br ^bb1
    ^bb44:  // pred: ^bb42
      %213 = comb.icmp ceq %147, %c76_i12 : i12
      cf.cond_br %213, ^bb45, ^bb46
    ^bb45:  // pred: ^bb44
      %214 = llhd.prb %intr_edge : i1
      %215 = llhd.prb %rx_fifo_th : i2
      %216 = llhd.prb %tx_fifo_th : i2
      %217 = comb.concat %c0_i15, %214, %c0_i6, %215, %c0_i6, %216 : i15, i1, i6, i2, i6, i2
      llhd.drv %prdata, %217 after %1 : i32
      cf.br ^bb1
    ^bb46:  // pred: ^bb44
      %218 = comb.icmp ceq %147, %c80_i12 : i12
      cf.cond_br %218, ^bb47, ^bb48
    ^bb47:  // pred: ^bb46
      %219 = llhd.prb %intr_en : i18
      %220 = comb.concat %c0_i14, %219 : i14, i18
      llhd.drv %prdata, %220 after %1 : i32
      cf.br ^bb1
    ^bb48:  // pred: ^bb46
      %221 = comb.icmp ceq %147, %c84_i12 : i12
      cf.cond_br %221, ^bb49, ^bb50
    ^bb49:  // pred: ^bb48
      %222 = llhd.prb %intr_sta : i18
      %223 = comb.concat %c0_i14, %222 : i14, i18
      llhd.drv %prdata, %223 after %1 : i32
      cf.br ^bb1
    ^bb50:  // pred: ^bb48
      %224 = comb.icmp ceq %147, %c88_i12 : i12
      cf.cond_br %224, ^bb51, ^bb52
    ^bb51:  // pred: ^bb50
      %225 = llhd.prb %raw_intr_sta : i18
      %226 = comb.concat %c0_i14, %225 : i14, i18
      llhd.drv %prdata, %226 after %1 : i32
      cf.br ^bb1
    ^bb52:  // pred: ^bb50
      %227 = comb.icmp ceq %147, %c92_i12 : i12
      cf.cond_br %227, ^bb53, ^bb54
    ^bb53:  // pred: ^bb52
      %228 = llhd.prb %intr_mask : i18
      %229 = comb.concat %c0_i14, %228 : i14, i18
      llhd.drv %prdata, %229 after %1 : i32
      cf.br ^bb1
    ^bb54:  // pred: ^bb52
      %230 = comb.icmp ceq %147, %c100_i12 : i12
      cf.cond_br %230, ^bb55, ^bb56
    ^bb55:  // pred: ^bb54
      %231 = llhd.prb %dma_ctrl : i2
      %232 = comb.concat %c0_i30, %231 : i30, i2
      llhd.drv %prdata, %232 after %1 : i32
      cf.br ^bb1
    ^bb56:  // pred: ^bb54
      %233 = comb.icmp ceq %147, %c104_i12 : i12
      cf.cond_br %233, ^bb57, ^bb58
    ^bb57:  // pred: ^bb56
      %234 = llhd.prb %rx_dma_th : i5
      %235 = llhd.prb %tx_dma_th : i5
      %236 = comb.concat %c0_i19, %234, %c0_i3, %235 : i19, i5, i3, i5
      llhd.drv %prdata, %236 after %1 : i32
      cf.br ^bb1
    ^bb58:  // pred: ^bb56
      llhd.drv %prdata, %c0_i32 after %1 : i32
      cf.br ^bb1
    }
    %4 = comb.concat %spi_stop_intr, %i2c_aerr_intr, %i2cs_gcall_intr, %i2cm_lose_arbi_intr, %i2c_nack_intr, %i2c_stop_intr, %uart_perr_intr, %uart_stop_intr, %rx_write_err_intr, %rx_read_err_intr, %rx_full_intr, %rx_empty_intr, %rx_thold_intr, %tx_write_err_intr, %tx_read_err_intr, %tx_full_intr, %tx_empty_intr, %tx_thold_intr : i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1
    llhd.drv %raw_intr_sta, %4 after %0 : i18
    %5 = llhd.prb %raw_intr_sta : i18
    %6 = llhd.prb %intr_mask : i18
    %7 = comb.and %5, %6 : i18
    llhd.drv %intr_sta, %7 after %0 : i18
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb41, ^bb42
      %134 = llhd.prb %clk_0 : i1
      %135 = llhd.prb %rst_n_6 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %136 = llhd.prb %clk_0 : i1
      %137 = comb.xor bin %134, %true : i1
      %138 = comb.and bin %137, %136 : i1
      %139 = llhd.prb %rst_n_6 : i1
      %140 = comb.xor bin %139, %true : i1
      %141 = comb.and bin %135, %140 : i1
      %142 = comb.or bin %138, %141 : i1
      cf.cond_br %142, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %143 = llhd.prb %rst_n_6 : i1
      %144 = comb.xor %143, %true : i1
      cf.cond_br %144, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %usi_ctrl, %c0_i4 after %1 : i4
      llhd.drv %mode_sel, %c0_i2 after %1 : i2
      llhd.drv %clk_div0, %c32_i24 after %1 : i24
      llhd.drv %clk_div1, %c48_i24 after %1 : i24
      llhd.drv %uart_ctrl, %c3_i6 after %1 : i6
      llhd.drv %i2c_mode, %true after %1 : i1
      llhd.drv %i2c_addr, %c307_i10 after %1 : i10
      llhd.drv %i2cm_ctrl, %c0_i5 after %1 : i5
      llhd.drv %i2cm_code, %c1_i3 after %1 : i3
      llhd.drv %i2cs_ctrl, %false after %1 : i1
      llhd.drv %i2c_fs_div, %c5_i8 after %1 : i8
      llhd.drv %i2c_hold, %c5_i8 after %1 : i8
      llhd.drv %spi_mode, %true after %1 : i1
      llhd.drv %spi_ctrl, %c7_i9 after %1 : i9
      llhd.drv %intr_edge, %false after %1 : i1
      llhd.drv %tx_fifo_th, %c1_i2 after %1 : i2
      llhd.drv %rx_fifo_th, %c1_i2 after %1 : i2
      llhd.drv %intr_en, %c0_i18 after %1 : i18
      llhd.drv %intr_mask, %c0_i18 after %1 : i18
      llhd.drv %dma_ctrl, %c0_i2 after %1 : i2
      llhd.drv %rx_dma_th, %c8_i5 after %1 : i5
      llhd.drv %tx_dma_th, %c8_i5 after %1 : i5
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %145 = llhd.prb %apb_wen : i1
      %146 = llhd.prb %paddr_4 : i32
      %147 = comb.extract %146 from 0 : (i32) -> i12
      %148 = comb.icmp eq %147, %c0_i12 : i12
      %149 = comb.and %145, %148 : i1
      cf.cond_br %149, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %150 = llhd.prb %pwdata_5 : i32
      %151 = comb.extract %150 from 0 : (i32) -> i4
      llhd.drv %usi_ctrl, %151 after %1 : i4
      cf.br ^bb7
    ^bb7:  // 2 preds: ^bb5, ^bb6
      %152 = llhd.prb %apb_wen : i1
      %153 = llhd.prb %paddr_4 : i32
      %154 = comb.extract %153 from 0 : (i32) -> i12
      %155 = comb.icmp eq %154, %c4_i12 : i12
      %156 = comb.and %152, %155 : i1
      cf.cond_br %156, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %157 = llhd.prb %pwdata_5 : i32
      %158 = comb.extract %157 from 0 : (i32) -> i2
      llhd.drv %mode_sel, %158 after %1 : i2
      cf.br ^bb9
    ^bb9:  // 2 preds: ^bb7, ^bb8
      %159 = llhd.prb %apb_wen : i1
      %160 = llhd.prb %paddr_4 : i32
      %161 = comb.extract %160 from 0 : (i32) -> i12
      %162 = comb.icmp eq %161, %c16_i12 : i12
      %163 = comb.and %159, %162 : i1
      cf.cond_br %163, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %164 = llhd.prb %pwdata_5 : i32
      %165 = comb.extract %164 from 0 : (i32) -> i24
      llhd.drv %clk_div0, %165 after %1 : i24
      cf.br ^bb11
    ^bb11:  // 2 preds: ^bb9, ^bb10
      %166 = llhd.prb %apb_wen : i1
      %167 = llhd.prb %paddr_4 : i32
      %168 = comb.extract %167 from 0 : (i32) -> i12
      %169 = comb.icmp eq %168, %c20_i12 : i12
      %170 = comb.and %166, %169 : i1
      cf.cond_br %170, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %171 = llhd.prb %pwdata_5 : i32
      %172 = comb.extract %171 from 0 : (i32) -> i24
      llhd.drv %clk_div1, %172 after %1 : i24
      cf.br ^bb13
    ^bb13:  // 2 preds: ^bb11, ^bb12
      %173 = llhd.prb %apb_wen : i1
      %174 = llhd.prb %paddr_4 : i32
      %175 = comb.extract %174 from 0 : (i32) -> i12
      %176 = comb.icmp eq %175, %c24_i12 : i12
      %177 = comb.and %173, %176 : i1
      cf.cond_br %177, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %178 = llhd.prb %pwdata_5 : i32
      %179 = comb.extract %178 from 0 : (i32) -> i6
      llhd.drv %uart_ctrl, %179 after %1 : i6
      cf.br ^bb15
    ^bb15:  // 2 preds: ^bb13, ^bb14
      %180 = llhd.prb %apb_wen : i1
      %181 = llhd.prb %paddr_4 : i32
      %182 = comb.extract %181 from 0 : (i32) -> i12
      %183 = comb.icmp eq %182, %c32_i12 : i12
      %184 = comb.and %180, %183 : i1
      cf.cond_br %184, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %185 = llhd.prb %pwdata_5 : i32
      %186 = comb.extract %185 from 0 : (i32) -> i1
      llhd.drv %i2c_mode, %186 after %1 : i1
      cf.br ^bb17
    ^bb17:  // 2 preds: ^bb15, ^bb16
      %187 = llhd.prb %apb_wen : i1
      %188 = llhd.prb %paddr_4 : i32
      %189 = comb.extract %188 from 0 : (i32) -> i12
      %190 = comb.icmp eq %189, %c36_i12 : i12
      %191 = comb.and %187, %190 : i1
      cf.cond_br %191, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      %192 = llhd.prb %pwdata_5 : i32
      %193 = comb.extract %192 from 0 : (i32) -> i10
      llhd.drv %i2c_addr, %193 after %1 : i10
      cf.br ^bb19
    ^bb19:  // 2 preds: ^bb17, ^bb18
      %194 = llhd.prb %apb_wen : i1
      %195 = llhd.prb %paddr_4 : i32
      %196 = comb.extract %195 from 0 : (i32) -> i12
      %197 = comb.icmp eq %196, %c40_i12 : i12
      %198 = comb.and %194, %197 : i1
      cf.cond_br %198, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %199 = llhd.prb %pwdata_5 : i32
      %200 = comb.extract %199 from 0 : (i32) -> i5
      llhd.drv %i2cm_ctrl, %200 after %1 : i5
      cf.br ^bb21
    ^bb21:  // 2 preds: ^bb19, ^bb20
      %201 = llhd.prb %apb_wen : i1
      %202 = llhd.prb %paddr_4 : i32
      %203 = comb.extract %202 from 0 : (i32) -> i12
      %204 = comb.icmp eq %203, %c44_i12 : i12
      %205 = comb.and %201, %204 : i1
      cf.cond_br %205, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      %206 = llhd.prb %pwdata_5 : i32
      %207 = comb.extract %206 from 0 : (i32) -> i3
      llhd.drv %i2cm_code, %207 after %1 : i3
      cf.br ^bb23
    ^bb23:  // 2 preds: ^bb21, ^bb22
      %208 = llhd.prb %apb_wen : i1
      %209 = llhd.prb %paddr_4 : i32
      %210 = comb.extract %209 from 0 : (i32) -> i12
      %211 = comb.icmp eq %210, %c48_i12 : i12
      %212 = comb.and %208, %211 : i1
      cf.cond_br %212, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %213 = llhd.prb %pwdata_5 : i32
      %214 = comb.extract %213 from 0 : (i32) -> i1
      llhd.drv %i2cs_ctrl, %214 after %1 : i1
      cf.br ^bb25
    ^bb25:  // 2 preds: ^bb23, ^bb24
      %215 = llhd.prb %apb_wen : i1
      %216 = llhd.prb %paddr_4 : i32
      %217 = comb.extract %216 from 0 : (i32) -> i12
      %218 = comb.icmp eq %217, %c56_i12 : i12
      %219 = comb.and %215, %218 : i1
      cf.cond_br %219, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      %220 = llhd.prb %pwdata_5 : i32
      %221 = comb.extract %220 from 0 : (i32) -> i8
      llhd.drv %i2c_hold, %221 after %1 : i8
      cf.br ^bb27
    ^bb27:  // 2 preds: ^bb25, ^bb26
      %222 = llhd.prb %apb_wen : i1
      %223 = llhd.prb %paddr_4 : i32
      %224 = comb.extract %223 from 0 : (i32) -> i12
      %225 = comb.icmp eq %224, %c52_i12 : i12
      %226 = comb.and %222, %225 : i1
      cf.cond_br %226, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      %227 = llhd.prb %pwdata_5 : i32
      %228 = comb.extract %227 from 0 : (i32) -> i8
      llhd.drv %i2c_fs_div, %228 after %1 : i8
      cf.br ^bb29
    ^bb29:  // 2 preds: ^bb27, ^bb28
      %229 = llhd.prb %apb_wen : i1
      %230 = llhd.prb %paddr_4 : i32
      %231 = comb.extract %230 from 0 : (i32) -> i12
      %232 = comb.icmp eq %231, %c64_i12 : i12
      %233 = comb.and %229, %232 : i1
      cf.cond_br %233, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %234 = llhd.prb %pwdata_5 : i32
      %235 = comb.extract %234 from 0 : (i32) -> i1
      llhd.drv %spi_mode, %235 after %1 : i1
      cf.br ^bb31
    ^bb31:  // 2 preds: ^bb29, ^bb30
      %236 = llhd.prb %apb_wen : i1
      %237 = llhd.prb %paddr_4 : i32
      %238 = comb.extract %237 from 0 : (i32) -> i12
      %239 = comb.icmp eq %238, %c68_i12 : i12
      %240 = comb.and %236, %239 : i1
      cf.cond_br %240, ^bb32, ^bb33
    ^bb32:  // pred: ^bb31
      %241 = llhd.prb %pwdata_5 : i32
      %242 = comb.extract %241 from 0 : (i32) -> i9
      llhd.drv %spi_ctrl, %242 after %1 : i9
      cf.br ^bb33
    ^bb33:  // 2 preds: ^bb31, ^bb32
      %243 = llhd.prb %apb_wen : i1
      %244 = llhd.prb %paddr_4 : i32
      %245 = comb.extract %244 from 0 : (i32) -> i12
      %246 = comb.icmp eq %245, %c76_i12 : i12
      %247 = comb.and %243, %246 : i1
      cf.cond_br %247, ^bb34, ^bb35
    ^bb34:  // pred: ^bb33
      %248 = llhd.prb %pwdata_5 : i32
      %249 = comb.extract %248 from 16 : (i32) -> i1
      llhd.drv %intr_edge, %249 after %1 : i1
      %250 = llhd.prb %pwdata_5 : i32
      %251 = comb.extract %250 from 8 : (i32) -> i2
      llhd.drv %rx_fifo_th, %251 after %1 : i2
      %252 = llhd.prb %pwdata_5 : i32
      %253 = comb.extract %252 from 0 : (i32) -> i2
      llhd.drv %tx_fifo_th, %253 after %1 : i2
      cf.br ^bb35
    ^bb35:  // 2 preds: ^bb33, ^bb34
      %254 = llhd.prb %apb_wen : i1
      %255 = llhd.prb %paddr_4 : i32
      %256 = comb.extract %255 from 0 : (i32) -> i12
      %257 = comb.icmp eq %256, %c80_i12 : i12
      %258 = comb.and %254, %257 : i1
      cf.cond_br %258, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      %259 = llhd.prb %pwdata_5 : i32
      %260 = comb.extract %259 from 0 : (i32) -> i18
      llhd.drv %intr_en, %260 after %1 : i18
      cf.br ^bb37
    ^bb37:  // 2 preds: ^bb35, ^bb36
      %261 = llhd.prb %apb_wen : i1
      %262 = llhd.prb %paddr_4 : i32
      %263 = comb.extract %262 from 0 : (i32) -> i12
      %264 = comb.icmp eq %263, %c92_i12 : i12
      %265 = comb.and %261, %264 : i1
      cf.cond_br %265, ^bb38, ^bb39
    ^bb38:  // pred: ^bb37
      %266 = llhd.prb %pwdata_5 : i32
      %267 = comb.extract %266 from 0 : (i32) -> i18
      llhd.drv %intr_mask, %267 after %1 : i18
      cf.br ^bb39
    ^bb39:  // 2 preds: ^bb37, ^bb38
      %268 = llhd.prb %apb_wen : i1
      %269 = llhd.prb %paddr_4 : i32
      %270 = comb.extract %269 from 0 : (i32) -> i12
      %271 = comb.icmp eq %270, %c100_i12 : i12
      %272 = comb.and %268, %271 : i1
      cf.cond_br %272, ^bb40, ^bb41
    ^bb40:  // pred: ^bb39
      %273 = llhd.prb %pwdata_5 : i32
      %274 = comb.extract %273 from 0 : (i32) -> i2
      llhd.drv %dma_ctrl, %274 after %1 : i2
      cf.br ^bb41
    ^bb41:  // 2 preds: ^bb39, ^bb40
      %275 = llhd.prb %apb_wen : i1
      %276 = llhd.prb %paddr_4 : i32
      %277 = comb.extract %276 from 0 : (i32) -> i12
      %278 = comb.icmp eq %277, %c104_i12 : i12
      %279 = comb.and %275, %278 : i1
      cf.cond_br %279, ^bb42, ^bb1
    ^bb42:  // pred: ^bb41
      %280 = llhd.prb %pwdata_5 : i32
      %281 = comb.extract %280 from 8 : (i32) -> i5
      llhd.drv %rx_dma_th, %281 after %1 : i5
      %282 = llhd.prb %pwdata_5 : i32
      %283 = comb.extract %282 from 0 : (i32) -> i5
      llhd.drv %tx_dma_th, %283 after %1 : i5
      cf.br ^bb1
    }
    %8 = comb.xor %penable, %true : i1
    %9 = comb.and %psel, %pwrite, %8 : i1
    llhd.drv %apb_wen, %9 after %0 : i1
    %10 = comb.xor %pwrite, %true : i1
    %11 = comb.and %psel, %10, %8 : i1
    llhd.drv %apb_ren, %11 after %0 : i1
    %12 = llhd.prb %apb_wen : i1
    %13 = llhd.prb %paddr_4 : i32
    %14 = comb.extract %13 from 0 : (i32) -> i12
    %15 = comb.icmp eq %14, %c96_i12 : i12
    %16 = comb.and %12, %15 {sv.namehint = "intr_clr"} : i1
    %17 = llhd.prb %pwdata_5 : i32
    %18 = comb.extract %17 from 17 : (i32) -> i1
    %19 = comb.and %16, %18 : i1
    %20 = comb.extract %17 from 16 : (i32) -> i1
    %21 = comb.and %16, %20 : i1
    %22 = comb.extract %17 from 15 : (i32) -> i1
    %23 = comb.and %16, %22 : i1
    %24 = comb.extract %17 from 14 : (i32) -> i1
    %25 = comb.and %16, %24 : i1
    %26 = comb.extract %17 from 13 : (i32) -> i1
    %27 = comb.and %16, %26 : i1
    %28 = comb.extract %17 from 12 : (i32) -> i1
    %29 = comb.and %16, %28 : i1
    %30 = comb.extract %17 from 11 : (i32) -> i1
    %31 = comb.and %16, %30 : i1
    %32 = comb.extract %17 from 10 : (i32) -> i1
    %33 = comb.and %16, %32 : i1
    %34 = comb.extract %17 from 9 : (i32) -> i1
    %35 = comb.and %16, %34 : i1
    %36 = comb.extract %17 from 8 : (i32) -> i1
    %37 = comb.and %16, %36 : i1
    %38 = comb.extract %17 from 7 : (i32) -> i1
    %39 = comb.and %16, %38 : i1
    %40 = comb.extract %17 from 6 : (i32) -> i1
    %41 = comb.and %16, %40 : i1
    %42 = comb.extract %17 from 5 : (i32) -> i1
    %43 = comb.and %16, %42 : i1
    %44 = comb.extract %17 from 4 : (i32) -> i1
    %45 = comb.and %16, %44 : i1
    %46 = comb.extract %17 from 3 : (i32) -> i1
    %47 = comb.and %16, %46 : i1
    %48 = comb.extract %17 from 2 : (i32) -> i1
    %49 = comb.and %16, %48 : i1
    %50 = comb.extract %17 from 1 : (i32) -> i1
    %51 = comb.and %16, %50 : i1
    %52 = comb.extract %17 from 0 : (i32) -> i1
    %53 = comb.and %16, %52 : i1
    %54 = comb.icmp eq %14, %c16_i12 : i12
    %55 = comb.icmp eq %14, %c20_i12 : i12
    %56 = comb.or %54, %55 : i1
    %57 = comb.and %12, %56 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %134 = llhd.prb %clk_0 : i1
      %135 = llhd.prb %rst_n_6 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %136 = llhd.prb %clk_0 : i1
      %137 = comb.xor bin %134, %true : i1
      %138 = comb.and bin %137, %136 : i1
      %139 = llhd.prb %rst_n_6 : i1
      %140 = comb.xor bin %139, %true : i1
      %141 = comb.and bin %135, %140 : i1
      %142 = comb.or bin %138, %141 : i1
      cf.cond_br %142, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %143 = llhd.prb %rst_n_6 : i1
      %144 = comb.xor %143, %true : i1
      cf.cond_br %144, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %uart_en, %false after %1 : i1
      llhd.drv %i2c_en, %false after %1 : i1
      llhd.drv %spi_en, %false after %1 : i1
      llhd.drv %i2cm_en, %false after %1 : i1
      llhd.drv %i2cs_en, %false after %1 : i1
      llhd.drv %spim_en, %false after %1 : i1
      llhd.drv %spis_en, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %145 = llhd.prb %usi_ctrl : i4
      %146 = comb.extract %145 from 0 : (i4) -> i1
      %147 = comb.extract %145 from 1 : (i4) -> i1
      %148 = llhd.prb %mode_sel : i2
      %149 = comb.icmp eq %148, %c0_i2 : i2
      %150 = comb.and %146, %147, %149 : i1
      llhd.drv %uart_en, %150 after %1 : i1
      %151 = llhd.prb %usi_ctrl : i4
      %152 = comb.extract %151 from 1 : (i4) -> i1
      %153 = comb.extract %151 from 0 : (i4) -> i1
      %154 = llhd.prb %mode_sel : i2
      %155 = comb.icmp eq %154, %c1_i2 : i2
      %156 = comb.and %152, %153, %155 : i1
      llhd.drv %i2c_en, %156 after %1 : i1
      %157 = llhd.prb %usi_ctrl : i4
      %158 = comb.extract %157 from 1 : (i4) -> i1
      %159 = comb.extract %157 from 0 : (i4) -> i1
      %160 = llhd.prb %mode_sel : i2
      %161 = comb.icmp eq %160, %c-2_i2 : i2
      %162 = comb.and %158, %159, %161 : i1
      llhd.drv %spi_en, %162 after %1 : i1
      %163 = llhd.prb %i2c_en : i1
      %164 = llhd.prb %i2c_mode : i1
      %165 = comb.and %163, %164 : i1
      llhd.drv %i2cm_en, %165 after %1 : i1
      %166 = llhd.prb %i2c_en : i1
      %167 = llhd.prb %i2c_mode : i1
      %168 = comb.xor %167, %true : i1
      %169 = comb.and %166, %168 : i1
      llhd.drv %i2cs_en, %169 after %1 : i1
      %170 = llhd.prb %spi_en : i1
      %171 = llhd.prb %spi_mode : i1
      %172 = comb.and %170, %171 : i1
      llhd.drv %spim_en, %172 after %1 : i1
      %173 = llhd.prb %spi_en : i1
      %174 = llhd.prb %spi_mode : i1
      %175 = comb.xor %174, %true : i1
      %176 = comb.and %173, %175 : i1
      llhd.drv %spis_en, %176 after %1 : i1
      cf.br ^bb1
    }
    %58 = llhd.prb %usi_ctrl : i4
    %59 = comb.extract %58 from 1 : (i4) -> i1
    %60 = comb.extract %58 from 0 : (i4) -> i1
    %61 = comb.and %59, %60 : i1
    %62 = comb.extract %58 from 3 : (i4) -> i1
    %63 = comb.and %60, %62 : i1
    %64 = comb.extract %58 from 2 : (i4) -> i1
    %65 = comb.and %60, %64 : i1
    %66 = llhd.prb %uart_ctrl : i6
    %67 = comb.extract %66 from 0 : (i6) -> i2
    llhd.drv %uart_dbit, %67 after %0 : i2
    %68 = comb.extract %66 from 2 : (i6) -> i2
    llhd.drv %uart_pbit, %68 after %0 : i2
    %69 = comb.extract %66 from 4 : (i6) -> i1
    %70 = comb.extract %66 from 5 : (i6) -> i1
    %71 = llhd.prb %clk_div0 : i24
    llhd.drv %uart_div, %71 after %0 : i24
    %72 = llhd.prb %i2cm_ctrl : i5
    %73 = comb.extract %72 from 4 : (i5) -> i1
    %74 = comb.extract %72 from 3 : (i5) -> i1
    %75 = comb.extract %72 from 2 : (i5) -> i1
    %76 = comb.extract %72 from 1 : (i5) -> i1
    %77 = comb.extract %72 from 0 : (i5) -> i1
    %78 = llhd.prb %i2cs_ctrl : i1
    llhd.drv %i2c_hcnt, %71 after %0 : i24
    %79 = llhd.prb %clk_div1 : i24
    llhd.drv %i2c_lcnt, %79 after %0 : i24
    %80 = llhd.prb %spi_ctrl : i9
    %81 = comb.extract %80 from 0 : (i9) -> i4
    %82 = comb.icmp ult %81, %c3_i4 : i4
    %83 = comb.mux %82, %c7_i4, %81 : i4
    llhd.drv %spi_data_size, %83 after %0 : i4
    %84 = comb.extract %80 from 7 : (i9) -> i1
    %85 = comb.extract %80 from 6 : (i9) -> i1
    %86 = comb.extract %80 from 5 : (i9) -> i1
    %87 = comb.xor %86, %true : i1
    %88 = comb.and %87, %60 : i1
    %89 = comb.extract %80 from 4 : (i9) -> i1
    %90 = comb.xor %89, %true : i1
    %91 = comb.and %90, %60 : i1
    %92 = comb.extract %80 from 8 : (i9) -> i1
    %93 = comb.icmp eq %14, %c8_i12 : i12
    %94 = comb.and %12, %93 : i1
    %95 = llhd.prb %apb_ren : i1
    %96 = comb.and %95, %93 : i1
    %97 = llhd.prb %intr_sta : i18
    %98 = comb.icmp ne %97, %c0_i18 : i18
    %99 = llhd.prb %intr_en : i18
    %100 = comb.extract %99 from 17 : (i18) -> i1
    %101 = comb.extract %99 from 12 : (i18) -> i5
    llhd.drv %i2c_intr_en, %101 after %0 : i5
    %102 = comb.extract %99 from 10 : (i18) -> i2
    llhd.drv %uart_intr_en, %102 after %0 : i2
    %103 = comb.extract %99 from 0 : (i18) -> i10
    llhd.drv %fifo_intr_en, %103 after %0 : i10
    %104 = llhd.prb %dma_ctrl : i2
    %105 = comb.extract %104 from 1 : (i2) -> i1
    %106 = comb.extract %104 from 0 : (i2) -> i1
    llhd.drv %clk_0, %clk after %0 : i1
    %107 = llhd.prb %fifo_intr_en : i10
    %108 = llhd.prb %i2c_addr : i10
    %109 = llhd.prb %i2c_en : i1
    %110 = llhd.prb %i2c_fs_div : i8
    %111 = llhd.prb %i2c_hcnt : i24
    %112 = llhd.prb %i2c_hold : i8
    %113 = llhd.prb %i2c_intr_en : i5
    %114 = llhd.prb %i2c_lcnt : i24
    %115 = llhd.prb %i2c_mode : i1
    %116 = llhd.prb %i2cm_code : i3
    llhd.drv %i2cm_data_1, %i2cm_data after %0 : i1
    %117 = llhd.prb %i2cm_en : i1
    llhd.drv %i2cm_work_2, %i2cm_work after %0 : i1
    %118 = llhd.prb %i2cs_en : i1
    llhd.drv %i2cs_work_3, %i2cs_work after %0 : i1
    %119 = llhd.prb %intr_edge : i1
    llhd.drv %paddr_4, %paddr after %0 : i32
    %120 = llhd.prb %prdata : i32
    llhd.drv %pwdata_5, %pwdata after %0 : i32
    llhd.drv %rst_n_6, %rst_n after %0 : i1
    llhd.drv %rx_data_cnt_7, %rx_data_cnt after %0 : i5
    %121 = llhd.prb %rx_dma_th : i5
    llhd.drv %rx_empty_8, %rx_empty after %0 : i1
    %122 = llhd.prb %rx_fifo_th : i2
    llhd.drv %rx_full_9, %rx_full after %0 : i1
    llhd.drv %rx_rd_data_10, %rx_rd_data after %0 : i16
    llhd.drv %rxd_work_11, %rxd_work after %0 : i1
    %123 = llhd.prb %spi_data_size : i4
    %124 = llhd.prb %spi_en : i1
    llhd.drv %spi_work_12, %spi_work after %0 : i1
    %125 = llhd.prb %spim_en : i1
    %126 = llhd.prb %spis_en : i1
    llhd.drv %tx_data_cnt_13, %tx_data_cnt after %0 : i5
    %127 = llhd.prb %tx_dma_th : i5
    llhd.drv %tx_empty_14, %tx_empty after %0 : i1
    %128 = llhd.prb %tx_fifo_th : i2
    llhd.drv %tx_full_15, %tx_full after %0 : i1
    llhd.drv %txd_work_16, %txd_work after %0 : i1
    %129 = llhd.prb %uart_dbit : i2
    %130 = llhd.prb %uart_div : i24
    %131 = llhd.prb %uart_en : i1
    %132 = llhd.prb %uart_intr_en : i2
    %133 = llhd.prb %uart_pbit : i2
    hw.output %71, %85, %84, %107, %108, %21, %109, %110, %111, %112, %113, %114, %115, %27, %29, %77, %116, %117, %73, %75, %25, %74, %76, %false, %118, %78, %23, %false, %false, %119, %92, %120, %105, %121, %41, %63, %122, %39, %37, %96, %43, %35, %61, %123, %124, %100, %91, %19, %88, %125, %126, %106, %127, %51, %65, %128, %49, %47, %53, %94, %45, %129, %130, %131, %70, %132, %133, %69, %31, %33, %58, %98, %57 : i24, i1, i1, i10, i10, i1, i1, i8, i24, i8, i5, i24, i1, i1, i1, i1, i3, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i32, i1, i5, i1, i1, i2, i1, i1, i1, i1, i1, i1, i4, i1, i1, i1, i1, i1, i1, i1, i1, i5, i1, i1, i2, i1, i1, i1, i1, i1, i2, i24, i1, i1, i2, i2, i1, i1, i1, i4, i1, i1
  }
  hw.module private @i2cm(in %clk : i1, in %f_scl : i1, in %f_scl_d : i1, in %i2c_addr : i10, in %i2c_aerr_clr : i1, in %i2c_fs_div : i8, in %i2c_hcnt : i24, in %i2c_hold : i8, in %i2c_intr_en : i5, in %i2c_lcnt : i24, in %i2c_nack_clr : i1, in %i2c_stop_clr : i1, out i2cm_aerr_intr : i1, in %i2cm_amode : i1, in %i2cm_code : i3, out i2cm_data : i1, in %i2cm_en : i1, in %i2cm_gcall : i1, in %i2cm_hs : i1, in %i2cm_lose_arbi_clr : i1, out i2cm_lose_arbi_intr : i1, out i2cm_nack_intr : i1, out i2cm_rx : i8, out i2cm_rx_wen : i1, in %i2cm_sbyte : i1, in %i2cm_stop : i1, out i2cm_stop_intr : i1, out i2cm_tx_ren : i1, out i2cm_work : i1, in %i_scl_in : i1, in %i_sda_in : i1, in %r_scl : i1, in %r_scl_d : i1, in %rst_n : i1, out scl_out : i1, out sda_out : i1, in %start_flag : i1, in %stop_flag : i1, in %tx_empty : i1, in %tx_empty_d : i1, in %tx_rd_data : i10, in %wr_clk_div : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %c0_i5 = hw.constant 0 : i5
    %c0_i10 = hw.constant 0 : i10
    %c-1_i4 = hw.constant -1 : i4
    %c1_i8 = hw.constant 1 : i8
    %c6_i4 = hw.constant 6 : i4
    %c5_i4 = hw.constant 5 : i4
    %c4_i4 = hw.constant 4 : i4
    %c-8_i4 = hw.constant -8 : i4
    %c7_i4 = hw.constant 7 : i4
    %c3_i4 = hw.constant 3 : i4
    %c2_i4 = hw.constant 2 : i4
    %c4_i24 = hw.constant 4 : i24
    %c0_i8 = hw.constant 0 : i8
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %false = hw.constant false
    %c1_i4 = hw.constant 1 : i4
    %c0_i4 = hw.constant 0 : i4
    %c1_i24 = hw.constant 1 : i24
    %c0_i24 = hw.constant 0 : i24
    %true = hw.constant true
    %c-1_i3 = hw.constant -1 : i3
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c2_i3 = hw.constant 2 : i3
    %c-2_i3 = hw.constant -2 : i3
    %c3_i3 = hw.constant 3 : i3
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %addr0_sda = llhd.sig %false : i1
    %2 = llhd.prb %addr0_sda : i1
    %addr1_sda = llhd.sig %false : i1
    %3 = llhd.prb %addr1_sda : i1
    %bit_cnt = llhd.sig %c0_i24 : i24
    %4 = llhd.prb %bit_cnt : i24
    %byte_cnt = llhd.sig %c0_i4 : i4
    %5 = llhd.prb %byte_cnt : i4
    %data_sda = llhd.sig %false : i1
    %6 = llhd.prb %data_sda : i1
    %hold_cnt = llhd.sig %c0_i8 : i8
    %hsm_flag = llhd.sig %false : i1
    %7 = llhd.prb %hsm_flag : i1
    %i2c_busy = llhd.sig %false : i1
    %i2c_fscnt = llhd.sig %c0_i8 : i8
    %8 = llhd.prb %i2c_fscnt : i8
    %i2c_sflag = llhd.sig %false : i1
    %i2cm_aerr_intr = llhd.sig %false : i1
    %i2cm_fsm = llhd.sig %c0_i3 : i3
    %9 = llhd.prb %i2cm_fsm : i3
    %i2cm_lose_arbi_intr = llhd.sig %false : i1
    %i2cm_nack_intr = llhd.sig %false : i1
    %i2cm_rx = llhd.sig %c0_i8 : i8
    %i2cm_rx_wen = llhd.sig %false : i1
    %i2cm_sflag = llhd.sig %false : i1
    %10 = llhd.prb %i2cm_sflag : i1
    %i2cm_stop_d = llhd.sig %false : i1
    %i2cm_stop_intr = llhd.sig %false : i1
    %lose_arbi = llhd.sig %false : i1
    %11 = llhd.prb %lose_arbi : i1
    %nack = llhd.sig %false : i1
    %12 = llhd.prb %nack : i1
    %nack_d = llhd.sig %false : i1
    %nxt_bcnt = llhd.sig %c0_i24 : i24
    %nxt_bycnt = llhd.sig %c0_i4 : i4
    %nxt_i2cm_fsm = llhd.sig %c0_i3 : i3
    %nxt_scl = llhd.sig %false : i1
    %nxt_sda = llhd.sig %false : i1
    %rw_flag = llhd.sig %false : i1
    %13 = llhd.prb %rw_flag : i1
    %sbyte_flag = llhd.sig %false : i1
    %14 = llhd.prb %sbyte_flag : i1
    %scl_out = llhd.sig %false : i1
    %15 = llhd.prb %scl_out : i1
    %sda_out = llhd.sig %false : i1
    %16 = llhd.prb %sda_out : i1
    %spec_hsmc = llhd.sig %false : i1
    %17 = llhd.prb %spec_hsmc : i1
    %spec_sbyte = llhd.sig %false : i1
    %18 = llhd.prb %spec_sbyte : i1
    %sr_flag = llhd.sig %false : i1
    %19 = llhd.prb %sr_flag : i1
    %a0_hs_byeq0 = llhd.sig %false : i1
    %a0_scl_clr = llhd.sig %false : i1
    %20 = llhd.prb %a0_scl_clr : i1
    %addr0_end = llhd.sig %false : i1
    %21 = llhd.prb %addr0_end : i1
    %addr1_end = llhd.sig %false : i1
    %22 = llhd.prb %addr1_end : i1
    %addr1_to_sr = llhd.sig %false : i1
    %23 = llhd.prb %addr1_to_sr : i1
    %addr_bcnt_plus = llhd.sig %false : i1
    %24 = llhd.prb %addr_bcnt_plus : i1
    %arbi_en = llhd.sig %false : i1
    %bcnt_clr = llhd.sig %false : i1
    %25 = llhd.prb %bcnt_clr : i1
    %bcnt_eq0 = llhd.sig %false : i1
    %26 = llhd.prb %bcnt_eq0 : i1
    %bcnt_eq4 = llhd.sig %false : i1
    %27 = llhd.prb %bcnt_eq4 : i1
    %bcnt_eqh = llhd.sig %false : i1
    %28 = llhd.prb %bcnt_eqh : i1
    %bcnt_eql = llhd.sig %false : i1
    %29 = llhd.prb %bcnt_eql : i1
    %bcnt_plus_hs = llhd.sig %false : i1
    %bycnt_eq0 = llhd.sig %false : i1
    %30 = llhd.prb %bycnt_eq0 : i1
    %bycnt_eq1 = llhd.sig %false : i1
    %31 = llhd.prb %bycnt_eq1 : i1
    %bycnt_eq2 = llhd.sig %false : i1
    %32 = llhd.prb %bycnt_eq2 : i1
    %bycnt_eq3 = llhd.sig %false : i1
    %33 = llhd.prb %bycnt_eq3 : i1
    %bycnt_eq7 = llhd.sig %false : i1
    %bycnt_eq8 = llhd.sig %false : i1
    %34 = llhd.prb %bycnt_eq8 : i1
    %bycnt_plus = llhd.sig %false : i1
    %35 = llhd.prb %bycnt_plus : i1
    %clk_0 = llhd.sig name "clk" %false : i1
    %36 = llhd.prb %clk_0 : i1
    %data_bcnt_plus = llhd.sig %false : i1
    %37 = llhd.prb %data_bcnt_plus : i1
    %data_by_eq0 = llhd.sig %false : i1
    %38 = llhd.prb %data_by_eq0 : i1
    %data_bycnt_clr = llhd.sig %false : i1
    %39 = llhd.prb %data_bycnt_clr : i1
    %data_end = llhd.sig %false : i1
    %40 = llhd.prb %data_end : i1
    %data_end_3 = llhd.sig %false : i1
    %f_empty = llhd.sig %false : i1
    %41 = llhd.prb %f_empty : i1
    %f_scl_1 = llhd.sig name "f_scl" %false : i1
    %42 = llhd.prb %f_scl_1 : i1
    %f_scl_d_2 = llhd.sig name "f_scl_d" %false : i1
    %43 = llhd.prb %f_scl_d_2 : i1
    %fscnt_clr = llhd.sig %false : i1
    %fscnt_plus = llhd.sig %false : i1
    %hold_clr = llhd.sig %false : i1
    %hold_eq = llhd.sig %false : i1
    %44 = llhd.prb %hold_eq : i1
    %hold_plus = llhd.sig %false : i1
    %i2c_addr_3 = llhd.sig name "i2c_addr" %c0_i10 : i10
    %45 = llhd.prb %i2c_addr_3 : i10
    %i2c_aerr_clr_4 = llhd.sig name "i2c_aerr_clr" %false : i1
    %i2c_fs_div_5 = llhd.sig name "i2c_fs_div" %c0_i8 : i8
    %46 = llhd.prb %i2c_fs_div_5 : i8
    %i2c_fscnt_eq = llhd.sig %false : i1
    %47 = llhd.prb %i2c_fscnt_eq : i1
    %i2c_hcnt_6 = llhd.sig name "i2c_hcnt" %c0_i24 : i24
    %48 = llhd.prb %i2c_hcnt_6 : i24
    %i2c_hold_7 = llhd.sig name "i2c_hold" %c0_i8 : i8
    %i2c_intr_en_8 = llhd.sig name "i2c_intr_en" %c0_i5 : i5
    %i2c_nack_clr_9 = llhd.sig name "i2c_nack_clr" %false : i1
    %i2c_stop_clr_10 = llhd.sig name "i2c_stop_clr" %false : i1
    %i2cm_aerr = llhd.sig %false : i1
    %i2cm_amode_11 = llhd.sig name "i2cm_amode" %false : i1
    %49 = llhd.prb %i2cm_amode_11 : i1
    %i2cm_code_12 = llhd.sig name "i2cm_code" %c0_i3 : i3
    %50 = llhd.prb %i2cm_code_12 : i3
    %i2cm_en_13 = llhd.sig name "i2cm_en" %false : i1
    %i2cm_gcall_14 = llhd.sig name "i2cm_gcall" %false : i1
    %51 = llhd.prb %i2cm_gcall_14 : i1
    %i2cm_hs_15 = llhd.sig name "i2cm_hs" %false : i1
    %52 = llhd.prb %i2cm_hs_15 : i1
    %i2cm_lose_arbi_clr_16 = llhd.sig name "i2cm_lose_arbi_clr" %false : i1
    %i2cm_sbyte_17 = llhd.sig name "i2cm_sbyte" %false : i1
    %53 = llhd.prb %i2cm_sbyte_17 : i1
    %i2cm_stop_18 = llhd.sig name "i2cm_stop" %false : i1
    %i_scl_in_19 = llhd.sig name "i_scl_in" %false : i1
    %54 = llhd.prb %i_scl_in_19 : i1
    %i_sda_in_20 = llhd.sig name "i_sda_in" %false : i1
    %55 = llhd.prb %i_sda_in_20 : i1
    %idle_end = llhd.sig %false : i1
    %56 = llhd.prb %idle_end : i1
    %r_nack = llhd.sig %false : i1
    %r_scl_21 = llhd.sig name "r_scl" %false : i1
    %57 = llhd.prb %r_scl_21 : i1
    %r_scl_d_22 = llhd.sig name "r_scl_d" %false : i1
    %re_nack = llhd.sig %false : i1
    %58 = llhd.prb %re_nack : i1
    %restart_end = llhd.sig %false : i1
    %59 = llhd.prb %restart_end : i1
    %rst_n_23 = llhd.sig name "rst_n" %false : i1
    %60 = llhd.prb %rst_n_23 : i1
    %set_sr_flag = llhd.sig %false : i1
    %special_end = llhd.sig %false : i1
    %61 = llhd.prb %special_end : i1
    %sta_addr0 = llhd.sig %false : i1
    %sta_data = llhd.sig %false : i1
    %sta_idle = llhd.sig %false : i1
    %sta_restart = llhd.sig %false : i1
    %sta_special = llhd.sig %false : i1
    %sta_start = llhd.sig %false : i1
    %start_end = llhd.sig %false : i1
    %62 = llhd.prb %start_end : i1
    %start_flag_24 = llhd.sig name "start_flag" %false : i1
    %63 = llhd.prb %start_flag_24 : i1
    %stop_end = llhd.sig %false : i1
    %64 = llhd.prb %stop_end : i1
    %stop_flag_25 = llhd.sig name "stop_flag" %false : i1
    %65 = llhd.prb %stop_flag_25 : i1
    %to_restart = llhd.sig %false : i1
    %66 = llhd.prb %to_restart : i1
    %tx_empty_26 = llhd.sig name "tx_empty" %false : i1
    %67 = llhd.prb %tx_empty_26 : i1
    %tx_juedge = llhd.sig %false : i1
    %68 = llhd.prb %tx_juedge : i1
    %tx_rd_data_27 = llhd.sig name "tx_rd_data" %c0_i10 : i10
    %69 = llhd.prb %tx_rd_data_27 : i10
    %wr_clk_div_28 = llhd.sig name "wr_clk_div" %false : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %216 = llhd.prb %clk_0 : i1
      %217 = llhd.prb %rst_n_23 : i1
      llhd.wait (%36, %60 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %218 = llhd.prb %clk_0 : i1
      %219 = comb.xor bin %216, %true : i1
      %220 = comb.and bin %219, %218 : i1
      %221 = llhd.prb %rst_n_23 : i1
      %222 = comb.xor bin %221, %true : i1
      %223 = comb.and bin %217, %222 : i1
      %224 = comb.or bin %220, %223 : i1
      cf.cond_br %224, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %225 = llhd.prb %rst_n_23 : i1
      %226 = comb.xor %225, %true : i1
      cf.cond_br %226, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i2cm_fsm, %c0_i3 after %1 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %227 = llhd.prb %i2cm_en_13 : i1
      %228 = comb.xor %227, %true : i1
      %229 = llhd.prb %i2cm_aerr : i1
      %230 = comb.or %228, %229 : i1
      cf.cond_br %230, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %i2cm_fsm, %c0_i3 after %1 : i3
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %231 = llhd.prb %nxt_i2cm_fsm : i3
      llhd.drv %i2cm_fsm, %231 after %1 : i3
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 31 preds: ^bb0, ^bb4, ^bb5, ^bb8, ^bb11, ^bb12, ^bb13, ^bb17, ^bb19, ^bb20, ^bb21, ^bb24, ^bb26, ^bb27, ^bb31, ^bb33, ^bb35, ^bb37, ^bb38, ^bb39, ^bb43, ^bb45, ^bb47, ^bb48, ^bb49, ^bb53, ^bb55, ^bb56, ^bb57, ^bb59, ^bb60
      llhd.wait (%12, %7, %40, %49, %65, %64, %52, %14, %62, %61, %63, %56, %10, %66, %19, %23, %59, %22, %21, %53, %9, %11 : i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i3, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %216 = llhd.prb %i2cm_fsm : i3
      %217 = comb.icmp ceq %216, %c0_i3 : i3
      cf.cond_br %217, ^bb3, ^bb6
    ^bb3:  // pred: ^bb2
      %218 = llhd.prb %idle_end : i1
      cf.cond_br %218, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %nxt_i2cm_fsm, %c1_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      llhd.drv %nxt_i2cm_fsm, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb6:  // pred: ^bb2
      %219 = comb.icmp ceq %216, %c1_i3 : i3
      cf.cond_br %219, ^bb7, ^bb14
    ^bb7:  // pred: ^bb6
      %220 = llhd.prb %start_end : i1
      %221 = llhd.prb %i2cm_sflag : i1
      %222 = comb.xor %221, %true : i1
      %223 = comb.and %220, %222 : i1
      cf.cond_br %223, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %nxt_i2cm_fsm, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %224 = llhd.prb %start_end : i1
      cf.cond_br %224, ^bb10, ^bb13
    ^bb10:  // pred: ^bb9
      %225 = llhd.prb %i2cm_sbyte_17 : i1
      %226 = llhd.prb %i2cm_hs_15 : i1
      %227 = comb.or %225, %226 : i1
      cf.cond_br %227, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      llhd.drv %nxt_i2cm_fsm, %c3_i3 after %0 : i3
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      llhd.drv %nxt_i2cm_fsm, %c-2_i3 after %0 : i3
      cf.br ^bb1
    ^bb13:  // pred: ^bb9
      llhd.drv %nxt_i2cm_fsm, %c1_i3 after %0 : i3
      cf.br ^bb1
    ^bb14:  // pred: ^bb6
      %228 = comb.icmp ceq %216, %c3_i3 : i3
      cf.cond_br %228, ^bb15, ^bb22
    ^bb15:  // pred: ^bb14
      %229 = llhd.prb %special_end : i1
      cf.cond_br %229, ^bb16, ^bb21
    ^bb16:  // pred: ^bb15
      %230 = llhd.prb %lose_arbi : i1
      cf.cond_br %230, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      llhd.drv %nxt_i2cm_fsm, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb18:  // pred: ^bb16
      %231 = llhd.prb %i2cm_hs_15 : i1
      %232 = llhd.prb %i2cm_sbyte_17 : i1
      %233 = llhd.prb %sbyte_flag : i1
      %234 = llhd.prb %hsm_flag : i1
      %235 = comb.xor %234, %true : i1
      %236 = comb.and %231, %232, %233, %235 : i1
      cf.cond_br %236, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      llhd.drv %nxt_i2cm_fsm, %c1_i3 after %0 : i3
      cf.br ^bb1
    ^bb20:  // pred: ^bb18
      llhd.drv %nxt_i2cm_fsm, %c2_i3 after %0 : i3
      cf.br ^bb1
    ^bb21:  // pred: ^bb15
      llhd.drv %nxt_i2cm_fsm, %c3_i3 after %0 : i3
      cf.br ^bb1
    ^bb22:  // pred: ^bb14
      %237 = comb.icmp ceq %216, %c2_i3 : i3
      cf.cond_br %237, ^bb23, ^bb28
    ^bb23:  // pred: ^bb22
      %238 = llhd.prb %restart_end : i1
      %239 = llhd.prb %i2cm_sflag : i1
      %240 = comb.xor %239, %true : i1
      %241 = comb.and %238, %240 : i1
      %242 = llhd.prb %stop_flag_25 : i1
      %243 = comb.or %241, %242 : i1
      cf.cond_br %243, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      llhd.drv %nxt_i2cm_fsm, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb25:  // pred: ^bb23
      %244 = llhd.prb %restart_end : i1
      cf.cond_br %244, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      llhd.drv %nxt_i2cm_fsm, %c-2_i3 after %0 : i3
      cf.br ^bb1
    ^bb27:  // pred: ^bb25
      llhd.drv %nxt_i2cm_fsm, %c2_i3 after %0 : i3
      cf.br ^bb1
    ^bb28:  // pred: ^bb22
      %245 = comb.icmp ceq %216, %c-2_i3 : i3
      cf.cond_br %245, ^bb29, ^bb40
    ^bb29:  // pred: ^bb28
      %246 = llhd.prb %addr0_end : i1
      cf.cond_br %246, ^bb30, ^bb39
    ^bb30:  // pred: ^bb29
      %247 = llhd.prb %lose_arbi : i1
      %248 = llhd.prb %start_flag_24 : i1
      %249 = llhd.prb %stop_flag_25 : i1
      %250 = comb.or %247, %248, %249 : i1
      cf.cond_br %250, ^bb31, ^bb32
    ^bb31:  // pred: ^bb30
      llhd.drv %nxt_i2cm_fsm, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb32:  // pred: ^bb30
      %251 = llhd.prb %nack : i1
      cf.cond_br %251, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      llhd.drv %nxt_i2cm_fsm, %c-4_i3 after %0 : i3
      cf.br ^bb1
    ^bb34:  // pred: ^bb32
      %252 = llhd.prb %sr_flag : i1
      cf.cond_br %252, ^bb35, ^bb36
    ^bb35:  // pred: ^bb34
      llhd.drv %nxt_i2cm_fsm, %c-3_i3 after %0 : i3
      cf.br ^bb1
    ^bb36:  // pred: ^bb34
      %253 = llhd.prb %i2cm_amode_11 : i1
      cf.cond_br %253, ^bb37, ^bb38
    ^bb37:  // pred: ^bb36
      llhd.drv %nxt_i2cm_fsm, %c-1_i3 after %0 : i3
      cf.br ^bb1
    ^bb38:  // pred: ^bb36
      llhd.drv %nxt_i2cm_fsm, %c-3_i3 after %0 : i3
      cf.br ^bb1
    ^bb39:  // pred: ^bb29
      llhd.drv %nxt_i2cm_fsm, %c-2_i3 after %0 : i3
      cf.br ^bb1
    ^bb40:  // pred: ^bb28
      %254 = comb.icmp ceq %216, %c-1_i3 : i3
      cf.cond_br %254, ^bb41, ^bb50
    ^bb41:  // pred: ^bb40
      %255 = llhd.prb %addr1_end : i1
      cf.cond_br %255, ^bb42, ^bb49
    ^bb42:  // pred: ^bb41
      %256 = llhd.prb %lose_arbi : i1
      %257 = llhd.prb %start_flag_24 : i1
      %258 = llhd.prb %stop_flag_25 : i1
      %259 = comb.or %256, %257, %258 : i1
      cf.cond_br %259, ^bb43, ^bb44
    ^bb43:  // pred: ^bb42
      llhd.drv %nxt_i2cm_fsm, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb44:  // pred: ^bb42
      %260 = llhd.prb %nack : i1
      cf.cond_br %260, ^bb45, ^bb46
    ^bb45:  // pred: ^bb44
      llhd.drv %nxt_i2cm_fsm, %c-4_i3 after %0 : i3
      cf.br ^bb1
    ^bb46:  // pred: ^bb44
      %261 = llhd.prb %addr1_to_sr : i1
      cf.cond_br %261, ^bb47, ^bb48
    ^bb47:  // pred: ^bb46
      llhd.drv %nxt_i2cm_fsm, %c2_i3 after %0 : i3
      cf.br ^bb1
    ^bb48:  // pred: ^bb46
      llhd.drv %nxt_i2cm_fsm, %c-3_i3 after %0 : i3
      cf.br ^bb1
    ^bb49:  // pred: ^bb41
      llhd.drv %nxt_i2cm_fsm, %c-1_i3 after %0 : i3
      cf.br ^bb1
    ^bb50:  // pred: ^bb40
      %262 = comb.icmp ceq %216, %c-3_i3 : i3
      cf.cond_br %262, ^bb51, ^bb58
    ^bb51:  // pred: ^bb50
      %263 = llhd.prb %data_end : i1
      cf.cond_br %263, ^bb52, ^bb57
    ^bb52:  // pred: ^bb51
      %264 = llhd.prb %lose_arbi : i1
      %265 = llhd.prb %start_flag_24 : i1
      %266 = llhd.prb %stop_flag_25 : i1
      %267 = comb.or %264, %265, %266 : i1
      cf.cond_br %267, ^bb53, ^bb54
    ^bb53:  // pred: ^bb52
      llhd.drv %nxt_i2cm_fsm, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb54:  // pred: ^bb52
      %268 = llhd.prb %to_restart : i1
      cf.cond_br %268, ^bb55, ^bb56
    ^bb55:  // pred: ^bb54
      llhd.drv %nxt_i2cm_fsm, %c2_i3 after %0 : i3
      cf.br ^bb1
    ^bb56:  // pred: ^bb54
      llhd.drv %nxt_i2cm_fsm, %c-4_i3 after %0 : i3
      cf.br ^bb1
    ^bb57:  // pred: ^bb51
      llhd.drv %nxt_i2cm_fsm, %c-3_i3 after %0 : i3
      cf.br ^bb1
    ^bb58:  // pred: ^bb50
      %269 = llhd.prb %stop_end : i1
      cf.cond_br %269, ^bb59, ^bb60
    ^bb59:  // pred: ^bb58
      llhd.drv %nxt_i2cm_fsm, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb60:  // pred: ^bb58
      llhd.drv %nxt_i2cm_fsm, %c-4_i3 after %0 : i3
      cf.br ^bb1
    }
    %70 = comb.icmp eq %9, %c0_i3 : i3
    llhd.drv %sta_idle, %70 after %0 : i1
    %71 = comb.icmp eq %9, %c1_i3 : i3
    llhd.drv %sta_start, %71 after %0 : i1
    %72 = comb.icmp eq %9, %c2_i3 : i3
    llhd.drv %sta_restart, %72 after %0 : i1
    %73 = comb.icmp eq %9, %c-4_i3 {sv.namehint = "sta_stop"} : i3
    %74 = comb.icmp eq %9, %c3_i3 : i3
    llhd.drv %sta_special, %74 after %0 : i1
    %75 = comb.icmp eq %9, %c-2_i3 : i3
    llhd.drv %sta_addr0, %75 after %0 : i1
    %76 = comb.icmp eq %9, %c-1_i3 {sv.namehint = "sta_addr1"} : i3
    %77 = comb.icmp eq %9, %c-3_i3 : i3
    llhd.drv %sta_data, %77 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 31 preds: ^bb0, ^bb7, ^bb9, ^bb10, ^bb26, ^bb28, ^bb30, ^bb31, ^bb56, ^bb58, ^bb60, ^bb61, ^bb79, ^bb81, ^bb83, ^bb84, ^bb100, ^bb102, ^bb104, ^bb105, ^bb121, ^bb123, ^bb124, ^bb144, ^bb146, ^bb148, ^bb149, ^bb162, ^bb164, ^bb166, ^bb167
      llhd.wait (%17, %30, %7, %38, %41, %31, %42, %35, %67, %64, %62, %54, %46, %32, %24, %59, %22, %6, %28, %25, %15, %68, %40, %18, %5, %20, %39, %3, %44, %4, %37, %26, %2, %29, %52, %33, %48, %14, %8, %61, %56, %34, %43, %47, %57, %16, %53, %21, %27, %55, %9 : i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i8, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i4, i1, i1, i1, i1, i24, i1, i1, i1, i1, i1, i1, i24, i1, i8, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i3), ^bb2
    ^bb2:  // pred: ^bb1
      %216 = llhd.prb %i2cm_fsm : i3
      %217 = comb.icmp ceq %216, %c0_i3 : i3
      cf.cond_br %217, ^bb3, ^bb11
    ^bb3:  // pred: ^bb2
      llhd.drv %nxt_scl, %true after %0 : i1
      llhd.drv %nxt_sda, %true after %0 : i1
      %218 = llhd.prb %bcnt_eqh : i1
      %219 = llhd.prb %idle_end : i1
      %220 = llhd.prb %i_scl_in_19 : i1
      %221 = comb.xor %220, %true : i1
      %222 = llhd.prb %i_sda_in_20 : i1
      %223 = comb.xor %222, %true : i1
      %224 = comb.or %218, %219, %221, %223 : i1
      cf.cond_br %224, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %nxt_bcnt, %c0_i24 after %0 : i24
      cf.br ^bb6
    ^bb5:  // pred: ^bb3
      %225 = llhd.prb %bit_cnt : i24
      %226 = comb.add %225, %c1_i24 : i24
      llhd.drv %nxt_bcnt, %226 after %0 : i24
      cf.br ^bb6
    ^bb6:  // 2 preds: ^bb4, ^bb5
      %227 = llhd.prb %idle_end : i1
      %228 = llhd.prb %i_scl_in_19 : i1
      %229 = comb.xor %228, %true : i1
      %230 = llhd.prb %i_sda_in_20 : i1
      %231 = comb.xor %230, %true : i1
      %232 = comb.or %227, %229, %231 : i1
      cf.cond_br %232, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      llhd.drv %nxt_bycnt, %c0_i4 after %0 : i4
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %233 = llhd.prb %bcnt_eqh : i1
      cf.cond_br %233, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %234 = llhd.prb %byte_cnt : i4
      %235 = comb.add %234, %c1_i4 : i4
      llhd.drv %nxt_bycnt, %235 after %0 : i4
      cf.br ^bb1
    ^bb10:  // pred: ^bb8
      %236 = llhd.prb %byte_cnt : i4
      llhd.drv %nxt_bycnt, %236 after %0 : i4
      cf.br ^bb1
    ^bb11:  // pred: ^bb2
      %237 = comb.icmp ceq %216, %c1_i3 : i3
      cf.cond_br %237, ^bb12, ^bb32
    ^bb12:  // pred: ^bb11
      %238 = llhd.prb %bycnt_eq3 : i1
      %239 = llhd.prb %start_end : i1
      %240 = comb.or %238, %239 : i1
      cf.cond_br %240, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      llhd.drv %nxt_scl, %false after %0 : i1
      cf.br ^bb17
    ^bb14:  // pred: ^bb12
      %241 = llhd.prb %bycnt_eq1 : i1
      cf.cond_br %241, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      llhd.drv %nxt_scl, %true after %0 : i1
      cf.br ^bb17
    ^bb16:  // pred: ^bb14
      %242 = llhd.prb %scl_out : i1
      llhd.drv %nxt_scl, %242 after %0 : i1
      cf.br ^bb17
    ^bb17:  // 3 preds: ^bb13, ^bb15, ^bb16
      %243 = llhd.prb %bycnt_eq2 : i1
      cf.cond_br %243, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      llhd.drv %nxt_sda, %false after %0 : i1
      cf.br ^bb22
    ^bb19:  // pred: ^bb17
      %244 = llhd.prb %bycnt_eq0 : i1
      cf.cond_br %244, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      llhd.drv %nxt_sda, %true after %0 : i1
      cf.br ^bb22
    ^bb21:  // pred: ^bb19
      %245 = llhd.prb %sda_out : i1
      llhd.drv %nxt_sda, %245 after %0 : i1
      cf.br ^bb22
    ^bb22:  // 3 preds: ^bb18, ^bb20, ^bb21
      %246 = llhd.prb %bit_cnt : i24
      %247 = llhd.prb %i2c_hcnt_6 : i24
      %248 = comb.icmp eq %246, %247 : i24
      %249 = llhd.prb %start_end : i1
      %250 = comb.or %248, %249 : i1
      cf.cond_br %250, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      llhd.drv %nxt_bcnt, %c0_i24 after %0 : i24
      cf.br ^bb25
    ^bb24:  // pred: ^bb22
      %251 = llhd.prb %bit_cnt : i24
      %252 = comb.add %251, %c1_i24 : i24
      llhd.drv %nxt_bcnt, %252 after %0 : i24
      cf.br ^bb25
    ^bb25:  // 2 preds: ^bb23, ^bb24
      %253 = llhd.prb %start_end : i1
      cf.cond_br %253, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      llhd.drv %nxt_bycnt, %c0_i4 after %0 : i4
      cf.br ^bb1
    ^bb27:  // pred: ^bb25
      %254 = llhd.prb %bycnt_eq3 : i1
      cf.cond_br %254, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      %255 = llhd.prb %byte_cnt : i4
      llhd.drv %nxt_bycnt, %255 after %0 : i4
      cf.br ^bb1
    ^bb29:  // pred: ^bb27
      %256 = llhd.prb %i2cm_hs_15 : i1
      %257 = llhd.prb %i2cm_sbyte_17 : i1
      %258 = comb.or %256, %257 : i1
      %259 = llhd.prb %bit_cnt : i24
      %260 = llhd.prb %i2c_hcnt_6 : i24
      %261 = comb.icmp eq %259, %260 : i24
      %262 = llhd.prb %i2c_fscnt_eq : i1
      %263 = comb.and %261, %262 : i1
      %264 = llhd.prb %bcnt_eqh : i1
      %265 = comb.mux %258, %263, %264 : i1
      cf.cond_br %265, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %266 = llhd.prb %byte_cnt : i4
      %267 = comb.add %266, %c1_i4 : i4
      llhd.drv %nxt_bycnt, %267 after %0 : i4
      cf.br ^bb1
    ^bb31:  // pred: ^bb29
      %268 = llhd.prb %byte_cnt : i4
      %269 = comb.extract %268 from 0 : (i4) -> i3
      %270 = comb.concat %false, %269 : i1, i3
      llhd.drv %nxt_bycnt, %270 after %0 : i4
      cf.br ^bb1
    ^bb32:  // pred: ^bb11
      %271 = comb.icmp ceq %216, %c3_i3 : i3
      cf.cond_br %271, ^bb33, ^bb62
    ^bb33:  // pred: ^bb32
      %272 = llhd.prb %hold_eq : i1
      cf.cond_br %272, ^bb34, ^bb44
    ^bb34:  // pred: ^bb33
      %273 = llhd.prb %i2cm_hs_15 : i1
      %274 = llhd.prb %i2cm_sbyte_17 : i1
      %275 = comb.concat %273, %274 : i1, i1
      %276 = comb.icmp ceq %275, %c0_i2 : i2
      cf.cond_br %276, ^bb36, ^bb35
    ^bb35:  // pred: ^bb34
      %277 = comb.icmp ceq %275, %c1_i2 : i2
      cf.cond_br %277, ^bb36, ^bb37
    ^bb36:  // 2 preds: ^bb34, ^bb35
      %278 = llhd.prb %spec_sbyte : i1
      llhd.drv %nxt_sda, %278 after %0 : i1
      cf.br ^bb45
    ^bb37:  // pred: ^bb35
      %279 = comb.icmp ceq %275, %c-2_i2 : i2
      cf.cond_br %279, ^bb38, ^bb39
    ^bb38:  // pred: ^bb37
      %280 = llhd.prb %spec_hsmc : i1
      llhd.drv %nxt_sda, %280 after %0 : i1
      cf.br ^bb45
    ^bb39:  // pred: ^bb37
      %281 = llhd.prb %sbyte_flag : i1
      %282 = comb.xor %281, %true : i1
      cf.cond_br %282, ^bb40, ^bb41
    ^bb40:  // pred: ^bb39
      %283 = llhd.prb %spec_sbyte : i1
      llhd.drv %nxt_sda, %283 after %0 : i1
      cf.br ^bb45
    ^bb41:  // pred: ^bb39
      %284 = llhd.prb %hsm_flag : i1
      %285 = comb.xor %284, %true : i1
      cf.cond_br %285, ^bb42, ^bb43
    ^bb42:  // pred: ^bb41
      %286 = llhd.prb %spec_hsmc : i1
      llhd.drv %nxt_sda, %286 after %0 : i1
      cf.br ^bb45
    ^bb43:  // pred: ^bb41
      %287 = llhd.prb %spec_sbyte : i1
      llhd.drv %nxt_sda, %287 after %0 : i1
      cf.br ^bb45
    ^bb44:  // pred: ^bb33
      %288 = llhd.prb %sda_out : i1
      llhd.drv %nxt_sda, %288 after %0 : i1
      cf.br ^bb45
    ^bb45:  // 6 preds: ^bb36, ^bb38, ^bb40, ^bb42, ^bb43, ^bb44
      %289 = llhd.prb %i2c_fscnt : i8
      %290 = llhd.prb %i2c_fs_div_5 : i8
      %291 = comb.icmp eq %289, %290 : i8
      %292 = llhd.prb %bcnt_eqh : i1
      %293 = comb.and %291, %292 : i1
      %294 = llhd.prb %f_scl_1 : i1
      %295 = comb.or %293, %294 : i1
      cf.cond_br %295, ^bb46, ^bb47
    ^bb46:  // pred: ^bb45
      llhd.drv %nxt_scl, %false after %0 : i1
      cf.br ^bb50
    ^bb47:  // pred: ^bb45
      %296 = llhd.prb %i2c_fscnt : i8
      %297 = llhd.prb %i2c_fs_div_5 : i8
      %298 = comb.icmp eq %296, %297 : i8
      %299 = llhd.prb %bcnt_eql : i1
      %300 = llhd.prb %scl_out : i1
      %301 = comb.xor %300, %true : i1
      %302 = comb.and %298, %299, %301 : i1
      cf.cond_br %302, ^bb48, ^bb49
    ^bb48:  // pred: ^bb47
      llhd.drv %nxt_scl, %true after %0 : i1
      cf.br ^bb50
    ^bb49:  // pred: ^bb47
      %303 = llhd.prb %scl_out : i1
      llhd.drv %nxt_scl, %303 after %0 : i1
      cf.br ^bb50
    ^bb50:  // 3 preds: ^bb46, ^bb48, ^bb49
      %304 = llhd.prb %bcnt_eqh : i1
      %305 = llhd.prb %bcnt_eql : i1
      %306 = llhd.prb %f_scl_1 : i1
      %307 = llhd.prb %special_end : i1
      %308 = comb.or %304, %305, %306, %307 : i1
      cf.cond_br %308, ^bb51, ^bb52
    ^bb51:  // pred: ^bb50
      llhd.drv %nxt_bcnt, %c0_i24 after %0 : i24
      cf.br ^bb55
    ^bb52:  // pred: ^bb50
      %309 = llhd.prb %r_scl_21 : i1
      %310 = llhd.prb %f_scl_d_2 : i1
      %311 = llhd.prb %i2c_fscnt : i8
      %312 = comb.icmp ne %311, %c0_i8 : i8
      %313 = llhd.prb %bcnt_eq0 : i1
      %314 = comb.xor %313, %true : i1
      %315 = comb.or %309, %310, %312, %314 : i1
      cf.cond_br %315, ^bb53, ^bb54
    ^bb53:  // pred: ^bb52
      %316 = llhd.prb %bit_cnt : i24
      %317 = comb.add %316, %c1_i24 : i24
      llhd.drv %nxt_bcnt, %317 after %0 : i24
      cf.br ^bb55
    ^bb54:  // pred: ^bb52
      %318 = llhd.prb %bit_cnt : i24
      llhd.drv %nxt_bcnt, %318 after %0 : i24
      cf.br ^bb55
    ^bb55:  // 3 preds: ^bb51, ^bb53, ^bb54
      %319 = llhd.prb %special_end : i1
      %320 = llhd.prb %bycnt_eq8 : i1
      %321 = llhd.prb %f_scl_1 : i1
      %322 = comb.and %320, %321 : i1
      %323 = comb.or %319, %322 : i1
      cf.cond_br %323, ^bb56, ^bb57
    ^bb56:  // pred: ^bb55
      llhd.drv %nxt_bycnt, %c0_i4 after %0 : i4
      cf.br ^bb1
    ^bb57:  // pred: ^bb55
      %324 = llhd.prb %bycnt_eq8 : i1
      cf.cond_br %324, ^bb58, ^bb59
    ^bb58:  // pred: ^bb57
      %325 = llhd.prb %byte_cnt : i4
      llhd.drv %nxt_bycnt, %325 after %0 : i4
      cf.br ^bb1
    ^bb59:  // pred: ^bb57
      %326 = llhd.prb %f_scl_1 : i1
      cf.cond_br %326, ^bb60, ^bb61
    ^bb60:  // pred: ^bb59
      %327 = llhd.prb %byte_cnt : i4
      %328 = comb.add %327, %c1_i4 : i4
      llhd.drv %nxt_bycnt, %328 after %0 : i4
      cf.br ^bb1
    ^bb61:  // pred: ^bb59
      %329 = llhd.prb %byte_cnt : i4
      llhd.drv %nxt_bycnt, %329 after %0 : i4
      cf.br ^bb1
    ^bb62:  // pred: ^bb32
      %330 = comb.icmp ceq %216, %c2_i3 : i3
      cf.cond_br %330, ^bb63, ^bb85
    ^bb63:  // pred: ^bb62
      %331 = llhd.prb %bycnt_eq3 : i1
      %332 = llhd.prb %bycnt_eq0 : i1
      %333 = llhd.prb %restart_end : i1
      %334 = comb.or %331, %332, %333 : i1
      cf.cond_br %334, ^bb64, ^bb65
    ^bb64:  // pred: ^bb63
      llhd.drv %nxt_scl, %false after %0 : i1
      cf.br ^bb68
    ^bb65:  // pred: ^bb63
      %335 = llhd.prb %bycnt_eq1 : i1
      %336 = llhd.prb %bycnt_eq2 : i1
      %337 = comb.or %335, %336 : i1
      cf.cond_br %337, ^bb66, ^bb67
    ^bb66:  // pred: ^bb65
      llhd.drv %nxt_scl, %true after %0 : i1
      cf.br ^bb68
    ^bb67:  // pred: ^bb65
      %338 = llhd.prb %scl_out : i1
      llhd.drv %nxt_scl, %338 after %0 : i1
      cf.br ^bb68
    ^bb68:  // 3 preds: ^bb64, ^bb66, ^bb67
      %339 = llhd.prb %bycnt_eq0 : i1
      cf.cond_br %339, ^bb69, ^bb70
    ^bb69:  // pred: ^bb68
      llhd.drv %nxt_sda, %true after %0 : i1
      cf.br ^bb73
    ^bb70:  // pred: ^bb68
      %340 = llhd.prb %bycnt_eq2 : i1
      cf.cond_br %340, ^bb71, ^bb72
    ^bb71:  // pred: ^bb70
      llhd.drv %nxt_sda, %false after %0 : i1
      cf.br ^bb73
    ^bb72:  // pred: ^bb70
      %341 = llhd.prb %sda_out : i1
      llhd.drv %nxt_sda, %341 after %0 : i1
      cf.br ^bb73
    ^bb73:  // 3 preds: ^bb69, ^bb71, ^bb72
      %342 = llhd.prb %bit_cnt : i24
      %343 = llhd.prb %i2c_hcnt_6 : i24
      %344 = comb.icmp eq %342, %343 : i24
      %345 = llhd.prb %restart_end : i1
      %346 = comb.or %344, %345 : i1
      cf.cond_br %346, ^bb74, ^bb75
    ^bb74:  // pred: ^bb73
      llhd.drv %nxt_bcnt, %c0_i24 after %0 : i24
      cf.br ^bb78
    ^bb75:  // pred: ^bb73
      %347 = llhd.prb %bycnt_eq0 : i1
      %348 = llhd.prb %r_scl_21 : i1
      %349 = llhd.prb %bycnt_eq2 : i1
      %350 = llhd.prb %bcnt_eq0 : i1
      %351 = comb.xor %350, %true : i1
      %352 = comb.or %347, %348, %349, %351 : i1
      cf.cond_br %352, ^bb76, ^bb77
    ^bb76:  // pred: ^bb75
      %353 = llhd.prb %bit_cnt : i24
      %354 = comb.add %353, %c1_i24 : i24
      llhd.drv %nxt_bcnt, %354 after %0 : i24
      cf.br ^bb78
    ^bb77:  // pred: ^bb75
      %355 = llhd.prb %bit_cnt : i24
      llhd.drv %nxt_bcnt, %355 after %0 : i24
      cf.br ^bb78
    ^bb78:  // 3 preds: ^bb74, ^bb76, ^bb77
      %356 = llhd.prb %restart_end : i1
      cf.cond_br %356, ^bb79, ^bb80
    ^bb79:  // pred: ^bb78
      llhd.drv %nxt_bycnt, %c0_i4 after %0 : i4
      cf.br ^bb1
    ^bb80:  // pred: ^bb78
      %357 = llhd.prb %bycnt_eq3 : i1
      cf.cond_br %357, ^bb81, ^bb82
    ^bb81:  // pred: ^bb80
      %358 = llhd.prb %byte_cnt : i4
      llhd.drv %nxt_bycnt, %358 after %0 : i4
      cf.br ^bb1
    ^bb82:  // pred: ^bb80
      %359 = llhd.prb %bit_cnt : i24
      %360 = llhd.prb %i2c_hcnt_6 : i24
      %361 = comb.icmp eq %359, %360 : i24
      cf.cond_br %361, ^bb83, ^bb84
    ^bb83:  // pred: ^bb82
      %362 = llhd.prb %byte_cnt : i4
      %363 = comb.add %362, %c1_i4 : i4
      llhd.drv %nxt_bycnt, %363 after %0 : i4
      cf.br ^bb1
    ^bb84:  // pred: ^bb82
      %364 = llhd.prb %byte_cnt : i4
      llhd.drv %nxt_bycnt, %364 after %0 : i4
      cf.br ^bb1
    ^bb85:  // pred: ^bb62
      %365 = comb.icmp ceq %216, %c-2_i3 : i3
      cf.cond_br %365, ^bb86, ^bb106
    ^bb86:  // pred: ^bb85
      %366 = llhd.prb %a0_scl_clr : i1
      cf.cond_br %366, ^bb87, ^bb88
    ^bb87:  // pred: ^bb86
      llhd.drv %nxt_scl, %false after %0 : i1
      cf.br ^bb91
    ^bb88:  // pred: ^bb86
      %367 = llhd.prb %bcnt_eql : i1
      cf.cond_br %367, ^bb89, ^bb90
    ^bb89:  // pred: ^bb88
      llhd.drv %nxt_scl, %true after %0 : i1
      cf.br ^bb91
    ^bb90:  // pred: ^bb88
      %368 = llhd.prb %scl_out : i1
      llhd.drv %nxt_scl, %368 after %0 : i1
      cf.br ^bb91
    ^bb91:  // 3 preds: ^bb87, ^bb89, ^bb90
      %369 = llhd.prb %hold_eq : i1
      cf.cond_br %369, ^bb92, ^bb93
    ^bb92:  // pred: ^bb91
      %370 = llhd.prb %addr0_sda : i1
      llhd.drv %nxt_sda, %370 after %0 : i1
      cf.br ^bb94
    ^bb93:  // pred: ^bb91
      %371 = llhd.prb %sda_out : i1
      llhd.drv %nxt_sda, %371 after %0 : i1
      cf.br ^bb94
    ^bb94:  // 2 preds: ^bb92, ^bb93
      %372 = llhd.prb %addr0_end : i1
      %373 = llhd.prb %bcnt_clr : i1
      %374 = comb.or %372, %373 : i1
      cf.cond_br %374, ^bb95, ^bb96
    ^bb95:  // pred: ^bb94
      llhd.drv %nxt_bcnt, %c0_i24 after %0 : i24
      cf.br ^bb99
    ^bb96:  // pred: ^bb94
      %375 = llhd.prb %addr_bcnt_plus : i1
      %376 = llhd.prb %bcnt_eq0 : i1
      %377 = comb.xor %376, %true : i1
      %378 = comb.or %375, %377 : i1
      cf.cond_br %378, ^bb97, ^bb98
    ^bb97:  // pred: ^bb96
      %379 = llhd.prb %bit_cnt : i24
      %380 = comb.add %379, %c1_i24 : i24
      llhd.drv %nxt_bcnt, %380 after %0 : i24
      cf.br ^bb99
    ^bb98:  // pred: ^bb96
      %381 = llhd.prb %bit_cnt : i24
      llhd.drv %nxt_bcnt, %381 after %0 : i24
      cf.br ^bb99
    ^bb99:  // 3 preds: ^bb95, ^bb97, ^bb98
      %382 = llhd.prb %addr0_end : i1
      cf.cond_br %382, ^bb100, ^bb101
    ^bb100:  // pred: ^bb99
      llhd.drv %nxt_bycnt, %c0_i4 after %0 : i4
      cf.br ^bb1
    ^bb101:  // pred: ^bb99
      %383 = llhd.prb %bycnt_eq8 : i1
      cf.cond_br %383, ^bb102, ^bb103
    ^bb102:  // pred: ^bb101
      %384 = llhd.prb %byte_cnt : i4
      llhd.drv %nxt_bycnt, %384 after %0 : i4
      cf.br ^bb1
    ^bb103:  // pred: ^bb101
      %385 = llhd.prb %bycnt_plus : i1
      cf.cond_br %385, ^bb104, ^bb105
    ^bb104:  // pred: ^bb103
      %386 = llhd.prb %byte_cnt : i4
      %387 = comb.add %386, %c1_i4 : i4
      llhd.drv %nxt_bycnt, %387 after %0 : i4
      cf.br ^bb1
    ^bb105:  // pred: ^bb103
      %388 = llhd.prb %byte_cnt : i4
      llhd.drv %nxt_bycnt, %388 after %0 : i4
      cf.br ^bb1
    ^bb106:  // pred: ^bb85
      %389 = comb.icmp ceq %216, %c-1_i3 : i3
      cf.cond_br %389, ^bb107, ^bb125
    ^bb107:  // pred: ^bb106
      %390 = llhd.prb %bcnt_eqh : i1
      %391 = llhd.prb %f_scl_1 : i1
      %392 = comb.or %390, %391 : i1
      cf.cond_br %392, ^bb108, ^bb109
    ^bb108:  // pred: ^bb107
      llhd.drv %nxt_scl, %false after %0 : i1
      cf.br ^bb112
    ^bb109:  // pred: ^bb107
      %393 = llhd.prb %bcnt_eql : i1
      %394 = llhd.prb %scl_out : i1
      %395 = comb.xor %394, %true : i1
      %396 = comb.and %393, %395 : i1
      cf.cond_br %396, ^bb110, ^bb111
    ^bb110:  // pred: ^bb109
      llhd.drv %nxt_scl, %true after %0 : i1
      cf.br ^bb112
    ^bb111:  // pred: ^bb109
      %397 = llhd.prb %scl_out : i1
      llhd.drv %nxt_scl, %397 after %0 : i1
      cf.br ^bb112
    ^bb112:  // 3 preds: ^bb108, ^bb110, ^bb111
      %398 = llhd.prb %hold_eq : i1
      cf.cond_br %398, ^bb113, ^bb114
    ^bb113:  // pred: ^bb112
      %399 = llhd.prb %addr1_sda : i1
      llhd.drv %nxt_sda, %399 after %0 : i1
      cf.br ^bb115
    ^bb114:  // pred: ^bb112
      %400 = llhd.prb %sda_out : i1
      llhd.drv %nxt_sda, %400 after %0 : i1
      cf.br ^bb115
    ^bb115:  // 2 preds: ^bb113, ^bb114
      %401 = llhd.prb %bcnt_clr : i1
      %402 = llhd.prb %addr1_end : i1
      %403 = comb.or %401, %402 : i1
      cf.cond_br %403, ^bb116, ^bb117
    ^bb116:  // pred: ^bb115
      llhd.drv %nxt_bcnt, %c0_i24 after %0 : i24
      cf.br ^bb120
    ^bb117:  // pred: ^bb115
      %404 = llhd.prb %addr_bcnt_plus : i1
      %405 = llhd.prb %bcnt_eq0 : i1
      %406 = comb.xor %405, %true : i1
      %407 = comb.or %404, %406 : i1
      cf.cond_br %407, ^bb118, ^bb119
    ^bb118:  // pred: ^bb117
      %408 = llhd.prb %bit_cnt : i24
      %409 = comb.add %408, %c1_i24 : i24
      llhd.drv %nxt_bcnt, %409 after %0 : i24
      cf.br ^bb120
    ^bb119:  // pred: ^bb117
      %410 = llhd.prb %bit_cnt : i24
      llhd.drv %nxt_bcnt, %410 after %0 : i24
      cf.br ^bb120
    ^bb120:  // 3 preds: ^bb116, ^bb118, ^bb119
      %411 = llhd.prb %addr1_end : i1
      cf.cond_br %411, ^bb121, ^bb122
    ^bb121:  // pred: ^bb120
      llhd.drv %nxt_bycnt, %c0_i4 after %0 : i4
      cf.br ^bb1
    ^bb122:  // pred: ^bb120
      %412 = llhd.prb %bycnt_plus : i1
      cf.cond_br %412, ^bb123, ^bb124
    ^bb123:  // pred: ^bb122
      %413 = llhd.prb %byte_cnt : i4
      %414 = comb.add %413, %c1_i4 : i4
      llhd.drv %nxt_bycnt, %414 after %0 : i4
      cf.br ^bb1
    ^bb124:  // pred: ^bb122
      %415 = llhd.prb %byte_cnt : i4
      llhd.drv %nxt_bycnt, %415 after %0 : i4
      cf.br ^bb1
    ^bb125:  // pred: ^bb106
      %416 = comb.icmp ceq %216, %c-3_i3 : i3
      cf.cond_br %416, ^bb126, ^bb150
    ^bb126:  // pred: ^bb125
      %417 = llhd.prb %bcnt_eqh : i1
      %418 = llhd.prb %f_scl_1 : i1
      %419 = comb.or %417, %418 : i1
      cf.cond_br %419, ^bb127, ^bb128
    ^bb127:  // pred: ^bb126
      llhd.drv %nxt_scl, %false after %0 : i1
      cf.br ^bb131
    ^bb128:  // pred: ^bb126
      %420 = llhd.prb %bcnt_eql : i1
      %421 = llhd.prb %scl_out : i1
      %422 = comb.xor %421, %true : i1
      %423 = comb.and %420, %422 : i1
      cf.cond_br %423, ^bb129, ^bb130
    ^bb129:  // pred: ^bb128
      llhd.drv %nxt_scl, %true after %0 : i1
      cf.br ^bb131
    ^bb130:  // pred: ^bb128
      %424 = llhd.prb %scl_out : i1
      llhd.drv %nxt_scl, %424 after %0 : i1
      cf.br ^bb131
    ^bb131:  // 3 preds: ^bb127, ^bb129, ^bb130
      %425 = llhd.prb %hold_eq : i1
      %426 = llhd.prb %data_by_eq0 : i1
      %427 = llhd.prb %f_empty : i1
      %428 = comb.and %426, %427 : i1
      %429 = comb.or %425, %428 : i1
      cf.cond_br %429, ^bb132, ^bb135
    ^bb132:  // pred: ^bb131
      %430 = llhd.prb %tx_empty_26 : i1
      cf.cond_br %430, ^bb133, ^bb134
    ^bb133:  // pred: ^bb132
      %431 = llhd.prb %sda_out : i1
      llhd.drv %nxt_sda, %431 after %0 : i1
      cf.br ^bb138
    ^bb134:  // pred: ^bb132
      %432 = llhd.prb %data_sda : i1
      llhd.drv %nxt_sda, %432 after %0 : i1
      cf.br ^bb138
    ^bb135:  // pred: ^bb131
      %433 = llhd.prb %tx_juedge : i1
      cf.cond_br %433, ^bb136, ^bb137
    ^bb136:  // pred: ^bb135
      llhd.drv %nxt_sda, %true after %0 : i1
      cf.br ^bb138
    ^bb137:  // pred: ^bb135
      %434 = llhd.prb %sda_out : i1
      llhd.drv %nxt_sda, %434 after %0 : i1
      cf.br ^bb138
    ^bb138:  // 4 preds: ^bb133, ^bb134, ^bb136, ^bb137
      %435 = llhd.prb %bcnt_clr : i1
      %436 = llhd.prb %data_end : i1
      %437 = comb.or %435, %436 : i1
      cf.cond_br %437, ^bb139, ^bb140
    ^bb139:  // pred: ^bb138
      llhd.drv %nxt_bcnt, %c0_i24 after %0 : i24
      cf.br ^bb143
    ^bb140:  // pred: ^bb138
      %438 = llhd.prb %data_bcnt_plus : i1
      %439 = llhd.prb %bcnt_eq0 : i1
      %440 = comb.xor %439, %true : i1
      %441 = comb.or %438, %440 : i1
      cf.cond_br %441, ^bb141, ^bb142
    ^bb141:  // pred: ^bb140
      %442 = llhd.prb %bit_cnt : i24
      %443 = comb.add %442, %c1_i24 : i24
      llhd.drv %nxt_bcnt, %443 after %0 : i24
      cf.br ^bb143
    ^bb142:  // pred: ^bb140
      %444 = llhd.prb %bit_cnt : i24
      llhd.drv %nxt_bcnt, %444 after %0 : i24
      cf.br ^bb143
    ^bb143:  // 3 preds: ^bb139, ^bb141, ^bb142
      %445 = llhd.prb %data_end : i1
      %446 = llhd.prb %data_bycnt_clr : i1
      %447 = comb.or %445, %446 : i1
      cf.cond_br %447, ^bb144, ^bb145
    ^bb144:  // pred: ^bb143
      llhd.drv %nxt_bycnt, %c0_i4 after %0 : i4
      cf.br ^bb1
    ^bb145:  // pred: ^bb143
      %448 = llhd.prb %bycnt_eq8 : i1
      cf.cond_br %448, ^bb146, ^bb147
    ^bb146:  // pred: ^bb145
      %449 = llhd.prb %byte_cnt : i4
      llhd.drv %nxt_bycnt, %449 after %0 : i4
      cf.br ^bb1
    ^bb147:  // pred: ^bb145
      %450 = llhd.prb %bycnt_plus : i1
      cf.cond_br %450, ^bb148, ^bb149
    ^bb148:  // pred: ^bb147
      %451 = llhd.prb %byte_cnt : i4
      %452 = comb.add %451, %c1_i4 : i4
      llhd.drv %nxt_bycnt, %452 after %0 : i4
      cf.br ^bb1
    ^bb149:  // pred: ^bb147
      %453 = llhd.prb %byte_cnt : i4
      llhd.drv %nxt_bycnt, %453 after %0 : i4
      cf.br ^bb1
    ^bb150:  // pred: ^bb125
      %454 = llhd.prb %bycnt_eq1 : i1
      cf.cond_br %454, ^bb151, ^bb152
    ^bb151:  // pred: ^bb150
      llhd.drv %nxt_scl, %true after %0 : i1
      cf.br ^bb153
    ^bb152:  // pred: ^bb150
      %455 = llhd.prb %scl_out : i1
      llhd.drv %nxt_scl, %455 after %0 : i1
      cf.br ^bb153
    ^bb153:  // 2 preds: ^bb151, ^bb152
      %456 = llhd.prb %bycnt_eq0 : i1
      %457 = llhd.prb %bcnt_eq4 : i1
      %458 = comb.and %456, %457 : i1
      cf.cond_br %458, ^bb154, ^bb155
    ^bb154:  // pred: ^bb153
      llhd.drv %nxt_sda, %false after %0 : i1
      cf.br ^bb158
    ^bb155:  // pred: ^bb153
      %459 = llhd.prb %bycnt_eq2 : i1
      cf.cond_br %459, ^bb156, ^bb157
    ^bb156:  // pred: ^bb155
      llhd.drv %nxt_sda, %true after %0 : i1
      cf.br ^bb158
    ^bb157:  // pred: ^bb155
      %460 = llhd.prb %sda_out : i1
      llhd.drv %nxt_sda, %460 after %0 : i1
      cf.br ^bb158
    ^bb158:  // 3 preds: ^bb154, ^bb156, ^bb157
      %461 = llhd.prb %bit_cnt : i24
      %462 = llhd.prb %i2c_hcnt_6 : i24
      %463 = comb.icmp eq %461, %462 : i24
      %464 = llhd.prb %stop_end : i1
      %465 = comb.or %463, %464 : i1
      cf.cond_br %465, ^bb159, ^bb160
    ^bb159:  // pred: ^bb158
      llhd.drv %nxt_bcnt, %c0_i24 after %0 : i24
      cf.br ^bb161
    ^bb160:  // pred: ^bb158
      %466 = llhd.prb %bit_cnt : i24
      %467 = comb.add %466, %c1_i24 : i24
      llhd.drv %nxt_bcnt, %467 after %0 : i24
      cf.br ^bb161
    ^bb161:  // 2 preds: ^bb159, ^bb160
      %468 = llhd.prb %stop_end : i1
      cf.cond_br %468, ^bb162, ^bb163
    ^bb162:  // pred: ^bb161
      llhd.drv %nxt_bycnt, %c0_i4 after %0 : i4
      cf.br ^bb1
    ^bb163:  // pred: ^bb161
      %469 = llhd.prb %bycnt_eq3 : i1
      cf.cond_br %469, ^bb164, ^bb165
    ^bb164:  // pred: ^bb163
      %470 = llhd.prb %byte_cnt : i4
      llhd.drv %nxt_bycnt, %470 after %0 : i4
      cf.br ^bb1
    ^bb165:  // pred: ^bb163
      %471 = llhd.prb %bit_cnt : i24
      %472 = llhd.prb %i2c_hcnt_6 : i24
      %473 = comb.icmp eq %471, %472 : i24
      cf.cond_br %473, ^bb166, ^bb167
    ^bb166:  // pred: ^bb165
      %474 = llhd.prb %byte_cnt : i4
      %475 = comb.add %474, %c1_i4 : i4
      llhd.drv %nxt_bycnt, %475 after %0 : i4
      cf.br ^bb1
    ^bb167:  // pred: ^bb165
      %476 = llhd.prb %byte_cnt : i4
      llhd.drv %nxt_bycnt, %476 after %0 : i4
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb11
      %216 = llhd.prb %clk_0 : i1
      %217 = llhd.prb %rst_n_23 : i1
      llhd.wait (%36, %60 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %218 = llhd.prb %clk_0 : i1
      %219 = comb.xor bin %216, %true : i1
      %220 = comb.and bin %219, %218 : i1
      %221 = llhd.prb %rst_n_23 : i1
      %222 = comb.xor bin %221, %true : i1
      %223 = comb.and bin %217, %222 : i1
      %224 = comb.or bin %220, %223 : i1
      cf.cond_br %224, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %225 = llhd.prb %rst_n_23 : i1
      %226 = comb.xor %225, %true : i1
      cf.cond_br %226, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %scl_out, %true after %1 : i1
      llhd.drv %sda_out, %true after %1 : i1
      llhd.drv %bit_cnt, %c0_i24 after %1 : i24
      llhd.drv %byte_cnt, %c0_i4 after %1 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %227 = llhd.prb %nxt_scl : i1
      llhd.drv %scl_out, %227 after %1 : i1
      %228 = llhd.prb %lose_arbi : i1
      %229 = llhd.prb %hold_eq : i1
      %230 = comb.and %228, %229 : i1
      cf.cond_br %230, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %sda_out, %true after %1 : i1
      cf.br ^bb8
    ^bb7:  // pred: ^bb5
      %231 = llhd.prb %nxt_sda : i1
      llhd.drv %sda_out, %231 after %1 : i1
      cf.br ^bb8
    ^bb8:  // 2 preds: ^bb6, ^bb7
      %232 = llhd.prb %wr_clk_div_28 : i1
      cf.cond_br %232, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      llhd.drv %bit_cnt, %c0_i24 after %1 : i24
      cf.br ^bb11
    ^bb10:  // pred: ^bb8
      %233 = llhd.prb %nxt_bcnt : i24
      llhd.drv %bit_cnt, %233 after %1 : i24
      cf.br ^bb11
    ^bb11:  // 2 preds: ^bb9, ^bb10
      %234 = llhd.prb %nxt_bycnt : i4
      llhd.drv %byte_cnt, %234 after %1 : i4
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %216 = llhd.prb %clk_0 : i1
      %217 = llhd.prb %rst_n_23 : i1
      llhd.wait (%36, %60 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %218 = llhd.prb %clk_0 : i1
      %219 = comb.xor bin %216, %true : i1
      %220 = comb.and bin %219, %218 : i1
      %221 = llhd.prb %rst_n_23 : i1
      %222 = comb.xor bin %221, %true : i1
      %223 = comb.and bin %217, %222 : i1
      %224 = comb.or bin %220, %223 : i1
      cf.cond_br %224, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %225 = llhd.prb %rst_n_23 : i1
      %226 = comb.xor %225, %true : i1
      cf.cond_br %226, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i2cm_stop_d, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %227 = llhd.prb %i2cm_stop_18 : i1
      llhd.drv %i2cm_stop_d, %227 after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb11, ^bb12
      %216 = llhd.prb %clk_0 : i1
      %217 = llhd.prb %rst_n_23 : i1
      llhd.wait (%36, %60 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %218 = llhd.prb %clk_0 : i1
      %219 = comb.xor bin %216, %true : i1
      %220 = comb.and bin %219, %218 : i1
      %221 = llhd.prb %rst_n_23 : i1
      %222 = comb.xor bin %221, %true : i1
      %223 = comb.and bin %217, %222 : i1
      %224 = comb.or bin %220, %223 : i1
      cf.cond_br %224, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %225 = llhd.prb %rst_n_23 : i1
      %226 = comb.xor %225, %true : i1
      cf.cond_br %226, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %sr_flag, %false after %1 : i1
      llhd.drv %rw_flag, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %227 = llhd.prb %sta_idle : i1
      cf.cond_br %227, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %sr_flag, %false after %1 : i1
      llhd.drv %rw_flag, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %228 = llhd.prb %addr0_end : i1
      %229 = llhd.prb %sr_flag : i1
      %230 = comb.and %228, %229 : i1
      %231 = llhd.prb %stop_end : i1
      %232 = comb.or %230, %231 : i1
      cf.cond_br %232, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %sr_flag, %false after %1 : i1
      cf.br ^bb11
    ^bb9:  // pred: ^bb7
      %233 = llhd.prb %set_sr_flag : i1
      cf.cond_br %233, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      llhd.drv %sr_flag, %true after %1 : i1
      cf.br ^bb11
    ^bb11:  // 3 preds: ^bb8, ^bb9, ^bb10
      %234 = llhd.prb %sta_addr0 : i1
      %235 = llhd.prb %bycnt_eq7 : i1
      %236 = llhd.prb %r_scl_d_22 : i1
      %237 = comb.and %234, %235, %236 : i1
      cf.cond_br %237, ^bb12, ^bb1
    ^bb12:  // pred: ^bb11
      %238 = llhd.prb %sda_out : i1
      llhd.drv %rw_flag, %238 after %1 : i1
      cf.br ^bb1
    }
    %78 = comb.extract %69 from 8 : (i10) -> i1
    %79 = comb.xor %13, %true : i1
    %80 = comb.and %78, %79 : i1
    %81 = comb.or %40, %22 : i1
    %82 = comb.and %80, %81 : i1
    llhd.drv %set_sr_flag, %82 after %0 : i1
    %83 = llhd.prb %sta_special : i1
    %84 = comb.and %83, %34, %42 : i1
    llhd.drv %special_end, %84 after %0 : i1
    %85 = llhd.prb %sta_idle : i1
    %86 = comb.xor %67, %true : i1
    %87 = llhd.prb %i2c_busy : i1
    %88 = comb.xor %87, %true : i1
    %89 = comb.and %85, %86, %88 : i1
    llhd.drv %idle_end, %89 after %0 : i1
    %90 = llhd.prb %sta_start : i1
    %91 = comb.and %90, %10, %42 : i1
    llhd.drv %start_end, %91 after %0 : i1
    %92 = llhd.prb %sta_restart : i1
    %93 = comb.and %92, %10, %42 : i1
    llhd.drv %restart_end, %93 after %0 : i1
    %94 = llhd.prb %sta_addr0 : i1
    %95 = comb.mux %52, %28, %42 : i1
    %96 = comb.and %94, %34, %95 : i1
    llhd.drv %addr0_end, %96 after %0 : i1
    %97 = comb.and %76, %34, %95 : i1
    llhd.drv %addr1_end, %97 after %0 : i1
    %98 = llhd.prb %sta_data : i1
    %99 = comb.and %58, %13 : i1
    %100 = comb.and %12, %79 : i1
    %101 = comb.or %99, %100, %66, %11, %124 : i1
    %102 = comb.and %98, %34, %35, %101 {sv.namehint = "data_end_1"} : i1
    %103 = comb.and %98, %30 : i1
    %104 = llhd.prb %i2cm_stop_18 : i1
    %105 = llhd.prb %i2cm_stop_d : i1
    %106 = comb.xor %105, %true : i1
    %107 = comb.and %103, %104, %106, %67 {sv.namehint = "data_end_2"} : i1
    %108 = comb.and %tx_empty_d, %86 : i1
    %109 = comb.and %103, %108, %13 : i1
    llhd.drv %data_end_3, %109 after %0 : i1
    %110 = llhd.prb %data_end_3 : i1
    %111 = comb.or %110, %107, %102 : i1
    llhd.drv %data_end, %111 after %0 : i1
    %112 = comb.and %73, %33 : i1
    llhd.drv %stop_end, %112 after %0 : i1
    %113 = comb.xor %49, %true : i1
    %114 = comb.and %51, %113 : i1
    %115 = comb.extract %69 from 9 : (i10) -> i1
    %116 = comb.xor %78, %true : i1
    %117 = comb.and %116, %13, %58 : i1
    %118 = comb.or %115, %80, %117 : i1
    %119 = comb.and %86, %118 : i1
    %120 = comb.or %119, %110 : i1
    %121 = comb.xor %114, %true : i1
    %122 = comb.and %121, %120 : i1
    llhd.drv %to_restart, %122 after %0 : i1
    %123 = comb.and %67, %104 : i1
    %124 = comb.and %123, %79 {sv.namehint = "tx_empty_stop"} : i1
    %125 = comb.or %80, %117 : i1
    %126 = comb.and %86, %125 : i1
    llhd.drv %addr1_to_sr, %126 after %0 : i1
    %127 = comb.icmp eq %4, %i2c_lcnt : i24
    %128 = comb.xor %15, %true : i1
    %129 = comb.and %127, %128 : i1
    llhd.drv %bcnt_eql, %129 after %0 : i1
    %130 = comb.icmp eq %4, %48 : i24
    %131 = comb.and %130, %15 : i1
    llhd.drv %bcnt_eqh, %131 after %0 : i1
    %132 = comb.icmp eq %4, %c0_i24 : i24
    llhd.drv %bcnt_eq0, %132 after %0 : i1
    %133 = comb.icmp eq %4, %c4_i24 : i24
    llhd.drv %bcnt_eq4, %133 after %0 : i1
    %134 = comb.or %29, %28 : i1
    %135 = comb.xor %52, %true : i1
    %136 = comb.and %135, %42 : i1
    %137 = comb.or %134, %136 : i1
    llhd.drv %bcnt_clr, %137 after %0 : i1
    llhd.drv %data_by_eq0, %103 after %0 : i1
    %138 = comb.and %38, %67 : i1
    llhd.drv %tx_juedge, %138 after %0 : i1
    %139 = llhd.prb %bcnt_plus_hs : i1
    %140 = comb.or %57, %43 : i1
    %141 = comb.mux %52, %139, %140 : i1
    llhd.drv %addr_bcnt_plus, %141 after %0 : i1
    %142 = comb.xor %52, %true : i1
    %143 = comb.and %142, %42 : i1
    %144 = comb.or %143, %28 : i1
    llhd.drv %a0_scl_clr, %144 after %0 : i1
    %145 = comb.xor %104, %true : i1
    %146 = comb.and %30, %145, %67 : i1
    %147 = comb.and %30, %41 : i1
    %148 = comb.or %147, %141 : i1
    %149 = comb.xor %146, %true : i1
    %150 = comb.and %149, %148 : i1
    llhd.drv %data_bcnt_plus, %150 after %0 : i1
    %151 = comb.and %30, %15 : i1
    %152 = comb.xor %151, %true : i1
    %153 = comb.or %152, %57 : i1
    llhd.drv %bcnt_plus_hs, %153 after %0 : i1
    %154 = comb.and %34, %28 : i1
    %155 = comb.and %34, %42 : i1
    %156 = comb.mux %52, %154, %155 : i1
    llhd.drv %data_bycnt_clr, %156 after %0 : i1
    llhd.drv %bycnt_plus, %95 after %0 : i1
    %157 = comb.icmp eq %5, %c0_i4 : i4
    llhd.drv %bycnt_eq0, %157 after %0 : i1
    %158 = comb.icmp eq %5, %c1_i4 : i4
    llhd.drv %bycnt_eq1, %158 after %0 : i1
    %159 = comb.icmp eq %5, %c2_i4 : i4
    llhd.drv %bycnt_eq2, %159 after %0 : i1
    %160 = comb.icmp eq %5, %c3_i4 : i4
    llhd.drv %bycnt_eq3, %160 after %0 : i1
    %161 = comb.icmp eq %5, %c7_i4 : i4
    llhd.drv %bycnt_eq7, %161 after %0 : i1
    %162 = comb.icmp eq %5, %c-8_i4 : i4
    llhd.drv %bycnt_eq8, %162 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 11 preds: ^bb0, ^bb3, ^bb5, ^bb7, ^bb9, ^bb11, ^bb13, ^bb15, ^bb17, ^bb19, ^bb20
      llhd.wait (%49, %58, %69, %50, %5, %13, %45, %51, %19 : i1, i1, i10, i3, i4, i1, i10, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %216 = llhd.prb %byte_cnt : i4
      %217 = comb.icmp ceq %216, %c0_i4 : i4
      cf.cond_br %217, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %spec_sbyte, %false after %0 : i1
      llhd.drv %spec_hsmc, %false after %0 : i1
      %218 = llhd.prb %i2cm_amode_11 : i1
      %219 = llhd.prb %i2cm_gcall_14 : i1
      %220 = llhd.prb %i2c_addr_3 : i10
      %221 = comb.extract %220 from 6 : (i10) -> i1
      %222 = comb.xor %219, %true : i1
      %223 = comb.and %222, %221 : i1
      %224 = comb.or %218, %223 : i1
      llhd.drv %addr0_sda, %224 after %0 : i1
      %225 = llhd.prb %i2c_addr_3 : i10
      %226 = comb.extract %225 from 7 : (i10) -> i1
      llhd.drv %addr1_sda, %226 after %0 : i1
      %227 = llhd.prb %rw_flag : i1
      %228 = llhd.prb %tx_rd_data_27 : i10
      %229 = comb.extract %228 from 7 : (i10) -> i1
      %230 = comb.or %227, %229 : i1
      llhd.drv %data_sda, %230 after %0 : i1
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      %231 = comb.icmp ceq %216, %c1_i4 : i4
      cf.cond_br %231, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %spec_sbyte, %false after %0 : i1
      llhd.drv %spec_hsmc, %false after %0 : i1
      %232 = llhd.prb %i2cm_amode_11 : i1
      %233 = llhd.prb %i2cm_gcall_14 : i1
      %234 = llhd.prb %i2c_addr_3 : i10
      %235 = comb.extract %234 from 5 : (i10) -> i1
      %236 = comb.xor %233, %true : i1
      %237 = comb.and %236, %235 : i1
      %238 = comb.or %232, %237 : i1
      llhd.drv %addr0_sda, %238 after %0 : i1
      %239 = llhd.prb %i2c_addr_3 : i10
      %240 = comb.extract %239 from 6 : (i10) -> i1
      llhd.drv %addr1_sda, %240 after %0 : i1
      %241 = llhd.prb %rw_flag : i1
      %242 = llhd.prb %tx_rd_data_27 : i10
      %243 = comb.extract %242 from 6 : (i10) -> i1
      %244 = comb.or %241, %243 : i1
      llhd.drv %data_sda, %244 after %0 : i1
      cf.br ^bb1
    ^bb6:  // pred: ^bb4
      %245 = comb.icmp ceq %216, %c2_i4 : i4
      cf.cond_br %245, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      llhd.drv %spec_sbyte, %false after %0 : i1
      llhd.drv %spec_hsmc, %false after %0 : i1
      %246 = llhd.prb %i2cm_amode_11 : i1
      %247 = llhd.prb %i2cm_gcall_14 : i1
      %248 = llhd.prb %i2c_addr_3 : i10
      %249 = comb.extract %248 from 4 : (i10) -> i1
      %250 = comb.xor %247, %true : i1
      %251 = comb.and %250, %249 : i1
      %252 = comb.or %246, %251 : i1
      llhd.drv %addr0_sda, %252 after %0 : i1
      %253 = llhd.prb %i2c_addr_3 : i10
      %254 = comb.extract %253 from 5 : (i10) -> i1
      llhd.drv %addr1_sda, %254 after %0 : i1
      %255 = llhd.prb %rw_flag : i1
      %256 = llhd.prb %tx_rd_data_27 : i10
      %257 = comb.extract %256 from 5 : (i10) -> i1
      %258 = comb.or %255, %257 : i1
      llhd.drv %data_sda, %258 after %0 : i1
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %259 = comb.icmp ceq %216, %c3_i4 : i4
      cf.cond_br %259, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      llhd.drv %spec_sbyte, %false after %0 : i1
      llhd.drv %spec_hsmc, %false after %0 : i1
      %260 = llhd.prb %i2cm_amode_11 : i1
      %261 = llhd.prb %i2cm_gcall_14 : i1
      %262 = llhd.prb %i2c_addr_3 : i10
      %263 = comb.extract %262 from 3 : (i10) -> i1
      %264 = comb.xor %261, %true : i1
      %265 = comb.and %264, %263 : i1
      %266 = comb.or %260, %265 : i1
      llhd.drv %addr0_sda, %266 after %0 : i1
      %267 = llhd.prb %i2c_addr_3 : i10
      %268 = comb.extract %267 from 4 : (i10) -> i1
      llhd.drv %addr1_sda, %268 after %0 : i1
      %269 = llhd.prb %rw_flag : i1
      %270 = llhd.prb %tx_rd_data_27 : i10
      %271 = comb.extract %270 from 4 : (i10) -> i1
      %272 = comb.or %269, %271 : i1
      llhd.drv %data_sda, %272 after %0 : i1
      cf.br ^bb1
    ^bb10:  // pred: ^bb8
      %273 = comb.icmp ceq %216, %c4_i4 : i4
      cf.cond_br %273, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      llhd.drv %spec_sbyte, %false after %0 : i1
      llhd.drv %spec_hsmc, %true after %0 : i1
      %274 = llhd.prb %i2cm_amode_11 : i1
      %275 = llhd.prb %i2cm_gcall_14 : i1
      %276 = llhd.prb %i2c_addr_3 : i10
      %277 = comb.extract %276 from 2 : (i10) -> i1
      %278 = comb.xor %275, %true : i1
      %279 = comb.xor %274, %true : i1
      %280 = comb.and %279, %278, %277 : i1
      llhd.drv %addr0_sda, %280 after %0 : i1
      %281 = llhd.prb %i2c_addr_3 : i10
      %282 = comb.extract %281 from 3 : (i10) -> i1
      llhd.drv %addr1_sda, %282 after %0 : i1
      %283 = llhd.prb %rw_flag : i1
      %284 = llhd.prb %tx_rd_data_27 : i10
      %285 = comb.extract %284 from 3 : (i10) -> i1
      %286 = comb.or %283, %285 : i1
      llhd.drv %data_sda, %286 after %0 : i1
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      %287 = comb.icmp ceq %216, %c5_i4 : i4
      cf.cond_br %287, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      llhd.drv %spec_sbyte, %false after %0 : i1
      %288 = llhd.prb %i2cm_code_12 : i3
      %289 = comb.extract %288 from 2 : (i3) -> i1
      llhd.drv %spec_hsmc, %289 after %0 : i1
      %290 = llhd.prb %i2cm_amode_11 : i1
      %291 = llhd.prb %i2c_addr_3 : i10
      %292 = comb.extract %291 from 9 : (i10) -> i1
      %293 = llhd.prb %i2cm_gcall_14 : i1
      %294 = comb.extract %291 from 1 : (i10) -> i1
      %295 = comb.xor %293, %true : i1
      %296 = comb.and %295, %294 : i1
      %297 = comb.mux %290, %292, %296 : i1
      llhd.drv %addr0_sda, %297 after %0 : i1
      %298 = llhd.prb %i2c_addr_3 : i10
      %299 = comb.extract %298 from 2 : (i10) -> i1
      llhd.drv %addr1_sda, %299 after %0 : i1
      %300 = llhd.prb %rw_flag : i1
      %301 = llhd.prb %tx_rd_data_27 : i10
      %302 = comb.extract %301 from 2 : (i10) -> i1
      %303 = comb.or %300, %302 : i1
      llhd.drv %data_sda, %303 after %0 : i1
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      %304 = comb.icmp ceq %216, %c6_i4 : i4
      cf.cond_br %304, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      llhd.drv %spec_sbyte, %false after %0 : i1
      %305 = llhd.prb %i2cm_code_12 : i3
      %306 = comb.extract %305 from 1 : (i3) -> i1
      llhd.drv %spec_hsmc, %306 after %0 : i1
      %307 = llhd.prb %i2cm_amode_11 : i1
      %308 = llhd.prb %i2c_addr_3 : i10
      %309 = comb.extract %308 from 8 : (i10) -> i1
      %310 = llhd.prb %i2cm_gcall_14 : i1
      %311 = comb.extract %308 from 0 : (i10) -> i1
      %312 = comb.xor %310, %true : i1
      %313 = comb.and %312, %311 : i1
      %314 = comb.mux %307, %309, %313 : i1
      llhd.drv %addr0_sda, %314 after %0 : i1
      %315 = llhd.prb %i2c_addr_3 : i10
      %316 = comb.extract %315 from 1 : (i10) -> i1
      llhd.drv %addr1_sda, %316 after %0 : i1
      %317 = llhd.prb %rw_flag : i1
      %318 = llhd.prb %tx_rd_data_27 : i10
      %319 = comb.extract %318 from 1 : (i10) -> i1
      %320 = comb.or %317, %319 : i1
      llhd.drv %data_sda, %320 after %0 : i1
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      %321 = comb.icmp ceq %216, %c7_i4 : i4
      cf.cond_br %321, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      llhd.drv %spec_sbyte, %true after %0 : i1
      %322 = llhd.prb %i2cm_code_12 : i3
      %323 = comb.extract %322 from 0 : (i3) -> i1
      llhd.drv %spec_hsmc, %323 after %0 : i1
      %324 = llhd.prb %sr_flag : i1
      %325 = llhd.prb %tx_rd_data_27 : i10
      %326 = comb.extract %325 from 8 : (i10) -> i1
      %327 = llhd.prb %i2cm_amode_11 : i1
      %328 = llhd.prb %i2cm_gcall_14 : i1
      %329 = comb.xor %328, %true : i1
      %330 = comb.xor %327, %true : i1
      %331 = comb.and %330, %329 : i1
      %332 = comb.or %324, %331 : i1
      %333 = comb.and %332, %326 : i1
      llhd.drv %addr0_sda, %333 after %0 : i1
      %334 = llhd.prb %i2c_addr_3 : i10
      %335 = comb.extract %334 from 0 : (i10) -> i1
      llhd.drv %addr1_sda, %335 after %0 : i1
      %336 = llhd.prb %rw_flag : i1
      %337 = llhd.prb %tx_rd_data_27 : i10
      %338 = comb.extract %337 from 0 : (i10) -> i1
      %339 = comb.or %336, %338 : i1
      llhd.drv %data_sda, %339 after %0 : i1
      cf.br ^bb1
    ^bb18:  // pred: ^bb16
      %340 = comb.icmp ceq %216, %c-8_i4 : i4
      cf.cond_br %340, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      llhd.drv %spec_sbyte, %true after %0 : i1
      llhd.drv %spec_hsmc, %true after %0 : i1
      llhd.drv %addr0_sda, %true after %0 : i1
      llhd.drv %addr1_sda, %true after %0 : i1
      %341 = llhd.prb %rw_flag : i1
      %342 = llhd.prb %re_nack : i1
      %343 = comb.xor %341, %true : i1
      %344 = comb.or %343, %342 : i1
      llhd.drv %data_sda, %344 after %0 : i1
      cf.br ^bb1
    ^bb20:  // pred: ^bb18
      llhd.drv %spec_sbyte, %true after %0 : i1
      llhd.drv %spec_hsmc, %false after %0 : i1
      llhd.drv %addr0_sda, %true after %0 : i1
      llhd.drv %addr1_sda, %true after %0 : i1
      llhd.drv %data_sda, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 13 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb7, ^bb9, ^bb11, ^bb13, ^bb15, ^bb17, ^bb19, ^bb21, ^bb22
      %216 = llhd.prb %clk_0 : i1
      %217 = llhd.prb %rst_n_23 : i1
      llhd.wait (%36, %60 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %218 = llhd.prb %clk_0 : i1
      %219 = comb.xor bin %216, %true : i1
      %220 = comb.and bin %219, %218 : i1
      %221 = llhd.prb %rst_n_23 : i1
      %222 = comb.xor bin %221, %true : i1
      %223 = comb.and bin %217, %222 : i1
      %224 = comb.or bin %220, %223 : i1
      cf.cond_br %224, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %225 = llhd.prb %rst_n_23 : i1
      %226 = comb.xor %225, %true : i1
      cf.cond_br %226, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i2cm_rx, %c0_i8 after %1 : i8
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %227 = llhd.prb %sta_data : i1
      %228 = llhd.prb %rw_flag : i1
      %229 = llhd.prb %r_scl_d_22 : i1
      %230 = comb.and %227, %228, %229 : i1
      cf.cond_br %230, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %231 = llhd.prb %byte_cnt : i4
      %232 = comb.icmp ceq %231, %c0_i4 : i4
      cf.cond_br %232, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %233 = llhd.sig.extract %i2cm_rx from %c-1_i3 : <i8> -> <i1>
      %234 = llhd.prb %i_sda_in_20 : i1
      llhd.drv %233, %234 after %1 : i1
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %235 = comb.icmp ceq %231, %c1_i4 : i4
      cf.cond_br %235, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %236 = llhd.sig.extract %i2cm_rx from %c-2_i3 : <i8> -> <i1>
      %237 = llhd.prb %i_sda_in_20 : i1
      llhd.drv %236, %237 after %1 : i1
      cf.br ^bb1
    ^bb10:  // pred: ^bb8
      %238 = comb.icmp ceq %231, %c2_i4 : i4
      cf.cond_br %238, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %239 = llhd.sig.extract %i2cm_rx from %c-3_i3 : <i8> -> <i1>
      %240 = llhd.prb %i_sda_in_20 : i1
      llhd.drv %239, %240 after %1 : i1
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      %241 = comb.icmp ceq %231, %c3_i4 : i4
      cf.cond_br %241, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      %242 = llhd.sig.extract %i2cm_rx from %c-4_i3 : <i8> -> <i1>
      %243 = llhd.prb %i_sda_in_20 : i1
      llhd.drv %242, %243 after %1 : i1
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      %244 = comb.icmp ceq %231, %c4_i4 : i4
      cf.cond_br %244, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      %245 = llhd.sig.extract %i2cm_rx from %c3_i3 : <i8> -> <i1>
      %246 = llhd.prb %i_sda_in_20 : i1
      llhd.drv %245, %246 after %1 : i1
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      %247 = comb.icmp ceq %231, %c5_i4 : i4
      cf.cond_br %247, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      %248 = llhd.sig.extract %i2cm_rx from %c2_i3 : <i8> -> <i1>
      %249 = llhd.prb %i_sda_in_20 : i1
      llhd.drv %248, %249 after %1 : i1
      cf.br ^bb1
    ^bb18:  // pred: ^bb16
      %250 = comb.icmp ceq %231, %c6_i4 : i4
      cf.cond_br %250, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %251 = llhd.sig.extract %i2cm_rx from %c1_i3 : <i8> -> <i1>
      %252 = llhd.prb %i_sda_in_20 : i1
      llhd.drv %251, %252 after %1 : i1
      cf.br ^bb1
    ^bb20:  // pred: ^bb18
      %253 = comb.icmp ceq %231, %c7_i4 : i4
      cf.cond_br %253, ^bb21, ^bb22
    ^bb21:  // pred: ^bb20
      %254 = llhd.sig.extract %i2cm_rx from %c0_i3 : <i8> -> <i1>
      %255 = llhd.prb %i_sda_in_20 : i1
      llhd.drv %254, %255 after %1 : i1
      cf.br ^bb1
    ^bb22:  // pred: ^bb20
      %256 = llhd.prb %i2cm_rx : i8
      llhd.drv %i2cm_rx, %256 after %1 : i8
      cf.br ^bb1
    }
    llhd.drv %f_empty, %108 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %216 = llhd.prb %clk_0 : i1
      %217 = llhd.prb %rst_n_23 : i1
      llhd.wait (%36, %60 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %218 = llhd.prb %clk_0 : i1
      %219 = comb.xor bin %216, %true : i1
      %220 = comb.and bin %219, %218 : i1
      %221 = llhd.prb %rst_n_23 : i1
      %222 = comb.xor bin %221, %true : i1
      %223 = comb.and bin %217, %222 : i1
      %224 = comb.or bin %220, %223 : i1
      cf.cond_br %224, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %225 = llhd.prb %rst_n_23 : i1
      %226 = comb.xor %225, %true : i1
      cf.cond_br %226, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %nack, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %227 = llhd.prb %stop_end : i1
      cf.cond_br %227, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %nack, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %228 = llhd.prb %bycnt_eq8 : i1
      %229 = llhd.prb %r_scl_d_22 : i1
      %230 = llhd.prb %sta_special : i1
      %231 = comb.xor %230, %true : i1
      %232 = comb.and %228, %229, %231 : i1
      cf.cond_br %232, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %233 = llhd.prb %i_sda_in_20 : i1
      llhd.drv %nack, %233 after %1 : i1
      cf.br ^bb1
    }
    %163 = comb.or %123, %116 : i1
    %164 = comb.and %163, %13, %98, %34 : i1
    llhd.drv %re_nack, %164 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %216 = llhd.prb %clk_0 : i1
      %217 = llhd.prb %rst_n_23 : i1
      llhd.wait (%36, %60 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %218 = llhd.prb %clk_0 : i1
      %219 = comb.xor bin %216, %true : i1
      %220 = comb.and bin %219, %218 : i1
      %221 = llhd.prb %rst_n_23 : i1
      %222 = comb.xor bin %221, %true : i1
      %223 = comb.and bin %217, %222 : i1
      %224 = comb.or bin %220, %223 : i1
      cf.cond_br %224, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %225 = llhd.prb %rst_n_23 : i1
      %226 = comb.xor %225, %true : i1
      cf.cond_br %226, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %hold_cnt, %c0_i8 after %1 : i8
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %227 = llhd.prb %hold_clr : i1
      cf.cond_br %227, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %hold_cnt, %c0_i8 after %1 : i8
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %228 = llhd.prb %hold_plus : i1
      cf.cond_br %228, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %229 = llhd.prb %hold_cnt : i8
      %230 = comb.add %229, %c1_i8 : i8
      llhd.drv %hold_cnt, %230 after %1 : i8
      cf.br ^bb1
    }
    %165 = llhd.prb %i2c_hold_7 : i8
    %166 = comb.icmp eq %165, %c0_i8 : i8
    %167 = comb.or %44, %166 : i1
    llhd.drv %hold_clr, %167 after %0 : i1
    %168 = llhd.prb %hold_cnt : i8
    %169 = comb.icmp eq %168, %165 : i8
    %170 = comb.mux %166, %43, %169 : i1
    llhd.drv %hold_eq, %170 after %0 : i1
    %171 = comb.icmp ne %168, %c0_i8 : i8
    %172 = comb.or %173, %175, %171 : i1
    llhd.drv %hold_plus, %172 after %0 : i1
    %173 = comb.and %83, %43 {sv.namehint = "hold_plus_1"} : i1
    %174 = comb.or %94, %98, %76 : i1
    %175 = comb.and %174, %178 {sv.namehint = "hold_plus_0"} : i1
    %176 = llhd.prb %a0_hs_byeq0 : i1
    %177 = comb.or %28, %176 : i1
    %178 = comb.mux %52, %177, %43 {sv.namehint = "hs_mode"} : i1
    %179 = comb.and %94, %30, %43 : i1
    llhd.drv %a0_hs_byeq0, %179 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %216 = llhd.prb %clk_0 : i1
      %217 = llhd.prb %rst_n_23 : i1
      llhd.wait (%36, %60 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %218 = llhd.prb %clk_0 : i1
      %219 = comb.xor bin %216, %true : i1
      %220 = comb.and bin %219, %218 : i1
      %221 = llhd.prb %rst_n_23 : i1
      %222 = comb.xor bin %221, %true : i1
      %223 = comb.and bin %217, %222 : i1
      %224 = comb.or bin %220, %223 : i1
      cf.cond_br %224, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %225 = llhd.prb %rst_n_23 : i1
      %226 = comb.xor %225, %true : i1
      cf.cond_br %226, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i2c_fscnt, %c0_i8 after %1 : i8
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %227 = llhd.prb %fscnt_clr : i1
      cf.cond_br %227, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %i2c_fscnt, %c0_i8 after %1 : i8
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %228 = llhd.prb %fscnt_plus : i1
      cf.cond_br %228, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %229 = llhd.prb %i2c_fscnt : i8
      %230 = comb.add %229, %c1_i8 : i8
      llhd.drv %i2c_fscnt, %230 after %1 : i8
      cf.br ^bb1
    }
    %180 = comb.or %182, %184 : i1
    llhd.drv %fscnt_clr, %180 after %0 : i1
    %181 = comb.and %83, %134 {sv.namehint = "fscnt_plus_spec"} : i1
    %182 = comb.and %181, %47 {sv.namehint = "fscnt_clr1"} : i1
    %183 = comb.and %90, %130 : i1
    %184 = comb.and %183, %47 {sv.namehint = "fscnt_clr2"} : i1
    %185 = comb.or %181, %187 : i1
    llhd.drv %fscnt_plus, %185 after %0 : i1
    %186 = comb.or %52, %53 : i1
    %187 = comb.and %183, %186 {sv.namehint = "fscnt_plus_star"} : i1
    %188 = comb.icmp eq %8, %46 : i8
    llhd.drv %i2c_fscnt_eq, %188 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %216 = llhd.prb %clk_0 : i1
      %217 = llhd.prb %rst_n_23 : i1
      llhd.wait (%36, %60 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %218 = llhd.prb %clk_0 : i1
      %219 = comb.xor bin %216, %true : i1
      %220 = comb.and bin %219, %218 : i1
      %221 = llhd.prb %rst_n_23 : i1
      %222 = comb.xor bin %221, %true : i1
      %223 = comb.and bin %217, %222 : i1
      %224 = comb.or bin %220, %223 : i1
      cf.cond_br %224, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %225 = llhd.prb %rst_n_23 : i1
      %226 = comb.xor %225, %true : i1
      cf.cond_br %226, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %sbyte_flag, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %227 = llhd.prb %sta_restart : i1
      cf.cond_br %227, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %sbyte_flag, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %228 = llhd.prb %sta_special : i1
      %229 = llhd.prb %i2cm_sbyte_17 : i1
      %230 = llhd.prb %bycnt_eq8 : i1
      %231 = llhd.prb %r_scl_21 : i1
      %232 = comb.and %228, %229, %230, %231 : i1
      cf.cond_br %232, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %sbyte_flag, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %216 = llhd.prb %clk_0 : i1
      %217 = llhd.prb %rst_n_23 : i1
      llhd.wait (%36, %60 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %218 = llhd.prb %clk_0 : i1
      %219 = comb.xor bin %216, %true : i1
      %220 = comb.and bin %219, %218 : i1
      %221 = llhd.prb %rst_n_23 : i1
      %222 = comb.xor bin %221, %true : i1
      %223 = comb.and bin %217, %222 : i1
      %224 = comb.or bin %220, %223 : i1
      cf.cond_br %224, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %225 = llhd.prb %rst_n_23 : i1
      %226 = comb.xor %225, %true : i1
      cf.cond_br %226, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %hsm_flag, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %227 = llhd.prb %sta_restart : i1
      cf.cond_br %227, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %hsm_flag, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %228 = llhd.prb %sta_special : i1
      %229 = llhd.prb %i2cm_hs_15 : i1
      %230 = llhd.prb %bycnt_eq8 : i1
      %231 = llhd.prb %r_scl_21 : i1
      %232 = llhd.prb %i2cm_sbyte_17 : i1
      %233 = llhd.prb %sbyte_flag : i1
      %234 = comb.xor %232, %true : i1
      %235 = comb.or %234, %233 : i1
      %236 = comb.and %228, %229, %230, %231, %235 : i1
      cf.cond_br %236, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %hsm_flag, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %216 = llhd.prb %clk_0 : i1
      %217 = llhd.prb %rst_n_23 : i1
      llhd.wait (%36, %60 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %218 = llhd.prb %clk_0 : i1
      %219 = comb.xor bin %216, %true : i1
      %220 = comb.and bin %219, %218 : i1
      %221 = llhd.prb %rst_n_23 : i1
      %222 = comb.xor bin %221, %true : i1
      %223 = comb.and bin %217, %222 : i1
      %224 = comb.or bin %220, %223 : i1
      cf.cond_br %224, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %225 = llhd.prb %rst_n_23 : i1
      %226 = comb.xor %225, %true : i1
      cf.cond_br %226, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i2cm_sflag, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %227 = llhd.prb %start_end : i1
      %228 = llhd.prb %restart_end : i1
      %229 = comb.or %227, %228 : i1
      cf.cond_br %229, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %i2cm_sflag, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %230 = llhd.prb %sta_start : i1
      %231 = llhd.prb %sta_restart : i1
      %232 = comb.or %230, %231 : i1
      %233 = llhd.prb %start_flag_24 : i1
      %234 = comb.and %232, %233 : i1
      cf.cond_br %234, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %i2cm_sflag, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %216 = llhd.prb %clk_0 : i1
      %217 = llhd.prb %rst_n_23 : i1
      llhd.wait (%36, %60 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %218 = llhd.prb %clk_0 : i1
      %219 = comb.xor bin %216, %true : i1
      %220 = comb.and bin %219, %218 : i1
      %221 = llhd.prb %rst_n_23 : i1
      %222 = comb.xor bin %221, %true : i1
      %223 = comb.and bin %217, %222 : i1
      %224 = comb.or bin %220, %223 : i1
      cf.cond_br %224, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %225 = llhd.prb %rst_n_23 : i1
      %226 = comb.xor %225, %true : i1
      cf.cond_br %226, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i2c_busy, %true after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %227 = llhd.prb %start_flag_24 : i1
      %228 = llhd.prb %sta_idle : i1
      %229 = comb.and %227, %228 : i1
      %230 = llhd.prb %lose_arbi : i1
      %231 = comb.or %229, %230 : i1
      cf.cond_br %231, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %i2c_busy, %true after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %232 = llhd.prb %bycnt_eq2 : i1
      %233 = llhd.prb %i2c_sflag : i1
      %234 = comb.and %232, %233 : i1
      %235 = llhd.prb %stop_flag_25 : i1
      %236 = comb.or %234, %235 : i1
      cf.cond_br %236, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %i2c_busy, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %216 = llhd.prb %clk_0 : i1
      %217 = llhd.prb %rst_n_23 : i1
      llhd.wait (%36, %60 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %218 = llhd.prb %clk_0 : i1
      %219 = comb.xor bin %216, %true : i1
      %220 = comb.and bin %219, %218 : i1
      %221 = llhd.prb %rst_n_23 : i1
      %222 = comb.xor bin %221, %true : i1
      %223 = comb.and bin %217, %222 : i1
      %224 = comb.or bin %220, %223 : i1
      cf.cond_br %224, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %225 = llhd.prb %rst_n_23 : i1
      %226 = comb.xor %225, %true : i1
      cf.cond_br %226, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i2c_sflag, %true after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %227 = llhd.prb %stop_flag_25 : i1
      cf.cond_br %227, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %i2c_sflag, %true after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %228 = llhd.prb %sta_idle : i1
      %229 = llhd.prb %start_flag_24 : i1
      %230 = comb.and %228, %229 : i1
      cf.cond_br %230, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %i2c_sflag, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %216 = llhd.prb %clk_0 : i1
      %217 = llhd.prb %rst_n_23 : i1
      llhd.wait (%36, %60 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %218 = llhd.prb %clk_0 : i1
      %219 = comb.xor bin %216, %true : i1
      %220 = comb.and bin %219, %218 : i1
      %221 = llhd.prb %rst_n_23 : i1
      %222 = comb.xor bin %221, %true : i1
      %223 = comb.and bin %217, %222 : i1
      %224 = comb.or bin %220, %223 : i1
      cf.cond_br %224, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %225 = llhd.prb %rst_n_23 : i1
      %226 = comb.xor %225, %true : i1
      cf.cond_br %226, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %lose_arbi, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %227 = llhd.prb %special_end : i1
      %228 = llhd.prb %addr0_end : i1
      %229 = llhd.prb %addr1_end : i1
      %230 = llhd.prb %data_end : i1
      %231 = comb.or %227, %228, %229, %230 : i1
      cf.cond_br %231, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %lose_arbi, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %232 = llhd.prb %arbi_en : i1
      %233 = llhd.prb %lose_arbi : i1
      %234 = comb.xor %233, %true : i1
      %235 = comb.and %232, %234 : i1
      cf.cond_br %235, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %236 = llhd.prb %sda_out : i1
      %237 = llhd.prb %i_sda_in_20 : i1
      %238 = comb.xor %236, %237 : i1
      llhd.drv %lose_arbi, %238 after %1 : i1
      cf.br ^bb1
    }
    %189 = llhd.prb %r_scl_d_22 : i1
    %190 = comb.or %195, %197 : i1
    %191 = comb.and %189, %190 : i1
    llhd.drv %arbi_en, %191 after %0 : i1
    %192 = comb.extract %5 from 3 : (i4) -> i1
    %193 = comb.xor %192, %true : i1
    %194 = comb.mux %13, %34, %193 : i1
    %195 = comb.and %98, %194 {sv.namehint = "data_arbi"} : i1
    %196 = comb.or %83, %94, %76 : i1
    %197 = comb.and %196, %193 {sv.namehint = "addr_arbi"} : i1
    %198 = llhd.prb %bycnt_eq7 : i1
    %199 = comb.and %98, %198, %189 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %216 = llhd.prb %clk_0 : i1
      %217 = llhd.prb %rst_n_23 : i1
      llhd.wait (%36, %60 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %218 = llhd.prb %clk_0 : i1
      %219 = comb.xor bin %216, %true : i1
      %220 = comb.and bin %219, %218 : i1
      %221 = llhd.prb %rst_n_23 : i1
      %222 = comb.xor bin %221, %true : i1
      %223 = comb.and bin %217, %222 : i1
      %224 = comb.or bin %220, %223 : i1
      cf.cond_br %224, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %225 = llhd.prb %rst_n_23 : i1
      %226 = comb.xor %225, %true : i1
      cf.cond_br %226, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i2cm_rx_wen, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %227 = llhd.prb %rw_flag : i1
      %228 = llhd.prb %sta_data : i1
      %229 = comb.and %227, %228 : i1
      cf.cond_br %229, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %230 = llhd.prb %r_scl_d_22 : i1
      %231 = llhd.prb %byte_cnt : i4
      %232 = comb.icmp eq %231, %c7_i4 : i4
      %233 = comb.and %230, %232 : i1
      llhd.drv %i2cm_rx_wen, %233 after %1 : i1
      cf.br ^bb1
    }
    %200 = comb.xor %85, %true : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %216 = llhd.prb %clk_0 : i1
      %217 = llhd.prb %rst_n_23 : i1
      llhd.wait (%36, %60 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %218 = llhd.prb %clk_0 : i1
      %219 = comb.xor bin %216, %true : i1
      %220 = comb.and bin %219, %218 : i1
      %221 = llhd.prb %rst_n_23 : i1
      %222 = comb.xor bin %221, %true : i1
      %223 = comb.and bin %217, %222 : i1
      %224 = comb.or bin %220, %223 : i1
      cf.cond_br %224, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %225 = llhd.prb %rst_n_23 : i1
      %226 = comb.xor %225, %true : i1
      cf.cond_br %226, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i2cm_aerr_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %227 = llhd.prb %i2c_aerr_clr_4 : i1
      %228 = llhd.prb %i2c_intr_en_8 : i5
      %229 = comb.extract %228 from 4 : (i5) -> i1
      %230 = comb.xor %229, %true : i1
      %231 = comb.or %227, %230 : i1
      cf.cond_br %231, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %i2cm_aerr_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %232 = llhd.prb %i2cm_aerr : i1
      %233 = llhd.prb %i2cm_en_13 : i1
      %234 = comb.and %232, %233 : i1
      cf.cond_br %234, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %i2cm_aerr_intr, %true after %1 : i1
      cf.br ^bb1
    }
    %201 = comb.xor %49, %true : i1
    %202 = comb.extract %45 from 3 : (i10) -> i4
    %203 = comb.icmp eq %202, %c0_i4 : i4
    %204 = comb.icmp eq %202, %c-1_i4 : i4
    %205 = comb.or %203, %204 : i1
    %206 = comb.and %201, %205 : i1
    llhd.drv %i2cm_aerr, %206 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %216 = llhd.prb %clk_0 : i1
      %217 = llhd.prb %rst_n_23 : i1
      llhd.wait (%36, %60 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %218 = llhd.prb %clk_0 : i1
      %219 = comb.xor bin %216, %true : i1
      %220 = comb.and bin %219, %218 : i1
      %221 = llhd.prb %rst_n_23 : i1
      %222 = comb.xor bin %221, %true : i1
      %223 = comb.and bin %217, %222 : i1
      %224 = comb.or bin %220, %223 : i1
      cf.cond_br %224, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %225 = llhd.prb %rst_n_23 : i1
      %226 = comb.xor %225, %true : i1
      cf.cond_br %226, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i2cm_stop_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %227 = llhd.prb %i2c_stop_clr_10 : i1
      %228 = llhd.prb %i2c_intr_en_8 : i5
      %229 = comb.extract %228 from 0 : (i5) -> i1
      %230 = comb.xor %229, %true : i1
      %231 = comb.or %227, %230 : i1
      cf.cond_br %231, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %i2cm_stop_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %232 = llhd.prb %stop_end : i1
      %233 = llhd.prb %i2cm_en_13 : i1
      %234 = comb.and %232, %233 : i1
      cf.cond_br %234, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %i2cm_stop_intr, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %216 = llhd.prb %clk_0 : i1
      %217 = llhd.prb %rst_n_23 : i1
      llhd.wait (%36, %60 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %218 = llhd.prb %clk_0 : i1
      %219 = comb.xor bin %216, %true : i1
      %220 = comb.and bin %219, %218 : i1
      %221 = llhd.prb %rst_n_23 : i1
      %222 = comb.xor bin %221, %true : i1
      %223 = comb.and bin %217, %222 : i1
      %224 = comb.or bin %220, %223 : i1
      cf.cond_br %224, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %225 = llhd.prb %rst_n_23 : i1
      %226 = comb.xor %225, %true : i1
      cf.cond_br %226, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i2cm_lose_arbi_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %227 = llhd.prb %i2cm_lose_arbi_clr_16 : i1
      %228 = llhd.prb %i2c_intr_en_8 : i5
      %229 = comb.extract %228 from 2 : (i5) -> i1
      %230 = comb.xor %229, %true : i1
      %231 = comb.or %227, %230 : i1
      cf.cond_br %231, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %i2cm_lose_arbi_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %232 = llhd.prb %arbi_en : i1
      %233 = llhd.prb %sda_out : i1
      %234 = llhd.prb %i_sda_in_20 : i1
      %235 = comb.xor %233, %234 : i1
      %236 = llhd.prb %i2cm_en_13 : i1
      %237 = comb.and %232, %235, %236 : i1
      cf.cond_br %237, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %i2cm_lose_arbi_intr, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %216 = llhd.prb %clk_0 : i1
      %217 = llhd.prb %rst_n_23 : i1
      llhd.wait (%36, %60 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %218 = llhd.prb %clk_0 : i1
      %219 = comb.xor bin %216, %true : i1
      %220 = comb.and bin %219, %218 : i1
      %221 = llhd.prb %rst_n_23 : i1
      %222 = comb.xor bin %221, %true : i1
      %223 = comb.and bin %217, %222 : i1
      %224 = comb.or bin %220, %223 : i1
      cf.cond_br %224, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %225 = llhd.prb %rst_n_23 : i1
      %226 = comb.xor %225, %true : i1
      cf.cond_br %226, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i2cm_nack_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %227 = llhd.prb %i2c_nack_clr_9 : i1
      %228 = llhd.prb %i2c_intr_en_8 : i5
      %229 = comb.extract %228 from 1 : (i5) -> i1
      %230 = comb.xor %229, %true : i1
      %231 = comb.or %227, %230 : i1
      cf.cond_br %231, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %i2cm_nack_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %232 = llhd.prb %r_nack : i1
      %233 = llhd.prb %rw_flag : i1
      %234 = comb.xor %233, %true : i1
      %235 = llhd.prb %i2cm_en_13 : i1
      %236 = comb.and %232, %234, %235 : i1
      cf.cond_br %236, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %i2cm_nack_intr, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %216 = llhd.prb %clk_0 : i1
      %217 = llhd.prb %rst_n_23 : i1
      llhd.wait (%36, %60 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %218 = llhd.prb %clk_0 : i1
      %219 = comb.xor bin %216, %true : i1
      %220 = comb.and bin %219, %218 : i1
      %221 = llhd.prb %rst_n_23 : i1
      %222 = comb.xor bin %221, %true : i1
      %223 = comb.and bin %217, %222 : i1
      %224 = comb.or bin %220, %223 : i1
      cf.cond_br %224, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %225 = llhd.prb %rst_n_23 : i1
      %226 = comb.xor %225, %true : i1
      cf.cond_br %226, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %nack_d, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %227 = llhd.prb %nack : i1
      llhd.drv %nack_d, %227 after %1 : i1
      cf.br ^bb1
    }
    %207 = llhd.prb %nack_d : i1
    %208 = comb.xor %207, %true : i1
    %209 = comb.and %12, %208 : i1
    llhd.drv %r_nack, %209 after %0 : i1
    llhd.drv %clk_0, %clk after %0 : i1
    llhd.drv %f_scl_1, %f_scl after %0 : i1
    llhd.drv %f_scl_d_2, %f_scl_d after %0 : i1
    llhd.drv %i2c_addr_3, %i2c_addr after %0 : i10
    llhd.drv %i2c_aerr_clr_4, %i2c_aerr_clr after %0 : i1
    llhd.drv %i2c_fs_div_5, %i2c_fs_div after %0 : i8
    llhd.drv %i2c_hcnt_6, %i2c_hcnt after %0 : i24
    llhd.drv %i2c_hold_7, %i2c_hold after %0 : i8
    llhd.drv %i2c_intr_en_8, %i2c_intr_en after %0 : i5
    llhd.drv %i2c_nack_clr_9, %i2c_nack_clr after %0 : i1
    llhd.drv %i2c_stop_clr_10, %i2c_stop_clr after %0 : i1
    %210 = llhd.prb %i2cm_aerr_intr : i1
    llhd.drv %i2cm_amode_11, %i2cm_amode after %0 : i1
    llhd.drv %i2cm_code_12, %i2cm_code after %0 : i3
    llhd.drv %i2cm_en_13, %i2cm_en after %0 : i1
    llhd.drv %i2cm_gcall_14, %i2cm_gcall after %0 : i1
    llhd.drv %i2cm_hs_15, %i2cm_hs after %0 : i1
    llhd.drv %i2cm_lose_arbi_clr_16, %i2cm_lose_arbi_clr after %0 : i1
    %211 = llhd.prb %i2cm_lose_arbi_intr : i1
    %212 = llhd.prb %i2cm_nack_intr : i1
    %213 = llhd.prb %i2cm_rx : i8
    %214 = llhd.prb %i2cm_rx_wen : i1
    llhd.drv %i2cm_sbyte_17, %i2cm_sbyte after %0 : i1
    llhd.drv %i2cm_stop_18, %i2cm_stop after %0 : i1
    %215 = llhd.prb %i2cm_stop_intr : i1
    llhd.drv %i_scl_in_19, %i_scl_in after %0 : i1
    llhd.drv %i_sda_in_20, %i_sda_in after %0 : i1
    llhd.drv %r_scl_21, %r_scl after %0 : i1
    llhd.drv %r_scl_d_22, %r_scl_d after %0 : i1
    llhd.drv %rst_n_23, %rst_n after %0 : i1
    llhd.drv %start_flag_24, %start_flag after %0 : i1
    llhd.drv %stop_flag_25, %stop_flag after %0 : i1
    llhd.drv %tx_empty_26, %tx_empty after %0 : i1
    llhd.drv %tx_rd_data_27, %tx_rd_data after %0 : i10
    llhd.drv %wr_clk_div_28, %wr_clk_div after %0 : i1
    hw.output %210, %98, %211, %212, %213, %214, %215, %199, %200, %15, %16 : i1, i1, i1, i1, i8, i1, i1, i1, i1, i1, i1
  }
  hw.module private @i2cs(in %clk : i1, in %f_scl : i1, in %f_scl_d : i2, in %i2c_addr : i10, in %i2c_hold : i8, in %i2c_intr_en : i4, in %i2c_lcnt : i24, in %i2c_nack_clr : i1, in %i2c_stop_clr : i1, in %i2cs_amode : i1, in %i2cs_en : i1, in %i2cs_gcall : i1, in %i2cs_gcall_clr : i1, out i2cs_gcall_intr : i1, in %i2cs_hs : i1, out i2cs_nack_intr : i1, out i2cs_rx : i8, out i2cs_rx_wen : i1, in %i2cs_sbyte : i1, out i2cs_stop_intr : i1, in %i2cs_tx_data : i8, out i2cs_tx_ren : i1, out i2cs_work : i1, in %i_sda_in : i1, in %r_scl_d2 : i1, in %rst_n : i1, in %rx_full : i1, out scl_out : i1, out sda_out : i1, in %start_flag : i1, in %stop_flag : i1, in %tx_empty : i1) {
    %c1_i3 = hw.constant 1 : i3
    %c2_i3 = hw.constant 2 : i3
    %c3_i3 = hw.constant 3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c-3_i3 = hw.constant -3 : i3
    %c-2_i3 = hw.constant -2 : i3
    %c-1_i3 = hw.constant -1 : i3
    %c0_i3 = hw.constant 0 : i3
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %c0_i10 = hw.constant 0 : i10
    %c-8_i4 = hw.constant -8 : i4
    %c-2_i5 = hw.constant -2 : i5
    %c1_i5 = hw.constant 1 : i5
    %c1_i8 = hw.constant 1 : i8
    %c0_i8 = hw.constant 0 : i8
    %c7_i4 = hw.constant 7 : i4
    %c6_i4 = hw.constant 6 : i4
    %c5_i4 = hw.constant 5 : i4
    %c4_i4 = hw.constant 4 : i4
    %c3_i4 = hw.constant 3 : i4
    %c2_i4 = hw.constant 2 : i4
    %c1_i4 = hw.constant 1 : i4
    %c0_i4 = hw.constant 0 : i4
    %c1_i24 = hw.constant 1 : i24
    %c0_i24 = hw.constant 0 : i24
    %false = hw.constant false
    %true = hw.constant true
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %addr0_cmp = llhd.sig %false : i1
    %2 = llhd.prb %addr0_cmp : i1
    %addr1_cmp = llhd.sig %false : i1
    %3 = llhd.prb %addr1_cmp : i1
    %addr_10 = llhd.sig %false : i1
    %4 = llhd.prb %addr_10 : i1
    %gcall_flag = llhd.sig %false : i1
    %5 = llhd.prb %gcall_flag : i1
    %gcall_flag_d = llhd.sig %false : i1
    %hs_flag = llhd.sig %false : i1
    %6 = llhd.prb %hs_flag : i1
    %i2cs_ack = llhd.sig %false : i1
    %i2cs_bcnt = llhd.sig %c0_i24 : i24
    %i2cs_bus = llhd.sig %false : i1
    %7 = llhd.prb %i2cs_bus : i1
    %i2cs_bycnt = llhd.sig %c0_i4 : i4
    %8 = llhd.prb %i2cs_bycnt : i4
    %i2cs_fsm = llhd.sig %c0_i2 : i2
    %9 = llhd.prb %i2cs_fsm : i2
    %i2cs_gcall_intr = llhd.sig %false : i1
    %i2cs_nack = llhd.sig %false : i1
    %i2cs_nack_intr = llhd.sig %false : i1
    %i2cs_rx = llhd.sig %c0_i8 : i8
    %i2cs_stop_intr = llhd.sig %false : i1
    %i2cs_tx = llhd.sig %false : i1
    %nxt_i2cs_fsm = llhd.sig %c0_i2 : i2
    %r_scl_d3 = llhd.sig %false : i1
    %s_hold_cnt = llhd.sig %c0_i8 : i8
    %s_rw_flag = llhd.sig %false : i1
    %10 = llhd.prb %s_rw_flag : i1
    %sbyte_flag = llhd.sig %false : i1
    %11 = llhd.prb %sbyte_flag : i1
    %scl_out = llhd.sig %false : i1
    %sda_out = llhd.sig %false : i1
    %12 = llhd.prb %sda_out : i1
    %start_hold = llhd.sig %false : i1
    %13 = llhd.prb %start_hold : i1
    %clk_0 = llhd.sig name "clk" %false : i1
    %14 = llhd.prb %clk_0 : i1
    %f_scl_1 = llhd.sig name "f_scl" %false : i1
    %15 = llhd.prb %f_scl_1 : i1
    %f_scl_d_2 = llhd.sig name "f_scl_d" %c0_i2 : i2
    %i2c_addr_3 = llhd.sig name "i2c_addr" %c0_i10 : i10
    %i2c_hold_4 = llhd.sig name "i2c_hold" %c0_i8 : i8
    %i2c_intr_en_5 = llhd.sig name "i2c_intr_en" %c0_i4 : i4
    %i2c_lcnt_6 = llhd.sig name "i2c_lcnt" %c0_i24 : i24
    %i2c_nack_clr_7 = llhd.sig name "i2c_nack_clr" %false : i1
    %i2c_stop_clr_8 = llhd.sig name "i2c_stop_clr" %false : i1
    %i2cs_a0_ack = llhd.sig %false : i1
    %i2cs_a0end = llhd.sig %false : i1
    %16 = llhd.prb %i2cs_a0end : i1
    %i2cs_a1end = llhd.sig %false : i1
    %17 = llhd.prb %i2cs_a1end : i1
    %i2cs_addr0 = llhd.sig %false : i1
    %i2cs_addr1 = llhd.sig %false : i1
    %i2cs_amode_9 = llhd.sig name "i2cs_amode" %false : i1
    %i2cs_bcnt_eql = llhd.sig %false : i1
    %i2cs_bycnt_clr = llhd.sig %false : i1
    %i2cs_bycnt_eq0 = llhd.sig %false : i1
    %i2cs_bycnt_eq8 = llhd.sig %false : i1
    %i2cs_data = llhd.sig %false : i1
    %i2cs_en_10 = llhd.sig name "i2cs_en" %false : i1
    %i2cs_gcall_11 = llhd.sig name "i2cs_gcall" %false : i1
    %i2cs_gcall_clr_12 = llhd.sig name "i2cs_gcall_clr" %false : i1
    %i2cs_hs_13 = llhd.sig name "i2cs_hs" %false : i1
    %i2cs_sbyte_14 = llhd.sig name "i2cs_sbyte" %false : i1
    %i2cs_send = llhd.sig %false : i1
    %i2cs_tx_data_15 = llhd.sig name "i2cs_tx_data" %c0_i8 : i8
    %18 = llhd.prb %i2cs_tx_data_15 : i8
    %i_sda_in_16 = llhd.sig name "i_sda_in" %false : i1
    %r_gcall = llhd.sig %false : i1
    %r_scl_d2_17 = llhd.sig name "r_scl_d2" %false : i1
    %rst_n_18 = llhd.sig name "rst_n" %false : i1
    %19 = llhd.prb %rst_n_18 : i1
    %s_hold_eq = llhd.sig %false : i1
    %20 = llhd.prb %s_hold_eq : i1
    %start_flag_19 = llhd.sig name "start_flag" %false : i1
    %21 = llhd.prb %start_flag_19 : i1
    %stop_flag_20 = llhd.sig name "stop_flag" %false : i1
    %22 = llhd.prb %stop_flag_20 : i1
    %strech_scl = llhd.sig %false : i1
    %tx_empty_21 = llhd.sig name "tx_empty" %false : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_18 : i1
      llhd.wait (%14, %19 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_18 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_18 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i2cs_fsm, %c0_i2 after %1 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %i2cs_en_10 : i1
      %84 = comb.xor %83, %true : i1
      cf.cond_br %84, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %i2cs_fsm, %c0_i2 after %1 : i2
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %85 = llhd.prb %nxt_i2cs_fsm : i2
      llhd.drv %i2cs_fsm, %85 after %1 : i2
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 17 preds: ^bb0, ^bb4, ^bb5, ^bb8, ^bb11, ^bb15, ^bb16, ^bb17, ^bb19, ^bb20, ^bb21, ^bb24, ^bb27, ^bb28, ^bb29, ^bb31, ^bb32
      llhd.wait (%21, %4, %6, %7, %9, %3, %15, %17, %22, %10, %5, %16, %2, %13, %11 : i1, i1, i1, i1, i2, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %72 = llhd.prb %i2cs_fsm : i2
      %73 = comb.icmp ceq %72, %c0_i2 : i2
      cf.cond_br %73, ^bb3, ^bb6
    ^bb3:  // pred: ^bb2
      %74 = llhd.prb %start_hold : i1
      %75 = llhd.prb %f_scl_1 : i1
      %76 = llhd.prb %i2cs_bus : i1
      %77 = comb.and %74, %75, %76 : i1
      cf.cond_br %77, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %nxt_i2cs_fsm, %c1_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      llhd.drv %nxt_i2cs_fsm, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb6:  // pred: ^bb2
      %78 = comb.icmp ceq %72, %c1_i2 : i2
      cf.cond_br %78, ^bb7, ^bb22
    ^bb7:  // pred: ^bb6
      %79 = llhd.prb %stop_flag_20 : i1
      %80 = llhd.prb %start_flag_19 : i1
      %81 = comb.or %79, %80 : i1
      cf.cond_br %81, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %nxt_i2cs_fsm, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %82 = llhd.prb %i2cs_a0end : i1
      cf.cond_br %82, ^bb10, ^bb21
    ^bb10:  // pred: ^bb9
      %83 = llhd.prb %hs_flag : i1
      %84 = llhd.prb %sbyte_flag : i1
      %85 = comb.or %83, %84 : i1
      cf.cond_br %85, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      llhd.drv %nxt_i2cs_fsm, %c1_i2 after %0 : i2
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      %86 = llhd.prb %addr_10 : i1
      %87 = llhd.prb %addr0_cmp : i1
      %88 = comb.and %86, %87 : i1
      cf.cond_br %88, ^bb13, ^bb18
    ^bb13:  // pred: ^bb12
      %89 = llhd.prb %s_rw_flag : i1
      cf.cond_br %89, ^bb14, ^bb17
    ^bb14:  // pred: ^bb13
      %90 = llhd.prb %addr1_cmp : i1
      cf.cond_br %90, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      llhd.drv %nxt_i2cs_fsm, %c-2_i2 after %0 : i2
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      llhd.drv %nxt_i2cs_fsm, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb17:  // pred: ^bb13
      llhd.drv %nxt_i2cs_fsm, %c-1_i2 after %0 : i2
      cf.br ^bb1
    ^bb18:  // pred: ^bb12
      %91 = llhd.prb %addr0_cmp : i1
      %92 = llhd.prb %gcall_flag : i1
      %93 = comb.or %91, %92 : i1
      cf.cond_br %93, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      llhd.drv %nxt_i2cs_fsm, %c-2_i2 after %0 : i2
      cf.br ^bb1
    ^bb20:  // pred: ^bb18
      llhd.drv %nxt_i2cs_fsm, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb21:  // pred: ^bb9
      %94 = llhd.prb %i2cs_fsm : i2
      llhd.drv %nxt_i2cs_fsm, %94 after %0 : i2
      cf.br ^bb1
    ^bb22:  // pred: ^bb6
      %95 = comb.icmp ceq %72, %c-1_i2 : i2
      cf.cond_br %95, ^bb23, ^bb30
    ^bb23:  // pred: ^bb22
      %96 = llhd.prb %start_flag_19 : i1
      %97 = llhd.prb %stop_flag_20 : i1
      %98 = comb.or %96, %97 : i1
      cf.cond_br %98, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      llhd.drv %nxt_i2cs_fsm, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb25:  // pred: ^bb23
      %99 = llhd.prb %i2cs_a1end : i1
      cf.cond_br %99, ^bb26, ^bb29
    ^bb26:  // pred: ^bb25
      %100 = llhd.prb %addr1_cmp : i1
      cf.cond_br %100, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      llhd.drv %nxt_i2cs_fsm, %c-2_i2 after %0 : i2
      cf.br ^bb1
    ^bb28:  // pred: ^bb26
      llhd.drv %nxt_i2cs_fsm, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb29:  // pred: ^bb25
      llhd.drv %nxt_i2cs_fsm, %c-1_i2 after %0 : i2
      cf.br ^bb1
    ^bb30:  // pred: ^bb22
      %101 = llhd.prb %stop_flag_20 : i1
      %102 = llhd.prb %start_flag_19 : i1
      %103 = comb.or %101, %102 : i1
      cf.cond_br %103, ^bb31, ^bb32
    ^bb31:  // pred: ^bb30
      llhd.drv %nxt_i2cs_fsm, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb32:  // pred: ^bb30
      %104 = llhd.prb %i2cs_fsm : i2
      llhd.drv %nxt_i2cs_fsm, %104 after %0 : i2
      cf.br ^bb1
    }
    %23 = comb.icmp eq %9, %c0_i2 {sv.namehint = "i2cs_idle"} : i2
    %24 = comb.icmp eq %9, %c1_i2 : i2
    llhd.drv %i2cs_addr0, %24 after %0 : i1
    %25 = comb.icmp eq %9, %c-1_i2 : i2
    llhd.drv %i2cs_addr1, %25 after %0 : i1
    %26 = comb.icmp eq %9, %c-2_i2 : i2
    llhd.drv %i2cs_data, %26 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 12 preds: ^bb0, ^bb2, ^bb4, ^bb7, ^bb8, ^bb11, ^bb12, ^bb14, ^bb16, ^bb19, ^bb20, ^bb21
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_18 : i1
      llhd.wait (%14, %19 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_18 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_18 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %sda_out, %true after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %i2cs_addr0 : i1
      %84 = llhd.prb %i2cs_bycnt_eq8 : i1
      %85 = comb.and %83, %84 : i1
      cf.cond_br %85, ^bb6, ^bb9
    ^bb6:  // pred: ^bb5
      %86 = llhd.prb %i2cs_a0_ack : i1
      cf.cond_br %86, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      llhd.drv %sda_out, %false after %1 : i1
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      llhd.drv %sda_out, %true after %1 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb5
      %87 = llhd.prb %i2cs_addr1 : i1
      %88 = llhd.prb %addr1_cmp : i1
      %89 = llhd.prb %i2cs_bycnt_eq8 : i1
      %90 = comb.and %87, %88, %89 : i1
      cf.cond_br %90, ^bb10, ^bb13
    ^bb10:  // pred: ^bb9
      %91 = llhd.prb %addr1_cmp : i1
      cf.cond_br %91, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      llhd.drv %sda_out, %false after %1 : i1
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      llhd.drv %sda_out, %true after %1 : i1
      cf.br ^bb1
    ^bb13:  // pred: ^bb9
      %92 = llhd.prb %i2cs_data : i1
      %93 = llhd.prb %i2cs_bycnt_eq8 : i1
      %94 = llhd.prb %s_rw_flag : i1
      %95 = comb.xor %94, %true : i1
      %96 = comb.and %92, %93, %95 : i1
      cf.cond_br %96, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %97 = llhd.prb %i2cs_ack : i1
      llhd.drv %sda_out, %97 after %1 : i1
      cf.br ^bb1
    ^bb15:  // pred: ^bb13
      %98 = llhd.prb %i2cs_data : i1
      %99 = llhd.prb %i2cs_bycnt_eq0 : i1
      %100 = llhd.prb %tx_empty_21 : i1
      %101 = llhd.prb %s_rw_flag : i1
      %102 = comb.and %98, %99, %100, %101 : i1
      cf.cond_br %102, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      llhd.drv %sda_out, %true after %1 : i1
      cf.br ^bb1
    ^bb17:  // pred: ^bb15
      %103 = llhd.prb %i2cs_data : i1
      %104 = llhd.prb %s_rw_flag : i1
      %105 = comb.and %103, %104 : i1
      cf.cond_br %105, ^bb18, ^bb21
    ^bb18:  // pred: ^bb17
      %106 = llhd.prb %i2cs_nack : i1
      %107 = llhd.prb %s_hold_eq : i1
      %108 = comb.and %106, %107 : i1
      cf.cond_br %108, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      llhd.drv %sda_out, %true after %1 : i1
      cf.br ^bb1
    ^bb20:  // pred: ^bb18
      %109 = llhd.prb %i2cs_tx : i1
      llhd.drv %sda_out, %109 after %1 : i1
      cf.br ^bb1
    ^bb21:  // pred: ^bb17
      llhd.drv %sda_out, %true after %1 : i1
      cf.br ^bb1
    }
    %27 = comb.and %10, %4 : i1
    %28 = comb.xor %27, %true : i1
    %29 = comb.or %28, %3 : i1
    %30 = comb.and %29, %2 : i1
    llhd.drv %i2cs_a0_ack, %30 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_18 : i1
      llhd.wait (%14, %19 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_18 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_18 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %scl_out, %true after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %i2cs_data : i1
      %84 = llhd.prb %i2cs_bycnt_eq0 : i1
      %85 = llhd.prb %i2cs_bcnt_eql : i1
      %86 = llhd.prb %s_rw_flag : i1
      %87 = comb.and %83, %84, %85, %86 : i1
      cf.cond_br %87, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %scl_out, %true after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %88 = llhd.prb %strech_scl : i1
      cf.cond_br %88, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %scl_out, %false after %1 : i1
      cf.br ^bb1
    }
    %31 = llhd.prb %i2cs_data : i1
    %32 = llhd.prb %i2cs_bycnt_eq8 : i1
    %33 = llhd.prb %i2cs_nack : i1
    %34 = comb.xor %33, %true : i1
    %35 = llhd.prb %tx_empty_21 : i1
    %36 = comb.and %35, %10 : i1
    %37 = comb.xor %10, %true : i1
    %38 = comb.and %rx_full, %37 : i1
    %39 = comb.or %36, %38 : i1
    %40 = comb.and %31, %32, %15, %34, %39 : i1
    llhd.drv %strech_scl, %40 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_18 : i1
      llhd.wait (%14, %19 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_18 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_18 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i2cs_bcnt, %c0_i24 after %1 : i24
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %i2cs_bcnt : i24
      %84 = llhd.prb %i2c_lcnt_6 : i24
      %85 = comb.icmp eq %83, %84 : i24
      cf.cond_br %85, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %i2cs_bcnt, %c0_i24 after %1 : i24
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %86 = llhd.prb %i2cs_data : i1
      %87 = llhd.prb %i2cs_bycnt_eq0 : i1
      %88 = llhd.prb %s_rw_flag : i1
      %89 = llhd.prb %scl_out : i1
      %90 = comb.xor %89, %true : i1
      %91 = llhd.prb %tx_empty_21 : i1
      %92 = comb.xor %91, %true : i1
      %93 = comb.and %86, %87, %88, %90, %92 : i1
      %94 = llhd.prb %i2cs_bcnt : i24
      %95 = comb.icmp ne %94, %c0_i24 : i24
      %96 = comb.or %93, %95 : i1
      cf.cond_br %96, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %97 = llhd.prb %i2cs_bcnt : i24
      %98 = comb.add %97, %c1_i24 : i24
      llhd.drv %i2cs_bcnt, %98 after %1 : i24
      cf.br ^bb1
    }
    %41 = llhd.prb %i2cs_bcnt : i24
    %42 = llhd.prb %i2c_lcnt_6 : i24
    %43 = comb.icmp eq %41, %42 : i24
    llhd.drv %i2cs_bcnt_eql, %43 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 11 preds: ^bb0, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb19, ^bb20
      llhd.wait (%18, %8, %20, %12 : i8, i4, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %72 = llhd.prb %s_hold_eq : i1
      cf.cond_br %72, ^bb3, ^bb20
    ^bb3:  // pred: ^bb2
      %73 = llhd.prb %i2cs_bycnt : i4
      %74 = comb.icmp ceq %73, %c0_i4 : i4
      cf.cond_br %74, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %75 = llhd.prb %i2cs_tx_data_15 : i8
      %76 = comb.extract %75 from 7 : (i8) -> i1
      llhd.drv %i2cs_tx, %76 after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %77 = comb.icmp ceq %73, %c1_i4 : i4
      cf.cond_br %77, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %78 = llhd.prb %i2cs_tx_data_15 : i8
      %79 = comb.extract %78 from 6 : (i8) -> i1
      llhd.drv %i2cs_tx, %79 after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %80 = comb.icmp ceq %73, %c2_i4 : i4
      cf.cond_br %80, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %81 = llhd.prb %i2cs_tx_data_15 : i8
      %82 = comb.extract %81 from 5 : (i8) -> i1
      llhd.drv %i2cs_tx, %82 after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %83 = comb.icmp ceq %73, %c3_i4 : i4
      cf.cond_br %83, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %84 = llhd.prb %i2cs_tx_data_15 : i8
      %85 = comb.extract %84 from 4 : (i8) -> i1
      llhd.drv %i2cs_tx, %85 after %0 : i1
      cf.br ^bb1
    ^bb11:  // pred: ^bb9
      %86 = comb.icmp ceq %73, %c4_i4 : i4
      cf.cond_br %86, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %87 = llhd.prb %i2cs_tx_data_15 : i8
      %88 = comb.extract %87 from 3 : (i8) -> i1
      llhd.drv %i2cs_tx, %88 after %0 : i1
      cf.br ^bb1
    ^bb13:  // pred: ^bb11
      %89 = comb.icmp ceq %73, %c5_i4 : i4
      cf.cond_br %89, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %90 = llhd.prb %i2cs_tx_data_15 : i8
      %91 = comb.extract %90 from 2 : (i8) -> i1
      llhd.drv %i2cs_tx, %91 after %0 : i1
      cf.br ^bb1
    ^bb15:  // pred: ^bb13
      %92 = comb.icmp ceq %73, %c6_i4 : i4
      cf.cond_br %92, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %93 = llhd.prb %i2cs_tx_data_15 : i8
      %94 = comb.extract %93 from 1 : (i8) -> i1
      llhd.drv %i2cs_tx, %94 after %0 : i1
      cf.br ^bb1
    ^bb17:  // pred: ^bb15
      %95 = comb.icmp ceq %73, %c7_i4 : i4
      cf.cond_br %95, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      %96 = llhd.prb %i2cs_tx_data_15 : i8
      %97 = comb.extract %96 from 0 : (i8) -> i1
      llhd.drv %i2cs_tx, %97 after %0 : i1
      cf.br ^bb1
    ^bb19:  // pred: ^bb17
      llhd.drv %i2cs_tx, %true after %0 : i1
      cf.br ^bb1
    ^bb20:  // pred: ^bb2
      %98 = llhd.prb %sda_out : i1
      llhd.drv %i2cs_tx, %98 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 3 preds: ^bb0, ^bb3, ^bb4
      llhd.wait (%20, %12 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %72 = llhd.prb %s_hold_eq : i1
      cf.cond_br %72, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %i2cs_ack, %false after %0 : i1
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      %73 = llhd.prb %sda_out : i1
      llhd.drv %i2cs_ack, %73 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_18 : i1
      llhd.wait (%14, %19 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_18 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_18 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %s_hold_cnt, %c0_i8 after %1 : i8
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %s_hold_eq : i1
      cf.cond_br %83, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %s_hold_cnt, %c0_i8 after %1 : i8
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %84 = llhd.prb %f_scl_d_2 : i2
      %85 = comb.extract %84 from 0 : (i2) -> i1
      %86 = llhd.prb %i2cs_addr0 : i1
      %87 = llhd.prb %i2cs_data : i1
      %88 = llhd.prb %i2cs_addr1 : i1
      %89 = comb.or %86, %87, %88 : i1
      %90 = comb.and %85, %89 : i1
      cf.cond_br %90, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %s_hold_cnt, %c1_i8 after %1 : i8
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %91 = llhd.prb %s_hold_cnt : i8
      %92 = comb.icmp ne %91, %c0_i8 : i8
      cf.cond_br %92, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %93 = llhd.prb %s_hold_cnt : i8
      %94 = comb.add %93, %c1_i8 : i8
      llhd.drv %s_hold_cnt, %94 after %1 : i8
      cf.br ^bb1
    }
    %44 = llhd.prb %f_scl_d_2 : i2
    %45 = comb.extract %44 from 1 : (i2) -> i1
    %46 = llhd.prb %s_hold_cnt : i8
    %47 = llhd.prb %i2c_hold_4 : i8
    %48 = comb.icmp eq %46, %47 : i8
    %49 = comb.mux %50, %45, %48 : i1
    llhd.drv %s_hold_eq, %49 after %0 : i1
    %50 = comb.icmp eq %47, %c0_i8 {sv.namehint = "s_hold_eq0"} : i8
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 13 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb7, ^bb9, ^bb11, ^bb13, ^bb15, ^bb17, ^bb19, ^bb21, ^bb22
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_18 : i1
      llhd.wait (%14, %19 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_18 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_18 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i2cs_rx, %c0_i8 after %1 : i8
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %i2cs_addr0 : i1
      %84 = llhd.prb %i2cs_addr1 : i1
      %85 = llhd.prb %i2cs_data : i1
      %86 = comb.or %83, %84, %85 : i1
      %87 = llhd.prb %r_scl_d2_17 : i1
      %88 = comb.and %86, %87 : i1
      cf.cond_br %88, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %89 = llhd.prb %i2cs_bycnt : i4
      %90 = comb.icmp ceq %89, %c0_i4 : i4
      cf.cond_br %90, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %91 = llhd.sig.extract %i2cs_rx from %c-1_i3 : <i8> -> <i1>
      %92 = llhd.prb %i_sda_in_16 : i1
      llhd.drv %91, %92 after %1 : i1
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %93 = comb.icmp ceq %89, %c1_i4 : i4
      cf.cond_br %93, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %94 = llhd.sig.extract %i2cs_rx from %c-2_i3 : <i8> -> <i1>
      %95 = llhd.prb %i_sda_in_16 : i1
      llhd.drv %94, %95 after %1 : i1
      cf.br ^bb1
    ^bb10:  // pred: ^bb8
      %96 = comb.icmp ceq %89, %c2_i4 : i4
      cf.cond_br %96, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %97 = llhd.sig.extract %i2cs_rx from %c-3_i3 : <i8> -> <i1>
      %98 = llhd.prb %i_sda_in_16 : i1
      llhd.drv %97, %98 after %1 : i1
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      %99 = comb.icmp ceq %89, %c3_i4 : i4
      cf.cond_br %99, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      %100 = llhd.sig.extract %i2cs_rx from %c-4_i3 : <i8> -> <i1>
      %101 = llhd.prb %i_sda_in_16 : i1
      llhd.drv %100, %101 after %1 : i1
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      %102 = comb.icmp ceq %89, %c4_i4 : i4
      cf.cond_br %102, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      %103 = llhd.sig.extract %i2cs_rx from %c3_i3 : <i8> -> <i1>
      %104 = llhd.prb %i_sda_in_16 : i1
      llhd.drv %103, %104 after %1 : i1
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      %105 = comb.icmp ceq %89, %c5_i4 : i4
      cf.cond_br %105, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      %106 = llhd.sig.extract %i2cs_rx from %c2_i3 : <i8> -> <i1>
      %107 = llhd.prb %i_sda_in_16 : i1
      llhd.drv %106, %107 after %1 : i1
      cf.br ^bb1
    ^bb18:  // pred: ^bb16
      %108 = comb.icmp ceq %89, %c6_i4 : i4
      cf.cond_br %108, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %109 = llhd.sig.extract %i2cs_rx from %c1_i3 : <i8> -> <i1>
      %110 = llhd.prb %i_sda_in_16 : i1
      llhd.drv %109, %110 after %1 : i1
      cf.br ^bb1
    ^bb20:  // pred: ^bb18
      %111 = comb.icmp ceq %89, %c7_i4 : i4
      cf.cond_br %111, ^bb21, ^bb22
    ^bb21:  // pred: ^bb20
      %112 = llhd.sig.extract %i2cs_rx from %c0_i3 : <i8> -> <i1>
      %113 = llhd.prb %i_sda_in_16 : i1
      llhd.drv %112, %113 after %1 : i1
      cf.br ^bb1
    ^bb22:  // pred: ^bb20
      %114 = llhd.prb %i2cs_rx : i8
      llhd.drv %i2cs_rx, %114 after %1 : i8
      cf.br ^bb1
    }
    %51 = comb.and %31, %37, %54 : i1
    %52 = comb.and %31, %10, %54 : i1
    %53 = comb.icmp eq %8, %c7_i4 : i4
    %54 = comb.and %53, %15 {sv.namehint = "tim_i2cs_fifo_op"} : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_18 : i1
      llhd.wait (%14, %19 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_18 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_18 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %s_rw_flag, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %i2cs_send : i1
      cf.cond_br %83, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %s_rw_flag, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %84 = llhd.prb %i2cs_addr0 : i1
      %85 = llhd.prb %i2cs_bycnt : i4
      %86 = comb.icmp eq %85, %c7_i4 : i4
      %87 = llhd.prb %r_scl_d2_17 : i1
      %88 = comb.and %84, %86, %87 : i1
      cf.cond_br %88, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %89 = llhd.prb %i_sda_in_16 : i1
      llhd.drv %s_rw_flag, %89 after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb12, ^bb13
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_18 : i1
      llhd.wait (%14, %19 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_18 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_18 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %hs_flag, %false after %1 : i1
      llhd.drv %gcall_flag, %false after %1 : i1
      llhd.drv %sbyte_flag, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %i2cs_a0end : i1
      cf.cond_br %83, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %hs_flag, %false after %1 : i1
      llhd.drv %gcall_flag, %false after %1 : i1
      llhd.drv %sbyte_flag, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %84 = llhd.prb %i2cs_addr0 : i1
      cf.cond_br %84, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %85 = llhd.prb %i2cs_hs_13 : i1
      %86 = comb.xor %85, %true : i1
      %87 = llhd.prb %i2cs_rx : i8
      %88 = comb.extract %87 from 3 : (i8) -> i5
      %89 = comb.icmp eq %88, %c1_i5 : i5
      %90 = llhd.prb %i2cs_bycnt : i4
      %91 = comb.icmp eq %90, %c4_i4 : i4
      %92 = llhd.prb %r_scl_d2_17 : i1
      %93 = comb.and %86, %89, %91, %92 : i1
      cf.cond_br %93, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      llhd.drv %hs_flag, %true after %1 : i1
      cf.br ^bb10
    ^bb10:  // 2 preds: ^bb8, ^bb9
      %94 = llhd.prb %i2cs_gcall_11 : i1
      %95 = comb.xor %94, %true : i1
      %96 = llhd.prb %i2cs_rx : i8
      %97 = comb.icmp eq %96, %c0_i8 : i8
      %98 = llhd.prb %i2cs_bycnt : i4
      %99 = comb.icmp eq %98, %c7_i4 : i4
      %100 = llhd.prb %r_scl_d2_17 : i1
      %101 = comb.and %95, %97, %99, %100 : i1
      cf.cond_br %101, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      llhd.drv %gcall_flag, %true after %1 : i1
      cf.br ^bb12
    ^bb12:  // 2 preds: ^bb10, ^bb11
      %102 = llhd.prb %i2cs_sbyte_14 : i1
      %103 = comb.xor %102, %true : i1
      %104 = llhd.prb %i2cs_rx : i8
      %105 = comb.icmp eq %104, %c1_i8 : i8
      %106 = llhd.prb %i2cs_bycnt : i4
      %107 = comb.icmp eq %106, %c7_i4 : i4
      %108 = llhd.prb %r_scl_d2_17 : i1
      %109 = comb.and %103, %105, %107, %108 : i1
      cf.cond_br %109, ^bb13, ^bb1
    ^bb13:  // pred: ^bb12
      llhd.drv %sbyte_flag, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 8 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb12, ^bb14, ^bb15
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_18 : i1
      llhd.wait (%14, %19 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_18 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_18 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %addr0_cmp, %false after %1 : i1
      llhd.drv %addr_10, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %stop_flag_20 : i1
      cf.cond_br %83, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %addr0_cmp, %false after %1 : i1
      llhd.drv %addr_10, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %84 = llhd.prb %i2cs_addr0 : i1
      cf.cond_br %84, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %85 = llhd.prb %i2cs_bycnt : i4
      %86 = comb.icmp eq %85, %c7_i4 : i4
      %87 = llhd.prb %r_scl_d3 : i1
      %88 = comb.and %86, %87 : i1
      cf.cond_br %88, ^bb9, ^bb12
    ^bb9:  // pred: ^bb8
      %89 = llhd.prb %addr_10 : i1
      cf.cond_br %89, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %90 = llhd.prb %i2cs_rx : i8
      %91 = comb.extract %90 from 1 : (i8) -> i2
      %92 = llhd.prb %i2c_addr_3 : i10
      %93 = comb.extract %92 from 8 : (i10) -> i2
      %94 = comb.icmp eq %91, %93 : i2
      llhd.drv %addr0_cmp, %94 after %1 : i1
      cf.br ^bb12
    ^bb11:  // pred: ^bb9
      %95 = llhd.prb %i2cs_rx : i8
      %96 = comb.extract %95 from 1 : (i8) -> i7
      %97 = llhd.prb %i2c_addr_3 : i10
      %98 = comb.extract %97 from 0 : (i10) -> i7
      %99 = comb.icmp eq %96, %98 : i7
      %100 = llhd.prb %i2cs_gcall_11 : i1
      %101 = comb.xor %100, %true : i1
      %102 = comb.icmp eq %95, %c0_i8 : i8
      %103 = comb.and %101, %102 : i1
      %104 = comb.or %99, %103 : i1
      llhd.drv %addr0_cmp, %104 after %1 : i1
      cf.br ^bb12
    ^bb12:  // 3 preds: ^bb8, ^bb10, ^bb11
      %105 = llhd.prb %i2cs_rx : i8
      %106 = comb.extract %105 from 3 : (i8) -> i5
      %107 = comb.icmp eq %106, %c-2_i5 : i5
      %108 = llhd.prb %i2cs_bycnt : i4
      %109 = comb.icmp eq %108, %c5_i4 : i4
      %110 = llhd.prb %r_scl_d3 : i1
      %111 = comb.and %107, %109, %110 : i1
      cf.cond_br %111, ^bb13, ^bb1
    ^bb13:  // pred: ^bb12
      %112 = llhd.prb %i2cs_amode_9 : i1
      %113 = comb.xor %112, %true : i1
      cf.cond_br %113, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      llhd.drv %addr_10, %true after %1 : i1
      cf.br ^bb1
    ^bb15:  // pred: ^bb13
      llhd.drv %addr_10, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_18 : i1
      llhd.wait (%14, %19 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_18 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_18 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %addr1_cmp, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %stop_flag_20 : i1
      cf.cond_br %83, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %addr1_cmp, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %84 = llhd.prb %i2cs_addr1 : i1
      %85 = llhd.prb %i2cs_bycnt : i4
      %86 = comb.icmp eq %85, %c7_i4 : i4
      %87 = llhd.prb %f_scl_1 : i1
      %88 = comb.and %84, %86, %87 : i1
      cf.cond_br %88, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %89 = llhd.prb %i2cs_rx : i8
      %90 = llhd.prb %i2c_addr_3 : i10
      %91 = comb.extract %90 from 0 : (i10) -> i8
      %92 = comb.icmp eq %89, %91 : i8
      llhd.drv %addr1_cmp, %92 after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_18 : i1
      llhd.wait (%14, %19 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_18 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_18 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i2cs_bus, %true after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %start_flag_19 : i1
      %84 = llhd.prb %stop_flag_20 : i1
      %85 = comb.or %83, %84 : i1
      cf.cond_br %85, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %i2cs_bus, %true after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %86 = llhd.prb %addr0_cmp : i1
      %87 = comb.xor %86, %true : i1
      %88 = llhd.prb %i2cs_a0end : i1
      %89 = comb.and %87, %88 : i1
      %90 = llhd.prb %addr1_cmp : i1
      %91 = comb.xor %90, %true : i1
      %92 = llhd.prb %i2cs_a1end : i1
      %93 = comb.and %91, %92 : i1
      %94 = comb.or %89, %93 : i1
      cf.cond_br %94, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %i2cs_bus, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_18 : i1
      llhd.wait (%14, %19 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_18 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_18 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %start_hold, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %f_scl_1 : i1
      cf.cond_br %83, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %start_hold, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %84 = llhd.prb %start_flag_19 : i1
      cf.cond_br %84, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %start_hold, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_18 : i1
      llhd.wait (%14, %19 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_18 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_18 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i2cs_bycnt, %c0_i4 after %1 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %i2cs_bycnt_clr : i1
      %84 = llhd.prb %start_flag_19 : i1
      %85 = llhd.prb %i2cs_en_10 : i1
      %86 = comb.xor %85, %true : i1
      %87 = comb.or %83, %84, %86 : i1
      cf.cond_br %87, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %i2cs_bycnt, %c0_i4 after %1 : i4
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %88 = llhd.prb %i2cs_fsm : i2
      %89 = comb.icmp ne %88, %c0_i2 : i2
      %90 = llhd.prb %f_scl_1 : i1
      %91 = comb.and %89, %90 : i1
      cf.cond_br %91, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %92 = llhd.prb %i2cs_bycnt : i4
      %93 = comb.add %92, %c1_i4 : i4
      llhd.drv %i2cs_bycnt, %93 after %1 : i4
      cf.br ^bb1
    }
    %55 = comb.and %32, %15 : i1
    llhd.drv %i2cs_bycnt_clr, %55 after %0 : i1
    %56 = comb.and %23, %15, %21 : i1
    llhd.drv %i2cs_send, %56 after %0 : i1
    %57 = llhd.prb %i2cs_addr0 : i1
    %58 = comb.and %57, %32, %15 : i1
    llhd.drv %i2cs_a0end, %58 after %0 : i1
    %59 = llhd.prb %i2cs_addr1 : i1
    %60 = comb.and %59, %32, %15 : i1
    llhd.drv %i2cs_a1end, %60 after %0 : i1
    %61 = comb.icmp eq %8, %c-8_i4 : i4
    llhd.drv %i2cs_bycnt_eq8, %61 after %0 : i1
    %62 = comb.icmp eq %8, %c0_i4 : i4
    llhd.drv %i2cs_bycnt_eq0, %62 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_18 : i1
      llhd.wait (%14, %19 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_18 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_18 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i2cs_nack, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %i2cs_addr0 : i1
      %84 = llhd.prb %i2cs_bycnt_eq8 : i1
      %85 = comb.and %83, %84 : i1
      cf.cond_br %85, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %i2cs_nack, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %86 = llhd.prb %i2cs_data : i1
      %87 = llhd.prb %i2cs_bycnt_eq8 : i1
      %88 = llhd.prb %r_scl_d2_17 : i1
      %89 = llhd.prb %s_rw_flag : i1
      %90 = comb.and %86, %87, %88, %89 : i1
      cf.cond_br %90, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %91 = llhd.prb %i_sda_in_16 : i1
      llhd.drv %i2cs_nack, %91 after %1 : i1
      cf.br ^bb1
    }
    %63 = comb.xor %23, %true : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_18 : i1
      llhd.wait (%14, %19 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_18 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_18 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i2cs_stop_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %i2c_stop_clr_8 : i1
      %84 = llhd.prb %i2c_intr_en_5 : i4
      %85 = comb.extract %84 from 0 : (i4) -> i1
      %86 = comb.xor %85, %true : i1
      %87 = comb.or %83, %86 : i1
      cf.cond_br %87, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %i2cs_stop_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %88 = llhd.prb %stop_flag_20 : i1
      %89 = llhd.prb %i2cs_en_10 : i1
      %90 = comb.xor %89, %true : i1
      %91 = comb.and %88, %90 : i1
      cf.cond_br %91, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %i2cs_stop_intr, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_18 : i1
      llhd.wait (%14, %19 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_18 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_18 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i2cs_gcall_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %i2cs_gcall_clr_12 : i1
      %84 = llhd.prb %i2c_intr_en_5 : i4
      %85 = comb.extract %84 from 3 : (i4) -> i1
      %86 = comb.xor %85, %true : i1
      %87 = comb.or %83, %86 : i1
      cf.cond_br %87, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %i2cs_gcall_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %88 = llhd.prb %r_gcall : i1
      cf.cond_br %88, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %i2cs_gcall_intr, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_18 : i1
      llhd.wait (%14, %19 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_18 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_18 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gcall_flag_d, %false after %1 : i1
      llhd.drv %r_scl_d3, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %gcall_flag : i1
      llhd.drv %gcall_flag_d, %83 after %1 : i1
      %84 = llhd.prb %r_scl_d2_17 : i1
      llhd.drv %r_scl_d3, %84 after %1 : i1
      cf.br ^bb1
    }
    %64 = llhd.prb %gcall_flag_d : i1
    %65 = comb.xor %64, %true : i1
    %66 = comb.and %5, %65 : i1
    llhd.drv %r_gcall, %66 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_18 : i1
      llhd.wait (%14, %19 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_18 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_18 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %i2cs_nack_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %i2c_nack_clr_7 : i1
      %84 = llhd.prb %i2c_intr_en_5 : i4
      %85 = comb.extract %84 from 1 : (i4) -> i1
      %86 = comb.xor %85, %true : i1
      %87 = comb.or %83, %86 : i1
      cf.cond_br %87, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %i2cs_nack_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %88 = llhd.prb %i2cs_data : i1
      %89 = llhd.prb %i2cs_bycnt_eq8 : i1
      %90 = llhd.prb %r_scl_d2_17 : i1
      %91 = llhd.prb %s_rw_flag : i1
      %92 = llhd.prb %i_sda_in_16 : i1
      %93 = comb.and %88, %89, %90, %91, %92 : i1
      cf.cond_br %93, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %i2cs_nack_intr, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_0, %clk after %0 : i1
    llhd.drv %f_scl_1, %f_scl after %0 : i1
    llhd.drv %f_scl_d_2, %f_scl_d after %0 : i2
    llhd.drv %i2c_addr_3, %i2c_addr after %0 : i10
    llhd.drv %i2c_hold_4, %i2c_hold after %0 : i8
    llhd.drv %i2c_intr_en_5, %i2c_intr_en after %0 : i4
    llhd.drv %i2c_lcnt_6, %i2c_lcnt after %0 : i24
    llhd.drv %i2c_nack_clr_7, %i2c_nack_clr after %0 : i1
    llhd.drv %i2c_stop_clr_8, %i2c_stop_clr after %0 : i1
    llhd.drv %i2cs_amode_9, %i2cs_amode after %0 : i1
    llhd.drv %i2cs_en_10, %i2cs_en after %0 : i1
    llhd.drv %i2cs_gcall_11, %i2cs_gcall after %0 : i1
    llhd.drv %i2cs_gcall_clr_12, %i2cs_gcall_clr after %0 : i1
    %67 = llhd.prb %i2cs_gcall_intr : i1
    llhd.drv %i2cs_hs_13, %i2cs_hs after %0 : i1
    %68 = llhd.prb %i2cs_nack_intr : i1
    %69 = llhd.prb %i2cs_rx : i8
    llhd.drv %i2cs_sbyte_14, %i2cs_sbyte after %0 : i1
    %70 = llhd.prb %i2cs_stop_intr : i1
    llhd.drv %i2cs_tx_data_15, %i2cs_tx_data after %0 : i8
    llhd.drv %i_sda_in_16, %i_sda_in after %0 : i1
    llhd.drv %r_scl_d2_17, %r_scl_d2 after %0 : i1
    llhd.drv %rst_n_18, %rst_n after %0 : i1
    %71 = llhd.prb %scl_out : i1
    llhd.drv %start_flag_19, %start_flag after %0 : i1
    llhd.drv %stop_flag_20, %stop_flag after %0 : i1
    llhd.drv %tx_empty_21, %tx_empty after %0 : i1
    hw.output %67, %68, %69, %51, %70, %52, %63, %71, %12 : i1, i1, i8, i1, i1, i1, i1, i1, i1
  }
  hw.module private @i2c_top(in %clk : i1, in %f_scl : i1, in %f_scl_d : i3, in %f_sda : i1, in %i2c_addr : i10, in %i2c_aerr_clr : i1, in %i2c_fs_div : i8, in %i2c_hcnt : i24, in %i2c_hold : i8, in %i2c_intr_en : i5, in %i2c_lcnt : i24, in %i2c_mode : i1, in %i2c_nack_clr : i1, out i2c_nack_intr : i1, out i2c_rx : i8, out i2c_rx_wen : i1, in %i2c_stop_clr : i1, out i2c_stop_intr : i1, out i2c_tx_ren : i1, out i2cm_aerr_intr : i1, in %i2cm_amode : i1, in %i2cm_code : i3, out i2cm_data : i1, in %i2cm_en : i1, in %i2cm_gcall : i1, in %i2cm_hs : i1, in %i2cm_lose_arbi_clr : i1, out i2cm_lose_arbi_intr : i1, in %i2cm_sbyte : i1, in %i2cm_stop : i1, out i2cm_work : i1, in %i2cs_amode : i1, in %i2cs_en : i1, in %i2cs_gcall : i1, in %i2cs_gcall_clr : i1, out i2cs_gcall_intr : i1, in %i2cs_hs : i1, in %i2cs_sbyte : i1, in %i2cs_tx_data : i8, out i2cs_work : i1, in %i_scl_in : i1, in %i_sda_in : i1, in %r_scl : i1, in %r_scl_d : i2, in %r_sda : i1, in %rst_n : i1, in %rx_full : i1, out scl_out : i1, out sda_out : i1, in %tx_empty : i1, in %tx_empty_d : i1, in %tx_rd_data : i10, in %wr_clk_div : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %c0_i8 = hw.constant 0 : i8
    %i2c_rx = llhd.sig %c0_i8 : i8
    %i2cm_scl_out = llhd.sig %false : i1
    %i2cm_sda_out = llhd.sig %false : i1
    %i2cs_scl_out = llhd.sig %false : i1
    %i2cs_sda_out = llhd.sig %false : i1
    %1 = comb.extract %f_scl_d from 0 : (i3) -> i1
    %2 = comb.extract %r_scl_d from 0 : (i2) -> i1
    %x_i2cm.i2cm_aerr_intr, %x_i2cm.i2cm_data, %x_i2cm.i2cm_lose_arbi_intr, %x_i2cm.i2cm_nack_intr, %x_i2cm.i2cm_rx, %x_i2cm.i2cm_rx_wen, %x_i2cm.i2cm_stop_intr, %x_i2cm.i2cm_tx_ren, %x_i2cm.i2cm_work, %x_i2cm.scl_out, %x_i2cm.sda_out = hw.instance "x_i2cm" @i2cm(clk: %clk: i1, f_scl: %f_scl: i1, f_scl_d: %1: i1, i2c_addr: %i2c_addr: i10, i2c_aerr_clr: %i2c_aerr_clr: i1, i2c_fs_div: %i2c_fs_div: i8, i2c_hcnt: %i2c_hcnt: i24, i2c_hold: %i2c_hold: i8, i2c_intr_en: %i2c_intr_en: i5, i2c_lcnt: %i2c_lcnt: i24, i2c_nack_clr: %i2c_nack_clr: i1, i2c_stop_clr: %i2c_stop_clr: i1, i2cm_amode: %i2cm_amode: i1, i2cm_code: %i2cm_code: i3, i2cm_en: %i2cm_en: i1, i2cm_gcall: %i2cm_gcall: i1, i2cm_hs: %i2cm_hs: i1, i2cm_lose_arbi_clr: %i2cm_lose_arbi_clr: i1, i2cm_sbyte: %i2cm_sbyte: i1, i2cm_stop: %i2cm_stop: i1, i_scl_in: %i_scl_in: i1, i_sda_in: %i_sda_in: i1, r_scl: %r_scl: i1, r_scl_d: %2: i1, rst_n: %rst_n: i1, start_flag: %29: i1, stop_flag: %30: i1, tx_empty: %tx_empty: i1, tx_empty_d: %tx_empty_d: i1, tx_rd_data: %tx_rd_data: i10, wr_clk_div: %wr_clk_div: i1) -> (i2cm_aerr_intr: i1, i2cm_data: i1, i2cm_lose_arbi_intr: i1, i2cm_nack_intr: i1, i2cm_rx: i8, i2cm_rx_wen: i1, i2cm_stop_intr: i1, i2cm_tx_ren: i1, i2cm_work: i1, scl_out: i1, sda_out: i1) {sv.namehint = "i2cm_rx"}
    llhd.drv %i2cm_scl_out, %x_i2cm.scl_out after %0 : i1
    llhd.drv %i2cm_sda_out, %x_i2cm.sda_out after %0 : i1
    %3 = comb.extract %f_scl_d from 1 : (i3) -> i2
    %4 = comb.extract %i2c_intr_en from 0 : (i5) -> i4
    %5 = comb.extract %r_scl_d from 1 : (i2) -> i1
    %x_i2cs.i2cs_gcall_intr, %x_i2cs.i2cs_nack_intr, %x_i2cs.i2cs_rx, %x_i2cs.i2cs_rx_wen, %x_i2cs.i2cs_stop_intr, %x_i2cs.i2cs_tx_ren, %x_i2cs.i2cs_work, %x_i2cs.scl_out, %x_i2cs.sda_out = hw.instance "x_i2cs" @i2cs(clk: %clk: i1, f_scl: %f_scl: i1, f_scl_d: %3: i2, i2c_addr: %i2c_addr: i10, i2c_hold: %i2c_hold: i8, i2c_intr_en: %4: i4, i2c_lcnt: %i2c_lcnt: i24, i2c_nack_clr: %i2c_nack_clr: i1, i2c_stop_clr: %i2c_stop_clr: i1, i2cs_amode: %i2cs_amode: i1, i2cs_en: %i2cs_en: i1, i2cs_gcall: %i2cs_gcall: i1, i2cs_gcall_clr: %i2cs_gcall_clr: i1, i2cs_hs: %i2cs_hs: i1, i2cs_sbyte: %i2cs_sbyte: i1, i2cs_tx_data: %i2cs_tx_data: i8, i_sda_in: %i_sda_in: i1, r_scl_d2: %5: i1, rst_n: %rst_n: i1, rx_full: %rx_full: i1, start_flag: %29: i1, stop_flag: %30: i1, tx_empty: %tx_empty: i1) -> (i2cs_gcall_intr: i1, i2cs_nack_intr: i1, i2cs_rx: i8, i2cs_rx_wen: i1, i2cs_stop_intr: i1, i2cs_tx_ren: i1, i2cs_work: i1, scl_out: i1, sda_out: i1) {sv.namehint = "i2cs_rx"}
    llhd.drv %i2cs_scl_out, %x_i2cs.scl_out after %0 : i1
    llhd.drv %i2cs_sda_out, %x_i2cs.sda_out after %0 : i1
    %6 = llhd.prb %i2cm_sda_out : i1
    %7 = llhd.prb %i2cs_sda_out : i1
    %8 = comb.mux %i2c_mode, %6, %7 : i1
    %9 = comb.replicate %i2cm_en : (i1) -> i8
    %10 = comb.and %9, %x_i2cm.i2cm_rx : i8
    %11 = comb.replicate %i2cs_en : (i1) -> i8
    %12 = comb.and %11, %x_i2cs.i2cs_rx : i8
    %13 = comb.or %10, %12 : i8
    llhd.drv %i2c_rx, %13 after %0 : i8
    %14 = comb.and %i2cm_en, %x_i2cm.i2cm_rx_wen : i1
    %15 = comb.and %i2cs_en, %x_i2cs.i2cs_rx_wen : i1
    %16 = comb.or %14, %15 : i1
    %17 = comb.and %i2cm_en, %x_i2cm.i2cm_tx_ren : i1
    %18 = comb.and %i2cs_en, %x_i2cs.i2cs_tx_ren : i1
    %19 = comb.or %17, %18 : i1
    %20 = llhd.prb %i2cm_scl_out : i1
    %21 = llhd.prb %i2cs_scl_out : i1
    %22 = comb.mux %i2c_mode, %20, %21 : i1
    %23 = comb.and %i2cm_en, %x_i2cm.i2cm_stop_intr : i1
    %24 = comb.and %i2cs_en, %x_i2cs.i2cs_stop_intr : i1
    %25 = comb.or %23, %24 : i1
    %26 = comb.and %i2cm_en, %x_i2cm.i2cm_nack_intr : i1
    %27 = comb.and %i2cs_en, %x_i2cs.i2cs_nack_intr : i1
    %28 = comb.or %26, %27 : i1
    %29 = comb.and %i_scl_in, %f_sda {sv.namehint = "start_flag"} : i1
    %30 = comb.and %i_scl_in, %r_sda {sv.namehint = "stop_flag"} : i1
    %31 = llhd.prb %i2c_rx : i8
    hw.output %28, %31, %16, %25, %19, %x_i2cm.i2cm_aerr_intr, %x_i2cm.i2cm_data, %x_i2cm.i2cm_lose_arbi_intr, %x_i2cm.i2cm_work, %x_i2cs.i2cs_gcall_intr, %x_i2cs.i2cs_work, %22, %8 : i1, i8, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1
  }
  hw.module private @sdata_if(in %clk : i1, out f_nss : i1, out f_rxd : i1, out f_scl : i1, out f_scl_d : i3, out f_sda : i1, in %i2c_en : i1, in %i2c_mode : i1, in %i2cm_en : i1, in %i2cs_en : i1, out i_nss_in : i1, out i_scl_in : i1, out i_sd1_in : i1, out i_sda_in : i1, out nss_ie_n : i1, in %nss_in : i1, out nss_oe_n : i1, out nss_out : i1, out r_scl : i1, out r_scl_d : i3, out r_sda : i1, in %rst_n : i1, in %scl_out : i1, out sclk_ie_n : i1, in %sclk_in : i1, out sclk_oe_n : i1, out sclk_out : i1, out sd0_ie_n : i1, in %sd0_in : i1, out sd0_oe_n : i1, out sd0_out : i1, out sd1_ie_n : i1, in %sd1_in : i1, out sd1_oe_n : i1, out sd1_out : i1, in %sda_out : i1, in %sdata_en : i1, in %spi_mo : i1, in %spi_rx_en : i1, in %spi_so : i1, in %spim_en : i1, in %spim_nss : i1, in %spim_sck : i1, in %spis_en : i1, in %txd_out : i1, in %uart_en : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %false = hw.constant false
    %c0_i4 = hw.constant 0 : i4
    %c0_i3 = hw.constant 0 : i3
    %c-1_i4 = hw.constant -1 : i4
    %f_sclk_d = llhd.sig %c0_i3 : i3
    %nss_in_d = llhd.sig %c0_i4 : i4
    %r_sclk_d = llhd.sig %c0_i3 : i3
    %sclk_in_d = llhd.sig %c0_i4 : i4
    %sd0_in_d = llhd.sig %c0_i4 : i4
    %sd1_in_d = llhd.sig %c0_i4 : i4
    %clk_0 = llhd.sig name "clk" %false : i1
    %2 = llhd.prb %clk_0 : i1
    %f_scl_d = llhd.sig %c0_i3 : i3
    %f_sclk = llhd.sig %false : i1
    %i2c_en_1 = llhd.sig name "i2c_en" %false : i1
    %i2cm_en_2 = llhd.sig name "i2cm_en" %false : i1
    %i2cs_en_3 = llhd.sig name "i2cs_en" %false : i1
    %nss_in_4 = llhd.sig name "nss_in" %false : i1
    %r_scl_d = llhd.sig %c0_i3 : i3
    %r_sclk = llhd.sig %false : i1
    %rst_n_5 = llhd.sig name "rst_n" %false : i1
    %3 = llhd.prb %rst_n_5 : i1
    %sclk_in_6 = llhd.sig name "sclk_in" %false : i1
    %sd0_in_7 = llhd.sig name "sd0_in" %false : i1
    %sd1_in_8 = llhd.sig name "sd1_in" %false : i1
    %sdata_en_9 = llhd.sig name "sdata_en" %false : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %61 = llhd.prb %clk_0 : i1
      %62 = llhd.prb %rst_n_5 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %63 = llhd.prb %clk_0 : i1
      %64 = comb.xor bin %61, %true : i1
      %65 = comb.and bin %64, %63 : i1
      %66 = llhd.prb %rst_n_5 : i1
      %67 = comb.xor bin %66, %true : i1
      %68 = comb.and bin %62, %67 : i1
      %69 = comb.or bin %65, %68 : i1
      cf.cond_br %69, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %70 = llhd.prb %rst_n_5 : i1
      %71 = comb.xor %70, %true : i1
      cf.cond_br %71, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %sd0_in_d, %c-1_i4 after %1 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %72 = llhd.prb %sdata_en_9 : i1
      cf.cond_br %72, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %73 = llhd.prb %sd0_in_d : i4
      %74 = comb.extract %73 from 0 : (i4) -> i3
      %75 = llhd.prb %sd0_in_7 : i1
      %76 = comb.concat %74, %75 : i3, i1
      llhd.drv %sd0_in_d, %76 after %1 : i4
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      llhd.drv %sd0_in_d, %c-1_i4 after %1 : i4
      cf.br ^bb1
    }
    %4 = llhd.prb %sd0_in_d : i4
    %5 = comb.extract %4 from 2 : (i4) -> i1
    %6 = comb.extract %4 from 3 : (i4) -> i1
    %7 = comb.xor %6, %true : i1
    %8 = comb.and %5, %7 {sv.namehint = "r_sd0"} : i1
    %9 = comb.xor %5, %true : i1
    %10 = comb.and %9, %6 {sv.namehint = "f_sd0"} : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %61 = llhd.prb %clk_0 : i1
      %62 = llhd.prb %rst_n_5 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %63 = llhd.prb %clk_0 : i1
      %64 = comb.xor bin %61, %true : i1
      %65 = comb.and bin %64, %63 : i1
      %66 = llhd.prb %rst_n_5 : i1
      %67 = comb.xor bin %66, %true : i1
      %68 = comb.and bin %62, %67 : i1
      %69 = comb.or bin %65, %68 : i1
      cf.cond_br %69, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %70 = llhd.prb %rst_n_5 : i1
      %71 = comb.xor %70, %true : i1
      cf.cond_br %71, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %sd1_in_d, %c-1_i4 after %1 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %72 = llhd.prb %sdata_en_9 : i1
      cf.cond_br %72, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %73 = llhd.prb %sd1_in_d : i4
      %74 = comb.extract %73 from 0 : (i4) -> i3
      %75 = llhd.prb %sd1_in_8 : i1
      %76 = comb.concat %74, %75 : i3, i1
      llhd.drv %sd1_in_d, %76 after %1 : i4
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      llhd.drv %sd1_in_d, %c-1_i4 after %1 : i4
      cf.br ^bb1
    }
    %11 = llhd.prb %sd1_in_d : i4
    %12 = comb.extract %11 from 2 : (i4) -> i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %61 = llhd.prb %clk_0 : i1
      %62 = llhd.prb %rst_n_5 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %63 = llhd.prb %clk_0 : i1
      %64 = comb.xor bin %61, %true : i1
      %65 = comb.and bin %64, %63 : i1
      %66 = llhd.prb %rst_n_5 : i1
      %67 = comb.xor bin %66, %true : i1
      %68 = comb.and bin %62, %67 : i1
      %69 = comb.or bin %65, %68 : i1
      cf.cond_br %69, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %70 = llhd.prb %rst_n_5 : i1
      %71 = comb.xor %70, %true : i1
      cf.cond_br %71, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %sclk_in_d, %c-1_i4 after %1 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %72 = llhd.prb %sdata_en_9 : i1
      cf.cond_br %72, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %73 = llhd.prb %sclk_in_d : i4
      %74 = comb.extract %73 from 0 : (i4) -> i3
      %75 = llhd.prb %sclk_in_6 : i1
      %76 = comb.concat %74, %75 : i3, i1
      llhd.drv %sclk_in_d, %76 after %1 : i4
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      llhd.drv %sclk_in_d, %c-1_i4 after %1 : i4
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %61 = llhd.prb %clk_0 : i1
      %62 = llhd.prb %rst_n_5 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %63 = llhd.prb %clk_0 : i1
      %64 = comb.xor bin %61, %true : i1
      %65 = comb.and bin %64, %63 : i1
      %66 = llhd.prb %rst_n_5 : i1
      %67 = comb.xor bin %66, %true : i1
      %68 = comb.and bin %62, %67 : i1
      %69 = comb.or bin %65, %68 : i1
      cf.cond_br %69, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %70 = llhd.prb %rst_n_5 : i1
      %71 = comb.xor %70, %true : i1
      cf.cond_br %71, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %f_sclk_d, %c0_i3 after %1 : i3
      llhd.drv %r_sclk_d, %c0_i3 after %1 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %72 = llhd.prb %i2c_en_1 : i1
      cf.cond_br %72, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %73 = llhd.prb %f_sclk_d : i3
      %74 = comb.extract %73 from 0 : (i3) -> i2
      %75 = llhd.prb %f_sclk : i1
      %76 = comb.concat %74, %75 : i2, i1
      llhd.drv %f_sclk_d, %76 after %1 : i3
      %77 = llhd.prb %r_sclk_d : i3
      %78 = comb.extract %77 from 0 : (i3) -> i2
      %79 = llhd.prb %r_sclk : i1
      %80 = comb.concat %78, %79 : i2, i1
      llhd.drv %r_sclk_d, %80 after %1 : i3
      cf.br ^bb1
    }
    %13 = llhd.prb %sclk_in_d : i4
    %14 = comb.extract %13 from 2 : (i4) -> i1
    %15 = comb.extract %13 from 3 : (i4) -> i1
    %16 = comb.xor %15, %true : i1
    %17 = comb.and %14, %16 : i1
    llhd.drv %r_sclk, %17 after %0 : i1
    %18 = comb.xor %14, %true : i1
    %19 = comb.and %18, %15 : i1
    llhd.drv %f_sclk, %19 after %0 : i1
    %20 = llhd.prb %r_sclk : i1
    %21 = llhd.prb %f_sclk : i1
    %22 = llhd.prb %r_sclk_d : i3
    llhd.drv %r_scl_d, %22 after %0 : i3
    %23 = llhd.prb %f_sclk_d : i3
    llhd.drv %f_scl_d, %23 after %0 : i3
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %61 = llhd.prb %clk_0 : i1
      %62 = llhd.prb %rst_n_5 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %63 = llhd.prb %clk_0 : i1
      %64 = comb.xor bin %61, %true : i1
      %65 = comb.and bin %64, %63 : i1
      %66 = llhd.prb %rst_n_5 : i1
      %67 = comb.xor bin %66, %true : i1
      %68 = comb.and bin %62, %67 : i1
      %69 = comb.or bin %65, %68 : i1
      cf.cond_br %69, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %70 = llhd.prb %rst_n_5 : i1
      %71 = comb.xor %70, %true : i1
      cf.cond_br %71, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %nss_in_d, %c-1_i4 after %1 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %72 = llhd.prb %nss_in_d : i4
      %73 = comb.extract %72 from 0 : (i4) -> i3
      %74 = llhd.prb %nss_in_4 : i1
      %75 = comb.concat %73, %74 : i3, i1
      llhd.drv %nss_in_d, %75 after %1 : i4
      cf.br ^bb1
    }
    %24 = llhd.prb %nss_in_d : i4
    %25 = comb.extract %24 from 2 : (i4) -> i1
    %26 = comb.xor %25, %true : i1
    %27 = comb.extract %24 from 3 : (i4) -> i1
    %28 = comb.and %26, %27 : i1
    %29 = llhd.prb %i2cm_en_2 : i1
    %30 = comb.xor %29, %true : i1
    %31 = llhd.prb %i2cs_en_3 : i1
    %32 = comb.xor %31, %true : i1
    %33 = comb.mux %i2c_mode, %30, %32 : i1
    %34 = comb.or %scl_out, %33 : i1
    %35 = comb.xor %spim_en, %true : i1
    %36 = comb.and %34, %35 : i1
    %37 = comb.and %scl_out, %29 : i1
    %38 = comb.and %spim_sck, %spim_en : i1
    %39 = comb.or %37, %38 : i1
    %40 = comb.xor %uart_en, %true : i1
    %41 = comb.or %29, %31 : i1
    %42 = comb.xor %41, %true : i1
    %43 = comb.and %spim_en, %spi_rx_en : i1
    %44 = comb.or %43, %spis_en : i1
    %45 = comb.xor %44, %true : i1
    %46 = comb.and %40, %42, %45 : i1
    %47 = llhd.prb %i2c_en_1 : i1
    %48 = comb.xor %47, %true : i1
    %49 = comb.or %sda_out, %48 : i1
    %50 = comb.and %49, %40, %35 : i1
    %51 = comb.and %sda_out, %47 : i1
    %52 = comb.and %txd_out, %uart_en : i1
    %53 = comb.and %spi_mo, %spim_en : i1
    %54 = comb.or %51, %52, %53 : i1
    %55 = comb.xor %spis_en, %true : i1
    %56 = comb.and %55, %48 : i1
    %57 = comb.and %spi_so, %spis_en : i1
    %58 = comb.or %spim_nss, %35 : i1
    llhd.drv %clk_0, %clk after %0 : i1
    %59 = llhd.prb %f_scl_d : i3
    llhd.drv %i2c_en_1, %i2c_en after %0 : i1
    llhd.drv %i2cm_en_2, %i2cm_en after %0 : i1
    llhd.drv %i2cs_en_3, %i2cs_en after %0 : i1
    llhd.drv %nss_in_4, %nss_in after %0 : i1
    %60 = llhd.prb %r_scl_d : i3
    llhd.drv %rst_n_5, %rst_n after %0 : i1
    llhd.drv %sclk_in_6, %sclk_in after %0 : i1
    llhd.drv %sd0_in_7, %sd0_in after %0 : i1
    llhd.drv %sd1_in_8, %sd1_in after %0 : i1
    llhd.drv %sdata_en_9, %sdata_en after %0 : i1
    hw.output %28, %21, %21, %59, %10, %25, %14, %12, %5, %spim_en, %35, %58, %20, %60, %8, %46, %36, %39, %56, %50, %54, %35, %55, %57 : i1, i1, i1, i3, i1, i1, i1, i1, i1, i1, i1, i1, i1, i3, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1
  }
  hw.module private @spi(in %clk : i1, in %clk_div0 : i23, in %cpha : i1, in %cpol : i1, in %f_nss : i1, in %f_sclk : i1, in %i_nss_in : i1, in %nss_toggle : i1, in %r_sclk : i1, in %rst_n : i1, in %rx_full : i1, out rx_wr_data : i16, in %spi_data_size : i4, in %spi_intr_en : i1, in %spi_mi : i1, out spi_mo : i1, in %spi_rx_en : i1, out spi_rx_wen : i1, in %spi_si : i1, out spi_so : i1, in %spi_stop_clr : i1, out spi_stop_intr : i1, in %spi_tx_en : i1, out spi_tx_ren : i1, out spi_work : i1, in %spim_en : i1, out spim_nss : i1, out spim_sck : i1, in %spis_en : i1, in %tx_empty : i1, in %tx_rd_data : i16) {
    %c-1_i5 = hw.constant -1 : i5
    %c-1_i4 = hw.constant -1 : i4
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %c0_i16 = hw.constant 0 : i16
    %c-2_i4 = hw.constant -2 : i4
    %c-3_i4 = hw.constant -3 : i4
    %c-4_i4 = hw.constant -4 : i4
    %c-5_i4 = hw.constant -5 : i4
    %c-6_i4 = hw.constant -6 : i4
    %c-7_i4 = hw.constant -7 : i4
    %c-8_i4 = hw.constant -8 : i4
    %c7_i4 = hw.constant 7 : i4
    %c6_i4 = hw.constant 6 : i4
    %c5_i4 = hw.constant 5 : i4
    %c4_i4 = hw.constant 4 : i4
    %c3_i4 = hw.constant 3 : i4
    %c2_i4 = hw.constant 2 : i4
    %c1_i4 = hw.constant 1 : i4
    %c0_i4 = hw.constant 0 : i4
    %false = hw.constant false
    %c1_i23 = hw.constant 1 : i23
    %c0_i23 = hw.constant 0 : i23
    %true = hw.constant true
    %c0_i5 = hw.constant 0 : i5
    %c-2_i2 = hw.constant -2 : i2
    %c-1_i2 = hw.constant -1 : i2
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %cnt_bits = llhd.sig %c0_i4 : i4
    %cnt_bits0_d = llhd.sig %false : i1
    %data_chg = llhd.sig %false : i1
    %data_smp = llhd.sig %false : i1
    %f_nss_d = llhd.sig %false : i1
    %nxt_spim_fsm = llhd.sig %c0_i2 : i2
    %spi_mo = llhd.sig %false : i1
    %2 = llhd.prb %spi_mo : i1
    %spi_so = llhd.sig %false : i1
    %spi_stop_intr = llhd.sig %false : i1
    %spim_1st_bit = llhd.sig %false : i1
    %spim_fsm = llhd.sig %c0_i2 : i2
    %3 = llhd.prb %spim_fsm : i2
    %spim_nss = llhd.sig %false : i1
    %spim_rx = llhd.sig %c0_i16 : i16
    %spim_sck = llhd.sig %false : i1
    %spis_1st_bit = llhd.sig %false : i1
    %spis_rx = llhd.sig %c0_i16 : i16
    %spis_rx_en = llhd.sig %false : i1
    %spis_rx_wen = llhd.sig %false : i1
    %stop_cnt = llhd.sig %c0_i2 : i2
    %txcnt_bits = llhd.sig %c0_i5 : i5
    %txcnt_div = llhd.sig %c0_i23 : i23
    %clk_0 = llhd.sig name "clk" %false : i1
    %4 = llhd.prb %clk_0 : i1
    %cpha_1 = llhd.sig name "cpha" %false : i1
    %5 = llhd.prb %cpha_1 : i1
    %cpol_2 = llhd.sig name "cpol" %false : i1
    %6 = llhd.prb %cpol_2 : i1
    %f_nss_3 = llhd.sig name "f_nss" %false : i1
    %f_sclk_4 = llhd.sig name "f_sclk" %false : i1
    %7 = llhd.prb %f_sclk_4 : i1
    %i_nss_in_5 = llhd.sig name "i_nss_in" %false : i1
    %r_sclk_6 = llhd.sig name "r_sclk" %false : i1
    %8 = llhd.prb %r_sclk_6 : i1
    %rst_n_7 = llhd.sig name "rst_n" %false : i1
    %9 = llhd.prb %rst_n_7 : i1
    %rx_wr_data = llhd.sig %c0_i16 : i16
    %spi_data_size_8 = llhd.sig name "spi_data_size" %c0_i4 : i4
    %10 = llhd.prb %spi_data_size_8 : i4
    %spi_intr_en_9 = llhd.sig name "spi_intr_en" %false : i1
    %spi_mi_10 = llhd.sig name "spi_mi" %false : i1
    %spi_rx_en_11 = llhd.sig name "spi_rx_en" %false : i1
    %spi_si_12 = llhd.sig name "spi_si" %false : i1
    %spi_stop_clr_13 = llhd.sig name "spi_stop_clr" %false : i1
    %spi_tx_en_14 = llhd.sig name "spi_tx_en" %false : i1
    %spim_all_end = llhd.sig %false : i1
    %spim_data = llhd.sig %false : i1
    %spim_data_end = llhd.sig %false : i1
    %11 = llhd.prb %spim_data_end : i1
    %spim_en_15 = llhd.sig name "spim_en" %false : i1
    %spim_idle = llhd.sig %false : i1
    %spim_idle_end = llhd.sig %false : i1
    %12 = llhd.prb %spim_idle_end : i1
    %spim_nss_clr = llhd.sig %false : i1
    %spim_nss_set = llhd.sig %false : i1
    %spim_start = llhd.sig %false : i1
    %spim_start_end = llhd.sig %false : i1
    %13 = llhd.prb %spim_start_end : i1
    %spim_stop = llhd.sig %false : i1
    %spim_stop_end = llhd.sig %false : i1
    %14 = llhd.prb %spim_stop_end : i1
    %spim_stop_intr = llhd.sig %false : i1
    %spis_cnt_load = llhd.sig %false : i1
    %spis_en_16 = llhd.sig name "spis_en" %false : i1
    %spis_stop_intr = llhd.sig %false : i1
    %stop_judge = llhd.sig %false : i1
    %15 = llhd.prb %stop_judge : i1
    %tx_empty_17 = llhd.sig name "tx_empty" %false : i1
    %tx_rd_data_18 = llhd.sig name "tx_rd_data" %c0_i16 : i16
    %16 = llhd.prb %tx_rd_data_18 : i16
    %txcnt_div_eq = llhd.sig %false : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %100 = llhd.prb %clk_0 : i1
      %101 = llhd.prb %rst_n_7 : i1
      llhd.wait (%4, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %102 = llhd.prb %clk_0 : i1
      %103 = comb.xor bin %100, %true : i1
      %104 = comb.and bin %103, %102 : i1
      %105 = llhd.prb %rst_n_7 : i1
      %106 = comb.xor bin %105, %true : i1
      %107 = comb.and bin %101, %106 : i1
      %108 = comb.or bin %104, %107 : i1
      cf.cond_br %108, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %109 = llhd.prb %rst_n_7 : i1
      %110 = comb.xor %109, %true : i1
      cf.cond_br %110, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %spim_fsm, %c0_i2 after %1 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %111 = llhd.prb %nxt_spim_fsm : i2
      llhd.drv %spim_fsm, %111 after %1 : i2
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 10 preds: ^bb0, ^bb4, ^bb5, ^bb8, ^bb9, ^bb12, ^bb13, ^bb16, ^bb17, ^bb18
      llhd.wait (%15, %11, %3, %12, %13, %14 : i1, i1, i2, i1, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %100 = llhd.prb %spim_fsm : i2
      %101 = comb.icmp ceq %100, %c0_i2 : i2
      cf.cond_br %101, ^bb3, ^bb6
    ^bb3:  // pred: ^bb2
      %102 = llhd.prb %spim_idle_end : i1
      cf.cond_br %102, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %nxt_spim_fsm, %c1_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      llhd.drv %nxt_spim_fsm, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb6:  // pred: ^bb2
      %103 = comb.icmp ceq %100, %c1_i2 : i2
      cf.cond_br %103, ^bb7, ^bb10
    ^bb7:  // pred: ^bb6
      %104 = llhd.prb %spim_start_end : i1
      cf.cond_br %104, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %nxt_spim_fsm, %c-1_i2 after %0 : i2
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      llhd.drv %nxt_spim_fsm, %c1_i2 after %0 : i2
      cf.br ^bb1
    ^bb10:  // pred: ^bb6
      %105 = comb.icmp ceq %100, %c-1_i2 : i2
      cf.cond_br %105, ^bb11, ^bb14
    ^bb11:  // pred: ^bb10
      %106 = llhd.prb %spim_data_end : i1
      cf.cond_br %106, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      llhd.drv %nxt_spim_fsm, %c-2_i2 after %0 : i2
      cf.br ^bb1
    ^bb13:  // pred: ^bb11
      llhd.drv %nxt_spim_fsm, %c-1_i2 after %0 : i2
      cf.br ^bb1
    ^bb14:  // pred: ^bb10
      %107 = llhd.prb %spim_stop_end : i1
      cf.cond_br %107, ^bb15, ^bb18
    ^bb15:  // pred: ^bb14
      %108 = llhd.prb %stop_judge : i1
      cf.cond_br %108, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      llhd.drv %nxt_spim_fsm, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb17:  // pred: ^bb15
      llhd.drv %nxt_spim_fsm, %c1_i2 after %0 : i2
      cf.br ^bb1
    ^bb18:  // pred: ^bb14
      llhd.drv %nxt_spim_fsm, %c-2_i2 after %0 : i2
      cf.br ^bb1
    }
    %17 = llhd.prb %spim_idle : i1
    %18 = llhd.prb %spi_tx_en_14 : i1
    %19 = llhd.prb %spi_rx_en_11 : i1
    %20 = comb.xor %19, %true : i1
    %21 = llhd.prb %tx_empty_17 : i1
    %22 = comb.xor %21, %true : i1
    %23 = comb.and %18, %20, %22 : i1
    %24 = comb.xor %18, %true : i1
    %25 = comb.xor %rx_full, %true : i1
    %26 = comb.and %24, %19, %25 : i1
    %27 = comb.and %18, %19, %22, %25 : i1
    %28 = comb.or %23, %26, %27 : i1
    %29 = comb.and %17, %28 : i1
    llhd.drv %spim_idle_end, %29 after %0 : i1
    %30 = llhd.prb %spim_start : i1
    %31 = llhd.prb %txcnt_div_eq : i1
    %32 = comb.and %30, %31 : i1
    llhd.drv %spim_start_end, %32 after %0 : i1
    %33 = llhd.prb %spim_data : i1
    %34 = llhd.prb %txcnt_bits : i5
    %35 = comb.icmp eq %34, %c0_i5 : i5
    %36 = comb.and %33, %35, %31 {sv.namehint = "spim_rx_wen"} : i1
    llhd.drv %spim_data_end, %36 after %0 : i1
    %37 = llhd.prb %spim_stop : i1
    %38 = comb.and %37, %31 : i1
    %39 = llhd.prb %stop_cnt : i2
    %40 = comb.icmp eq %39, %c-2_i2 : i2
    %41 = comb.xor %nss_toggle, %true : i1
    %42 = comb.or %41, %40 : i1
    %43 = comb.and %38, %42 : i1
    llhd.drv %spim_stop_end, %43 after %0 : i1
    %44 = comb.or %12, %13, %11, %14 : i1
    llhd.drv %spim_all_end, %44 after %0 : i1
    %45 = comb.and %18, %21 : i1
    %46 = comb.and %19, %rx_full : i1
    %47 = comb.or %45, %46 : i1
    llhd.drv %stop_judge, %47 after %0 : i1
    %48 = comb.icmp eq %3, %c0_i2 : i2
    llhd.drv %spim_idle, %48 after %0 : i1
    %49 = comb.icmp eq %3, %c1_i2 : i2
    llhd.drv %spim_start, %49 after %0 : i1
    %50 = comb.icmp eq %3, %c-1_i2 : i2
    llhd.drv %spim_data, %50 after %0 : i1
    %51 = comb.icmp eq %3, %c-2_i2 : i2
    llhd.drv %spim_stop, %51 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %100 = llhd.prb %clk_0 : i1
      %101 = llhd.prb %rst_n_7 : i1
      llhd.wait (%4, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %102 = llhd.prb %clk_0 : i1
      %103 = comb.xor bin %100, %true : i1
      %104 = comb.and bin %103, %102 : i1
      %105 = llhd.prb %rst_n_7 : i1
      %106 = comb.xor bin %105, %true : i1
      %107 = comb.and bin %101, %106 : i1
      %108 = comb.or bin %104, %107 : i1
      cf.cond_br %108, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %109 = llhd.prb %rst_n_7 : i1
      %110 = comb.xor %109, %true : i1
      cf.cond_br %110, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %txcnt_bits, %c0_i5 after %1 : i5
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %111 = llhd.prb %spim_start_end : i1
      %112 = llhd.prb %tx_empty_17 : i1
      %113 = comb.xor %112, %true : i1
      %114 = llhd.prb %spim_stop_end : i1
      %115 = comb.and %113, %114 : i1
      %116 = comb.or %111, %115 : i1
      cf.cond_br %116, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %117 = llhd.prb %spi_data_size_8 : i4
      %118 = comb.concat %117, %true : i4, i1
      llhd.drv %txcnt_bits, %118 after %1 : i5
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %119 = llhd.prb %spim_idle : i1
      %120 = llhd.prb %spim_start : i1
      %121 = llhd.prb %spim_stop : i1
      %122 = llhd.prb %spim_data_end : i1
      %123 = comb.or %119, %120, %121, %122 : i1
      cf.cond_br %123, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %txcnt_bits, %c0_i5 after %1 : i5
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %124 = llhd.prb %txcnt_div_eq : i1
      cf.cond_br %124, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %125 = llhd.prb %txcnt_bits : i5
      %126 = comb.add %125, %c-1_i5 : i5
      llhd.drv %txcnt_bits, %126 after %1 : i5
      cf.br ^bb1
    }
    %52 = llhd.prb %txcnt_div : i23
    %53 = comb.icmp eq %52, %clk_div0 : i23
    llhd.drv %txcnt_div_eq, %53 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %100 = llhd.prb %clk_0 : i1
      %101 = llhd.prb %rst_n_7 : i1
      llhd.wait (%4, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %102 = llhd.prb %clk_0 : i1
      %103 = comb.xor bin %100, %true : i1
      %104 = comb.and bin %103, %102 : i1
      %105 = llhd.prb %rst_n_7 : i1
      %106 = comb.xor bin %105, %true : i1
      %107 = comb.and bin %101, %106 : i1
      %108 = comb.or bin %104, %107 : i1
      cf.cond_br %108, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %109 = llhd.prb %rst_n_7 : i1
      %110 = comb.xor %109, %true : i1
      cf.cond_br %110, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %txcnt_div, %c0_i23 after %1 : i23
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %111 = llhd.prb %txcnt_div_eq : i1
      %112 = llhd.prb %spim_all_end : i1
      %113 = comb.or %111, %112 : i1
      cf.cond_br %113, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %txcnt_div, %c0_i23 after %1 : i23
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %114 = llhd.prb %txcnt_div : i23
      %115 = comb.add %114, %c1_i23 : i23
      llhd.drv %txcnt_div, %115 after %1 : i23
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 21 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb9, ^bb11, ^bb13, ^bb15, ^bb17, ^bb19, ^bb21, ^bb23, ^bb25, ^bb27, ^bb29, ^bb31, ^bb33, ^bb35, ^bb37, ^bb38
      %100 = llhd.prb %clk_0 : i1
      %101 = llhd.prb %rst_n_7 : i1
      llhd.wait (%4, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %102 = llhd.prb %clk_0 : i1
      %103 = comb.xor bin %100, %true : i1
      %104 = comb.and bin %103, %102 : i1
      %105 = llhd.prb %rst_n_7 : i1
      %106 = comb.xor bin %105, %true : i1
      %107 = comb.and bin %101, %106 : i1
      %108 = comb.or bin %104, %107 : i1
      cf.cond_br %108, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %109 = llhd.prb %rst_n_7 : i1
      %110 = comb.xor %109, %true : i1
      cf.cond_br %110, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %spi_mo, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %111 = llhd.prb %spim_en_15 : i1
      %112 = comb.xor %111, %true : i1
      cf.cond_br %112, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %spi_mo, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %113 = llhd.prb %txcnt_bits : i5
      %114 = comb.extract %113 from 0 : (i5) -> i1
      %115 = comb.xor %114, %true : i1
      %116 = llhd.prb %txcnt_div_eq : i1
      %117 = llhd.prb %spi_tx_en_14 : i1
      %118 = llhd.prb %tx_empty_17 : i1
      %119 = comb.xor %118, %true : i1
      %120 = comb.and %115, %116, %117, %119 : i1
      cf.cond_br %120, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %121 = llhd.prb %txcnt_bits : i5
      %122 = comb.extract %121 from 1 : (i5) -> i4
      %123 = comb.icmp ceq %122, %c0_i4 : i4
      cf.cond_br %123, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %124 = llhd.prb %spim_1st_bit : i1
      llhd.drv %spi_mo, %124 after %1 : i1
      cf.br ^bb1
    ^bb10:  // pred: ^bb8
      %125 = comb.icmp ceq %122, %c1_i4 : i4
      cf.cond_br %125, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %126 = llhd.prb %tx_rd_data_18 : i16
      %127 = comb.extract %126 from 0 : (i16) -> i1
      llhd.drv %spi_mo, %127 after %1 : i1
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      %128 = comb.icmp ceq %122, %c2_i4 : i4
      cf.cond_br %128, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      %129 = llhd.prb %tx_rd_data_18 : i16
      %130 = comb.extract %129 from 1 : (i16) -> i1
      llhd.drv %spi_mo, %130 after %1 : i1
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      %131 = comb.icmp ceq %122, %c3_i4 : i4
      cf.cond_br %131, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      %132 = llhd.prb %tx_rd_data_18 : i16
      %133 = comb.extract %132 from 2 : (i16) -> i1
      llhd.drv %spi_mo, %133 after %1 : i1
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      %134 = comb.icmp ceq %122, %c4_i4 : i4
      cf.cond_br %134, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      %135 = llhd.prb %tx_rd_data_18 : i16
      %136 = comb.extract %135 from 3 : (i16) -> i1
      llhd.drv %spi_mo, %136 after %1 : i1
      cf.br ^bb1
    ^bb18:  // pred: ^bb16
      %137 = comb.icmp ceq %122, %c5_i4 : i4
      cf.cond_br %137, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %138 = llhd.prb %tx_rd_data_18 : i16
      %139 = comb.extract %138 from 4 : (i16) -> i1
      llhd.drv %spi_mo, %139 after %1 : i1
      cf.br ^bb1
    ^bb20:  // pred: ^bb18
      %140 = comb.icmp ceq %122, %c6_i4 : i4
      cf.cond_br %140, ^bb21, ^bb22
    ^bb21:  // pred: ^bb20
      %141 = llhd.prb %tx_rd_data_18 : i16
      %142 = comb.extract %141 from 5 : (i16) -> i1
      llhd.drv %spi_mo, %142 after %1 : i1
      cf.br ^bb1
    ^bb22:  // pred: ^bb20
      %143 = comb.icmp ceq %122, %c7_i4 : i4
      cf.cond_br %143, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      %144 = llhd.prb %tx_rd_data_18 : i16
      %145 = comb.extract %144 from 6 : (i16) -> i1
      llhd.drv %spi_mo, %145 after %1 : i1
      cf.br ^bb1
    ^bb24:  // pred: ^bb22
      %146 = comb.icmp ceq %122, %c-8_i4 : i4
      cf.cond_br %146, ^bb25, ^bb26
    ^bb25:  // pred: ^bb24
      %147 = llhd.prb %tx_rd_data_18 : i16
      %148 = comb.extract %147 from 7 : (i16) -> i1
      llhd.drv %spi_mo, %148 after %1 : i1
      cf.br ^bb1
    ^bb26:  // pred: ^bb24
      %149 = comb.icmp ceq %122, %c-7_i4 : i4
      cf.cond_br %149, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      %150 = llhd.prb %tx_rd_data_18 : i16
      %151 = comb.extract %150 from 8 : (i16) -> i1
      llhd.drv %spi_mo, %151 after %1 : i1
      cf.br ^bb1
    ^bb28:  // pred: ^bb26
      %152 = comb.icmp ceq %122, %c-6_i4 : i4
      cf.cond_br %152, ^bb29, ^bb30
    ^bb29:  // pred: ^bb28
      %153 = llhd.prb %tx_rd_data_18 : i16
      %154 = comb.extract %153 from 9 : (i16) -> i1
      llhd.drv %spi_mo, %154 after %1 : i1
      cf.br ^bb1
    ^bb30:  // pred: ^bb28
      %155 = comb.icmp ceq %122, %c-5_i4 : i4
      cf.cond_br %155, ^bb31, ^bb32
    ^bb31:  // pred: ^bb30
      %156 = llhd.prb %tx_rd_data_18 : i16
      %157 = comb.extract %156 from 10 : (i16) -> i1
      llhd.drv %spi_mo, %157 after %1 : i1
      cf.br ^bb1
    ^bb32:  // pred: ^bb30
      %158 = comb.icmp ceq %122, %c-4_i4 : i4
      cf.cond_br %158, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      %159 = llhd.prb %tx_rd_data_18 : i16
      %160 = comb.extract %159 from 11 : (i16) -> i1
      llhd.drv %spi_mo, %160 after %1 : i1
      cf.br ^bb1
    ^bb34:  // pred: ^bb32
      %161 = comb.icmp ceq %122, %c-3_i4 : i4
      cf.cond_br %161, ^bb35, ^bb36
    ^bb35:  // pred: ^bb34
      %162 = llhd.prb %tx_rd_data_18 : i16
      %163 = comb.extract %162 from 12 : (i16) -> i1
      llhd.drv %spi_mo, %163 after %1 : i1
      cf.br ^bb1
    ^bb36:  // pred: ^bb34
      %164 = comb.icmp ceq %122, %c-2_i4 : i4
      cf.cond_br %164, ^bb37, ^bb38
    ^bb37:  // pred: ^bb36
      %165 = llhd.prb %tx_rd_data_18 : i16
      %166 = comb.extract %165 from 13 : (i16) -> i1
      llhd.drv %spi_mo, %166 after %1 : i1
      cf.br ^bb1
    ^bb38:  // pred: ^bb36
      %167 = llhd.prb %tx_rd_data_18 : i16
      %168 = comb.extract %167 from 14 : (i16) -> i1
      llhd.drv %spi_mo, %168 after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 16 preds: ^bb0, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb22, ^bb24, ^bb26, ^bb28, ^bb30, ^bb31, ^bb32
      llhd.wait (%16, %13, %2, %10, %14 : i16, i1, i1, i4, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %100 = llhd.prb %spim_stop_end : i1
      %101 = llhd.prb %spim_start_end : i1
      %102 = comb.or %100, %101 : i1
      cf.cond_br %102, ^bb3, ^bb32
    ^bb3:  // pred: ^bb2
      %103 = llhd.prb %spi_data_size_8 : i4
      %104 = comb.icmp ceq %103, %c0_i4 : i4
      cf.cond_br %104, ^bb6, ^bb4
    ^bb4:  // pred: ^bb3
      %105 = comb.icmp ceq %103, %c1_i4 : i4
      cf.cond_br %105, ^bb6, ^bb5
    ^bb5:  // pred: ^bb4
      %106 = comb.icmp ceq %103, %c2_i4 : i4
      cf.cond_br %106, ^bb6, ^bb7
    ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
      %107 = llhd.prb %tx_rd_data_18 : i16
      %108 = comb.extract %107 from 7 : (i16) -> i1
      llhd.drv %spim_1st_bit, %108 after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %109 = comb.icmp ceq %103, %c3_i4 : i4
      cf.cond_br %109, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %110 = llhd.prb %tx_rd_data_18 : i16
      %111 = comb.extract %110 from 3 : (i16) -> i1
      llhd.drv %spim_1st_bit, %111 after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %112 = comb.icmp ceq %103, %c4_i4 : i4
      cf.cond_br %112, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %113 = llhd.prb %tx_rd_data_18 : i16
      %114 = comb.extract %113 from 4 : (i16) -> i1
      llhd.drv %spim_1st_bit, %114 after %0 : i1
      cf.br ^bb1
    ^bb11:  // pred: ^bb9
      %115 = comb.icmp ceq %103, %c5_i4 : i4
      cf.cond_br %115, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %116 = llhd.prb %tx_rd_data_18 : i16
      %117 = comb.extract %116 from 5 : (i16) -> i1
      llhd.drv %spim_1st_bit, %117 after %0 : i1
      cf.br ^bb1
    ^bb13:  // pred: ^bb11
      %118 = comb.icmp ceq %103, %c6_i4 : i4
      cf.cond_br %118, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %119 = llhd.prb %tx_rd_data_18 : i16
      %120 = comb.extract %119 from 6 : (i16) -> i1
      llhd.drv %spim_1st_bit, %120 after %0 : i1
      cf.br ^bb1
    ^bb15:  // pred: ^bb13
      %121 = comb.icmp ceq %103, %c7_i4 : i4
      cf.cond_br %121, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %122 = llhd.prb %tx_rd_data_18 : i16
      %123 = comb.extract %122 from 7 : (i16) -> i1
      llhd.drv %spim_1st_bit, %123 after %0 : i1
      cf.br ^bb1
    ^bb17:  // pred: ^bb15
      %124 = comb.icmp ceq %103, %c-8_i4 : i4
      cf.cond_br %124, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      %125 = llhd.prb %tx_rd_data_18 : i16
      %126 = comb.extract %125 from 8 : (i16) -> i1
      llhd.drv %spim_1st_bit, %126 after %0 : i1
      cf.br ^bb1
    ^bb19:  // pred: ^bb17
      %127 = comb.icmp ceq %103, %c-7_i4 : i4
      cf.cond_br %127, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %128 = llhd.prb %tx_rd_data_18 : i16
      %129 = comb.extract %128 from 9 : (i16) -> i1
      llhd.drv %spim_1st_bit, %129 after %0 : i1
      cf.br ^bb1
    ^bb21:  // pred: ^bb19
      %130 = comb.icmp ceq %103, %c-6_i4 : i4
      cf.cond_br %130, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      %131 = llhd.prb %tx_rd_data_18 : i16
      %132 = comb.extract %131 from 10 : (i16) -> i1
      llhd.drv %spim_1st_bit, %132 after %0 : i1
      cf.br ^bb1
    ^bb23:  // pred: ^bb21
      %133 = comb.icmp ceq %103, %c-5_i4 : i4
      cf.cond_br %133, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %134 = llhd.prb %tx_rd_data_18 : i16
      %135 = comb.extract %134 from 11 : (i16) -> i1
      llhd.drv %spim_1st_bit, %135 after %0 : i1
      cf.br ^bb1
    ^bb25:  // pred: ^bb23
      %136 = comb.icmp ceq %103, %c-4_i4 : i4
      cf.cond_br %136, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      %137 = llhd.prb %tx_rd_data_18 : i16
      %138 = comb.extract %137 from 12 : (i16) -> i1
      llhd.drv %spim_1st_bit, %138 after %0 : i1
      cf.br ^bb1
    ^bb27:  // pred: ^bb25
      %139 = comb.icmp ceq %103, %c-3_i4 : i4
      cf.cond_br %139, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      %140 = llhd.prb %tx_rd_data_18 : i16
      %141 = comb.extract %140 from 13 : (i16) -> i1
      llhd.drv %spim_1st_bit, %141 after %0 : i1
      cf.br ^bb1
    ^bb29:  // pred: ^bb27
      %142 = comb.icmp ceq %103, %c-2_i4 : i4
      cf.cond_br %142, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %143 = llhd.prb %tx_rd_data_18 : i16
      %144 = comb.extract %143 from 14 : (i16) -> i1
      llhd.drv %spim_1st_bit, %144 after %0 : i1
      cf.br ^bb1
    ^bb31:  // pred: ^bb29
      %145 = llhd.prb %tx_rd_data_18 : i16
      %146 = comb.extract %145 from 15 : (i16) -> i1
      llhd.drv %spim_1st_bit, %146 after %0 : i1
      cf.br ^bb1
    ^bb32:  // pred: ^bb2
      %147 = llhd.prb %spi_mo : i1
      llhd.drv %spim_1st_bit, %147 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 12 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb9, ^bb10, ^bb11, ^bb13, ^bb15, ^bb17, ^bb18, ^bb19
      %100 = llhd.prb %clk_0 : i1
      %101 = llhd.prb %rst_n_7 : i1
      llhd.wait (%4, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %102 = llhd.prb %clk_0 : i1
      %103 = comb.xor bin %100, %true : i1
      %104 = comb.and bin %103, %102 : i1
      %105 = llhd.prb %rst_n_7 : i1
      %106 = comb.xor bin %105, %true : i1
      %107 = comb.and bin %101, %106 : i1
      %108 = comb.or bin %104, %107 : i1
      cf.cond_br %108, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %109 = llhd.prb %rst_n_7 : i1
      %110 = comb.xor %109, %true : i1
      cf.cond_br %110, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %spim_sck, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %111 = llhd.prb %spim_en_15 : i1
      %112 = comb.xor %111, %true : i1
      cf.cond_br %112, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %113 = llhd.prb %cpol_2 : i1
      llhd.drv %spim_sck, %113 after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %114 = llhd.prb %cpha_1 : i1
      %115 = comb.xor %114, %true : i1
      cf.cond_br %115, ^bb8, ^bb12
    ^bb8:  // pred: ^bb7
      %116 = llhd.prb %spim_idle : i1
      %117 = llhd.prb %spim_start : i1
      %118 = llhd.prb %spim_stop : i1
      %119 = comb.or %116, %117, %118 : i1
      cf.cond_br %119, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %120 = llhd.prb %cpol_2 : i1
      llhd.drv %spim_sck, %120 after %1 : i1
      cf.br ^bb1
    ^bb10:  // pred: ^bb8
      %121 = llhd.prb %spim_data : i1
      %122 = llhd.prb %txcnt_div_eq : i1
      %123 = comb.and %121, %122 : i1
      cf.cond_br %123, ^bb11, ^bb1
    ^bb11:  // pred: ^bb10
      %124 = llhd.prb %spim_sck : i1
      %125 = comb.xor %124, %true : i1
      llhd.drv %spim_sck, %125 after %1 : i1
      cf.br ^bb1
    ^bb12:  // pred: ^bb7
      %126 = llhd.prb %spim_idle : i1
      %127 = llhd.prb %spim_stop : i1
      %128 = comb.or %126, %127 : i1
      cf.cond_br %128, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      %129 = llhd.prb %cpol_2 : i1
      llhd.drv %spim_sck, %129 after %1 : i1
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      %130 = llhd.prb %spim_start_end : i1
      cf.cond_br %130, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      %131 = llhd.prb %spim_sck : i1
      %132 = comb.xor %131, %true : i1
      llhd.drv %spim_sck, %132 after %1 : i1
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      %133 = llhd.prb %spim_data_end : i1
      %134 = llhd.prb %spim_start : i1
      %135 = comb.or %133, %134 : i1
      cf.cond_br %135, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      %136 = llhd.prb %cpol_2 : i1
      llhd.drv %spim_sck, %136 after %1 : i1
      cf.br ^bb1
    ^bb18:  // pred: ^bb16
      %137 = llhd.prb %spim_data : i1
      %138 = llhd.prb %txcnt_div_eq : i1
      %139 = comb.and %137, %138 : i1
      cf.cond_br %139, ^bb19, ^bb1
    ^bb19:  // pred: ^bb18
      %140 = llhd.prb %spim_sck : i1
      %141 = comb.xor %140, %true : i1
      llhd.drv %spim_sck, %141 after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 20 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb7, ^bb9, ^bb11, ^bb13, ^bb15, ^bb17, ^bb19, ^bb21, ^bb23, ^bb25, ^bb27, ^bb29, ^bb31, ^bb33, ^bb35, ^bb36
      %100 = llhd.prb %clk_0 : i1
      %101 = llhd.prb %rst_n_7 : i1
      llhd.wait (%4, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %102 = llhd.prb %clk_0 : i1
      %103 = comb.xor bin %100, %true : i1
      %104 = comb.and bin %103, %102 : i1
      %105 = llhd.prb %rst_n_7 : i1
      %106 = comb.xor bin %105, %true : i1
      %107 = comb.and bin %101, %106 : i1
      %108 = comb.or bin %104, %107 : i1
      cf.cond_br %108, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %109 = llhd.prb %rst_n_7 : i1
      %110 = comb.xor %109, %true : i1
      cf.cond_br %110, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %spim_rx, %c0_i16 after %1 : i16
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %111 = llhd.prb %spi_rx_en_11 : i1
      %112 = llhd.prb %spim_data : i1
      %113 = llhd.prb %data_smp : i1
      %114 = comb.and %111, %112, %113 : i1
      cf.cond_br %114, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %115 = llhd.prb %txcnt_bits : i5
      %116 = comb.extract %115 from 1 : (i5) -> i4
      %117 = comb.icmp ceq %116, %c0_i4 : i4
      cf.cond_br %117, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %118 = llhd.sig.extract %spim_rx from %c0_i4 : <i16> -> <i1>
      %119 = llhd.prb %spi_mi_10 : i1
      llhd.drv %118, %119 after %1 : i1
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %120 = comb.icmp ceq %116, %c1_i4 : i4
      cf.cond_br %120, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %121 = llhd.sig.extract %spim_rx from %c1_i4 : <i16> -> <i1>
      %122 = llhd.prb %spi_mi_10 : i1
      llhd.drv %121, %122 after %1 : i1
      cf.br ^bb1
    ^bb10:  // pred: ^bb8
      %123 = comb.icmp ceq %116, %c2_i4 : i4
      cf.cond_br %123, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %124 = llhd.sig.extract %spim_rx from %c2_i4 : <i16> -> <i1>
      %125 = llhd.prb %spi_mi_10 : i1
      llhd.drv %124, %125 after %1 : i1
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      %126 = comb.icmp ceq %116, %c3_i4 : i4
      cf.cond_br %126, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      %127 = llhd.sig.extract %spim_rx from %c3_i4 : <i16> -> <i1>
      %128 = llhd.prb %spi_mi_10 : i1
      llhd.drv %127, %128 after %1 : i1
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      %129 = comb.icmp ceq %116, %c4_i4 : i4
      cf.cond_br %129, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      %130 = llhd.sig.extract %spim_rx from %c4_i4 : <i16> -> <i1>
      %131 = llhd.prb %spi_mi_10 : i1
      llhd.drv %130, %131 after %1 : i1
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      %132 = comb.icmp ceq %116, %c5_i4 : i4
      cf.cond_br %132, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      %133 = llhd.sig.extract %spim_rx from %c5_i4 : <i16> -> <i1>
      %134 = llhd.prb %spi_mi_10 : i1
      llhd.drv %133, %134 after %1 : i1
      cf.br ^bb1
    ^bb18:  // pred: ^bb16
      %135 = comb.icmp ceq %116, %c6_i4 : i4
      cf.cond_br %135, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %136 = llhd.sig.extract %spim_rx from %c6_i4 : <i16> -> <i1>
      %137 = llhd.prb %spi_mi_10 : i1
      llhd.drv %136, %137 after %1 : i1
      cf.br ^bb1
    ^bb20:  // pred: ^bb18
      %138 = comb.icmp ceq %116, %c7_i4 : i4
      cf.cond_br %138, ^bb21, ^bb22
    ^bb21:  // pred: ^bb20
      %139 = llhd.sig.extract %spim_rx from %c7_i4 : <i16> -> <i1>
      %140 = llhd.prb %spi_mi_10 : i1
      llhd.drv %139, %140 after %1 : i1
      cf.br ^bb1
    ^bb22:  // pred: ^bb20
      %141 = comb.icmp ceq %116, %c-8_i4 : i4
      cf.cond_br %141, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      %142 = llhd.sig.extract %spim_rx from %c-8_i4 : <i16> -> <i1>
      %143 = llhd.prb %spi_mi_10 : i1
      llhd.drv %142, %143 after %1 : i1
      cf.br ^bb1
    ^bb24:  // pred: ^bb22
      %144 = comb.icmp ceq %116, %c-7_i4 : i4
      cf.cond_br %144, ^bb25, ^bb26
    ^bb25:  // pred: ^bb24
      %145 = llhd.sig.extract %spim_rx from %c-7_i4 : <i16> -> <i1>
      %146 = llhd.prb %spi_mi_10 : i1
      llhd.drv %145, %146 after %1 : i1
      cf.br ^bb1
    ^bb26:  // pred: ^bb24
      %147 = comb.icmp ceq %116, %c-6_i4 : i4
      cf.cond_br %147, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      %148 = llhd.sig.extract %spim_rx from %c-6_i4 : <i16> -> <i1>
      %149 = llhd.prb %spi_mi_10 : i1
      llhd.drv %148, %149 after %1 : i1
      cf.br ^bb1
    ^bb28:  // pred: ^bb26
      %150 = comb.icmp ceq %116, %c-5_i4 : i4
      cf.cond_br %150, ^bb29, ^bb30
    ^bb29:  // pred: ^bb28
      %151 = llhd.sig.extract %spim_rx from %c-5_i4 : <i16> -> <i1>
      %152 = llhd.prb %spi_mi_10 : i1
      llhd.drv %151, %152 after %1 : i1
      cf.br ^bb1
    ^bb30:  // pred: ^bb28
      %153 = comb.icmp ceq %116, %c-4_i4 : i4
      cf.cond_br %153, ^bb31, ^bb32
    ^bb31:  // pred: ^bb30
      %154 = llhd.sig.extract %spim_rx from %c-4_i4 : <i16> -> <i1>
      %155 = llhd.prb %spi_mi_10 : i1
      llhd.drv %154, %155 after %1 : i1
      cf.br ^bb1
    ^bb32:  // pred: ^bb30
      %156 = comb.icmp ceq %116, %c-3_i4 : i4
      cf.cond_br %156, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      %157 = llhd.sig.extract %spim_rx from %c-3_i4 : <i16> -> <i1>
      %158 = llhd.prb %spi_mi_10 : i1
      llhd.drv %157, %158 after %1 : i1
      cf.br ^bb1
    ^bb34:  // pred: ^bb32
      %159 = comb.icmp ceq %116, %c-2_i4 : i4
      cf.cond_br %159, ^bb35, ^bb36
    ^bb35:  // pred: ^bb34
      %160 = llhd.sig.extract %spim_rx from %c-2_i4 : <i16> -> <i1>
      %161 = llhd.prb %spi_mi_10 : i1
      llhd.drv %160, %161 after %1 : i1
      cf.br ^bb1
    ^bb36:  // pred: ^bb34
      %162 = llhd.sig.extract %spim_rx from %c-1_i4 : <i16> -> <i1>
      %163 = llhd.prb %spi_mi_10 : i1
      llhd.drv %162, %163 after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %100 = llhd.prb %clk_0 : i1
      %101 = llhd.prb %rst_n_7 : i1
      llhd.wait (%4, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %102 = llhd.prb %clk_0 : i1
      %103 = comb.xor bin %100, %true : i1
      %104 = comb.and bin %103, %102 : i1
      %105 = llhd.prb %rst_n_7 : i1
      %106 = comb.xor bin %105, %true : i1
      %107 = comb.and bin %101, %106 : i1
      %108 = comb.or bin %104, %107 : i1
      cf.cond_br %108, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %109 = llhd.prb %rst_n_7 : i1
      %110 = comb.xor %109, %true : i1
      cf.cond_br %110, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %stop_cnt, %c0_i2 after %1 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %111 = llhd.prb %spim_stop_end : i1
      cf.cond_br %111, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %stop_cnt, %c0_i2 after %1 : i2
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %112 = llhd.prb %txcnt_div_eq : i1
      %113 = llhd.prb %spim_stop : i1
      %114 = comb.and %112, %113 : i1
      cf.cond_br %114, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %115 = llhd.prb %stop_cnt : i2
      %116 = comb.add %115, %c1_i2 : i2
      llhd.drv %stop_cnt, %116 after %1 : i2
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %100 = llhd.prb %clk_0 : i1
      %101 = llhd.prb %rst_n_7 : i1
      llhd.wait (%4, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %102 = llhd.prb %clk_0 : i1
      %103 = comb.xor bin %100, %true : i1
      %104 = comb.and bin %103, %102 : i1
      %105 = llhd.prb %rst_n_7 : i1
      %106 = comb.xor bin %105, %true : i1
      %107 = comb.and bin %101, %106 : i1
      %108 = comb.or bin %104, %107 : i1
      cf.cond_br %108, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %109 = llhd.prb %rst_n_7 : i1
      %110 = comb.xor %109, %true : i1
      cf.cond_br %110, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %spim_nss, %true after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %111 = llhd.prb %spim_nss_clr : i1
      cf.cond_br %111, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %spim_nss, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %112 = llhd.prb %spim_nss_set : i1
      cf.cond_br %112, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %spim_nss, %true after %1 : i1
      cf.br ^bb1
    }
    %54 = comb.xor %15, %true : i1
    %55 = comb.and %nss_toggle, %14, %54 : i1
    %56 = comb.or %12, %55 : i1
    llhd.drv %spim_nss_clr, %56 after %0 : i1
    %57 = comb.and %14, %15 : i1
    %58 = comb.mux %nss_toggle, %38, %57 : i1
    %59 = comb.or %17, %58 : i1
    llhd.drv %spim_nss_set, %59 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %100 = llhd.prb %clk_0 : i1
      %101 = llhd.prb %rst_n_7 : i1
      llhd.wait (%4, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %102 = llhd.prb %clk_0 : i1
      %103 = comb.xor bin %100, %true : i1
      %104 = comb.and bin %103, %102 : i1
      %105 = llhd.prb %rst_n_7 : i1
      %106 = comb.xor bin %105, %true : i1
      %107 = comb.and bin %101, %106 : i1
      %108 = comb.or bin %104, %107 : i1
      cf.cond_br %108, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %109 = llhd.prb %rst_n_7 : i1
      %110 = comb.xor %109, %true : i1
      cf.cond_br %110, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cnt_bits, %c0_i4 after %1 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %111 = llhd.prb %spis_en_16 : i1
      %112 = comb.xor %111, %true : i1
      %113 = llhd.prb %i_nss_in_5 : i1
      %114 = comb.or %112, %113 : i1
      cf.cond_br %114, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %cnt_bits, %c0_i4 after %1 : i4
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %115 = llhd.prb %spis_cnt_load : i1
      cf.cond_br %115, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %116 = llhd.prb %spi_data_size_8 : i4
      llhd.drv %cnt_bits, %116 after %1 : i4
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %117 = llhd.prb %data_chg : i1
      %118 = llhd.prb %i_nss_in_5 : i1
      %119 = comb.xor %118, %true : i1
      %120 = comb.and %117, %119 : i1
      cf.cond_br %120, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %121 = llhd.prb %cnt_bits : i4
      %122 = comb.add %121, %c-1_i4 : i4
      llhd.drv %cnt_bits, %122 after %1 : i4
      cf.br ^bb1
    }
    %60 = llhd.prb %cnt_bits : i4
    %61 = comb.icmp eq %60, %c0_i4 : i4
    %62 = llhd.prb %data_chg : i1
    %63 = llhd.prb %i_nss_in_5 : i1
    %64 = comb.xor %63, %true : i1
    %65 = comb.and %61, %62, %64 : i1
    %66 = llhd.prb %f_nss_d : i1
    %67 = comb.xor %5, %true : i1
    %68 = comb.and %67, %66 : i1
    %69 = comb.or %68, %65 : i1
    llhd.drv %spis_cnt_load, %69 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %100 = llhd.prb %clk_0 : i1
      %101 = llhd.prb %rst_n_7 : i1
      llhd.wait (%4, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %102 = llhd.prb %clk_0 : i1
      %103 = comb.xor bin %100, %true : i1
      %104 = comb.and bin %103, %102 : i1
      %105 = llhd.prb %rst_n_7 : i1
      %106 = comb.xor bin %105, %true : i1
      %107 = comb.and bin %101, %106 : i1
      %108 = comb.or bin %104, %107 : i1
      cf.cond_br %108, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %109 = llhd.prb %rst_n_7 : i1
      %110 = comb.xor %109, %true : i1
      cf.cond_br %110, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %f_nss_d, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %111 = llhd.prb %f_nss_3 : i1
      llhd.drv %f_nss_d, %111 after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 21 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb9, ^bb11, ^bb13, ^bb15, ^bb17, ^bb19, ^bb21, ^bb23, ^bb25, ^bb27, ^bb29, ^bb31, ^bb33, ^bb35, ^bb37, ^bb38
      %100 = llhd.prb %clk_0 : i1
      %101 = llhd.prb %rst_n_7 : i1
      llhd.wait (%4, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %102 = llhd.prb %clk_0 : i1
      %103 = comb.xor bin %100, %true : i1
      %104 = comb.and bin %103, %102 : i1
      %105 = llhd.prb %rst_n_7 : i1
      %106 = comb.xor bin %105, %true : i1
      %107 = comb.and bin %101, %106 : i1
      %108 = comb.or bin %104, %107 : i1
      cf.cond_br %108, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %109 = llhd.prb %rst_n_7 : i1
      %110 = comb.xor %109, %true : i1
      cf.cond_br %110, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %spis_rx, %c0_i16 after %1 : i16
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %111 = llhd.prb %spis_en_16 : i1
      %112 = comb.xor %111, %true : i1
      cf.cond_br %112, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %spis_rx, %c0_i16 after %1 : i16
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %113 = llhd.prb %data_smp : i1
      %114 = llhd.prb %spi_rx_en_11 : i1
      %115 = comb.and %113, %114 : i1
      cf.cond_br %115, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %116 = llhd.prb %cnt_bits : i4
      %117 = comb.icmp ceq %116, %c0_i4 : i4
      cf.cond_br %117, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %118 = llhd.sig.extract %spis_rx from %c0_i4 : <i16> -> <i1>
      %119 = llhd.prb %spi_si_12 : i1
      llhd.drv %118, %119 after %1 : i1
      cf.br ^bb1
    ^bb10:  // pred: ^bb8
      %120 = comb.icmp ceq %116, %c1_i4 : i4
      cf.cond_br %120, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %121 = llhd.sig.extract %spis_rx from %c1_i4 : <i16> -> <i1>
      %122 = llhd.prb %spi_si_12 : i1
      llhd.drv %121, %122 after %1 : i1
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      %123 = comb.icmp ceq %116, %c2_i4 : i4
      cf.cond_br %123, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      %124 = llhd.sig.extract %spis_rx from %c2_i4 : <i16> -> <i1>
      %125 = llhd.prb %spi_si_12 : i1
      llhd.drv %124, %125 after %1 : i1
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      %126 = comb.icmp ceq %116, %c3_i4 : i4
      cf.cond_br %126, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      %127 = llhd.sig.extract %spis_rx from %c3_i4 : <i16> -> <i1>
      %128 = llhd.prb %spi_si_12 : i1
      llhd.drv %127, %128 after %1 : i1
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      %129 = comb.icmp ceq %116, %c4_i4 : i4
      cf.cond_br %129, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      %130 = llhd.sig.extract %spis_rx from %c4_i4 : <i16> -> <i1>
      %131 = llhd.prb %spi_si_12 : i1
      llhd.drv %130, %131 after %1 : i1
      cf.br ^bb1
    ^bb18:  // pred: ^bb16
      %132 = comb.icmp ceq %116, %c5_i4 : i4
      cf.cond_br %132, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %133 = llhd.sig.extract %spis_rx from %c5_i4 : <i16> -> <i1>
      %134 = llhd.prb %spi_si_12 : i1
      llhd.drv %133, %134 after %1 : i1
      cf.br ^bb1
    ^bb20:  // pred: ^bb18
      %135 = comb.icmp ceq %116, %c6_i4 : i4
      cf.cond_br %135, ^bb21, ^bb22
    ^bb21:  // pred: ^bb20
      %136 = llhd.sig.extract %spis_rx from %c6_i4 : <i16> -> <i1>
      %137 = llhd.prb %spi_si_12 : i1
      llhd.drv %136, %137 after %1 : i1
      cf.br ^bb1
    ^bb22:  // pred: ^bb20
      %138 = comb.icmp ceq %116, %c7_i4 : i4
      cf.cond_br %138, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      %139 = llhd.sig.extract %spis_rx from %c7_i4 : <i16> -> <i1>
      %140 = llhd.prb %spi_si_12 : i1
      llhd.drv %139, %140 after %1 : i1
      cf.br ^bb1
    ^bb24:  // pred: ^bb22
      %141 = comb.icmp ceq %116, %c-8_i4 : i4
      cf.cond_br %141, ^bb25, ^bb26
    ^bb25:  // pred: ^bb24
      %142 = llhd.sig.extract %spis_rx from %c-8_i4 : <i16> -> <i1>
      %143 = llhd.prb %spi_si_12 : i1
      llhd.drv %142, %143 after %1 : i1
      cf.br ^bb1
    ^bb26:  // pred: ^bb24
      %144 = comb.icmp ceq %116, %c-7_i4 : i4
      cf.cond_br %144, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      %145 = llhd.sig.extract %spis_rx from %c-7_i4 : <i16> -> <i1>
      %146 = llhd.prb %spi_si_12 : i1
      llhd.drv %145, %146 after %1 : i1
      cf.br ^bb1
    ^bb28:  // pred: ^bb26
      %147 = comb.icmp ceq %116, %c-6_i4 : i4
      cf.cond_br %147, ^bb29, ^bb30
    ^bb29:  // pred: ^bb28
      %148 = llhd.sig.extract %spis_rx from %c-6_i4 : <i16> -> <i1>
      %149 = llhd.prb %spi_si_12 : i1
      llhd.drv %148, %149 after %1 : i1
      cf.br ^bb1
    ^bb30:  // pred: ^bb28
      %150 = comb.icmp ceq %116, %c-5_i4 : i4
      cf.cond_br %150, ^bb31, ^bb32
    ^bb31:  // pred: ^bb30
      %151 = llhd.sig.extract %spis_rx from %c-5_i4 : <i16> -> <i1>
      %152 = llhd.prb %spi_si_12 : i1
      llhd.drv %151, %152 after %1 : i1
      cf.br ^bb1
    ^bb32:  // pred: ^bb30
      %153 = comb.icmp ceq %116, %c-4_i4 : i4
      cf.cond_br %153, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      %154 = llhd.sig.extract %spis_rx from %c-4_i4 : <i16> -> <i1>
      %155 = llhd.prb %spi_si_12 : i1
      llhd.drv %154, %155 after %1 : i1
      cf.br ^bb1
    ^bb34:  // pred: ^bb32
      %156 = comb.icmp ceq %116, %c-3_i4 : i4
      cf.cond_br %156, ^bb35, ^bb36
    ^bb35:  // pred: ^bb34
      %157 = llhd.sig.extract %spis_rx from %c-3_i4 : <i16> -> <i1>
      %158 = llhd.prb %spi_si_12 : i1
      llhd.drv %157, %158 after %1 : i1
      cf.br ^bb1
    ^bb36:  // pred: ^bb34
      %159 = comb.icmp ceq %116, %c-2_i4 : i4
      cf.cond_br %159, ^bb37, ^bb38
    ^bb37:  // pred: ^bb36
      %160 = llhd.sig.extract %spis_rx from %c-2_i4 : <i16> -> <i1>
      %161 = llhd.prb %spi_si_12 : i1
      llhd.drv %160, %161 after %1 : i1
      cf.br ^bb1
    ^bb38:  // pred: ^bb36
      %162 = llhd.sig.extract %spis_rx from %c-1_i4 : <i16> -> <i1>
      %163 = llhd.prb %spi_si_12 : i1
      llhd.drv %162, %163 after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 3 preds: ^bb0, ^bb3, ^bb4
      llhd.wait (%5, %7, %8, %6 : i1, i1, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %100 = llhd.prb %cpha_1 : i1
      cf.cond_br %100, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %101 = llhd.prb %cpol_2 : i1
      %102 = llhd.prb %r_sclk_6 : i1
      %103 = llhd.prb %f_sclk_4 : i1
      %104 = comb.mux %101, %102, %103 : i1
      llhd.drv %data_smp, %104 after %0 : i1
      %105 = llhd.prb %cpol_2 : i1
      %106 = llhd.prb %f_sclk_4 : i1
      %107 = llhd.prb %r_sclk_6 : i1
      %108 = comb.mux %105, %106, %107 : i1
      llhd.drv %data_chg, %108 after %0 : i1
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      %109 = llhd.prb %cpol_2 : i1
      %110 = llhd.prb %f_sclk_4 : i1
      %111 = llhd.prb %r_sclk_6 : i1
      %112 = comb.mux %109, %110, %111 : i1
      llhd.drv %data_smp, %112 after %0 : i1
      %113 = llhd.prb %cpol_2 : i1
      %114 = llhd.prb %r_sclk_6 : i1
      %115 = llhd.prb %f_sclk_4 : i1
      %116 = comb.mux %113, %114, %115 : i1
      llhd.drv %data_chg, %116 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %100 = llhd.prb %clk_0 : i1
      %101 = llhd.prb %rst_n_7 : i1
      llhd.wait (%4, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %102 = llhd.prb %clk_0 : i1
      %103 = comb.xor bin %100, %true : i1
      %104 = comb.and bin %103, %102 : i1
      %105 = llhd.prb %rst_n_7 : i1
      %106 = comb.xor bin %105, %true : i1
      %107 = comb.and bin %101, %106 : i1
      %108 = comb.or bin %104, %107 : i1
      cf.cond_br %108, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %109 = llhd.prb %rst_n_7 : i1
      %110 = comb.xor %109, %true : i1
      cf.cond_br %110, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cnt_bits0_d, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %111 = llhd.prb %cnt_bits : i4
      %112 = comb.icmp eq %111, %c1_i4 : i4
      llhd.drv %cnt_bits0_d, %112 after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %100 = llhd.prb %clk_0 : i1
      %101 = llhd.prb %rst_n_7 : i1
      llhd.wait (%4, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %102 = llhd.prb %clk_0 : i1
      %103 = comb.xor bin %100, %true : i1
      %104 = comb.and bin %103, %102 : i1
      %105 = llhd.prb %rst_n_7 : i1
      %106 = comb.xor bin %105, %true : i1
      %107 = comb.and bin %101, %106 : i1
      %108 = comb.or bin %104, %107 : i1
      cf.cond_br %108, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %109 = llhd.prb %rst_n_7 : i1
      %110 = comb.xor %109, %true : i1
      cf.cond_br %110, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %spis_rx_en, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %111 = llhd.prb %spis_rx_wen : i1
      cf.cond_br %111, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %spis_rx_en, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %112 = llhd.prb %cnt_bits : i4
      %113 = comb.icmp eq %112, %c0_i4 : i4
      %114 = llhd.prb %cnt_bits0_d : i1
      %115 = comb.and %113, %114 : i1
      cf.cond_br %115, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %spis_rx_en, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %100 = llhd.prb %clk_0 : i1
      %101 = llhd.prb %rst_n_7 : i1
      llhd.wait (%4, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %102 = llhd.prb %clk_0 : i1
      %103 = comb.xor bin %100, %true : i1
      %104 = comb.and bin %103, %102 : i1
      %105 = llhd.prb %rst_n_7 : i1
      %106 = comb.xor bin %105, %true : i1
      %107 = comb.and bin %101, %106 : i1
      %108 = comb.or bin %104, %107 : i1
      cf.cond_br %108, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %109 = llhd.prb %rst_n_7 : i1
      %110 = comb.xor %109, %true : i1
      cf.cond_br %110, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %spis_rx_wen, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %111 = llhd.prb %spis_rx_en : i1
      %112 = llhd.prb %data_smp : i1
      %113 = llhd.prb %spi_rx_en_11 : i1
      %114 = llhd.prb %spis_en_16 : i1
      %115 = comb.and %111, %112, %113, %114 : i1
      cf.cond_br %115, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %spis_rx_wen, %true after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      llhd.drv %spis_rx_wen, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 21 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb9, ^bb11, ^bb13, ^bb15, ^bb17, ^bb19, ^bb21, ^bb23, ^bb25, ^bb27, ^bb29, ^bb31, ^bb33, ^bb35, ^bb37, ^bb38
      %100 = llhd.prb %clk_0 : i1
      %101 = llhd.prb %rst_n_7 : i1
      llhd.wait (%4, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %102 = llhd.prb %clk_0 : i1
      %103 = comb.xor bin %100, %true : i1
      %104 = comb.and bin %103, %102 : i1
      %105 = llhd.prb %rst_n_7 : i1
      %106 = comb.xor bin %105, %true : i1
      %107 = comb.and bin %101, %106 : i1
      %108 = comb.or bin %104, %107 : i1
      cf.cond_br %108, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %109 = llhd.prb %rst_n_7 : i1
      %110 = comb.xor %109, %true : i1
      cf.cond_br %110, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %spi_so, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %111 = llhd.prb %f_nss_d : i1
      cf.cond_br %111, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %112 = llhd.prb %spis_1st_bit : i1
      llhd.drv %spi_so, %112 after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %113 = llhd.prb %spis_cnt_load : i1
      %114 = llhd.prb %i_nss_in_5 : i1
      %115 = comb.xor %114, %true : i1
      %116 = llhd.prb %data_chg : i1
      %117 = comb.and %115, %116 : i1
      %118 = comb.or %113, %117 : i1
      %119 = llhd.prb %spi_tx_en_14 : i1
      %120 = llhd.prb %tx_empty_17 : i1
      %121 = comb.xor %120, %true : i1
      %122 = comb.and %118, %119, %121 : i1
      cf.cond_br %122, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %123 = llhd.prb %cnt_bits : i4
      %124 = comb.icmp ceq %123, %c0_i4 : i4
      cf.cond_br %124, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %125 = llhd.prb %spis_1st_bit : i1
      llhd.drv %spi_so, %125 after %1 : i1
      cf.br ^bb1
    ^bb10:  // pred: ^bb8
      %126 = comb.icmp ceq %123, %c1_i4 : i4
      cf.cond_br %126, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %127 = llhd.prb %tx_rd_data_18 : i16
      %128 = comb.extract %127 from 0 : (i16) -> i1
      llhd.drv %spi_so, %128 after %1 : i1
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      %129 = comb.icmp ceq %123, %c2_i4 : i4
      cf.cond_br %129, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      %130 = llhd.prb %tx_rd_data_18 : i16
      %131 = comb.extract %130 from 1 : (i16) -> i1
      llhd.drv %spi_so, %131 after %1 : i1
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      %132 = comb.icmp ceq %123, %c3_i4 : i4
      cf.cond_br %132, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      %133 = llhd.prb %tx_rd_data_18 : i16
      %134 = comb.extract %133 from 2 : (i16) -> i1
      llhd.drv %spi_so, %134 after %1 : i1
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      %135 = comb.icmp ceq %123, %c4_i4 : i4
      cf.cond_br %135, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      %136 = llhd.prb %tx_rd_data_18 : i16
      %137 = comb.extract %136 from 3 : (i16) -> i1
      llhd.drv %spi_so, %137 after %1 : i1
      cf.br ^bb1
    ^bb18:  // pred: ^bb16
      %138 = comb.icmp ceq %123, %c5_i4 : i4
      cf.cond_br %138, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %139 = llhd.prb %tx_rd_data_18 : i16
      %140 = comb.extract %139 from 4 : (i16) -> i1
      llhd.drv %spi_so, %140 after %1 : i1
      cf.br ^bb1
    ^bb20:  // pred: ^bb18
      %141 = comb.icmp ceq %123, %c6_i4 : i4
      cf.cond_br %141, ^bb21, ^bb22
    ^bb21:  // pred: ^bb20
      %142 = llhd.prb %tx_rd_data_18 : i16
      %143 = comb.extract %142 from 5 : (i16) -> i1
      llhd.drv %spi_so, %143 after %1 : i1
      cf.br ^bb1
    ^bb22:  // pred: ^bb20
      %144 = comb.icmp ceq %123, %c7_i4 : i4
      cf.cond_br %144, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      %145 = llhd.prb %tx_rd_data_18 : i16
      %146 = comb.extract %145 from 6 : (i16) -> i1
      llhd.drv %spi_so, %146 after %1 : i1
      cf.br ^bb1
    ^bb24:  // pred: ^bb22
      %147 = comb.icmp ceq %123, %c-8_i4 : i4
      cf.cond_br %147, ^bb25, ^bb26
    ^bb25:  // pred: ^bb24
      %148 = llhd.prb %tx_rd_data_18 : i16
      %149 = comb.extract %148 from 7 : (i16) -> i1
      llhd.drv %spi_so, %149 after %1 : i1
      cf.br ^bb1
    ^bb26:  // pred: ^bb24
      %150 = comb.icmp ceq %123, %c-7_i4 : i4
      cf.cond_br %150, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      %151 = llhd.prb %tx_rd_data_18 : i16
      %152 = comb.extract %151 from 8 : (i16) -> i1
      llhd.drv %spi_so, %152 after %1 : i1
      cf.br ^bb1
    ^bb28:  // pred: ^bb26
      %153 = comb.icmp ceq %123, %c-6_i4 : i4
      cf.cond_br %153, ^bb29, ^bb30
    ^bb29:  // pred: ^bb28
      %154 = llhd.prb %tx_rd_data_18 : i16
      %155 = comb.extract %154 from 9 : (i16) -> i1
      llhd.drv %spi_so, %155 after %1 : i1
      cf.br ^bb1
    ^bb30:  // pred: ^bb28
      %156 = comb.icmp ceq %123, %c-5_i4 : i4
      cf.cond_br %156, ^bb31, ^bb32
    ^bb31:  // pred: ^bb30
      %157 = llhd.prb %tx_rd_data_18 : i16
      %158 = comb.extract %157 from 10 : (i16) -> i1
      llhd.drv %spi_so, %158 after %1 : i1
      cf.br ^bb1
    ^bb32:  // pred: ^bb30
      %159 = comb.icmp ceq %123, %c-4_i4 : i4
      cf.cond_br %159, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      %160 = llhd.prb %tx_rd_data_18 : i16
      %161 = comb.extract %160 from 11 : (i16) -> i1
      llhd.drv %spi_so, %161 after %1 : i1
      cf.br ^bb1
    ^bb34:  // pred: ^bb32
      %162 = comb.icmp ceq %123, %c-3_i4 : i4
      cf.cond_br %162, ^bb35, ^bb36
    ^bb35:  // pred: ^bb34
      %163 = llhd.prb %tx_rd_data_18 : i16
      %164 = comb.extract %163 from 12 : (i16) -> i1
      llhd.drv %spi_so, %164 after %1 : i1
      cf.br ^bb1
    ^bb36:  // pred: ^bb34
      %165 = comb.icmp ceq %123, %c-2_i4 : i4
      cf.cond_br %165, ^bb37, ^bb38
    ^bb37:  // pred: ^bb36
      %166 = llhd.prb %tx_rd_data_18 : i16
      %167 = comb.extract %166 from 13 : (i16) -> i1
      llhd.drv %spi_so, %167 after %1 : i1
      cf.br ^bb1
    ^bb38:  // pred: ^bb36
      %168 = llhd.prb %tx_rd_data_18 : i16
      %169 = comb.extract %168 from 14 : (i16) -> i1
      llhd.drv %spi_so, %169 after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 15 preds: ^bb0, ^bb5, ^bb7, ^bb9, ^bb11, ^bb13, ^bb15, ^bb17, ^bb19, ^bb21, ^bb23, ^bb25, ^bb27, ^bb29, ^bb30
      llhd.wait (%16, %10 : i16, i4), ^bb2
    ^bb2:  // pred: ^bb1
      %100 = llhd.prb %spi_data_size_8 : i4
      %101 = comb.icmp ceq %100, %c0_i4 : i4
      cf.cond_br %101, ^bb5, ^bb3
    ^bb3:  // pred: ^bb2
      %102 = comb.icmp ceq %100, %c1_i4 : i4
      cf.cond_br %102, ^bb5, ^bb4
    ^bb4:  // pred: ^bb3
      %103 = comb.icmp ceq %100, %c2_i4 : i4
      cf.cond_br %103, ^bb5, ^bb6
    ^bb5:  // 3 preds: ^bb2, ^bb3, ^bb4
      %104 = llhd.prb %tx_rd_data_18 : i16
      %105 = comb.extract %104 from 7 : (i16) -> i1
      llhd.drv %spis_1st_bit, %105 after %0 : i1
      cf.br ^bb1
    ^bb6:  // pred: ^bb4
      %106 = comb.icmp ceq %100, %c3_i4 : i4
      cf.cond_br %106, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %107 = llhd.prb %tx_rd_data_18 : i16
      %108 = comb.extract %107 from 3 : (i16) -> i1
      llhd.drv %spis_1st_bit, %108 after %0 : i1
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %109 = comb.icmp ceq %100, %c4_i4 : i4
      cf.cond_br %109, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %110 = llhd.prb %tx_rd_data_18 : i16
      %111 = comb.extract %110 from 4 : (i16) -> i1
      llhd.drv %spis_1st_bit, %111 after %0 : i1
      cf.br ^bb1
    ^bb10:  // pred: ^bb8
      %112 = comb.icmp ceq %100, %c5_i4 : i4
      cf.cond_br %112, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %113 = llhd.prb %tx_rd_data_18 : i16
      %114 = comb.extract %113 from 5 : (i16) -> i1
      llhd.drv %spis_1st_bit, %114 after %0 : i1
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      %115 = comb.icmp ceq %100, %c6_i4 : i4
      cf.cond_br %115, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      %116 = llhd.prb %tx_rd_data_18 : i16
      %117 = comb.extract %116 from 6 : (i16) -> i1
      llhd.drv %spis_1st_bit, %117 after %0 : i1
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      %118 = comb.icmp ceq %100, %c7_i4 : i4
      cf.cond_br %118, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      %119 = llhd.prb %tx_rd_data_18 : i16
      %120 = comb.extract %119 from 7 : (i16) -> i1
      llhd.drv %spis_1st_bit, %120 after %0 : i1
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      %121 = comb.icmp ceq %100, %c-8_i4 : i4
      cf.cond_br %121, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      %122 = llhd.prb %tx_rd_data_18 : i16
      %123 = comb.extract %122 from 8 : (i16) -> i1
      llhd.drv %spis_1st_bit, %123 after %0 : i1
      cf.br ^bb1
    ^bb18:  // pred: ^bb16
      %124 = comb.icmp ceq %100, %c-7_i4 : i4
      cf.cond_br %124, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %125 = llhd.prb %tx_rd_data_18 : i16
      %126 = comb.extract %125 from 9 : (i16) -> i1
      llhd.drv %spis_1st_bit, %126 after %0 : i1
      cf.br ^bb1
    ^bb20:  // pred: ^bb18
      %127 = comb.icmp ceq %100, %c-6_i4 : i4
      cf.cond_br %127, ^bb21, ^bb22
    ^bb21:  // pred: ^bb20
      %128 = llhd.prb %tx_rd_data_18 : i16
      %129 = comb.extract %128 from 10 : (i16) -> i1
      llhd.drv %spis_1st_bit, %129 after %0 : i1
      cf.br ^bb1
    ^bb22:  // pred: ^bb20
      %130 = comb.icmp ceq %100, %c-5_i4 : i4
      cf.cond_br %130, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      %131 = llhd.prb %tx_rd_data_18 : i16
      %132 = comb.extract %131 from 11 : (i16) -> i1
      llhd.drv %spis_1st_bit, %132 after %0 : i1
      cf.br ^bb1
    ^bb24:  // pred: ^bb22
      %133 = comb.icmp ceq %100, %c-4_i4 : i4
      cf.cond_br %133, ^bb25, ^bb26
    ^bb25:  // pred: ^bb24
      %134 = llhd.prb %tx_rd_data_18 : i16
      %135 = comb.extract %134 from 12 : (i16) -> i1
      llhd.drv %spis_1st_bit, %135 after %0 : i1
      cf.br ^bb1
    ^bb26:  // pred: ^bb24
      %136 = comb.icmp ceq %100, %c-3_i4 : i4
      cf.cond_br %136, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      %137 = llhd.prb %tx_rd_data_18 : i16
      %138 = comb.extract %137 from 13 : (i16) -> i1
      llhd.drv %spis_1st_bit, %138 after %0 : i1
      cf.br ^bb1
    ^bb28:  // pred: ^bb26
      %139 = comb.icmp ceq %100, %c-2_i4 : i4
      cf.cond_br %139, ^bb29, ^bb30
    ^bb29:  // pred: ^bb28
      %140 = llhd.prb %tx_rd_data_18 : i16
      %141 = comb.extract %140 from 14 : (i16) -> i1
      llhd.drv %spis_1st_bit, %141 after %0 : i1
      cf.br ^bb1
    ^bb30:  // pred: ^bb28
      %142 = llhd.prb %tx_rd_data_18 : i16
      %143 = comb.extract %142 from 15 : (i16) -> i1
      llhd.drv %spis_1st_bit, %143 after %0 : i1
      cf.br ^bb1
    }
    %70 = llhd.prb %spis_en_16 : i1
    %71 = comb.replicate %70 : (i1) -> i16
    %72 = llhd.prb %spis_rx : i16
    %73 = comb.and %71, %72 : i16
    %74 = llhd.prb %spim_en_15 : i1
    %75 = comb.replicate %74 : (i1) -> i16
    %76 = llhd.prb %spim_rx : i16
    %77 = comb.and %75, %76 : i16
    %78 = comb.or %73, %77 : i16
    llhd.drv %rx_wr_data, %78 after %0 : i16
    %79 = llhd.prb %data_smp : i1
    %80 = comb.icmp eq %34, %c0_i5 : i5
    %81 = comb.and %70, %18, %64, %61, %79 : i1
    %82 = comb.and %74, %33, %80, %31, %18 : i1
    %83 = comb.or %81, %82 : i1
    %84 = llhd.prb %spis_rx_wen : i1
    %85 = comb.and %70, %84 : i1
    %86 = comb.and %74, %36 : i1
    %87 = comb.or %85, %86 : i1
    %88 = comb.xor %17, %true : i1
    %89 = comb.and %74, %88 : i1
    %90 = comb.and %70, %64 : i1
    %91 = comb.or %89, %90 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %100 = llhd.prb %clk_0 : i1
      %101 = llhd.prb %rst_n_7 : i1
      llhd.wait (%4, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %102 = llhd.prb %clk_0 : i1
      %103 = comb.xor bin %100, %true : i1
      %104 = comb.and bin %103, %102 : i1
      %105 = llhd.prb %rst_n_7 : i1
      %106 = comb.xor bin %105, %true : i1
      %107 = comb.and bin %101, %106 : i1
      %108 = comb.or bin %104, %107 : i1
      cf.cond_br %108, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %109 = llhd.prb %rst_n_7 : i1
      %110 = comb.xor %109, %true : i1
      cf.cond_br %110, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %spi_stop_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %111 = llhd.prb %spi_stop_clr_13 : i1
      %112 = llhd.prb %spi_intr_en_9 : i1
      %113 = comb.xor %112, %true : i1
      %114 = comb.or %111, %113 : i1
      cf.cond_br %114, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %spi_stop_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %115 = llhd.prb %spim_en_15 : i1
      %116 = llhd.prb %spim_stop_intr : i1
      %117 = comb.and %115, %116 : i1
      %118 = llhd.prb %spis_en_16 : i1
      %119 = llhd.prb %spis_stop_intr : i1
      %120 = comb.and %118, %119 : i1
      %121 = comb.or %117, %120 : i1
      cf.cond_br %121, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %spi_stop_intr, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.drv %spim_stop_intr, %57 after %0 : i1
    %92 = comb.icmp eq %60, %c0_i4 : i4
    %93 = llhd.prb %spis_rx_en : i1
    %94 = comb.and %92, %79, %93 : i1
    llhd.drv %spis_stop_intr, %94 after %0 : i1
    llhd.drv %clk_0, %clk after %0 : i1
    llhd.drv %cpha_1, %cpha after %0 : i1
    llhd.drv %cpol_2, %cpol after %0 : i1
    llhd.drv %f_nss_3, %f_nss after %0 : i1
    llhd.drv %f_sclk_4, %f_sclk after %0 : i1
    llhd.drv %i_nss_in_5, %i_nss_in after %0 : i1
    llhd.drv %r_sclk_6, %r_sclk after %0 : i1
    llhd.drv %rst_n_7, %rst_n after %0 : i1
    %95 = llhd.prb %rx_wr_data : i16
    llhd.drv %spi_data_size_8, %spi_data_size after %0 : i4
    llhd.drv %spi_intr_en_9, %spi_intr_en after %0 : i1
    llhd.drv %spi_mi_10, %spi_mi after %0 : i1
    llhd.drv %spi_rx_en_11, %spi_rx_en after %0 : i1
    llhd.drv %spi_si_12, %spi_si after %0 : i1
    %96 = llhd.prb %spi_so : i1
    llhd.drv %spi_stop_clr_13, %spi_stop_clr after %0 : i1
    %97 = llhd.prb %spi_stop_intr : i1
    llhd.drv %spi_tx_en_14, %spi_tx_en after %0 : i1
    llhd.drv %spim_en_15, %spim_en after %0 : i1
    %98 = llhd.prb %spim_nss : i1
    %99 = llhd.prb %spim_sck : i1
    llhd.drv %spis_en_16, %spis_en after %0 : i1
    llhd.drv %tx_empty_17, %tx_empty after %0 : i1
    llhd.drv %tx_rd_data_18, %tx_rd_data after %0 : i16
    hw.output %95, %2, %87, %96, %97, %83, %91, %98, %99 : i16, i1, i1, i1, i1, i1, i1, i1, i1
  }
  hw.module private @sync_fifo_16x16(in %clk : i1, out empty : i1, in %empty_clr : i1, out empty_d : i1, out empty_intr : i1, in %fifo_en : i1, in %fifo_intr_en : i5, in %fifo_thold : i2, out flag_counter : i5, out full : i1, in %full_clr : i1, out full_intr : i1, in %intr_edge : i1, out rd_data : i16, in %rd_en : i1, in %read_err_clr : i1, out read_err_intr : i1, in %rst_n : i1, in %thold_clr : i1, out thold_intr : i1, in %wr_data : i16, in %wr_en : i1, in %write_err_clr : i1, out write_err_intr : i1) {
    %c13_i32 = hw.constant 13 : i32
    %c9_i32 = hw.constant 9 : i32
    %c5_i32 = hw.constant 5 : i32
    %c11_i32 = hw.constant 11 : i32
    %c0_i3 = hw.constant 0 : i3
    %c-16_i5 = hw.constant -16 : i5
    %c1_i5 = hw.constant 1 : i5
    %c-1_i5 = hw.constant -1 : i5
    %c1_i4 = hw.constant 1 : i4
    %c0_i27 = hw.constant 0 : i27
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %c0_i256 = hw.constant 0 : i256
    %c0_i16 = hw.constant 0 : i16
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %false = hw.constant false
    %true = hw.constant true
    %c0_i5 = hw.constant 0 : i5
    %c-1_i4 = hw.constant -1 : i4
    %c0_i4 = hw.constant 0 : i4
    %clk_0 = llhd.sig name "clk" %false : i1
    %2 = llhd.prb %clk_0 : i1
    %empty_clr_1 = llhd.sig name "empty_clr" %false : i1
    %fifo_en_2 = llhd.sig name "fifo_en" %false : i1
    %fifo_intr_en_3 = llhd.sig name "fifo_intr_en" %c0_i5 : i5
    %fifo_thold_4 = llhd.sig name "fifo_thold" %c0_i2 : i2
    %3 = llhd.prb %fifo_thold_4 : i2
    %full_clr_5 = llhd.sig name "full_clr" %false : i1
    %ge_cnt_eq12 = llhd.sig %false : i1
    %4 = llhd.prb %ge_cnt_eq12 : i1
    %ge_cnt_eq4 = llhd.sig %false : i1
    %5 = llhd.prb %ge_cnt_eq4 : i1
    %ge_cnt_eq8 = llhd.sig %false : i1
    %6 = llhd.prb %ge_cnt_eq8 : i1
    %intr_edge_6 = llhd.sig name "intr_edge" %false : i1
    %7 = llhd.prb %intr_edge_6 : i1
    %le_cnt_eq12 = llhd.sig %false : i1
    %8 = llhd.prb %le_cnt_eq12 : i1
    %le_cnt_eq4 = llhd.sig %false : i1
    %9 = llhd.prb %le_cnt_eq4 : i1
    %le_cnt_eq8 = llhd.sig %false : i1
    %10 = llhd.prb %le_cnt_eq8 : i1
    %rd_data = llhd.sig %c0_i16 : i16
    %rd_en_7 = llhd.sig name "rd_en" %false : i1
    %read_err_clr_8 = llhd.sig name "read_err_clr" %false : i1
    %rst_n_9 = llhd.sig name "rst_n" %false : i1
    %11 = llhd.prb %rst_n_9 : i1
    %thold_clr_10 = llhd.sig name "thold_clr" %false : i1
    %wr_data_11 = llhd.sig name "wr_data" %c0_i16 : i16
    %wr_en_12 = llhd.sig name "wr_en" %false : i1
    %write_err_clr_13 = llhd.sig name "write_err_clr" %false : i1
    %empty = llhd.sig %false : i1
    %empty_d = llhd.sig %false : i1
    %empty_intr = llhd.sig %false : i1
    %flag_counter = llhd.sig %c0_i5 : i5
    %full = llhd.sig %false : i1
    %full_d = llhd.sig %false : i1
    %full_intr = llhd.sig %false : i1
    %12 = hw.bitcast %c0_i256 : (i256) -> !hw.array<16xi16>
    %mem_fifo = llhd.sig %12 : !hw.array<16xi16>
    %rd_ptr = llhd.sig %c0_i4 : i4
    %read_err_intr = llhd.sig %false : i1
    %thold_en = llhd.sig %false : i1
    %thold_intr = llhd.sig %false : i1
    %wr_ptr = llhd.sig %c0_i4 : i4
    %write_err_intr = llhd.sig %false : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %36 = llhd.prb %clk_0 : i1
      %37 = llhd.prb %rst_n_9 : i1
      llhd.wait (%2, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %38 = llhd.prb %clk_0 : i1
      %39 = comb.xor bin %36, %true : i1
      %40 = comb.and bin %39, %38 : i1
      %41 = llhd.prb %rst_n_9 : i1
      %42 = comb.xor bin %41, %true : i1
      %43 = comb.and bin %37, %42 : i1
      %44 = comb.or bin %40, %43 : i1
      cf.cond_br %44, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %45 = llhd.prb %rst_n_9 : i1
      %46 = comb.xor %45, %true : i1
      cf.cond_br %46, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %wr_ptr, %c0_i4 after %1 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %47 = llhd.prb %fifo_en_2 : i1
      %48 = comb.xor %47, %true : i1
      cf.cond_br %48, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %wr_ptr, %c0_i4 after %1 : i4
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %49 = llhd.prb %wr_en_12 : i1
      cf.cond_br %49, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %50 = llhd.prb %wr_ptr : i4
      %51 = comb.add %50, %c1_i4 : i4
      llhd.drv %wr_ptr, %51 after %1 : i4
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %36 = llhd.prb %clk_0 : i1
      %37 = llhd.prb %rst_n_9 : i1
      llhd.wait (%2, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %38 = llhd.prb %clk_0 : i1
      %39 = comb.xor bin %36, %true : i1
      %40 = comb.and bin %39, %38 : i1
      %41 = llhd.prb %rst_n_9 : i1
      %42 = comb.xor bin %41, %true : i1
      %43 = comb.and bin %37, %42 : i1
      %44 = comb.or bin %40, %43 : i1
      cf.cond_br %44, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %45 = llhd.prb %rst_n_9 : i1
      %46 = comb.xor %45, %true : i1
      cf.cond_br %46, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rd_ptr, %c0_i4 after %1 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %47 = llhd.prb %fifo_en_2 : i1
      %48 = comb.xor %47, %true : i1
      cf.cond_br %48, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %rd_ptr, %c0_i4 after %1 : i4
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %49 = llhd.prb %empty : i1
      %50 = comb.xor %49, %true : i1
      %51 = llhd.prb %rd_en_7 : i1
      %52 = comb.and %50, %51 : i1
      %53 = llhd.prb %full : i1
      %54 = llhd.prb %wr_en_12 : i1
      %55 = comb.and %53, %54 : i1
      %56 = comb.or %52, %55 : i1
      cf.cond_br %56, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %57 = llhd.prb %rd_ptr : i4
      %58 = comb.add %57, %c1_i4 : i4
      llhd.drv %rd_ptr, %58 after %1 : i4
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
      %36 = llhd.prb %clk_0 : i1
      llhd.wait (%2 : i1), ^bb2
    ^bb2:  // pred: ^bb1
      %37 = llhd.prb %clk_0 : i1
      %38 = comb.xor bin %36, %true : i1
      %39 = comb.and bin %38, %37 : i1
      cf.cond_br %39, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %40 = llhd.prb %wr_en_12 : i1
      %41 = llhd.prb %fifo_en_2 : i1
      %42 = comb.and %40, %41 : i1
      cf.cond_br %42, ^bb4, ^bb1
    ^bb4:  // pred: ^bb3
      %43 = llhd.prb %wr_ptr : i4
      %44 = comb.sub %c-1_i4, %43 : i4
      %45 = llhd.sig.array_get %mem_fifo[%44] : <!hw.array<16xi16>>
      %46 = llhd.prb %wr_data_11 : i16
      llhd.drv %45, %46 after %1 : i16
      cf.br ^bb1
    }
    %13 = llhd.prb %mem_fifo : !hw.array<16xi16>
    %14 = llhd.prb %rd_ptr : i4
    %15 = comb.sub %c-1_i4, %14 : i4
    %16 = hw.array_get %13[%15] : !hw.array<16xi16>, i4
    llhd.drv %rd_data, %16 after %0 : i16
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %36 = llhd.prb %clk_0 : i1
      %37 = llhd.prb %rst_n_9 : i1
      llhd.wait (%2, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %38 = llhd.prb %clk_0 : i1
      %39 = comb.xor bin %36, %true : i1
      %40 = comb.and bin %39, %38 : i1
      %41 = llhd.prb %rst_n_9 : i1
      %42 = comb.xor bin %41, %true : i1
      %43 = comb.and bin %37, %42 : i1
      %44 = comb.or bin %40, %43 : i1
      cf.cond_br %44, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %45 = llhd.prb %rst_n_9 : i1
      %46 = comb.xor %45, %true : i1
      cf.cond_br %46, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %flag_counter, %c0_i5 after %1 : i5
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %47 = llhd.prb %fifo_en_2 : i1
      %48 = comb.xor %47, %true : i1
      cf.cond_br %48, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %flag_counter, %c0_i5 after %1 : i5
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %49 = llhd.prb %rd_en_7 : i1
      %50 = llhd.prb %wr_en_12 : i1
      %51 = comb.xor %50, %true : i1
      %52 = llhd.prb %empty : i1
      %53 = comb.xor %52, %true : i1
      %54 = comb.and %49, %51, %53 : i1
      cf.cond_br %54, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %55 = llhd.prb %flag_counter : i5
      %56 = comb.add %55, %c-1_i5 : i5
      llhd.drv %flag_counter, %56 after %1 : i5
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %57 = llhd.prb %rd_en_7 : i1
      %58 = comb.xor %57, %true : i1
      %59 = llhd.prb %wr_en_12 : i1
      %60 = llhd.prb %full : i1
      %61 = comb.xor %60, %true : i1
      %62 = comb.and %58, %59, %61 : i1
      cf.cond_br %62, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %63 = llhd.prb %flag_counter : i5
      %64 = comb.add %63, %c1_i5 : i5
      llhd.drv %flag_counter, %64 after %1 : i5
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %36 = llhd.prb %clk_0 : i1
      %37 = llhd.prb %rst_n_9 : i1
      llhd.wait (%2, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %38 = llhd.prb %clk_0 : i1
      %39 = comb.xor bin %36, %true : i1
      %40 = comb.and bin %39, %38 : i1
      %41 = llhd.prb %rst_n_9 : i1
      %42 = comb.xor bin %41, %true : i1
      %43 = comb.and bin %37, %42 : i1
      %44 = comb.or bin %40, %43 : i1
      cf.cond_br %44, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %45 = llhd.prb %rst_n_9 : i1
      %46 = comb.xor %45, %true : i1
      cf.cond_br %46, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %empty, %true after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %47 = llhd.prb %fifo_en_2 : i1
      %48 = comb.xor %47, %true : i1
      cf.cond_br %48, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %empty, %true after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %49 = llhd.prb %flag_counter : i5
      %50 = comb.icmp eq %49, %c1_i5 : i5
      %51 = llhd.prb %rd_en_7 : i1
      %52 = llhd.prb %wr_en_12 : i1
      %53 = comb.xor %52, %true : i1
      %54 = comb.and %50, %51, %53 : i1
      cf.cond_br %54, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %empty, %true after %1 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %55 = llhd.prb %flag_counter : i5
      %56 = comb.icmp ne %55, %c0_i5 : i5
      cf.cond_br %56, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      llhd.drv %empty, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9
      %36 = llhd.prb %clk_0 : i1
      %37 = llhd.prb %rst_n_9 : i1
      llhd.wait (%2, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %38 = llhd.prb %clk_0 : i1
      %39 = comb.xor bin %36, %true : i1
      %40 = comb.and bin %39, %38 : i1
      %41 = llhd.prb %rst_n_9 : i1
      %42 = comb.xor bin %41, %true : i1
      %43 = comb.and bin %37, %42 : i1
      %44 = comb.or bin %40, %43 : i1
      cf.cond_br %44, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %45 = llhd.prb %rst_n_9 : i1
      %46 = comb.xor %45, %true : i1
      cf.cond_br %46, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %full, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %47 = llhd.prb %fifo_en_2 : i1
      %48 = comb.xor %47, %true : i1
      cf.cond_br %48, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %full, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %49 = llhd.prb %flag_counter : i5
      %50 = comb.icmp eq %49, %c-16_i5 : i5
      cf.cond_br %50, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %full, %true after %1 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      llhd.drv %full, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %36 = llhd.prb %clk_0 : i1
      %37 = llhd.prb %rst_n_9 : i1
      llhd.wait (%2, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %38 = llhd.prb %clk_0 : i1
      %39 = comb.xor bin %36, %true : i1
      %40 = comb.and bin %39, %38 : i1
      %41 = llhd.prb %rst_n_9 : i1
      %42 = comb.xor bin %41, %true : i1
      %43 = comb.and bin %37, %42 : i1
      %44 = comb.or bin %40, %43 : i1
      cf.cond_br %44, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %45 = llhd.prb %rst_n_9 : i1
      %46 = comb.xor %45, %true : i1
      cf.cond_br %46, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %thold_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %47 = llhd.prb %thold_clr_10 : i1
      %48 = llhd.prb %fifo_intr_en_3 : i5
      %49 = comb.extract %48 from 0 : (i5) -> i1
      %50 = comb.xor %49, %true : i1
      %51 = comb.or %47, %50 : i1
      cf.cond_br %51, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %thold_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %52 = llhd.prb %thold_en : i1
      cf.cond_br %52, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %thold_intr, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %36 = llhd.prb %clk_0 : i1
      %37 = llhd.prb %rst_n_9 : i1
      llhd.wait (%2, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %38 = llhd.prb %clk_0 : i1
      %39 = comb.xor bin %36, %true : i1
      %40 = comb.and bin %39, %38 : i1
      %41 = llhd.prb %rst_n_9 : i1
      %42 = comb.xor bin %41, %true : i1
      %43 = comb.and bin %37, %42 : i1
      %44 = comb.or bin %40, %43 : i1
      cf.cond_br %44, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %45 = llhd.prb %rst_n_9 : i1
      %46 = comb.xor %45, %true : i1
      cf.cond_br %46, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %full_d, %false after %1 : i1
      llhd.drv %empty_d, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %47 = llhd.prb %full : i1
      llhd.drv %full_d, %47 after %1 : i1
      %48 = llhd.prb %empty : i1
      llhd.drv %empty_d, %48 after %1 : i1
      cf.br ^bb1
    }
    %17 = llhd.prb %flag_counter : i5
    %18 = comb.concat %c0_i27, %17 : i27, i5
    %19 = comb.extract %17 from 2 : (i5) -> i3
    %20 = comb.icmp ne %19, %c0_i3 : i3
    llhd.drv %ge_cnt_eq4, %20 after %0 : i1
    %21 = comb.extract %17 from 3 : (i5) -> i2
    %22 = comb.icmp ne %21, %c0_i2 : i2
    llhd.drv %ge_cnt_eq8, %22 after %0 : i1
    %23 = comb.icmp ugt %18, %c11_i32 : i32
    llhd.drv %ge_cnt_eq12, %23 after %0 : i1
    %24 = comb.icmp ult %18, %c5_i32 : i32
    llhd.drv %le_cnt_eq4, %24 after %0 : i1
    %25 = comb.icmp ult %18, %c9_i32 : i32
    llhd.drv %le_cnt_eq8, %25 after %0 : i1
    %26 = comb.icmp ult %18, %c13_i32 : i32
    llhd.drv %le_cnt_eq12, %26 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb3, ^bb5, ^bb7, ^bb8
      llhd.wait (%8, %6, %9, %4, %10, %3, %5, %7 : i1, i1, i1, i1, i1, i2, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %36 = llhd.prb %fifo_thold_4 : i2
      %37 = comb.icmp ceq %36, %c0_i2 : i2
      cf.cond_br %37, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %thold_en, %false after %0 : i1
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      %38 = comb.icmp ceq %36, %c1_i2 : i2
      cf.cond_br %38, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %39 = llhd.prb %intr_edge_6 : i1
      %40 = llhd.prb %ge_cnt_eq4 : i1
      %41 = llhd.prb %le_cnt_eq4 : i1
      %42 = comb.mux %39, %40, %41 : i1
      llhd.drv %thold_en, %42 after %0 : i1
      cf.br ^bb1
    ^bb6:  // pred: ^bb4
      %43 = comb.icmp ceq %36, %c-2_i2 : i2
      cf.cond_br %43, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %44 = llhd.prb %intr_edge_6 : i1
      %45 = llhd.prb %ge_cnt_eq8 : i1
      %46 = llhd.prb %le_cnt_eq8 : i1
      %47 = comb.mux %44, %45, %46 : i1
      llhd.drv %thold_en, %47 after %0 : i1
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %48 = llhd.prb %intr_edge_6 : i1
      %49 = llhd.prb %ge_cnt_eq12 : i1
      %50 = llhd.prb %le_cnt_eq12 : i1
      %51 = comb.mux %48, %49, %50 : i1
      llhd.drv %thold_en, %51 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb10, ^bb11, ^bb12
      %36 = llhd.prb %clk_0 : i1
      %37 = llhd.prb %rst_n_9 : i1
      llhd.wait (%2, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %38 = llhd.prb %clk_0 : i1
      %39 = comb.xor bin %36, %true : i1
      %40 = comb.and bin %39, %38 : i1
      %41 = llhd.prb %rst_n_9 : i1
      %42 = comb.xor bin %41, %true : i1
      %43 = comb.and bin %37, %42 : i1
      %44 = comb.or bin %40, %43 : i1
      cf.cond_br %44, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %45 = llhd.prb %rst_n_9 : i1
      %46 = comb.xor %45, %true : i1
      cf.cond_br %46, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %full_intr, %false after %1 : i1
      llhd.drv %empty_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %47 = llhd.prb %full_clr_5 : i1
      %48 = llhd.prb %fifo_intr_en_3 : i5
      %49 = comb.extract %48 from 2 : (i5) -> i1
      %50 = comb.xor %49, %true : i1
      %51 = comb.or %47, %50 : i1
      cf.cond_br %51, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %full_intr, %false after %1 : i1
      cf.br ^bb9
    ^bb7:  // pred: ^bb5
      %52 = llhd.prb %full : i1
      cf.cond_br %52, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %full_intr, %true after %1 : i1
      cf.br ^bb9
    ^bb9:  // 3 preds: ^bb6, ^bb7, ^bb8
      %53 = llhd.prb %empty_clr_1 : i1
      %54 = llhd.prb %fifo_intr_en_3 : i5
      %55 = comb.extract %54 from 1 : (i5) -> i1
      %56 = comb.xor %55, %true : i1
      %57 = comb.or %53, %56 : i1
      cf.cond_br %57, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      llhd.drv %empty_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb11:  // pred: ^bb9
      %58 = llhd.prb %empty : i1
      cf.cond_br %58, ^bb12, ^bb1
    ^bb12:  // pred: ^bb11
      llhd.drv %empty_intr, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %36 = llhd.prb %clk_0 : i1
      %37 = llhd.prb %rst_n_9 : i1
      llhd.wait (%2, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %38 = llhd.prb %clk_0 : i1
      %39 = comb.xor bin %36, %true : i1
      %40 = comb.and bin %39, %38 : i1
      %41 = llhd.prb %rst_n_9 : i1
      %42 = comb.xor bin %41, %true : i1
      %43 = comb.and bin %37, %42 : i1
      %44 = comb.or bin %40, %43 : i1
      cf.cond_br %44, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %45 = llhd.prb %rst_n_9 : i1
      %46 = comb.xor %45, %true : i1
      cf.cond_br %46, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %read_err_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %47 = llhd.prb %read_err_clr_8 : i1
      %48 = llhd.prb %fifo_intr_en_3 : i5
      %49 = comb.extract %48 from 3 : (i5) -> i1
      %50 = comb.xor %49, %true : i1
      %51 = comb.or %47, %50 : i1
      cf.cond_br %51, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %read_err_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %52 = llhd.prb %empty : i1
      %53 = llhd.prb %rd_en_7 : i1
      %54 = comb.and %52, %53 : i1
      cf.cond_br %54, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %read_err_intr, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %36 = llhd.prb %clk_0 : i1
      %37 = llhd.prb %rst_n_9 : i1
      llhd.wait (%2, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %38 = llhd.prb %clk_0 : i1
      %39 = comb.xor bin %36, %true : i1
      %40 = comb.and bin %39, %38 : i1
      %41 = llhd.prb %rst_n_9 : i1
      %42 = comb.xor bin %41, %true : i1
      %43 = comb.and bin %37, %42 : i1
      %44 = comb.or bin %40, %43 : i1
      cf.cond_br %44, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %45 = llhd.prb %rst_n_9 : i1
      %46 = comb.xor %45, %true : i1
      cf.cond_br %46, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %write_err_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %47 = llhd.prb %write_err_clr_13 : i1
      %48 = llhd.prb %fifo_intr_en_3 : i5
      %49 = comb.extract %48 from 4 : (i5) -> i1
      %50 = comb.xor %49, %true : i1
      %51 = comb.or %47, %50 : i1
      cf.cond_br %51, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %write_err_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %52 = llhd.prb %full : i1
      %53 = llhd.prb %wr_en_12 : i1
      %54 = comb.and %52, %53 : i1
      cf.cond_br %54, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %write_err_intr, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_0, %clk after %0 : i1
    %27 = llhd.prb %empty : i1
    llhd.drv %empty_clr_1, %empty_clr after %0 : i1
    %28 = llhd.prb %empty_d : i1
    %29 = llhd.prb %empty_intr : i1
    llhd.drv %fifo_en_2, %fifo_en after %0 : i1
    llhd.drv %fifo_intr_en_3, %fifo_intr_en after %0 : i5
    llhd.drv %fifo_thold_4, %fifo_thold after %0 : i2
    %30 = llhd.prb %full : i1
    llhd.drv %full_clr_5, %full_clr after %0 : i1
    %31 = llhd.prb %full_intr : i1
    llhd.drv %intr_edge_6, %intr_edge after %0 : i1
    %32 = llhd.prb %rd_data : i16
    llhd.drv %rd_en_7, %rd_en after %0 : i1
    llhd.drv %read_err_clr_8, %read_err_clr after %0 : i1
    %33 = llhd.prb %read_err_intr : i1
    llhd.drv %rst_n_9, %rst_n after %0 : i1
    llhd.drv %thold_clr_10, %thold_clr after %0 : i1
    %34 = llhd.prb %thold_intr : i1
    llhd.drv %wr_data_11, %wr_data after %0 : i16
    llhd.drv %wr_en_12, %wr_en after %0 : i1
    llhd.drv %write_err_clr_13, %write_err_clr after %0 : i1
    %35 = llhd.prb %write_err_intr : i1
    hw.output %27, %28, %29, %17, %30, %31, %32, %33, %34, %35 : i1, i1, i1, i5, i1, i1, i16, i1, i1, i1
  }
  hw.module private @uart(in %clk : i1, in %f_rxd : i1, in %i_rxd_in : i1, in %rst_n : i1, out rx_shift : i8, out rxd_work : i1, in %tx_empty : i1, in %tx_rd_data : i8, out txd_out : i1, out txd_work : i1, in %uart_dbit : i2, in %uart_div : i24, in %uart_en : i1, in %uart_eps : i1, in %uart_intr_en : i2, in %uart_pbit : i2, in %uart_pen : i1, in %uart_perr_clr : i1, out uart_perr_intr : i1, out uart_rx_wen : i1, in %uart_rxd : i1, in %uart_stop_clr : i1, out uart_stop_intr : i1, out uart_tx_ren : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %c4_i4 = hw.constant 4 : i4
    %c3_i4 = hw.constant 3 : i4
    %c2_i4 = hw.constant 2 : i4
    %c0_i8 = hw.constant 0 : i8
    %c-7_i4 = hw.constant -7 : i4
    %c-8_i4 = hw.constant -8 : i4
    %c6_i4 = hw.constant 6 : i4
    %c5_i4 = hw.constant 5 : i4
    %c-6_i4 = hw.constant -6 : i4
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %c-1_i3 = hw.constant -1 : i3
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %false = hw.constant false
    %true = hw.constant true
    %c1_i4 = hw.constant 1 : i4
    %c0_i4 = hw.constant 0 : i4
    %c1_i24 = hw.constant 1 : i24
    %c7_i4 = hw.constant 7 : i4
    %c0_i24 = hw.constant 0 : i24
    %c-1_i4 = hw.constant -1 : i4
    %c1_i3 = hw.constant 1 : i3
    %c-2_i3 = hw.constant -2 : i3
    %c2_i3 = hw.constant 2 : i3
    %c3_i3 = hw.constant 3 : i3
    %c0_i3 = hw.constant 0 : i3
    %data_parity = llhd.sig %false : i1
    %dbit_en = llhd.sig %false : i1
    %nxt_uart_fsm = llhd.sig %c0_i3 : i3
    %parity_check = llhd.sig %false : i1
    %rx_en = llhd.sig %false : i1
    %rx_shift = llhd.sig %c0_i8 : i8
    %2 = llhd.prb %rx_shift : i8
    %rxcnt_1bit = llhd.sig %c0_i4 : i4
    %rxcnt_bits = llhd.sig %c0_i4 : i4
    %3 = llhd.prb %rxcnt_bits : i4
    %rxcnt_div16 = llhd.sig %c0_i24 : i24
    %txcnt_1bit = llhd.sig %c0_i4 : i4
    %4 = llhd.prb %txcnt_1bit : i4
    %txcnt_bits = llhd.sig %c0_i3 : i3
    %5 = llhd.prb %txcnt_bits : i3
    %txcnt_div16 = llhd.sig %c0_i24 : i24
    %txd_out = llhd.sig %false : i1
    %uart_bit0_en = llhd.sig %false : i1
    %uart_data_end = llhd.sig %false : i1
    %6 = llhd.prb %uart_data_end : i1
    %uart_fsm = llhd.sig %c0_i3 : i3
    %7 = llhd.prb %uart_fsm : i3
    %uart_perr_intr = llhd.sig %false : i1
    %uart_stop_end = llhd.sig %false : i1
    %8 = llhd.prb %uart_stop_end : i1
    %uart_stop_intr = llhd.sig %false : i1
    %clk_0 = llhd.sig name "clk" %false : i1
    %9 = llhd.prb %clk_0 : i1
    %f_rxd_1 = llhd.sig name "f_rxd" %false : i1
    %i_rxd_in_2 = llhd.sig name "i_rxd_in" %false : i1
    %10 = llhd.prb %i_rxd_in_2 : i1
    %parity_comp = llhd.sig %false : i1
    %rst_n_3 = llhd.sig name "rst_n" %false : i1
    %11 = llhd.prb %rst_n_3 : i1
    %rxcnt_1bit_eq = llhd.sig %false : i1
    %rxcnt_div16_eq = llhd.sig %false : i1
    %rxcnt_plus = llhd.sig %false : i1
    %tx_empty_4 = llhd.sig name "tx_empty" %false : i1
    %12 = llhd.prb %tx_empty_4 : i1
    %tx_rd_data_5 = llhd.sig name "tx_rd_data" %c0_i8 : i8
    %13 = llhd.prb %tx_rd_data_5 : i8
    %txcnt_1bit_eq = llhd.sig %false : i1
    %14 = llhd.prb %txcnt_1bit_eq : i1
    %txcnt_bits_eq1 = llhd.sig %false : i1
    %15 = llhd.prb %txcnt_bits_eq1 : i1
    %txcnt_div16_eq = llhd.sig %false : i1
    %16 = llhd.prb %txcnt_div16_eq : i1
    %uart_all_end = llhd.sig %false : i1
    %uart_data = llhd.sig %false : i1
    %17 = llhd.prb %uart_data : i1
    %uart_dbit_6 = llhd.sig name "uart_dbit" %c0_i2 : i2
    %18 = llhd.prb %uart_dbit_6 : i2
    %uart_div_7 = llhd.sig name "uart_div" %c0_i24 : i24
    %uart_en_8 = llhd.sig name "uart_en" %false : i1
    %uart_eps_9 = llhd.sig name "uart_eps" %false : i1
    %uart_idle = llhd.sig %false : i1
    %uart_idle_end = llhd.sig %false : i1
    %19 = llhd.prb %uart_idle_end : i1
    %uart_intr_en_10 = llhd.sig name "uart_intr_en" %c0_i2 : i2
    %uart_parity_end = llhd.sig %false : i1
    %20 = llhd.prb %uart_parity_end : i1
    %uart_pbit_11 = llhd.sig name "uart_pbit" %c0_i2 : i2
    %21 = llhd.prb %uart_pbit_11 : i2
    %uart_pen_12 = llhd.sig name "uart_pen" %false : i1
    %22 = llhd.prb %uart_pen_12 : i1
    %uart_perr_clr_13 = llhd.sig name "uart_perr_clr" %false : i1
    %uart_rx_end = llhd.sig %false : i1
    %uart_rx_wen = llhd.sig %false : i1
    %uart_rxd_14 = llhd.sig name "uart_rxd" %false : i1
    %uart_start_end = llhd.sig %false : i1
    %23 = llhd.prb %uart_start_end : i1
    %uart_stop = llhd.sig %false : i1
    %24 = llhd.prb %uart_stop : i1
    %uart_stop_clr_15 = llhd.sig name "uart_stop_clr" %false : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_3 : i1
      llhd.wait (%9, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_3 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_3 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %uart_fsm, %c0_i3 after %1 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %uart_en_8 : i1
      cf.cond_br %83, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %84 = llhd.prb %nxt_uart_fsm : i3
      llhd.drv %uart_fsm, %84 after %1 : i3
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      llhd.drv %uart_fsm, %c0_i3 after %1 : i3
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 14 preds: ^bb0, ^bb4, ^bb5, ^bb8, ^bb9, ^bb13, ^bb14, ^bb15, ^bb18, ^bb19, ^bb23, ^bb24, ^bb25, ^bb26
      llhd.wait (%8, %6, %19, %22, %12, %20, %7, %23 : i1, i1, i1, i1, i1, i1, i3, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %72 = llhd.prb %uart_fsm : i3
      %73 = comb.icmp ceq %72, %c0_i3 : i3
      cf.cond_br %73, ^bb3, ^bb6
    ^bb3:  // pred: ^bb2
      %74 = llhd.prb %uart_idle_end : i1
      cf.cond_br %74, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %nxt_uart_fsm, %c3_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      llhd.drv %nxt_uart_fsm, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb6:  // pred: ^bb2
      %75 = comb.icmp ceq %72, %c3_i3 : i3
      cf.cond_br %75, ^bb7, ^bb10
    ^bb7:  // pred: ^bb6
      %76 = llhd.prb %uart_start_end : i1
      cf.cond_br %76, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %nxt_uart_fsm, %c2_i3 after %0 : i3
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      llhd.drv %nxt_uart_fsm, %c3_i3 after %0 : i3
      cf.br ^bb1
    ^bb10:  // pred: ^bb6
      %77 = comb.icmp ceq %72, %c2_i3 : i3
      cf.cond_br %77, ^bb11, ^bb16
    ^bb11:  // pred: ^bb10
      %78 = llhd.prb %uart_data_end : i1
      cf.cond_br %78, ^bb12, ^bb15
    ^bb12:  // pred: ^bb11
      %79 = llhd.prb %uart_pen_12 : i1
      cf.cond_br %79, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      llhd.drv %nxt_uart_fsm, %c-2_i3 after %0 : i3
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      llhd.drv %nxt_uart_fsm, %c1_i3 after %0 : i3
      cf.br ^bb1
    ^bb15:  // pred: ^bb11
      llhd.drv %nxt_uart_fsm, %c2_i3 after %0 : i3
      cf.br ^bb1
    ^bb16:  // pred: ^bb10
      %80 = comb.icmp ceq %72, %c-2_i3 : i3
      cf.cond_br %80, ^bb17, ^bb20
    ^bb17:  // pred: ^bb16
      %81 = llhd.prb %uart_parity_end : i1
      cf.cond_br %81, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      llhd.drv %nxt_uart_fsm, %c1_i3 after %0 : i3
      cf.br ^bb1
    ^bb19:  // pred: ^bb17
      llhd.drv %nxt_uart_fsm, %c-2_i3 after %0 : i3
      cf.br ^bb1
    ^bb20:  // pred: ^bb16
      %82 = comb.icmp ceq %72, %c1_i3 : i3
      cf.cond_br %82, ^bb21, ^bb26
    ^bb21:  // pred: ^bb20
      %83 = llhd.prb %uart_stop_end : i1
      cf.cond_br %83, ^bb22, ^bb25
    ^bb22:  // pred: ^bb21
      %84 = llhd.prb %tx_empty_4 : i1
      cf.cond_br %84, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      llhd.drv %nxt_uart_fsm, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb24:  // pred: ^bb22
      llhd.drv %nxt_uart_fsm, %c3_i3 after %0 : i3
      cf.br ^bb1
    ^bb25:  // pred: ^bb21
      llhd.drv %nxt_uart_fsm, %c1_i3 after %0 : i3
      cf.br ^bb1
    ^bb26:  // pred: ^bb20
      llhd.drv %nxt_uart_fsm, %c0_i3 after %0 : i3
      cf.br ^bb1
    }
    %25 = comb.icmp eq %7, %c0_i3 : i3
    llhd.drv %uart_idle, %25 after %0 : i1
    %26 = comb.icmp eq %7, %c3_i3 {sv.namehint = "uart_start"} : i3
    %27 = comb.icmp eq %7, %c2_i3 : i3
    llhd.drv %uart_data, %27 after %0 : i1
    %28 = comb.icmp eq %7, %c-2_i3 {sv.namehint = "uart_parity"} : i3
    %29 = comb.icmp eq %7, %c1_i3 : i3
    llhd.drv %uart_stop, %29 after %0 : i1
    %30 = comb.icmp eq %5, %c1_i3 : i3
    llhd.drv %txcnt_bits_eq1, %30 after %0 : i1
    %31 = comb.icmp eq %4, %c-1_i4 : i4
    llhd.drv %txcnt_1bit_eq, %31 after %0 : i1
    %32 = llhd.prb %txcnt_div16 : i24
    %33 = llhd.prb %uart_div_7 : i24
    %34 = comb.icmp eq %32, %33 : i24
    llhd.drv %txcnt_div16_eq, %34 after %0 : i1
    %35 = llhd.prb %uart_idle : i1
    %36 = comb.xor %12, %true : i1
    %37 = comb.and %35, %36 : i1
    llhd.drv %uart_idle_end, %37 after %0 : i1
    %38 = comb.and %26, %16, %14 : i1
    llhd.drv %uart_start_end, %38 after %0 : i1
    %39 = comb.and %28, %16, %14 : i1
    llhd.drv %uart_parity_end, %39 after %0 : i1
    %40 = comb.or %19, %23, %6, %20, %8 : i1
    llhd.drv %uart_all_end, %40 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_3 : i1
      llhd.wait (%9, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_3 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_3 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %txcnt_bits, %c0_i3 after %1 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %uart_all_end : i1
      %84 = llhd.prb %uart_en_8 : i1
      %85 = comb.xor %84, %true : i1
      %86 = llhd.prb %uart_idle : i1
      %87 = comb.or %83, %85, %86 : i1
      cf.cond_br %87, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %txcnt_bits, %c0_i3 after %1 : i3
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %88 = llhd.prb %txcnt_div16_eq : i1
      %89 = llhd.prb %txcnt_1bit_eq : i1
      %90 = comb.and %88, %89 : i1
      cf.cond_br %90, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %91 = llhd.prb %txcnt_bits : i3
      %92 = comb.add %91, %c1_i3 : i3
      llhd.drv %txcnt_bits, %92 after %1 : i3
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_3 : i1
      llhd.wait (%9, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_3 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_3 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %txcnt_div16, %c0_i24 after %1 : i24
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %uart_stop : i1
      %84 = llhd.prb %txcnt_bits_eq1 : i1
      %85 = llhd.prb %txcnt_1bit : i4
      %86 = comb.icmp eq %85, %c7_i4 : i4
      %87 = llhd.prb %txcnt_div16_eq : i1
      %88 = comb.and %83, %84, %86, %87 : i1
      cf.cond_br %88, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %txcnt_div16, %c0_i24 after %1 : i24
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %89 = llhd.prb %txcnt_div16_eq : i1
      %90 = llhd.prb %uart_idle : i1
      %91 = comb.or %89, %90 : i1
      cf.cond_br %91, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %txcnt_div16, %c0_i24 after %1 : i24
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %92 = llhd.prb %txcnt_div16 : i24
      %93 = comb.add %92, %c1_i24 : i24
      llhd.drv %txcnt_div16, %93 after %1 : i24
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_3 : i1
      llhd.wait (%9, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_3 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_3 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %txcnt_1bit, %c0_i4 after %1 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %uart_en_8 : i1
      %84 = comb.xor %83, %true : i1
      %85 = llhd.prb %uart_idle : i1
      %86 = llhd.prb %uart_stop_end : i1
      %87 = comb.or %84, %85, %86 : i1
      cf.cond_br %87, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %txcnt_1bit, %c0_i4 after %1 : i4
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %88 = llhd.prb %txcnt_div16_eq : i1
      cf.cond_br %88, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %89 = llhd.prb %txcnt_1bit : i4
      %90 = comb.add %89, %c1_i4 : i4
      llhd.drv %txcnt_1bit, %90 after %1 : i4
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 16 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb11, ^bb13, ^bb15, ^bb17, ^bb19, ^bb21, ^bb23, ^bb24, ^bb26, ^bb28, ^bb29
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_3 : i1
      llhd.wait (%9, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_3 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_3 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %txd_out, %true after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %uart_fsm : i3
      %84 = comb.icmp ceq %83, %c0_i3 : i3
      cf.cond_br %84, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %txd_out, %true after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %85 = comb.icmp ceq %83, %c3_i3 : i3
      cf.cond_br %85, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %txd_out, %false after %1 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %86 = comb.icmp ceq %83, %c2_i3 : i3
      cf.cond_br %86, ^bb10, ^bb25
    ^bb10:  // pred: ^bb9
      %87 = llhd.prb %txcnt_bits : i3
      %88 = comb.icmp ceq %87, %c0_i3 : i3
      cf.cond_br %88, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %89 = llhd.prb %tx_rd_data_5 : i8
      %90 = comb.extract %89 from 0 : (i8) -> i1
      llhd.drv %txd_out, %90 after %1 : i1
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      %91 = comb.icmp ceq %87, %c1_i3 : i3
      cf.cond_br %91, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      %92 = llhd.prb %tx_rd_data_5 : i8
      %93 = comb.extract %92 from 1 : (i8) -> i1
      llhd.drv %txd_out, %93 after %1 : i1
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      %94 = comb.icmp ceq %87, %c2_i3 : i3
      cf.cond_br %94, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      %95 = llhd.prb %tx_rd_data_5 : i8
      %96 = comb.extract %95 from 2 : (i8) -> i1
      llhd.drv %txd_out, %96 after %1 : i1
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      %97 = comb.icmp ceq %87, %c3_i3 : i3
      cf.cond_br %97, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      %98 = llhd.prb %tx_rd_data_5 : i8
      %99 = comb.extract %98 from 3 : (i8) -> i1
      llhd.drv %txd_out, %99 after %1 : i1
      cf.br ^bb1
    ^bb18:  // pred: ^bb16
      %100 = comb.icmp ceq %87, %c-4_i3 : i3
      cf.cond_br %100, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %101 = llhd.prb %tx_rd_data_5 : i8
      %102 = comb.extract %101 from 4 : (i8) -> i1
      llhd.drv %txd_out, %102 after %1 : i1
      cf.br ^bb1
    ^bb20:  // pred: ^bb18
      %103 = comb.icmp ceq %87, %c-3_i3 : i3
      cf.cond_br %103, ^bb21, ^bb22
    ^bb21:  // pred: ^bb20
      %104 = llhd.prb %tx_rd_data_5 : i8
      %105 = comb.extract %104 from 5 : (i8) -> i1
      llhd.drv %txd_out, %105 after %1 : i1
      cf.br ^bb1
    ^bb22:  // pred: ^bb20
      %106 = comb.icmp ceq %87, %c-2_i3 : i3
      cf.cond_br %106, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      %107 = llhd.prb %tx_rd_data_5 : i8
      %108 = comb.extract %107 from 6 : (i8) -> i1
      llhd.drv %txd_out, %108 after %1 : i1
      cf.br ^bb1
    ^bb24:  // pred: ^bb22
      %109 = llhd.prb %tx_rd_data_5 : i8
      %110 = comb.extract %109 from 7 : (i8) -> i1
      llhd.drv %txd_out, %110 after %1 : i1
      cf.br ^bb1
    ^bb25:  // pred: ^bb9
      %111 = comb.icmp ceq %83, %c-2_i3 : i3
      cf.cond_br %111, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      %112 = llhd.prb %uart_eps_9 : i1
      %113 = llhd.prb %data_parity : i1
      %114 = comb.xor %112, %113, %true : i1
      llhd.drv %txd_out, %114 after %1 : i1
      cf.br ^bb1
    ^bb27:  // pred: ^bb25
      %115 = comb.icmp ceq %83, %c1_i3 : i3
      cf.cond_br %115, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      llhd.drv %txd_out, %true after %1 : i1
      cf.br ^bb1
    ^bb29:  // pred: ^bb27
      %116 = llhd.prb %txd_out : i1
      llhd.drv %txd_out, %116 after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb3, ^bb5, ^bb7, ^bb8
      llhd.wait (%13, %14, %16, %18, %5, %2, %17, %10 : i8, i1, i1, i2, i3, i8, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %72 = llhd.prb %uart_dbit_6 : i2
      %73 = comb.icmp ceq %72, %c0_i2 : i2
      cf.cond_br %73, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %74 = llhd.prb %tx_rd_data_5 : i8
      %75 = comb.extract %74 from 0 : (i8) -> i5
      %76 = comb.parity %75 : i5
      llhd.drv %data_parity, %76 after %0 : i1
      %77 = llhd.prb %rx_shift : i8
      %78 = comb.extract %77 from 0 : (i8) -> i5
      %79 = comb.parity %78 : i5
      %80 = llhd.prb %i_rxd_in_2 : i1
      %81 = comb.xor %79, %80 : i1
      llhd.drv %parity_check, %81 after %0 : i1
      %82 = llhd.prb %uart_data : i1
      %83 = llhd.prb %txcnt_bits : i3
      %84 = comb.icmp eq %83, %c-4_i3 : i3
      %85 = llhd.prb %txcnt_div16_eq : i1
      %86 = llhd.prb %txcnt_1bit_eq : i1
      %87 = comb.and %82, %84, %85, %86 : i1
      llhd.drv %uart_data_end, %87 after %0 : i1
      cf.br ^bb1
    ^bb4:  // pred: ^bb2
      %88 = comb.icmp ceq %72, %c1_i2 : i2
      cf.cond_br %88, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %89 = llhd.prb %tx_rd_data_5 : i8
      %90 = comb.extract %89 from 0 : (i8) -> i6
      %91 = comb.parity %90 : i6
      llhd.drv %data_parity, %91 after %0 : i1
      %92 = llhd.prb %rx_shift : i8
      %93 = comb.extract %92 from 0 : (i8) -> i6
      %94 = comb.parity %93 : i6
      %95 = llhd.prb %i_rxd_in_2 : i1
      %96 = comb.xor %94, %95 : i1
      llhd.drv %parity_check, %96 after %0 : i1
      %97 = llhd.prb %uart_data : i1
      %98 = llhd.prb %txcnt_bits : i3
      %99 = comb.icmp eq %98, %c-3_i3 : i3
      %100 = llhd.prb %txcnt_div16_eq : i1
      %101 = llhd.prb %txcnt_1bit_eq : i1
      %102 = comb.and %97, %99, %100, %101 : i1
      llhd.drv %uart_data_end, %102 after %0 : i1
      cf.br ^bb1
    ^bb6:  // pred: ^bb4
      %103 = comb.icmp ceq %72, %c-2_i2 : i2
      cf.cond_br %103, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %104 = llhd.prb %tx_rd_data_5 : i8
      %105 = comb.extract %104 from 0 : (i8) -> i7
      %106 = comb.parity %105 : i7
      llhd.drv %data_parity, %106 after %0 : i1
      %107 = llhd.prb %rx_shift : i8
      %108 = comb.extract %107 from 0 : (i8) -> i7
      %109 = comb.parity %108 : i7
      %110 = llhd.prb %i_rxd_in_2 : i1
      %111 = comb.xor %109, %110 : i1
      llhd.drv %parity_check, %111 after %0 : i1
      %112 = llhd.prb %uart_data : i1
      %113 = llhd.prb %txcnt_bits : i3
      %114 = comb.icmp eq %113, %c-2_i3 : i3
      %115 = llhd.prb %txcnt_div16_eq : i1
      %116 = llhd.prb %txcnt_1bit_eq : i1
      %117 = comb.and %112, %114, %115, %116 : i1
      llhd.drv %uart_data_end, %117 after %0 : i1
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %118 = llhd.prb %tx_rd_data_5 : i8
      %119 = comb.parity %118 : i8
      llhd.drv %data_parity, %119 after %0 : i1
      %120 = llhd.prb %rx_shift : i8
      %121 = comb.parity %120 : i8
      %122 = llhd.prb %i_rxd_in_2 : i1
      %123 = comb.xor %121, %122 : i1
      llhd.drv %parity_check, %123 after %0 : i1
      %124 = llhd.prb %uart_data : i1
      %125 = llhd.prb %txcnt_bits : i3
      %126 = comb.icmp eq %125, %c-1_i3 : i3
      %127 = llhd.prb %txcnt_div16_eq : i1
      %128 = llhd.prb %txcnt_1bit_eq : i1
      %129 = comb.and %124, %126, %127, %128 : i1
      llhd.drv %uart_data_end, %129 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      llhd.wait (%24, %14, %21, %16, %15, %4 : i1, i1, i2, i1, i1, i4), ^bb2
    ^bb2:  // pred: ^bb1
      %72 = llhd.prb %uart_stop : i1
      %73 = llhd.prb %txcnt_div16_eq : i1
      %74 = comb.and %72, %73 : i1
      cf.cond_br %74, ^bb3, ^bb10
    ^bb3:  // pred: ^bb2
      %75 = llhd.prb %uart_pbit_11 : i2
      %76 = comb.icmp ceq %75, %c0_i2 : i2
      cf.cond_br %76, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %77 = llhd.prb %txcnt_1bit_eq : i1
      llhd.drv %uart_stop_end, %77 after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %78 = comb.icmp ceq %75, %c1_i2 : i2
      cf.cond_br %78, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %79 = llhd.prb %txcnt_1bit : i4
      %80 = comb.icmp eq %79, %c7_i4 : i4
      %81 = llhd.prb %txcnt_bits_eq1 : i1
      %82 = comb.and %80, %81 : i1
      llhd.drv %uart_stop_end, %82 after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %83 = comb.icmp ceq %75, %c-2_i2 : i2
      cf.cond_br %83, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %84 = llhd.prb %txcnt_1bit_eq : i1
      %85 = llhd.prb %txcnt_bits_eq1 : i1
      %86 = comb.and %84, %85 : i1
      llhd.drv %uart_stop_end, %86 after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %87 = llhd.prb %txcnt_1bit_eq : i1
      llhd.drv %uart_stop_end, %87 after %0 : i1
      cf.br ^bb1
    ^bb10:  // pred: ^bb2
      llhd.drv %uart_stop_end, %false after %0 : i1
      cf.br ^bb1
    }
    %41 = comb.icmp eq %5, %c0_i3 : i3
    %42 = comb.icmp eq %4, %c1_i4 : i4
    %43 = comb.and %24, %41, %42, %16 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_3 : i1
      llhd.wait (%9, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_3 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_3 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rxcnt_div16, %c0_i24 after %1 : i24
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %uart_en_8 : i1
      %84 = comb.xor %83, %true : i1
      %85 = llhd.prb %rxcnt_div16 : i24
      %86 = llhd.prb %uart_div_7 : i24
      %87 = comb.icmp eq %85, %86 : i24
      %88 = llhd.prb %uart_rx_end : i1
      %89 = comb.or %84, %87, %88 : i1
      cf.cond_br %89, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %rxcnt_div16, %c0_i24 after %1 : i24
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %90 = llhd.prb %rxcnt_plus : i1
      cf.cond_br %90, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %91 = llhd.prb %rxcnt_div16 : i24
      %92 = comb.add %91, %c1_i24 : i24
      llhd.drv %rxcnt_div16, %92 after %1 : i24
      cf.br ^bb1
    }
    %44 = comb.icmp eq %3, %c0_i4 : i4
    %45 = llhd.prb %f_rxd_1 : i1
    %46 = llhd.prb %uart_bit0_en : i1
    %47 = comb.or %45, %46 : i1
    %48 = comb.and %44, %47 : i1
    %49 = comb.icmp ne %3, %c0_i4 : i4
    %50 = comb.or %48, %49 : i1
    llhd.drv %rxcnt_plus, %50 after %0 : i1
    %51 = comb.icmp eq %3, %c-6_i4 : i4
    %52 = llhd.prb %rxcnt_div16_eq : i1
    %53 = llhd.prb %rxcnt_1bit : i4
    %54 = comb.icmp eq %53, %c7_i4 : i4
    %55 = comb.and %51, %52, %54 : i1
    llhd.drv %uart_rx_end, %55 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_3 : i1
      llhd.wait (%9, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_3 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_3 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %uart_bit0_en, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %uart_rx_end : i1
      %84 = llhd.prb %rxcnt_bits : i4
      %85 = comb.icmp ne %84, %c0_i4 : i4
      %86 = comb.or %83, %85 : i1
      cf.cond_br %86, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %uart_bit0_en, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %87 = llhd.prb %f_rxd_1 : i1
      %88 = llhd.prb %rxcnt_bits : i4
      %89 = comb.icmp eq %88, %c0_i4 : i4
      %90 = comb.and %87, %89 : i1
      cf.cond_br %90, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %uart_bit0_en, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 9 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb13, ^bb14, ^bb16, ^bb17
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_3 : i1
      llhd.wait (%9, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_3 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_3 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rxcnt_bits, %c0_i4 after %1 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %rx_en : i1
      %84 = comb.xor %83, %true : i1
      %85 = llhd.prb %uart_en_8 : i1
      %86 = comb.xor %85, %true : i1
      %87 = llhd.prb %uart_rx_end : i1
      %88 = comb.or %84, %86, %87 : i1
      cf.cond_br %88, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %rxcnt_bits, %c0_i4 after %1 : i4
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %89 = llhd.prb %rxcnt_div16_eq : i1
      %90 = llhd.prb %rxcnt_1bit_eq : i1
      %91 = comb.and %89, %90 : i1
      cf.cond_br %91, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %92 = llhd.prb %rxcnt_bits : i4
      %93 = comb.icmp ceq %92, %c5_i4 : i4
      cf.cond_br %93, ^bb12, ^bb9
    ^bb9:  // pred: ^bb8
      %94 = comb.icmp ceq %92, %c6_i4 : i4
      cf.cond_br %94, ^bb12, ^bb10
    ^bb10:  // pred: ^bb9
      %95 = comb.icmp ceq %92, %c7_i4 : i4
      cf.cond_br %95, ^bb12, ^bb11
    ^bb11:  // pred: ^bb10
      %96 = comb.icmp ceq %92, %c-8_i4 : i4
      cf.cond_br %96, ^bb12, ^bb15
    ^bb12:  // 4 preds: ^bb8, ^bb9, ^bb10, ^bb11
      %97 = llhd.prb %dbit_en : i1
      cf.cond_br %97, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      %98 = llhd.prb %uart_pen_12 : i1
      %99 = comb.xor %98, %true : i1
      %100 = comb.concat %c0_i3, %99 : i3, i1
      %101 = comb.add %100, %c-7_i4 : i4
      llhd.drv %rxcnt_bits, %101 after %1 : i4
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      %102 = llhd.prb %rxcnt_bits : i4
      %103 = comb.add %102, %c1_i4 : i4
      llhd.drv %rxcnt_bits, %103 after %1 : i4
      cf.br ^bb1
    ^bb15:  // pred: ^bb11
      %104 = comb.icmp ceq %92, %c-6_i4 : i4
      cf.cond_br %104, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      llhd.drv %rxcnt_bits, %c0_i4 after %1 : i4
      cf.br ^bb1
    ^bb17:  // pred: ^bb15
      %105 = llhd.prb %rxcnt_bits : i4
      %106 = comb.add %105, %c1_i4 : i4
      llhd.drv %rxcnt_bits, %106 after %1 : i4
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 9 preds: ^bb0, ^bb4, ^bb5, ^bb8, ^bb9, ^bb12, ^bb13, ^bb15, ^bb16
      llhd.wait (%18, %3 : i2, i4), ^bb2
    ^bb2:  // pred: ^bb1
      %72 = llhd.prb %uart_dbit_6 : i2
      %73 = comb.icmp ceq %72, %c0_i2 : i2
      cf.cond_br %73, ^bb3, ^bb6
    ^bb3:  // pred: ^bb2
      %74 = llhd.prb %rxcnt_bits : i4
      %75 = comb.icmp eq %74, %c5_i4 : i4
      cf.cond_br %75, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %dbit_en, %true after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      llhd.drv %dbit_en, %false after %0 : i1
      cf.br ^bb1
    ^bb6:  // pred: ^bb2
      %76 = comb.icmp ceq %72, %c1_i2 : i2
      cf.cond_br %76, ^bb7, ^bb10
    ^bb7:  // pred: ^bb6
      %77 = llhd.prb %rxcnt_bits : i4
      %78 = comb.icmp eq %77, %c6_i4 : i4
      cf.cond_br %78, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %dbit_en, %true after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      llhd.drv %dbit_en, %false after %0 : i1
      cf.br ^bb1
    ^bb10:  // pred: ^bb6
      %79 = comb.icmp ceq %72, %c-2_i2 : i2
      cf.cond_br %79, ^bb11, ^bb14
    ^bb11:  // pred: ^bb10
      %80 = llhd.prb %rxcnt_bits : i4
      %81 = comb.icmp eq %80, %c7_i4 : i4
      cf.cond_br %81, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      llhd.drv %dbit_en, %true after %0 : i1
      cf.br ^bb1
    ^bb13:  // pred: ^bb11
      llhd.drv %dbit_en, %false after %0 : i1
      cf.br ^bb1
    ^bb14:  // pred: ^bb10
      %82 = llhd.prb %rxcnt_bits : i4
      %83 = comb.icmp eq %82, %c-8_i4 : i4
      cf.cond_br %83, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      llhd.drv %dbit_en, %true after %0 : i1
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      llhd.drv %dbit_en, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_3 : i1
      llhd.wait (%9, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_3 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_3 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rx_en, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %uart_en_8 : i1
      %84 = comb.xor %83, %true : i1
      cf.cond_br %84, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %rx_en, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %85 = llhd.prb %rxcnt_bits : i4
      %86 = comb.icmp eq %85, %c-6_i4 : i4
      %87 = llhd.prb %rxcnt_1bit : i4
      %88 = comb.icmp eq %87, %c7_i4 : i4
      %89 = llhd.prb %rxcnt_div16_eq : i1
      %90 = comb.and %86, %88, %89 : i1
      cf.cond_br %90, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %rx_en, %false after %1 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %91 = llhd.prb %rxcnt_bits : i4
      %92 = comb.icmp eq %91, %c0_i4 : i4
      %93 = llhd.prb %rxcnt_1bit : i4
      %94 = comb.icmp ult %93, %c7_i4 : i4
      %95 = llhd.prb %rxcnt_div16_eq : i1
      %96 = comb.and %92, %94, %95 : i1
      cf.cond_br %96, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %97 = llhd.prb %uart_rxd_14 : i1
      %98 = comb.xor %97, %true : i1
      llhd.drv %rx_en, %98 after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_3 : i1
      llhd.wait (%9, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_3 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_3 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rxcnt_1bit, %c0_i4 after %1 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %uart_en_8 : i1
      %84 = comb.xor %83, %true : i1
      %85 = llhd.prb %uart_rx_end : i1
      %86 = comb.or %84, %85 : i1
      cf.cond_br %86, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %rxcnt_1bit, %c0_i4 after %1 : i4
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %87 = llhd.prb %rxcnt_div16_eq : i1
      cf.cond_br %87, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %88 = llhd.prb %rxcnt_1bit : i4
      %89 = comb.add %88, %c1_i4 : i4
      llhd.drv %rxcnt_1bit, %89 after %1 : i4
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 13 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb7, ^bb9, ^bb11, ^bb13, ^bb15, ^bb17, ^bb19, ^bb21, ^bb22
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_3 : i1
      llhd.wait (%9, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_3 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_3 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rx_shift, %c0_i8 after %1 : i8
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %rxcnt_1bit : i4
      %84 = comb.icmp eq %83, %c7_i4 : i4
      %85 = llhd.prb %rxcnt_div16_eq : i1
      %86 = comb.and %84, %85 : i1
      cf.cond_br %86, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %87 = llhd.prb %rxcnt_bits : i4
      %88 = comb.icmp ceq %87, %c1_i4 : i4
      cf.cond_br %88, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %89 = llhd.sig.extract %rx_shift from %c0_i3 : <i8> -> <i1>
      %90 = llhd.prb %i_rxd_in_2 : i1
      llhd.drv %89, %90 after %1 : i1
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %91 = comb.icmp ceq %87, %c2_i4 : i4
      cf.cond_br %91, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %92 = llhd.sig.extract %rx_shift from %c1_i3 : <i8> -> <i1>
      %93 = llhd.prb %i_rxd_in_2 : i1
      llhd.drv %92, %93 after %1 : i1
      cf.br ^bb1
    ^bb10:  // pred: ^bb8
      %94 = comb.icmp ceq %87, %c3_i4 : i4
      cf.cond_br %94, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %95 = llhd.sig.extract %rx_shift from %c2_i3 : <i8> -> <i1>
      %96 = llhd.prb %i_rxd_in_2 : i1
      llhd.drv %95, %96 after %1 : i1
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      %97 = comb.icmp ceq %87, %c4_i4 : i4
      cf.cond_br %97, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      %98 = llhd.sig.extract %rx_shift from %c3_i3 : <i8> -> <i1>
      %99 = llhd.prb %i_rxd_in_2 : i1
      llhd.drv %98, %99 after %1 : i1
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      %100 = comb.icmp ceq %87, %c5_i4 : i4
      cf.cond_br %100, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      %101 = llhd.sig.extract %rx_shift from %c-4_i3 : <i8> -> <i1>
      %102 = llhd.prb %i_rxd_in_2 : i1
      llhd.drv %101, %102 after %1 : i1
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      %103 = comb.icmp ceq %87, %c6_i4 : i4
      cf.cond_br %103, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      %104 = llhd.sig.extract %rx_shift from %c-3_i3 : <i8> -> <i1>
      %105 = llhd.prb %i_rxd_in_2 : i1
      llhd.drv %104, %105 after %1 : i1
      cf.br ^bb1
    ^bb18:  // pred: ^bb16
      %106 = comb.icmp ceq %87, %c7_i4 : i4
      cf.cond_br %106, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %107 = llhd.sig.extract %rx_shift from %c-2_i3 : <i8> -> <i1>
      %108 = llhd.prb %i_rxd_in_2 : i1
      llhd.drv %107, %108 after %1 : i1
      cf.br ^bb1
    ^bb20:  // pred: ^bb18
      %109 = comb.icmp ceq %87, %c-8_i4 : i4
      cf.cond_br %109, ^bb21, ^bb22
    ^bb21:  // pred: ^bb20
      %110 = llhd.sig.extract %rx_shift from %c-1_i3 : <i8> -> <i1>
      %111 = llhd.prb %i_rxd_in_2 : i1
      llhd.drv %110, %111 after %1 : i1
      cf.br ^bb1
    ^bb22:  // pred: ^bb20
      %112 = llhd.prb %rx_shift : i8
      llhd.drv %rx_shift, %112 after %1 : i8
      cf.br ^bb1
    }
    %56 = comb.icmp eq %53, %c1_i4 : i4
    %57 = comb.and %51, %56, %52 : i1
    llhd.drv %uart_rx_wen, %57 after %0 : i1
    %58 = comb.icmp eq %53, %c-1_i4 : i4
    llhd.drv %rxcnt_1bit_eq, %58 after %0 : i1
    %59 = llhd.prb %rxcnt_div16 : i24
    %60 = comb.icmp eq %59, %33 : i24
    llhd.drv %rxcnt_div16_eq, %60 after %0 : i1
    %61 = llhd.prb %rx_en : i1
    %62 = comb.xor %35, %true : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_3 : i1
      llhd.wait (%9, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_3 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_3 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %uart_stop_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %uart_stop_clr_15 : i1
      %84 = llhd.prb %uart_intr_en_10 : i2
      %85 = comb.extract %84 from 0 : (i2) -> i1
      %86 = comb.xor %85, %true : i1
      %87 = comb.or %83, %86 : i1
      cf.cond_br %87, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %uart_stop_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %88 = llhd.prb %tx_empty_4 : i1
      %89 = llhd.prb %uart_stop_end : i1
      %90 = comb.and %88, %89 : i1
      %91 = llhd.prb %uart_rx_wen : i1
      %92 = comb.or %90, %91 : i1
      cf.cond_br %92, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %uart_stop_intr, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %72 = llhd.prb %clk_0 : i1
      %73 = llhd.prb %rst_n_3 : i1
      llhd.wait (%9, %11 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_n_3 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_n_3 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %uart_perr_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %uart_perr_clr_13 : i1
      %84 = llhd.prb %uart_intr_en_10 : i2
      %85 = comb.extract %84 from 1 : (i2) -> i1
      %86 = comb.xor %85, %true : i1
      %87 = comb.or %83, %86 : i1
      cf.cond_br %87, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %uart_perr_intr, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %88 = llhd.prb %parity_comp : i1
      cf.cond_br %88, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %uart_perr_intr, %true after %1 : i1
      cf.br ^bb1
    }
    %63 = comb.icmp eq %3, %c-7_i4 : i4
    %64 = llhd.prb %uart_eps_9 : i1
    %65 = llhd.prb %parity_check : i1
    %66 = comb.xor %64, %65, %true : i1
    %67 = comb.and %63, %54, %60, %66 : i1
    llhd.drv %parity_comp, %67 after %0 : i1
    llhd.drv %clk_0, %clk after %0 : i1
    llhd.drv %f_rxd_1, %f_rxd after %0 : i1
    llhd.drv %i_rxd_in_2, %i_rxd_in after %0 : i1
    llhd.drv %rst_n_3, %rst_n after %0 : i1
    llhd.drv %tx_empty_4, %tx_empty after %0 : i1
    llhd.drv %tx_rd_data_5, %tx_rd_data after %0 : i8
    %68 = llhd.prb %txd_out : i1
    llhd.drv %uart_dbit_6, %uart_dbit after %0 : i2
    llhd.drv %uart_div_7, %uart_div after %0 : i24
    llhd.drv %uart_en_8, %uart_en after %0 : i1
    llhd.drv %uart_eps_9, %uart_eps after %0 : i1
    llhd.drv %uart_intr_en_10, %uart_intr_en after %0 : i2
    llhd.drv %uart_pbit_11, %uart_pbit after %0 : i2
    llhd.drv %uart_pen_12, %uart_pen after %0 : i1
    llhd.drv %uart_perr_clr_13, %uart_perr_clr after %0 : i1
    %69 = llhd.prb %uart_perr_intr : i1
    %70 = llhd.prb %uart_rx_wen : i1
    llhd.drv %uart_rxd_14, %uart_rxd after %0 : i1
    llhd.drv %uart_stop_clr_15, %uart_stop_clr after %0 : i1
    %71 = llhd.prb %uart_stop_intr : i1
    hw.output %2, %61, %68, %62, %69, %70, %71, %43 : i8, i1, i1, i1, i1, i1, i1, i1
  }
  hw.module private @usi_top(in %clk : i1, in %dma_ack_rx : i1, in %dma_ack_tx : i1, out dma_req_rx : i1, out dma_req_tx : i1, out nss_ie_n : i1, in %nss_in : i1, out nss_oe_n : i1, out nss_out : i1, in %paddr : i32, in %penable : i1, out prdata : i32, in %psel : i1, in %pwdata : i32, in %pwrite : i1, in %rst_n : i1, out sclk_ie_n : i1, in %sclk_in : i1, out sclk_oe_n : i1, out sclk_out : i1, out sd0_ie_n : i1, in %sd0_in : i1, out sd0_oe_n : i1, out sd0_out : i1, out sd1_ie_n : i1, in %sd1_in : i1, out sd1_oe_n : i1, out sd1_out : i1, out usi_etb_rx_trig : i1, out usi_etb_tx_trig : i1, out usi_intr : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %c0_i5 = hw.constant 0 : i5
    %c0_i16 = hw.constant 0 : i16
    %c1_i5 = hw.constant 1 : i5
    %true = hw.constant true
    %false = hw.constant false
    %c0_i8 = hw.constant 0 : i8
    %dma_req_rx = llhd.sig %false : i1
    %dma_req_tx = llhd.sig %false : i1
    %set_rx_req_trig_dly = llhd.sig %false : i1
    %set_tx_req_trig_dly = llhd.sig %false : i1
    %tx_rd_data = llhd.sig %c0_i16 : i16
    %tx_ren_d = llhd.sig %false : i1
    %tx_wen_d = llhd.sig %false : i1
    %usi_etb_rx_trig = llhd.sig %false : i1
    %usi_etb_tx_trig = llhd.sig %false : i1
    %clk_0 = llhd.sig name "clk" %false : i1
    %2 = llhd.prb %clk_0 : i1
    %dma_ack_rx_1 = llhd.sig name "dma_ack_rx" %false : i1
    %dma_ack_tx_2 = llhd.sig name "dma_ack_tx" %false : i1
    %rst_n_3 = llhd.sig name "rst_n" %false : i1
    %3 = llhd.prb %rst_n_3 : i1
    %rx_data_cnt = llhd.sig %c0_i5 : i5
    %rx_dma_en = llhd.sig %false : i1
    %rx_dma_th = llhd.sig %c0_i5 : i5
    %rx_rd_data = llhd.sig %c0_i16 : i16
    %rx_wr_data = llhd.sig %c0_i16 : i16
    %set_rx_req_trig = llhd.sig %false : i1
    %set_rx_req_trig_psdg = llhd.sig %false : i1
    %set_tx_req_trig = llhd.sig %false : i1
    %set_tx_req_trig_psdg = llhd.sig %false : i1
    %spi_rx = llhd.sig %c0_i16 : i16
    %tx_data_cnt = llhd.sig %c0_i5 : i5
    %tx_dma_en = llhd.sig %false : i1
    %tx_dma_th = llhd.sig %c0_i5 : i5
    %tx_fifo_en = llhd.sig %false : i1
    %tx_fifo_latch_en = llhd.sig %false : i1
    %tx_rd_data_tmp = llhd.sig %c0_i16 : i16
    %tx_ren = llhd.sig %false : i1
    %tx_wen = llhd.sig %false : i1
    %uart_rx = llhd.sig %c0_i8 : i8
    %usi_ctrl = llhd.sig %c0_i4 : i4
    %4 = llhd.prb %tx_rd_data : i16
    %5 = comb.extract %4 from 0 : (i16) -> i8
    %x_uart.rx_shift, %x_uart.rxd_work, %x_uart.txd_out, %x_uart.txd_work, %x_uart.uart_perr_intr, %x_uart.uart_rx_wen, %x_uart.uart_stop_intr, %x_uart.uart_tx_ren = hw.instance "x_uart" @uart(clk: %2: i1, f_rxd: %x_sdata_if.f_rxd: i1, i_rxd_in: %x_sdata_if.i_scl_in: i1, rst_n: %3: i1, tx_empty: %x_tx_sync_fifo_16x16.empty: i1, tx_rd_data: %5: i8, uart_dbit: %x_apb_if.uart_dbit: i2, uart_div: %x_apb_if.uart_div: i24, uart_en: %x_apb_if.uart_en: i1, uart_eps: %x_apb_if.uart_eps: i1, uart_intr_en: %x_apb_if.uart_intr_en: i2, uart_pbit: %x_apb_if.uart_pbit: i2, uart_pen: %x_apb_if.uart_pen: i1, uart_perr_clr: %x_apb_if.uart_perr_clr: i1, uart_rxd: %x_sdata_if.i_scl_in: i1, uart_stop_clr: %x_apb_if.uart_stop_clr: i1) -> (rx_shift: i8, rxd_work: i1, txd_out: i1, txd_work: i1, uart_perr_intr: i1, uart_rx_wen: i1, uart_stop_intr: i1, uart_tx_ren: i1) {sv.namehint = "txd_out"}
    llhd.drv %uart_rx, %x_uart.rx_shift after %1 : i8
    %6 = comb.extract %x_sdata_if.r_scl_d from 1 : (i3) -> i2
    %7 = comb.extract %4 from 0 : (i16) -> i10
    %x_i2c_top.i2c_nack_intr, %x_i2c_top.i2c_rx, %x_i2c_top.i2c_rx_wen, %x_i2c_top.i2c_stop_intr, %x_i2c_top.i2c_tx_ren, %x_i2c_top.i2cm_aerr_intr, %x_i2c_top.i2cm_data, %x_i2c_top.i2cm_lose_arbi_intr, %x_i2c_top.i2cm_work, %x_i2c_top.i2cs_gcall_intr, %x_i2c_top.i2cs_work, %x_i2c_top.scl_out, %x_i2c_top.sda_out = hw.instance "x_i2c_top" @i2c_top(clk: %2: i1, f_scl: %x_sdata_if.f_scl: i1, f_scl_d: %x_sdata_if.f_scl_d: i3, f_sda: %x_sdata_if.f_sda: i1, i2c_addr: %x_apb_if.i2c_addr: i10, i2c_aerr_clr: %x_apb_if.i2c_aerr_clr: i1, i2c_fs_div: %x_apb_if.i2c_fs_div: i8, i2c_hcnt: %x_apb_if.i2c_hcnt: i24, i2c_hold: %x_apb_if.i2c_hold: i8, i2c_intr_en: %x_apb_if.i2c_intr_en: i5, i2c_lcnt: %x_apb_if.i2c_lcnt: i24, i2c_mode: %x_apb_if.i2c_mode: i1, i2c_nack_clr: %x_apb_if.i2c_nack_clr: i1, i2c_stop_clr: %x_apb_if.i2c_stop_clr: i1, i2cm_amode: %x_apb_if.i2cm_amode: i1, i2cm_code: %x_apb_if.i2cm_code: i3, i2cm_en: %x_apb_if.i2cm_en: i1, i2cm_gcall: %x_apb_if.i2cm_gcall: i1, i2cm_hs: %x_apb_if.i2cm_hs: i1, i2cm_lose_arbi_clr: %x_apb_if.i2cm_lose_arbi_clr: i1, i2cm_sbyte: %x_apb_if.i2cm_sbyte: i1, i2cm_stop: %x_apb_if.i2cm_stop: i1, i2cs_amode: %x_apb_if.i2cs_amode: i1, i2cs_en: %x_apb_if.i2cs_en: i1, i2cs_gcall: %x_apb_if.i2cs_gcall: i1, i2cs_gcall_clr: %x_apb_if.i2cs_gcall_clr: i1, i2cs_hs: %x_apb_if.i2cs_hs: i1, i2cs_sbyte: %x_apb_if.i2cs_sbyte: i1, i2cs_tx_data: %5: i8, i_scl_in: %x_sdata_if.i_scl_in: i1, i_sda_in: %x_sdata_if.i_sda_in: i1, r_scl: %x_sdata_if.r_scl: i1, r_scl_d: %6: i2, r_sda: %x_sdata_if.r_sda: i1, rst_n: %3: i1, rx_full: %x_rx_sync_fifo_16x16.full: i1, tx_empty: %x_tx_sync_fifo_16x16.empty: i1, tx_empty_d: %x_tx_sync_fifo_16x16.empty_d: i1, tx_rd_data: %7: i10, wr_clk_div: %x_apb_if.wr_clk_div: i1) -> (i2c_nack_intr: i1, i2c_rx: i8, i2c_rx_wen: i1, i2c_stop_intr: i1, i2c_tx_ren: i1, i2cm_aerr_intr: i1, i2cm_data: i1, i2cm_lose_arbi_intr: i1, i2cm_work: i1, i2cs_gcall_intr: i1, i2cs_work: i1, scl_out: i1, sda_out: i1) {sv.namehint = "i2c_rx"}
    %8 = comb.extract %x_apb_if.clk_div0 from 1 : (i24) -> i23
    %x_spi.rx_wr_data, %x_spi.spi_mo, %x_spi.spi_rx_wen, %x_spi.spi_so, %x_spi.spi_stop_intr, %x_spi.spi_tx_ren, %x_spi.spi_work, %x_spi.spim_nss, %x_spi.spim_sck = hw.instance "x_spi" @spi(clk: %2: i1, clk_div0: %8: i23, cpha: %x_apb_if.cpha: i1, cpol: %x_apb_if.cpol: i1, f_nss: %x_sdata_if.f_nss: i1, f_sclk: %x_sdata_if.f_scl: i1, i_nss_in: %x_sdata_if.i_nss_in: i1, nss_toggle: %x_apb_if.nss_toggle: i1, r_sclk: %x_sdata_if.r_scl: i1, rst_n: %3: i1, rx_full: %x_rx_sync_fifo_16x16.full: i1, spi_data_size: %x_apb_if.spi_data_size: i4, spi_intr_en: %x_apb_if.spi_intr_en: i1, spi_mi: %x_sdata_if.i_sd1_in: i1, spi_rx_en: %x_apb_if.spi_rx_en: i1, spi_si: %x_sdata_if.i_sda_in: i1, spi_stop_clr: %x_apb_if.spi_stop_clr: i1, spi_tx_en: %x_apb_if.spi_tx_en: i1, spim_en: %x_apb_if.spim_en: i1, spis_en: %x_apb_if.spis_en: i1, tx_empty: %x_tx_sync_fifo_16x16.empty: i1, tx_rd_data: %4: i16) -> (rx_wr_data: i16, spi_mo: i1, spi_rx_wen: i1, spi_so: i1, spi_stop_intr: i1, spi_tx_ren: i1, spi_work: i1, spim_nss: i1, spim_sck: i1) {sv.namehint = "spi_so"}
    llhd.drv %spi_rx, %x_spi.rx_wr_data after %1 : i16
    %x_sdata_if.f_nss, %x_sdata_if.f_rxd, %x_sdata_if.f_scl, %x_sdata_if.f_scl_d, %x_sdata_if.f_sda, %x_sdata_if.i_nss_in, %x_sdata_if.i_scl_in, %x_sdata_if.i_sd1_in, %x_sdata_if.i_sda_in, %x_sdata_if.nss_ie_n, %x_sdata_if.nss_oe_n, %x_sdata_if.nss_out, %x_sdata_if.r_scl, %x_sdata_if.r_scl_d, %x_sdata_if.r_sda, %x_sdata_if.sclk_ie_n, %x_sdata_if.sclk_oe_n, %x_sdata_if.sclk_out, %x_sdata_if.sd0_ie_n, %x_sdata_if.sd0_oe_n, %x_sdata_if.sd0_out, %x_sdata_if.sd1_ie_n, %x_sdata_if.sd1_oe_n, %x_sdata_if.sd1_out = hw.instance "x_sdata_if" @sdata_if(clk: %2: i1, i2c_en: %x_apb_if.i2c_en: i1, i2c_mode: %x_apb_if.i2c_mode: i1, i2cm_en: %x_apb_if.i2cm_en: i1, i2cs_en: %x_apb_if.i2cs_en: i1, nss_in: %nss_in: i1, rst_n: %3: i1, scl_out: %x_i2c_top.scl_out: i1, sclk_in: %sclk_in: i1, sd0_in: %sd0_in: i1, sd1_in: %sd1_in: i1, sda_out: %x_i2c_top.sda_out: i1, sdata_en: %x_apb_if.sdata_en: i1, spi_mo: %x_spi.spi_mo: i1, spi_rx_en: %x_apb_if.spi_rx_en: i1, spi_so: %x_spi.spi_so: i1, spim_en: %x_apb_if.spim_en: i1, spim_nss: %x_spi.spim_nss: i1, spim_sck: %x_spi.spim_sck: i1, spis_en: %x_apb_if.spis_en: i1, txd_out: %x_uart.txd_out: i1, uart_en: %x_apb_if.uart_en: i1) -> (f_nss: i1, f_rxd: i1, f_scl: i1, f_scl_d: i3, f_sda: i1, i_nss_in: i1, i_scl_in: i1, i_sd1_in: i1, i_sda_in: i1, nss_ie_n: i1, nss_oe_n: i1, nss_out: i1, r_scl: i1, r_scl_d: i3, r_sda: i1, sclk_ie_n: i1, sclk_oe_n: i1, sclk_out: i1, sd0_ie_n: i1, sd0_oe_n: i1, sd0_out: i1, sd1_ie_n: i1, sd1_oe_n: i1, sd1_out: i1) {sv.namehint = "r_sda"}
    %9 = llhd.prb %rx_data_cnt : i5
    %10 = llhd.prb %rx_rd_data : i16
    %11 = llhd.prb %tx_data_cnt : i5
    %x_apb_if.clk_div0, %x_apb_if.cpha, %x_apb_if.cpol, %x_apb_if.fifo_intr_en, %x_apb_if.i2c_addr, %x_apb_if.i2c_aerr_clr, %x_apb_if.i2c_en, %x_apb_if.i2c_fs_div, %x_apb_if.i2c_hcnt, %x_apb_if.i2c_hold, %x_apb_if.i2c_intr_en, %x_apb_if.i2c_lcnt, %x_apb_if.i2c_mode, %x_apb_if.i2c_nack_clr, %x_apb_if.i2c_stop_clr, %x_apb_if.i2cm_amode, %x_apb_if.i2cm_code, %x_apb_if.i2cm_en, %x_apb_if.i2cm_gcall, %x_apb_if.i2cm_hs, %x_apb_if.i2cm_lose_arbi_clr, %x_apb_if.i2cm_sbyte, %x_apb_if.i2cm_stop, %x_apb_if.i2cs_amode, %x_apb_if.i2cs_en, %x_apb_if.i2cs_gcall, %x_apb_if.i2cs_gcall_clr, %x_apb_if.i2cs_hs, %x_apb_if.i2cs_sbyte, %x_apb_if.intr_edge, %x_apb_if.nss_toggle, %x_apb_if.prdata, %x_apb_if.rx_dma_en, %x_apb_if.rx_dma_th, %x_apb_if.rx_empty_clr, %x_apb_if.rx_fifo_en, %x_apb_if.rx_fifo_th, %x_apb_if.rx_full_clr, %x_apb_if.rx_read_err_clr, %x_apb_if.rx_ren, %x_apb_if.rx_thold_clr, %x_apb_if.rx_write_err_clr, %x_apb_if.sdata_en, %x_apb_if.spi_data_size, %x_apb_if.spi_en, %x_apb_if.spi_intr_en, %x_apb_if.spi_rx_en, %x_apb_if.spi_stop_clr, %x_apb_if.spi_tx_en, %x_apb_if.spim_en, %x_apb_if.spis_en, %x_apb_if.tx_dma_en, %x_apb_if.tx_dma_th, %x_apb_if.tx_empty_clr, %x_apb_if.tx_fifo_en, %x_apb_if.tx_fifo_th, %x_apb_if.tx_full_clr, %x_apb_if.tx_read_err_clr, %x_apb_if.tx_thold_clr, %x_apb_if.tx_wen, %x_apb_if.tx_write_err_clr, %x_apb_if.uart_dbit, %x_apb_if.uart_div, %x_apb_if.uart_en, %x_apb_if.uart_eps, %x_apb_if.uart_intr_en, %x_apb_if.uart_pbit, %x_apb_if.uart_pen, %x_apb_if.uart_perr_clr, %x_apb_if.uart_stop_clr, %x_apb_if.usi_ctrl, %x_apb_if.usi_intr, %x_apb_if.wr_clk_div = hw.instance "x_apb_if" @apb_if(clk: %2: i1, i2c_aerr_intr: %x_i2c_top.i2cm_aerr_intr: i1, i2c_nack_intr: %x_i2c_top.i2c_nack_intr: i1, i2c_stop_intr: %x_i2c_top.i2c_stop_intr: i1, i2cm_data: %x_i2c_top.i2cm_data: i1, i2cm_lose_arbi_intr: %x_i2c_top.i2cm_lose_arbi_intr: i1, i2cm_work: %x_i2c_top.i2cm_work: i1, i2cs_gcall_intr: %x_i2c_top.i2cs_gcall_intr: i1, i2cs_work: %x_i2c_top.i2cs_work: i1, paddr: %paddr: i32, penable: %penable: i1, psel: %psel: i1, pwdata: %pwdata: i32, pwrite: %pwrite: i1, rst_n: %3: i1, rx_data_cnt: %9: i5, rx_empty: %x_rx_sync_fifo_16x16.empty: i1, rx_empty_intr: %x_rx_sync_fifo_16x16.empty_intr: i1, rx_full: %x_rx_sync_fifo_16x16.full: i1, rx_full_intr: %x_rx_sync_fifo_16x16.full_intr: i1, rx_rd_data: %10: i16, rx_read_err_intr: %x_rx_sync_fifo_16x16.read_err_intr: i1, rx_thold_intr: %x_rx_sync_fifo_16x16.thold_intr: i1, rx_write_err_intr: %x_rx_sync_fifo_16x16.write_err_intr: i1, rxd_work: %x_uart.rxd_work: i1, spi_stop_intr: %x_spi.spi_stop_intr: i1, spi_work: %x_spi.spi_work: i1, tx_data_cnt: %11: i5, tx_empty: %x_tx_sync_fifo_16x16.empty: i1, tx_empty_intr: %x_tx_sync_fifo_16x16.empty_intr: i1, tx_full: %x_tx_sync_fifo_16x16.full: i1, tx_full_intr: %x_tx_sync_fifo_16x16.full_intr: i1, tx_read_err_intr: %x_tx_sync_fifo_16x16.read_err_intr: i1, tx_thold_intr: %x_tx_sync_fifo_16x16.thold_intr: i1, tx_write_err_intr: %x_tx_sync_fifo_16x16.write_err_intr: i1, txd_work: %x_uart.txd_work: i1, uart_perr_intr: %x_uart.uart_perr_intr: i1, uart_stop_intr: %x_uart.uart_stop_intr: i1) -> (clk_div0: i24, cpha: i1, cpol: i1, fifo_intr_en: i10, i2c_addr: i10, i2c_aerr_clr: i1, i2c_en: i1, i2c_fs_div: i8, i2c_hcnt: i24, i2c_hold: i8, i2c_intr_en: i5, i2c_lcnt: i24, i2c_mode: i1, i2c_nack_clr: i1, i2c_stop_clr: i1, i2cm_amode: i1, i2cm_code: i3, i2cm_en: i1, i2cm_gcall: i1, i2cm_hs: i1, i2cm_lose_arbi_clr: i1, i2cm_sbyte: i1, i2cm_stop: i1, i2cs_amode: i1, i2cs_en: i1, i2cs_gcall: i1, i2cs_gcall_clr: i1, i2cs_hs: i1, i2cs_sbyte: i1, intr_edge: i1, nss_toggle: i1, prdata: i32, rx_dma_en: i1, rx_dma_th: i5, rx_empty_clr: i1, rx_fifo_en: i1, rx_fifo_th: i2, rx_full_clr: i1, rx_read_err_clr: i1, rx_ren: i1, rx_thold_clr: i1, rx_write_err_clr: i1, sdata_en: i1, spi_data_size: i4, spi_en: i1, spi_intr_en: i1, spi_rx_en: i1, spi_stop_clr: i1, spi_tx_en: i1, spim_en: i1, spis_en: i1, tx_dma_en: i1, tx_dma_th: i5, tx_empty_clr: i1, tx_fifo_en: i1, tx_fifo_th: i2, tx_full_clr: i1, tx_read_err_clr: i1, tx_thold_clr: i1, tx_wen: i1, tx_write_err_clr: i1, uart_dbit: i2, uart_div: i24, uart_en: i1, uart_eps: i1, uart_intr_en: i2, uart_pbit: i2, uart_pen: i1, uart_perr_clr: i1, uart_stop_clr: i1, usi_ctrl: i4, usi_intr: i1, wr_clk_div: i1) {sv.namehint = "cpol"}
    llhd.drv %rx_dma_en, %x_apb_if.rx_dma_en after %1 : i1
    llhd.drv %rx_dma_th, %x_apb_if.rx_dma_th after %1 : i5
    llhd.drv %tx_dma_en, %x_apb_if.tx_dma_en after %1 : i1
    llhd.drv %tx_dma_th, %x_apb_if.tx_dma_th after %1 : i5
    llhd.drv %tx_fifo_en, %x_apb_if.tx_fifo_en after %1 : i1
    llhd.drv %tx_wen, %x_apb_if.tx_wen after %1 : i1
    llhd.drv %usi_ctrl, %x_apb_if.usi_ctrl after %1 : i4
    %12 = llhd.prb %tx_fifo_en : i1
    %13 = comb.extract %x_apb_if.fifo_intr_en from 0 : (i10) -> i5
    %14 = llhd.prb %tx_ren : i1
    %15 = comb.extract %pwdata from 0 : (i32) -> i16
    %16 = llhd.prb %tx_wen : i1
    %x_tx_sync_fifo_16x16.empty, %x_tx_sync_fifo_16x16.empty_d, %x_tx_sync_fifo_16x16.empty_intr, %x_tx_sync_fifo_16x16.flag_counter, %x_tx_sync_fifo_16x16.full, %x_tx_sync_fifo_16x16.full_intr, %x_tx_sync_fifo_16x16.rd_data, %x_tx_sync_fifo_16x16.read_err_intr, %x_tx_sync_fifo_16x16.thold_intr, %x_tx_sync_fifo_16x16.write_err_intr = hw.instance "x_tx_sync_fifo_16x16" @sync_fifo_16x16(clk: %2: i1, empty_clr: %x_apb_if.tx_empty_clr: i1, fifo_en: %12: i1, fifo_intr_en: %13: i5, fifo_thold: %x_apb_if.tx_fifo_th: i2, full_clr: %x_apb_if.tx_full_clr: i1, intr_edge: %x_apb_if.intr_edge: i1, rd_en: %14: i1, read_err_clr: %x_apb_if.tx_read_err_clr: i1, rst_n: %3: i1, thold_clr: %x_apb_if.tx_thold_clr: i1, wr_data: %15: i16, wr_en: %16: i1, write_err_clr: %x_apb_if.tx_write_err_clr: i1) -> (empty: i1, empty_d: i1, empty_intr: i1, flag_counter: i5, full: i1, full_intr: i1, rd_data: i16, read_err_intr: i1, thold_intr: i1, write_err_intr: i1) {sv.namehint = "tx_full"}
    llhd.drv %tx_data_cnt, %x_tx_sync_fifo_16x16.flag_counter after %1 : i5
    llhd.drv %tx_rd_data_tmp, %x_tx_sync_fifo_16x16.rd_data after %1 : i16
    %17 = comb.extract %x_apb_if.fifo_intr_en from 5 : (i10) -> i5
    %18 = llhd.prb %rx_wr_data : i16
    %x_rx_sync_fifo_16x16.empty, %x_rx_sync_fifo_16x16.empty_d, %x_rx_sync_fifo_16x16.empty_intr, %x_rx_sync_fifo_16x16.flag_counter, %x_rx_sync_fifo_16x16.full, %x_rx_sync_fifo_16x16.full_intr, %x_rx_sync_fifo_16x16.rd_data, %x_rx_sync_fifo_16x16.read_err_intr, %x_rx_sync_fifo_16x16.thold_intr, %x_rx_sync_fifo_16x16.write_err_intr = hw.instance "x_rx_sync_fifo_16x16" @sync_fifo_16x16(clk: %2: i1, empty_clr: %x_apb_if.rx_empty_clr: i1, fifo_en: %x_apb_if.rx_fifo_en: i1, fifo_intr_en: %17: i5, fifo_thold: %x_apb_if.rx_fifo_th: i2, full_clr: %x_apb_if.rx_full_clr: i1, intr_edge: %x_apb_if.intr_edge: i1, rd_en: %x_apb_if.rx_ren: i1, read_err_clr: %x_apb_if.rx_read_err_clr: i1, rst_n: %3: i1, thold_clr: %x_apb_if.rx_thold_clr: i1, wr_data: %18: i16, wr_en: %33: i1, write_err_clr: %x_apb_if.rx_write_err_clr: i1) -> (empty: i1, empty_d: i1, empty_intr: i1, flag_counter: i5, full: i1, full_intr: i1, rd_data: i16, read_err_intr: i1, thold_intr: i1, write_err_intr: i1) {sv.namehint = "rx_full"}
    llhd.drv %rx_data_cnt, %x_rx_sync_fifo_16x16.flag_counter after %1 : i5
    llhd.drv %rx_rd_data, %x_rx_sync_fifo_16x16.rd_data after %1 : i16
    %19 = comb.replicate %x_apb_if.uart_en : (i1) -> i8
    %20 = llhd.prb %uart_rx : i8
    %21 = comb.and %19, %20 : i8
    %22 = comb.concat %c0_i8, %21 : i8, i8
    %23 = comb.replicate %x_apb_if.i2c_en : (i1) -> i8
    %24 = comb.and %23, %x_i2c_top.i2c_rx : i8
    %25 = comb.concat %c0_i8, %24 : i8, i8
    %26 = comb.replicate %x_apb_if.spi_en : (i1) -> i16
    %27 = llhd.prb %spi_rx : i16
    %28 = comb.and %26, %27 : i16
    %29 = comb.or %22, %25, %28 : i16
    llhd.drv %rx_wr_data, %29 after %1 : i16
    %30 = comb.and %x_apb_if.uart_en, %x_uart.uart_rx_wen : i1
    %31 = comb.and %x_apb_if.i2c_en, %x_i2c_top.i2c_rx_wen : i1
    %32 = comb.and %x_apb_if.spi_en, %x_spi.spi_rx_wen : i1
    %33 = comb.or %30, %31, %32 {sv.namehint = "rx_wen"} : i1
    %34 = comb.and %x_apb_if.uart_en, %x_uart.uart_tx_ren : i1
    %35 = comb.and %x_apb_if.i2c_en, %x_i2c_top.i2c_tx_ren : i1
    %36 = comb.and %x_apb_if.spi_en, %x_spi.spi_tx_ren : i1
    %37 = comb.or %34, %35, %36 : i1
    llhd.drv %tx_ren, %37 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %61 = llhd.prb %clk_0 : i1
      %62 = llhd.prb %rst_n_3 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %63 = llhd.prb %clk_0 : i1
      %64 = comb.xor bin %61, %true : i1
      %65 = comb.and bin %64, %63 : i1
      %66 = llhd.prb %rst_n_3 : i1
      %67 = comb.xor bin %66, %true : i1
      %68 = comb.and bin %62, %67 : i1
      %69 = comb.or bin %65, %68 : i1
      cf.cond_br %69, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %70 = llhd.prb %rst_n_3 : i1
      %71 = comb.xor %70, %true : i1
      cf.cond_br %71, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %tx_wen_d, %false after %0 : i1
      llhd.drv %tx_ren_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %72 = llhd.prb %tx_fifo_en : i1
      %73 = comb.xor %72, %true : i1
      cf.cond_br %73, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %tx_wen_d, %false after %0 : i1
      llhd.drv %tx_ren_d, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %74 = llhd.prb %tx_wen : i1
      llhd.drv %tx_wen_d, %74 after %0 : i1
      %75 = llhd.prb %tx_ren : i1
      llhd.drv %tx_ren_d, %75 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
      %61 = llhd.prb %clk_0 : i1
      llhd.wait (%2 : i1), ^bb2
    ^bb2:  // pred: ^bb1
      %62 = llhd.prb %clk_0 : i1
      %63 = comb.xor bin %61, %true : i1
      %64 = comb.and bin %63, %62 : i1
      cf.cond_br %64, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %65 = llhd.prb %tx_fifo_latch_en : i1
      cf.cond_br %65, ^bb4, ^bb1
    ^bb4:  // pred: ^bb3
      %66 = llhd.prb %tx_rd_data_tmp : i16
      llhd.drv %tx_rd_data, %66 after %0 : i16
      cf.br ^bb1
    }
    %38 = llhd.prb %tx_wen_d : i1
    %39 = llhd.prb %tx_ren_d : i1
    %40 = comb.or %38, %39 : i1
    llhd.drv %tx_fifo_latch_en, %40 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb10, ^bb11, ^bb12
      %61 = llhd.prb %clk_0 : i1
      %62 = llhd.prb %rst_n_3 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %63 = llhd.prb %clk_0 : i1
      %64 = comb.xor bin %61, %true : i1
      %65 = comb.and bin %64, %63 : i1
      %66 = llhd.prb %rst_n_3 : i1
      %67 = comb.xor bin %66, %true : i1
      %68 = comb.and bin %62, %67 : i1
      %69 = comb.or bin %65, %68 : i1
      cf.cond_br %69, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %70 = llhd.prb %rst_n_3 : i1
      %71 = comb.xor %70, %true : i1
      cf.cond_br %71, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %dma_req_rx, %false after %0 : i1
      llhd.drv %dma_req_tx, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %72 = llhd.prb %rx_dma_en : i1
      %73 = comb.xor %72, %true : i1
      %74 = llhd.prb %dma_ack_rx_1 : i1
      %75 = comb.or %73, %74 : i1
      cf.cond_br %75, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %dma_req_rx, %false after %0 : i1
      cf.br ^bb9
    ^bb7:  // pred: ^bb5
      %76 = llhd.prb %rx_dma_th : i5
      %77 = llhd.prb %rx_data_cnt : i5
      %78 = comb.icmp ule %76, %77 : i5
      cf.cond_br %78, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %dma_req_rx, %true after %0 : i1
      cf.br ^bb9
    ^bb9:  // 3 preds: ^bb6, ^bb7, ^bb8
      %79 = llhd.prb %tx_dma_en : i1
      %80 = comb.xor %79, %true : i1
      %81 = llhd.prb %dma_ack_tx_2 : i1
      %82 = comb.or %80, %81 : i1
      cf.cond_br %82, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      llhd.drv %dma_req_tx, %false after %0 : i1
      cf.br ^bb1
    ^bb11:  // pred: ^bb9
      %83 = llhd.prb %tx_dma_th : i5
      %84 = llhd.prb %tx_data_cnt : i5
      %85 = comb.icmp uge %83, %84 : i5
      cf.cond_br %85, ^bb12, ^bb1
    ^bb12:  // pred: ^bb11
      llhd.drv %dma_req_tx, %true after %0 : i1
      cf.br ^bb1
    }
    %41 = llhd.prb %rx_dma_th : i5
    %42 = comb.add %41, %c1_i5 : i5
    %43 = comb.icmp ule %42, %9 : i5
    %44 = llhd.prb %usi_ctrl : i4
    %45 = comb.extract %44 from 0 : (i4) -> i1
    %46 = comb.and %43, %45 : i1
    llhd.drv %set_rx_req_trig, %46 after %1 : i1
    %47 = comb.icmp eq %11, %c0_i5 : i5
    %48 = comb.and %47, %45 : i1
    llhd.drv %set_tx_req_trig, %48 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %61 = llhd.prb %clk_0 : i1
      %62 = llhd.prb %rst_n_3 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %63 = llhd.prb %clk_0 : i1
      %64 = comb.xor bin %61, %true : i1
      %65 = comb.and bin %64, %63 : i1
      %66 = llhd.prb %rst_n_3 : i1
      %67 = comb.xor bin %66, %true : i1
      %68 = comb.and bin %62, %67 : i1
      %69 = comb.or bin %65, %68 : i1
      cf.cond_br %69, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %70 = llhd.prb %rst_n_3 : i1
      %71 = comb.xor %70, %true : i1
      cf.cond_br %71, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %set_rx_req_trig_dly, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %72 = llhd.prb %set_rx_req_trig : i1
      llhd.drv %set_rx_req_trig_dly, %72 after %0 : i1
      cf.br ^bb1
    }
    %49 = llhd.prb %set_rx_req_trig : i1
    %50 = llhd.prb %set_rx_req_trig_dly : i1
    %51 = comb.xor %50, %true : i1
    %52 = comb.and %49, %51 : i1
    llhd.drv %set_rx_req_trig_psdg, %52 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %61 = llhd.prb %clk_0 : i1
      %62 = llhd.prb %rst_n_3 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %63 = llhd.prb %clk_0 : i1
      %64 = comb.xor bin %61, %true : i1
      %65 = comb.and bin %64, %63 : i1
      %66 = llhd.prb %rst_n_3 : i1
      %67 = comb.xor bin %66, %true : i1
      %68 = comb.and bin %62, %67 : i1
      %69 = comb.or bin %65, %68 : i1
      cf.cond_br %69, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %70 = llhd.prb %rst_n_3 : i1
      %71 = comb.xor %70, %true : i1
      cf.cond_br %71, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %set_tx_req_trig_dly, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %72 = llhd.prb %set_tx_req_trig : i1
      llhd.drv %set_tx_req_trig_dly, %72 after %0 : i1
      cf.br ^bb1
    }
    %53 = llhd.prb %set_tx_req_trig : i1
    %54 = llhd.prb %set_tx_req_trig_dly : i1
    %55 = comb.xor %54, %true : i1
    %56 = comb.and %53, %55 : i1
    llhd.drv %set_tx_req_trig_psdg, %56 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %61 = llhd.prb %clk_0 : i1
      %62 = llhd.prb %rst_n_3 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %63 = llhd.prb %clk_0 : i1
      %64 = comb.xor bin %61, %true : i1
      %65 = comb.and bin %64, %63 : i1
      %66 = llhd.prb %rst_n_3 : i1
      %67 = comb.xor bin %66, %true : i1
      %68 = comb.and bin %62, %67 : i1
      %69 = comb.or bin %65, %68 : i1
      cf.cond_br %69, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %70 = llhd.prb %rst_n_3 : i1
      %71 = comb.xor %70, %true : i1
      cf.cond_br %71, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %usi_etb_rx_trig, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %72 = llhd.prb %usi_ctrl : i4
      %73 = comb.extract %72 from 0 : (i4) -> i1
      %74 = comb.xor %73, %true : i1
      cf.cond_br %74, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %usi_etb_rx_trig, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %75 = llhd.prb %usi_etb_rx_trig : i1
      cf.cond_br %75, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %usi_etb_rx_trig, %false after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %76 = llhd.prb %set_rx_req_trig_psdg : i1
      cf.cond_br %76, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      llhd.drv %usi_etb_rx_trig, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %61 = llhd.prb %clk_0 : i1
      %62 = llhd.prb %rst_n_3 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %63 = llhd.prb %clk_0 : i1
      %64 = comb.xor bin %61, %true : i1
      %65 = comb.and bin %64, %63 : i1
      %66 = llhd.prb %rst_n_3 : i1
      %67 = comb.xor bin %66, %true : i1
      %68 = comb.and bin %62, %67 : i1
      %69 = comb.or bin %65, %68 : i1
      cf.cond_br %69, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %70 = llhd.prb %rst_n_3 : i1
      %71 = comb.xor %70, %true : i1
      cf.cond_br %71, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %usi_etb_tx_trig, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %72 = llhd.prb %usi_ctrl : i4
      %73 = comb.extract %72 from 0 : (i4) -> i1
      %74 = comb.xor %73, %true : i1
      cf.cond_br %74, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %usi_etb_tx_trig, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %75 = llhd.prb %usi_etb_tx_trig : i1
      cf.cond_br %75, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %usi_etb_tx_trig, %false after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %76 = llhd.prb %set_tx_req_trig_psdg : i1
      cf.cond_br %76, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      llhd.drv %usi_etb_tx_trig, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_0, %clk after %1 : i1
    llhd.drv %dma_ack_rx_1, %dma_ack_rx after %1 : i1
    llhd.drv %dma_ack_tx_2, %dma_ack_tx after %1 : i1
    %57 = llhd.prb %dma_req_rx : i1
    %58 = llhd.prb %dma_req_tx : i1
    llhd.drv %rst_n_3, %rst_n after %1 : i1
    %59 = llhd.prb %usi_etb_rx_trig : i1
    %60 = llhd.prb %usi_etb_tx_trig : i1
    hw.output %57, %58, %x_sdata_if.nss_ie_n, %x_sdata_if.nss_oe_n, %x_sdata_if.nss_out, %x_apb_if.prdata, %x_sdata_if.sclk_ie_n, %x_sdata_if.sclk_oe_n, %x_sdata_if.sclk_out, %x_sdata_if.sd0_ie_n, %x_sdata_if.sd0_oe_n, %x_sdata_if.sd0_out, %x_sdata_if.sd1_ie_n, %x_sdata_if.sd1_oe_n, %x_sdata_if.sd1_out, %59, %60, %x_apb_if.usi_intr : i1, i1, i1, i1, i1, i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1
  }
  hw.module @usi2_sec_top(in %clk : i1, in %dma_ack_rx : i1, in %dma_ack_tx : i1, out dma_req_rx : i1, out dma_req_tx : i1, out nss_ie_n : i1, in %nss_in : i1, out nss_oe_n : i1, out nss_out : i1, in %paddr : i32, in %penable : i1, in %pprot : i3, out prdata : i32, in %psel : i1, in %pwdata : i32, in %pwrite : i1, in %rst_n : i1, out sclk_ie_n : i1, in %sclk_in : i1, out sclk_oe_n : i1, out sclk_out : i1, out sd0_ie_n : i1, in %sd0_in : i1, out sd0_oe_n : i1, out sd0_out : i1, out sd1_ie_n : i1, in %sd1_in : i1, out sd1_oe_n : i1, out sd1_out : i1, out sec_rx_req : i1, out sec_tx_req : i1, in %tipc_usi2_trust : i1, out usi_etb_rx_trig : i1, out usi_etb_tx_trig : i1, out usi_intr : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %prdata = llhd.sig %c0_i32 : i32
    %x_usi2.dma_req_rx, %x_usi2.dma_req_tx, %x_usi2.nss_ie_n, %x_usi2.nss_oe_n, %x_usi2.nss_out, %x_usi2.prdata, %x_usi2.sclk_ie_n, %x_usi2.sclk_oe_n, %x_usi2.sclk_out, %x_usi2.sd0_ie_n, %x_usi2.sd0_oe_n, %x_usi2.sd0_out, %x_usi2.sd1_ie_n, %x_usi2.sd1_oe_n, %x_usi2.sd1_out, %x_usi2.usi_etb_rx_trig, %x_usi2.usi_etb_tx_trig, %x_usi2.usi_intr = hw.instance "x_usi2" @usi_top(clk: %clk: i1, dma_ack_rx: %dma_ack_rx: i1, dma_ack_tx: %dma_ack_tx: i1, nss_in: %nss_in: i1, paddr: %paddr: i32, penable: %penable: i1, psel: %psel: i1, pwdata: %pwdata: i32, pwrite: %pwrite: i1, rst_n: %rst_n: i1, sclk_in: %sclk_in: i1, sd0_in: %sd0_in: i1, sd1_in: %sd1_in: i1) -> (dma_req_rx: i1, dma_req_tx: i1, nss_ie_n: i1, nss_oe_n: i1, nss_out: i1, prdata: i32, sclk_ie_n: i1, sclk_oe_n: i1, sclk_out: i1, sd0_ie_n: i1, sd0_oe_n: i1, sd0_out: i1, sd1_ie_n: i1, sd1_oe_n: i1, sd1_out: i1, usi_etb_rx_trig: i1, usi_etb_tx_trig: i1, usi_intr: i1) {sv.namehint = "i_prdata"}
    llhd.drv %prdata, %x_usi2.prdata after %0 : i32
    %1 = llhd.prb %prdata : i32
    hw.output %x_usi2.dma_req_rx, %x_usi2.dma_req_tx, %x_usi2.nss_ie_n, %x_usi2.nss_oe_n, %x_usi2.nss_out, %1, %x_usi2.sclk_ie_n, %x_usi2.sclk_oe_n, %x_usi2.sclk_out, %x_usi2.sd0_ie_n, %x_usi2.sd0_oe_n, %x_usi2.sd0_out, %x_usi2.sd1_ie_n, %x_usi2.sd1_oe_n, %x_usi2.sd1_out, %x_usi2.dma_req_rx, %x_usi2.dma_req_tx, %x_usi2.usi_etb_rx_trig, %x_usi2.usi_etb_tx_trig, %x_usi2.usi_intr : i1, i1, i1, i1, i1, i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1
  }
}
