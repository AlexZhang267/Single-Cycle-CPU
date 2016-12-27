module RdRtSelector;
	reg[4:0] rd;
	reg[4:0] rt;
	reg REGRT;
	reg[4:0] ND;
	parameter stop_time = 150;
	initial #stop_time $finish;
	
	Rtselector selector(rd,rt,REGRT,ND);
	initial
	begin
		#100 rd = 5'b00001;
		#20  rt = 5'b00010;
		#20 REGRT = 1;
	end
endmodule