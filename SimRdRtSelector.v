module RdRtSelector;
	reg[4:0] rd;
	reg[4:0] rt;
	reg REGRT;
	wire[4:0] ND;
	Rtselector selector(rd,rt,REGRT,ND);
	parameter stop_time = 150;
	initial #stop_time $finish;
	initial
	begin
		#20 rd = 5'b00001;
		#20  rt = 5'b00010;
		#20 REGRT = 1;
		#20 REGRT = 0;
		#20 rd = 5'b00011;
		#20 REGRT = 1;
	end
endmodule