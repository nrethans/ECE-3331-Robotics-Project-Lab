module dflipflop(clk,D,Q);
    input clk,D;
    output reg Q = 0;
    always @(posedge clk)begin
        Q<=D;
    end
endmodule

module top();
    input [3:0] D;
    output [3:0] Q;
    input clk;
    dflipflop unit1(clk,D[0],Q[0]);
    dflipflop unit2(clk,D[1],Q[1]);
    dflipflop unit3(clk,D[2],Q[2]);
    dflipflop unit4(clk,D[3],Q[3]);
endmodule

