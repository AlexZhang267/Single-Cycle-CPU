module SimRegfile;
	reg[4:0] rs;
	reg[4:0] rt;
	reg[4:0] ND;
	reg[31:0] DI;
	reg clk = 1'b1;
	reg WREG;
	wire[31:0] Q1;
	wire[31:0] Q2;

	parameter stop_time = 1500;
	Refile rf(rs,rt,ND,DI,clk,WREG,Q1,Q2);

	initial #stop_time $finish;

	initial begin
		rs = 5'b00000;
		rt = 5'b00001;
		WREG = 1;
		DI = 1;
		ND = 5'b00001;
		repeat(10)
			#10 clk = ~clk;
			DI = DI + 1;
	end
endmodule