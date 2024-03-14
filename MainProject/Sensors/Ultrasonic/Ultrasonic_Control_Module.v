/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Samir Hossain
    Module Name: UltrasonicControlModule
    Submodule of:
    Dependances:
    Description:

    Inputs: clk, enable, reset, echo

    Outputs: trigger, [3:0] cathode, [7:0] anode

    Notes: If using with display use this, Ultrasonic code in Ultrasonic Signal Manager

*/

module UltrasonicControlModule(input clk, enable, reset, echo, output trigger, output [3:0] cathode, output [7:0] anode);
    wire [3:0] Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data;
    UltrasonicSignalHandler Unit1(clk, enable, reset, echo, trigger, Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data);
    DisplayTop Unit2(clk,Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data,cathode,anode);
endmodule
