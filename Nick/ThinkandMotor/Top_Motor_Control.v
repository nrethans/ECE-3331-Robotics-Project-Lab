`include "ThinkandMotor/IPS_Main.v"
`include "ThinkandMotor/IRSense.v"
`include "ThinkandMotor/PWM2.v"
`include "ThinkandMotor/TopController.v"
module TopMotor(
    input clk,
    input [2:0] sensor_input,  // 3-bit sensor input: sensor_input[2] = sensor_inputL, sensor_input[1] = sensor_inputM, sensor_input[0] = sensor_inputR
    input ir_box,              // IR box detection
    input [2:0] RouteRequest,  // Route request from the top-level controller
    input PWMGo,              // Route execution sensor_input
    output ENAL,               // Left motor
    output ENAR,               // Right motor
    //output [15:0] LED,
    output reg LIN1,           // Left motor forward
    output reg LIN2,           // Left motor backward
    output reg RIN1,           // Right motor forward
    output reg RIN2,           // Right motor backward
    output reg Taskdone        // sensor_input to indicate task completion
);

    // Motor control
    reg [19:0] widthL;          // Left motor
    reg [19:0] widthR;          // Right motor

    // Servo control
    reg [1:0] clawState;        // Claw state: 00 = Neutral, 01 = Open, 10 = Close
    reg [1:0] gearPinionState;  // Gear pinion state: 00 = Neutral, 01 = Raise, 10 = Lower

    // State and control sensor_inputs
    reg [2:0] state;            // State register
    reg [31:0] timer;           // Timer for delays
    reg delay_active;           // Delay flag for ignoring sensors
    reg [3:0] routePending;

    // assign LED[0] = state[0];
    // assign LED[1] = state[1];
    // assign LED[2] = state[2];
    // assign LED[3] = sensor_input[0];
    // assign LED[4] = sensor_input[1];
    // assign LED[5] = sensor_input[2];
    // assign LED[9] = 0;
    // assign LED[10] = routePending[0];
    // assign LED[11] = routePending[1];
    // assign LED[12] = routePending[2];
    // assign LED[13] = 0;
    // assign LED[14] = 0;
    // assign LED[15] = Taskdone;

    // State Definitions
    parameter IDLE = 3'b000,
              ROUTE_REQUEST = 3'b001,
              FWD = 3'b010,
              INTERSECTION = 3'b011,
              LEFT_TURN = 3'b100,
              RIGHT_TURN = 3'b101,
              STRAIGHT = 3'b110,
              DEGREE_180 = 3'b111;

    // Route Definitions
    parameter ROUTE_STOP = 3'b000,
              ROUTE_FWD = 3'b001,
              ROUTE_INTERSECTION = 3'b010,
              ROUTE_LEFT_TURN = 3'b011,
              ROUTE_RIGHT_TURN = 3'b100,
              ROUTE_180 = 3'b101,
              ROUTE_CLAW_OPEN = 3'b110,
              ROUTE_CLAW_CLOSE = 3'b111;

    // IR Sensor outputs
    wire ir_box_detected;
    wire ir_desk_detected;

    // Instantiate IR Sensors
    IRSense ir_box_inst(
        .clk(clk),
        .enable(1'b1),
        .in(ir_box),
        .trigger(),
        .out(ir_box_detected)
    );

    IRSense ir_desk_inst(
        .clk(clk),
        .enable(1'b1),
        .in(ir_desk),
        .trigger(),
        .out(ir_desk_detected)
    );

    // Instantiate PWM for motors
    PWM2 pwm_inst(
        .clk(clk),
        .widthL(widthL),
        .widthR(widthR),
        .ENAL(ENAL),
        .ENAR(ENAR)
    );

    // Instantiate IPS sensors
    IPS_Main ips_inst(
        .clk(clk),
        .signalL(sensor_input[2]),
        .signalM(sensor_input[1]),
        .signalR(sensor_input[0])
    );

    // Instantiate Servo PWM
    top_controller servo_control(
        .clk(clk),
        .clawState(clawState),
        .gearPinionState(gearPinionState),
        .clawPS(),
        .gearPinionPS()
    );

    // Main State Machine
    always @(posedge clk) begin
        if (PWMGo) begin
            state <= ROUTE_REQUEST;
            Taskdone = 1'b0;
            routePending = RouteRequest;
        end
        case (state)
            IDLE: begin
                // Initialize motors and servos to neutral
                LIN1 <= 1'b0;
                LIN2 <= 1'b0;
                RIN1 <= 1'b0;
                RIN2 <= 1'b0;
                widthL <= 20'd0;
                widthR <= 20'd0;
                clawState <= 2'b01;        // Claw open
                gearPinionState <= 2'b10;  // Gear pinion lowered
                Taskdone = 1;

                
            end

            ROUTE_REQUEST: begin
                case (RouteRequest)
                    ROUTE_STOP: begin
                        state <= IDLE;
                        Taskdone = 1'b1;
                    end
                    ROUTE_FWD: begin
                        timer <= 0;
                        Taskdone = 1;
                        state <= FWD;
                    end
                    ROUTE_INTERSECTION: begin
                        timer = 0;
                        state = FWD;
                    end
                    ROUTE_LEFT_TURN: begin
                        timer <= 0;
                        state <= FWD;
                    end
                    ROUTE_RIGHT_TURN: begin
                        timer <= 0;
                        state <= FWD;
                    end
                    ROUTE_180: begin
                        timer <= 0;
                        state <= DEGREE_180;
                    end
                    ROUTE_CLAW_OPEN: begin
                        clawState <= 2'b01;
                        timer <= 0;
                        state <= IDLE;
                        Taskdone = 1'b1;
                    end
                    ROUTE_CLAW_CLOSE: begin
                        clawState <= 2'b10;
                        timer <= 0;
                        state <= IDLE;
                        Taskdone = 1'b1;
                    end
                endcase
            end

            FWD: begin
                if (sensor_input == 3'b011) begin
                    // Adjust Left
                    LIN1 <= 1'b0;
                    LIN2 <= 1'b1;  // Forward
                    RIN1 <= 1'b1;
                    RIN2 <= 1'b0;
                    widthL <= 20'd524288;
                    widthR <= 20'd524288;
                end else if (sensor_input == 3'b101) begin
                    // Go Straight
                    LIN1 <= 1'b1;
                    LIN2 <= 1'b0;
                    RIN1 <= 1'b1;
                    RIN2 <= 1'b0;
                    widthL <= 20'd524288;
                    widthR <= 20'd524288;
                end else if (sensor_input == 3'b110) begin
                    // Adjust Right
                    LIN1 <= 1'b1;
                    LIN2 <= 1'b0;
                    RIN1 <= 1'b0;
                    RIN2 <= 1'b1;
                    widthL <= 20'd838861;
                    widthR <= 20'd838861;
                end else if (sensor_input == 3'b000 || sensor_input == 3'b001 || sensor_input == 3'b100) begin
                    state = FWD;  // Intersection or stop condition
                    case(routePending)
                        ROUTE_FWD:begin 
                            LIN1 <= 1'b1;
                            LIN2 <= 1'b0;
                            RIN1 <= 1'b1;
                            RIN2 <= 1'b0;
                            state = FWD;
                            Taskdone = 1;
                        end

                        ROUTE_INTERSECTION:begin 
                            state = INTERSECTION;
                        end

                        ROUTE_LEFT_TURN:begin 
                            state = LEFT_TURN;
                        end

                        ROUTE_RIGHT_TURN:begin 
                            state = RIGHT_TURN;
                        end

                        ROUTE_180:begin 
                            state = DEGREE_180;
                        end
                    endcase
                end
            end
            INTERSECTION: begin
                if (timer < 32'd50_000_000) begin
                    LIN1 <= 1'b1;
                    LIN2 <= 1'b0;
                    RIN1 <= 1'b1;
                    RIN2 <= 1'b0;
                    widthL <= 20'd524288; 
                    widthR <= 20'd524288;  
                    timer <= timer + 1;
                end else begin
                    if (sensor_input == 3'b000 || sensor_input == 3'b001 || sensor_input == 3'b100) begin
                        state = INTERSECTION;
                    end else begin
                        state <= FWD;
                        Taskdone =1;
                    end
                end
            end

            LEFT_TURN: begin
                if (timer < 32'd50_000_000) begin
                    LIN1 <= 1'b0;
                    LIN2 <= 1'b1;
                    RIN1 <= 1'b1;
                    RIN2 <= 1'b0;
                    widthL <= 20'd524288; //slower than the right
                    widthR <= 20'd524288;  
                    timer <= timer + 1;
                end else begin
                    if (sensor_input[2]) begin
                        state = LEFT_TURN;
                    end else begin
                        state <= FWD;
                        Taskdone =1;
                    end
                end
            end

            RIGHT_TURN: begin
                if (timer < 32'd50_000_000) begin
                    LIN1 <= 1'b1;
                    LIN2 <= 1'b0;
                    RIN1 <= 1'b0;
                    RIN2 <= 1'b1;
                    widthL <= 20'd524288;
                    widthR <= 20'd524288;  //slower than the left 
                    timer <= timer + 1;
                end else begin
                     if (sensor_input[0]) begin
                        state = RIGHT_TURN;
                    end else begin
                        state <= FWD;
                        Taskdone =1;
                    end
                end
            end

            DEGREE_180: begin
                if (timer < 32'd100_000_000) begin
                    LIN1 <= 1'b0;
                    LIN2 <= 1'b1;
                    RIN1 <= 1'b1;
                    RIN2 <= 1'b0;  // 180-degree turn
                    widthL <= 20'd209715;
                    widthR <= 20'd209715;
                    timer <= timer + 1;
                end else begin
                    if (sensor_input != 3'b111) begin
                        state = FWD;
                    end else begin
                        state = DEGREE_180;
                        Taskdone =1;
                    end
                end
            end
        endcase
    end
endmodule