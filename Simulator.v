`timescale 1ns/1ps
module Simulator;
	reg clk = 1'b1;	
	Single_Cycle_CPU single_cycle_computer(clk);
	parameter stop_time = 800;
	initial
	begin
		#stop_time $finish;
	end
	initial
		begin
			repeat(40)
				#20 clk = ~clk;
		end
endmodule