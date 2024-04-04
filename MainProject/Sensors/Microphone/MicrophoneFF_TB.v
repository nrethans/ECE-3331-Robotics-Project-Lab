`include "MainProject/Sensors/Microphone/MicrophoneFFs.v"
module testbench;
    reg CLK=0,RightMic=0, LeftMic=0;
    wire Direction;
    MicFFs UUT(CLK,RightMic,LeftMic,Direction);
    always begin
        CLK=~CLK; #1;
    end
    always begin
        RightMic=~RightMic; #4;
    end
    
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
            #1; LeftMic=1;
            #4; LeftMic=0;
            #4; LeftMic=1;
            #4; LeftMic=0;
            #4; LeftMic=1;
            #4; LeftMic=0;
            #4; LeftMic=1;
            #4; LeftMic=0;
            #4; LeftMic=1;
            #4; LeftMic=0;
            #4; LeftMic=1;
            #6; LeftMic=0;
            #4; LeftMic=1;
            #4; LeftMic=0;
            #4; LeftMic=1;
            #4; LeftMic=0;
            #4; LeftMic=1;
            #4; LeftMic=0;
            #8; LeftMic=1;
            #4; LeftMic=0;
            #4; LeftMic=1;
            #4; LeftMic=0;
            #4; LeftMic=1;
            #4; LeftMic=0;
            #4; LeftMic=1;
            #4; LeftMic=0;
            #4; LeftMic=1;
            #4; LeftMic=0;
            #4; LeftMic=1;
            #4; LeftMic=0;
            
        $finish;     
    end
endmodule