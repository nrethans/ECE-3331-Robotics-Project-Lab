/*
    ECE 3331-303 Group 3
    Spring 2024

    Name: Nicholas Rethans
    Module Name: Main State Machine
    Submodule of: None
    Dependances: Ball_SM, Goal_SM, Shooter_SM, Defence_SM
    Description: See Miro

    Inputs: 

    Outputs: 

    Notes:

*/
module Main_State_Machine(
    input clk, input Attack, input Defense, input Reset, input Ball_SM_Done, input Goal_SM_Done, input Defense_SM_Done, input Shooter_Done,
    output reg Ball_Detection_SM_EN = 1'b0, output reg Goal_Detection_SM_EN = 1'b0, output reg Defense_SM_EN = 1'b0, output reg Shooter_EN = 1'b0);

    parameter IDLE = 3'b000,
    BALL_DETECTION = 3'b001,
    GOAL_DETECTION = 3'b010,
             SHOOT = 3'b011,
           DEFENSE = 3'b100;

    reg [2:0] STATE = 3'b000;

    always@(posedge clk) begin
        if(Reset) STATE = IDLE;
        else begin
            case(STATE) //State Transitions:
                IDLE: begin
                    STATE = (Attack&Defense)?(IDLE):(
                        (Defense)?(DEFENSE):(
                            (Attack)?(BALL_DETECTION):(IDLE)
                        )
                    );
                end
                BALL_DETECTION: STATE = (Ball_SM_Done)?(GOAL_DETECTION):(BALL_DETECTION);
                GOAL_DETECTION: STATE = (Goal_SM_Done)?(SHOOT):(GOAL_DETECTION);
                SHOOT: STATE = (Shooter_Done)?(IDLE):(SHOOT);
                DEFENSE: STATE = (Defense_SM_Done)?(IDLE):(DEFENSE);
            endcase
        end
        case(STATE) //State Actions:
            IDLE: {Ball_Detection_SM_EN,Goal_Detection_SM_EN,Defense_SM_EN,Shooter_EN} = 4'b0000;
            BALL_DETECTION: {Ball_Detection_SM_EN,Goal_Detection_SM_EN,Defense_SM_EN,Shooter_EN} = 4'b1000;
            GOAL_DETECTION: {Ball_Detection_SM_EN,Goal_Detection_SM_EN,Defense_SM_EN,Shooter_EN} = 4'b0100;
            SHOOT: {Ball_Detection_SM_EN,Goal_Detection_SM_EN,Defense_SM_EN,Shooter_EN} = 4'b0001;
            DEFENSE: {Ball_Detection_SM_EN,Goal_Detection_SM_EN,Defense_SM_EN,Shooter_EN} = 4'b0010;
        endcase
    end
endmodule