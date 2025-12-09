module ifIdLatch(address, instruction, Oaddress, Oinstruction, clk, rst);
	input [31:0] address, instruction;
	input clk, rst;
	output reg [31:0] Oaddress, Oinstruction;
	always@(posedge clk)begin
		if(rst)begin
			Oaddress <= 32'd0;
			Oinstruction <= 32'd0;end
		else begin
		Oaddress <=address;
		Oinstruction <=instruction;
	end
	end
endmodule

