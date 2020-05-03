-- 
-- DSI Shield
-- Copyright (C) 2013-2014 twl <twlostow@printf.cc>
--
-- This library is free software; you can redistribute it and/or
-- modify it under the terms of the GNU Lesser General Public
-- License as published by the Free Software Foundation; either
-- version 3 of the License, or (at your option) any later version.
--
-- This library is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-- Lesser General Public License for more details.
--
-- You should have received a copy of the GNU Lesser General Public
-- License along with this library; if not, write to the Free Software
-- Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
-- 

--
-- rev2_top.vhd - top level for rev 2.2. PCB FPGA
--
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.gencores_pkg.all;
use work.wishbone_pkg.all;

library unisim;
use unisim.vcomponents.all;



entity covidlcd_top_cmod_a7 is
  generic (
    g_cpu_firmware : string  := "../../../../sw/bootloader/boot.bram";
    g_simulation   : boolean := false
    );

  port (
    sysclk_12m_i : in std_logic;

    uart_txd_o : out std_logic;
    uart_rxd_i : in  std_logic;

    led_o : out std_logic_vector(1 downto 0);
    btn_i : in  std_logic_vector(1 downto 0);

    lcd_clk_o   : out std_logic;
    lcd_de_o    : out std_logic;
    lcd_hsync_o : out std_logic;
    lcd_vsync_o : out std_logic;
    lcd_r_o     : out std_logic_vector(1 downto 0);
    lcd_g_o     : out std_logic_vector(1 downto 0);
    lcd_b_o     : out std_logic_vector(1 downto 0)
    );

end covidlcd_top_cmod_a7;

architecture rtl of covidlcd_top_cmod_a7 is


  constant c_cnx_slave_ports  : integer := 1;
  constant c_cnx_master_ports : integer := 2;
  constant c_master_urv_cpu   : integer := 0;

  constant c_slave_uart           : integer := 0;
  constant c_slave_lcd_controller : integer := 1;

  signal cnx_slave_in  : t_wishbone_slave_in_array(c_cnx_slave_ports-1 downto 0);
  signal cnx_slave_out : t_wishbone_slave_out_array(c_cnx_slave_ports-1 downto 0);

  signal cnx_master_in  : t_wishbone_master_in_array(c_cnx_master_ports-1 downto 0);
  signal cnx_master_out : t_wishbone_master_out_array(c_cnx_master_ports-1 downto 0);

  constant c_cfg_base_addr : t_wishbone_address_array(c_cnx_master_ports-1 downto 0) :=
    (c_slave_uart           => x"c0010000",
     c_slave_lcd_controller => x"c0020000"
     );

  constant c_cfg_base_mask : t_wishbone_address_array(c_cnx_master_ports-1 downto 0) :=
    (c_slave_uart           => x"ffff0000",
     c_slave_lcd_controller => x"ffff0000"
     );


  signal rst_n_sys, rst_sys, clk_sys, pll_locked_n : std_logic;

  attribute keep            : string;
  attribute keep of clk_sys : signal is "true";

  signal pll_clk_in  : std_logic;
  signal pll_clk_sys : std_logic;

  component xurv_core is
    generic (
      g_internal_ram_size           : integer;
      g_internal_ram_init_file      : string;
      g_internal_ram_implementation : string;
      g_simulation                  : boolean);
    port (
      clk_sys_i    : in  std_logic;
      rst_n_i      : in  std_logic;
      cpu_rst_i    : in  std_logic                    := '0';
      irq_i        : in  std_logic_vector(7 downto 0) := x"00";
      dwb_o        : out t_wishbone_master_out;
      dwb_i        : in  t_wishbone_master_in;
      host_slave_i : in  t_wishbone_slave_in          := cc_dummy_slave_in;
      host_slave_o : out t_wishbone_slave_out);
  end component xurv_core;

  component chipscope_icon is
    port (
      CONTROL0 : inout std_logic_vector(35 downto 0));
  end component chipscope_icon;

  component chipscope_ila is
    port (
      CONTROL : inout std_logic_vector(35 downto 0);
      CLK     : in    std_logic;
      TRIG0   : in    std_logic_vector(7 downto 0));
  end component chipscope_ila;

  signal CONTROL                                      : std_logic_vector(35 downto 0);
  signal TRIG0                                        : std_logic_vector(7 downto 0);
  signal uart_txd_int                                 : std_logic;
  signal pll_locked, pll_locked_synced, rst_n_sys_pre : std_logic;
  signal pll_clk_fb, pll_clk_fb_prebuf                : std_logic;

  signal r_pfifo_we   : std_logic;
  signal r_pfifo_full : std_logic;
  signal r_pfifo_data : std_logic_vector(31 downto 0);

  signal r_cr_enable   : std_logic;
  signal r_cr_page_sel : std_logic_vector(1 downto 0);
  signal r_h_f_porch   : std_logic_vector(9 downto 0);
  signal r_h_b_porch   : std_logic_vector(9 downto 0);
  signal r_h_total     : std_logic_vector(9 downto 0);
  signal r_h_active    : std_logic_vector(9 downto 0);
  signal r_v_f_porch   : std_logic_vector(9 downto 0);
  signal r_v_b_porch   : std_logic_vector(9 downto 0);
  signal r_v_active    : std_logic_vector(9 downto 0);
  signal r_v_total     : std_logic_vector(9 downto 0);
  signal r_cr_clk_div  : std_logic_vector(7 downto 0);

  signal dummy_zeros : std_logic_vector(31 downto 0) := x"00000000";

