module tb;
   logic [3:0] x;
   logic [3:0] y;
   logic reset;
   logic clk;

   mavg dut(.x(x), .y(y), .reset(reset), .clk(clk));
   
   always
   begin
      clk = 1'b0;
      #5 clk = 1'b1;
      #5;
   end

   always_ff @(posedge clk)
   begin
      $display("x %d y %d", x, y);
   end
   
   initial
   begin
      $dumpfile("trace.vcd");
      $dumpvars(0, tb);
      x = 4'b0;
      reset = 1'b1;
      repeat(3)
         @(posedge clk);
      reset = 1'b0;
      
      repeat(5)
      begin
         x = 4'hf;
         repeat(6)
            @(posedge clk);
         x = 4'h0;
         repeat(6)
            @(posedge clk);
      end

      $finish;
   end
   
endmodule
