/*
    ECE 3331-303 Group 3
    Spring 2024

    Name: Nicholas Rethans
    Module Name: Direction Control IR Goal Dection State Machine
    Submodule of: 
    Dependances: Dual PWM, Motor Encoder, Disable Control
    Description:

    Inputs: clk, Enable, Pause, Inductance, IR_1k, IR_10k

    Outputs: FWD A/B, BWD A/B, 2'b Duty_SelA, 2'b Duty_SelB

    States: IDLE, TURN_RIGHT, SMALL_RIGHT, SMALL_LEFT, PAUSE, INDUCTNACE
     
    Notes: Change turning mechanism to turn in place

*/
module GoalDirectionControl(
    input clk, Enable, Pause, Inductance, IR_1k, IR_10k,
    output reg FWD_A=1'b0,FWD_B=0,BWD_A=1'b0,BWD_B=0,Done=1'b0,
    output reg [1:0] Duty_SelA = 2'b00, Duty_SelB =2'b00
);
    parameter IDLE = 3'b000,
        TURN_RIGHT = 3'b001,
       SMALL_RIGHT = 3'b010,
        SMALL_LEFT = 3'b011,
             PAUSE = 3'b100,
        INDUCTANCE = 3'b101;

    reg [2:0] STATE = 3'b000, PREV_STATE = 3'b000;
    reg SR_FLG = 1'b0, SL_FLG = 1'b0, IND_FLG = 1'b0;
    reg [28:0] COUNT = 29'b0;
    reg [1:0] Enable_Edge=2'b00;
    always@(posedge clk)begin
        Enable_Edge[1]=Enable_Edge[0];
        Enable_Edge[0]=Enable;
        case(STATE)
            IDLE: STATE = ((~Enable_Edge[1]&Enable_Edge[0]))?(TURN_RIGHT):(IDLE);
            TURN_RIGHT: begin
                PREV_STATE=TURN_RIGHT;
                STATE = (Pause)?(PAUSE):(
                    (Inductance)?(INDUCTANCE):(
                        (IR_1k)?(SMALL_RIGHT):(
                            (IR_10k)?(SMALL_LEFT):(TURN_RIGHT)
                        )
                    )
                );
            end
            SMALL_RIGHT: begin
                STATE = (SR_FLG)?(SMALL_RIGHT):(IDLE); 
                PREV_STATE = SMALL_RIGHT;
            end
            SMALL_LEFT: begin
                STATE = (SL_FLG)?(SMALL_LEFT):(IDLE); 
                PREV_STATE = SMALL_LEFT;
            end
            PAUSE: STATE = (Pause)?(PAUSE):(PREV_STATE);
            INDUCTANCE: begin
                STATE = (IND_FLG)?(INDUCTANCE):(
                    (Inductance)?(INDUCTANCE):(PREV_STATE)
                );
            end
        endcase
        case(STATE)
            IDLE: begin
                {FWD_A,FWD_B,BWD_A,BWD_B}=4'b0;
                {Duty_SelA,Duty_SelB}=4'b0;
                {SR_FLG,SL_FLG,IND_FLG}=3'b111;
            end
            TURN_RIGHT: begin
                {FWD_A,FWD_B,BWD_A,BWD_B}=4'b1001;
                {Duty_SelA,Duty_SelB}=4'b0000;
                {SR_FLG,SL_FLG,IND_FLG,Done}=4'b1110;
            end
            SMALL_RIGHT: begin
                {FWD_A,FWD_B,BWD_A,BWD_B}=4'b1001;
                {Duty_SelA,Duty_SelB}=4'b1010;
                {SL_FLG,IND_FLG,Done}=3'b110;
                COUNT=COUNT+1;
                if(COUNT==29'd100_000_000)begin
                    SR_FLG=1'b0;
                    COUNT=29'b0;
                    STATE=IDLE;
                    Done = 1'b1;
                end
            end
            SMALL_LEFT: begin
                {FWD_A,FWD_B,BWD_A,BWD_B}=4'b0110;
                {Duty_SelA,Duty_SelB}=4'b0101;
                {SR_FLG,IND_FLG,Done}=3'b110;
                COUNT=COUNT+1;
                if(COUNT==29'd100_000_000)begin
                    SL_FLG=1'b0;
                    COUNT=29'b0;
                    STATE=IDLE;
                    Done = 1'b1;
                end
            end
            PAUSE: begin
                {FWD_A,FWD_B,BWD_A,BWD_B}=4'b0;
                {Duty_SelA,Duty_SelB}=4'b0;
                {SR_FLG,SL_FLG,IND_FLG,Done}=4'b1110;
            end
            INDUCTANCE: begin
                {BWD_A,BWD_B}=2'b11;
                {FWD_A,FWD_B}=2'b00;
                {Duty_SelA,Duty_SelB}=4'b1111;
                {SR_FLG,SL_FLG,Done}=3'b110;
                COUNT=COUNT+1;
                if(COUNT==29'd200_000_000) begin //200,000,000 = 2 seconds
                    IND_FLG=1'b0;
                    COUNT=29'b0;
                end
            end
        endcase
    end
endmodule