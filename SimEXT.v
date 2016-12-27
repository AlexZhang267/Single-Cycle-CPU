module SimEXT;
	reg[15:0] imme;
	wire[31:0] imm;
	reg SEXT;

	parameter stop_time = 60;
	initial #stop_time $finish;

	EXT ext(imme,SEXT,imm);

	initial begin
		#10 imme = 16'b0111111111111111;
		#10 SEXT = 1;
		#10 imme = 16'b1111111111111111;
		#10 SEXT = 0;
	end

endmodule