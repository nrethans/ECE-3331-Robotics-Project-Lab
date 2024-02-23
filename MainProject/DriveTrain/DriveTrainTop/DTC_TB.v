/*
    #25000 PWM period

    #15000 Pause period
*/
`timescale 1ps/1ps
`include "/Users/nicholasrethans/Documents/GitHub/ECE-3331-Robotics-Project-Lab/MainProject/DriveTrain/DriveTrainTop/DriveTrainControl.v"

module testbench;
    reg [5:0] sw = 0;
    reg [1:0] Serial_In_Disable = 0;

    wire [5:2] Serial_Out;
    wire [1:0] Serial_Out_Enable;
    wire Pause;
    wire [7:0] led;
    DriveTrainTop UUT(Serial_Out,Serial_Out_Enable,Pause,led,sw,Serial_In_Disable,clk); 
    //Wavetable
    reg clk=0;
    parameter PRD = 2;
    always#(PRD/2) begin
        clk = ~clk; 
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        sw[2]=1;
        sw[4]=1;
        #50000;
        sw[1]=1;
        #50000;
        Serial_In_Disable[1] = 1;
        #20000;
        Serial_In_Disable[1] = 0;
        #30000;
        $finish;     
    end
endmodule