`timescale 1ns / 1ps
module testbench();
reg clk, rst;
top u22(clk, rst);
initial begin
$dumpfile("dump.vcd");
$dumpvars(0, testbench);
end
initial begin
	clk = 1;
	repeat(100) #1 clk=~clk;
end
initial begin
rst = 1;
#5 rst =0;

end
endmodule
