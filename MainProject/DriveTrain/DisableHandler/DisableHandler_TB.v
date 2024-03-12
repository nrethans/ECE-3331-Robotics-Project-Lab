`include "/Users/nicholasrethans/Documents/GitHub/ECE-3331-Robotics-Project-Lab/MainProject/DriveTrain/DisableHandler/DisableHandler.v"
`timescale 1ns/1ns
module testbench;
    reg [1:0] Disable = 2'b00;
    wire [1:0] Enable; 
    DisableHandler UUT(Disable,clk,Enable,Pause); 
    //Wavetable
    reg clk = 0; 
    always begin
        clk = ~clk; #1;
    end 
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
            #1000; Disable = 1; #1000; Disable = 0; #15000; Disable = 2; #1000; Disable = 0; #15000;
        $finish;     
    end
endmodule