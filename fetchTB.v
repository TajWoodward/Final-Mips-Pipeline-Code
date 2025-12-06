`timescale 1ns / 1ps
module fetchTB();
reg [31:0]  PC_from_ExMrm;
reg clk, PCSrc, rst;
wire [31:0] address, instruction;
fetch u1(clk, rst, PCSrc, PC_from_ExMrm, address, instruction);
initial begin
$dumpfile("dump.vcd");
$dumpvars(0, fetchTB);
end
initial begin
clk = 1'b1;
repeat(250) #1	clk = ~clk;
end

initial begin
rst = 1'b1;
PCSrc = 1'b0;
PC_from_ExMrm = 32'd0;
#3;rst = 1'b0;
PCSrc = 1'b0;
#3;
#3;
#3;
#3;
#3;
#3;
PCSrc = 1'b1;
PC_from_ExMrm= 32'h00000006;
#3;
PC_from_ExMrm= 32'h00000007;
#3;
PC_from_ExMrm= 32'h00000008;
PCSrc = 1'b0;
#3;
PC_from_ExMrm= 32'h00000009;
#3;
PC_from_ExMrm= 32'h0000000A;
PCSrc = 1'b0;
end
endmodule
