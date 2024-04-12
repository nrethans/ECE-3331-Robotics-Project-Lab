
module Kicker(
    input clk, Enable, 
    output reg Kick = 1'b0, Done = 1'b0
);
    parameter IDLE = 1'b0, 
              KICK = 1'b1;
    (* DONT_TOUCH = "true" *)   
    reg STATE = 1'b0;
    reg [3:0] Count = 25'b0; 
    reg EnableEdge = 1'b0;
    wire EN;
    assign EN = Enable & ~EnableEdge;
    always @(posedge clk) begin
        EnableEdge=Enable;
        case(STATE)
            IDLE: STATE = (EN)?(KICK):(IDLE);
            KICK: begin
                STATE = (Count[3])?(IDLE):(KICK);
                Done = (Count[3])?(1'b1):(1'b0);
            end
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