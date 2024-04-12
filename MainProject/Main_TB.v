`include "MainProject/Main.v"
module testbench;
    reg Defense=1'b0, Attack=1'b0, Reset=1'b0, DisableA=1'b0, DisableB=1'b0, 
        Inductance_Sense=1'b0, IR_Ball_Detect=1'b0, LeftMic=1'b0, RightMic=1'b0, IR_1K_Reciever=1'b0,IR_10K_Reciever=1'b0, clk=1'b0;
    wire Enable, FWDA, BWDA, FWDB, BWDB, Kick;
    Main UUT(Defense, Attack, Reset, DisableA, DisableB, Inductance_Sense, IR_Ball_Detect,
             LeftMic, RightMic, IR_1K_Reciever, IR_10K_Reciever, clk, Enable, FWDA, BWDA, FWDB, BWDB, Kick); 
    //Wavetable
    parameter PRD = 2;
    always#(PRD/2) begin
        clk = ~clk; 
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        #10;
        Attack = 1; 
        #20;
        Attack = 0;
        IR_Ball_Detect = 1;
        #10;
        $finish;     
    end
endmodule