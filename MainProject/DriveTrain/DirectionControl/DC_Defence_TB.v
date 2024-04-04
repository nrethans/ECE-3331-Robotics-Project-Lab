`include "MainProject/DriveTrain/DirectionControl/DC_Defence.v"
module testbench;
    reg Enable = 1'b0, Pause = 1'b0, Inductance = 1'b0, MicrophoneDirection = 1'b1;
    wire [1:0] DutyCycleA,DutyCycleB;
    wire FWDA,FWDB,BWDA,BWDB,Done;
    DC_Defence UUT(clk,Enable,Pause,Inductance,MicrophoneDirection,
                    DutyCycleA,DutyCycleB,FWDA,FWDB,BWDA,BWDB,Done); 
    //Wavetable
    reg clk=0;
    parameter PRD = 2;
    always#(PRD/2) begin
        clk = ~clk; 
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
            #6;
            Enable=1;
            #6;
            Enable=0;
            MicrophoneDirection=0;
            #6;
            Pause=1;
            #6;
            Pause=0;
            #6;
            MicrophoneDirection=1;
            #6;
            Inductance=1;
            #6;
            Pause=1;
            #6;
            Pause=0;
            #6;
            Inductance=0;
            #6;
        $finish;     
    end
endmodule