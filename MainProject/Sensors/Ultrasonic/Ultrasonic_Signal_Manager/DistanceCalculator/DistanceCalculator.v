`timescale 1ns/1ns
/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Samir Hossain
    Module Name: DistanceCalculationModule
    Submodule of:
    Dependances:
    Description: Using Echo calculates distance in centimeters

    Inputs: clk, echo

    Outputs: [9:0] distance

    Notes: 

*/

module DistanceCalculationModule(input clk, echo, output reg [9:0] distance = 10'b0000000000);

    reg [15:0] count = 16'b00000000000000000; // Counter for echo pulse duration
    reg [15:0] pulse_duration = 16'b0000000000000000; // Duration of the echo pulse
    reg prev_echo = 1'b0;    // Previous state of the echo signal

    always @(posedge clk) begin
        // Increment count if echo signal is high and was low in the previous cycle
        if (!(echo && prev_echo)) begin
            // Calculate distance when echo ends (echo signal transitions from high to low)
            distance <= pulse_duration / (5800); // Convert echo pulse duration to distance in cm (100*58=5800)
            count <= 0; // Reset count at the start of the echo pulse
        end else begin
            count = count + 1; // Increment count during echo pulse
            pulse_duration = count;
        end
        prev_echo <= echo; // Update previous echo state
    end
endmodule