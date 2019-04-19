module MUX #(parameter WIDTH = 32)(
    input[WIDTH - 1:0] a,
    input[WIDTH - 1:0] b,
    input[WIDTH - 1:0] c,
    input[WIDTH - 1:0] d,
    input[1:0] Ctrl_MUX,
    output reg[WIDTH - 1:0] MUX_out
);
    always@(*)begin
        case (Ctrl_MUX)
            2'b00: MUX_out = a;
            2'b01: MUX_out = b;
            2'b10: MUX_out = c;
            2'b11: MUX_out = d;
        endcase
    end
endmodule // MUX