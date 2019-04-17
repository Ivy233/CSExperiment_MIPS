module Next_PC(
    input[31:0] pc_cur,
    input[5:0] op,
    input[5:0] funct,
    input[15:0] branch_delta,
    input[26:0] jumpToWhere,
    input[31:0] aluout,
    output reg[31:0] pc_next
);
    parameter 	BEQ				= 6'b000100,
				BNE				= 6'b000101,
				J				= 6'b000010;
    wire[31:0] pc4;
    assign pc4 = pc_cur + 3'b100;
    always @(*) begin
        case (op)
            BEQ:begin
                pc_next = pc4 + (aluout==32'b00000000 ? { {14{branch_delta[15]}}, branch_delta[15:0],2'b00} : 0);
            end
            BNE:begin
                pc_next = pc4 + (aluout!=32'b00000000 ? { {14{branch_delta[15]}}, branch_delta[15:0],2'b00} : 0);
            end
            J:begin
                pc_next = {pc_cur[31:28], jumpToWhere[25:0], 2'b00};
            end
            default  pc_next = pc4;
        endcase
    end
endmodule // Next_PC