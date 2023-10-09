module rampipe(input wire [6:0]   A,
	       input wire [15:0]  D,
	       input wire 	  OEN,
	       input wire 	  WEN,
	       input wire 	  CLK,
	       output wire [15:0] Q);

   wire [15:0] 			  pipe_next;
   reg [15:0] 			  pipe;
   
   ram_128x16A ram(.A(A),
		  .D(D),
		  .OEN(OEN),
		  .WEN(WEN),
		  .CLK(CLK),
		  .Q(pipe_next));

   always @(posedge CLK)
     pipe <= pipe_next;

   assign Q = pipe;
   
endmodule 

   
