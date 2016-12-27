module Data_mem(address, data_in , WE, data_out, clk);
	input[31:0] address;
	input[31:0] data_in;
	input WE;
	input clk;
	output [31:0] data_out;

	//256 byte 的memory
	reg[31:0] memory[0:64];

	assign data_out = memory[address];
	// always @ (address) begin
	// 	$display("address is %b",address);
	// 	$display("data_out is %b",data_out);
	// end
	//todo: 如果不在时钟下降沿将数据写入，那么一个周期内就会对多个内存地址的内容修改
	always @(negedge clk) begin
		if (WE == 1) begin
			memory[address] = data_in;
			$display("memory[%d] is %b",address,data_in);
		end
	end

endmodule