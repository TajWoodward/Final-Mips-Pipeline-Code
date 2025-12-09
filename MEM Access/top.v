module top(
input clk, rst, ex_mem_latch, ex_mem_zero, memWrite, memRead,
input [1:0] ex_mem_wb,
input [4:0] ex_mux,
input [31:0] address, writeData,
output PCSrc, regWrite, memReg,
output [4:0] ex_mux_out,
output [31:0] readData, address_out
);
wire [31:0] readData_wire;
datamemory u1(memWrite, memRead, address, writeData, readData_wire);
assign PCSrc = ex_mem_latch & ex_mem_zero;
latch u2(clk, rst, ex_mem_wb, readData_wire, address, ex_mux, {regWrite, memReg}, readData, address_out, ex_mux_out);

endmodule
