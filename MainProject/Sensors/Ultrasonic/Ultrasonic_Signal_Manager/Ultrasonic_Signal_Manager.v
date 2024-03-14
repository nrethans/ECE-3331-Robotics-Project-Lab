`timescale 1ns / 1ns
/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Samir Hossain
    Module Name: UltrasonicSignalManager
    Submodule of:
    Dependances:
    Description:

    Inputs: clk, enable, reset, echo

    Outputs: trigger, [3:0] Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data

    Notes: BCD needed if display is being used else, TriggerGenerator and DistanceCalculationModule needed only

*/

module UltrasonicSignalManager(input clk, enable, reset, echo, output trigger, output [3:0] Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data);
    wire [9:0] distance;
    TriggerGenerator Unit1(clk, enable, reset, trigger);
    DistanceCalculationModule Unit2(clk, echo, distance);
    BCD_Double_Dabble Unit4(distance,Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data);
endmodule