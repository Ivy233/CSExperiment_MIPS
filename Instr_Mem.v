module Instr_Mem(pc_cur, instr);
    input[5:0] pc_cur;
    output [31:0] instr;

    reg[31:0] Instrs[1023:0];

    assign instr = Instrs[pc_cur];
    always@(pc_cur)begin
        $display("pc_cur=0x%8X, instr=0x%8X", pc_cur, instr);
    end

endmodule // Instr_Mem