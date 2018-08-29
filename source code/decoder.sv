module decoder(input  logic       clk, reset,
              input  logic [1:0] Op,
              input  logic [5:0] Funct,
              input  logic [3:0] Rd,
              output logic [1:0] FlagW,
              output logic       PCS, NextPC, RegW, MemW,
              output logic       IRWrite, AdrSrc,
              output logic [1:0] ResultSrc, ALUSrcA, ALUSrcB, 
              output logic [1:0] ImmSrc, RegSrc, ALUControl);

  logic       Branch, ALUOp;

  // Main FSM
  mainfsm fsm(clk, reset, Op, Funct, 
              IRWrite, AdrSrc, 
              ALUSrcA, ALUSrcB, ResultSrc,
              NextPC, RegW, MemW, Branch, ALUOp);

  // ADD CODE BELOW
  // Add code for the ALU Decoder and PC Logic.
  // Remember, you may reuse code from the book.
  // ALU Decoder
  
always_comb
if (ALUOp) begin 				// which DP Instr? 
	  case(Funct[4:1]) 
				4'b0100: ALUControl = 2'b00; // ADD 
				4'b0010: ALUControl = 2'b01; // SUB
				4'b0000: ALUControl = 2'b10; // AND
				4'b1100: ALUControl = 2'b11; // ORR
				
				default: ALUControl = 3'bx; // unimplemented
	  endcase
	  

 // update flags if S bit is set (C & V only for arith) 
 FlagW[1] = Funct[0];
 FlagW[0] = Funct[0] &
   (ALUControl == 2'b00 | ALUControl == 2'b01); 
end else begin 
 ALUControl = 2'b00; // add for non-DP instructions
 FlagW = 2'b00; // don't update Flags 
end



  // PC Logic 
  assign PCS = ((Rd == 4'b1111) & RegW) | Branch; 

  // Add code for the Instruction Decoder (Instr Decoder) below.
  // Recall that the input to Instr Decoder is Op, and the outputs are
  // ImmSrc and RegSrc. We've completed the ImmSrc logic for you.

  // Instr Decoder
  assign ImmSrc    = Op;
  assign RegSrc[1] = ((Op[0]) & (~Op[1]));
  assign RegSrc[0] = ((~Op[0]) & (Op[1]));
  
 
 
 

endmodule