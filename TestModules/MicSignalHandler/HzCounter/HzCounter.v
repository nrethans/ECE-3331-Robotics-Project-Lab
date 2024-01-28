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
//`timescale 1s/1s
//`include "TestModules/MicSignalHandler/OneSecondTimer/OneSecondTimer.v"
(* DONT_TOUCH = "yes" *)

module HzCounter(input OneSecond, input [9:0] JA1COUNTER, output reg [9:0] Hz=0);
    always@(OneSecond)begin
        Hz=JA1COUNTER;
    end
endmodule