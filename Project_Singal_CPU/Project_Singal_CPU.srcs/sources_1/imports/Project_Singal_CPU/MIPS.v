module MIPS(
    input clk,
    input rst,
    output[15:0] Ctrl_out,
    output[31:0] display_data
);
    //PC & ins
    wire[31:0] pc_next, pc_cur, instr;

    //ctrl
    wire[4:0] Ctrl_alu;//alu
    wire[1:0] Ctrl_regDst, Ctrl_aluSrcA, Ctrl_aluSrcB, Ctrl_Mem2Reg;//MUX
    wire Ctrl_regWr, Ctrl_MemWr, Ctrl_ext;

    //reg_out & alu_input & Mem
    wire[31:0] reg_out1, reg_out2, alu_input1, alu_input2;
    wire[31:0] alu_output;
    wire[31:0] Mem_output;

    //other
    wire[4:0] RegFile_write_import;
    wire[31:0] Ext_imm_16, Mem_RegFile_write_data, tmp_output;
    assign Ctrl_out = {Ctrl_alu, Ctrl_regDst, Ctrl_aluSrcA, Ctrl_aluSrcB, Ctrl_Mem2Reg, Ctrl_regWr, Ctrl_MemWr, Ctrl_ext};
    reg[3:0]tmp_import;
    initial begin
        tmp_import=3'b000;
    end
    always @(posedge clk) begin
        if(instr == 32'h00000000) begin
            tmp_import = tmp_import + 1;
            if(tmp_import >= 3'b101) begin
                tmp_import = 0;
            end
        end
    end

    PC U_PC(
        .clk(clk),
        .rst(rst),
        .pc_next(pc_next),
        .pc_cur(pc_cur)//output
    );
    Next_PC U_Next_PC(
        .pc_cur(pc_cur),
        .op(instr[31:26]),
        .funct(instr[5:0]),
        .branch_delta(instr[15:0]),
        .jumpToWhere(instr[25:0]),
        .aluout(alu_output),
        .pc_next(pc_next)//output
    );

    Instr_Mem U_Instr_Mem(
        .a(pc_cur[11:2]),
        .spo(instr)//output
    );

    Ctrl U_Ctrl(
        .op(instr[31:26]),
        .funct(instr[5:0]),
        //output
        .Ctrl_alu(Ctrl_alu),
        .Ctrl_regDst(Ctrl_regDst),
        .Ctrl_aluSrcA(Ctrl_aluSrcA),
        .Ctrl_aluSrcB(Ctrl_aluSrcB),
        .Ctrl_Mem2Reg(Ctrl_Mem2Reg),
        .Ctrl_ext(Ctrl_ext),
        .Ctrl_regWr(Ctrl_regWr),
        .Ctrl_MemWr(Ctrl_MemWr)
    );

    Ext U_Ext(
        .imm_16(instr[15:0]),
        .Ctrl_ext(Ctrl_ext),
        .output_imm_32(Ext_imm_16)//output
    );

    MUX #(5) Choose_Rt_Rd(
        .a(instr[20:16]),
        .b(instr[15:11]),
        .Ctrl_MUX(Ctrl_regDst),
        .MUX_output(RegFile_write_import)//output
    );

    RegFile U_Regfile(
        .clk(clk),
        .Read_import1(instr[25:21]),
        .Read_import2(instr[20:16]),
        .Write_import(RegFile_write_import),
        .Write_data(Mem_RegFile_write_data),
        .Ctrl_regWr(Ctrl_regWr),

        //output
        .Rout1(reg_out1),
        .Rout2(reg_out2)
    );

    MUX #(32) choose_aluinput1(
        .a(reg_out1),
        .b(32'h00000010),//lui
        .c({ {27{1'b0}} , instr[10:6]}),
        .Ctrl_MUX(Ctrl_aluSrcA),
        .MUX_output(alu_input1)//output
    );
    MUX #(32) choose_aluinput2(
        .a(reg_out2),
        .b(Ext_imm_16),
        .Ctrl_MUX(Ctrl_aluSrcB),
        .MUX_output(alu_input2)//output
    );

    ALU U_ALU(
        .input1(alu_input1),
        .input2(alu_input2),
        .Ctrl_alu(Ctrl_alu),
        .ALU_output(alu_output)//output
    );

    Mem U_Mem(
        .input_pos(alu_output),
        .input_data(reg_out2),
        .Ctrl_MemWr(Ctrl_MemWr),
        .clk(clk),
        .Mem_output(Mem_output),//output
        .tmp_import(tmp_import),
        .tmp_output(tmp_output)
    );

    MUX choose_writeBack(
        .a(alu_output),
        .b(Mem_output),
        .Ctrl_MUX(Ctrl_Mem2Reg),
        .MUX_output(Mem_RegFile_write_data)
    );

    assign display_data = instr ? ((pc_cur - 32'h00003000) >> 2) : tmp_output;

endmodule //