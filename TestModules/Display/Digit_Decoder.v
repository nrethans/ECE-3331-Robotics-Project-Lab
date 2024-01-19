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

    Notes: Index segment[0] holds segment a value, segment[7] holds DP value

*/
module Digit_Decoder(
    input [3:0] data,
    output reg [7:0] segments
);
    always@(data) begin
        case (data)
            0:  segments = 8'h0x3F; 
            1:  segments = 8'h0x06;
            2:  segments = 8'h0x5B;
            3:  segments = 8'h0x4F;
            4:  segments = 8'h0x66;
            5:  segments = 8'h0x6D;
            6:  segments = 8'h0x7D;
            7:  segments = 8'h0x07;
            8:  segments = 8'h0x7F;
            9:  segments = 8'h0x6F;
            default: segments = 8'h0x00;
        endcase
    end
endmodule

module testbench;
    reg [3:0] data=0;
    wire [7:0] segments;
    reg clk=0;
    Digit_Decoder UUT(data,segments); 
    //Wavetable
    parameter PRD = 2;
    always#(PRD/2) begin
        clk = ~clk; 
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        #PRD;
        for (integer i=0; i<12; i=i+1)begin
            data = i; #PRD;
        end
        $finish;     
    end
endmodule