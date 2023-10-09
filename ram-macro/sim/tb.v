module tb();
   reg 	       clk;
   reg  [6:0]  address;
   reg  [15:0] data_in;
   wire [15:0] data_out;
   reg 	       oen;
   reg 	       wen;

   rampipe dut(.A(address),
	       .D(data_in),
	       .OEN(oen),
	       .WEN(wen),
	       .CLK(clk),
	       .Q(data_out));
   
   always
     begin
	clk = 1'b0;
	#5;
	clk = 1'b1;
	#5;
     end
   
   initial
     begin
	
	$dumpfile("trace.vcd");
	$dumpvars(0, tb);

	address = 7'd0;
	data_in = 10'd0;
	wen = 1'b1;
	oen = 1'b1;
	
	repeat (150) 
	  begin
	     @(posedge clk);
	     #1;
	     $display("ad %x di %x do %x", address, data_in, data_out);
	     address = address + 1'd1;	     
	     data_in = data_in + 1'd1;	     
	  end

	wen = 1'b0;
	oen = 1'b1;
	
	repeat (128) 
	  begin
	     @(posedge clk);
	     #1;
	     $display("ad %x di %x do %x", address, data_in, data_out);
	     address = address + 1'd1;	     
	  end
	
	$finish;
     end
   
endmodule
