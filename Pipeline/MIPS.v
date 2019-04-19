module MIPS();
    //clk & rst
    reg clk, reset;
    initial begin
        $readmemh("Bubble_sort.txt", U_Instr_Mem.Instrs);
        clk = 1;
        reset = 1;
        #20 reset = 0;
    end
    always #50 clk = ~clk;

    //IF
    wire[31:0] IF_instr, IF_pc_cur, IF_pc_next;
    //ID
    wire[31:0] ID_pc_cur, ID_instr;
    wire[31:0] ID_Ext_imm_16, ID_reg_out1, ID_reg_out2;
        //ID:Ctrl
        wire[4:0] ID_Ctrl_alu;
        wire[1:0] ID_Ctrl_aluSrcA, ID_Ctrl_aluSrcB;
        wire[1:0] ID_Ctrl_branch;
        wire ID_Ctrl_Mem2Reg, ID_Ctrl_MemWr, ID_Ctrl_ext, ID_Ctrl_jump, ID_Ctrl_regDst, ID_Ctrl_regWr;
    //EX
    wire[31:0] EX_Ext_imm_16;
    wire[31:0] EX_alu_in1, EX_alu_in2, EX_alu_out;
    wire[31:0] EX_reg_out1,EX_reg_out2;
    wire[4:0] EX_reg_write_import1, EX_reg_write_import2, EX_reg_write_import;
    wire[4:0] EX_shamt;
        //EX:Ctrl
        wire[3:0] EX_Ctrl_alu;
        wire[1:0] EX_Ctrl_aluSrcA, EX_Ctrl_aluSrcB;
        wire[1:0] EX_Ctrl_branch;
        wire EX_Ctrl_Mem2Reg, EX_Ctrl_MemWr, EX_Ctrl_alures, EX_Ctrl_regDst, EX_Ctrl_regWr;
    //ME
    wire[31:0] ME_Mem_out, ME_alu_out, ME_branchToWhere, ME_mem_write_data, Mem_out;
    wire[4:0] ME_reg_write_import;
        //ME:Ctrl
        wire[1:0] ME_Ctrl_branch;
        wire ME_Ctrl_Mem2Reg, ME_Ctrl_MemWr, ME_Ctrl_alures, ME_Ctrl_regWr;
    //WB
    wire[31:0] WB_reg_write_data, WB_reg_write_data1, WB_reg_write_data2;
    wire[4:0] WB_reg_write_import;
        //WB:Ctrl
        wire WB_Ctrl_Mem2Reg, WB_Ctrl_regWr;

    //Units
    //ID
    Next_PC U_Next_PC(
        //nothing:+4
        .pc_cur(IF_pc_cur),//32: have been increased by 4
        //jump:j
        .Ctrl_jump(ID_Ctrl_jump),//1
        .jumpToWhere({ID_pc_cur[31:28], ID_instr[25:0], 2'b00}),//32
        //branch:beq,bne
        .Ctrl_branch(ME_Ctrl_branch),//1
        .Ctrl_alures(ME_Ctrl_alures),//1
        .branchToWhere(ME_branchToWhere),//32
        //out
        .pc_next(IF_pc_next)//32
    );
    PC U_PC(
        .clk(clk),//1
        .rst(reset),//1
        .pc_next(IF_pc_next),//32
        .pc_cur(IF_pc_cur)//32
    );
    Instr_Mem U_Instr_Mem(
        .pc_cur(IF_pc_cur[11:2]),//10
        //out
        .instr(IF_instr)//32
    );
    assign IF_pc_cur=IF_pc_cur + 3'b100;
    //IF_ID
    ID_IF_Reg U_ID_IF_Reg(
        .clk(clk),//1
        .rst(reset),//1
        .reg_in1(IF_pc_cur),//32
        .reg_in2(IF_instr),//32
        //out
        .reg_out1(ID_pc_cur),//32
        .reg_out2(ID_instr),//32
    );
    //ID
    Ctrl U_Ctrl(
        .op(ID_instr[31:26]),//6
        .funct(ID_instr[5:0]),//6
        //out
        .Ctrl_alu(ID_Ctrl_alu),//4
        .Ctrl_regDst(ID_Ctrl_regDst),//1
        .Ctrl_aluSrcA(ID_Ctrl_aluSrcA),//2
        .Ctrl_aluSrcB(ID_Ctrl_aluSrcB),//2
        .Ctrl_Mem2Reg(ID_Ctrl_Mem2Reg),//1
        .Ctrl_ext(ID_Ctrl_ext),//1
        .Ctrl_regWr(ID_Ctrl_regWr),//1
        .Ctrl_MemWr(ID_Ctrl_MemWr),//1
        .Ctrl_branch(ID_Ctrl_branch),//2
        .Ctrl_jump(ID_Ctrl_jump)//1
    );
    Ext U_Ext(
        .imm_16(ID_instr[15:0]),//16
        .Ctrl_ext(ID_Ctrl_ext),//1
        //out
        .out_imm_32(ID_Ext_imm_16)//31
    );
    RegFile U_Regfile(
        .clk(clk),//1
        .Read_import1(ID_instr[25:21]),//5
        .Read_import2(ID_instr[20:16]),//5
        .Write_import(WB_reg_write_import),//5
        .Write_data(WB_reg_write_data),//32
        .Ctrl_regWr(WB_Ctrl_regWr),//1
        //out
        .Rout1(ID_reg_out1),//32
        .Rout2(ID_reg_out2)//32
    );
    //ID_EX
    ID_EX_Reg U_ID_EX_Reg(
        .clk(clk),//1
        .rst(reset),//1
        .reg_in1(ID_reg_out1),//32
        .reg_in2(ID_reg_out2),//32
        .reg_in3(ID_instr[20:16]),//5
        .reg_in4(ID_instr[15:11]),//5
        .reg_in5(ID_instr[10:6]),//5
        .reg_in6(ID_pc_cur),//32
        .Ctrl_alu_in(ID_Ctrl_alu),//4
        .Ctrl_regDst_in(ID_Ctrl_regDst),//1
        .Ctrl_aluSrcA_in(ID_Ctrl_aluSrcA),//2
        .Ctrl_aluSrcB_in(ID_Ctrl_aluSrcB),//2
        .Ctrl_Mem2Reg_in(ID_Ctrl_Mem2Reg),//1
        .Ctrl_regWr_in(ID_Ctrl_regWr),//1
        .Ctrl_MemWr_in(ID_Ctrl_MemWr),//1
        .Ctrl_branch_in(ID_Ctrl_branch),//1
        //out
        .reg_out1(EX_reg_out1),//32
        .reg_out2(EX_reg_out2),//32
        .reg_out3(EX_reg_write_import1),//5
        .reg_out4(EX_reg_write_import2),//5
        .reg_out5(EX_shamt),//5
        .reg_out6(EX_pc_cur),//32
        .Ctrl_alu_out(EX_Ctrl_alu),//4
        .Ctrl_regDst_out(EX_Ctrl_regDst),//1
        .Ctrl_aluSrcA_out(EX_Ctrl_aluSrcA),//2
        .Ctrl_aluSrcB_out(EX_Ctrl_aluSrcB),//2
        .Ctrl_Mem2Reg_out(EX_Ctrl_Mem2Reg),//1
        .Ctrl_regWr_out(EX_Ctrl_regWr),//1
        .Ctrl_MemWr_out(EX_Ctrl_MemWr),//1
        .Ctrl_branch_out(EX_Ctrl_branch),//1
    );
    //EX
    MUX #(5) Choose_Rt_Rd(
        .a(EX_reg_write_import1),//rt,5
        .b(EX_reg_write_import2),//rd,5
        .Ctrl_MUX({1'b0, EX_Ctrl_regDst}),//1
        //out
        .MUX_out(EX_reg_write_import)//5
    );
    MUX #(32) choose_aluin1(
        .a(EX_reg_out1),//32
        .b(32'h00000010),//lui,32
        .c({ {27{1'b0}}, shamt}),//32
        .Ctrl_MUX(EX_Ctrl_aluSrcA),//2
        //out
        .MUX_out(EX_alu_in1)//32
    );
    MUX #(32) choose_aluin2(
        .a(EX_reg_out2),//32
        .b(EX_Ext_imm_16),//32
        .Ctrl_MUX(EX_Ctrl_aluSrcB),//2
        //out
        .MUX_out(EX_alu_in2)//32
    );

    ALU U_ALU(
        .in1(EX_alu_in1),//32
        .in2(EX_alu_in2),//32
        .Ctrl_alu(EX_Ctrl_alu),//4
        //out
        .ALU_out(EX_alu_out),//32
        .zero(EX_Ctrl_alures)//1
    );
    //EX_ME
    EX_ME_Reg U_EX_ME_Reg(
        .clk(clk),//1
        .rst(reset),//1
        .reg_in1(EX_alu_out),//32
        .reg_in2(EX_reg_write_import),//5
        .reg_in3(EX_reg_out2),//32
        .reg_in4(EX_pc_cur + {EX_Ext_imm_16[29:0], 2'b00});//32
        .Ctrl_Mem2Reg_in(EX_Ctrl_Mem2Reg),//1
        .Ctrl_regWr_in(EX_Ctrl_regWr),//1
        .Ctrl_MemWr_in(EX_Ctrl_MemWr),//1
        .Ctrl_branch_in(EX_Ctrl_branch),//1
        .Ctrl_alures_in(EX_Ctrl_alures),//1
        //out
        .reg_out1(ME_alu_out),//32
        .reg_out2(ME_reg_write_import),//5
        .reg_out3(ME_mem_write_data),//32
        .reg_out4(ME_branchToWhere),//32
        .Ctrl_Mem2Reg_out(ME_Ctrl_Mem2Reg),//1
        .Ctrl_regWr_out(ME_Ctrl_regWr),//1
        .Ctrl_MemWr_out(ME_Ctrl_MemWr),//1
        .Ctrl_branch_out(ME_Ctrl_branch),//1
        .Ctrl_alures_out(ME_Ctrl_alures)//1
    );
    //ME
    Mem U_Mem(
        .clk(clk),
        .in_pos(ME_alu_out),
        .in_data(ME_mem_write_data),
        .Ctrl_MemWr(ME_Ctrl_MemWr),
        //out
        .Mem_out(ME_Mem_out)//out
    );
    //ME_WB
    ME_WB_Reg U_ME_WB_Reg(
        .clk(clk),//1
        .rst(reset),//1
        .reg_in1(ME_alu_out),//32
        .reg_in2(ME_Mem_out),//32
        .reg_in3(ME_reg_write_import),//5
        .Ctrl_Mem2Reg_in(ME_Ctrl_Mem2Reg),//1
        .Ctrl_regWr_in(ME_Ctrl_regWr),//1
        //out
        .reg_out1(WB_reg_write_data1),//32
        .reg_out2(WB_reg_write_data2),//5
        .reg_out3(WB_reg_write_import),//32
        .Ctrl_Mem2Reg_out(WB_Ctrl_Mem2Reg),//1
        .Ctrl_regWr_out(WB_Ctrl_regWr),//1
    );
    //WB
    MUX #(32) choose_writeBack(
        .a(WB_reg_write_data1),
        .b(WB_reg_write_data1),
        .Ctrl_MUX({1'b0,WB_Ctrl_Mem2Reg}),
        .MUX_out(WB_reg_write_data)
    );

endmodule //