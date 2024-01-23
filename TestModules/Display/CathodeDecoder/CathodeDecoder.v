/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Nicholas Rethans
    Module Name: CathodeDecoder
    Submodule of: Display Top
    Description: Cathode Decoder selects which cathode (digit) to display

    Inputs: sync_count - 2 bits

    Outputs: cathode - 4 bits

    Notes: cathodes are active low
*/

module CathodeDecoder(input [1:0] sync_count, output reg [3:0] cathode=2'b00);
    always@(sync_count)begin
        case (sync_count)
            0: cathode <= 4'b1110;
            1: cathode <= 4'b1101;
            2: cathode <= 4'b1011;
            3: cathode <= 4'b0111; 
        endcase
    end
endmodule

