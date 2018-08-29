module condlogic(input  logic       clk, reset,
                 input  logic [3:0] Cond,
                 input  logic [3:0] ALUFlags,
                 input  logic [1:0] FlagW,
                 input  logic       PCS, NextPC, RegW, MemW,
                 output logic       PCWrite, RegWrite, MemWrite);

  logic [1:0] FlagWrite;
  logic [3:0] Flags;
  logic       CondEx;
  logic 		  CondExD;
  


  // Delay writing flags until ALUWB state
 // flopr #(2)flagwritereg(clk, reset, FlagW&{2{CondEx}}, FlagWrite);

  // ADD CODE HERE
  
  assign FlagWrite = FlagW &{2{CondEx}};
  
	flopenr #(2)flagreg1(clk, reset, FlagWrite[1],
							ALUFlags[3:2], Flags[3:2]); 
	flopenr #(2)flagreg0(clk, reset, FlagWrite[0],
							ALUFlags[1:0], Flags[1:0]);
							
  condcheck cc(Cond, Flags, CondEx);
  
  flopr #(1)condReg(clk , reset , CondEx , CondExD); 
  
  
  assign RegWrite = RegW & CondExD;
  
  assign MemWrite = MemW & CondExD; 
  
  assign PCSrc = PCS & CondExD; 
  
  assign PCWrite = PCSrc | NextPC;
  

endmodule    
