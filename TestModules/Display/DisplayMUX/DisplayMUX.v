/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Nicholas Rethans
    Module Name: Display MUX
    Submodule of: Display Top
    Description: 4 to 1, 8-bit mux

    Inputs: 
    segments1, segments2, segments3, segments4, 8-bits
    sync_count, 2-bits
    Outputs:
    segmentout, 8-bits

    Notes:
*/
(* DONT_TOUCH = "yes" *)
module DisplayMUX(
    input [7:0] segment1, segment2, segment3, segment4,
    input [1:0] sync_count, output reg [7:0] segmentout=0
);
    always @(segment1,segment2,segment3,segment4,sync_count) begin
        case(sync_count)
            0: segmentout = segment1; //Sel segment 1
            1: segmentout = segment2; //Sel segment 2
            2: segmentout = segment3; //Sel segment 3
            3: segmentout = segment4; //Sel segment 4
            default: segmentout = 0;  
        endcase
    end
endmodule

