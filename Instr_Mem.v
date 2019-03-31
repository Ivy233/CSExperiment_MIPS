module Instr_Mem(mem_addr, instr);
    input[31:0] mem_addr;
    output[31:0] instr;

    reg[31:0] Instrs[1023:0];
    initial begin
        $readmemh("",Instrs);
    end

    assign instr = Instrs[mem_addr[11:2]];

endmodule // Instr_Mem