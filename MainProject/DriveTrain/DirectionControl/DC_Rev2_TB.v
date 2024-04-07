`include "MainProject/DriveTrain/DirectionControl/DC_Rev2.v"
module testbench;
    reg Enable=0,BallSignal=1,Pause=0,Inductance=0,Ball_Detect=0;
    wire FWD_A,FWD_B,BWD_A,BWD_B,Done;
    wire [1:0] Duty_SelA,Duty_SelB;
    BallDirectionControl UUT(clk,Enable,BallSignal,Pause,Inductance,Ball_Detect,FWD_A,FWD_B,BWD_A,BWD_B,Done,Duty_SelA,Duty_SelB); 
    //Wavetable
    reg clk=0;
    parameter PRD = 2;
    always#(PRD/2) begin
        clk = ~clk; 
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        #4;
        Enable=1;
        #4;
        BallSignal=0;
        #4;
        Pause=1;
        #4;
        Pause=0;
        #4;
        Inductance=1;
        #12;
        Inductance=0;
        #4;
        Ball_Detect=1;
        #4;
        Ball_Detect=0;
        #4;
        #4;
        $finish;     
    end
endmodule