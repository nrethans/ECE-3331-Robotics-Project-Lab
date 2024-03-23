`timescale 1ns/1ns
`include "MainProject/DriveTrain/DriveTrainTop/DriveTrainControl_Rev1.v"
module testbench;
    reg DisableA=0,DisableB=0,Inductance_Sense=0,Enable_Ball_SM=0,IR_Ball_Detection=0,LR_Mic_Signal=0,
    Enable_Goal_SM=0,IR_1K_Reciever=0,IR_10K_Reciever=0;
    wire Enable, FWDA, BWDA, FWDB, BWDB, Goal_SM_Done, Ball_SM_DONE;
    DriveTrainTop UUT(DisableA, DisableB, Inductance_Sense, Enable_Ball_SM, IR_Ball_Detection, LR_Mic_Signal,
    Enable_Goal_SM, IR_1K_Reciever, IR_10K_Reciever, clk, Enable, FWDA, BWDA, FWDB, BWDB, Goal_SM_Done, Ball_SM_DONE); 
    //Wavetable
    reg clk=0;
    parameter PRD = 2;
    always#(PRD/2) begin
        clk = ~clk; 
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
            #25000;
            Enable_Ball_SM=1;
            #10;
            Enable_Ball_SM=0;
            #25000;
            // LR_Mic_Signal=0;
            // #25000;
            // DisableA=1;
            // #25000;
            // DisableB=0;
            // #25000;
            // Inductance_Sense=1;
            // #25000;
            // #75000;
            // Inductance_Sense=0;
            // #75000;
        $finish;     
    end
endmodule