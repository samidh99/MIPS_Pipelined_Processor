module tb_processor();
reg clk;
reg reset;

proc tesla( clk,  reset);

initial begin
reset=0;
#10 reset=1;
end

// Clock Generation
initial begin
clk = 1;
repeat(20)
#10 clk = ~clk; #10 $finish;
end

endmodule
