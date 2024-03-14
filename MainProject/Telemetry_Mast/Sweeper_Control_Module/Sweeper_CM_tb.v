`include "Sweeper_Control_Module.v"
`timescale 1ns/1ns

module testbench;
    reg enable=1, reset=0; //initialize inputs as registers
    wire mast_ready;
    wire [3:0] angle; //intialize outputs as wires

    Sweeper_Control_Module UUT(
        .clk(clk),
        .enable(enable),
        .reset(reset),
        .mast_ready(mast_ready),
        .angle(angle)
    ); 

    // Clock generation
    reg clk=0;
    always begin
        clk = ~clk; #1;
    end

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        #10266;
        enable = 0;
        #1000;
        $finish;     
    end
endmodule
