module Next_PC(
    input[31:0] pc_cur,
    input Ctrl_jump,
    input[31:0] jumpToWhere,
    input[1:0] Ctrl_branch,
    input Ctrl_alures,
    input[31:0] branchToWhere,
    output reg[31:0] pc_next
);
    always @(*) begin
        if(Ctrl_jump == 1'b1) begin
            pc_next = jumpToWhere;
        end//j
        else if(Ctrl_branch == 2'b01 && Ctrl_alures == 1'b1)begin
            pc_next = branchToWhere;
        end//beq
        else if(Ctrl_branch == 2'b10 && Ctrl_alures == 1'b0)begin
            pc_next = branchToWhere;
        end//bne
        else begin
            pc_next = pc_cur;
        end//other
    end
endmodule // Next_PC