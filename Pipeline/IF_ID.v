module IF_ID(
    input clk,
    input rst,
    input hazard,
    input[31:0] regin1,
    input[31:0] regin2,
    output[31:0] regout1,
    output[31:0] regout2
);
    reg[63:0] TMP_reg;

    initial begin
        TMP_reg <= 64'b0;
    end
    always @(posedge rst) begin
        TMP_reg <= 64'b0;
    end
    assign reg_out1 = TMP_reg[63:32];
    assign reg_out2 = TMP_reg[31:0];
    always @(posedge clk) begin
        if(hazard)begin
            TMP_reg <= 64'b0;
        end else begin
            TMP_reg <= {reg_in1, reg_in2};
        end
    end
endmodule // IF_ID_Reg