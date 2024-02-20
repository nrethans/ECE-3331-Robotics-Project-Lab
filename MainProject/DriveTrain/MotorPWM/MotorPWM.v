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

module MotorPWM(input clk, input sw[1:0], output PulseSignalA, PulseSignalB);
    reg [11:0] count = 12'b000000000000;
    always @(posedge clk) begin
        if(count == 12'b111110100000)begin
            count <= 12'b000000000000;
            count <= count + 1'b1;
        end
        else count <= count + 1'b1;
    end  
    case({sw[1],sw[0]}) //sw[1] = B side, sw[0] = A side, sw low = 50% duty, sw high = 100% duty
        2'b00: begin
            if(count<=12'b00011111010000) {PulseSignalA,PulseSignalB} <= 2'b11; // counting to 2000
            else {PulseSignalA,PulseSignalB} <= 2'b00;
        end
        2'b01: begin
            if(count<=12'b00011111010000) PulseSignalB <= 1'b1;
            else PulseSignalB = 1'b0;
            PulseSignalA=1'b1;
        end
        
        2'b10: begin
            if(count<=12'b00011111010000) PulseSignalA <= 1'b1;
            else PulseSignalA = 1'b0;
            PulseSignalB=1'b1;
        end
        2'b11: {PulseSignalA,PulseSignalB} = 2'b11;
        default: {PulseSignalA,PulseSignalA} = 2'b00;
    endcase
endmodule 