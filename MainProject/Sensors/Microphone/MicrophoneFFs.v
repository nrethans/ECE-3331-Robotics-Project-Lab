/*
    ECE 3331-303 Group 3
    Spring 2024

    Name: Nicholas Rethans
    Module Name: MicrophoneFFs
    Submodule of: 
    Dependances: Ball SM
    Description: Determine is ball is closer to left or right mic using the phase of both signals.

    Inputs: CLK, RightMic, LeftMic

    Outputs: Direction

    Notes:  Direction is high when right mic is closer
            Direction is low when left mic is closer

*/

module FF(CLK,D,Q);
    input CLK,D;
    output reg Q=0;
    always @(posedge CLK) begin
        Q=D;
    end
endmodule

module MicFFs(input CLK,RightMic,LeftMic, output Direction);
    reg RMic = 1'b0, LMic=1'b0, RRMic=1'b0, LLMic=1'b0;
    wire W1,L,R;
    always@(posedge CLK) begin
        RRMic=RightMic;
        LLMic=LeftMic;
    end
    always@(negedge CLK) begin
        RMic=RightMic;
        LMic=LeftMic;
    end
    assign L = LLMic|LMic;
    assign R = RRMic|RMic;
    FF U0(L,R,W1);
    FF U1(CLK,W1,Direction);
endmodule