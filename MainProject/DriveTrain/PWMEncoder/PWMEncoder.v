/*
    ECE 3331-303 Group 3
    Spring 2024

    Name: Nicholas Rethans
    Module Name: PWMEncoder
    Submodule of: DriveTrainControl
    Dependances: MotorPWM
    Description:

    Inputs: swA,swB

    Outputs: 

    Notes:

*/

module PWMEncoder(input FWD,BWD,Pulse, output SerialOut1,SerialOut2);
    assign SerialOut1 = FWD&Pulse;
    assign SerialOut2 = BWD&Pulse;
endmodule

