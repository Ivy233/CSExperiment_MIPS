`include "seg7x16.v"
`include "clk_div.v"
`include "MIPS.v"
module TESTBENCH(
    input clk,
    input rst,
    input[15:0] sw_i,
    output[15:0] led_o,
    output[7:0] o_seg,
    output[7:0] o_sel
);
    wire clk_display = clk;
    wire clk_CPU;
    wire rst_CPU = ~rst;
    reg[31:0] clk_cnt;
    wire[31:0] display_data;

    initial begin
        clk_cnt = 0;
    end

    always @(posedge rst_CPU) begin
        clk_cnt=0;
    end
    always @(posedge clk_CPU) begin
        clk_cnt = clk_cnt + 1;
        if(clk_cnt >= 2048)begin
            $finish;
        end
    end

    MIPS U_MIPS(
        .clk(clk_CPU),
        .rst(rst_CPU),
        .Ctrl_out(led_o),
        .display_data(display_data)
    );

    clk_div U_clk_div(
        .clk(clk_display),
        .rst(rst_CPU),
        .sw_15(sw_i[15]),
        .clk_CPU(clk_CPU)
    );

    seg7x16 U_seg7x16(
        .clk(clk_display),
        .rst(rst_CPU),
        .i_data(display_data),
        .o_seg(o_seg),
        .o_sel(o_sel)
    );
endmodule // TESTBENCH