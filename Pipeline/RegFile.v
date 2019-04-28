module RegFile(
    input clk,
    input[4:0] readimport1,
    input[4:0] readimport2,
    input[4:0] writeimport,
    input[31:0] Writedata,
    input regWr,
    output[31:0] regfile_out1,
    output[31:0] regfile_out2
);
    reg[31:0] register[0:31];

    initial begin
        register[0] <= 0;
    end

    assign regfile_out1 = (readimport1 != 0) ? register[readimport1] : 0;
    assign regfile_out2 = (readimport2 != 0) ? register[readimport2] : 0;

    always @(posedge clk ) begin
        if(regWr == 1'b1 && writeimport != 0)begin
            register[writeimport] = Writedata;
        end
        $display("R[00-07]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", register[0], register[1], register[2], register[3], register[4], register[5], register[6], register[7]);
        $display("R[08-15]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", register[8], register[9], register[10], register[11], register[12], register[13], register[14], register[15]);
        $display("R[16-23]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", register[16], register[17], register[18], register[19], register[20], register[21], register[22], register[23]);
        $display("R[24-31]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", register[24], register[25], register[26], register[27], register[28], register[29], register[30], register[31]);
        $display("writeimport=%8X Read_import=%8X, %8X", writeimport, readimport1, readimport2);
        $display("regWr  =%8X", regWr);
    end
endmodule // RegFile