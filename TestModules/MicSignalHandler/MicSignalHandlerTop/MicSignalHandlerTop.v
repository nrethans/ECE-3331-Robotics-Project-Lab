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
//`include "TestModules/MicSignalHandler/BCD/BCD_Double_Dabble.v"
//`include "TestModules/MicSignalHandler/HzCounter/HzCounter.v"
//`include "TestModules/MicSignalHandler/OneSecondTimer/OneSecondTimer.v"
(* DONT_TOUCH = "yes" *)
module MicSignalHandler(input clk, JA1, output reg led0,led1,led2,led3, output LED);
    wire [9:0] Binary_Hz;
    wire OneSecond;
    wire [9:0] JA1COUNT;
    assign LED = JA1;
    OneSecondTimer Unit1(clk, OneSecond);
    JA1Counter Unit2(JA1,JA1COUNT);
    HzCounter Unit3(OneSecond,JA1COUNT,Binary_Hz);
    always@(clk)begin
        if(Binary_Hz>750) led0 = 1;
        else led0 = 0;
        if(Binary_Hz>500) led1 = 1;
        else led1 = 0;
        if(Binary_Hz>250) led2 = 1;
        else led2 = 0;
        if(Binary_Hz>50) led3 = 1;
        else led3 = 0;
    end
    //BCD_Double_Dabble Unit1(Binary_Hz,Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data);
endmodule