/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Nicholas Rethans
    Module Name: Input Counter
    Submodule of:
    Dependances: OneSecondTimer
    Description:

    Inputs: clk (100Mhz internal clk)
            JA1 (Basys3 Pmod IO port with mic circuit signal)

    Outputs: Hz (Hz in binary, cycles per second)

    Notes: https://texastechuniversity-my.sharepoint.com/:p:/g/personal/bfadal_ttu_edu/EdnHrEfu4r5CoGp9oyv_3UkB2lzy6nvRImTPYrmlU1Um1Q?e=4%3AtIbAlQ&fromShare=true&at=9

*/
//`timescale 1s/1s
`include "TestModules/MicSignalHandler/OneSecondTimer/OneSecondTimer.v"
(* DONT_TOUCH = "yes" *)

module HzCounter(input JA1, OneSecond, clk, output reg [9:0] Hz=0);
    reg LiveSignal = 0,PrevSecond=0;
    always @(posedge(clk)) LiveSignal<=JA1;
    reg [9:0] temp=0;
    always @(posedge (clk))begin
        if(OneSecond!=PrevSecond)begin
            Hz=temp;
            temp <= 0;
            PrevSecond <= OneSecond;
        end
        else if(~LiveSignal&JA1) temp <= temp+1;
    end
endmodule

/*
    Combine the HzCounter and JA1Counter modules. The kHz if statement in the JA1Counter should just be the OneSecond Signal instead of kilohertz
    since the else if statement handles the high sampling rate problem. 

    Then lower the OneSecond timer and run the Signal Handler TB and Miniproject Top module

    Then run in vivado. 
*/