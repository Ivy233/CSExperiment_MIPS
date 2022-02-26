module Instr_Mem(
    input[9:0] pc,
    output reg[31:0] instr
);
    reg[31:0] Instrs[1023:0];
    always@(pc)begin
        instr = Instrs[pc];
        $display("pc=0x%8X, instr=0x%8X", pc, instr);
    end
endmodule // Instr_Mem