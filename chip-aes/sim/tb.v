`define AES_KEY 128'hfb0b38bcad60b76c73377dfd9ce5692f

`define AES_PLAINTEXT1  128'h16b576b600a49804d81267644b80e292
`define AES_CIPHERTEXT1 128'h33b661a74d164dc7b811f54fe5a5832c

`define AES_PLAINTEXT2  128'hfb8587bdac1c369369173bceb2ed4785
`define AES_CIPHERTEXT2 128'h2287d7fc410a4e2059c15b4a2a2b3375

module tb();
   reg clk;
   reg resetn;
   reg valid;
   reg wen;
   reg [6:0] addr;
   reg [31:0] wdata;
   wire [31:0] rdata;

   localparam 
     CTRL_ADDR  = 32'h00000000,  // Control register
     KEYW0_ADDR = 32'h00000004,  // Key word 0
     KEYW1_ADDR = 32'h00000008,  // Key word 1
     KEYW2_ADDR = 32'h0000000C,  // Key word 0 
     KEYW3_ADDR = 32'h00000010,  // Key word 0 
     PTW0_ADDR = 32'h00000014,   // PT word 0
     PTW1_ADDR = 32'h00000018,   // PT word 1
     PTW2_ADDR = 32'h0000001C,   // PT word 2
     PTW3_ADDR = 32'h00000020,   // PT word 3
     IVW0_ADDR = 32'h00000024,   // IV word 0
     IVW1_ADDR = 32'h00000028,   // IV word 1
     IVW2_ADDR = 32'h0000002C,   // IV word 2
     IVW3_ADDR = 32'h00000030,   // IV word 3
     CTW0_ADDR = 32'h00000034,   // CT word 0
     CTW1_ADDR = 32'h00000038,   // CT word 1
     CTW2_ADDR = 32'h0000003C,   // CT word 2
     CTW3_ADDR = 32'h00000040,   // CT word 3
     STATUS_ADDR = 32'h00000044; // Status reg
   
   localparam 
     CTRL_SOFT_RST_BIT = 0,
     CTRL_INPUTS_VALID_BIT = 1,
     CTRL_ENCDEC_BIT = 2,
     CTRL_AESMODE_LSB = 3,
     CTRL_AESMODE_MSB = 4,
     CTRL_REG_SIZE = CTRL_AESMODE_MSB+1;
   
   localparam 
     AES_MODE_ECB = 2'b00,
     AES_MODE_CBC = 2'b01;

   reg [127:0] state;
   reg [127:0] key;
   reg [127:0] out;

   picoaes dut(.clk(clk),
	       .resetn(resetn),
	       .valid(valid),
	       .wen(wen),
	       .addr(addr),
	       .wdata(wdata),
	       .rdata(rdata));   
   
   always
     begin
	clk = 1'b0;
	#5;
	clk = 1'b1;
	#5;
     end
   
   reg     op_running;
   
   initial
     begin
	
	$dumpfile("trace.vcd");
	$dumpvars(0, tb);

	valid = 1'b1;
	clk   = 1'b0;
	resetn  = 1'b0;
	wen   = 1'b0;
	
	@ (negedge clk);
	
	state  = `AES_PLAINTEXT1; 
	key    = `AES_KEY;
	resetn    = 1'b1;
	
	addr    = KEYW3_ADDR;
	wdata   = key[31:0];
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	addr    = KEYW2_ADDR;
	wdata   = key[63:32];
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wdata   = key[95:64];
	addr    = KEYW1_ADDR;
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wdata   = key[127:96];
	addr    = KEYW0_ADDR;
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wdata   = state[31:0];
	addr    = PTW3_ADDR;
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wdata   = state[63:32];
	addr    = PTW2_ADDR;
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wdata   = state[95:64];
	addr    = PTW1_ADDR;
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wdata   = state[127:96];
	addr    = PTW0_ADDR;
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wdata   = 32'h6;
	addr    = CTRL_ADDR;
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wdata   = 32'h6;
	addr    = CTRL_ADDR;
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wdata   = 32'h4;      
	addr    = CTRL_ADDR;
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wdata   = 32'h4;      
	addr    = CTRL_ADDR;
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wen     = 1'b0;
	addr    = CTRL_ADDR;
	@ (posedge clk);
	#1 ;
	
	op_running = 1'b1;
	while (op_running)
          begin
             wen     = 1'b0;
             addr    = STATUS_ADDR;
             @ (negedge clk);
             op_running = ((rdata & 32'h1) == 0);
             @ (posedge clk);	    
          end
	
	wen     = 1'b0;
	addr    = CTRL_ADDR;
	@ (posedge clk);
	#1 ;
	
	addr        = CTW3_ADDR;
	wen         = 1'b0;
	@ (negedge clk) ;
	out[31:0]   = rdata;
	@ (posedge clk);
	#1 ;
	
	addr        = CTW2_ADDR;
	wen         = 1'b0;
	@ (negedge clk);
	out[63:32]  = rdata;
	@ (posedge clk);
	#1 ;
	
	addr        = CTW1_ADDR;
	wen         = 1'b0;
	@ (negedge clk);
	out[95:64]  = rdata;
	@ (posedge clk);
	#1 ;
	
	addr        = CTW0_ADDR;
	wen         = 1'b0;
	@ (negedge clk);
	out[127:96] = rdata;
	@ (posedge clk);
	#1 ;
	
	@(negedge clk);
	
	$display("Plaintext:  %x", state);
	$display("Key:        %x", key);
	$display("Ciphertext: %x", out);
	
	if (out !== `AES_CIPHERTEXT1)
          $display("Ciphertext ERROR - expected %x", `AES_CIPHERTEXT1); 
	else
	  $display("Ciphertext CORRECT");
	
	repeat(5) @(posedge clk);
	
	@ (negedge clk);
	
	state  = `AES_PLAINTEXT2; 
	key    = `AES_KEY;
	resetn    = 1'b1;
	
	addr    = KEYW3_ADDR;
	wdata   = key[31:0];
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	addr    = KEYW2_ADDR;
	wdata   = key[63:32];
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wdata   = key[95:64];
	addr    = KEYW1_ADDR;
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wdata   = key[127:96];
	addr    = KEYW0_ADDR;
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wdata   = state[31:0];
	addr    = PTW3_ADDR;
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wdata   = state[63:32];
	addr    = PTW2_ADDR;
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wdata   = state[95:64];
	addr    = PTW1_ADDR;
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wdata   = state[127:96];
	addr    = PTW0_ADDR;
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wdata   = 32'h6;
	addr    = CTRL_ADDR;
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wdata   = 32'h6;
	addr    = CTRL_ADDR;
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wdata   = 32'h4;      
	addr    = CTRL_ADDR;
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wdata   = 32'h4;      
	addr    = CTRL_ADDR;
	wen     = 1'b1;
	@ (posedge clk);
	#1 ;
	
	wen     = 1'b0;
	addr    = CTRL_ADDR;
	@ (posedge clk);
	#1 ;
	
	op_running = 1'b1;
	while (op_running)
          begin
             wen     = 1'b0;
             addr    = STATUS_ADDR;
             @ (negedge clk);
             op_running = ((rdata & 32'h1) == 0);
             @ (posedge clk);	    
          end
	
	wen     = 1'b0;
	addr    = CTRL_ADDR;
	@ (posedge clk);
	#1 ;
	
	addr        = CTW3_ADDR;
	wen         = 1'b0;
	@ (negedge clk) ;
	out[31:0]   = rdata;
	@ (posedge clk);
	#1 ;
	
	addr        = CTW2_ADDR;
	wen         = 1'b0;
	@ (negedge clk);
	out[63:32]  = rdata;
	@ (posedge clk);
	#1 ;
	
	addr        = CTW1_ADDR;
	wen         = 1'b0;
	@ (negedge clk);
	out[95:64]  = rdata;
	@ (posedge clk);
	#1 ;
	
	addr        = CTW0_ADDR;
	wen         = 1'b0;
	@ (negedge clk);
	out[127:96] = rdata;
	@ (posedge clk);
	#1 ;
	
	@(negedge clk);
	
	$display("Plaintext:  %x", state);
	$display("Key:        %x", key);
	$display("Ciphertext: %x", out);
	
	if (out !== `AES_CIPHERTEXT2)
          $display("Ciphertext ERROR - expected %x", `AES_CIPHERTEXT2); 
	else
	  $display("Ciphertext CORRECT");
	
	
	$finish;
     end
   
endmodule
