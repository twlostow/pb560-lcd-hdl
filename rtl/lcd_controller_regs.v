// Do not edit.  Generated on Mon May 04 00:13:07 2020 by twl
// With Cheby 1.4.dev0 and these options:
//  -i lcd_controller_regs.cheby.yaml --hdl verilog --gen-hdl lcd_controller_regs.v --consts-style h --gen-consts lcd_controller_regs.h



module lcd_controller_regs
  (
    input   wire rst_n_i,
    input   wire clk_i,
    input   wire wb_cyc_i,
    input   wire wb_stb_i,
    input   wire [5:2] wb_adr_i,
    input   wire [3:0] wb_sel_i,
    input   wire wb_we_i,
    input   wire [31:0] wb_dat_i,
    output  wire wb_ack_o,
    output  wire wb_err_o,
    output  wire wb_rty_o,
    output  wire wb_stall_o,
    output  reg [31:0] wb_dat_o,

    // Control register
    output  wire cr_enable_o,
    output  wire [1:0] cr_page_sel_o,
    output  wire [7:0] cr_clk_div_o,

    // Status register
    input   wire sr_gfx_fifo_full_i,

    // REG h_front_porch
    output  wire [9:0] h_front_porch_value_o,

    // REG h_back_porch
    output  wire [9:0] h_back_porch_value_o,

    // REG h_active
    output  wire [9:0] h_active_value_o,

    // REG h_total
    output  wire [9:0] h_total_value_o,

    // REG v_front_porch
    output  wire [9:0] v_front_porch_value_o,

    // REG v_back_porch
    output  wire [9:0] v_back_porch_value_o,

    // REG v_active
    output  wire [9:0] v_active_value_o,

    // REG v_total
    output  wire [9:0] v_total_value_o,

    // REG gfx_fifo
    input   wire [31:0] gfx_fifo_data_i,
    output  wire [31:0] gfx_fifo_data_o,
    output  wire gfx_fifo_wr_o
  );
  wire rd_req_int;
  wire wr_req_int;
  reg rd_ack_int;
  reg wr_ack_int;
  wire wb_en;
  wire ack_int;
  reg wb_rip;
  reg wb_wip;
  reg cr_enable_reg;
  reg [1:0] cr_page_sel_reg;
  reg [7:0] cr_clk_div_reg;
  reg cr_wreq;
  reg cr_wack;
  reg [9:0] h_front_porch_value_reg;
  reg h_front_porch_wreq;
  reg h_front_porch_wack;
  reg [9:0] h_back_porch_value_reg;
  reg h_back_porch_wreq;
  reg h_back_porch_wack;
  reg [9:0] h_active_value_reg;
  reg h_active_wreq;
  reg h_active_wack;
  reg [9:0] h_total_value_reg;
  reg h_total_wreq;
  reg h_total_wack;
  reg [9:0] v_front_porch_value_reg;
  reg v_front_porch_wreq;
  reg v_front_porch_wack;
  reg [9:0] v_back_porch_value_reg;
  reg v_back_porch_wreq;
  reg v_back_porch_wack;
  reg [9:0] v_active_value_reg;
  reg v_active_wreq;
  reg v_active_wack;
  reg [9:0] v_total_value_reg;
  reg v_total_wreq;
  reg v_total_wack;
  reg gfx_fifo_wreq;
  reg rd_ack_d0;
  reg [31:0] rd_dat_d0;
  reg wr_req_d0;
  reg [5:2] wr_adr_d0;
  reg [31:0] wr_dat_d0;
  reg [3:0] wr_sel_d0;

  // WB decode signals
  assign wb_en = wb_cyc_i & wb_stb_i;

  always @(posedge(clk_i)or negedge(rst_n_i))
  begin
    if (!rst_n_i)
      wb_rip <= 1'b0;
    else
      wb_rip <= (wb_rip | (wb_en & !wb_we_i)) & !rd_ack_int;
  end
  assign rd_req_int = (wb_en & !wb_we_i) & !wb_rip;

  always @(posedge(clk_i)or negedge(rst_n_i))
  begin
    if (!rst_n_i)
      wb_wip <= 1'b0;
    else
      wb_wip <= (wb_wip | (wb_en & wb_we_i)) & !wr_ack_int;
  end
  assign wr_req_int = (wb_en & wb_we_i) & !wb_wip;

  assign ack_int = rd_ack_int | wr_ack_int;
  assign wb_ack_o = ack_int;
  assign wb_stall_o = !ack_int & wb_en;
  assign wb_rty_o = 1'b0;
  assign wb_err_o = 1'b0;

  // pipelining for wr-in+rd-out
  always @(posedge(clk_i)or negedge(rst_n_i))
  begin
    if (!rst_n_i)
      begin
        rd_ack_int <= 1'b0;
        wr_req_d0 <= 1'b0;
      end
    else
      begin
        rd_ack_int <= rd_ack_d0;
        wb_dat_o <= rd_dat_d0;
        wr_req_d0 <= wr_req_int;
        wr_adr_d0 <= wb_adr_i;
        wr_dat_d0 <= wb_dat_i;
        wr_sel_d0 <= wb_sel_i;
      end
  end

  // Register cr
  assign cr_enable_o = cr_enable_reg;
  assign cr_page_sel_o = cr_page_sel_reg;
  assign cr_clk_div_o = cr_clk_div_reg;
  always @(posedge(clk_i)or negedge(rst_n_i))
  begin
    if (!rst_n_i)
      begin
        cr_enable_reg <= 1'b0;
        cr_page_sel_reg <= 2'b00;
        cr_clk_div_reg <= 8'b00000000;
        cr_wack <= 1'b0;
      end
    else
      begin
        if (cr_wreq == 1'b1)
          begin
            cr_enable_reg <= wr_dat_d0[0];
            cr_page_sel_reg <= wr_dat_d0[2:1];
            cr_clk_div_reg <= wr_dat_d0[10:3];
          end
        cr_wack <= cr_wreq;
      end
  end

  // Register sr

  // Register h_front_porch
  assign h_front_porch_value_o = h_front_porch_value_reg;
  always @(posedge(clk_i)or negedge(rst_n_i))
  begin
    if (!rst_n_i)
      begin
        h_front_porch_value_reg <= 10'b0000000000;
        h_front_porch_wack <= 1'b0;
      end
    else
      begin
        if (h_front_porch_wreq == 1'b1)
          h_front_porch_value_reg <= wr_dat_d0[9:0];
        h_front_porch_wack <= h_front_porch_wreq;
      end
  end

  // Register h_back_porch
  assign h_back_porch_value_o = h_back_porch_value_reg;
  always @(posedge(clk_i)or negedge(rst_n_i))
  begin
    if (!rst_n_i)
      begin
        h_back_porch_value_reg <= 10'b0000000000;
        h_back_porch_wack <= 1'b0;
      end
    else
      begin
        if (h_back_porch_wreq == 1'b1)
          h_back_porch_value_reg <= wr_dat_d0[9:0];
        h_back_porch_wack <= h_back_porch_wreq;
      end
  end

  // Register h_active
  assign h_active_value_o = h_active_value_reg;
  always @(posedge(clk_i)or negedge(rst_n_i))
  begin
    if (!rst_n_i)
      begin
        h_active_value_reg <= 10'b0000000000;
        h_active_wack <= 1'b0;
      end
    else
      begin
        if (h_active_wreq == 1'b1)
          h_active_value_reg <= wr_dat_d0[9:0];
        h_active_wack <= h_active_wreq;
      end
  end

  // Register h_total
  assign h_total_value_o = h_total_value_reg;
  always @(posedge(clk_i)or negedge(rst_n_i))
  begin
    if (!rst_n_i)
      begin
        h_total_value_reg <= 10'b0000000000;
        h_total_wack <= 1'b0;
      end
    else
      begin
        if (h_total_wreq == 1'b1)
          h_total_value_reg <= wr_dat_d0[9:0];
        h_total_wack <= h_total_wreq;
      end
  end

  // Register v_front_porch
  assign v_front_porch_value_o = v_front_porch_value_reg;
  always @(posedge(clk_i)or negedge(rst_n_i))
  begin
    if (!rst_n_i)
      begin
        v_front_porch_value_reg <= 10'b0000000000;
        v_front_porch_wack <= 1'b0;
      end
    else
      begin
        if (v_front_porch_wreq == 1'b1)
          v_front_porch_value_reg <= wr_dat_d0[9:0];
        v_front_porch_wack <= v_front_porch_wreq;
      end
  end

  // Register v_back_porch
  assign v_back_porch_value_o = v_back_porch_value_reg;
  always @(posedge(clk_i)or negedge(rst_n_i))
  begin
    if (!rst_n_i)
      begin
        v_back_porch_value_reg <= 10'b0000000000;
        v_back_porch_wack <= 1'b0;
      end
    else
      begin
        if (v_back_porch_wreq == 1'b1)
          v_back_porch_value_reg <= wr_dat_d0[9:0];
        v_back_porch_wack <= v_back_porch_wreq;
      end
  end

  // Register v_active
  assign v_active_value_o = v_active_value_reg;
  always @(posedge(clk_i)or negedge(rst_n_i))
  begin
    if (!rst_n_i)
      begin
        v_active_value_reg <= 10'b0000000000;
        v_active_wack <= 1'b0;
      end
    else
      begin
        if (v_active_wreq == 1'b1)
          v_active_value_reg <= wr_dat_d0[9:0];
        v_active_wack <= v_active_wreq;
      end
  end

  // Register v_total
  assign v_total_value_o = v_total_value_reg;
  always @(posedge(clk_i)or negedge(rst_n_i))
  begin
    if (!rst_n_i)
      begin
        v_total_value_reg <= 10'b0000000000;
        v_total_wack <= 1'b0;
      end
    else
      begin
        if (v_total_wreq == 1'b1)
          v_total_value_reg <= wr_dat_d0[9:0];
        v_total_wack <= v_total_wreq;
      end
  end

  // Register gfx_fifo
  assign gfx_fifo_data_o = wr_dat_d0;
  assign gfx_fifo_wr_o = gfx_fifo_wreq;

  // Process for write requests.
  always @(wr_adr_d0, wr_req_d0, cr_wack, h_front_porch_wack, h_back_porch_wack, h_active_wack, h_total_wack, v_front_porch_wack, v_back_porch_wack, v_active_wack, v_total_wack) 
      begin
        cr_wreq <= 1'b0;
        h_front_porch_wreq <= 1'b0;
        h_back_porch_wreq <= 1'b0;
        h_active_wreq <= 1'b0;
        h_total_wreq <= 1'b0;
        v_front_porch_wreq <= 1'b0;
        v_back_porch_wreq <= 1'b0;
        v_active_wreq <= 1'b0;
        v_total_wreq <= 1'b0;
        gfx_fifo_wreq <= 1'b0;
        case (wr_adr_d0[5:2])
        4'b0000: 
          begin
            // Reg cr
            cr_wreq <= wr_req_d0;
            wr_ack_int <= cr_wack;
          end
        4'b0001: 
          // Reg sr
          wr_ack_int <= wr_req_d0;
        4'b0010: 
          begin
            // Reg h_front_porch
            h_front_porch_wreq <= wr_req_d0;
            wr_ack_int <= h_front_porch_wack;
          end
        4'b0011: 
          begin
            // Reg h_back_porch
            h_back_porch_wreq <= wr_req_d0;
            wr_ack_int <= h_back_porch_wack;
          end
        4'b0100: 
          begin
            // Reg h_active
            h_active_wreq <= wr_req_d0;
            wr_ack_int <= h_active_wack;
          end
        4'b0101: 
          begin
            // Reg h_total
            h_total_wreq <= wr_req_d0;
            wr_ack_int <= h_total_wack;
          end
        4'b0110: 
          begin
            // Reg v_front_porch
            v_front_porch_wreq <= wr_req_d0;
            wr_ack_int <= v_front_porch_wack;
          end
        4'b0111: 
          begin
            // Reg v_back_porch
            v_back_porch_wreq <= wr_req_d0;
            wr_ack_int <= v_back_porch_wack;
          end
        4'b1000: 
          begin
            // Reg v_active
            v_active_wreq <= wr_req_d0;
            wr_ack_int <= v_active_wack;
          end
        4'b1001: 
          begin
            // Reg v_total
            v_total_wreq <= wr_req_d0;
            wr_ack_int <= v_total_wack;
          end
        4'b1010: 
          begin
            // Reg gfx_fifo
            gfx_fifo_wreq <= wr_req_d0;
            wr_ack_int <= wr_req_d0;
          end
        default:
          wr_ack_int <= wr_req_d0;
        endcase
      end

  // Process for read requests.
  always @(wb_adr_i, rd_req_int, cr_enable_reg, cr_page_sel_reg, cr_clk_div_reg, sr_gfx_fifo_full_i, h_front_porch_value_reg, h_back_porch_value_reg, h_active_value_reg, h_total_value_reg, v_front_porch_value_reg, v_back_porch_value_reg, v_active_value_reg, v_total_value_reg, gfx_fifo_data_i) 
      begin
        // By default ack read requests
        rd_dat_d0 <= {32{1'bx}};
        case (wb_adr_i[5:2])
        4'b0000: 
          begin
            // Reg cr
            rd_ack_d0 <= rd_req_int;
            rd_dat_d0[0] <= cr_enable_reg;
            rd_dat_d0[2:1] <= cr_page_sel_reg;
            rd_dat_d0[10:3] <= cr_clk_div_reg;
            rd_dat_d0[31:11] <= {21{1'b0}};
          end
        4'b0001: 
          begin
            // Reg sr
            rd_ack_d0 <= rd_req_int;
            rd_dat_d0[0] <= sr_gfx_fifo_full_i;
            rd_dat_d0[31:1] <= {31{1'b0}};
          end
        4'b0010: 
          begin
            // Reg h_front_porch
            rd_ack_d0 <= rd_req_int;
            rd_dat_d0[9:0] <= h_front_porch_value_reg;
            rd_dat_d0[31:10] <= {22{1'b0}};
          end
        4'b0011: 
          begin
            // Reg h_back_porch
            rd_ack_d0 <= rd_req_int;
            rd_dat_d0[9:0] <= h_back_porch_value_reg;
            rd_dat_d0[31:10] <= {22{1'b0}};
          end
        4'b0100: 
          begin
            // Reg h_active
            rd_ack_d0 <= rd_req_int;
            rd_dat_d0[9:0] <= h_active_value_reg;
            rd_dat_d0[31:10] <= {22{1'b0}};
          end
        4'b0101: 
          begin
            // Reg h_total
            rd_ack_d0 <= rd_req_int;
            rd_dat_d0[9:0] <= h_total_value_reg;
            rd_dat_d0[31:10] <= {22{1'b0}};
          end
        4'b0110: 
          begin
            // Reg v_front_porch
            rd_ack_d0 <= rd_req_int;
            rd_dat_d0[9:0] <= v_front_porch_value_reg;
            rd_dat_d0[31:10] <= {22{1'b0}};
          end
        4'b0111: 
          begin
            // Reg v_back_porch
            rd_ack_d0 <= rd_req_int;
            rd_dat_d0[9:0] <= v_back_porch_value_reg;
            rd_dat_d0[31:10] <= {22{1'b0}};
          end
        4'b1000: 
          begin
            // Reg v_active
            rd_ack_d0 <= rd_req_int;
            rd_dat_d0[9:0] <= v_active_value_reg;
            rd_dat_d0[31:10] <= {22{1'b0}};
          end
        4'b1001: 
          begin
            // Reg v_total
            rd_ack_d0 <= rd_req_int;
            rd_dat_d0[9:0] <= v_total_value_reg;
            rd_dat_d0[31:10] <= {22{1'b0}};
          end
        4'b1010: 
          begin
            // Reg gfx_fifo
            rd_ack_d0 <= rd_req_int;
            rd_dat_d0 <= gfx_fifo_data_i;
          end
        default:
          rd_ack_d0 <= rd_req_int;
        endcase
      end
endmodule
