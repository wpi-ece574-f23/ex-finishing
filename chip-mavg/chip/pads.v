module pads(
	    input wire 	      clk,
	    input wire 	      reset,
	    input wire 	      x0,
	    input wire 	      x1,
	    input wire 	      x2,
	    input wire 	      x3,
	    output wire       y0,
	    output wire       y1,
	    output wire       y2,
	    output wire       y3,

	    output wire       die_clk,
	    output wire       die_reset,
	    output wire [3:0] die_x,
	    input wire [3:0]  die_y);

   PADI clkpad(.PAD(clk), .OUT(die_clk));
   PADI resetpad(.PAD(reset), .OUT(die_reset));

   PADI x0pad(.PAD(x0), .OUT(die_x[0]));
   PADI x1pad(.PAD(x1), .OUT(die_x[1]));
   PADI x2pad(.PAD(x2), .OUT(die_x[2]));
   PADI x3pad(.PAD(x3), .OUT(die_x[3]));

   PADO y0pad(.IN(die_y[0]), .PAD(y0));
   PADO y1pad(.IN(die_y[1]), .PAD(y1));
   PADO y2pad(.IN(die_y[2]), .PAD(y2));
   PADO y3pad(.IN(die_y[3]), .PAD(y3));

   PADCORNER ul();
   PADCORNER ur();
   PADCORNER ll();
   PADCORNER lr();

   PADVDD1 vdd1();
   PADVDD1 vdd2();
   PADVDD1 vdd3();
   PADVDD1 vdd4();

   PADVSS1 vss1();
   PADVSS1 vss2();
   PADVSS1 vss3();
   PADVSS1 vss4();
   
endmodule

module PADI(input wire PAD, output wire OUT);
   assign OUT = PAD;
endmodule 

module PADO(output wire PAD, input wire IN);
   assign PAD = IN;
endmodule 

module PADVSS1();
endmodule 

module PADVDD1();
endmodule 

module PADCORNER();
endmodule
