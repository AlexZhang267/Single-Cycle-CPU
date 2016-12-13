module test(
	input clk,
	output aaa
	);

	assign aaa = clk ? 1:0;

	always @(posedge clk) begin
		if (clk==0) begin
			
		end
	end
endmodule