module ALU(A, B, ALUC, zero, result);
	input signed [31:0] A, B;
	input[3:0] ALUC;
	output reg zero = 0;
	output reg [31:0] result;

	initial begin
		result = 0;
	end

	always @(A, B, ALUC) begin
		case(ALUC)
			4'b0000:begin
				result = A + B;
				// $display("ALU add A is %b B is %b result is %b",A,B,result);
			end
			4'b0001:begin
				result = A - B;
			end
			4'b0010:begin
				result = A & B;
			end
			4'b0011:begin
				result = A | B;
			end
			4'b0100:begin
				if (A < B) begin
					result = 1;
				end
				else begin
					result = 0;
				end
			end
		endcase
	end
endmodule