module chip(
	    input 	  clk,
	    input 	  resetn,
	    input 	  valid,
	    input 	  wen,
	    input [7:0]  addr,
	    input [7:0]  wdata,
	    output [7:0] rdata,
            input        scan_enable,
            input        scan_in,
            output       scan_out);
   
   wire 		die_clk;
   wire 		die_resetn;
   wire 		die_valid;
   wire 		die_wen;
   wire [7:0]		die_addr;
   wire [7:0]		die_wdata;
   wire [7:0]		die_rdata;
   wire 		die_scan_enable;
   wire 		die_scan_in;
   wire 		die_scan_out;

   pads thepads(.clk   (clk),
		.resetn(resetn),
		.valid (valid),
		.wen   (wen),
		.addr  (addr),
		.wdata (wdata),
		.rdata (rdata),
		.scan_enable(scan_enable),
		.scan_in(scan_in),
		.scan_out(scan_out),

		.die_clk   (die_clk),
		.die_resetn(die_resetn),
		.die_valid (die_valid),
		.die_wen   (die_wen),
		.die_addr  (die_addr),
		.die_wdata (die_wdata),
		.die_rdata (die_rdata),
		.die_scan_enable(die_scan_enable),
		.die_scan_in(die_scan_in),
		.die_scan_out(die_scan_out)
		);

   picotop thecore (.clk(die_clk),
		    .resetn(die_resetn),
		    .valid(die_valid),
		    .wen(die_wen),
		    .addr(die_addr),
		    .wdata(die_wdata),
		    .rdata(die_rdata),
		    .scan_enable(die_scan_enable),
		    .scan_in(die_scan_in),
		    .scan_out(die_scan_out));
      
endmodule
   
