//`timescale 1ns / 1ps
module IRSense (
    input clk,
    input enable,
    input in,
    output reg trigger,
    output reg out
);

    always @(posedge clk) begin
        trigger = 1'b1;   // Always active trigger
        out = !in;        // Output inverted sensor signal
    end
endmodule