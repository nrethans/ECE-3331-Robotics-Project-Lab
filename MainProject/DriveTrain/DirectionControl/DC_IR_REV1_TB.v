`include "MainProject/DriveTrain/DirectionControl/DC_IR_Rev1.v"

module testbench;
    reg Enable=0, Pause=0, Inductance=0, IR_1k=0, IR_10k=0;
    wire FWD_A,FWD_B,BWD_A,BWD_B,Done;
    wire [1:0] Duty_SelA, Duty_SelB;
    GoalDirectionControl UUT(clk, Enable, Pause, Inductance, IR_1k, IR_10k, 
                            FWD_A,FWD_B,BWD_A,BWD_B,Done,Duty_SelA,Duty_SelB); 
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
        Enable=0;
        #4;
        Pause=1;
        #4;
        Pause=0;
        #4;
        Inductance=1;
        #4;
        Inductance=0;
        #10;
        IR_1k=1;
        #10;
        IR_1k=0;
        Enable=1;
        #4
        Enable=0;
        IR_10k=1;
        #14;
        $finish;     
    end
endmodule