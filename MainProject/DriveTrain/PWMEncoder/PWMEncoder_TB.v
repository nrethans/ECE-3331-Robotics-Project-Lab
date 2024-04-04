`include "/Users/nicholasrethans/Documents/GitHub/ECE-3331-Robotics-Project-Lab/MainProject/DriveTrain/MotorEncoder/MotorEncoder.v"
module testbench;
    reg swA=0,swB=0,Pulse=1;
    wire IN1,IN2;
    PWMEncoder UUT(clk,swA,swB,Pulse,IN1,IN2); 
    //Wavetable
    reg clk=0;
    always begin
        clk = ~clk; #1;
    end
    always begin
        Pulse = ~Pulse; #2;
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
            #10;
            {swA,swB} = 2'b01; #10;
            {swA,swB} = 2'b10; #10;
            {swA,swB} = 2'b11; #10;
        $finish;     
    end
endmodule