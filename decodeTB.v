`timescale 1ns / 1ps
module decodeTB();
reg clk, rst, wb_reg_write;
reg [4:0] wb_write_reg_location;
reg [31:0] mem_wb_write_data, if_id_instr, if_id_npc;
wire [1:0] id_ex_wb;
wire [2:0]id_ex_mem;
wire [3:0] if_ex_execute;
wire [31:0]id_ex_npc, id_ex_readdat1, id_ex_readdat2, id_ex_sign_ext;
wire [4:0] id_ex_instr_bits_2016, id_ex_instr_bits_1511;


decode ll1(clk, rst, wb_reg_write, wb_write_reg_location, mem_wb_write_data, if_id_instr, if_id_npc, id_ex_wb, id_ex_mem, if_ex_execute, id_ex_npc, id_ex_readdat1, id_ex_readdat2, id_ex_sign_ext, id_ex_instr_bits_2016, id_ex_instr_bits_1511);

initial begin
$dumpfile("dump.vcd");
$dumpvars(0, decodeTB);
end
initial begin
clk =0; 
repeat(50)
#1 clk = ~clk;
end
initial begin
rst = 1;
wb_reg_write = 0;
wb_write_reg_location = 5'd2;
mem_wb_write_data = 32'h00000064;
if_id_npc = 32'h00000001;
if_id_instr = 32'h00A41020;
#2 rst = 0;
#2 if_id_npc = 32'h00000002;
if_id_instr = 32'h10000008;
#2 if_id_npc = 32'h00000003;
if_id_instr = 32'h8C820002;
#2 if_id_npc = 32'h00000004;
if_id_instr = 32'hAC820002;
if_id_npc = 32'h00000005;
wb_reg_write = 1;
#2 if_id_instr = 32'h00421020;
if_id_npc = 32'h00000006;
#2 if_id_instr=32'h00008000;
wb_reg_write = 0;
#2 #2;
end
endmodule
