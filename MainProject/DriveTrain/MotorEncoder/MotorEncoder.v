/*
    ECE 3331-303 Group 3
    Spring 2024

    Name: Nicholas Rethans
    Module Name: MotorEncoder
    Submodule of: DriveTrainControl
    Dependances: MotorPWM
    Description:

    Inputs: swA,swB

    Outputs: 

    Notes:

*/

module PWMEncoder(input clk,swA,swB,Pulse, output reg IN1=1'b0,IN2=1'b0);
    always@(posedge clk)begin
        case({swA,swB})
            2'b00: {IN1,IN2} <= 2'b00;
            2'b01: {IN1,IN2} <= {1'b0,Pulse};
            2'b10: {IN1,IN2} <= {Pulse,1'b0};
            2'b11: {IN1,IN2} <= 2'b00;
            default: {IN1,IN2} <= 2'b00;
        endcase
    end
endmodule

