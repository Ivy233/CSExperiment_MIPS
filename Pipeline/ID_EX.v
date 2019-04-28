module ID_EX(
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

    output reg[31:0] regout1,
    output reg[31:0] regout2,
    output reg[31:0] regout3,
    output reg[4:0] regout4,
    output reg[4:0] regout5,
    output reg[4:0] regout6,
    output reg[4:0] regout7,
    output reg regdstout,
    output reg[3:0] aluopout,
    output reg[1:0] alusrcaout,
    output reg[1:0] alusrcbout,
    output reg mem2regout,
    output reg regwrout,
    output reg memwrout
);
    initial begin
        regout1 <= 0;
        regout2 <= 0;
        regout3 <= 0;
        regout4 <= 0;
        regout5 <= 0;
        regout6 <= 0;
        regout7 <= 0;
        regdstout <= 0;
        aluopout <= 0;
        alusrcaout <= 0;
        alusrcbout <= 0;
        mem2regout <= 0;
        regwrout <= 0;
        memwrout <= 0;
    end
    always @(posedge rst) begin
        regout1 <= 0;
        regout2 <= 0;
        regout3 <= 0;
        regout4 <= 0;
        regout5 <= 0;
        regout6 <= 0;
        regout7 <= 0;
        regdstout <= 0;
        aluopout <= 0;
        alusrcaout <= 0;
        alusrcbout <= 0;
        mem2regout <= 0;
        regwrout <= 0;
        memwrout <= 0;
    end

    always @(posedge clk) begin
        regout1 <= regin1;
        regout2 <= regin2;
        regout3 <= regin3;
        regout4 <= regin4;
        regout5 <= regin5;
        regout6 <= regin6;
        regout7 <= regin7;
        regdstout <= regdstin;
        aluopout <= aluopin;
        alusrcaout <= alusrcain;
        alusrcbout <= alusrcbin;
        mem2regout <= mem2regin;
        regwrout <= regwrin;
        memwrout <= memwrin;
    end
endmodule // ID_EX_Reg