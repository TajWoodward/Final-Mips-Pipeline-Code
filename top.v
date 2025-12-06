module top(
	input clk, rst
);
	wire 		mem_branch, mem_wb_reg_write,
			ex_mem_branch, ex_mem_mem_write,
			ex_mem_mem_read, ex_mem_zero,
			mem_wb_mem_reg;
	wire [1:0] 	id_ex_wb, ex_mem_wb;
	wire [2:0]	id_ex_mem;
	wire [3:0]	id_ex_ex;
	wire [4:0] 	mem_wb_write_reg, id_ex_2016, id_ex_1511
			, ex_mem_mux, mem_wb_mux;
	wire [31:0] 	ex_mem_npc, if_id_npc, if_id_instr,
			id_ex_npc, id_ex_readdat1, id_ex_readdat2,
			id_ex_sign, 
			ex_mem_alu, ex_mem_readdat2,
			mem_wb_alu, mem_wb_write_data,
			mem_wb_read_data;


	fetch 	s1(clk, rst, mem_branch, ex_mem_npc, if_id_npc,
		if_id_instr);
	decode 	s2(clk, rst, mem_wb_reg_write, mem_wb_write_reg,
		mem_wb_write_data, if_id_instr, if_id_npc,
		id_ex_wb, id_ex_mem, id_ex_ex, id_ex_npc,
		id_ex_readdat1, id_ex_readdat2, id_ex_sign,
		id_ex_2016, id_ex_1511);
	execute s3(clk, rst,id_ex_wb, id_ex_mem, id_ex_ex, 
		id_ex_npc, id_ex_readdat1, id_ex_readdat2, 
		id_ex_sign, id_ex_2016, id_ex_1511, ex_mem_wb,
		ex_mem_branch,
		ex_mem_mem_read, ex_mem_mem_write, ex_mem_npc,
		ex_mem_zero, ex_mem_alu, ex_mem_readdat2, 
		ex_mem_mux);
	mem 	s4(clk, rst, ex_mem_branch, ex_mem_zero,
		ex_mem_mem_write, ex_mem_mem_read, ex_mem_wb,
		ex_mem_mux, ex_mem_alu, ex_mem_readdat2, 
		mem_branch,
		mem_wb_mem_reg, mem_wb_reg_write, 
		mem_wb_write_reg,
		mem_wb_read_data, mem_wb_alu);
	wb	s5(clk, rst, mem_wb_mem_reg, mem_wb_read_data,
		mem_wb_alu, mem_wb_write_data);


endmodule

