/*
    ECE 3331-303 Group 3
    Spring 2024

    Name: Nicholas Rethans
    Module Name: MicrophoneFFs
    Submodule of: 
    Dependances: 
    Description:

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
    reg RMic = 0, LMic=0, RRMic=0, LLMic=0;
    wire W1,L,R;
    always@(posedge CLK) begin
        RMic=RightMic;
        LMic=LeftMic;
    end
    always@(negedge CLK) begin
        RMic=RightMic;
        LMic=LeftMic;
    end
    assign L = LLMic|LMic;
    assign R = RRMic|RMic;
    FF U0(LMic,RMic,W1);
    FF U1(CLK,W1,Direction);

endmodule