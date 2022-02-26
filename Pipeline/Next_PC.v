module Next_PC(
    input clk,
    input rst,
    input hazard,
    input jump,
    input[31:0] jump2where,
    input branch,
    input[31:0] branch2where,
    output reg[31:0] pc
);
    always @(posedge rst) begin
        if(rst)begin
            pc <= 32'h00003000;
        end
    end
    always @(posedge clk) begin
        if(jump == 1'b1) begin
            pc <= jump2where;
        end//j
        else if(branch)begin
            pc <= branch2where;
        end
        else if(hazard)begin
            pc <= pc;
        end
        else begin
            pc <= pc + 3'b100;
        end//other
    end
endmodule // Next_PC