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

`include "TestModules/Display/DisplayTop/VSCODEDisplayTop.v"
`include "TestModules/MicSignalHandler/MicSignalHandlerTop/MSH_VSCODE.v"
(* DONT_TOUCH = "yes" *)
module MiniProjectTop(input clk, JA1, output [3:0] cathode, output [7:0] anode);
    wire [3:0] Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data;
    MicSignalHandler Unit1(clk,JA1,Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data);
    DisplayTop Unit2(clk,Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data,cathode,anode);
endmodule

module testbench;
    reg JA1=0;
    wire [3:0] cathodes;
    wire [7:0] anodes;
    reg clk = 0;
    always begin
        clk=~clk; #1;
    end
    MiniProjectTop UUT(clk, JA1, cathodes, anodes);
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        //#1000 window for each "second"
        #10;
        for(integer i = 0; i<246; i=i+1) begin 
            JA1 = ~JA1; #4;                 
        end      
        #16;
        $finish;  
    end
endmodule