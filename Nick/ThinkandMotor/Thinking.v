//This file will handle the statemachine for Position discovery (IR received Color --> Color Pos --> Pos# Found)
// `include "Defines.v"
`include "ThinkandMotor/ColorTop.v"
`include "ThinkandMotor/IR_PLS2.v"
module Thinking(
    input clk, rst, ColorSignal,
    input ir_signal, Start, 
    output reg [1:0] TargetColor, TargetPos, //Target position I will use to tell next state machine
    output s2, s3,
    output reg Done,
    //output LED1, LED2, LED3,
    //output PWM_Enable
    output reg PWMGo,
    output reg [2:0] RouteRequest,
    output [3:0] an,
    output [6:0] seg,
    output reg [3:0] state
);
    `include "ThinkandMotor/params.v"
    //Internal signals to connect to each module
    // reg [3:0] state, NextState;
    reg NextState;
    localparam  Idle = 0,
                IRWait = 1,
                PWM_ENABLE = 2,
                COLORWAIT = 3,
                FINDPOS = 4,
                DONE = 5;
    
    wire ColorDone;
    wire [1:0] color_detected; //ir
    wire [1:0] Pos1, Pos2, Pos3;

    // initial begin 
//    {TargetPos,PWMGo, RouteRequest, state, NextState, Done} = 0;
//    TargetColor = FQ_Clear;
    // end

    //Color Instantiation
    ColorTop Colortop1(
        .clk(clk), .rst(rst), .signal(ColorSignal),
        .s2(s2), .s3(s3),
        .Done(ColorDone),
        .Color1(Pos1),
        .Color2(Pos2),
        .Color3(Pos3),
        .an(an), .seg(seg)
    );

    IR_PLS2 IR_module(
        .ir_signal(ir_signal),
        .clk(clk),
        .color_detected(color_detected)
    );

    assign LED1 = (TargetPos == 1);
    assign LED2 = (TargetPos == 2);
    assign LED3 = (TargetPos == 3);

    always @(*) begin
        if (rst) begin
            {PWMGo, RouteRequest, NextState} = 0;
            TargetColor = FQ_Clear;
        end
        else begin
        
        case(state) 
        Idle: begin
            NextState = Start ? IRWait : Idle;
        end
        IRWait: begin 
            if (color_detected != FQ_Clear)begin
                TargetColor = color_detected;
                NextState = PWM_ENABLE;
            end  
            else
                NextState = IRWait;
        end
        PWM_ENABLE: begin 
            RouteRequest = DRIVE_Straight;
            PWMGo = 1;
            NextState = COLORWAIT;
        end
        COLORWAIT: begin 
            NextState = ColorDone ? FINDPOS : COLORWAIT;
        end
        FINDPOS: begin 
            NextState = Done;
        end
        DONE: begin 
            NextState = Done;
        end
        default:
            NextState = 0;
        endcase
        end
    end
    always @(posedge clk) begin
        if (rst) begin
            state = 0;
            TargetPos = 0;
            Done = 0;
        end
        else begin 
            state = NextState;
        case(state)

            FINDPOS: begin 
                // At this point, we have TargetColor & colors @ Pos1,2,3
                if (TargetColor == Pos1) begin
                    TargetPos = 1;
                end
                else if (TargetColor == Pos2) begin
                    TargetPos = 2;
                end
                else if (TargetColor == Pos3) begin
                    TargetPos = 3;
                end
            end
            
            DONE: begin
                Done = 1;
            end

            default: begin

            end
        endcase
        end
    end
    
endmodule