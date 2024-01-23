`include "TestModules/MicSignalHandler/OneSecondTimer/OneSecondTimer.v"
`timescale 1s/1s
module testbench;
    wire OneSecond;
    OneSecondTimer UUT(clk,OneSecond); 
    //Wavetable
    reg clk=0;
    always begin
        clk = ~clk; #1; 
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        #1100;
        $finish;     
    end
endmodule