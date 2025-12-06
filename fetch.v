module fetch(clk, rst,ex_mem_pc_src, ex_mem_npc, address_out,instr_out);
	input [31:0] ex_mem_npc;
	input clk, ex_mem_pc_src, rst;
	output [31:0] address_out, instr_out;

	wire [31:0] add_out, pc_out, fromPC, pc_in, instructLatch;
	mux u1(ex_mem_npc,add_out,  ex_mem_pc_src, pc_in);
	pc u2(pc_in, pc_out, clk, rst);
	incrementer u3(pc_out, 32'd1, add_out, clk, rst);
	instrMem u4(pc_out, instructLatch, clk, rst);
	ifIdLatch u5(add_out, instructLatch,address_out, 
		instr_out, clk, rst);

endmodule
module pc(muxed, address, clk, rst);
	input clk, rst;
	input [31:0] muxed;
	output reg [31:0] address;
	always@(posedge clk)begin
		if(rst)
			address = 32'd0;
		else
			address= muxed;
	end
endmodule

module mux(A, B, sel, out);
	input [31:0] A, B;
	input sel;
	output [31:0] out;

	assign out = sel ? A : B;
endmodule

module instrMem(address, instruction, clk, rst);
	input clk, rst;
	input [31:0] address;
	reg [31:0] memory [23:0];
	output reg [31:0] instruction;
	initial begin 
	$readmemb("instr.mem", memory, 0 ,23);	
			end
	always@(*)begin
		if(rst)
			instruction <= 32'd0;
		else
	instruction <= memory[address%24];	
end
endmodule

module incrementer(A, B, sum,clk, rst);
	input [31:0] A, B;
	input clk, rst;
	output [31:0]sum;
	assign sum = rst ? 32'd0 : A + B;
endmodule
module ifIdLatch(address, instruction, Oaddress, Oinstruction, clk, rst);
	input [31:0] address, instruction;
	input clk, rst;
	output reg [31:0] Oaddress, Oinstruction;
	always@(posedge clk)begin
		if(rst)begin
			Oaddress = 32'd0;
			Oinstruction = 32'd0;end
		else begin
		Oaddress =address;
		Oinstruction =instruction;
	end
	end
endmodule

