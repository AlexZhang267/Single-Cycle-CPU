module Ext(imm, SEXT, res);
input[15:0] imm;
input SEXT;
output reg [31:0] res;

always @(imm, SEXT) begin
	if(SEXT == 0)begin
		res = {16'b0000000000000000,imm};
	end
	else begin
		if (imm[15]==0) begin
			res = {16'b0000000000000000,imm};
		end
		else begin
			res = {16'b1111111111111111,imm};
		end
	end
end
endmodule