module Kicker(
    input clk, Enable, 
    output reg Kick = 1'b0, Done = 1'b0
);
    parameter IDLE = 1'b0, 
              KICK = 1'b1;
    reg STATE = 1'b0;
    reg [3:0] Count = 25'b0; 
    reg [1:0] EnableEdge = 2'b00;
    always @(posedge clk) begin
        EnableEdge[1]=EnableEdge[0];
        EnableEdge[0]=Enable;
        case(STATE)
            IDLE: STATE = ((~EnableEdge[1]&EnableEdge[0]))?(KICK):(IDLE);
            KICK: STATE = (Count[3])?(IDLE):(KICK);
        endcase
        case(STATE)
            IDLE: Kick = 1'b0;
            KICK: begin
                Count=Count+1;
                Kick=~Count[3];
            end
        endcase
    end
endmodule