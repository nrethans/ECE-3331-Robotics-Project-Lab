`timescale 1ns / 1ps
`include "ThinkandMotor/pwm_servo.v"
module top_controller(
    input clk,
    input [1:0] clawState,          // 00 = Neutral, 01 = Open, 10 = Close
    input [1:0] gearPinionState,    // 00 = Neutral, 01 = Raise, 10 = Lower
    output clawPS,
    output gearPinionPS
);
    // Define duty cycles for the claw
    parameter   ClawNeutral = 22'd0,
                ClawClose   = 22'd50000,
                ClawOpen    = 22'd250000;

    // Define duty cycles for the gear pinion rack
    parameter   GearNeutral = 22'd0,
                GearRaise   = 22'd100000,
                GearLower   = 22'd300000;

    // Wires to hold the current duty cycle
    reg [21:0] clawDutyCycle = 22'd0;
    reg [21:0] gearDutyCycle = 22'd0;

    // Instantiate PWM modules
    pwm_servo clawPWM (
        .clk(clk),
        .DutyCycle(clawDutyCycle),
        .PS(clawPS)
    );

    pwm_servo gearPinionPWM (
        .clk(clk),
        .DutyCycle(gearDutyCycle),
        .PS(gearPinionPS)
    );

    // Assign duty cycles based on states
    always @(*) begin
        // Claw duty cycle
        case (clawState)
            2'b00: clawDutyCycle = ClawNeutral; // Neutral
            2'b01: clawDutyCycle = ClawOpen;    // Open
            2'b10: clawDutyCycle = ClawClose;   // Close
            default: clawDutyCycle = ClawNeutral;
        endcase
        
        // Gear pinion duty cycle
        case (gearPinionState)
            2'b00: gearDutyCycle = GearNeutral; // Neutral
            2'b01: gearDutyCycle = GearRaise;   // Raise
            2'b10: gearDutyCycle = GearLower;   // Lower
            default: gearDutyCycle = GearNeutral;
        endcase
    end
endmodule
