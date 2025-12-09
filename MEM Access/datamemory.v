module datamemory(memWrite, memRead, address, writeData, readData);
input memWrite, memRead;
input [31:0] address, writeData;
output reg [31:0] readData;
reg [31:0] MEMORY [31:0];
initial begin
	MEMORY [0] = 32'H002300AA;
	MEMORY [1] = 32'H10654321;
	MEMORY [2] = 32'H00100022;
	MEMORY [3] = 32'H8C123456;
	MEMORY [5] = 32'H8F123456;
	MEMORY [6] = 32'HAD654321;
	MEMORY [7] = 32'H13012345;
	MEMORY [8] = 32'HAC654321;
	MEMORY [9] = 32'H12012345;
end
always@(*)begin
	if(memWrite)begin
		MEMORY[address] = writeData;
	end
	else if(memRead)begin
		readData = MEMORY[address];	
	end
end
endmodule
