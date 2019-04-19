module ALU(
    input[31:0] in1,
    input[31:0] in2,
    input[3:0] Ctrl_alu,
    output reg[31:0] ALU_out,
    output reg zero
);
    always@(Ctrl_alu or in1 or in2) begin
        case (Ctrl_alu)
            4'b0000: ALU_out = in1 + in2;
            4'b0001: ALU_out = in1 - in2;
            4'b0010: ALU_out = in2 << in1[3:0];
            4'b0011: ALU_out = in2 >> in1[3:0];
            4'b0100: ALU_out = ($signed(in1) < $signed(in2)) ? 1 : 0;
            4'b0101: ALU_out = in1 & in2;
            4'b0110: ALU_out = in1 | in2;
            4'b0111: ALU_out = in1 ^ in2;
            4'b1000: ALU_out = (in1 < in2) ? 1 : 0;
            4'b1001: ALU_out = $signed(in2) >>> in1[3:0];
        endcase
        zero = (ALU_out == 0);
    end
endmodule // ALU