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
//`include "MainProject/DriveTrain/DirectionControl/DC_IR_Rev1.v"
//`include "MainProject/DriveTrain/DirectionControl/DC_Rev2.v"
//`include "MainProject/DriveTrain/DisableHandler/DisableHandler.v"
//`include "MainProject/DriveTrain/PWMEncoder/PWMEncoder.v"
//`include "MainProject/DriveTrain/MotorPWM/MotorPWM.v"

module DriveTrainTop(
    input DisableA, DisableB, Inductance_Sense, Enable_Ball_SM, IR_Ball_Detection, RightMic,LeftMic,
    Enable_Goal_SM, IR_1K_Reciever, IR_10K_Reciever, clk,
    output Enable, FWDA, BWDA, FWDB, BWDB, Goal_SM_Done, Ball_SM_Done
);

    wire Pause,PWM_Signal_A,PWM_Signal_B,LR_Mic_Signal;
    wire IR_1K,IR_10K;
    wire [1:0] Duty_SelA, Duty_SelA1, Duty_SelA2, Duty_SelB, Duty_SelB1, Duty_SelB2;
    wire FWD_A,FWD_A1,FWD_A2, FWD_B, FWD_B1, FWD_B2, BWD_A, BWD_A1, BWD_A2,BWD_B, BWD_B1, BWD_B2;
    MicFFs U6(clk,RightMic,LeftMic,LR_Mic_Signal);
    
    //Make sure the Enable signal stays high the whole time untill ball detection occurs
    GoalDirectionControl U1(clk,Enable_Goal_SM,Pause,Inductance_Sense,IR_1K,IR_10K,FWD_A1,FWD_B1,BWD_A1,BWD_B1,Goal_SM_Done,Duty_SelA1,Duty_SelB1);
    BallDirectionControl U2(clk,Enable_Ball_SM,LR_Mic_Signal,Pause,Inductance_Sense,~IR_Ball_Detection,FWD_A2,FWD_B2,BWD_A2,BWD_B2,Ball_SM_Done,Duty_SelA2,Duty_SelB2);
    DisableHandler U3({DisableA,DisableB},clk,Enable,Pause);
    
    FrequencyCounter_1K(clk,IR_1K_Reciever,1'b1,1'b0,IR_1K);
    FrequencyCounter_10K(clk,IR_10K_Reciever,1'b1,1'b0,IR_10K);
    
    assign Duty_SelA = Duty_SelA1|Duty_SelA2;
    assign Duty_SelB = Duty_SelB1|Duty_SelB2;
    MotorPWM U4A(clk,Duty_SelA,PWM_Signal_A);
    MotorPWM U4B(clk,Duty_SelB,PWM_Signal_B);
    
    assign FWD_A = FWD_A1|FWD_A2;
    assign FWD_B = FWD_B1|FWD_B2;
    assign BWD_A = BWD_A1|BWD_A2;
    assign BWD_B = BWD_B1|BWD_B2;
    PWMEncoder U5A(FWD_A,BWD_A,PWM_Signal_A,FWDA,BWDA);
    PWMEncoder U5B(FWD_B,BWD_B,PWM_Signal_B,FWDB,BWDB);
endmodule
