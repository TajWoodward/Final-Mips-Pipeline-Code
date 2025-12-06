`timescale 1ns / 1ps
module memTB();
initial begin
$dumpfile("dump.vcd");
$dumpvars(0, memTB);
end
reg clk, rst, ex_mem_latch, ex_mem_zero, memWrite, memRead;
reg [1:0] ex_mem_wb;
reg [4:0] ex_mux;
reg [31:0] address, writeData;
wire PCSrc, regWrite, memReg;
wire [4:0] ex_mux_out;
wire [31:0] readData, address_out;
mem u1(clk, rst, ex_mem_latch, ex_mem_zero, memWrite, memRead, ex_mem_wb, ex_mux, address, writeData, PCSrc, regWrite, memReg, ex_mux_out, readData, address_out);   
initial begin
clk = 1'b0;
repeat(50) #5 clk = ~clk;   
end
initial begin
rst = 1'b1;
#10 rst = 1'b0;
ex_mem_latch = 1'b0;
ex_mem_zero= 1'b0;
memWrite =1'b0;
memRead =1'b0;
ex_mem_wb = 2'b00;
ex_mux = 4'b0000;
address = 32'h00000000;
writeData = 32'h00000000;
#10
ex_mem_latch = 1'b1;
ex_mem_zero= 1'b1;
memWrite =1'b1;
memRead =1'b0;
ex_mem_wb = 2'b00;
ex_mux = 4'b0010;
address = 32'h00000000;
writeData = 32'hABCDEF12;
#10
ex_mem_latch = 1'b0;
ex_mem_zero= 1'b1;
memWrite =1'b0;
memRead =1'b1;
ex_mem_wb = 2'b00;
ex_mux = 4'b0001;
address = 32'h00000000;
end
endmodule
