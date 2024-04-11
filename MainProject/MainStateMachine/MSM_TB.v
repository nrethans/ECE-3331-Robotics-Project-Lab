`include "MainProject/MainStateMachine/MainStateMachine.v"

module testbench;
    reg Attack=1'b0,Defense=1'b0,Reset=1'b0,
    Ball_SM_Done=1'b0,Goal_SM_Done=1'b0,Defense_SM_Done=1'b0,Shooter_Done=1'b0;
    wire Ball_Detection_SM_EN,Goal_Detection_SM_EN,Defense_SM_EN,Shooter_EN;
    Main_State_Machine UUT(
        clk, Attack, Defense, Reset, Ball_SM_Done, Goal_SM_Done, Defense_SM_Done, Shooter_Done,
        Ball_Detection_SM_EN, Goal_Detection_SM_EN, Defense_SM_EN, Shooter_EN
    ); 
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
            Defense = 1;
            #4; 
            Defense = 0;
            #4;
            Defense_SM_Done = 1;
            #4;
            Defense_SM_Done = 0;
            #4;
            Attack = 1;
            #4;
            Ball_SM_Done = 1;
            #4;
            Goal_SM_Done = 1;
            #4;
            Shooter_Done = 1;
            #4;
            Defense = 1;
            #4;
            Reset = 1;
            #4;
        $finish;     
    end
endmodule