module Ctrl(
    op, funct,
    Ctrl_alu,
    Ctrl_regDst, Ctrl_aluSrcA, Ctrl_aluSrcB, Ctrl_Mem2Reg, Ctrl_ext,
    Ctrl_regWr, Ctrl_MemWr
);
    input[5:0] op;
    input[5:0] funct;
    output reg[4:0] Ctrl_alu;
    output reg[1:0] Ctrl_regDst, Ctrl_aluSrcA, Ctrl_aluSrcB, Ctrl_Mem2Reg;
    output reg Ctrl_regWr, Ctrl_MemWr, Ctrl_ext;

    // Operation code;
	parameter  	R 				= 6'b000000,
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
                Ctrl_regDst <= 2'b01;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_Mem2Reg <= 2'b00;
                Ctrl_ext <= 1'bx;
                Ctrl_MemWr <= 1'b0;
                Ctrl_regWr <= 1'b1;
                case (funct)
                    ADD:begin
                        Ctrl_aluSrcB <= 2'b00;
                        Ctrl_alu <= 5'b00000;
                    end
                    ADDU:begin
                        Ctrl_aluSrcB <= 2'b00;
                        Ctrl_alu <= 5'b00000;
                    end
                    SUB:begin
                        Ctrl_aluSrcB <= 2'b00;
                        Ctrl_alu <= 5'b00001;
                    end
                    SUBU:begin
                        Ctrl_aluSrcB <= 2'b00;
                        Ctrl_alu <= 5'b00001;
                    end

                    SLL:begin
                        Ctrl_aluSrcB <= 2'b01;
                        Ctrl_alu <= 5'b00010;
                    end
                    SRL:begin
                        Ctrl_aluSrcB <= 2'b01;
                        Ctrl_alu <= 5'b00011;
                    end
                    SRL:begin
                        Ctrl_aluSrcB <= 2'b01;
                        Ctrl_alu <= 5'b00011;
                    end

                    AND:begin
                        Ctrl_aluSrcB <= 2'b00;
                        Ctrl_alu <= 5'b00101;
                    end
                    OR:begin
                        Ctrl_aluSrcB <= 2'b00;
                        Ctrl_alu <= 5'b00110;
                    end
                    XOR:begin
                        Ctrl_aluSrcB <= 2'b00;
                        Ctrl_alu <= 5'b00111;
                    end
                    NOR:begin
                        Ctrl_aluSrcB <= 2'b00;
                        Ctrl_alu <= 5'b01010;
                    end

                    SLT:begin
                        Ctrl_aluSrcB <= 2'b00;
                        Ctrl_alu <= 5'b00100;
                    end
                    SLTU:begin
                        Ctrl_aluSrcB <= 2'b00;
                        Ctrl_alu <= 5'b01000;
                    end
                endcase
            end
            ADDIU:begin
                Ctrl_alu <= 5'b00000;
                Ctrl_regDst <= 2'b00;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b10;
                Ctrl_Mem2Reg <= 2'b00;
                Ctrl_regWr <= 1'b1;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b0;
            end
            SLTI:begin
                Ctrl_alu <= 5'b00100;
                Ctrl_regDst <= 2'b00;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b10;
                Ctrl_Mem2Reg <= 2'b00;
                Ctrl_regWr <= 1'b1;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b1;
            end
            SLTIU:begin
                Ctrl_alu <= 5'b01000;
                Ctrl_regDst <= 2'b00;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b10;
                Ctrl_Mem2Reg <= 2'b00;
                Ctrl_regWr <= 1'b1;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b0;
            end
            ANDI:begin
                Ctrl_alu <= 5'b00101;
                Ctrl_regDst <= 2'b00;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b10;
                Ctrl_Mem2Reg <= 2'b00;
                Ctrl_regWr <= 1'b1;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b0;
            end
            ORI:begin
                Ctrl_alu <= 5'b00110;
                Ctrl_regDst <= 2'b00;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b10;
                Ctrl_Mem2Reg <= 2'b00;
                Ctrl_regWr <= 1'b1;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b0;
            end
            XORI:begin
                Ctrl_alu <= 5'b00111;
                Ctrl_regDst <= 2'b00;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b10;
                Ctrl_Mem2Reg <= 2'b00;
                Ctrl_regWr <= 1'b1;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b0;
            end
            LUI:begin
                Ctrl_alu <= 5'b00010;
                Ctrl_regDst <= 2'b00;
                Ctrl_aluSrcA <= 2'b01;
                Ctrl_aluSrcB <= 2'b10;
                Ctrl_Mem2Reg <= 2'b00;
                Ctrl_regWr <= 1'b1;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b0;
            end
            LW:begin
                Ctrl_alu <= 5'b00000;
                Ctrl_regDst <= 2'b00;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b10;
                Ctrl_Mem2Reg <= 2'b01;
                Ctrl_regWr <= 1'b1;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b0;
            end
            SW:begin
                Ctrl_alu <= 5'b00000;
                Ctrl_regDst <= 2'b00;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b10;
                Ctrl_Mem2Reg <= 2'b00;
                Ctrl_regWr <= 1'b0;
                Ctrl_MemWr <= 1'b1;
                Ctrl_ext <= 1'b0;
            end
            BEQ:begin
                Ctrl_alu <= 5'b00001;
                Ctrl_regDst <= 2'b00;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b00;
                Ctrl_Mem2Reg <= 2'b00;
                Ctrl_regWr <= 1'b0;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b1;
            end
            BNE:begin
                Ctrl_alu <= 5'b00001;
                Ctrl_regDst <= 2'b00;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b00;
                Ctrl_Mem2Reg <= 2'b00;
                Ctrl_regWr <= 1'b0;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b1;
            end
            J:begin
                Ctrl_alu <= 5'b00000;
                Ctrl_regDst <= 2'b00;
                Ctrl_aluSrcA <= 2'b00;
                Ctrl_aluSrcB <= 2'b00;
                Ctrl_Mem2Reg <= 2'b00;
                Ctrl_regWr <= 1'b0;
                Ctrl_MemWr <= 1'b0;
                Ctrl_ext <= 1'b0;
            end
        endcase
    end

endmodule // Ctrl