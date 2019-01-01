module ALU(Result,Data1,Data2,Select);
    
    //inputs,outputs and internal variables declared here
    input  [7:0] Data1,Data2;
    input [2:0] Select;
    output  [7:0] Result;
    
    wire  [7:0] Reg1,Reg2;
    reg [7:0] Reg3;
    

    
    //Assign A and B to internal variables for doing operations
    assign Reg1 = Data1;
    assign Reg2 = Data2;
   
    assign Result = Reg3; //Assign the output 



    always @(Select or Reg1 or Reg2) 
    begin
        case (Select)
          3'b000 : Reg3 <= Reg1;
          3'b001 : Reg3 <= Reg1 + Reg2;
          3'b010 : Reg3 <= Reg1 & Reg2;
          3'b011 : Reg3 <= Reg1 | Reg2;
        endcase 
       
    end    
endmodule


module reg_file(IN, OUT1, OUT2, INaddr, OUT1addr, OUT2addr, CLK);

input[7:0] IN;
input[2:0] INaddr,OUT1addr,OUT2addr;
input wire RESET,CLK;
output reg [7:0] OUT1,OUT2;

reg[7:0] R0,R1,R2,R3,R4,R5,R6,R7;
 initial begin
  R0 = 8'b00000000;
  R1 = 8'b00000000;
  R2 = 8'b00000000;
  R3 = 8'b00000000;
  R4 = 8'b00000000;
  R5 = 8'b00000000;
  R6 = 8'b00000000;
  R7 = 8'b00000000;
end
always @(posedge RESET) begin
  R0 = 8'b00000000;
  R1 = 8'b00000000;
  R2 = 8'b00000000;
  R3 = 8'b00000000;
  R4 = 8'b00000000;
  R5 = 8'b00000000;
  R6 = 8'b00000000;
  R7 = 8'b00000000;
end



always @(negedge CLK) begin
   case(INaddr)
    3'b000:R0=IN;
    3'b001:R1=IN;
    3'b010:R2=IN;
    3'b011:R3=IN;
    3'b100:R4=IN;
    3'b101:R5=IN;
    3'b110:R6=IN;
    3'b111:R7=IN;
   endcase
end


always @(posedge CLK) begin
   case(OUT1addr)
    3'b000:OUT1=R0;
    3'b001:OUT1=R1;
    3'b010:OUT1=R2;
    3'b011:OUT1=R3;
    3'b100:OUT1=R4;
    3'b101:OUT1=R5;
    3'b110:OUT1=R6;
    3'b111:OUT1=R7;
    default:OUT1=0;
   endcase

   case(OUT2addr)
    3'b000:OUT2=R0;
    3'b001:OUT2=R1;
    3'b010:OUT2=R2;
    3'b011:OUT2=R3;
    3'b100:OUT2=R4;
    3'b101:OUT2=R5;
    3'b110:OUT2=R6;
    3'b111:OUT2=R7;
      default:OUT2=0;
   endcase
end
endmodule
/*


module reg_file(IN, OUT1, OUT2, INaddr, OUT1addr, OUT2addr, CLK);

input CLK;
input [7:0] IN;
output [7:0] OUT1,OUT2;
input [2:0] INaddr,OUT1addr,OUT2addr;
reg [7:0] reg0, reg1, reg2, reg3,reg4,reg5,reg6,reg7;

assign OUT1 = (OUT1addr==3'b000)?reg0:
(OUT1addr==3'b001)?reg1:
(OUT1addr==3'b010)?reg2:
(OUT1addr==3'b011)?reg3:
(OUT1addr==3'b100)?reg4:
(OUT1addr==3'b101)?reg5:
(OUT1addr==3'b110)?reg6:
(OUT1addr==3'b111)?reg7:0;
// add until 8 //
assign OUT2 = OUT2addr == 0 ? reg0 :
OUT2addr == 1 ? reg1 :
OUT2addr == 2 ? reg2 :
OUT2addr == 3 ? reg3 :
OUT2addr == 4 ? reg4 :
OUT2addr == 5 ? reg5 :
OUT2addr == 6 ? reg6 :
OUT2addr == 7 ? reg7 :0;
//add until 8//
always @(negedge CLK) 
begin
case(INaddr)
3'b000:reg0=IN;
3'b001:reg1=IN;
3'b010:reg2=IN;
3'b011:reg3=IN;
3'b100:reg4=IN;
3'b101:reg5=IN;
3'b110:reg6=IN;
3'b111:reg7=IN;
// your code here
endcase
end // always @ (negedgeclk)
endmodule

*/
////////////////////////



module compliment(out,in);
	input [7:0] in;
	output [7:0] out;
	reg [7:0] comp=8'b11111111;
	assign out=(comp-in)+8'b00000001;
endmodule



