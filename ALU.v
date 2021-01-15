// Author: Samidh Mehta

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
