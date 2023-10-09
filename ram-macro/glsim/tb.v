`timescale 1ns/1ps

module tb();
   wire [1:0] qm;
   reg [1:0]  am, bm, ma, mb, mq;
   reg 	      reset, clk;
   
   maskmul dut(.am(am),
	       .bm(bm),
	       .ma(ma),
	       .mb(mb),
	       .mq(mq),
	       .reset(reset),
	       .clk(clk),
	       .qm(qm));
   
`ifdef USE_SDF
   initial
     begin
        $sdf_annotate("../syn/outputs/maskmul_delays.sdf",tb.dut,,"sdf.log","MAXIMUM");

     end
`endif

   always
     begin
	clk = 1'b0;
	#1;
	clk = 1'b1;
	#1;
     end
   
   initial
     begin
	
	$dumpfile("trace.vcd");
	$dumpvars(0, tb);

	reset = 1'b1;
	@(posedge clk);
	reset = 1'b0;
	
	repeat (500) 
	  begin
	     am = $random;
	     bm = $random;
	     ma = $random;
	     mb = $random;
	     mq = $random;
	     
	     @(posedge clk);
	     #1;
	     $display("%b %b %b %b %b qm %b", am, bm, ma, mb, mq, qm);
	  end
	
	$finish;
     end
   
endmodule
