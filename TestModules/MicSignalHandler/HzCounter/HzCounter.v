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
`include "TestModules/MicSignalHandler/OneSecondTimer/OneSecondTimer.v"
(* DONT_TOUCH = "yes" *)

module HzCounter(input JA1, OneSecond, clk, output reg [9:0] Hz=0);
    reg [1:0] EdgeTest=0;
    reg PrevSecond=0;
    reg [9:0] temp=0;
    always @(posedge (clk))begin
        EdgeTest[0]<=JA1;
        if(OneSecond!=PrevSecond)begin
            Hz=temp*4; //multiply by 4 on board
            temp <= 0;
            PrevSecond <= OneSecond;
        end
        else if(!EdgeTest[0]&&EdgeTest[1]) begin
            temp <= temp+1;
        end
        EdgeTest[1]<=EdgeTest[0];
    end
endmodule
