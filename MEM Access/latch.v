module latch(clk, rst, control_wb_in, readData_in, alu_in, memWrite, control, readData, memALU, memWrite_out);
input clk, rst;
input [1:0] control_wb_in;
input [31:0] readData_in, alu_in;
input [4:0] memWrite ;
output reg [1:0] control;
output reg [31:0] readData, memALU;
output reg [4:0] memWrite_out; 
always @(posedge clk)begin
	if(rst)begin
		memWrite_out = 4'd0;
		control = 4'd0;
		readData = 32'd0;
		memALU = 32'd0;
	end else begin
		memWrite_out= memWrite;
		control = control_wb_in;
		readData = readData_in;
		memALU = alu_in;
	end
end
endmodule
