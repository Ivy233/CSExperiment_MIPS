module Next_PC(
    input clk,
    input rst,
    input Ctrl_jump,
    input[31:0] jumpToWhere,
    input[1:0] Ctrl_branch,
    input Ctrl_alures,
    input[31:0] branchToWhere,
    output reg[31:0] pc_cur
);
    always @(posedge rst) begin
        pc_cur = 32'h00003000;
    end
    always @(posedge clk) begin
        if(Ctrl_jump == 1'b1) begin
            pc_cur = jumpToWhere;
        end//j
        else if(Ctrl_branch == 2'b01 && Ctrl_alures == 1'b1)begin
            pc_cur = branchToWhere;
        end//beq
        else if(Ctrl_branch == 2'b10 && Ctrl_alures == 1'b0)begin
            pc_cur = branchToWhere;
        end//bne
        else begin
            pc_cur = pc_cur + 3'b100;
        end//other
    end
endmodule // Next_PC