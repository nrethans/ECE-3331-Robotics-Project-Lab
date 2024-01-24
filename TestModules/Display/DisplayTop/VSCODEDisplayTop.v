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

    Notes: VSCODE display top
*/
`include "TestModules/Display/CathodeDecoder/CathodeDecoder.v"
`include "TestModules/Display/DigitDecoder/DigitDecoder.v"
`include "TestModules/Display/DisplayMUX/DisplayMUX.v"
`include "TestModules/Display/SyncCounter/SyncCounter.v" 
//`include "Testmodules/Display/SlowClk/SlowClk.v"

module DisplayTop(
    input clk,
    input [3:0] Thousands_Data, Hundreds_Data, Tens_Data, Ones_Data,
    output [3:0] cathode, output [7:0] segmentout
);
    wire [7:0] decoder1,decoder2,decoder3,decoder4;
    wire [1:0] sync;
    //wire slowedclk;
    //Slowclk U0(clk,slowedclk);
    Digit_Decoder U1(Thousands_Data,decoder1);
    Digit_Decoder U2(Hundreds_Data,decoder2);
    Digit_Decoder U3(Tens_Data,decoder3);
    Digit_Decoder U4(Ones_Data,decoder4);
    SyncCounter U5(clk,sync); //slowedclk used on Basys3 board
    DisplayMUX U6(decoder1,decoder2,decoder3,decoder4,sync,segmentout);
    CathodeDecoder U7(sync,cathode);
endmodule

module testbench;
    reg [3:0] Thousands_Data=0, Hundreds_Data=1, Tens_Data=2, Ones_Data=3;
    wire [3:0] cathode;
    wire [7:0] segmentout;
    DisplayTop UUT(clk, Thousands_Data, Hundreds_Data, Tens_Data, Ones_Data, cathode, segmentout); 
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
        Thousands_Data = 4'h4;
        Hundreds_Data = 4'h5;
        Tens_Data = 4'h6;
        Ones_Data = 4'h7;
        #(PRD*4);
        Thousands_Data = 4'h8;
        Hundreds_Data = 4'h9;
        #(PRD*2);
        $finish;     
    end
endmodule