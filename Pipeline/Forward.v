module Forward(
    input[4:0]  ID_Rs,
    input[4:0]  ID_Rt,
    input[4:0]  EX_Rs,
    input[4:0]  EX_Rt,
    input[4:0]  EX_writeimport,
    input[4:0]  ME_writeimport,
    input[4:0]  WB_writeimport,
    input       EXRegWr,
    input       MERegWr,
    input       WBRegWr,
    output reg[1:0] ForwardA,
    output reg[1:0] ForwardB,
    output reg[1:0] ForwardC,
    output reg[1:0] ForwardD
);
    always @(*) begin
        if (MERegWr && (ME_writeimport != 0) && (ME_writeimport == EX_Rs) )
            ForwardA <= 2'b10;
        else if(WBRegWr && (WB_writeimport != 0) && (WB_writeimport == EX_Rs) )
            ForwardA <= 2'b01;
        else ForwardA <= 2'b00;

        if (MERegWr && (ME_writeimport != 0) && (ME_writeimport == EX_Rt) )
            ForwardB <= 2'b10;
        else if (WBRegWr && (WB_writeimport != 0) && (WB_writeimport == EX_Rt) )
            ForwardB <= 2'b01;
        else ForwardB <= 2'b00;

        if (WBRegWr && (WB_writeimport != 0) && (WB_writeimport == ID_Rs) )
            ForwardC <= 2'b11;
        else if (MERegWr && (ME_writeimport != 0) && (ME_writeimport == ID_Rs ) )
            ForwardC <= 2'b10;
        else if(EXRegWr && (EX_writeimport !=0 ) && (ID_Rs == EX_writeimport) )
            ForwardC <= 2'b01;
        else ForwardC <= 2'b00;

        if (WBRegWr && (WB_writeimport != 0) && (WB_writeimport == ID_Rt) )
            ForwardD <= 2'b11;
        else if (MERegWr && (ME_writeimport != 0) && (ME_writeimport == ID_Rt ) )
            ForwardD <= 2'b10;
        else if(EXRegWr && (EX_writeimport !=0 ) && (EX_writeimport == ID_Rt) )
            ForwardD <= 2'b01;
        else ForwardD <= 2'b00;
    end
endmodule
