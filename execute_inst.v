module Execute_inst(inst,clk);
	input[31:0] inst;
	input clk;
	wire[5:0] op = inst[31:26];
	wire[4:0] rs = inst[25:21];
	wire[4:0] rt = inst[20:16];
	wire[4:0] rd = inst[15:11];
	wire[4:0] sa = inst[10:6];
	wire[5:0] func = inst[5:0];

	wire[15:0] imme = inst[15:0];
	wire[25:0] target = inst[25:0];
	reg Z = 0;

	//control unit  产生的信号
	wire JUMP, M2REG, BRANCH, WMEM, SHIFT, ALUIMM, WREG, SEXT, REGRT;
	wire[3:0] ALUC;
	Control_unit control_unit(op,func,Z, JUMP, M2REG, BRANCH, WMEM, ALUC, SHIFT, ALUIMM, WREG, SEXT, REGRT);

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

endmodule