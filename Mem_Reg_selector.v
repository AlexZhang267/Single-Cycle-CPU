module Mem_Reg_selector( reg_data,mem_data, M2REG, data_out);
	input[31:0] mem_data;
	input[31:0] reg_data;
	input M2REG;
	output reg [31:0] data_out;

	initial
		begin
			data_out = 0;
		end

	always @(mem_data, reg_data, M2REG) begin
		if (M2REG==0) begin
			data_out = reg_data;
			// $display("Mem_Reg_selector data_out is %b",data_out);
		end
		else begin
			data_out = mem_data;
			$display("mem_data %b",data_out);
		end
	end
endmodule