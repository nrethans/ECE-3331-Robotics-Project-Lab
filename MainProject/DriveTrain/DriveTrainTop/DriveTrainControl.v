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
`include "/Users/nicholasrethans/Documents/GitHub/ECE-3331-Robotics-Project-Lab/MainProject/DriveTrain/MotorEncoder/MotorEncoder.v"
`include "/Users/nicholasrethans/Documents/GitHub/ECE-3331-Robotics-Project-Lab/MainProject/DriveTrain/MotorPWM/MotorPWM.v"
`include "/Users/nicholasrethans/Documents/GitHub/ECE-3331-Robotics-Project-Lab/MainProject/DriveTrain/DisableHandler/DisableHandler.v"

module DriveTrainTop(
    output [5:2] Serial_Out, output [1:0] Serial_Out_Enable, output Pause,
    output [7:0] led, input [5:0] sw, input [1:0] Serial_In_Disable, input clk);
    assign led[0] = sw[0];
    assign led[1] = sw[1];
    assign led[2] = sw[2];
    assign led[3] = sw[3];
    assign led[4] = sw[4];
    assign led[5] = sw[5];
    assign led[6] = Serial_In_Disable[0];
    assign led[7] = Serial_In_Disable[1];
    wire [1:0] Internal_PWM_Signal; //[1] A side, [0] B side 
    DisableHandler DisableUnit(Serial_In_Disable,clk,Serial_Out_Enable,Pause);
    MotorPWM PwmUnit(clk,sw[1:0],Internal_PWM_Signal[1],Internal_PWM_Signal[0]);
    PWMEncoder PWMEncoderUnit1(sw[2],sw[3],Internal_PWM_Signal[1],Serial_Out[2],Serial_Out[3]); //A side direction control
    PWMEncoder PWMEncoderUnit2(sw[4],sw[5],Internal_PWM_Signal[0],Serial_Out[4],Serial_Out[5]); //B side direction control
endmodule

