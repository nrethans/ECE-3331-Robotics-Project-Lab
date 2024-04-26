
module Kicker(
    input clk, Enable, 
    output reg Kick = 1'b0, Done = 1'b0
);
    parameter IDLE = 1'b0, 
              KICK = 1'b1;
    (* DONT_TOUCH = "true" *)   
    reg STATE = 1'b0;
    reg [24:0] Count = 25'b0; 
    reg EnableEdge = 1'b0;
    wire EN;
    assign EN = Enable & ~EnableEdge;
    always @(posedge clk) begin
        EnableEdge=Enable;
        case(STATE)
            IDLE: STATE = (EN)?(KICK):(IDLE);
            KICK: begin
                STATE = (Count[24])?(IDLE):(KICK);
                Done = (Count[24])?(1'b1):(1'b0);
            end
        endcase
        case(STATE)
            IDLE: Kick = 1'b0;
            KICK: begin
                Count=Count+1;
                Kick=~Count[24];
            end
        endcase
    end
endmodule