module PC(clk, rst, pc_next, pc_cur);
    input clk, rst;
    input[31:0] pc_next;
    output reg[31:0] pc_cur;

    always@ (posedge clk or posedge rst)begin
        pc_cur = rst ? 32'h00003000 : pc_next;
    end
endmodule //pc