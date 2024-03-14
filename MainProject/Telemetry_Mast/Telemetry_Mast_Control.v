/*
    ECE 3331-303 Group 3
    Spring 2024

    Name: Samir Hossain
    Module Name: Telemetry_Mast_Control
    Submodule of: 
    Dependances:
    Description: See Miro Diagram
    Inputs: clk, enable, reset
    Outputs: mast_ready, [3:0] angle, servo

    Notes:
*/


//////// For Vivado - Check the Picture in Servo Sweeper /////////

module Telemetry_Mast_Control(input clk, enable, reset, output mast_ready, output [3:0] angle, output servo);

    wire [3:0] angle_temp = angle;
    Sweeper_Control_Module U1(clk, enable, reset, mast_ready , angle);
    Servo_PWM_Generator(clk, angle_temp, servo);

endmodule