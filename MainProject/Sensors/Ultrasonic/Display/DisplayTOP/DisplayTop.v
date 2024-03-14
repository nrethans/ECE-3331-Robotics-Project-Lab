/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Nicholas Rethans
    Module Name: DisplayTop
    Submodule of: none
    Dependances: CathodeDecoder, DigitDecoder, MUX, SyncCounter
    Description: Top module for 4x8 display

    Inputs: 
    clk 
    data1, data2, data3, data4, 4-bits

    Outputs:
    cathode, 4-bits
    segmentout, 8-bits

    Notes: DisplayTop for Vivado
*/
//`include "TestModules/Display/CathodeDecoder.v"
//`include "TestModules/Display/DigitDecoder.v"
//`include "TestModules/Display/DisplayMUX.v"
//`include "TestModules/Display/SyncCounter.v" 
//`include "Testmodules/Display/SlowClk/SlowClk.v"
(* DONT_TOUCH = "yes" *)
module Display(
    input clk, 
    input [3:0] Thousands_Data, Hundreds_Data, Tens_Data, Ones_Data,
    output [3:0] cathode, output [7:0] segmentout
);
    reg [3:0] data1=1,data2=2,data3=3,data4=4;
    wire [7:0] decoder1,decoder2,decoder3,decoder4;
    wire [1:0] sync;
    wire slowedclk;
    SlowClk U0(clk,slowedclk);
    Digit_Decoder U1(Thousands_Data,decoder1);
    Digit_Decoder U2(Hundreds_Data,decoder2);
    Digit_Decoder U3(Tens_Data,decoder3);
    Digit_Decoder U4(Ones_Data,decoder4);
    SyncCounter U5(slowedclk,sync);
    DisplayMUX U6(decoder1,decoder2,decoder3,decoder4,sync,segmentout);
    CathodeDecoder U7(sync,cathode);
endmodule
/*
module testbench;
    reg [3:0] data1=0,data2=1,data3=2,data4=3;
    wire [3:0] cathode;
    wire [7:0] segmentout;
    DisplayTop UUT(clk,data1,data2,data3,data4,cathode,segmentout); 
    //Wavetable
    reg clk=0;
    parameter PRD = 4;
    always#(PRD/2) begin
        clk = ~clk; 
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        #(PRD*4);
        data1 = 4'h4;
        data2 = 4'h5;
        data3 = 4'h6;
        data4 = 4'h7;
        #(PRD*4);
        data1 = 4'h8;
        data2 = 4'h9;
        #(PRD*2);
        $finish;     
    end
endmodule*/