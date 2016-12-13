module Jump(address, JUMP, res_Address);
	input [25:0] address;
	input JUMP;
	output [27:0] res_Address;

	assign res_Address = {address,2'b00};
endmodule