`timescale 1ns/1ps

module lcd_controller
  (
   input 	    clk_i,
   input 	    rst_n_i,

   output reg 	    lcd_de_o,
   output reg 	    lcd_clk_o,
   output reg 	    lcd_hsync_o,
   output reg 	    lcd_vsync_o,
   output reg [1:0] lcd_r_o,
   output reg [1:0] lcd_g_o,
   output reg [1:0] lcd_b_o,

   input 	    r_pfifo_we_i,
   output 	    r_pfifo_full_o,
   input [31:0]     r_pfifo_data_i,

   input 	    r_enable_i,
   input [1:0] 	    r_page_sel_i,
   input [9:0] 	    r_h_f_porch_i,
   input [9:0] 	    r_h_b_porch_i,
   input [9:0] 	    r_h_total_i,
   input [9:0] 	    r_h_active_i,
   input [9:0] 	    r_v_f_porch_i,
   input [9:0] 	    r_v_b_porch_i,
   input [9:0] 	    r_v_active_i,
   input [9:0] 	    r_v_total_i,
   input [7:0] 	    r_clk_div_i

   );

   parameter g_gram_size = 320 * 240;

   reg [17:0]  lcd_ram_addr;
   wire [3:0]  lcd_ram_rdata;

   reg [17:0]  gfx_ram_addr;
   wire [3:0]  gfx_ram_rdata;
   reg [3:0]  gfx_ram_wdata;
   reg 	      gfx_ram_we;
   
   generic_dpram 
     #(
       .g_data_width(4),
       .g_size(g_gram_size),
       .g_dual_clock(0)
       )
   U_GRAM
     (
      .clka_i(clk_i),
      .clkb_i(clk_i),
      .rst_n_i(rst_n_i),
      .aa_i(lcd_ram_addr[16:0]),
      .qa_o(lcd_ram_rdata),
      .wea_i(1'b0),

      .ab_i(gfx_ram_addr[16:0]),
      .qb_o(gfx_ram_rdata),
      .db_i(gfx_ram_wdata),
      .web_i(gfx_ram_we)
      
      );

   wire pfifo_empty;
   reg 	pfifo_rd;
   wire [31:0] pfifo_rdata;

   
   generic_sync_fifo
     #(
       .g_data_width(32),
       .g_size      (128),
       .g_show_ahead(1),
       .g_almost_empty_threshold(10),
       .g_almost_full_threshold(120)
       ) 
   U_GFX_Fifo 
     (
      .rst_n_i (rst_n_i),

      .clk_i(clk_i),
      .d_i  (r_pfifo_data_i),
      .we_i (r_pfifo_we_i),

      .q_o  (pfifo_rdata),
      .rd_i (pfifo_rd),

      .empty_o(pfifo_empty),
      .full_o (r_pfifo_full_o)
      );

   reg [9:0]  lcd_h_count;
   reg [9:0]   lcd_v_count;

   reg [8:0]   lcd_clk_div_count;
   reg 	       lcd_clk_div_re;
   reg 	       lcd_clk_div_fe;
   

   // lcd clock generator
   always@(posedge clk_i)
     if (!r_enable_i)
       begin
	  lcd_clk_div_count <= 0;
	  lcd_clk_div_re <= 0;
	  lcd_clk_div_fe <= 1;
       end
     else
       begin
	  lcd_clk_div_count <= lcd_clk_div_count + 1;

	  if( lcd_clk_div_count == {r_clk_div_i, 1'b0} )
	    begin
	       lcd_clk_div_re <= 1;
	       lcd_clk_div_count <= 0;
	    end else if ( lcd_clk_div_count == {1'b0, r_clk_div_i} )
	      begin
		 lcd_clk_div_re <= 0;
		 lcd_clk_div_fe <= 1;
		 lcd_clk_div_count <= lcd_clk_div_count+1;
	      end else begin
		 lcd_clk_div_re <= 0;
		 lcd_clk_div_fe <= 0;
		 lcd_clk_div_count <= lcd_clk_div_count+1;
	      end
       end


   reg lcd_v_active;
   reg lcd_h_active;
   reg lcd_h_sync;
   reg lcd_v_sync;
   reg lcd_pixel;
   
   
   // display timing generator
   always@(posedge clk_i)
     if(!r_enable_i)
       begin
	  lcd_h_active <= 0;
	  lcd_v_active <= 0;
	  lcd_h_sync <= 0;
	  lcd_v_sync <= 0;
	  lcd_h_count <= 0;
	  lcd_v_count <= 0;
       end else begin

	  if (lcd_clk_div_re ) begin

	     if( lcd_h_count == r_h_f_porch_i)
	       begin
		  lcd_h_active <= 1;
		  lcd_h_count <= lcd_h_count + 1;
	       end
 	     else if ( lcd_h_count == r_h_active_i )
	       begin
		    lcd_h_active <= 0;
		    lcd_h_count <= lcd_h_count + 1;
		 end
 	     else if ( lcd_h_count == r_h_b_porch_i )
	       begin
		    lcd_h_sync <= 1;
		    lcd_h_count <= lcd_h_count + 1;
		 end
 	     else if ( lcd_h_count == r_h_total_i )
	       begin
		    lcd_h_sync <= 0;
		    lcd_h_count <= 0;
	       end
	     else
	       begin
		  lcd_h_count <= lcd_h_count + 1;
	       end
	     
	     if( lcd_h_count == r_h_total_i )
	       begin
		  lcd_h_count <= 0;
		  
		      if ( lcd_v_count == r_v_f_porch_i )
			begin
			   lcd_v_active <= 1;
			   lcd_v_count <= lcd_v_count + 1;
			end 
		      else if ( lcd_v_count == r_v_active_i )
			begin
			   lcd_v_active <= 0;
			   lcd_v_count <= lcd_v_count + 1;
			end
		      else if ( lcd_v_count == r_v_b_porch_i )
			begin
			   lcd_v_sync <= 1;
			   lcd_v_count <= lcd_v_count + 1;
			end
		      else if ( lcd_v_count == r_v_total_i )
			begin
			   lcd_v_sync <= 0;
			   lcd_v_count <= 0;
			end 
		      else 
			begin
			   lcd_v_count <= lcd_v_count + 1;
			end
		  
	       end // if ( lcd_h_count == r_h_total_i )
	  end // if (lcd_clk_div_fe )
       end // else: !if(!r_enable_i)
   

   always@(posedge clk_i)
     if (!r_enable_i)
       begin
	  lcd_ram_addr <= 0;
       end else begin
	  if(lcd_v_active && lcd_h_active && lcd_clk_div_re)
	    lcd_ram_addr <= lcd_ram_addr + 1;
	  else if (lcd_v_sync && lcd_h_sync && lcd_clk_div_re)
	    lcd_ram_addr <= 0;

	  if(lcd_v_active && lcd_h_active)
	    lcd_pixel <= lcd_ram_rdata[r_page_sel_i];
	  else
	    lcd_pixel <= 0;
       end
   

   always@(posedge clk_i)
     if(!r_enable_i)
       begin
	  lcd_de_o <= 0;
	  lcd_r_o <= 0;
	  lcd_g_o <= 0;
	  lcd_b_o <= 0;
	  lcd_hsync_o <=0;
	  lcd_vsync_o <=0;
	  lcd_clk_o <=0;
       end else begin
	  if(lcd_clk_div_re)
	    lcd_clk_o <= 1;
	  
	  if(lcd_clk_div_fe)
	    begin
	       lcd_clk_o <= 0;
	       lcd_vsync_o <= lcd_v_sync;
	       lcd_hsync_o <= lcd_h_sync;
	       lcd_de_o <= lcd_h_active && lcd_v_active;
	       lcd_r_o <= {lcd_pixel, lcd_pixel};
	       lcd_g_o <= {lcd_pixel, lcd_pixel};
	       lcd_b_o <= {lcd_pixel, lcd_pixel};
	    end
       end // else: !if(!r_enable_i)

   
   
	 
   wire [17:0] pfifo_addr = pfifo_rdata[17:0];
   wire [9:0]  pfifo_count = pfifo_rdata[27:18];
   wire [1:0]  pfifo_page = pfifo_rdata[29:28];
   wire        pfifo_pixel = pfifo_rdata[30];

   reg [3:0]  pfifo_page_mask;
   wire [3:0]  pfifo_pixel_value = {pfifo_pixel, pfifo_pixel,pfifo_pixel, pfifo_pixel};

   always@*
     case (pfifo_page)
       2'b00: pfifo_page_mask <= 4'b0001;
       2'b01: pfifo_page_mask <= 4'b0010;
       2'b10: pfifo_page_mask <= 4'b0100;
       2'b11: pfifo_page_mask <= 4'b1000;
       default: pfifo_page_mask <= 4'b0001;
     endcase // case (pfifo_page)
   
`define ST_IDLE 0
`define ST_FETCH 1
`define ST_EXECUTE 2
`define ST_WRITEBACK 3
	  
   reg [1:0]   gfx_state;
   reg [9:0]   gfx_count;
   reg [3:0]   gfx_page_mask;
   reg [3:0]   gfx_pixel_value;
   
   always@(posedge clk_i)
     if(!r_enable_i)
       begin
	  gfx_state <= `ST_IDLE;
	  gfx_ram_we <= 0;
	  gfx_ram_wdata <= 0;
	  pfifo_rd <= 0;
       end else begin
	  case (gfx_state)
	    `ST_IDLE: 
	      if (!pfifo_empty)
		begin
		   gfx_state <= `ST_FETCH;
		   gfx_ram_addr <= pfifo_addr;
		   gfx_count <= pfifo_count;
		   gfx_page_mask <= pfifo_page_mask;
		   gfx_pixel_value <= pfifo_pixel_value;
		   pfifo_rd <= 1;
		end

	    `ST_FETCH:
	      begin
		 pfifo_rd <= 0;
		 gfx_state <= `ST_EXECUTE;
	      end
	    

	    `ST_EXECUTE:
	      begin
		 gfx_ram_wdata <= gfx_ram_rdata & (~gfx_page_mask) | (gfx_pixel_value & gfx_page_mask);
		 gfx_ram_we <= 1;
		 gfx_count <= gfx_count - 1;
		 gfx_state <= `ST_WRITEBACK;
	      end
	    
	    `ST_WRITEBACK:
	      begin
		 gfx_ram_we <= 0;
		 gfx_ram_addr <= gfx_ram_addr + 1;
		 if (gfx_count == 0)
		   gfx_state <= `ST_IDLE;
		 else
		   gfx_state <= `ST_FETCH;
	      end
	  endcase // case (gfx_state)
       end // else: !if(!r_enable_i)
   
   
   
   

endmodule // lcd_controller

   
   
