module Ext(
    input[15:0] input0,
    input op,
    output reg[31:0] out
);
    always@(*)begin
        case (op)
            1'b0: out = { {16{1'b0}} , input0};
            1'b1: out = { {16{input0[15]}} , input0};
        endcase
    end
endmodule // Ext