module Ext(imm_16, Ctrl_ext, output_imm_32);
    input Ctrl_ext;
    input[15:0] imm_16;
    output reg[31:0] output_imm_32;

    always@(*)begin
        case (Ctrl_ext)
            2'b00: output_imm_32 = { {16{1'b0}} , imm_16};
            2'b01: output_imm_32 = { {16{imm_16[15]}} , imm_16};
            default: output_imm_32 = imm_16;
        endcase
    end
endmodule // Ext