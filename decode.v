module decode(clk, rst, wb_reg_write, wb_write_reg_location, mem_wb_write_data, if_id_instr, if_id_npc, id_ex_wb, id_ex_mem, id_ex_execute, id_ex_npc, id_ex_readdat1, id_ex_readdat2, id_ex_sign_ext, id_ex_instr_bits_2016, id_ex_instr_bits_1511);
input clk, rst, wb_reg_write;
input [4:0] wb_write_reg_location;
input [31:0] mem_wb_write_data, if_id_instr, if_id_npc;
output [1:0] id_ex_wb;
output [2:0] id_ex_mem;
output [3:0] id_ex_execute;
output [31:0] id_ex_npc, id_ex_readdat1,id_ex_readdat2, id_ex_sign_ext;
output [4:0] id_ex_instr_bits_2016,id_ex_instr_bits_1511;
wire [1:0] wb;
wire [2:0] mem;
wire [3:0] execute;
wire [31:0] npc, readdat1,readdat2, sign_ext;
control u1(clk, rst, if_id_instr[31:26], wb, mem, execute);
signExt u2(if_id_instr[15:0], sign_ext);
regfile u3(clk, rst, wb_reg_write, if_id_instr[25:21], if_id_instr[20:16], wb_write_reg_location, mem_wb_write_data, readdat1, readdat2);
idExLatch u4(clk, rst, wb, mem, execute, if_id_npc, readdat1, readdat2, sign_ext, if_id_instr[20:16], if_id_instr[15:11], id_ex_wb, id_ex_mem,id_ex_execute, id_ex_npc, id_ex_readdat1, id_ex_readdat2, id_ex_sign_ext, id_ex_instr_bits_2016, id_ex_instr_bits_1511);
endmodule

module control(clk, rst, opcode, wb, mem, ex);
	input clk, rst;
	input [5:0] opcode;
	output reg [1:0] wb;
	output reg [2:0] mem;
	output reg [3:0] ex;
	parameter RTYPE 	= 6'b000000;
	parameter LW 		= 6'b100011;
	parameter SW		= 6'b101011;
	parameter BEQ 		= 6'b000100;
	parameter NOP 		= 6'b100000;

	initial begin
		wb = 2'd0;
		mem = 3'd0;
		ex = 4'd0;
	end
	always@(posedge clk)begin
	if(rst)begin
		wb = 	2'd0;
		mem =	3'd0;
		ex =	4'd0;
	end else begin
		case(opcode)
			RTYPE: begin
				wb <= 2'b10;
				mem <= 3'b000;
				ex <= 4'b1100;
			end
			LW: begin
				wb <= 2'b11;
				mem <= 3'b010;
				ex <= 4'b0001;
			end
			SW: begin
				wb <= 2'b00;
				mem <= 3'b001;
				ex <= 4'b0001;
			end
			BEQ: begin
				wb <= 2'b00;
				mem <= 3'b100;
				ex <= 4'b0010;
			end
			default: begin
				wb <= 2'b00;
				mem <= 3'b000;
				ex <= 0000;
			end
		endcase
		end
	end
endmodule
module signExt(immediate, extended);
	input [15:0] immediate;
	output [31:0] extended;
	assign extended = {{16{immediate[15]}},immediate};
endmodule

module regfile(clk, rst, regwrite, rs, rt, rd, writedata, A_readdat1, B_readdat2);
	input clk, rst, regwrite;
	input [4:0] rs, rt, rd;
	input [31:0] writedata;
	output reg [31:0] A_readdat1, B_readdat2;
	
	reg [31:0] REG [31:0];
	initial begin
		REG[0] = 32'h002300AA;
		REG[1] = 32'h10654321;
		REG[2] = 32'h00100022;
		REG[3] = 32'h8C123456;
		REG[4] = 32'h8F123456;
		REG[5] = 32'hAD654321;
		REG[6] = 32'h60000066;
		REG[7] = 32'h13012345;
		REG[8] = 32'hAC654321;
		REG[9] = 32'h12012345;
	end
	always@(posedge clk)begin
		if(rst)begin
			A_readdat1 = 32'd0;
			B_readdat2 = 32'd0;
		end
		else begin
			if(regwrite)begin
				REG[rd] <=writedata;
			end
			else begin
				A_readdat1 <= REG[rs];
				B_readdat2<= REG[rt];
			end
		end
	end
endmodule

module idExLatch(clk, rst, ctl_wb, ctl_mem, ctl_ex, npc, readdat1, readdat2, sign_ext, instr_bits_2016, instr_bits_1511, ctl_wb_out, ctl_mem_out, ctl_ex_out, npc_out, readdat1_out, readdat2_out, sign_ext_out, instr_bits_2016_out, instr_bits_1511_out);
	input clk, rst;
	input [1:0] ctl_wb;
	input [2:0] ctl_mem;
	input [3:0] ctl_ex;
	input [31:0] npc, readdat1, readdat2, sign_ext; 
	input wire [4:0] instr_bits_2016, instr_bits_1511;
	
	output reg [1:0] ctl_wb_out;
	output reg [2:0] ctl_mem_out;
	output reg [3:0] ctl_ex_out;
	output reg [31:0] npc_out, readdat1_out, readdat2_out, sign_ext_out; 
	output reg [4:0] instr_bits_2016_out, instr_bits_1511_out;
always@(posedge clk)begin
	if(rst)begin
		ctl_wb_out <= 2'd0;
 		ctl_mem_out <= 3'd0;
	 	ctl_ex_out <= 4'd0;
		npc_out <= 32'd0;
		readdat1_out<= 32'd0;
		readdat2_out<= 32'd0;
		sign_ext_out <= 32'd0;
		instr_bits_2016_out <= 5'd0;
		instr_bits_1511_out <= 5'd0;
	end
	else begin
		ctl_wb_out <= ctl_wb;
 		ctl_mem_out <= ctl_mem;
	 	ctl_ex_out <= ctl_ex;
		npc_out <= npc;
		readdat1_out<= readdat1;
		readdat2_out<= readdat2;
		sign_ext_out <= sign_ext;
		instr_bits_2016_out <= instr_bits_2016;
		instr_bits_1511_out <= instr_bits_1511;
	end
end
endmodule

