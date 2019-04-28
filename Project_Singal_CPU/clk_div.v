//`timescale 1ns / 1ps
module clk_div (
    input clk_dis,
    input rst,
    input[15:0] sw,
    output clk_CPU
);
    reg[31:0] clkdiv;
    always @ (posedge clk_dis or posedge rst)
        begin
            clkdiv <= (rst) ? 0 : clkdiv + 1'b1;
/*            if (rst)
                clkdiv <= 0;
            else
                clkdiv <= clkdiv + 1'b1;*/
        end

    //sw_15:29->5.3687
    //sw_14:28->2.6844
    //sw_13:27->1.3422
    //sw_12:26->0.6711
    //sw_11:25->0.3355
    //sw_10:24->0.1678
    assign clk_CPU=(sw[15]) ? clkdiv[29] :
                   (sw[14]) ? clkdiv[28] :
                   (sw[13]) ? clkdiv[27] :
                   (sw[12]) ? clkdiv[26] :
                   (sw[11]) ? clkdiv[25] :
                   (sw[10]) ? clkdiv[24] : clkdiv[19];

endmodule
