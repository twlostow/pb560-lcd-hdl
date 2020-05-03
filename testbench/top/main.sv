`timescale 1ns/1ps

module dummy;
   covidlcd_top_cmod_a7 DUT();
endmodule // dummy


   

module main;

   reg clk = 0;
   reg rst = 1;

   initial #100ns rst <=0;
   
   parameter time g_clk_period = 83.333ns;

   always #(g_clk_period/2) clk <= ~clk;
   wire [1:0] 	  btn;

   assign btn[1] = 0;
   assign btn[0] = ~rst;
   
   covidlcd_top_cmod_a7
     #( 
	.g_cpu_firmware("../../sw/bootloader/boot.bram"),
	.g_simulation(1)
	)
   DUT 
     (
      .sysclk_12m_i(clk),
      .btn_i(btn)

      );

   initial begin
      #100us;
      $stop;
      
      
   end

endmodule
