module Shift_selector(regdata, sa, SHIFT, outputdata);
	input[31:0] regdata;
	input[4:0] sa;
	input SHIFT;
	output reg[31:0] outputdata;

	initial begin
		outputdata = 0;
	end

	always @(regdata or sa or SHIFT) begin
	 	outputdata = regdata;
	end
endmodule