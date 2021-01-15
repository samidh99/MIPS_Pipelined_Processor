// Author: Samidh Mehta

module Register_file(
	input [2:0] Read_Reg_Num_1,
	input [2:0] Read_Reg_Num_2,
	input [2:0] Write_Reg,
	input [7:0] Write_Data,
	input reset, 
	output [7:0] Read_Data_1,
	output [7:0] Read_Data_2,
	input RegWrite
);
reg [7:0] RegMemory [7:0];
//assigning the default values of register when beginning a process
always @ (reset) begin
if (reset==0) begin
RegMemory[0]=8'h0; 	RegMemory[1]=8'h1; 	RegMemory[2]=8'h2; 	RegMemory[3]=8'h3;
RegMemory[4]=8'h4; 	RegMemory[5]=8'h5; 	RegMemory[6]=8'h6; 	RegMemory[7]=8'h7;
end
end

assign Read_Data_1=RegMemory[Read_Reg_Num_1];
assign Read_Data_2=RegMemory[Read_Reg_Num_2];

always @ (*) begin
if (RegWrite) begin
RegMemory[Write_Reg]= Write_Data;
end
end
endmodule

module control_unit(input [7:0]IFIDIR, output  RegWrite, output  AluOp);

assign RegWrite=~IFIDIR[7];
assign AluOp=IFIDIR[6];

endmodule
