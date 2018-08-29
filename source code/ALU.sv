
module ALU(input logic [31:0] a,b,
           input logic [1:0] ALUControl,
        output logic [31:0] Result,
        output logic [3:0] ALUFlags);
      
logic [31:0] c;
always_comb
 if(ALUControl[0]) c = ~b;
 else              c = b;

always_comb

  casez(ALUControl)
	2'b0? :  Result = a + c + ALUControl[0];
	2'b10 : Result = a & b;
	2'b11 : Result = a | b;
	default : Result = 32'bx;
  endcase
  
assign ALUFlags[0] = ((~a[31]) &(~c[31]) & Result[31])|((a[31]) &(c[31]) & (~Result[31]));
assign ALUFlags[2] = (Result ==0);
assign ALUFlags[3] = (Result[31] == 1);

always_comb
  if(ALUControl[1]) ALUFlags[1] = 0;
  else              ALUFlags[1] =  ((a[31]& c[31])|((a[31]^c[31])&(~Result[31])));

endmodule