`timescale 1ns/1ns
/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Samir Hossain
    Module Name: FrequencyCounter
    Submodule of:
    Dependances:
    Description: Using ir signal calculates frequency

    Inputs: clk, ir, enable, reset

    Outputs: [16:0] Hz, ir1k, ir10k

    Notes: 

*/

module FrequencyCounter_10K(
    input clk,       // Clock input
    input ir,       // Input signal
    input enable,    // Enable signal
    input reset,     // Reset signal
    output reg ir10k = 1'b0       // 10kHz indicator
);

    reg [1:0] EdgeTest = 2'b0;
    reg [15:0] Hz = 16'b0, temp = 16'b0;
    reg [23:0] count = 24'b0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            Hz <= 16'b0;
            ir10k <= 1'b0;
            temp <= 16'b0;
            count <= 24'b0;
        end else if (enable) begin
            EdgeTest[0] <= ir;
            if (!EdgeTest[0] && EdgeTest[1]) begin
                temp <= temp + 1;
            end
            EdgeTest[1] <= EdgeTest[0];
            // Update Hz every 10 million clock cycles (for 100 MHz clock)
            if (count == 10_000_000) begin
                Hz <= temp * 10; // Scale to fit 100 MHz
                if (Hz >= 9000 && Hz <=11000) ir10k <= 1;
                else ir10k <= 0;
                temp <= 0;
                count <= 0;
            end 
            else count <= count + 1;
        end 
        else begin
            // Reset internal state if enable is low
            temp <= 0;
            count <= 0;
        end
    end
endmodule
