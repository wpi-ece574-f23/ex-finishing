module pads(
	    input 	 clk,
	    input 	 resetn,
	    input 	 valid,
	    input 	 wen,
	    input [7:0]  addr,
	    input [7:0]  wdata,
	    output [7:0] rdata,
            input 	 scan_enable,
            input 	 scan_in,
            output 	 scan_out,

	    output 	 die_clk,
	    output 	 die_resetn,
	    output 	 die_valid,
	    output 	 die_wen,
	    output [7:0] die_addr,
	    output [7:0] die_wdata,
	    input [7:0]  die_rdata,
            output 	 die_scan_enable,
            output 	 die_scan_in,
            input 	 die_scan_out
	    );
   
   PADI clkpad   (.PAD(clk),   .OUT(die_clk));
   PADI resetnpad(.PAD(resetn), .OUT(die_resetn));
   PADI validpad (.PAD(valid), .OUT(die_valid));
   PADI wenpad   (.PAD(wen),   .OUT(die_wen));

   PADI scanenablepad (.PAD(scan_enable),   .OUT(die_scan_enable));
   PADI scaninpad  (.PAD(scan_in),   .OUT(die_scan_in));
   PADO scanoutpad (.IN(scan_out), .PAD(die_scan_out));

   PADI addrpad0 (.PAD(addr[0]), .OUT(die_addr[0]));
   PADI addrpad1 (.PAD(addr[1]), .OUT(die_addr[1]));
   PADI addrpad2 (.PAD(addr[2]), .OUT(die_addr[2]));
   PADI addrpad3 (.PAD(addr[3]), .OUT(die_addr[3]));
   PADI addrpad4 (.PAD(addr[4]), .OUT(die_addr[4]));
   PADI addrpad5 (.PAD(addr[5]), .OUT(die_addr[5]));
   PADI addrpad6 (.PAD(addr[6]), .OUT(die_addr[6]));
   PADI addrpad7 (.PAD(addr[7]), .OUT(die_addr[7]));
   
   PADI wdatapad0 (.PAD(wdata[0]), .OUT(die_wdata[0]));
   PADI wdatapad1 (.PAD(wdata[1]), .OUT(die_wdata[1]));
   PADI wdatapad2 (.PAD(wdata[2]), .OUT(die_wdata[2]));
   PADI wdatapad3 (.PAD(wdata[3]), .OUT(die_wdata[3]));
   PADI wdatapad4 (.PAD(wdata[4]), .OUT(die_wdata[4]));
   PADI wdatapad5 (.PAD(wdata[5]), .OUT(die_wdata[5]));
   PADI wdatapad6 (.PAD(wdata[6]), .OUT(die_wdata[6]));
   PADI wdatapad7 (.PAD(wdata[7]), .OUT(die_wdata[7]));
   
   PADO rdatapad0 (.IN(die_rdata[0]), .PAD(rdata[0]));
   PADO rdatapad1 (.IN(die_rdata[1]), .PAD(rdata[1]));
   PADO rdatapad2 (.IN(die_rdata[2]), .PAD(rdata[2]));
   PADO rdatapad3 (.IN(die_rdata[3]), .PAD(rdata[3]));
   PADO rdatapad4 (.IN(die_rdata[4]), .PAD(rdata[4]));
   PADO rdatapad5 (.IN(die_rdata[5]), .PAD(rdata[5]));
   PADO rdatapad6 (.IN(die_rdata[6]), .PAD(rdata[6]));
   PADO rdatapad7 (.IN(die_rdata[7]), .PAD(rdata[7]));
   
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
