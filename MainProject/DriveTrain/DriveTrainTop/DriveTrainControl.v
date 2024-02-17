/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Nicholas Rethans
    Module Name: DriveTrainControl
    Submodule of: MainTop
    Dependances: PWM
    Description: Drive Control Module, Interfaces with PWM and rest of design

    Inputs: **Temp: BTN_FWD, BTN_BKWD, BTN_LEFT, BTN_RIGHT
            Overcurrent

    Outputs: Left_Track_SEL, Right_Track_SEL

    Notes: 

*/
module DriveTrainControl(
    input BTN_FWD, BTN_BKWD, BTN_LEFT, BTN_RIGHT,
    output reg [1:0] Left_Track_Duty = 2'b00, Right_Track_Duty=2'b00
);
    case({BTN_FWD,BTN_BKWD,BTN_LEFT,BTN_RIGHT}) begin
        4'b0000: {Left_Track_Duty,Right_Track_Duty} = 4'b0000;
        4'b0001: {Left_Track_Duty,Right_Track_Duty} = 4'b0010;
        4'b0010: {Left_Track_Duty,Right_Track_Duty} = 4'b0100;
        4'b0100: {Left_Track_Duty,Right_Track_Duty} = //backwards input?, check L298 driver datasheet
    end
endmodule
