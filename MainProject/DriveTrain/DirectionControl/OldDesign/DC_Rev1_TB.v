`include "MainProject/DriveTrain/DirectionControl/DirectionControl_Rev1.v"
module testbench;
    reg enable=0, pause=0, inductance=0, reset=0;
    reg [3:0] direction = 0;
    reg [5:0] track_count_Aside = 0, track_count_Bside = 0;

    wire FWD_A,FWD_B,BWD_A,BWD_B,MotorEncoder_RST;
    wire [1:0] Duty_Sel;
    DirectionControl UUT(clk,enable,pause,inductance,reset,direction,track_count_Aside,track_count_Bside,FWD_A,FWD_B,BWD_A,BWD_B,MotorEncoder_RST,Duty_Sel); 
    //Wavetable
    reg clk=0;
    parameter PRD = 2;
    always#(PRD/2) begin
        clk = ~clk; 
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        //Non-Interrupt Test
        #4;
        enable=1;
        #4;
        enable=0;
        track_count_Aside=10;
        #12; 
        track_count_Bside=10;
        #20;
        //Inductance Test
        #4; 
        enable=1;
        #4;
        enable=0;
        inductance=1;
        #16;
        track_count_Aside=10;
        track_count_Bside=10;
        #14; 
        //Pause Test
        #4; 
        enable=1;
        #4;
        enable=0;
        pause=1;
        #10;
        pause=0;
        #4;
        track_count_Aside=10;
        #14;
        pause=1;
        #4;
        pause=0;
        #4;
        track_count_Bside=10;
        #16;
        //Reset Test
        #4; 
        enable=1;
        #4;
        enable=0;
        reset=1;
        #2;
        reset=0;
        #12;
        $finish;     
    end
endmodule