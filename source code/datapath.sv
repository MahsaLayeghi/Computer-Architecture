
// ADD CODE BELOW
// Complete the datapath module below.
// The datapath unit is a structural SystemVerilog module. That is,
// it is composed of instances of its sub-modules. For example,
// the instruction register is instantiated as a 32-bit flopenr.
// The other submodules are likewise instantiated. 

module datapath(input  logic        clk, reset,
                output logic [31:0] Adr, WriteData,
                input  logic [31:0] ReadData,
                output logic [31:0] Instr,
                output logic [3:0]  ALUFlags,
                input  logic        PCWrite, RegWrite,
                input  logic        IRWrite,
                input  logic        AdrSrc, 
                input  logic [1:0]  RegSrc, 
                input  logic [1:0]  ALUSrcA, ALUSrcB, ResultSrc,
                input  logic [1:0]  ImmSrc, ALUControl);

  logic [31:0] PCNext, PC;
  logic [31:0] ExtImm, SrcA, SrcB, Result;
  logic [31:0] Data, RD1, RD2, A, ALUResult, ALUOut;
  logic [3:0]  RA1, RA2;
  //logic [31:0] Instr

	

  // ADD CODE HERE
  
  flopenr #(32)PCR (clk, reset, PCWrite , Result , PC );
  mux2  #(32)ADRmux ( PC , Result , AdrSrc , Adr );
  
  flopenr #(32)IR ( clk , reset, IRWrite , ReadData , Instr );
  flopr #(32)DR (clk , reset , ReadData , Data);
  
  mux2 #(4)RA1mux (Instr[19:16], 4'b1111, RegSrc[0] , RA1 );
  mux2 #(4)RA2mux (Instr[3:0] , Instr[15:12] , RegSrc[1] , RA2);
  
  regfile RegFile ( clk , RegWrite , RA1 , RA2 , Instr[15:12] , Result , Result , RD1, RD2);
  extend Ext (Instr[23:0] , ImmSrc , ExtImm);
  
	flopr #(32)RD1Reg(clk , reset, RD1 , A);
	flopr #(32)RD2Reg(clk , reset, RD2 , WriteData);
	
	mux3 #(32)SrcAmux(A, PC , ALUOut , ALUSrcA , SrcA);
	mux3 #(32)SrcBmux(WriteData , ExtImm , 32'b100 , ALUSrcB , SrcB);
	ALU ALU (SrcA , SrcB , ALUControl , ALUResult, ALUFlags );
	flopr #(32)ALUResReg(clk , reset , ALUResult , ALUOut);
	mux3 #(32)ALUOutmux( ALUOut , Data , ALUResult, ResultSrc, Result);
	
	
	
	
  

endmodule