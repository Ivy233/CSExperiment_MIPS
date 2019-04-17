module RegFile(
    input clk,
    input[4:0] Read_import1,
    input[4:0] Read_import2,
    input[4:0] Write_import,
    input[31:0] Write_data,
    input Ctrl_regWr,
    output[31:0] Rout1,
    output[31:0] Rout2
);
    reg[31:0] register[0:31];

    initial begin
        register[0] <= 0;
    end

    assign Rout1 = (Read_import1 != 0) ? register[Read_import1] : 0;
    assign Rout2 = (Read_import2 != 0) ? register[Read_import2] : 0;

    always @(posedge clk ) begin
        if(Ctrl_regWr == 1'b1 && Write_import != 0)begin
            register[Write_import] = Write_data;
        end
        $display("R[00-07]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", register[0], register[1], register[2], register[3], register[4], register[5], register[6], register[7]);
        $display("R[08-15]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", register[8], register[9], register[10], register[11], register[12], register[13], register[14], register[15]);
        $display("R[16-23]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", register[16], register[17], register[18], register[19], register[20], register[21], register[22], register[23]);
        $display("R[24-31]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", register[24], register[25], register[26], register[27], register[28], register[29], register[30], register[31]);
        $display("Write_import=%8X Read_import=%8X, %8X", Write_import, Read_import1, Read_import2);
        $display("Ctrl_regWr  =%8X", Ctrl_regWr);
    end
endmodule // RegFile