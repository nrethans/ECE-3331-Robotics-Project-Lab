/*
    ECE 3331-303 Group 3
    Spring 2024

    Name: Nicholas Rethans
    Module Name: Direction Control Ball Dection State Machine
    Submodule of: 
    Dependances: Dual PWM, Motor Encoder, Disable Control
    Description:

    Inputs: clk, Enable, Pause, Inductance, Ball_Detect

    Outputs: FWD A/B, BWD A/B, 2'b Duty_SelA, 2'b Duty_SelB

    States: IDLE, TURN_RIGHT, TURN_LEFT, PAUSE, INDUCTANCE
    BallSignal 1 = right mic closer
    BallSignal 0 = left mic closer

    Notes: 

*/

module BallDirectionControl(input clk,Enable,BallSignal,Pause,Inductance,Ball_Detect,
                        output reg FWD_A=1'b0,FWD_B=1'b0,BWD_A=1'b0,BWD_B=1'b0,Done=1'b0,
                        output reg [1:0] Duty_SelA=2'b00, Duty_SelB=2'b00);
    parameter IDLE=3'b000,
             PAUSE=3'b001,
        INDUCTANCE=3'b010,
        TURN_RIGHT=3'b011,
         TURN_LEFT=3'b100;
    (* DONT_TOUCH = "true" *)
    reg [2:0] STATE=3'b000,PREV_STATE=3'b0;
    reg IND_FLG = 1'b1; //IND_FLG Transition to low when inductance counter is done
    reg [28:0] IND_COUNT=29'b0;
    reg Enable_Edge=1'b0,enable=1'b0;
    wire EN;
    always@(negedge clk) enable = Enable;
    assign EN = enable & ~Enable_Edge;
    always@(posedge clk) begin
        Enable_Edge=enable;
        if(Ball_Detect) begin
            STATE=IDLE;
            Done = 1'b1;
        end
        else begin
            case(STATE)
                IDLE: STATE = (EN)?(TURN_RIGHT):(IDLE);
                PAUSE: STATE = (Pause)?(PAUSE):(PREV_STATE);
                INDUCTANCE: begin
                    STATE = (IND_FLG)?(INDUCTANCE):(
                        (Inductance)?(INDUCTANCE):(PREV_STATE)
                    );
                end
                TURN_RIGHT: begin
                    PREV_STATE = TURN_RIGHT;
                    STATE = (Pause)?(PAUSE):(
                        (Inductance)?(INDUCTANCE):(
                            (BallSignal)?(TURN_RIGHT):(TURN_LEFT)
                        )
                    );
                end
                TURN_LEFT: begin
                    PREV_STATE = TURN_LEFT;
                    STATE = (Pause)?(PAUSE):(
                        (Inductance)?(INDUCTANCE):(
                            (BallSignal)?(TURN_RIGHT):(TURN_LEFT)
                        )
                    );
                end
                default: STATE = IDLE;
            endcase
        end
        case(STATE)
            IDLE: begin
                {FWD_A,FWD_B,BWD_A,BWD_B}=4'b0;
                {Duty_SelA,Duty_SelB}=4'b0;
                IND_FLG=1'b1;
            end
            PAUSE: begin
                {FWD_A,FWD_B,BWD_A,BWD_B}=4'b0;
                {Duty_SelA,Duty_SelB}=4'b0;
                IND_FLG=1'b1;
            end
            INDUCTANCE: begin
                {BWD_A,BWD_B}=2'b11;
                {FWD_A,FWD_B}=2'b00;
                {Duty_SelA,Duty_SelB}=4'b1111;
                IND_COUNT=IND_COUNT+1;
                if(IND_COUNT==29'd100_000_000) begin
                    IND_FLG=1'b0;
                    IND_COUNT=29'b0;
                end
            end
            TURN_RIGHT: begin
                {BWD_A,BWD_B}=2'b00;
                {FWD_A,FWD_B}=2'b11;
                Duty_SelA=2'b10; //75% duty cycle 
                Duty_SelB=2'b00; //25% duty cycle
                IND_FLG=1'b1;
            end
            TURN_LEFT: begin
                {BWD_A,BWD_B}=2'b00;
                {FWD_A,FWD_B}=2'b11;
                Duty_SelA=2'b00; //25% duty cycle
                Duty_SelB=2'b10; //75% duty cycle
                IND_FLG=1'b1;
            end
        endcase
    end
endmodule
