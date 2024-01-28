/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Nicholas Rethans
    Module Name: MiniProjectTop.v
    Submodule of: none
    Dependances: DisplayTop.v, MicSignalHandlerTop.v
    Description: Top module combination

    Inputs: clk (100Mhz internal clk)
            JA1 (Basys3 mic circuit signal)

    Outputs:
            Display cathodes
            Display anodes
    Notes:

*/

//`include "TestModules/Display/DisplayTop/VSCODEDisplayTop.v"
//`include "TestModules/MicSignalHandler/MicSignalHandlerTop/MicSignalHandlerTop.v"
(* DONT_TOUCH = "yes" *)
module top(input clk, JA1, output led, output [3:0] cathode, output [7:0] anode);
    wire [3:0] Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data;
    assign led = JA1;
    MicSignalHandler Unit1(clk,JA1,Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data);
    Display Unit2(clk,Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data,cathode,anode);
endmodule
