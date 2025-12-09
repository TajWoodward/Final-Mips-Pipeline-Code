module ex_mem_latch(
	input clk, rst,
	input [1:0] ctlwb_out,
	input [2:0] ctlm_out,
	input [31:0] adder_out,
	input aluzero, 
	input [31:0] alu_out, readdat2,
	input [4:0] muxout,
	output reg [1:0] wb_ctlout,
	output reg branch, memread, memwrite,
	output reg [31:0] add_result,
	output reg zero,
	output reg [31:0] alu_result, rdata2out,
	output reg [4:0] five_bit_muxout
);
	initial begin
		wb_ctlout =0;
		branch=0;
		memread=0;
		memwrite=0;
		add_result=0;
		zero=0;
		alu_result=0;
		rdata2out=0;
		five_bit_muxout=0;
	end
	always@(posedge clk)begin
		if(rst)begin
		wb_ctlout <=0;
		branch<=0;
		memread<=0;
		memwrite<=0;
		add_result<=0;
		zero<=0;
		alu_result<=0;
		rdata2out<=0;
		five_bit_muxout=0;
	end else begin
	wb_ctlout <= ctlwb_out;
	branch<= ctlm_out[2];
	memread <= ctlm_out[1];
	memwrite<= ctlm_out[0];

	add_result <= adder_out;
	zero <= aluzero;
	alu_result<= alu_out;
	rdata2out <= readdat2;
	five_bit_muxout<= muxout;
end
	end
endmodule

