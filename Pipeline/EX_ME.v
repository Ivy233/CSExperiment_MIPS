module EX_ME(
    input clk,
    input rst,
    input[31:0] regin1,
    input[31:0] regin2,
    input[4:0] regin3,
    input mem2regin,
    input memwrin,
    input regwrin,

    output[31:0] regout1,
    output[31:0] regout2,
    output[4:0] regout3,
    output mem2regout,
    output memwrout,
    output regwrout,
);
    reg[71:0] TMP_reg;

    initial begin
        TMP_reg = 0;
    end
    always @(posedge rst) begin
        TMP_reg = 0;
    end

    assign regout1 = TMP_reg[71:40];
    assign regout2 = TMP_reg[39:8];
    assign regout3 = TMP_reg[7:3];
    assign mem2regin = TMP_reg[2];
    assign memwrin = TMP_reg[1];
    assign regwrin = TMP_reg[0];

    always @(posedge clk) begin
        TMP_reg = {
            regin1, regin2, regin3,
            mem2regin, memwrin, regwrin
        };
    end
endmodule // EX_ME_Reg