module ram_128x16A (A, 
		    D, 
		    OEN,
		    WEN, 
		    CLK, 
		    Q);
     
   input [ 6:0] A;
   input [15:0] D, Q;
   input 	OEN, WEN, CLK;

// black-box model for synthesis   

`ifdef SIMULATION
   reg [15:0] 	memory [0:127];
   reg [15:0] 	DATA_OUT;
   
    always @ (posedge CLK)
    begin
        if (WEN) begin
           memory[A] = D;
        end
       DATA_OUT = memory[A];
    end
   
   assign Q = OEN ? DATA_OUT : 16'bz;
   
`endif
   
endmodule
