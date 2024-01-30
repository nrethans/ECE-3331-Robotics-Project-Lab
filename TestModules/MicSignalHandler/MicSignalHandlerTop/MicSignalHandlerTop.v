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
module MicSignalHandler(input clk, JA1, output led0,led1,led2,led3);
    wire [9:0] Binary_Hz;
    wire [9:0] JA1COUNT;
    wire OneSecond,OneKiloHert;
    OneSecondTimer Unit1(clk,OneSecond);
    OneKilohertTimer Unit4(clk,OneKiloHert);
    wire clr;
    JA1Counter Unit2(JA1,clk,clr,OneKiloHert,JA1COUNT);
    HzCounter Unit3(OneSecond,JA1COUNT,Binary_Hz,clr);
    assign led0=Binary_Hz[5];
    assign led1=Binary_Hz[6];
    assign led2=Binary_Hz[7];
    assign led3=Binary_Hz[8];
    
//    always@(posedge(clk))begin
//        casex(Binary_Hz)
//            10'b00001xxxxx:begin //0-128
//                led0<=1;
//                {led1,led2,led3}<=0;
//            end
//            10'b0001xxxxxx: begin //129-256
//                led1=1;
//                {led0,led2,led3}=0;
//            end
//            10'b001xxxxxxx: begin //257-512
//                led2<=1;
//                {led0,led1,led3}<=0;
//            end
//            10'b01xxxxxxxx: begin//513-1024
//                led3<=1;
//                {led0,led1,led2}<=0;
//            end
//            default:{led0,led1,led2,led3}=0;
//        endcase
//    end
    //BCD_Double_Dabble Unit1(Binary_Hz,Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data);
endmodule