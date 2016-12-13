`timescale 1ns/1ps
module Simulator;
	reg clk = 1'b1;	
	Single_Cycle_CPU single_cycle_computer(clk);
	initial
		begin
			repeat(40)
				#1000 clk = ~clk;
		end
endmodule