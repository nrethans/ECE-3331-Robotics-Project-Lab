`include "/Users/nicholasrethans/Documents/GitHub/ECE-3331-Robotics-Project-Lab/MainProject/DriveTrain/MotorPWM/MotorPWM.v"
module testbench;
    reg sw1=0,sw0=0;
    wire PulseSignalA, PulseSignalB;
    MotorPWM UUT(clk, sw1,sw0, PulseSignalA, PulseSignalB); 
    //Wavetable
    reg clk=0;
    always begin
        clk=~clk; #1;
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
            #4000;
            sw1=1; #4000;
            sw0=1; #4000;
        $finish;     
    end
endmodule