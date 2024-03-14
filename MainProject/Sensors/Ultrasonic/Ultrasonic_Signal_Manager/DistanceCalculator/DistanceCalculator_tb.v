`include "DistanceCalculator.v"
`timescale 1ns/1ns
module testbench;
    reg echo=0; //initialize inputs as registers
    wire distance; //intialize outputs as wires
    DistanceCalculationModule UUT(clk,echo,distance); 
    //Wavetable
    reg clk=0;
    always begin
        clk = ~clk; #1;
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        echo = 1; #200000
        echo = 0; #50000
        echo = 1; #150000
        echo = 0; #50000
        echo = 1; #180000
        echo = 0; #50000
        $finish;     
    end
endmodule