begin  -- rtl

  uart_txd_o <= uart_txd_int;

  U_IbufG_CLKIn : IBUFG
    port map (
      I => sysclk_12m_i,
      O => pll_clk_in
      );

  U_PLL : MMCME2_ADV
    generic map(
      BANDWIDTH            => "OPTIMIZED",
      CLKFBOUT_MULT_F      => 62.500000,
      CLKFBOUT_PHASE       => 0.000000,
      CLKFBOUT_USE_FINE_PS => false,
      CLKIN1_PERIOD        => 83.333000,
      CLKIN2_PERIOD        => 0.000000,
      CLKOUT0_DIVIDE_F     => 7.500000,
      CLKOUT0_DUTY_CYCLE   => 0.500000,
      CLKOUT0_PHASE        => 0.000000,
      CLKOUT0_USE_FINE_PS  => false,
      CLKOUT1_DIVIDE       => 1,
      CLKOUT1_DUTY_CYCLE   => 0.500000,
      CLKOUT1_PHASE        => 0.000000,
      CLKOUT1_USE_FINE_PS  => false,
      CLKOUT2_DIVIDE       => 1,
      CLKOUT2_DUTY_CYCLE   => 0.500000,
      CLKOUT2_PHASE        => 0.000000,
      CLKOUT2_USE_FINE_PS  => false,
      CLKOUT3_DIVIDE       => 1,
      CLKOUT3_DUTY_CYCLE   => 0.500000,
      CLKOUT3_PHASE        => 0.000000,
      CLKOUT3_USE_FINE_PS  => false,
      CLKOUT4_CASCADE      => false,
      CLKOUT4_DIVIDE       => 1,
      CLKOUT4_DUTY_CYCLE   => 0.500000,
      CLKOUT4_PHASE        => 0.000000,
      CLKOUT4_USE_FINE_PS  => false,
      CLKOUT5_DIVIDE       => 1,
      CLKOUT5_DUTY_CYCLE   => 0.500000,
      CLKOUT5_PHASE        => 0.000000,
      CLKOUT5_USE_FINE_PS  => false,
      CLKOUT6_DIVIDE       => 1,
      CLKOUT6_DUTY_CYCLE   => 0.500000,
      CLKOUT6_PHASE        => 0.000000,
      CLKOUT6_USE_FINE_PS  => false,
      COMPENSATION         => "ZHOLD",
      DIVCLK_DIVIDE        => 1,
      REF_JITTER1          => 0.010000,
      REF_JITTER2          => 0.010000,
      SS_EN                => "FALSE",
      SS_MODE              => "CENTER_HIGH",
      SS_MOD_PERIOD        => 10000,
      STARTUP_WAIT         => false
      )
    port map (
      CLKFBIN           => pll_clk_fb,
      CLKFBOUT          => pll_clk_fb_prebuf,
      CLKIN1            => pll_clk_in,
      CLKIN2            => '0',
      CLKINSEL          => '1',
      CLKOUT0           => pll_clk_sys,
      DADDR(6 downto 0) => "0000000",
      DCLK              => '0',
      DEN               => '0',
      DI(15 downto 0)   => "0000000000000000",
      DWE               => '0',
      LOCKED            => pll_locked,
      PSCLK             => '0',
      PSEN              => '0',
      PSINCDEC          => '0',
      PWRDWN            => '0',
      RST               => '0'
      );

  U_BufG_CLK_SYS : BUFG
    port map (
      I => pll_clk_sys,
      O => clk_sys);

  U_BufG_CLK_FB : BUFG
    port map (
      I => pll_clk_fb_prebuf,
      O => pll_clk_fb);

  U_Sync_PLL_Lock : gc_sync_ffs
    port map (
      clk_i    => clk_sys,
      rst_n_i  => '1',
      data_i   => pll_locked,
      synced_o => pll_locked_synced);

  rst_sys <= not rst_n_sys;

  U_Reset_Gen : entity work.reset_gen
    port map (
      clk_sys_i      => clk_sys,
      mask_reset_i   => '0',
      spi_cs_n_rst_i => btn_i(0),
      rst_sys_n_o    => rst_n_sys_pre);

  rst_n_sys <= rst_n_sys_pre and pll_locked_synced;  -- and rst_n_sys_pre;

  U_Intercon : xwb_crossbar
    generic map (
      g_num_masters => c_cnx_slave_ports,
      g_num_slaves  => c_cnx_master_ports,
      g_registered  => true,
      g_address     => c_cfg_base_addr,
      g_mask        => c_cfg_base_mask)
    port map (
      clk_sys_i => clk_sys,
      rst_n_i   => rst_n_sys,
      slave_i   => cnx_slave_in,
      slave_o   => cnx_slave_out,
      master_i  => cnx_master_in,
      master_o  => cnx_master_out);

  U_CPU : xurv_core
    generic map (
      g_internal_ram_size           => 32768,
      g_internal_ram_init_file      => g_cpu_firmware,
      g_simulation                  => g_simulation,
      g_internal_ram_implementation => "gencores"
      )
    port map (
      clk_sys_i => clk_sys,
      rst_n_i   => rst_n_sys,
      cpu_rst_i => rst_sys,
      irq_i     => x"00",
      dwb_o     => cnx_slave_in(0),
      dwb_i     => cnx_slave_out(0)
      );

  U_UART : xwb_simple_uart
    generic map (
      g_interface_mode      => PIPELINED,
      g_address_granularity => BYTE)
    port map (
      clk_sys_i  => clk_sys,
      rst_n_i    => rst_n_sys,
      slave_i    => cnx_master_out(c_slave_uart),
      slave_o    => cnx_master_in(c_slave_uart),
      uart_rxd_i => uart_rxd_i,
      uart_txd_o => uart_txd_int);


  U_LCD_Controller : entity work.lcd_controller
    port map (
      clk_i   => clk_sys,
      rst_n_i => rst_n_sys,

      lcd_de_o    => lcd_de_o,
      lcd_clk_o   => lcd_clk_o,
      lcd_hsync_o => lcd_hsync_o,
      lcd_vsync_o => lcd_vsync_o,
      lcd_r_o     => lcd_r_o,
      lcd_g_o     => lcd_g_o,
      lcd_b_o     => lcd_b_o,

      r_pfifo_we_i   => r_pfifo_we,
      r_pfifo_full_o => r_pfifo_full,
      r_pfifo_data_i => r_pfifo_data,

      r_enable_i    => r_cr_enable,
      r_page_sel_i  => r_cr_page_sel,
      r_h_f_porch_i => r_h_f_porch,
      r_h_b_porch_i => r_h_b_porch,
      r_h_total_i   => r_h_total,
      r_h_active_i  => r_h_active,
      r_v_f_porch_i => r_v_f_porch,
      r_v_b_porch_i => r_v_b_porch,
      r_v_active_i  => r_v_active,
      r_v_total_i   => r_v_total,
      r_clk_div_i   => r_cr_clk_div
      );

  U_LCD_Regs : entity work.lcd_controller_regs
    port map (

      rst_n_i    => rst_n_sys,
      clk_i      => clk_sys,
      wb_cyc_i   => cnx_master_out(c_slave_lcd_controller).cyc,
      wb_stb_i   => cnx_master_out(c_slave_lcd_controller).stb,
      wb_adr_i   => cnx_master_out(c_slave_lcd_controller).adr(5 downto 2),
      wb_sel_i   => cnx_master_out(c_slave_lcd_controller).sel,
      wb_we_i    => cnx_master_out(c_slave_lcd_controller).we,
      wb_dat_i   => cnx_master_out(c_slave_lcd_controller).dat,
      wb_ack_o   => cnx_master_in(c_slave_lcd_controller).ack,
      wb_err_o   => cnx_master_in(c_slave_lcd_controller).err,
      wb_rty_o   => cnx_master_in(c_slave_lcd_controller).rty,
      wb_stall_o => cnx_master_in(c_slave_lcd_controller).stall,
      wb_dat_o   => cnx_master_in(c_slave_lcd_controller).dat,

      cr_enable_o   => r_cr_enable,
      cr_page_sel_o => r_cr_page_sel,
      cr_clk_div_o  => r_cr_clk_div,

      sr_gfx_fifo_full_i => r_pfifo_full,

      h_front_porch_value_o => r_h_f_porch,
      h_back_porch_value_o  => r_h_b_porch,
      h_active_value_o      => r_h_active,
      h_total_value_o       => r_h_total,
      v_front_porch_value_o => r_v_f_porch,
      v_back_porch_value_o  => r_v_b_porch,
      v_active_value_o      => r_v_active,
      v_total_value_o       => r_v_total,

      gfx_fifo_data_i => dummy_zeros,
      gfx_fifo_data_o => r_pfifo_data,
      gfx_fifo_wr_o   => r_pfifo_we
      );


end rtl;

