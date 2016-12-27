module SimJump;
	reg[24:0] add;
	reg Jinst;
	wire[26:0] out;
	Jump j(add,Jinst,out);
	initial begin
		#100 add = 25'b0000000000000000000000001;
		#100 Jinst = 1;
	end
endmodule