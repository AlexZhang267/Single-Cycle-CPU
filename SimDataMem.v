module SimDataMen;
	reg[31:0] address;
	reg[31:0] datain;
	reg wmem;
	wire[31:0] dataout;
	reg clk = 1'b1;

	parameter stop_time = 100;
	initial #stop_time $finish;

	Data_mem datamem(address, datain , wmem, dataout, clk);
	initial begin
		#10 address = 1;
		#10 datain = 7;
		repeat(2) begin
			#10 clk = ~clk;
		end
		#10 wmem = 1;
		#10 repeat(2) begin
			#10 clk = ~clk;
		end
		
	end
endmodule