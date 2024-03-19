`include "MainProject/DriveTrain/IR_Motor_Encoder/IR_Motor_Encoder.v"

module testbench;
    reg reset=0,IR_Sense=0;
    wire [5:0] Track_Count;
    IR_Motor_Encoder UUT(clk,reset,IR_Sense,Track_Count); 
    //Wavetable
    reg clk=0;
    parameter PRD = 2;
    always#(PRD/2) begin
        clk = ~clk;
    end
    always#25 IR_Sense=~IR_Sense;
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        #100;
        reset=1; #4; reset=0; #4;
        #100;
        $finish;     
    end
endmodule