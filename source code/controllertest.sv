module controllertest();
logic clk;
logic reset;
logic [31:0] Instr;
logic [3:0] ALUFlags; 
logic PCWrite , MemWrite , RegWrite , IRWrite ,AdrSrc;
logic [1:0]   RegSrc;
logic [1:0]   ALUSrcA;
logic [1:0]   ALUSrcB;
logic [1:0]   ResultSrc;
logic [1:0]   ImmSrc;
logic [1:0]   ALUControl;

// instantiate device to be tested
controller uut(clk, reset, Instr[31:12], ALUFlags, 
               PCWrite, MemWrite, RegWrite, IRWrite,
               AdrSrc, RegSrc, ALUSrcA, ALUSrcB, ResultSrc,
               ImmSrc, ALUControl);

// initialize test 
initial 
begin
 reset <= 1;
 # 20; reset <= 0;
 /*
 #10;
 Instr <= 32'hE04F000F; // SUB - DPR E04F000F
 ALUFlags <= 4'b0000;
 #60;
 
 reset <= 1;
 #20; reset <= 0;
 
 #10;
 Instr <= 32'hE2802005; // ADD -DPI
 ALUFlags <= 4'b0000;
 #60
 
  reset <= 1;
 #20; reset <= 0;
 
 #10;
 Instr <= 32'hE1874002; // ORR - DPR 
 ALUFlags <= 4'b0000;
 #60
 
  reset <= 1;
 #20; reset <= 0;
 
 #10;
 Instr <= 32'hE0035004; // AND -DPR
 ALUFlags <= 4'b0000;
 #60
 
  reset <= 1;
 #20; reset <= 0;
 
 #10;
 Instr <= 32'hE280200A; // ADD -DPI
 ALUFlags <= 4'b0000;
 #60
*/
  reset <= 1;
 #20; reset <= 0;
 
 Instr <= 32'hE5902060;// LDR
 ALUFlags <=4'b0000;
 #120;

   reset <= 1;
 #20; reset <= 0;
 

 Instr <= 32'hE5802064;// STR
 ALUFlags <=4'b0000;
 #60; 
 /*
   reset <= 1;
 #20; reset <= 0;
 
 Instr <= 32'h0A00000C;// BEQ - not taken
 ALUFlags <=4'b0000;
 #60;
 
   reset <= 1;
 #20; reset <= 0;
 

  Instr <= 32'h0A00000C;// BEQ - taken
 ALUFlags <=4'b0100;
 #60;
 */
end

// generate clock to sequence tests 
always 
begin
 clk <= 1; # 5; clk <= 0; # 5; 
end

endmodule
