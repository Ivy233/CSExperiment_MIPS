module ALU(
    input[31:0] input1,
    input[31:0] input2,
    input[3:0] aluop,
    output reg[31:0] out
);
    always@(aluop or input1 or input2) begin
        case (aluop)
            4'b0000: out = input1 + input2;
            4'b0001: out = input1 - input2;
            4'b0010: out = input2 << input1[4:0];
            4'b0011: out = input2 >> input1[4:0];
            4'b0100: out = ($signed(input1) < $signed(input2)) ? 1 : 0;
            4'b0101: out = input1 & input2;
            4'b0110: out = input1 | input2;
            4'b0111: out = input1 ^ input2;
            4'b1000: out = (input1 < input2) ? 1 : 0;
            4'b1001: out = $signed(input2) >>> input1[4:0];
        endcase
    end
endmodule // ALU