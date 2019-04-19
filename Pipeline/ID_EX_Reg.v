module ID_EX_Reg(
    input clk,
    input rst,
    input[31:0] reg_in1,
    input[31:0] reg_in2,
    input[4:0] reg_in3,
    input[4:0] reg_in4,
    input[4:0] reg_in5,
    input[31:0] reg_in6,
    input[3:0] Ctrl_alu_in,
    input Ctrl_regDst_in,
    input[1:0] Ctrl_aluSrcA_in,
    input[1:0] Ctrl_aluSrcB_in,
    input Ctrl_Mem2Reg_in,
    input Ctrl_regWr_in,
    input Ctrl_MemWr_in,
    input[1:0] Ctrl_branch_in,
    output[31:0] reg_out1,
    output[31:0] reg_out2,
    output[4:0] reg_out3,
    output[4:0] reg_out4,
    output[4:0] reg_out5,
    output[31:0] reg_out6,
    output[3:0] Ctrl_alu_out,
    output Ctrl_regDst_out,
    output[1:0] Ctrl_aluSrcA_out,
    output[1:0] Ctrl_aluSrcB_out,
    output Ctrl_Mem2Reg_out,
    output Ctrl_regWr_out,
    output Ctrl_MemWr_out,
    output[1:0] Ctrl_branch_out,
);
    reg[124:0] TMP_reg;

    initial begin
        TMP_reg = 0;
    end
    always @(posedge rst) begin
        TMP_reg = 0;
    end

    assign reg_out1 = TMP_reg[124:93];
    assign reg_out2 = TMP_reg[92:61];
    assign reg_out3 = TMP_reg[60:56];
    assign reg_out4 = TMP_reg[55:51];
    assign reg_out5 = TMP_reg[50:46];
    assign reg_out6 = TMP_reg[45:14];
    assign Ctrl_alu_out = TMP_reg[13:10];
    assign Ctrl_regDst_out = TMP_reg[9];
    assign Ctrl_aluSrcA_out = TMP_reg[8:7];
    assign Ctrl_aluSrcB_out = TMP_reg[6:5];
    assign Ctrl_Mem2Reg_out = TMP_reg[4];
    assign Ctrl_regWr_out = TMP_reg[3];
    assign Ctrl_MemWr_out = TMP_reg[2];
    assign Ctrl_branch_out = TMP_reg[1:0];

    always @(posedge clk) begin
        TMP_reg = {
            reg_in1, reg_in2, reg_in3, reg_in4, reg_in5, reg_in6,
            Ctrl_alu_in, Ctrl_regDst_in, Ctrl_aluSrcA_in, Ctrl_aluSrcB_in,
            Ctrl_Mem2Reg_in, Ctrl_regWr_in, Ctrl_MemWr_in, Ctrl_branch_in
        };
    end
endmodule // ID_EX_Reg