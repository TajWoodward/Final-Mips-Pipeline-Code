module top(ex_mem_pc_src, ex_mem_npc, address_out,instr_out, clk, rst);
	input [31:0] ex_mem_npc;
	input clk, ex_mem_pc_src, rst;
	output [31:0] address_out, instr_out;
	wire [31:0] add_out, pc_out, fromPC, pc_in, instructLatch;
	mux u1(ex_mem_npc,add_out,  ex_mem_pc_src, pc_in);
	pc u2(pc_in, pc_out, clk, rst);
	incrementer u3(pc_out, 32'd4, add_out, clk, rst);
	instrMem u4(pc_out, instructLatch, clk, rst);
	ifIdLatch u5(add_out, instructLatch,address_out, instr_out, clk, rst);

endmodule
