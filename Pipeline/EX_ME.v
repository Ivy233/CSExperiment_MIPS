module EX_ME(
    input clk,
    input rst,
    input[31:0] regin1,
    input[31:0] regin2,
    input[4:0] regin3,
    input mem2regin,
    input memwrin,
    input regwrin,

    output reg[31:0] regout1,
    output reg[31:0] regout2,
    output reg[4:0] regout3,
    output reg mem2regout,
    output reg memwrout,
    output reg regwrout
);
    initial begin
        regout1 <= 0;
        regout2 <= 0;
        regout3 <= 0;
        mem2regout <= 0;
        memwrout <= 0;
        regwrout <= 0;
    end
    always @(posedge rst) begin
        regout1 <= 0;
        regout2 <= 0;
        regout3 <= 0;
        mem2regout <= 0;
        memwrout <= 0;
        regwrout <= 0;
    end

    always @(posedge clk) begin
        regout1 <= regin1;
        regout2 <= regin2;
        regout3 <= regin3;
        mem2regout <= mem2regin;
        memwrout <= memwrin;
        regwrout <= regwrin;
    end
endmodule // EX_ME_Reg