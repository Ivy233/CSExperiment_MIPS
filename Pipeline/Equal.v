module Equal (
    input[31:0] input1,
    input[31:0] input2,
    output reg  equal
);
initial begin
    equal <= 0;
end
always @(*) begin
    equal <= (input1 == input2);
end
endmodule
