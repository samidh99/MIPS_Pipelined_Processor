// Author: Samidh Mehta

module proc (input clk, input reset);

//instruction fetch 
wire [7:0] instruction_ifid, IFIDIR_ifid;
wire [2:0] rs1_ifid, rs2_ifid;

//instruction decode
wire [7:0] A_idex, B_idex;
wire RegWrite_idex, AluOp_idex;
wire [7:0] A_out_idex, B_out_idex;
wire AluOp_out_idex, RegWrite_out_idex;
wire [2:0] rs1_out_idex, rs2_out_idex;

//execute
wire [2:0] rs2_out_exwb;
wire [7:0] AluResult_exwb, AluResult_out_exwb;
wire RegWrite_out_exwb;

//forwarding
wire forward_rs1, forward_rs2;
wire [7:0] dout_1, dout_2;

//Instruction Fetch Unit. 
//Output is instruction_ifid on clock edge.
//Jump Address generation is also done in the IF stage using the lower 6 bits from the instruction and upper 2 bits form PC+1
//A mux chooses the Jump Address or PC+1
Instruction_Fetch M1( clk, reset ,instruction_ifid);

//Instruction Decode Unit. 
//Output is A_idex, B_idex which are the values in the registers rs1 and rs2. 
//A write operation is also performed, where the write register comes from the rs2 of EX WB register.
//Control Signals- AluOp and RegWrite are also generated here.
Register_file M2(rs1_ifid,rs2_ifid,rs2_out_exwb,AluResult_out_exwb,reset, A_idex,B_idex,RegWrite_out_exwb);
control_unit M3( IFIDIR_ifid, RegWrite_idex, AluOp_idex);

//Execution Unit
//ALU operation is done here
//This also includes the forwarding unit
// A MUX also chooses the ALU inputs, output of the registers or the WriteBack value from the previous operation.
ALU M4(dout_1 , dout_2 ,AluOp_out_idex ,AluResult_exwb);
forwarding_unit M9(rs1_out_idex, rs2_out_idex, rs2_out_exwb, RegWrite_out_exwb, forward_rs1, forward_rs2 );
mux_2X1 M10 ( A_out_idex, AluResult_out_exwb, forward_rs1, dout_1);
mux_2X1 M11 ( B_out_idex, AluResult_out_exwb, forward_rs2, dout_2);

//pipeline registers are implemented using the concept of D flip flop. They depend on clock and reset
ifidreg M6( clk,  reset, instruction_ifid, rs1_ifid, rs2_ifid, IFIDIR_ifid);
idexreg M7( clk, reset, rs1_ifid, rs2_ifid, A_idex, B_idex,RegWrite_idex, AluOp_idex,rs1_out_idex,rs2_out_idex, A_out_idex,B_out_idex,RegWrite_out_idex,AluOp_out_idex);
exwbreg M8( clk,  reset, AluResult_exwb, rs2_out_idex, RegWrite_out_idex, AluResult_out_exwb,rs2_out_exwb,RegWrite_out_exwb);

endmodule

