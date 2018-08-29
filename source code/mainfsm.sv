
module mainfsm(input  logic         clk,
               input  logic         reset,
               input  logic [1:0]   Op,
               input  logic [5:0]   Funct,
               output logic         IRWrite,
               output logic         AdrSrc,
               output logic [1:0]   ALUSrcA, ALUSrcB, ResultSrc,
               output logic         NextPC, RegW, MemW, Branch, ALUOp);  
              
  typedef enum logic [3:0] {FETCH, DECODE, MEMADR, MEMRD, MEMWB, 
                            MEMWR, EXECUTER, EXECUTEI, ALUWB, BRANCH, 
				     UNKNOWN} statetype;
  
  statetype state, nextstate;
  logic [12:0] controls;
  
  // state register
  always @(posedge clk or posedge reset)
    if (reset) state <= FETCH;
    else state <= nextstate;
  
  // ADD CODE BELOW
  // Finish entering the next state logic below.  We've completed the 
  // first two states, FETCH and DECODE, for you.

  // next state logic
  always_comb
    casex(state)
      FETCH:                     nextstate = DECODE;
      DECODE: case(Op)
                2'b00: 
                  if (Funct[5])  nextstate = EXECUTEI;
                  else           nextstate = EXECUTER;
                2'b01:           nextstate = MEMADR;
                2'b10:           nextstate = BRANCH;
                default:         nextstate = UNKNOWN;
              endcase
      EXECUTER:						nextstate = ALUWB;                 
      EXECUTEI: 						nextstate = ALUWB;                 
      MEMADR: if(Funct[0]) 		nextstate = MEMRD;
					else 					nextstate = MEMWR;
      MEMRD:							nextstate = MEMWB;
		
      default:                   nextstate = FETCH; 
    endcase
    
  // ADD CODE BELOW
  // Finish entering the output logic below.  We've entered the
  // output logic for the first two states, FETCH and DECODE, for you.

  // state-dependent output logic
  always_comb
    case(state)
      FETCH: 	   controls = 13'b10001_010_01100; 
      DECODE:  	controls = 13'b00000_010_01100;      
      EXECUTER: 	controls = 13'b00000_xxx_00001;
      EXECUTEI: 	controls = 13'b00000_xxx_00011;
      ALUWB: 		controls = 13'b00010_x00_xxxxx;
      MEMADR: 		controls = 13'b00000_xxx_00010;
      MEMWR: 		controls = 13'b00100_100_xxxxx;
      MEMRD: 		controls = 13'b00000_100_xxxxx;
      MEMWB: 		controls = 13'b00010_x01_xxxxx;
      BRANCH: 		controls = 13'b01000_x10_10010;
      default: 	controls = 13'bxxxxx_xxx_xxxxx;
    endcase

  assign {NextPC, Branch, MemW, RegW, IRWrite,
          AdrSrc, ResultSrc,   
          ALUSrcA, ALUSrcB, ALUOp} = controls;
endmodule              