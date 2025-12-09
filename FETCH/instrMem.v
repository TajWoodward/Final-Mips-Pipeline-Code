module instrMem(address, instruction, clk, rst);
	input clk, rst;
	input [31:0] address;
	reg [31:0] memory [31:0];
	output reg [31:0] instruction;
	initial begin 
		memory[0] = 32'hA00000AA;	
		memory[1] = 32'h10000011;	
		memory[2] = 32'h20000022;	
		memory[3] = 32'h30000033;	
		memory[4] = 32'h40000044;	
		memory[5] = 32'h50000055;	
		memory[6] = 32'h60000066;	
		memory[7] = 32'h70000077;
		memory[8] = 32'h80000088;	
		memory[9] = 32'h90000099;
	end
	always@(*)begin
		if(rst)
			instruction = 32'd0;
		else
	instruction = (address[31:28]<32'd10)?memory[address[31:28]]:32'hfffffff;	
end
endmodule

