module Instr_Mem(mem_addr, instr);
    input[31:0] mem_addr;
    output[31:0] instr;

    reg[31:0] Instrs[1023:0];
    initial begin
        $readmemh("Input_MIPS.txt", Instrs);
    end

    assign instr = Instrs[mem_addr[11:2]][31:0];

endmodule // Instr_Mem