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

