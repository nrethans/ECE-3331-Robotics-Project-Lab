//`include "MainProject/MainStateMachine/MainStateMachine.v"
//`include "MainProject/DriveTrain/DirectionControl/DC_Rev2.v"
//`include "MainProject/DriveTrain/DirectionControl/DC_IR_Rev1.v"
//`include "MainProject/DriveTrain/DirectionControl/DC_Defence.v"
//`include "MainProject/KickerSolinoid/Kicker.v"
//`include "MainProject/Sensors/Microphone/MicrophoneFFs.v"
//`include "MainProject/Sensors/IR/1_kHz_Frequency_Counter.v"
//`include "MainProject/Sensors/IR/10_kHz_Frequency_Counter.v"
//`include "MainProject/DriveTrain/DisableHandler/DisableHandler.v"
//`include "MainProject/DriveTrain/MotorPWM/MotorPWM.v"
//`include "MainProject/DriveTrain/PWMEncoder/PWMEncoder.v"
module Main(
    input Defense, Attack, Reset, DisableA, DisableB, Inductance_Sense, IR_Ball_Detect,
          LeftMic, RightMic, IR_1K_Reciever, IR_10K_Reciever, clk,
    output Enable, FWDA, BWDA, FWDB, BWDB, Kick, led
);
    //Wires:
    wire Ball_Detection_SM_EN, Goal_Detection_SM_EN, Defense_SM_EN, Kicker_EN;
    wire Ball_SM_Done, Goal_SM_Done, Defense_SM_Done, Kicker_Done; 
    wire Direction;
    wire Pause;
    wire IR_1K, IR_10K;
    wire [1:0] Duty_SelA, Duty_SelA1, Duty_SelA2, Duty_SelA3, Duty_SelB, Duty_SelB1, Duty_SelB2, Duty_SelB3;
    wire FWD_A, FWD_A1, FWD_A2, FWD_A3, FWD_B, FWD_B1, FWD_B2, FWD_B3, BWD_A, BWD_A1, BWD_A2, BWD_A3, BWD_B, BWD_B1, BWD_B2, BWD_B3;
    wire PWM_Signal_A,PWM_Signal_B;

    //State Machines:
    Main_State_Machine U0(clk, Attack, Defense, Reset, Ball_SM_Done, Goal_SM_Done, Defense_SM_Done, Kicker_Done,
                          Ball_Detection_SM_EN, Goal_Detection_SM_EN, Defense_SM_EN, Kicker_EN);
    BallDirectionControl U1(clk, Ball_Detection_SM_EN, Direction, Pause, Inductance_Sense, ~IR_Ball_Detect,
                            FWD_A1, FWD_B1, BWD_A1, BWD_B1, Ball_SM_Done, Duty_SelA1, Duty_SelB1);
                            //Make sure to invert IR_Ball_Detect Signal when IR circuit is connected.
    GoalDirectionControl U2(clk, Goal_Detection_SM_EN, Pause, Inductance_Sense, IR_1K, IR_10K,
                            FWD_A2, FWD_B2, BWD_A2, BWD_B2, Goal_SM_Done, Duty_SelA2, Duty_SelB2);
    DC_Defence U3(clk, Defense_SM_EN, Pause, Inductance_Sense, Direction, Duty_SelA3, Duty_SelB3, FWD_A3, FWD_B3, BWD_A3, BWD_B3, Defense_SM_Done);
    //Shooter:
    Kicker U4(clk, Kicker_EN, Kick, Kicker_Done);
    //Signal Handlers:
    assign led = Kick;
    MicFFs U5(clk, RightMic, LeftMic, Direction);
    FrequencyCounter_1K U6A(clk, IR_1K_Reciever, 1'b1, 1'b0, IR_1K);
    FrequencyCounter_10K U6B(clk, IR_10K_Reciever, 1'b1, 1'b0, IR_10K);
    //Drive Train Modules:
    DisableHandler U7({DisableA, DisableB}, clk, Enable, Pause);
    assign Duty_SelA = Duty_SelA1|Duty_SelA2|Duty_SelA3;
    assign Duty_SelB = Duty_SelB1|Duty_SelB2|Duty_SelB3;
    MotorPWM U8A(clk,Duty_SelA,PWM_Signal_A);
    MotorPWM U8B(clk,Duty_SelB,PWM_Signal_B);
    assign FWD_A = FWD_A1|FWD_A2|FWD_A3;
    assign FWD_B = FWD_B1|FWD_B2|FWD_B3;
    assign BWD_A = BWD_A1|BWD_A2|BWD_A3;
    assign BWD_B = BWD_B1|BWD_B2|BWD_B3;
    PWMEncoder U9A(FWD_A,BWD_A,PWM_Signal_A,FWDA,BWDA);
    PWMEncoder U9B(FWD_B,BWD_B,PWM_Signal_B,FWDB,BWDB);
endmodule