module alucontrol( 
	input [5:0] funct,
	input [1:0] aluop,
	output reg[2:0] sel
);
	parameter Rtype = 2'b10;
	parameter lwsw = 2'b00;
	parameter Itype = 2'b01;
	parameter xis = 6'bxxxxxx;
	parameter ALUADD = 3'b010;
	parameter ALUSUB = 3'b110;
	parameter ALUAND = 3'b000;
	parameter ALUOR = 3'b001;
	parameter ALUSLT = 3'b111;
	parameter unknown = 2'b11;
	parameter ALUx = 3'b011;
	parameter FUNCTADD = 6'b100000;
	parameter FUNCTSUB = 6'b100010;
		
	parameter FUNCTAND = 6'b100100;
	parameter FUNCTOR = 6'b100101;
	parameter FUNCTSLT = 6'b101010;
initial
	sel <=0;
always@(*)begin
	if(aluop == Rtype) begin
		case(funct)
			FUNCTADD: sel <= ALUADD;
			FUNCTSUB: sel <= ALUSUB;
			FUNCTAND: sel <= ALUAND;
			FUNCTOR: sel <= ALUOR;
			FUNCTSLT: sel <= ALUSLT;
			default: sel <= ALUx;
		endcase
	end
	else if(aluop == lwsw)
		sel <=ALUADD;
	else if (aluop == Itype)
		sel <=ALUSUB;
	else if (aluop == unknown)
		sel <= ALUx;
	else
		sel <= sel;
end
endmodule

