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

    Notes:

*/
`timescale 1s/1s
`include "TestModules/MicSignalHandler/OneSecondTimer/OneSecondTimer.v"

module HzCounter(input clk,JA1,output reg [9:0] Hz=0);
    wire OneSecond;
    reg [9:0] count = 0;
    OneSecondTimer U0(clk,OneSecond);
    always@(posedge(JA1)) count<=count+1;

    always@(OneSecond)begin
        Hz=count;
        count=0;
    end
    //assign Hz = (Onesecond)?(count):();
endmodule