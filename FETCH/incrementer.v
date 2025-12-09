module incrementer(A, B, sum,clk, rst);
	input [31:0] A, B;
	input clk, rst;
	output reg [31:0]sum;
	always@(*)begin
		if(rst)
			sum = 32'd0;
		else
			sum = A + B;
	end
endmodule
