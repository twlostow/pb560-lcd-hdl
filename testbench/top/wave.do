onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group Top /main/DUT/sysclk_12m_i
add wave -noupdate -group Top /main/DUT/uart_txd_o
add wave -noupdate -group Top /main/DUT/uart_rxd_i
add wave -noupdate -group Top /main/DUT/led_o
add wave -noupdate -group Top /main/DUT/btn_i
add wave -noupdate -group Top /main/DUT/cnx_slave_in
add wave -noupdate -group Top /main/DUT/cnx_slave_out
add wave -noupdate -group Top /main/DUT/cnx_master_in
add wave -noupdate -group Top /main/DUT/cnx_master_out
add wave -noupdate -group Top /main/DUT/rst_n_sys
add wave -noupdate -group Top /main/DUT/rst_sys
add wave -noupdate -group Top /main/DUT/clk_sys
add wave -noupdate -group Top /main/DUT/pll_locked_n
add wave -noupdate -group Top /main/DUT/pll_clk_in
add wave -noupdate -group Top /main/DUT/pll_clk_sys
add wave -noupdate -group Top /main/DUT/CONTROL
add wave -noupdate -group Top /main/DUT/TRIG0
add wave -noupdate -group Top /main/DUT/uart_txd_int
add wave -noupdate -group Top /main/DUT/pll_locked
add wave -noupdate -group Top /main/DUT/pll_locked_synced
add wave -noupdate -group Top /main/DUT/rst_n_sys_pre
add wave -noupdate -group Top /main/DUT/pll_clk_fb
add wave -noupdate -group Top /main/DUT/pll_clk_fb_prebuf
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/clk_i
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/rst_i
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/irq_i
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/im_addr_o
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/im_data_i
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/im_valid_i
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/dm_addr_o
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/dm_data_s_o
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/dm_data_l_i
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/dm_data_select_o
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/dm_store_o
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/dm_load_o
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/dm_load_done_i
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/dm_store_done_i
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/dbg_force_i
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/dbg_enabled_o
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/dbg_insn_i
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/dbg_insn_set_i
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/dbg_insn_ready_o
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/dbg_mbx_data_i
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/dbg_mbx_write_i
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/dbg_mbx_data_o
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/f_stall
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/x_stall
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/x_kill
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d_stall
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d_kill
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d_stall_req
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/w_stall_req
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/x_stall_req
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/x2f_pc_bra
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/x2f_bra
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/x2f_dbg_toggle
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/f2d_pc
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/f2d_ir
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/f2d_valid
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/rf_rs1
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/rf_rs2
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/rf_rd
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/rf_rd_value
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/rf_rd_write
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_valid
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_pc
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_rs1
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_rs2
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_rd
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_fun
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_opcode
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_shifter_sign
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_is_load
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_is_store
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_is_undef
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_imm
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_is_signed_alu_op
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_is_add_o
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_rd_source
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_rd_write
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_csr_sel
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_csr_imm
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_is_csr
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_is_mret
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_is_ebreak
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_csr_load_en
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_alu_op1
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_alu_op2
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_use_op1
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_use_op2
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_is_multiply
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_is_divide
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/x2w_rd
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/x2w_rd_value
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/x2w_rd_shifter
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/x2w_rd_multiply
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/x2w_dm_addr
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/x2w_rd_write
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/x2w_fun
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/x2w_store
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/x2w_load
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/x2w_rd_source
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/x2w_valid
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/x_rs2_value
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/x_rs1_value
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/rf_bypass_rd_value
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/rf_bypass_rd_write
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/csr_time
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/csr_cycles
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/d2x_is_add
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/sys_tick
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/x2f_bra_d0
add wave -noupdate -group CPU /main/DUT/U_CPU/cpu_core/x2f_bra_d1
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/clk_i
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/rst_n_i
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/lcd_de_o
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/lcd_clk_o
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/lcd_hsync_o
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/lcd_vsync_o
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/lcd_r_o
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/lcd_g_o
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/lcd_b_o
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/r_pfifo_we_i
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/r_pfifo_full_o
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/r_pfifo_data_i
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/r_enable_i
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/r_page_sel_i
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/r_h_f_porch_i
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/r_h_b_porch_i
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/r_h_total_i
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/r_h_active_i
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/r_v_f_porch_i
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/r_v_b_porch_i
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/r_v_active_i
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/r_v_total_i
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/r_clk_div_i
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/lcd_ram_addr
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/lcd_ram_rdata
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/gfx_ram_addr
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/gfx_ram_rdata
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/gfx_ram_wdata
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/gfx_ram_we
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/lcd_h_count
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/lcd_v_count
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/lcd_clk_div_count
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/lcd_clk_div_re
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/lcd_clk_div_fe
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/lcd_v_active
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/lcd_h_active
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/lcd_h_sync
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/lcd_v_sync
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/lcd_pixel
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/pfifo_rd
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/pfifo_rdata
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/pfifo_addr
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/pfifo_count
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/pfifo_page
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/pfifo_pixel
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/pfifo_page_mask
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/pfifo_pixel_value
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/gfx_state
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/gfx_count
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/gfx_page_mask
add wave -noupdate -group LCDC /main/DUT/U_LCD_Controller/gfx_pixel_value
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/rst_n_i
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/clk_i
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/wb_cyc_i
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/wb_stb_i
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/wb_adr_i
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/wb_sel_i
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/wb_we_i
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/wb_dat_i
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/wb_ack_o
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/wb_err_o
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/wb_rty_o
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/wb_stall_o
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/wb_dat_o
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/cr_enable_o
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/cr_page_sel_o
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/cr_clk_div_o
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/sr_gfx_fifo_full_i
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/h_front_porch_value_o
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/h_back_porch_value_o
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/h_active_value_o
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/h_total_value_o
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/v_front_porch_value_o
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/v_back_porch_value_o
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/v_active_value_o
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/v_total_value_o
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/gfx_fifo_data_i
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/gfx_fifo_data_o
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/gfx_fifo_wr_o
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/rd_req_int
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/wr_req_int
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/rd_ack_int
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/wr_ack_int
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/wb_en
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/ack_int
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/wb_rip
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/wb_wip
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/cr_enable_reg
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/cr_page_sel_reg
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/cr_clk_div_reg
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/cr_wreq
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/cr_wack
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/h_front_porch_value_reg
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/h_front_porch_wreq
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/h_front_porch_wack
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/h_back_porch_value_reg
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/h_back_porch_wreq
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/h_back_porch_wack
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/h_active_value_reg
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/h_active_wreq
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/h_active_wack
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/h_total_value_reg
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/h_total_wreq
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/h_total_wack
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/v_front_porch_value_reg
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/v_front_porch_wreq
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/v_front_porch_wack
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/v_back_porch_value_reg
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/v_back_porch_wreq
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/v_back_porch_wack
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/v_active_value_reg
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/v_active_wreq
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/v_active_wack
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/v_total_value_reg
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/v_total_wreq
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/v_total_wack
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/gfx_fifo_wreq
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/rd_ack_d0
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/rd_dat_d0
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/wr_req_d0
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/wr_adr_d0
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/wr_dat_d0
add wave -noupdate -expand -group LCDC_Regs /main/DUT/U_LCD_Regs/wr_sel_d0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {34846700 ps} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {196875008 ps}
