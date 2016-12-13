module Reg_Imm_selector(regdata,imm,ALUIMM,outputdata);
	input[31:0] regdata;
	input[31:0] imm;
	input ALUIMM;
	output reg[31:0] outputdata;

	initial begin
		outputdata = 0;
	end

	// assign outputdata = ALUIMM ? regdata : imm;

	always @(regdata or imm or ALUIMM) begin
		if (ALUIMM == 0) begin
			outputdata = regdata;

		end
		else begin
			if (ALUIMM == 1) begin
				outputdata = imm;
			end
			else begin
				outputdata = 0;
			end
		end
		// $display("Reg_Imm_selector: regdata is %b imm is %b  ALUIMM is %b", regdata,imm, ALUIMM);
	end
endmodule