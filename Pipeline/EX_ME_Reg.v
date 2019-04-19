module EX_ME_Reg(
    input clk,
    input rst,
    input[31:0] reg_in1,
    input[4:0] reg_in2,
    input[31:0] reg_in3,
    input[31:0] reg_in4,
    input Ctrl_Mem2Reg_in,
    input Ctrl_regWr_in,
    input Ctrl_MemWr_in,
    input[1:0] Ctrl_branch_in,
    input Ctrl_alures_in,
    output[31:0] reg_out1,
    output[4:0] reg_out2,
    output[31:0] reg_out3,
    output[31:0] reg_out4,
    output Ctrl_Mem2Reg_out,
    output Ctrl_regWr_out,
    output Ctrl_MemWr_out,
    output[1:0] Ctrl_branch_out,
    output Ctrl_alures_out,
);
    reg[106:0] TMP_reg;

    initial begin
        TMP_reg = 0;
    end
    always @(posedge rst) begin
        TMP_reg = 0;
    end

    assign reg_out1 = TMP_reg[106:75];
    assign reg_out2 = TMP_reg[74:70];
    assign reg_out3 = TMP_reg[69:38];
    assign reg_out4 = TMP_reg[37:6];
    assign Ctrl_Mem2Reg_out = TMP_reg[5];
    assign Ctrl_regWr_out = TMP_reg[4];
    assign Ctrl_MemWr_out = TMP_reg[3];
    assign Ctrl_branch_out = TMP_reg[2:1];
    assign Ctrl_alures_out = TMP_reg[0];

    always @(posedge clk) begin
        TMP_reg = {
            reg_in1, reg_in2, reg_in3, reg_in4,
            Ctrl_Mem2Reg_in, Ctrl_regWr_in, Ctrl_MemWr_in, Ctrl_branch_in
        };
    end
endmodule // EX_ME_Reg