module Control_unit(op,func,Z, JUMP, M2REG, BRANCH, WMEM, ALUC, SHIFT, ALUIMM, WREG, SEXT, REGRT);
	input[5:0] op;
	input[5:0] func;
	input Z;
	output reg JUMP, M2REG, BRANCH,WMEM,SHIFT, ALUIMM, WREG,SEXT, REGRT;
	output reg[3:0] ALUC;

	// reg[3:0] aluc;
	// assign JUMP = jump, M2REG = m2reg, BRANCH = branch, WMEM = wmem, SHIFT=shift, ALUIMM = aluimm, WREG = wreg, SEXT = sext, REGRT = regrt;
	// assign ALUC = aluc;

	//讲道理我觉得不该用case实现，应该有直接用与或非实现
	//先用case实现再该吧


	initial begin
		JUMP = 0;
		M2REG = 0;//应该是ALU直接输出
		BRANCH = 0;//暂时不用管
		WMEM = 0;//不需要写存储器 
		ALUC = 4'b0000;//默认加法是0000
		SHIFT = 0;
		ALUIMM = 0;
		WREG = 1;
		SEXT = 0;
		REGRT = 0;//选择rd		
	end
	always @(op or func or Z) begin
		case(op)
			// special
			6'b000000:begin
				case(func)
					6'b100000:begin
						JUMP = 0;
						M2REG = 0;//应该是ALU直接输出
						BRANCH = 0;//暂时不用管
						WMEM = 0;//不需要写存储器 
						ALUC = 4'b0000;//默认加法是0000
						SHIFT = 0;
						ALUIMM = 0;
						WREG = 1;
						SEXT = 0;
						REGRT = 0;//选择rd
						$display("Control_unit add");
					end
					6'b100010:begin
						JUMP = 0;
						M2REG = 0;//应该是ALU直接输出
						BRANCH = 0;//暂时不用管
						WMEM = 0;//不需要写存储器 
						ALUC = 4'b0001;//默认减法是0001
						SHIFT = 0;
						ALUIMM = 0;
						WREG = 1;
						SEXT = 0;
						REGRT = 0;//选择rd
						$display("Control_unit sub");
					end
					6'b100100:begin
						JUMP = 0;
						M2REG = 0;//应该是ALU直接输出
						BRANCH = 0;//暂时不用管
						WMEM = 0;//不需要写存储器 
						ALUC = 4'b0010;//默认and是0010
						SHIFT = 0;
						ALUIMM = 0;
						WREG = 1;
						SEXT = 0;
						REGRT = 0;//选择rd
						$display("Control_unit and");
					end
					6'b100101:begin
						JUMP = 0;
						M2REG = 0;//应该是ALU直接输出
						BRANCH = 0;//暂时不用管
						WMEM = 0;//不需要写存储器 
						ALUC = 4'b0011;//默认or是0011
						SHIFT = 0;
						ALUIMM = 0;
						WREG = 1;
						SEXT = 0;
						REGRT = 0;//选择rd
						$display("Control_unit or");
					end
					6'b101010:begin
						JUMP = 0;
						M2REG = 0;//应该是ALU直接输出
						BRANCH = 0;//暂时不用管
						WMEM = 0;//不需要写存储器 
						ALUC = 4'b0100;//默认slt是0100
						SHIFT = 0;
						ALUIMM = 0;
						WREG = 1;
						SEXT = 0;
						REGRT = 0;//选择rd
						$display("Control_unit slt");
					end
					6'b000000:begin
						JUMP = 0;
						M2REG = 0;//应该是ALU直接输出
						BRANCH = 0;//暂时不用管
						WMEM = 0;//不需要写存储器 
						ALUC = 4'b1111;//默认加法是0000
						SHIFT = 0;
						ALUIMM = 0;
						WREG = 0;
						SEXT = 0;
						REGRT = 0;//选择rd
						$display("Control_unit nop");
					end
				endcase
			end
				//addi
			6'b001000:begin
					JUMP = 0;
					M2REG = 0;
					BRANCH = 0;
					WMEM = 0;
					ALUC = 4'b0000;
					SHIFT = 0;
					ALUIMM = 1;//输入立即数
					WREG = 1;
					SEXT = 1;//有符号扩展
					REGRT = 1;//选择rt
					$display("Control_unit add immediate");
			end
			//andi
			6'b001100:begin
					JUMP = 0;
					M2REG = 0;
					BRANCH = 0;
					WMEM = 0;
					ALUC = 4'b0010;
					SHIFT = 0;
					ALUIMM = 1;//输入立即数
					WREG = 1;
					SEXT = 1;//有符号扩展
					REGRT = 1;//选择rt
					$display("Control_unit and immediate");
			end
			//or i
			6'b001101:begin
					JUMP = 0;
					M2REG = 0;
					BRANCH = 0;
					WMEM = 0;
					ALUC = 4'b0011;
					SHIFT = 0;
					ALUIMM = 1;//输入立即数
					WREG = 1;
					SEXT = 1;//有符号扩展
					REGRT = 1;//选择rt
					$display("Control_unit or immediate");
			end	

			//slti
			6'b001010:begin
					JUMP = 0;
					M2REG = 0;
					BRANCH = 0;
					WMEM = 0;
					ALUC = 4'b0100;
					SHIFT = 0;
					ALUIMM = 1;//输入立即数
					WREG = 1;
					SEXT = 1;//有符号扩展
					REGRT = 1;//选择rt
					$display("Control_unit slt immediate");		
			end

			//sw
			6'b101011:begin
				JUMP = 0;
				M2REG = 0;//无所谓的，不把数据写到寄存器
				BRANCH = 0;
				WMEM = 1;
				ALUC = 4'b0000;//寄存器和 加 offset 计算地址
				SHIFT = 0;
				ALUIMM = 1;
				WREG = 0;
				SEXT = 1;
				REGRT = 0;//无所谓的
				$display("Control_unit sw");
			end

			6'b100011:begin
				JUMP = 0;
				M2REG = 1;
				BRANCH = 0;
				WMEM = 0;
				ALUC = 4'b0000;
				SHIFT = 0;
				ALUIMM = 1;
				WREG = 1;
				SEXT = 1;
				REGRT = 1;
				$display("Control_unit lw");
			end
			//jump
			6'b000010:begin
				JUMP = 1;
				M2REG = 0;//应该是ALU直接输出
				BRANCH = 0;//暂时不用管
				WMEM = 0;//不需要写存储器 
				ALUC = 4'b0000;//默认加法是0000
				SHIFT = 0;
				ALUIMM = 0;
				WREG = 0;
				SEXT = 0;
				REGRT = 0;//选择rd
				$display("Control_unit jump");
			end
			//bne
			6'b000101:begin
				JUMP=0;
				M2REG = 0;
				$display("ZERO %b",Z);
				if (Z==1)begin 
					BRANCH=1;
					$display("BRANCH == 1");
				end
				else begin
					BRANCH=0;
				end
				WMEM = 0;
				ALUC = 4'b0101;
				SHIFT = 0;
				ALUIMM = 0;
				WREG = 0;
				SEXT = 0;
				REGRT = 0;
				$display("Control_unit bne");
			end
			6'b000100:begin
				JUMP=0;
				M2REG = 0;
				$display("ZERO %b",Z);
				if (Z==1)begin 
					BRANCH=1;
					$display("BRANCH == 1");
				end
				else begin
					BRANCH=0;
				end
				WMEM = 0;
				ALUC = 4'b0110;
				SHIFT = 0;
				ALUIMM = 0;
				WREG = 0;
				SEXT = 0;
				REGRT = 0;
				$display("Control_unit bne");
			end
		endcase
	end


endmodule