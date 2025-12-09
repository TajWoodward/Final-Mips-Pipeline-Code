module top(clk, rst, MemtoReg, memReaddata, memALUresult, wb_data);
input clk, rst ,MemtoReg;
input [31:0] memReaddata, memALUresult;
output [31:0] wb_data;
assign wb_data = MemtoReg ? memALUresult : memReaddata;
endmodule
