module MIPS();
    //IF
    wire[31:0] IF_instr, IF_pc;
    //ID
    wire[31:0] ID_pc, ID_instr;
    wire[31:0] ID_Ext_imm_16, ID_reg_out1, ID_reg_out2;
        //ID:Ctrl
        wire[3:0] ID_Ctrl_alu;
        wire[1:0] ID_Ctrl_aluSrcA, ID_Ctrl_aluSrcB;
        wire[1:0] ID_Ctrl_branch;
        wire ID_Ctrl_Mem2Reg, ID_Ctrl_MemWr, ID_Ctrl_ext, ID_Ctrl_jump, ID_Ctrl_regDst, ID_Ctrl_regWr;
        wire ID_hazard, ID_Condition;
    //EX
    wire[31:0] EX_Ext_imm_16, EX_alu_out;
    wire[31:0] EX_reg_out1,EX_reg_out2;
    wire[4:0] EX_shamt, EX_Rs, EX_Rt, EX_Rd;
        //EX:Ctrl
        wire[3:0] EX_Ctrl_alu;
        wire[1:0] EX_Ctrl_aluSrcA, EX_Ctrl_aluSrcB;
        wire EX_Ctrl_Mem2Reg, EX_Ctrl_MemWr, EX_Ctrl_regDst, EX_Ctrl_regWr;
    //ME
    wire[31:0] ME_Mem_out, ME_alu_out, ME_mem_write_data;
    wire[4:0] ME_reg_write_import;
        //ME:Ctrl
        wire ME_Ctrl_Mem2Reg, ME_Ctrl_MemWr, ME_Ctrl_regWr;
    //WB
    wire[31:0] WB_alu_out, WB_mem_out;
    wire[4:0] WB_reg_write_import;
        //WB:Ctrl
        wire WB_Ctrl_Mem2Reg, WB_Ctrl_regWr;

    //
    wire[1:0] ForwardA, ForwardB, ForwardC, ForwardD;

    //clk & rst
    reg clk, rst;
    initial begin
        $readmemh("others/Instr_MIPS_Pipeline.txt", U_Instr_Mem.Instrs);
        clk = 1;
        rst = 0;
        #5 rst = 1;
        #20 rst = 0;
    end
    always #50 clk = ~clk;

    Next_PC U_Next_PC(
        .clk(clk),
        .rst(rst),
        .hazard(ID_hazard),
        //jump
        .jump(ID_Ctrl_jump),
        .jump2where({ID_pc[31:28], ID_instr[25:0], 2'b00}),
        //branch
        .branch((ID_Ctrl_branch == 2'b01 && ID_Condition == 1'b1)
                || (ID_Ctrl_branch == 2'b10 && ID_Condition == 1'b0)),//beq || bne
        .branch2where(ID_pc + {{14{ID_instr[15]}}, ID_instr[15:0], 2'b00}),
        .pc(IF_pc)
    );
    Instr_Mem U_Instr_Mem(
        .pc(IF_pc[11:2]),
        .instr(IF_instr)
    );

    IF_ID U_IFID(
        .clk(clk),
        .rst(rst),
        .hazard(ID_hazard),

        .regin1(IF_pc),
        .regin2(IF_instr),

        .regout1(ID_pc),
        .regout2(ID_instr)
    );
    RegFile U_RegFile(
        .clk(clk),
        .Writedata(U_Mem2Reg.out),
        .regWr(WB_Ctrl_regWr),
        .writeimport(WB_reg_write_import),
        .readimport1(ID_instr[25:21]),
        .readimport2(ID_instr[20:16]),
        .regfile_out1(ID_reg_out1),
        .regfile_out2(ID_reg_out2)
    );
    Hazard U_Hazard(
        .jump(ID_Ctrl_jump),
        .branch(U_Next_PC.branch),
        .mem2reg(ID_Ctrl_Mem2Reg),
        .IF_Rs(IF_instr[25:21]),
        .IF_Rt(IF_instr[20:16]),
        .ID_Rt(ID_instr[20:16]),
        .hazard(ID_hazard)
    );
    Ctrl U_Ctrl(
        .op(ID_instr[31:26]),
        .funct(ID_instr[5:0]),
        //output
        .Ctrl_alu(ID_Ctrl_alu),
        .Ctrl_regDst(ID_Ctrl_regDst),
        .Ctrl_aluSrcA(ID_Ctrl_aluSrcA),
        .Ctrl_aluSrcB(ID_Ctrl_aluSrcB),
        .Ctrl_Mem2Reg(ID_Ctrl_Mem2Reg),
        .Ctrl_ext(ID_Ctrl_ext),
        .Ctrl_regWr(ID_Ctrl_regWr),
        .Ctrl_MemWr(ID_Ctrl_MemWr),
        .Ctrl_branch(ID_Ctrl_branch),
        .Ctrl_jump(ID_Ctrl_jump)
    );

    MUX #(32) U_ForwardC(
        .a(ID_reg_out1),
        .b(EX_alu_out),
        .c(ME_alu_out),
        .d(U_Mem2Reg.out),
        .Ctrl(ForwardC)
    );
    MUX #(32) U_ForwardD(
        .a(ID_reg_out2),
        .b(EX_alu_out),
        .c(ME_alu_out),
        .d(U_Mem2Reg.out),
        .Ctrl(ForwardD)
    );
    Equal U_Equal(
        .input1(U_ForwardC.out),
        .input2(U_ForwardD.out),
        .equal(ID_Condition)
    );
    Ext U_Ext(
        .input0(ID_instr[15:0]),
        .op(ID_Ctrl_ext),
        .out(ID_Ext_imm_16)
    );
    ID_EX U_IDEX(
        .clk(clk),
        .rst(rst),

        .regin1(ID_reg_out1),
        .regin2(ID_reg_out2),
        .regin3(ID_Ext_imm_16),
        .regin4(ID_instr[25:21]),
        .regin5(ID_instr[20:16]),
        .regin6(ID_instr[15:11]),
        .regin7(ID_instr[10:6]),
        .regdstin(ID_Ctrl_regDst),
        .aluopin(ID_Ctrl_alu),
        .alusrcain(ID_Ctrl_aluSrcA),
        .alusrcbin(ID_Ctrl_aluSrcB),
        .mem2regin(ID_Ctrl_Mem2Reg),
        .regwrin(ID_Ctrl_regWr),
        .memwrin(ID_Ctrl_MemWr),

        .regout1(EX_reg_out1),
        .regout2(EX_reg_out2),
        .regout3(EX_Ext_imm_16),
        .regout4(EX_Rs),
        .regout5(EX_Rt),
        .regout6(EX_Rd),
        .regout7(EX_shamt),
        .regdstout(EX_Ctrl_regDst),
        .aluopout(EX_Ctrl_alu),
        .alusrcaout(EX_Ctrl_aluSrcA),
        .alusrcbout(EX_Ctrl_aluSrcB),
        .mem2regout(EX_Ctrl_Mem2Reg),
        .regwrout(EX_Ctrl_regWr),
        .memwrout(EX_Ctrl_MemWr)
    );
    MUX #(5) U_RegDst(
        .a(EX_Rt),
        .b(EX_Rd),
        .Ctrl({1'b0,EX_Ctrl_regDst})
    );
    MUX #(32) U_ForwardA(
        .a(EX_reg_out1),
        .b(U_Mem2Reg.out),
        .c(ME_alu_out),
        .Ctrl(ForwardA)
    );
    MUX #(32) U_ALUSrcA(
        .a(U_ForwardA.out),
        .b(32'h00000010),//lui
        .c({{27{1'b0}}, EX_shamt}),
        .Ctrl(EX_Ctrl_aluSrcA)
    );
    MUX #(32) U_ForwardB(
        .a(EX_reg_out2),
        .b(U_Mem2Reg.out),
        .c(ME_alu_out),
        .Ctrl(ForwardB)
    );
    MUX #(32) U_ALUSrcB(
        .a(U_ForwardB.out),
        .b(EX_Ext_imm_16),
        .Ctrl(EX_Ctrl_aluSrcB)
    );
    ALU U_ALU(
        .input1(U_ALUSrcA.out),
        .input2(U_ALUSrcB.out),
        .aluop(EX_Ctrl_alu),
        .out(EX_alu_out)
    );

    EX_ME U_EXME(
        .clk(clk),
        .rst(rst),

        .regin1(EX_alu_out),
        .regin2(U_ForwardB.out),
        .regin3(U_RegDst.out),
        .mem2regin(EX_Ctrl_Mem2Reg),
        .memwrin(EX_Ctrl_MemWr),
        .regwrin(EX_Ctrl_regWr),

        .regout1(ME_alu_out),
        .regout2(ME_mem_write_data),
        .regout3(ME_reg_write_import),
        .mem2regout(ME_Ctrl_Mem2Reg),
        .memwrout(ME_Ctrl_MemWr),
        .regwrout(ME_Ctrl_regWr)
    );
    Mem U_Mem(
        .clk(clk),
        .import(ME_alu_out),
        .write_data(ME_mem_write_data),
        .memWr(ME_Ctrl_MemWr),

        .read_out(ME_Mem_out)
    );
    ME_WB U_MEWB(
        .clk(clk),
        .rst(rst),
        .regin1(ME_alu_out),
        .regin2(ME_Mem_out),
        .regin3(ME_reg_write_import),
        .mem2regin(ME_Ctrl_Mem2Reg),
        .regwrin(ME_Ctrl_regWr),

        .regout1(WB_alu_out),
        .regout2(WB_mem_out),
        .regout3(WB_reg_write_import),
        .mem2regout(WB_Ctrl_Mem2Reg),
        .regwrout(WB_Ctrl_regWr)
    );
    MUX #(32) U_Mem2Reg(
        .a(WB_alu_out),
        .b(WB_mem_out),
        .Ctrl({1'b0,WB_Ctrl_Mem2Reg})
    );

    Forward U_Forward(
        .ID_Rs(ID_instr[25:21]),
        .ID_Rt(ID_instr[20:16]),
        .EX_Rs(EX_Rs),
        .EX_Rt(EX_Rt),
        .EX_writeimport(U_RegDst.out),
        .ME_writeimport(ME_reg_write_import),
        .WB_writeimport(WB_reg_write_import),
        .EXRegWr(EX_Ctrl_regWr),
        .MERegWr(ME_Ctrl_regWr),
        .WBRegWr(WB_Ctrl_regWr),
        .ForwardA(ForwardA),
        .ForwardB(ForwardB),
        .ForwardC(ForwardC),
        .ForwardD(ForwardD)
    );
endmodule //