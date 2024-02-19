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
    output IN1,IN2,IN3,IN4, output reg EnableA=1'b0,EnableB=1'b0,
    output [7:0] led, input [5:0] sw, input SNSA, SNSB, clk);
    assign led[0] = sw[0];
    assign led[1] = sw[1];
    assign led[2] = sw[2];
    assign led[3] = sw[3];
    assign led[4] = sw[4];
    assign led[5] = sw[5];
    assign led[6] = SNSA;
    assign led[7] = SNSB;

    assign IN1 = sw[2];
    assign IN2 = sw[3];
    assign IN3 = sw[4];
    assign IN4 = sw[5];
endmodule
