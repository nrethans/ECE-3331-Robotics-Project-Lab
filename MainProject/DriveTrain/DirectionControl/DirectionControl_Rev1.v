/*
    ECE 3331-303 Group 3
    Spring 2024

    Name: Nicholas Rethans
    Module Name: DirectionControl
    Submodule of: DriveTrainControl
    Dependances: Dual PWM, Motor Encoder, IR motor Encoder, Disable Control
    Description:

    Inputs: clk,enable,4'b Direction, Pause, Inductance, 6'b Track Count, Reset 

    Outputs: FWD A/B, BWD A/B, 2'b Duty_Sel, MotorEncoder_RST

    Notes:
        States: Idle, Turn -90 to 90, Forward, Pause, Inductance
*/

module DirectionControl(
    input clk, enable, pause, inductance, reset,
    input [3:0] direction, input [5:0] track_count_Aside, track_count_Bside,
    output reg FWD_A=1'b0,FWD_B=1'b0,BWD_A=1'b0,BWD_B=1'b0,MotorEncoder_RST=1'b0,
    output reg [1:0] duty_sel 2'b00;
);
    parameter    IDLE=5'b0,     //State Parameters
                PAUSE=5'b00001,
           INDUCTANCE=5'b00010,
            TURN_0000=5'b00011,
            TURN_0001=5'b00100,
            TURN_0010=5'b00101,
            TURN_0011=5'b00110,
            TURN_0100=5'b00111,
            TURN_0101=5'b01000,
            TURN_0110=5'b01001,
            TURN_0111=5'b01010,
            TURN_1000=5'b01011,
            TURN_1001=5'b01100,
            TURN_1010=5'b01101,
            TURN_1011=5'b01110,
            TURN_1100=5'b01111,
            TURN_1101=5'b10000,
            TURN_1110=5'b10001,
            TURN_1111=5'b10010,
              FORWARD=5'b10011,
  RESET_MOTOR_ENCODER=5'b10100;
    

    reg [4:0] STATE=5'b0, PREV_STATE=5'b0;
    reg IND_FLG=0, FWD_FLG=0,RDY_FLG=0;
    always@(posedge clk)begin
        if(reset) begin
            STATE=Idle;
        end
        else begin
            case(STATE)
                IDLE: begin
                    if(enable)begin
                        case(direction)
                            4'b0000: STATE=TURN_0000;
                            4'b0001: STATE=TURN_0001;
                            4'b0010: STATE=TURN_0010;
                            4'b0011: STATE=TURN_0011;
                            4'b0100: STATE=TURN_0100;
                            4'b0101: STATE=TURN_0101;
                            4'b0110: STATE=TURN_0110;
                            4'b0111: STATE=TURN_0111;
                            4'b1000: STATE=TURN_1000;
                            4'b1001: STATE=TURN_1001;
                            4'b1010: STATE=TURN_1010;
                            4'b1011: STATE=TURN_1011;
                            4'b1100: STATE=TURN_1100;
                            4'b1101: STATE=TURN_1101;
                            4'b1110: STATE=TURN_1110;
                            4'b1111: STATE=TURN_1111;
                            default: STATE=TURN_1000;
                        endcase
                    end
                end
                PAUSE: if(~pause) STATE=PREV_STATE;
                INDUCTANCE:
                 begin
                    if(pause) begin
                        PREV_STATE=STATE;
                        STATE=PAUSE;
                    end
                    else if(reset) STATE=RESET_MOTOR_ENCODER;
                    else if((track_count_Aside==6'b0)&&(track_count_Bside==6'b0)) STATE=RESET_MOTOR_ENCODER;
                    //define limit later
                end
                RESET_MOTOR_ENCODER: begin
                    casex({IND_FLG,FWD_FLG,RDY_FLG})
                        xx0: STATE=RESET_MOTOR_ENCODER;
                        001: begin
                            STATE=IDLE;
                            {IND_FLG,FWD_FLG,RDY_FLG}=3'b0;
                        end
                        101: begin
                            STATE=INDUCTANCE;
                            {IND_FLG,FWD_FLG,RDY_FLG}=3'b0;
                        end
                        011: begin
                            STATE=FORWARD;
                            {IND_FLG,FWD_FLG,RDY_FLG}=3'b0;
                        end
                        default: begin
                            STATE=IDLE;
                            {IND_FLG,FWD_FLG,RDY_FLG}=3'b0;
                        end
                    endcase
                end
                FORWARD:
                 begin
                    if(pause) begin
                        PREV_STATE=STATE;
                        STATE=PAUSE;
                    end
                    else if(reset) STATE=RESET_MOTOR_ENCODER;
                    else if(inductance) begin
                        IND_FLG=1'b1;
                        STATE=RESET_MOTOR_ENCODER;
                    end
                    else if((track_count_Aside==6'b0)&&(track_count_Bside==6'b0)) STATE=RESET_MOTOR_ENCODER;
                    //define limit later
                end
                TURN_0000: begin
                    if(pause) begin
                        PREV_STATE=STATE;
                        STATE=PAUSE;
                    end
                    else if(reset) STATE=RESET_MOTOR_ENCODER;
                    else if(inductance) begin
                        IND_FLG=1'b1;
                        STATE=RESET_MOTOR_ENCODER;
                    end
                    else if(track_count_Aside==6'b0) begin
                        FWD_FLG=1'b1;
                        STATE=FORWARD;
                    end
                    //define limit later
                end
                // TURN_0001:
                // TURN_0010:
                // TURN_0011:
                // TURN_0100:
                // TURN_0101:
                // TURN_0110:
                // TURN_0111:
                // TURN_1000:
                // TURN_1001:
                // TURN_1010:
                // TURN_1011:
                // TURN_1100:
                // TURN_1101:
                // TURN_1110:
                // TURN_1111:
            endcase
        end
        case(STATE)
            IDLE: begin
                FWD_A<=1'b0;
                FWD_B<=1'b0;
                BWD_A<=1'b0;
                BWD_B<=1'b0;
                Duty_Sel<=2'b00;
            end
            PAUSE: begin
                FWD_A<=1'b0;
                FWD_B<=1'b0;
                BWD_A<=1'b0;
                BWD_B<=1'b0;
            end
            INDUCTANCE: begin
                BWD_A<=1'b1;
                BWD_B<=1'b1;
            end
            RESET_MOTOR_ENCODER: begin
                always@(posedge clk) begin
                    //Reset Timer
                    
                end
            end
            FORWARD: begin
                
            end
            TURN_0000:
            // TURN_0001:
            // TURN_0010:
            // TURN_0011:
            // TURN_0100:
            // TURN_0101:
            // TURN_0110:
            // TURN_0111:
            // TURN_1000:
            // TURN_1001:
            // TURN_1010:
            // TURN_1011:
            // TURN_1100:
            // TURN_1101:
            // TURN_1110:
            // TURN_1111:
        endcase
    end
endmodule