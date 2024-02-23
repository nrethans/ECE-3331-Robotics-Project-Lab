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

module PWMEncoder(input swA,swB,Pulse, output SerialOut1,SerialOut2);
    assign SerialOut1 = swA&Pulse;
    assign SerialOut2 = swB&Pulse;
endmodule

