/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name:Nicholas Rethans
    Module Name: OneSecondTimer
    Submodule of: HzCalculator
    Dependances: none
    Description: One Second Timer

    Inputs: CLK

    Outputs: OneSecond

    Notes:condition ? value_if_true : value_if_false

*/

module OneSecondTimer(input clk,output reg OneSecond=1);
    reg [27:0] count=0;
    always@(posedge(clk)) begin
        if(count==50)begin
            count=0;
            OneSecond=~OneSecond;
            count = count + 1;
        end 
        else begin
            count <= count + 1;
        end
    end
endmodule
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