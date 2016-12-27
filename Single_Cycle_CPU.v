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

	wire Z;

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
	// wire zero =0;

	ALU alu(A, B, ALUC, Z, ALU_result);

	wire[31:0] mem_data_out;
	Data_mem data_mem(ALU_result,Q2,WMEM,mem_data_out, clk);

	Mem_Reg_selector mem_Reg_selector(ALU_result,mem_data_out,M2REG,DI);


	// always @(inst) begin
	// 	$display("inst is %b",inst);
	// 	$display("op is %b", op);
	// 	$display("rs is %b", rs);
	// 	$display("rt is %b", rt);
	// 	$display("rd is %b", rd);
	// 	$display("sa is %b", sa);
	// end


	initial
		begin
			//add reg[1] = reg[0] + reg[1]
			//final reg[1] = 4
			instraction[0] = 32'b00000000000000010000100000100000;
			instraction[1] = 32'b00000000000000010000100000100000;
			instraction[2] = 32'b00000000000000010000100000100000;
			//nop
			instraction[3] = 32'b00000000000000000000000000000000;

			//sub reg[1] = reg[1] - reg[0]
			//reg[1] = 3
			instraction[4] = 32'b00000000001000000000100000100010;

			//and: reg[1] = reg[1] & reg[0]
			//then reg[1] = 1
			instraction[5] = 32'b00000000000000010000100000100100;

			//addi: reg[1] = reg[1] + imm
			//then: reg[1] = 8(0000...0001000)
			instraction[6] = 32'b00100000001000010000000000000111;

			//or reg[1] = reg[1] || reg[0]
			//then reg[1] = 9
			instraction[7] = 32'b00000000001000000000100000100101;

			//andi reg[1] = reg[1] & 12
			//then reg[1] = 8
			instraction[8] = 32'b00110000001000010000000000001100;

			//ori reg[1] = reg[1] || 7
			//then reg[1] = 15
			instraction[9] = 32'b00110100001000010000000000000111;

			//sw:memory[reg[2]+1] = reg[0]
			//then:memory[reg[2]+1] = 1
			instraction[10]= 32'b10101100010000000000000000000001;

			//lw:reg[1] = memory[reg[2]+1]
			//then reg[1] = 1
			instraction[11]= 32'b10001100010000010000000000000001;

			//slt:reg[0] reg[1]
			//then reg[1] = 0
			instraction[12]= 32'b00000000000000010000100000101010;

			//slti
			//reg[1] = 1
			instraction[13]= 32'b00101000000000010000000000000010;

			//nop
			instraction[14]= 32'b00000000000000000000000000000000;

			instraction[15] = 32'b00000000000000010000100000100000;

			//bne reg[0]!=reg[1]
			//then brance
			instraction[16]= 32'b00010100000000010000000000000010;

			//nop
			instraction[17]= 32'b00000000000000000000000000000000;

			//beq reg[0]==reg[2]
			//then brance
			instraction[18]= 32'b00010000000000100000000000000010;

			//nop
			instraction[19]= 32'b00000000000000000000000000000000;

			//jump
			instraction[20]= 32'b00001000000000000000000000000000;


		end

		always @(posedge clk) begin
			$display("Clk posedge PC is %d",PC);
			
			inst = instraction[PC/4];
			$display("inst is %b",inst);
			
		end

		always @(negedge clk) begin
			$display("op is %b", op);
			$display("rs is %b", rs);
			$display("rt is %b", rt);
			$display("rd is %b", rd);
			$display("sa is %b", sa);
			if (JUMP==1) begin
				PC = {PC[31:28],jump_Address};
			end
			else begin
				if (BRANCH==1) begin
					PC = PC + {imm,2'b00};
				end
				else
					PC = PC + 4;
				end
		end
		// always @(negedge clk) begin
		// 	$display("Clk negedge");
	// end
endmodule