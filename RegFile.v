module RegFile(clk, Read_import1, Read_import2, Write_import, Write_data, Ctrl_regWr, Rout1, Rout2);
    input[4:0] Read_import1, Read_import2, Write_import;
    input[31:0] Write_data;
    input Ctrl_regWr, clk;
    output[31:0] Rout1, Rout2;

    reg[31:0] register[0:31];

    initial begin
        register[0] <= 0;
    end

    assign Rout1 = (Read_import1 != 0) ? register[Read_import1] : 0;
    assign Rout2 = (Read_import2 != 0) ? register[Read_import2] : 0;

    always @(posedge clk ) begin
        if(Ctrl_regWr==1'b1 && Write_import!=0)begin
            register[Write_import] = Write_data;
        end
    end
endmodule // RegFile