`timescale 1ns / 1ns
/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Samir Hossain
    Module Name: TriggerGenerator
    Submodule of:
    Dependances:
    Description: Generates Trigger Pulses

    Inputs: clk, enable, reset

    Outputs: trigger

    Notes:

*/

module TriggerGenerator(input clk, enable, reset, output reg trigger=1'b0);
    reg trig_state = 1'b0; // State variable for trigger signal
    reg [19:0] counter = 20'b00000000000000000000; // Counter for trigger pulse generation
    always @(posedge clk) begin
        if (enable) begin
            case(trig_state)
                1'b0: begin // State 0: Waiting for trigger activation
                           if (reset) begin
                               trig_state <= 1'b0;
                               counter <= 0;
                               trigger <= 0;
                           end else if (!trigger) begin
                               trig_state <= 1'b1; // Transition to state 01 when trigger is inactive
                           end
                       end
                1'b1: begin // State 1: Trigger pulse generation
                           if (reset) begin
                               trig_state <= 1'b0;
                               counter <= 0;
                               trigger <= 0;
                           end else begin
                               counter <= counter + 1; // Increment counter
                               if (counter == 50_0) begin // Generate trigger pulse after 1 ms should be 50_0000
                                   trigger <= 1; // Set trigger signal high
                               end
                               if (counter == 100_0) begin // Reset counter after 2 ms should be 100_0000
                                   trigger <= 0; // Set trigger signal low
                                   counter <= 0; // Reset counter
                                   trig_state <= 1'b0; // Transition back to state 00
                               end
                           end
                       end
            endcase
        end
    end
endmodule