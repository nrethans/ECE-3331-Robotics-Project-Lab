/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Nicholas Rethans
    Module Name: DriveTrainControl
    Submodule of: MainTop
    Dependances: BallDirectionControl, GoalDirectionControl, MotorEncoder, MotorPWM, DisableHandler
    Description: Drive Control Module

    Inputs: DisableA, DisableB, Inductance_Sense, Enable_Ball_SM, IR_Ball_Detection, LR_Mic_Signal,
            Enable_Goal_SM, IR_1K_Reciever, IR_10K_Reciever, CLK

    Outputs: Enable, FWD_OUTA, BWD_OUTA, FWD_OUTB, BWD_OUTB
    Notes: 

    IR:
        Small right = 200_000_000
        Small left = 200_000_000
        Inductance = 300_000_000
    Ball:
        Inductance = 300_000_000
    Disable:
        Pause = 75_000_000
        Enable = 150_000_000
    PWM: 
        Period = 25_000
*/
`include "MainProject/DriveTrain/DirectionControl/DC_IR_Rev1.v"
`include "MainProject/DriveTrain/DirectionControl/DC_Rev2.v"
`include "MainProject/DriveTrain/DisableHandler/DisableHandler.v"
`include "MainProject/DriveTrain/PWMEncoder/PWMEncoder.v"
`include "MainProject/DriveTrain/MotorPWM/MotorPWM.v"

module DriveTrainTop(
    input DisableA, DisableB, Inductance_Sense, Enable_Ball_SM, IR_Ball_Detection, LR_Mic_Signal,
    Enable_Goal_SM, IR_1K_Reciever, IR_10K_Reciever, clk,
    output Enable, FWDA, BWDA, FWDB, BWDB, Goal_SM_Done, Ball_SM_Done
);

    wire Pause,PWM_Signal_A,PWM_Signal_B,FWD_A,FWD_B,BWD_A,BWD_B;
    wire [1:0] Duty_SelA, Duty_SelB;

    GoalDirectionControl U1(clk,Enable_Goal_SM,Pause,Inductance_Sense,IR_1K_Reciever,IR_10K_Reciever,FWD_A,FWD_B,BWD_A,BWD_B,Goal_SM_Done,Duty_SelA,Duty_SelB);
    BallDirectionControl U2(clk,Enable_Ball_SM,LR_Mic_Signal,Pause,Inductance_Sense,IR_Ball_Detection,FWD_A,FWD_B,BWD_A,BWD_B,Ball_SM_Done,Duty_SelA,Duty_SelB);
    DisableHandler U3({DisableA,DisableB},clk,Enable,Pause);
    MotorPWM U4A(clk,Duty_SelA,PWM_Signal_A);
    MotorPWM U4B(clk,Duty_SelB,PWM_Signal_B);
    PWMEncoder U5A(FWD_A,BWD_A,PWM_Signal_A,FWDA,BWDA);
    PWMEncoder U5B(FWD_B,BWD_B,PWM_Signal_B,FWDB,BWDB);
endmodule
