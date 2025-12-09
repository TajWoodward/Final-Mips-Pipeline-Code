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

