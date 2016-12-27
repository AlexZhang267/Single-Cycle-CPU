module SimRegImmSelector;
	reg[31:0] r;
	reg[31:0] i;
	wire[31:0] B;
	reg ALUIMM;

	Reg_Imm_selector reg_imm_selector(r,i,ALUIMM,B);

	parameter stop_time = 80;

	initial #stop_time $finish;

	initial begin
		#10 r = 1;
		#10 i = 2;
		#10 ALUIMM = 0;
		#30 ALUIMM = 1;
	end
endmodule