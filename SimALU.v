module SimALU;
	reg[31:0] A;
	reg[31:0] B;
	wire[31:0] result;
	wire zero;
	reg[3:0] aluc;

	parameter stop_time = 80;

	ALU alu(A,B,aluc,zero,result);

	initial #stop_time $finish;	

	initial begin
		#10 A = 6;
		#10 B = 5;
		#10 aluc = 4'b0000;
		#10 aluc = 4'b0001;
		#10 aluc = 4'b0010;
		#10 aluc = 4'b0011;
		#10 aluc = 4'b0100;
	end
endmodule