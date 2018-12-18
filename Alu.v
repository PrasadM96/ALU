module ALU(Result,Data1,Data2,Select);
    
    //inputs,outputs and internal variables declared here
    input signed [7:0] Data1,Data2;//*************
    input [2:0] Select;
    output signed [7:0] Result;//**************
    
    wire signed [7:0] Reg1,Reg2;//************
    reg signed[7:0] Reg3;//**********
    
    //reg []
    
    //Assign A and B to internal variables for doing operations
    assign Reg1 = Data1;
    assign Reg2 = Data2;
   
    assign Result = Reg3; //Assign the output 



    always @(Select or Reg1 or Reg2) 
    begin
        case (Select)
          3'b000 : Reg3 = Reg1;
          3'b001 : Reg3 = Reg1 + Reg2;
          3'b010 : Reg3 = Reg1 & Reg2;
          3'b011 : Reg3 = Reg1 | Reg2;
        endcase 
        $display("%d %d  %d",Reg1,Reg2,Result);
    end    
endmodule

module testAlu;

    // Inputs
    reg [7:0] Data1;
    reg [7:0] Data2;
    reg [2:0] Select;

    // Outputs
    wire signed [7:0] Result;//**************************

    // Instantiate the Unit Under Test (UUT)
   // ALU alu (.Result(Result),.Data1(Data1),.Data2(Data2),.Select(Select));
    
   ALU alu (Result,Data1,Data2,Select);
   
    initial begin
        Data1 = 8'sb10000001; //input 1
        Data2 = 8'sb00111011; //input 2
        Select = 3'b000; #100;
        Select = 3'b001; #100;
        Select = 3'b010; #100;
        Select = 3'b011; #100;
      
    end
    
endmodule
