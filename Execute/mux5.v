module mux5(A, B, sel, out);
	input [4:0] A, B;
	input  sel;
	output  [4:0] out;
		assign out = sel ? B : A;
endmodule

