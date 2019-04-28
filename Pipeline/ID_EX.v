module ID_EX_Reg(
    input clk,
    input rst,
    input[31:0] regin1,
    input[31:0] regin2,
    input[31:0] regin3,
    input[4:0] regin4,
    input[4:0] regin5,
    input[4:0] regin6,
    input[4:0] regin7,
    input regdstin,
    input[3:0] aluopin,
    input[1:0] alusrcain,
    input[1:0] alusrcbin,
    input mem2regin,
    input regwrin,
    input memwrin,

    output[31:0] regout1,
    output[31:0] regout2,
    output[31:0] regout3,
    output[4:0] regout4,
    output[4:0] regout5,
    output[4:0] regout6,
    output[4:0] regout7,
    output regdstout,
    output[3:0] aluopout,
    output[1:0] alusrcaout,
    output[1:0] alusrcbout,
    output mem2regout,
    output regwrout,
    output memwrout,
);
    reg[127:0] TMP_reg;

    initial begin
        TMP_reg <= 0;
    end
    always @(posedge rst) begin
        TMP_reg <= 0;
    end

    assign regout1 = TMP_reg[127:96];
    assign regout2 = TMP_reg[95:64];
    assign regout3 = TMP_reg[63:32];
    assign regout4 = TMP_reg[31:27];
    assign regout5 = TMP_reg[26:22];
    assign regout6 = TMP_reg[21:17];
    assign regout7 = TMP_reg[16:12];
    assign regdstout = TMP_reg[11];
    assign aluopout = TMP_reg[10:7];
    assign alusrcaout = TMP_reg[6:5];
    assign alusrcbout = TMP_reg[4:3];
    assign mem2regout = TMP_reg[2];
    assign regwrout = TMP_reg[1];
    assign memwrout = TMP_reg[0];

    always @(posedge clk) begin
        TMP_reg <= {
            regin1, regin2, regin3, regin4, regin5, regin6, regin7,
            regdstin, aluopin, alusrcain, alusrcbin, mem2regin, regwrin, memwrin
        };
    end
endmodule // ID_EX_Reg