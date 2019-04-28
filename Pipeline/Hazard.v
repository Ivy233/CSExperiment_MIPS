module Hazard (
    input      jump,
    input      branch,
    input      mem2reg,
    input[4:0] IF_Rs,
    input[4:0] IF_Rt,
    input[4:0] ID_Rt,
    output reg hazard
);

    initial begin
        hazard <= 1'b0;
    end
    always @(*) begin
        if (mem2reg	&& (ID_Rt != 0) && (ID_Rt == IF_Rs || ID_Rt == IF_Rt) ) begin
            hazard <= 1;
        end else begin
            hazard <= jump || branch;
        end
    end
endmodule
