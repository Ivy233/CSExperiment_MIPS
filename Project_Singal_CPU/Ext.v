module Ext(
    input[15:0] imm_16,
    input Ctrl_ext,
    output reg[31:0] output_imm_32
);
    always@(*)begin
        case (Ctrl_ext)
            1'b0: output_imm_32 = { {16{1'b0}} , imm_16};
            1'b1: output_imm_32 = { {16{imm_16[15]}} , imm_16};
        endcase
    end
endmodule // Ext