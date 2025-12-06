module execute(
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
	mux5 u1(instr_2016, instr_1511, execute[0], mux5_wire);
	alucontrol u2(sign_ext[5:0], execute[2:1], ALC_wire); 
	mux32 u3(readdat2, sign_ext, execute[3], ALU_in_wire);
	alu u4(readdat1, ALU_in_wire, ALC_wire, alu_wire, zero_wire);
	adder u5(npc, sign_ext, add_wire);
	ex_mem_latch u6(clk, rst, wb_wire, mem_wire, add_wire, zero_wire, alu_wire, readdat2, mux5_wire, wb_out, branch, memread, memwrite, addOUT, zero, aluOUT, readdat2OUT, mux5OUT);
endmodule

module adder(
	input [31:0] add_in1,	
	input [31:0] add_in2,	
	output[31:0] add_out	
);
	assign add_out = add_in1 + add_in2;
endmodule

module alucontrol( 
	input [5:0] funct,
	input [1:0] aluop,
	output reg[2:0] sel
);
	parameter Rtype = 2'b10;
	parameter lwsw = 2'b00;
	parameter Itype = 2'b01;
	parameter xis = 6'bxxxxxx;
	parameter ALUADD = 3'b010;
	parameter ALUSUB = 3'b110;
	parameter ALUAND = 3'b000;
	parameter ALUOR = 3'b001;
	parameter ALUSLT = 3'b111;
	parameter unknown = 2'b11;
	parameter ALUx = 3'b011;
	parameter FUNCTADD = 6'b100000;
	parameter FUNCTSUB = 6'b100010;
		
	parameter FUNCTAND = 6'b100100;
	parameter FUNCTOR = 6'b100101;
	parameter FUNCTSLT = 6'b101010;
initial
	sel <=0;
always@(*)begin
	if(aluop == Rtype) begin
		case(funct)
			FUNCTADD: sel <= ALUADD;
			FUNCTSUB: sel <= ALUSUB;
			FUNCTAND: sel <= ALUAND;
			FUNCTOR: sel <= ALUOR;
			FUNCTSLT: sel <= ALUSLT;
			default: sel <= ALUx;
		endcase
	end
	else if(aluop == lwsw)
		sel <=ALUADD;
	else if (aluop == Itype)
		sel <=ALUSUB;
	else if (aluop == unknown)
		sel <= ALUx;
	else
		sel <= sel;
end
endmodule

module alu(
	input wire[31:0] a,	
	input wire[31:0] b,	
	input wire[2:0] control,	
	output reg [31:0] result,
	output wire zero
);
parameter	ALUADD = 3'b010,
		ALUSUB = 3'b110,
		ALUAND = 3'b000,
		ALUOR  = 3'b001,
		ALUSLT = 3'b111;
	wire sign_mismatch;
	assign sign_mismatch = 1'b0;
	assign sign_mismatch = a[31]^b[31];
	initial
		result <=0;
	always@(*)
		case(control)
			ALUADD: result = a + b;
			ALUSUB: result = a - b;
			ALUAND: result = a & b;
			ALUOR:  result = a | b;
			ALUSLT: result = (a<b)? (1-sign_mismatch):(0+sign_mismatch);
			default: result = 32'bX;
		endcase
	assign zero = (result ==0)?1:0;
endmodule

module ex_mem_latch(
	input clk, rst,
	input [1:0] ctlwb_out,
	input [2:0] ctlm_out,
	input [31:0] adder_out,
	input aluzero, 
	input [31:0] alu_out, readdat2,
	input [4:0] muxout,
	output reg [1:0] wb_ctlout,
	output reg branch, memread, memwrite,
	output reg [31:0] add_result,
	output reg zero,
	output reg [31:0] alu_result, rdata2out,
	output reg [4:0] five_bit_muxout
);
	initial begin
		wb_ctlout ='d0;
		branch='d0;
		memread='d0;
		memwrite='d0;
		add_result='d0;
		zero='d0;
		alu_result='d0;
		rdata2out='d0;
		five_bit_muxout='d0;
	end
	always@(posedge clk)begin
		if(rst)begin
		wb_ctlout <='d0;
		branch<='d0;
		memread<='d0;
		memwrite<='d0;
		add_result<='d0;
		zero<='d0;
		alu_result<='d0;
		rdata2out<='d0;
		five_bit_muxout='d0;
	end else begin
	wb_ctlout <= ctlwb_out;
	branch<= ctlm_out[2];
	memread <= ctlm_out[1];
	memwrite<= ctlm_out[0];

	add_result <= adder_out;
	zero <= aluzero;
	alu_result<= alu_out;
	rdata2out <= readdat2;
	five_bit_muxout<= muxout;
end
	end
endmodule

module mux32(A, B, sel, out);
	input [31:0] A, B;
	input  sel;
	output  [31:0] out;
		assign out = sel ? A : B;
endmodule

module mux5(A, B, sel, out);
	input [4:0] A, B;
	input  sel;
	output  [4:0] out;
		assign out = sel ? B : A;
endmodule

