/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Nicholas Rethans
    Module Name: JA1Counter
    Submodule of: HzCounter
    Dependances: OneKhzTimer,HzCounter
    Description: IO signal counter

    Inputs: JA1, clk, clr, KHZ

    Outputs: JA1COUNT

    Notes: https://stackoverflow.com/questions/38034890/how-can-i-calculate-the-frequency-of-an-input-signal-using-verilog

*/

module JA1Counter(input JA1,clk,clr,KHZ,output reg [9:0] JA1COUNT = 10'b0000000000);
    reg CLR=1'b0;
    always@(posedge(clk)) begin
        if(clr!=CLR)begin
            JA1COUNT=0;
            CLR=clr;
        end
    end
    reg LiveSignal = 0,PrevKHZ=0;
    always @(posedge(clk)) LiveSignal=JA1;
    reg [9:0] temp=0;
    always @(posedge (clk))begin
        if(KHZ!=PrevKHZ)begin
            JA1COUNT=temp;
            temp <= 0;
            PrevKHZ <= KHZ;
        end
        else if(~LiveSignal&JA1) temp = temp+1;
    end
endmodule