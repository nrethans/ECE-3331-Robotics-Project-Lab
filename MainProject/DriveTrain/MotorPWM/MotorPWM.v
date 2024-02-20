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
module MotorPWM(input clk, input sw0,sw1, output reg PulseSignalA=1'b0, PulseSignalB=1'b0);
    reg [11:0] count = 12'b000000000000;
    always @(posedge clk) begin
        if(count >= 12'b011111010000)begin //Limit to 2000 since posedge instead of 4000
            count = 12'b000000000000;
            count = count + 1'b1;
        end
        else begin
            count <= count + 1'b1;
        end 
        case({sw1,sw0}) //sw1 = B side, sw0 = A side, sw low = 50% duty, sw high = 100% duty
            2'b00: begin
                if(count<=12'b001111101000) begin
                    {PulseSignalA,PulseSignalB} <= 2'b11; 
                end
                else {PulseSignalA,PulseSignalB} <= 2'b00;
            end
            2'b01: begin
                if(count<=12'b001111101000) begin
                    PulseSignalB <= 1'b1;
                end
                else begin
                    PulseSignalB = 1'b0;
                end
                PulseSignalA=1'b1;
            end
            
            2'b10: begin
                if(count<=12'b001111101000) begin
                    PulseSignalA <= 1'b1;
                end
                else begin
                    PulseSignalA = 1'b0;
                end
                PulseSignalB=1'b1;
            end
            2'b11: {PulseSignalA,PulseSignalB} = 2'b11;
            default: {PulseSignalA,PulseSignalA} = 2'b00;
        endcase
    end
endmodule 