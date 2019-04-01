module Mem(input_pos, input_data, Ctrl_MemWr, clk, Mem_output);
    input[31:0] input_data;
    input[11:0] input_pos;
    input Ctrl_MemWr;
    output reg[31:0] Mem_output;

    reg[31:0] data_memory[1023:0];
    always@(*)begin
        Mem_output= data_memory[input_pos[11:2]][31:0];
    end
    always@(posedge clk)begin
        data_memory[input_pos[11:2]][31:0]=input_data[31:0];
    end
endmodule // Mem