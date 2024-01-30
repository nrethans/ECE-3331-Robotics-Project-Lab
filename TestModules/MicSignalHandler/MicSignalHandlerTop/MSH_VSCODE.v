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
module OneSecondTimer(input clk,output reg OneSecond=0);
    reg [25:0] count = 0;         //2^26 = 67,108,864 ~= 50,000,000
    always@(posedge(clk)) begin
        if(count==500)begin     //!Board count == 50_000_000! Divide again because Hz Counter is only Posedge = 25_000 
            count=0;            //Use half of period (100E6) since using posedge
            OneSecond=~OneSecond;
            count = count + 1;
        end 
        else begin
            count = count + 1;
        end
    end
endmodule
`include "TestModules/MicSignalHandler/BCD/BCD_Double_Dabble.v"
`include "TestModules/MicSignalHandler/HzCounter/HzCounter.v"
//`include "TestModules/MicSignalHandler/OneSecondTimer/OneSecondTimer.v"
//(* DONT_TOUCH = "yes" *)
module MicSignalHandler(input clk, JA1, output [3:0] Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data);
    wire [9:0] Binary_Hz;
    wire OneSecond,OneKiloHert,clr;
    OneSecondTimer Unit1(clk,OneSecond);
    HzCounter Unit2(JA1,OneSecond,clk,Binary_Hz);
    BCD_Double_Dabble Unit3(Binary_Hz,Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data);
endmodule

