`timescale 1ns/1ns
`include "/Users/nicholasrethans/Documents/GitHub/ECE-3331-Robotics-Project-Lab/MainProject/DriveTrain/MotorPWM/MotorPWM.v"
module testbench;
    reg [1:0] DutyCycle=0;
    wire PulseSignal;
    MotorPWM UUT(clk, DutyCycle, PulseSignal); 
    //Wavetable
    reg clk=0;
    always begin
        clk=~clk; #1;
    end
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