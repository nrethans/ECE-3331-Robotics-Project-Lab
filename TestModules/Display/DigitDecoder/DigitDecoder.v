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
        case (data)                 //Using inverse of since display anodes are active low 
            0:  segments = 8'h0xC0; //3F 
            1:  segments = 8'h0xF9; //06
            2:  segments = 8'h0xA4; //5B
            3:  segments = 8'h0xB0; //4F
            4:  segments = 8'h0x99; //66
            5:  segments = 8'h0x92; //6D
            6:  segments = 8'h0x82; //7D
            7:  segments = 8'h0xF8; //07
            8:  segments = 8'h0x80; //7F
            9:  segments = 8'h0x90; //6F
            default: segments = 8'h0x00; //FF default all off
        endcase
    end
endmodule
