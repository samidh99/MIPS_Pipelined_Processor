module Instruction_Memory( input [7:0] PC, input reset,output reg[7:0] Instruction_Code);
reg [7:0] Mem[7:0]; //byte addressable memory 8 locations

always @ (*) 
begin
Instruction_Code= {Mem[PC]};
end

//handling reset condition
always@(reset)
begin
if(reset==0) //if reset is equal to logic 0
	begin
//2017AAPS0288G --> A=2, B=8, C=8, x=2, y=2, z=3
//	mov R2, R2	12
//	add R2, R2	52
//	add R3, R2	5A
//	j L1		C5
//	mov R2, R3	13
//L1:	add R2, R3	53

	Mem[5]=8'h53; Mem[4]=8'h13; Mem[3]=8'hC5; Mem[2]=8'h5A; Mem[1]=8'h52; Mem[0]=8'h12;
	
//Mem[7]=8'h22; Mem[6]=8'h53;
	end
end
endmodule

module Instruction_Fetch( input clk,input reset, output [7:0] Instruction_Code);

reg [7:0] PC;
wire [7:0] PC_wire;
wire [7:0] JumpAddr;
wire [7:0] PC_1;

//Instantiate the Instruction Memory here
Instruction_Memory Instr( PC, reset, Instruction_Code );
PC_adder adder(PC,PC_1);
JumpAddressGen M5( PC_1 , Instruction_Code , JumpAddr);
mux_2X1 mux1( PC_1 , JumpAddr, Instruction_Code[7], PC_wire);

always @(posedge clk)
begin
PC<=PC_wire;
end

always@(negedge reset)
begin
//if reset is equal to 0, then instantiate the PC with 0
if(reset==0)
PC <= 0;
end

initial 
begin
PC<=0;
end

endmodule

module mux_2X1( source0, source1, select, dout);
input [7:0]source0;
input [7:0]source1;
input select;
output reg [7:0]dout;

always @(*)
  if (select == 0)
    dout <= source0;
  else
    dout <= source1;
endmodule

module PC_adder(input [7:0]PC, output [7:0]PC_1);
assign PC_1=PC+1;
endmodule

module JumpAddressGen( input [7:0]PC_1 , input [7:0]PJA, output reg [7:0]jumpadd);
always@(*) begin
jumpadd={PC_1[7:6],PJA[5:0]};
end
endmodule
