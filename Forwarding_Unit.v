module ALU(A , B ,AluOp ,result);
input [7:0]A ;
input [7:0]B ;
input AluOp;
output reg [7:0]result;

always@(*)
begin
case(AluOp)

	1'b0	:	result=A;
	1'b1	:	result=A+B;
	endcase

end
endmodule

module forwarding_unit(input [2:0] rs1, input [2:0]rs2, input [2:0]rd, input regwrite, output reg forward_rs1, output reg forward_rs2 );
always @ (*)
begin

if (regwrite == 1 && rd==rs1)
begin
forward_rs1=1;
end

else
begin
forward_rs1=0;
end
 
if (regwrite == 1 && rd==rs2)
begin
forward_rs2=1;
end

else
begin
forward_rs2=0;
end

end
endmodule
