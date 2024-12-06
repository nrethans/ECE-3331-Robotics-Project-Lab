`timescale 1ns / 1ps

module PWM2(
    input clk,
    input [19:0] widthL,  // Left motor
    input [19:0] widthR,  // Right motor
    output ENAL,          // Enable Left motor
    output ENAR           // Enable Right motor
);

    reg [19:0] counter;
    reg temp_ENAL;
    reg temp_ENAR;

    always @(posedge clk) begin
        if (0)
            counter <= 0;
        else
            counter <= counter + 1;
            temp_ENAL<=(counter< widthL);
            temp_ENAR<=(counter<widthR);
        // Left motor PWM
        if (counter < widthL)
            temp_ENAL <= 1;
        else
            temp_ENAL <= 0;

        // Right motor PWM
        if (counter < widthR)
            temp_ENAR <= 1;
        else
            temp_ENAR <= 0;
    end

    assign ENAL = temp_ENAL;
    assign ENAR = temp_ENAR;

endmodule