`include "TriggerGenerator.v"
`timescale 1ns/1ns
module testbench;
    reg enable=0,reset=0; //initialize inputs as registers
    wire trigger;         //intialize outputs as wires
    TriggerGenerator UUT(clk,enable,reset,trigger); 
    //Wavetable
    reg clk=0;
    always begin
        clk = ~clk; #1;
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        enable = 1; #18500;
        enable = 0; #10000;
        enable = 1; reset= 1; #10000;
        $finish;     
    end
endmodule