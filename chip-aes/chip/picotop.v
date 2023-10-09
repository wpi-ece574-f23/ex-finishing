module picotop (
    input clk,
    input resetn,
    input valid,
    input wen,
    input  [7:0] addr,
    input  [7:0] wdata,
    output [7:0] rdata,
    input  scan_enable,
    input  scan_in,
    output scan_out
);

   wire [6:0] 	 localaddr;
   wire [31:0] 	 localwdata;
   wire [31:0] 	 localrdata;
   
   picoaes aes(.clk(clk),
	       .resetn(resetn),
	       .valid(valid),
	       .wen(wen),
	       .addr(localaddr),
	       .wdata(localwdata),
	       .rdata(localrdata),
	       .SE(scan_enable),
	       .scan_in(scan_in),
	       .scan_out(scan_out));

   assign localaddr[5:0] = addr[5:0];
   assign localaddr[6]   = |addr[7:6];

   assign localwdata[7:0]   = wdata[7:0];
   assign localwdata[15:8]  = wdata[7:0];
   assign localwdata[23:16] = wdata[7:0];
   assign localwdata[31:24] = wdata[7:0];
   
   assign rdata[7:0] = localrdata[7:0] |
		       localrdata[15:8] |
		       localrdata[23:16] |
		       localrdata[31:24];

endmodule
