module Rtselector(rt,rd, REGRT, ND);
	input[4:0] rt;
	input[4:0] rd;
	input REGRT;
	output reg[4:0] ND;

	initial begin
		ND = 0;
	end

	//add or regrt
	always @(rt or rd or REGRT) begin
		case(REGRT)
			0:ND = rd;
			1:ND = rt;
			// $display("Rtselector: rd is %b rt is %b REGRT is %b ND is %b",rd,rt,REGRT,ND);
		endcase
		// $display("Rtselector: rd is %b rt is %b REGRT is %b ND is %b",rd,rt,REGRT,ND);
		
	end
endmodule