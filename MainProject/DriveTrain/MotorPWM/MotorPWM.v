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

    Notes:
        Commutation frequency range is 23 - 40 KHz, Typical is 25Khz
        100Mhz/25KHz = 4000
        logbase2(4000) =~ 12
*/
module MotorPWM(input clk, input [1:0] DutyCycle, output reg PulseSignalA=1'b0, PulseSignalB=1'b0);
    reg [13:0] count = 14'b0000000000000;
    parameter HalfDuty = 14'b01100001101010;
    always @(posedge clk) begin
        if(count >= 14'b11000011010100)begin                                    //Limit to 12500 since posedge instead of 25000
            count = 14'b00000000000000;
            count = count + 1'b1;
        end
        else begin
            count <= count + 1'b1;
        end 
        case({DutyCycle[1],DutyCycle[0]})                                       //DutyCycle[1] = B side, DutyCycle[0] = A side, low = 50% duty, high = 100% duty
            2'b00: begin
                if(count<=HalfDuty) {PulseSignalA,PulseSignalB} <= 2'b11; 
                else {PulseSignalA,PulseSignalB} <= 2'b00;
            end
            2'b01: begin
                if(count<=HalfDuty) PulseSignalB <= 1'b1;
                else PulseSignalB = 1'b0;
                PulseSignalA=1'b1;
            end
            
            2'b10: begin
                if(count<=HalfDuty) PulseSignalA <= 1'b1;
                else PulseSignalA = 1'b0;
                PulseSignalB=1'b1;
            end
            2'b11: {PulseSignalA,PulseSignalB} = 2'b11;
            default: {PulseSignalA,PulseSignalA} = 2'b00;
        endcase
    end
endmodule 