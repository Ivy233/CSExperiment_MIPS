module ME_WB(
    input clk,
    input rst,
    input[31:0] regin1,
    input[31:0] regin2,
    input[4:0] regin3,
    input mem2regin,
    input regwrin,
    output[31:0] reg_out1,
    output[31:0] reg_out2,
    output[4:0] reg_out3,
    output mem2regout,
    output regwrout
);
    reg[70:0] TMP_reg;

    initial begin
        TMP_reg <= 0;
    end
    always @(posedge rst) begin
        TMP_reg <= 0;
    end

    assign reg_out1 = TMP_reg[70:39];
    assign reg_out2 = TMP_reg[38:7];
    assign reg_out3 = TMP_reg[6:2];
    assign Ctrl_Mem2Reg_out = TMP_reg[1];
    assign Ctrl_regWr_out = TMP_reg[0];

    always @(posedge clk) begin
        TMP_reg <= {
            regin1, regin2, regin3,
            mem2regin, regwrin
        };
    end
endmodule // ME_WB_Reg