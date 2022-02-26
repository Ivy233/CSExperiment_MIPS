module IF_ID(
    input clk,
    input rst,
    input hazard,
    input[31:0] regin1,
    input[31:0] regin2,
    output reg[31:0] regout1,
    output reg[31:0] regout2
);
    initial begin
        regout1 <= 0;
        regout2 <= 0;
    end
    always @(posedge rst) begin
        regout1 <= 0;
        regout2 <= 0;
    end
    always @(posedge clk) begin
        if(hazard)begin
            regout1 = 0;
            regout2 = 0;
        end else begin
            regout1 = regin1;
            regout2 = regin2;
        end
    end
endmodule // IF_ID_Reg