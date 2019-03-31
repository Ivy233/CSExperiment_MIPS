module (

);
    //PC & ins
    wire[31:0] pc_next;
    wire[31:0] pc_cur;
    wire[31:0] instr;

    //ctrl
    //
    PC U_PC(
        .pc_cur(pc_cur),
        .pc_next(pc_next),

    )
endmodule //