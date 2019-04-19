module ME_WB_Reg(
    input clk,
    input rst,
    input[31:0] reg_in1,
    input[31:0] reg_in2,
    input[4:0] reg_in3,
    input Ctrl_Mem2Reg_in,
    input Ctrl_regWr_in,
    output[31:0] reg_out1,
    output[31:0] reg_out2,
    output[4:0] reg_out3,
    output Ctrl_Mem2Reg_out,
    output Ctrl_regWr_out
);
    reg[70:0] TMP_reg;

    initial begin
        TMP_reg = 0;
    end
    always @(posedge rst) begin
        TMP_reg = 0;
    end

    assign reg_out1 = TMP_reg[70:39];
    assign reg_out2 = TMP_reg[38:7];
    assign reg_out3 = TMP_reg[6:2];
    assign Ctrl_Mem2Reg_out = TMP_reg[1];
    assign Ctrl_regWr_out = TMP_reg[0];

    always @(posedge clk) begin
        TMP_reg = {
            reg_in1, reg_in2, reg_in3,
            Ctrl_Mem2Reg_in, Ctrl_regWr_in
        };
    end
endmodule // ME_WB_Reg