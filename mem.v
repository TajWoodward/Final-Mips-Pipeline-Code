module mem(
input clk, rst, ex_mem_latch, ex_mem_zero, memWrite, memRead,
input [1:0] ex_mem_wb,
input [4:0] ex_mux,
input [31:0] address, writeData,
output PCSrc, wb_mem_reg, wb_write_reg,
output [4:0] ex_mux_out,
output [31:0] readData, address_out
);
wire [31:0] readData_wire;
datamemory u1(memWrite, memRead, address, writeData, readData_wire);
assign PCSrc = ex_mem_latch & ex_mem_zero;
latch u2(clk, rst, ex_mem_wb, readData_wire, address, ex_mux, {wb_write_reg, wb_mem_reg}, readData, address_out, ex_mux_out);

endmodule

module datamemory(memWrite, memRead, address, writeData, readData);
input memWrite, memRead;
input [31:0] address, writeData;
output reg [31:0] readData;
reg [31:0] MEMORY [5:0];
initial begin
	$readmemb("data.mem",MEMORY, 0, 5);
	end
always@(*)begin
	if(memWrite)begin
		MEMORY[address%6] = writeData;
	end
	else if(memRead)begin
		readData = MEMORY[address];	
	end
	else begin
		readData = 'd0;
	end
end
endmodule

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
		memWrite_out <= 4'd0;
		control <= 4'd0;
		readData <= 32'd0;
		memALU <= 32'd0;
	end else begin
		memWrite_out<= memWrite;
		control <= control_wb_in;
		readData <= readData_in;
		memALU <= alu_in;
	end
end
endmodule


