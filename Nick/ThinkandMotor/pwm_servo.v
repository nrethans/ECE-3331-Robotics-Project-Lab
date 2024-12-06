module pwm_servo(
    input clk,
    input [21:0] DutyCycle,  // Input duty cycle for the servo
    output reg PS = 1'b0
);
    reg [21:0] count = 22'd0;
    parameter PWM_PERIOD = 22'd2_000_000; // One full PWM cycle

    always @(posedge clk) begin
        count = count + 1'b1;
        if (count >= PWM_PERIOD) begin
            count = 22'b0; // Reset the counter after one period
        end

        // Generate the PWM signal
        if (count >= DutyCycle) 
            PS = 1'b1;
        else 
            PS = 1'b0;
    end
endmodule