module ALU(
    input[31:0] input1,
    input[31:0] input2,
    input[3:0] Ctrl_alu,
    output reg[31:0] ALU_output
);

    always@(Ctrl_alu or input1 or input2) begin
        case (Ctrl_alu)
            5'b00000: ALU_output <= input1 + input2;
            5'b00001: ALU_output <= input1 - input2;
            5'b00010: ALU_output <= input2 << input1[4:0];
            5'b00011: ALU_output <= input2 >> input1[4:0];
            5'b00100: ALU_output <= ($signed(input1) < $signed(input2)) ? 1 : 0;
            5'b00101: ALU_output <= input1 & input2;
            5'b00110: ALU_output <= input1 | input2;
            5'b00111: ALU_output <= input1 ^ input2;
            5'b01000: ALU_output <= (input1 < input2) ? 1 : 0;
            5'b01001: ALU_output <= $signed(input2) >>> input1[4:0];
        endcase
    end
endmodule // ALU