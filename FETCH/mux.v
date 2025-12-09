module mux(A, B, sel, out);
	input [31:0] A, B;
	input sel;
	output [31:0] out;

	assign out = sel ? A : B;
endmodule

