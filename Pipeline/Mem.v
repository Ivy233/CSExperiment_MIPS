module Mem(
    input clk,
    input[31:0] import,
    input[31:0] write_data,
    input memWr,
    output reg[31:0] read_out
);
    reg[31:0] data_memory[1023:0];
    always@(*)begin
        read_out = data_memory[import[11:2]][31:0];
    end
    always@(negedge clk)begin
        if(memWr == 1'b1)
            data_memory[import[11:2]][31:0] <= write_data[31:0];
        $display("M[00-07]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", data_memory[0], data_memory[1], data_memory[2], data_memory[3], data_memory[4], data_memory[5], data_memory[6], data_memory[7]);
        $display("M[08-15]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", data_memory[8], data_memory[9], data_memory[10], data_memory[11], data_memory[12], data_memory[13], data_memory[14], data_memory[15]);
        $display("M[16-23]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", data_memory[16], data_memory[17], data_memory[18], data_memory[19], data_memory[20], data_memory[21], data_memory[22], data_memory[23]);
        $display("M[24-31]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", data_memory[24], data_memory[25], data_memory[26], data_memory[27], data_memory[28], data_memory[29], data_memory[30], data_memory[31]);
        $display("Mem_input =%8X, %8X", import, write_data);
        $display("memWr=%8X", memWr);
    end
endmodule // Mem