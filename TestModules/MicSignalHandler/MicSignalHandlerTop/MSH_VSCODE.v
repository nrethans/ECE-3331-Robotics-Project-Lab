/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Nicholas Rethans
    Module Name: MicSignalHandlerTop
    Submodule of: none
    Dependances: OneSecondTimer, HzCounter, BCD_Converter
    Description: Top Module for Mic Signal Handling

    Inputs: JA1 (Basys3 Pmod port, signal from mic circuit)
            CLK (100Mhz Internal Clock)

    Outputs:Thousands Data
            Hundreds Data
            Tens Data
            Ones Data
    Notes:

*/
`include "TestModules/MicSignalHandler/BCD/BCD_Double_Dabble.v"
`include "TestModules/MicSignalHandler/HzCounter/HzCounter.v"
`include "TestModules/MicSignalHandler/OneSecondTimer/OneSecondTimer.v"
(* DONT_TOUCH = "yes" *)
module MicSignalHandler(input clk, JA1, output [3:0] Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data);
    wire [9:0] Binary_Hz;
    wire [9:0] JA1COUNT;
    wire OneSecond,OneKiloHert,clr;
    OneSecondTimer Unit1(clk,OneSecond);
    OneKilohertTimer Unit4(clk,OneKiloHert);
    JA1Counter Unit2(JA1,clk,clr,OneKiloHert,JA1COUNT);
    HzCounter Unit3(OneSecond,JA1COUNT,Binary_Hz,clr);
    BCD_Double_Dabble Unit1(Binary_Hz,Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data);
endmodule