module PC(
    input clk,
    input rst,
    input[31:0] pc_next,
    output reg[31:0] pc_cur
);
    initial begin
        pc_cur = 32'h00003000;
    end
    always@ (posedge clk or posedge rst)begin
        pc_cur = rst ? 32'h00003000 : pc_next;
        $display("pc_cur=%8X, pc_next=%8X", pc_cur,pc_next);
    end
endmodule //pc