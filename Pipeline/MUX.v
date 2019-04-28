module MUX #(parameter WIDTH = 32)(
    input[WIDTH - 1:0] a,
    input[WIDTH - 1:0] b,
    input[WIDTH - 1:0] c,
    input[WIDTH - 1:0] d,
    input[1:0] Ctrl,
    output reg[WIDTH - 1:0] out
);
    always@(*)begin
        case (Ctrl)
            2'b00: out = a;
            2'b01: out = b;
            2'b10: out = c;
            2'b11: out = d;
        endcase
    end
endmodule // MUX