module pgcounter (Read_Addr,CLK, RESET);
	input CLK;
	input RESET;
	output reg [2:0] Read_Addr=0;
	
	always @(negedge CLK)
	if(!RESET) 
	begin
		Read_Addr<=Read_Addr+3'd001;
	end
	else 
	begin
		Read_Addr<=0;	
	end
endmodule


module Instruction_reg (instruction,CLK, Read_Addr );
	input CLK;
	input [2:0] Read_Addr;
	output reg [31:0] instruction;
	
	
	
	reg [31:0] addr1 = 32'b00001000000001000000000011111111;		// loadi 4 X 0xFF(255)
	reg [31:0] addr2 = 32'b00001000000001100000000010101010;		// loadi 6 X 0xAA(170)
	reg [31:0] addr3 = 32'b00001000000000110000000010111011;		// loadi 3 X 0xBB(187)
	reg [31:0] addr4 = 32'b00000001000001010000011000000011;		// add   5 6 3
	reg [31:0] addr5 = 32'b00000010000000010000010000000101;		// and   1 4 5
	reg [31:0] addr6 = 32'b00000011000000100000000100000110;		// or    2 1 6 
	reg [31:0] addr7 = 32'b00000000000001110000000000000010;		// mov   7 x 2
	reg [31:0] addr8 = 32'b00001001000001000000011100000011;		// sub   4 7 3


	always @(negedge CLK) 
	begin
		case (Read_Addr)
			3'd0:instruction = addr1;
			3'd1:instruction = addr2;
			3'd2:instruction = addr3;
			3'd3:instruction = addr4;
			3'd4:instruction = addr5;
			3'd5:instruction = addr6;
			3'd6:instruction = addr7;
			3'd7:instruction = addr8;
			
		endcase
	end
	
endmodule

//select in1 or in2
module MUX(out,select,in1,in2);
	input [7:0] in1,in2;
	output reg [7:0] out;
	input select,CLK;
	
	always @*
	begin
		if(select==1)
			out=in1;
		else
			out=in2;
	end
		
endmodule


module CU(OUT1addr,OUT2addr, INaddr,immVal,Select,immSignal,compSignal,instruction);
	input [31:0] instruction;
	output reg [7:0] immVal;
	output reg immSignal;
	output reg [2:0] Select;
	output reg [2:0] OUT1addr;
	output reg [2:0] OUT2addr;
	output reg [2:0] INaddr;
	output reg compSignal;
	
	always @(instruction)
	begin
		
		immVal=instruction[7:0];
		Select = instruction[26:24];
		INaddr = instruction[18:16];
		OUT2addr = instruction[2:0];
		OUT1addr = instruction[10:8];
		immSignal = 1'b0;
		compSignal = 1'b0;
		case(instruction[31:24])
			8'b00001000:immSignal=1'b1;
			8'b00001001:compSignal=1'b1;
			default:;
		endcase
	end
endmodule


module processor(OUT1,OUT2,Data2,Result,mux1,mux2,immVal,CLK,RESET,Select);
	output [2:0] Select; 
	input RESET,CLK;
	output[7:0] OUT1,OUT2,Data2,Result,mux1,mux2,immVal;
	wire [31:0] instruction;
	wire [2:0] Read_Addr,OUT1addr,OUT2addr,INaddr;
	wire compSignal,immSignal;
	
	pgcounter counter(Read_Addr,CLK, RESET);
	Instruction_reg IR(instruction,CLK, Read_Addr );
	CU cu(OUT1addr,OUT2addr, INaddr,immVal,Select,immSignal,compSignal,instruction);
	reg_file register(Result, OUT1, OUT2, INaddr, OUT1addr, OUT2addr, CLK);
	
	
	compliment comp(Data2,OUT2);
	MUX mux3(mux1,compSignal,Data2,OUT2);
	MUX mux4(mux2,immSignal,immVal,mux1);
	ALU alu(Result,mux2,OUT1,Select);
	reg_file register1(Result, OUT1, OUT2, INaddr, OUT1addr, OUT2addr, CLK);
	
endmodule





module testProcessor;
	wire[2:0] Select;
	reg CLK,RESET;
	wire [7:0] OUT1,OUT2,Data2,Result,mux1,mux2,immVal;
	
	initial
 $monitor("Res=%d Out1=%d Out2=%b D2=%b mux1=%b imm=%d mux2=%d Select=%b clk=%b R=%b",Result,OUT1,OUT2,Data2,mux1,immVal,mux2,Select,CLK,RESET);
	
	processor proc(OUT1,OUT2,Data2,Result,mux1,mux2,immVal,CLK,RESET,Select);
	
	
	initial
	begin
		CLK=1'b1;
		RESET=0;
	end

	always #5 CLK=~CLK;
	
	initial
	begin
		#80 $finish;
	end
	
endmodule



