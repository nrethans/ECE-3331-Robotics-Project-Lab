//this module is the testing top module for thinking + motor
`include "ThinkandMotor/Top_Motor_Control.v"
`include "ThinkandMotor/Thinking.v"
`include "ThinkandMotor/Defines.v"

module ThinkerTest (
    input clk, rst, 
    input ThinkerStart,
    input ColorSignal, ir_signal, BoxDetect,
    input Button,// Taskdone,
    output s2, s3,
    input [2:0] sensor_input,    
    output [15:0] LED,
    output [3:0] an,
    output [6:0] seg,   
    output ENAL, ENAR, LIN1, LIN2, RIN1, RIN2
);
    `include "ThinkandMotor/params.v"

    wire [1:0] TargetColor, TargetPos, ClawRequest, elevator;
    wire [2:0] state;
    wire [2:0] RouteRequest;
    wire [3:0] routePending;
    wire [3:0] testwire;
    //wire Taskdone;

     Thinking Thinker(
     .clk(clk), .rst(rst), .ColorSignal(ColorSignal),
     .ir_signal(ir_signal), .Start(ThinkerStart),
     .TargetColor(TargetColor), .TargetPos(TargetPos),
     .s2(s2), .s3(s3),
     .an(an), .seg(seg), .state(testwire)
    );

     TopMotor Motorboat(
     .clk(clk), .ir_box(BoxDetect),
     .sensor_input(sensor_input),
     .RouteRequest(RouteRequest),
     .PWMGo(PWMGo),
     .ENAL(ENAL), .ENAR(ENAR),
     .LIN1(LIN1), .LIN2(LIN2), .RIN1(RIN1), .RIN2(RIN2)
    );

    assign LED[0] = state[0];
    assign LED[1] = state[1];
    assign LED[2] = state[2];
    assign LED[3] = sensor_input[0];
    assign LED[4] = sensor_input[1];
    assign LED[5] = sensor_input[2];
    assign LED[9] = ir_signal;
    assign LED[10] = routePending[0];
    assign LED[11] = routePending[1];
//    assign LED[12] = routePending[2];
    assign LED[12] = testwire[0];
    assign LED[13] = testwire[1];
    assign LED[14] = testwire[2];
    assign LED[15] = testwire[3];
    

endmodule