module Instr_Mem(
    input[9:0] a,
    output[31:0] spo
);
    reg[31:0] Instrs[4095:0];
    reg[31:0] tmp_instr;
    always@(a)begin
        tmp_instr = Instrs[a];
        $display("pc_cur=0x%8X, instr=0x%8X", a, tmp_instr);
    end
    assign spo = tmp_instr;
endmodule // Instr_Mem