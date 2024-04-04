`include "/Users/nicholasrethans/Documents/GitHub/ECE-3331-Robotics-Project-Lab/MainProject/DriveTrain/DirectionControl/DC_Copy.v"
`timescale 1 ns / 1 ns
module testbench;
    reg reset=0, Enable=0, PAUSE=0, INDUCTANCE=0;
    reg [3:0] Direction=0; 
    reg [15:0] CountA=0, CountB=0;
    wire FWD_EN_A, FWD_EN_B, BWD_EN_A, BWD_EN_B;
    wire [1:0] Duty_Sel;
    wire EncoderA_RST, EncoderB_RST;
    moore_sf UUT(clk,reset,Enable,Direction,CountA,CountB,PAUSE,INDUCTANCE,FWD_EN_A,FWD_EN_B,BWD_EN_B,Duty_Sel,EncoderA_RST,EncoderB_RST,BWD_EN_A); 
    reg clk=0;
    always begin
        clk = ~clk; #1;
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        #4; //idle
        Enable=1;
        #4; //Direction 0000 - LEFT90
        Enable=0;
        PAUSE=1;
        #4; //Pause Test
        PAUSE=0;
        #4; //LeavePause
        INDUCTANCE=1;
        #4;
        INDUCTANCE=0;
        #4;
        CountA=20;
        #4; //Advance to forward stage 2
        CountB=20;
        #4; //Advance to Done
        // Direction=3;
        // CountB=0;
        // #4; //Idle
        // Enable=1;
        // CountA=20;
        // #4; //Direction 0011
        // Enable=0;
        // CountA=20;
        // CountB=20;
        // #4; //Advance to forward stage 2
        // CountB=0;
        // #4; //Done
        // Enable=1;
        // #4; //Direction 0011
        // Enable=0;
        // INDUCTANCE=1;
        // #4;
        $finish;     
    end
endmodule