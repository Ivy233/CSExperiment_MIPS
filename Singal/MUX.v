module MUX #(parameter WIDTH=32)(a, b, c, d, Ctrl_MUX, MUX_output);
    input[WIDTH-1:0] a, b, c, d;
    input[1:0] Ctrl_MUX;
    output reg[WIDTH-1:0] MUX_output;

    always@(*)begin
        case (Ctrl_MUX)
            2'b00: MUX_output = a;
            2'b01: MUX_output = b;
            2'b10: MUX_output = c;
            2'b11: MUX_output = d;
        endcase
    end
endmodule // MUX