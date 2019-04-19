module Instr_Mem(
    input[9:0] pc_cur,
    output reg[31:0] instr
);
    reg[31:0] Instrs[1023:0];
    always@(pc_cur)begin
        instr = Instrs[pc_cur];
        $display("pc_cur=0x%8X, instr=0x%8X", pc_cur, instr);
    end
endmodule // Instr_Mem