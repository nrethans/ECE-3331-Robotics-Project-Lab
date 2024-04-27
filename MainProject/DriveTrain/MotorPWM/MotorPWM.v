/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Nicholas Rethans 
    Module Name: MotorPWM
    Submodule of: DriveTrainControl
    Dependances: Motor Control Chip
    Description: 

    Inputs: clk, sw[1:0]

    Outputs:

    Notes: This PWM frequency is 8khz 
       
*/
module MotorPWM(input clk, input [1:0] DutyCycle, output reg PulseSignal=1'b0);
    reg [13:0] count = 14'b0000000000000;
    parameter QuarterDuty = 14'd5000, //5,000
                 HalfDuty = 14'b01100001101010, //6250
         ThreeQuarterDuty = 14'd10000; //10,000
    always @(posedge clk) begin
        if(count >= 14'b11000011010100)begin                                    
            count = 14'b00000000000000;
            count = count + 1'b1;
        end
        else begin
            count = count + 1'b1;
        end 
        case(DutyCycle) //00 = 25% duty, 01 = 50% duty, 10 = 75% duty, 11 = 100%   
            2'b00: begin
                if(count<=QuarterDuty) PulseSignal = 1'b1;
                else PulseSignal = 1'b0;
            end
            2'b01: begin
                if(count<=HalfDuty) PulseSignal = 1'b1;
                else PulseSignal = 1'b0;
            end
            2'b10: begin
                if(count<=ThreeQuarterDuty) PulseSignal = 1'b1;
                else PulseSignal = 1'b0;
            end
            2'b11: PulseSignal = 1'b1;
            default: PulseSignal = 1'b0;
        endcase
    end
endmodule 