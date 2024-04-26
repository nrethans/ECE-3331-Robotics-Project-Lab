module Kicker(
    input clk, Enable, 
    output reg Kick = 1'b0, Done = 1'b0
);
    parameter IDLE = 1'b0, 
              KICK = 1'b1;
    (* DONT_TOUCH = "true" *)   
    reg STATE = 1'b0;
    reg [27:0] Count = 28'b0; 
    reg EnableEdge = 1'b0, enable = 1'b0;
    wire EN;
    always@(negedge clk) enable = Enable;
    assign EN = enable & ~EnableEdge;
    always @(posedge clk) begin
        EnableEdge=enable;
        case(STATE)
            IDLE: STATE = (EN)?(KICK):(IDLE);
            KICK: begin
                STATE = (Count[27])?(IDLE):(KICK);
                Done = (Count[27])?(1'b1):(1'b0);
            end
        endcase
        case(STATE)
            IDLE: Kick = 1'b0;
            KICK: begin
                Count=Count+1;
                Kick=~Count[27];
            end
        endcase
    end
endmodule