module top(
	input clk, rst,
	input [1:0] wb,
	input [2:0] mem,
	input [3:0] execute,
	input [31:0] npc, readdat1, readdat2, sign_ext,
	input [4:0] instr_2016, instr_1511,
	output [1:0] wb_out,
	output branch, memread, memwrite,
	output [31:0] addOUT,
	output zero,
	output[31:0] aluOUT, readdat2OUT,
	output [4:0] mux5OUT
);
	wire  zero_wire;
	wire [1:0] wb_wire;
	wire [2:0] mem_wire, ALC_wire;
	wire [1:0] EX;
	wire [31:0] add_wire, alu_wire, readdat_wire2, ALU_in_wire;
	wire [4:0] mux5_wire;
	assign wb_wire = wb;
	assign mem_wire = mem;
	mux5 u1(instr_2016, instr_1511, execute[1], mux5_wire);
	alucontrol u2(sign_ext[5:0], execute[3:2], ALC_wire); 
	mux32 u3(readdat2, sign_ext, execute[0], ALU_in_wire);
	alu u4(readdat1, ALU_in_wire, ALC_wire, alu_wire, zero_wire);
	adder u5(npc, sign_ext, add_wire);
	ex_mem_latch u6(clk, rst, wb_wire, mem_wire, add_wire, zero_wire, alu_wire, readdat2, mux5_wire, wb_out, branch, memread, memwrite, addOUT, zero, aluOUT, readdat2OUT, mux5OUT);
endmodule

