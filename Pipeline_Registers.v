// Author: Samidh Mehta


module ifidreg (input clk, input reset, input [7:0] instruction, output reg [2:0]rs1, output reg [2:0] rs2, output reg [7:0]IFIDIR);

always@(posedge clk, negedge reset)
begin

if (reset==0)
begin
rs1<=0;
rs2<=0;
IFIDIR<=0;
end

else begin
rs1<=instruction[2:0];
rs2<=instruction[5:3];
IFIDIR<=instruction;
end

end
endmodule

module idexreg (input clk, 
		input reset, 
		input [2:0]rs1,
		input [2:0]rs2, 
		input [7:0]A, 
		input [7:0]B, 
		input RegWrite, 	
		input AluOp,
		output reg [2:0] rs1_out,
		output reg [2:0] rs2_out,
		output reg [7:0] A_out,
		output reg [7:0] B_out,
		output reg RegWrite_out,
		output reg AluOp_out );

always@(posedge clk, negedge reset)
begin

if (reset==0)
begin
rs1_out 	<=0;
rs2_out 	<=0;
A_out		<=0;
B_out		<=0;
RegWrite_out	<=0;
AluOp_out	<=0;
end

else
begin 
rs1_out		<=rs1;
rs2_out		<=rs2;
A_out		<=A;
B_out		<=B;
RegWrite_out	<=RegWrite;
AluOp_out	<=AluOp;
end
end

endmodule

module exwbreg (input clk, input reset, input [7:0]AluResult, input [2:0]rs2, input RegWrite,  
		output reg [7:0] AluResult_out,
		output reg [2:0] rs2_out,
		output reg RegWrite_out );

always @ (posedge clk , negedge reset)
begin

if(reset==0)
begin
AluResult_out<=0;
rs2_out<=0;
RegWrite_out<=0;
end

else
begin
AluResult_out<=AluResult;
rs2_out<=rs2;
RegWrite_out<=RegWrite;	
end

end
endmodule
