module Instr_Mem(pc_cur, instr);
    input[5:0] pc_cur;
    output [31:0] instr;

    reg[31:0] Instrs[1023:0];
    reg[31:0] tmp_instr;

    always@(pc_cur)begin
        tmp_instr = Instrs[pc_cur];
        $display("pc_cur=0x%8X, instr=0x%8X", pc_cur, tmp_instr);
    end

    assign instr = tmp_instr;

endmodule // Instr_Mem