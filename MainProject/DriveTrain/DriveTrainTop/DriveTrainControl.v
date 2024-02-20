/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Nicholas Rethans
    Module Name: DriveTrainControl
    Submodule of: MainTop
    Dependances: PWM
    Description: Drive Control Module, Interfaces with PWM and rest of design

    Inputs: **Temp: BTN_FWD, BTN_BKWD, BTN_LEFT, BTN_RIGHT
            Overcurrent

    Outputs: Left_Track_SEL, Right_Track_SEL

    Notes: 

*/
module DriveTrainTop(
    output IN1,IN2,IN3,IN4, output EnableA,EnableB,
    /*output [7:0] led,*/ input [5:0] sw, input DisableA, DisableB, clk);
    // assign led[0] = sw[0];//PWM A_SEL
    // assign led[1] = sw[1];//PWM B_SEL
    // assign led[2] = sw[2];//IN1
    // assign led[3] = sw[3];//IN2
    // assign led[4] = sw[4];//IN3
    // assign led[5] = sw[5];//IN4
    // assign led[6] = DisableA;
    // assign led[7] = DisableB;
    
    // assign IN1 = sw[2];
    // assign IN2 = sw[3];
    // assign IN3 = sw[4];
    // assign IN4 = sw[5];
endmodule

module testbench;
    reg DisableA=0,DisableB=0;
    wire EnableA,EnableB;
    DriveTrainTop UUT(EnableA,EnableB,DisableA,DisableB); 
    // //Wavetable
    // reg clk=0;
    // parameter PRD = ;
    // always#(PRD/2) begin
    //     clk = ~clk; 
    // end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
            #5; DisableA=1; #5; DisableB=1; #5; DisableA=0; #5; DisableB=0; #5;
        $finish;     
    end
endmodule