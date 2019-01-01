module reg_file(IN, OUT1, OUT2, INaddr, OUT1addr, OUT2addr, CLK, RESET);

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
   endcase
end
endmodule

module testreg;
 reg[7:0] IN;
 reg[2:0] INaddr,OUT1addr,OUT2addr;
 reg RESET,CLK;
 wire [7:0] OUT1,OUT2;

  reg_file register (IN, OUT1, OUT2, INaddr, OUT1addr, OUT2addr, CLK, RESET);
  
  initial begin
    RESET = 1'b0;
    INaddr = 3'b000;OUT1addr= 3'b000;OUT2addr= 3'b010;IN= 8'b11001100;
    #5
    $monitor(" IN = %b, OUT1= %b, OUT2= %b,INaddr= %b,OUT1addr= %b,OUT2addr= %b,CLK= %b,RESET= %b, ",IN, OUT1, OUT2, INaddr, OUT1addr, OUT2addr, CLK, RESET);
    CLK =1'b1;
    #5;
    CLK =1'b0;
    #5;
    CLK =1'b1;
    #5;
    INaddr = 3'b011;OUT1addr= 3'b000;OUT2addr= 3'b011;IN= 8'b11001110;
    #5
    CLK =1'b0;
    #5
    CLK =1'b1;
 end
endmodule
