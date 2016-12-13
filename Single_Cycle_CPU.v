module Single_Cycle_CPU(clk);
	input clk;
	reg [31:0] instraction[0:20];
	reg[6:0] PC = 7'b0000000;

	reg[31:0] inst;

	wire[5:0] op = inst[31:26];
	wire[4:0] rs = inst[25:21];
	wire[4:0] rt = inst[20:16];
	wire[4:0] rd = inst[15:11];
	wire[4:0] sa = inst[10:6];
	wire[5:0] func = inst[5:0];

	wire[15:0] imme = inst[15:0];
	wire[25:0] target = inst[25:0];

	wire[27:0] jump_Address;

	reg Z = 0;

	//control unit  产生的信号
	wire JUMP, M2REG, BRANCH, WMEM, SHIFT, ALUIMM, WREG, SEXT, REGRT;
	wire[3:0] ALUC;
	Control_unit control_unit(op,func,Z, JUMP, M2REG, BRANCH, WMEM, ALUC, SHIFT, ALUIMM, WREG, SEXT, REGRT);

	Jump jump(target,JUMP, jump_Address);

	// rd rt 选择
	wire[4:0] ND;
	Rtselector rtselector(rt,rd,REGRT,ND);

	wire[31:0] Q1;
	wire[31:0] Q2;

	wire[31:0] DI;
	Regfile regfile(rs, rt, ND, DI,clk, WREG, Q1, Q2);

	wire[31:0] imm;

	Ext ext(imme,SEXT,imm);

	wire[31:0] B;
	Reg_Imm_selector reg_imm_selector(Q2,imm,ALUIMM,B);

	wire[31:0] A;
	Shift_selector shift_selector(Q1,sa,SHIFT,A);


	wire[31:0] ALU_result;
	wire zero =0;

	ALU alu(A, B, ALUC, zero, ALU_result);

	wire[31:0] mem_data_out;
	Data_mem data_mem(ALU_result,Q2,WMEM,mem_data_out, clk);

	Mem_Reg_selector mem_Reg_selector(ALU_result,mem_data_out,M2REG,DI);


	always @(inst) begin
		$display("inst is %b",inst);
		$display("op is %b", op);
		$display("rs is %b", rs);
		$display("rt is %b", rt);
		$display("rd is %b", rd);
		$display("sa is %b", sa);
	end


	initial
		begin
			instraction[0]= 32'b00000000000000010000100000100000;
			instraction[1]= 32'b00000000000000010000100000100000;
			instraction[2]= 32'b00000000000000010000100000100000;
			instraction[3]= 32'b00000000000000000000000000000000;
			// instraction[4]= 32'b00000000000000010000100000100000;
			// instraction[5]= 32'b00000000000000010000100000100000;
			// instraction[6]= 32'b00000000000000010000100000100000;
			// instraction[7]= 32'b00000000000000010000100000100000;
			//sub
			instraction[4]= 32'b00001000000000000000000000000000;
			instraction[5]= 32'b00000000001000000000100000100010;
			instraction[6]= 32'b00000000001000000000100000100100;
			instraction[7]= 32'b00000000001000000000100000100100;
			instraction[8]= 32'b00000000000000010000100000100000;
			instraction[9]= 32'b00000000000000010000100000100000;
			instraction[10]= 32'b00000000000000010000100000100101;
			instraction[11]= 32'b00000000000000010000100000100101;

			//slt
			instraction[12]= 32'b00000000000000010000100000101010;

			//addi
			instraction[13]= 32'b00100000001000010000100000101010;
							  // 00000000000000000000100000101011

			instraction[14]= 32'b00110000001000010000000000101010;
							  // 00000000000000000000000000101010

			instraction[15]= 32'b00110100001000011000000000010101;
							  // 11111111111111111000000000111111
			instraction[16]= 32'b00101000001000010000000000010101;

			instraction[17]= 32'b10101100000000010000000000000001;

			instraction[18]= 32'b00000000000000010000100000100000;

			instraction[19]= 32'b10001100000000010000000000000001;

		end

		always @(posedge clk) begin
			PC = PC + 4;
			$display("Clk posedge PC is %d",PC);
			if (JUMP==1) begin
				PC = {PC[31:28],jump_Address};
			end
			inst = instraction[PC/4];
		end
		always @(negedge clk) begin
		$display("Clk negedge");
	end
endmodule