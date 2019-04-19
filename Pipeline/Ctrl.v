module Ctrl(
    input[5:0] op,
    input[5:0] funct,
    output reg[3:0] Ctrl_alu,
    output reg Ctrl_regDst,
    output reg[1:0] Ctrl_aluSrcA,
    output reg[1:0] Ctrl_aluSrcB,
    output reg Ctrl_Mem2Reg,
    output reg Ctrl_ext,
    output reg Ctrl_regWr,
    output reg Ctrl_MemWr,
    output reg[1:0] Ctrl_branch,
    output reg Ctrl_jump
);

    // Operation code;
	parameter  	R 				= 6'b000000,
                ADDI            = 6'b001000,
				ADDIU			= 6'b001001,
				SLTI			= 6'b001010,
				SLTIU			= 6'b001011,
				ANDI			= 6'b001100,
				ORI				= 6'b001101,
				XORI			= 6'b001110,
				LUI				= 6'b001111,
				LW				= 6'b100011,
				SW				= 6'b101011,
				BEQ				= 6'b000100,
				BNE				= 6'b000101,
				J				= 6'b000010;
	// Function code;
	parameter 	ADD 	= 6'b100000,
				ADDU 	= 6'b100001,
				SUB 	= 6'b100010,
				SUBU 	= 6'b100011,
				AND 	= 6'b100100,
				OR		= 6'b100101,
				XOR		= 6'b100110,
				NOR		= 6'b100111,
				SLT 	= 6'b101010,
				SLTU 	= 6'b101011,
				SLL		= 6'b000000,
				SRL		= 6'b000010,
                SRA		= 6'b000011;

    always@(*)begin
        case (op)
            R:begin
                Ctrl_regDst <= 1'b1;
                Ctrl_aluSrcB <= 2'b00;
                Ctrl_Mem2Reg <= 1'b0;
                Ctrl_ext <= 1'b0;//x
                Ctrl_MemWr <= 1'b0;
                Ctrl_regWr <= 1'b1;
                Ctrl_branch <= 2'b00;
                Ctrl_jump <= 1'b0;
                case (funct)
                    ADD:begin
                        Ctrl_aluSrcA <= 2'b00;
                        Ctrl_alu <= 4'b0000;
                    end
                    ADDU:begin
                        Ctrl_aluSrcA <= 2'b00;
                        Ctrl_alu <= 4'b0000;
                    end
                    SUB:begin
                        Ctrl_aluSrcA <= 2'b00;
                        Ctrl_alu <= 4'b0001;
                    end
                    SUBU:begin
                        Ctrl_aluSrcA <= 2'b00;
                        Ctrl_alu <= 4'b0001;
                    end

                    SLL:begin
                        Ctrl_aluSrcA <= 2'b10;
                        Ctrl_alu <= 4'b0010;
                    end
                    SRL:begin
                        Ctrl_aluSrcA <= 2'b10;
                        Ctrl_alu <= 4'b0011;
                    end
                    SRL:begin
                        Ctrl_aluSrcA <= 2'b10;
                        Ctrl_alu <= 4'b0011;
                    end

                    AND:begin
                        Ctrl_aluSrcA <= 2'b00;
                        Ctrl_alu <= 4'b0101;
                    end
                    OR:begin
                        Ctrl_aluSrcA <= 2'b00;
                        Ctrl_alu <= 4'b0110;
                    end
                    XOR:begin
                        Ctrl_aluSrcA <= 2'b00;
                        Ctrl_alu <= 4'b0111;
                    end
                    NOR:begin
                        Ctrl_aluSrcA <= 2'b00;
                        Ctrl_alu <= 4'b1010;
                    end

                    SLT:begin
                        Ctrl_aluSrcA <= 2'b00;
                        Ctrl_alu <= 4'b0100;
                    end
                    SLTU:begin
                        Ctrl_aluSrcA <= 2'b00;
                        Ctrl_alu <= 4'b1000;
                    end
                endcase
            end
            ADDI:begin
                Ctrl_alu <= 4'b0000;
                Ctrl_regDst <= 1'b0;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b01;
                Ctrl_Mem2Reg <= 1'b0;
                Ctrl_regWr <= 1'b1;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b1;
                Ctrl_branch <= 2'b00;
                Ctrl_jump <= 1'b0;
            end
            ADDIU:begin
                Ctrl_alu <= 4'b0000;
                Ctrl_regDst <= 1'b0;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b01;
                Ctrl_Mem2Reg <= 1'b0;
                Ctrl_regWr <= 1'b1;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b0;
                Ctrl_branch <= 2'b00;
                Ctrl_jump <= 1'b0;
            end
            SLTI:begin
                Ctrl_alu <= 4'b0100;
                Ctrl_regDst <= 1'b0;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b01;
                Ctrl_Mem2Reg <= 1'b0;
                Ctrl_regWr <= 1'b1;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b1;
                Ctrl_branch <= 2'b00;
                Ctrl_jump <= 1'b0;
            end
            SLTIU:begin
                Ctrl_alu <= 4'b1000;
                Ctrl_regDst <= 1'b0;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b01;
                Ctrl_Mem2Reg <= 1'b0;
                Ctrl_regWr <= 1'b1;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b0;
                Ctrl_branch <= 2'b00;
                Ctrl_branch <= 1'b0;
            end
            ANDI:begin
                Ctrl_alu <= 4'b0101;
                Ctrl_regDst <= 1'b0;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b01;
                Ctrl_Mem2Reg <= 1'b0;
                Ctrl_regWr <= 1'b1;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b0;
                Ctrl_branch <= 2'b00;
                Ctrl_jump <= 1'b0;
            end
            ORI:begin
                Ctrl_alu <= 4'b0110;
                Ctrl_regDst <= 1'b0;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b01;
                Ctrl_Mem2Reg <= 1'b0;
                Ctrl_regWr <= 1'b1;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b0;
                Ctrl_branch <= 2'b00;
                Ctrl_jump <= 1'b0;
            end
            XORI:begin
                Ctrl_alu <= 4'b0111;
                Ctrl_regDst <= 1'b0;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b01;
                Ctrl_Mem2Reg <= 1'b0;
                Ctrl_regWr <= 1'b1;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b0;
                Ctrl_branch <= 2'b00;
                Ctrl_jump <= 1'b0;
            end
            LUI:begin
                Ctrl_alu <= 4'b0010;
                Ctrl_regDst <= 1'b0;
                Ctrl_aluSrcA <= 2'b01;
                Ctrl_aluSrcB <= 2'b01;
                Ctrl_Mem2Reg <= 1'b0;
                Ctrl_regWr <= 1'b1;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b0;
                Ctrl_branch <= 2'b00;
                Ctrl_jump <= 1'b0;
            end
            LW:begin
                Ctrl_alu <= 4'b0000;
                Ctrl_regDst <= 1'b0;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b01;
                Ctrl_Mem2Reg <= 1'b1;
                Ctrl_regWr <= 1'b1;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b1;
                Ctrl_branch <= 2'b00;
                Ctrl_jump <= 1'b0;
            end
            SW:begin
                Ctrl_alu <= 4'b0000;
                Ctrl_regDst <= 1'b0;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b01;
                Ctrl_Mem2Reg <= 1'b0;
                Ctrl_regWr <= 1'b0;
                Ctrl_MemWr <= 1'b1;
                Ctrl_ext <= 1'b1;
                Ctrl_branch <= 2'b00;
                Ctrl_jump <= 1'b0;
            end
            BEQ:begin
                Ctrl_alu <= 4'b0001;
                Ctrl_regDst <= 1'b0;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b00;
                Ctrl_Mem2Reg <= 1'b0;//xx
                Ctrl_regWr <= 1'b0;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b1;
                Ctrl_branch <= 2'b01;
                Ctrl_jump <= 1'b0;
            end
            BNE:begin
                Ctrl_alu <= 4'b0001;
                Ctrl_regDst <= 1'b0;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b00;
                Ctrl_Mem2Reg <= 1'b0;//xx
                Ctrl_regWr <= 1'b0;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b1;
                Ctrl_branch <= 2'b10;
                Ctrl_jump <= 1'b0;
            end
            J:begin
                Ctrl_alu <= 4'b0000;//xxxxx
                Ctrl_regDst <= 2'b00;//xx
                Ctrl_aluSrcA <= 2'b00;//xx
                Ctrl_aluSrcB <= 2'b00;//xx
                Ctrl_Mem2Reg <= 2'b00;//xx
                Ctrl_regWr <= 1'b0;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b0;//x
                Ctrl_branch <= 2'b00;
                Ctrl_jump <= 1'b1;
            end
        endcase
    end

endmodule // Ctrl