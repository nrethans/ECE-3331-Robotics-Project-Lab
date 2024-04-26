`timescale 1ns/1ns
`include "MainProject/DriveTrain/MotorPWM/MotorPWM_WithOverdrive.v"
module testbench;
    reg [1:0] DutyCycle=0;
    wire PulseSignal;
    MotorPWM UUT(clk, DutyCycle, PulseSignal); 
    //Wavetable
    reg clk=0;
    always begin
        clk=~clk; #1;
    end
    // 10, 10, 20, 25           //DC: 00
    // 10, 8.75, 21.25, 25      //DC: 01
    // 10, 7.5, 22.5, 25        //DC: 10
    // 10, 6.25, 23.75, 25      //DC: 11
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
            #25000;
            DutyCycle=2'b01;
            #25000;
            DutyCycle=2'b10;
            #25000;
            DutyCycle=2'b11;
            #25000;
        $finish;     
    end
endmodule