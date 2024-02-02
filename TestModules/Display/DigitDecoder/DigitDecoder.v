/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Nicholas Rethans
    Module Name: Digit Decoder
    Submodule of: Display Top
    Description: 
    Individual digit 7 segment decoder. 
    includes 8th bit as decimal point value.

    Inputs: 
    4 bit data input expecting values 0-9.

    Outputs:
    8 bit segments output for segement and decimal point values

    Notes: 
    Index segment[0] holds segment a value, segment[7] holds DP value
    The segment anodes are illuminated on low. (Active Low)
*/
(* DONT_TOUCH = "yes" *)
module Digit_Decoder(
    input [3:0] data,
    output reg [7:0] segments);
    always@(data) begin
        case (data) //Using inverse of since display anodes are active low 
            0:  segments = 8'b11000000; //C0 
            1:  segments = 8'b11111001; //F9
            2:  segments = 8'b10100100; //A4
            3:  segments = 8'b10110000; //B0
            4:  segments = 8'b10011001; //99
            5:  segments = 8'b10010010; //92
            6:  segments = 8'b10000010; //82
            7:  segments = 8'b11111000; //F8
            8:  segments = 8'b10000000; //80
            9:  segments = 8'b10010000; //90
            default: segments = 8'b00000000; //00 default all off
        endcase
    end
endmodule
