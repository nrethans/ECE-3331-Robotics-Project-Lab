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

module DisplayMUX(
    input [7:0] segment1, segment2, segment3, segment4,
    input [1:0] sync_count, output reg [7:0] segmentout=0
);
    always @(segment1,segment2,segment3,segment4,sync_count) begin
        case(sync_count)
            0: segmentout = segment1;
            1: segmentout = segment2;
            2: segmentout = segment3;
            3: segmentout = segment4;
            default: segmentout = 1;
        endcase
    end
endmodule

// module testbench;
//     reg [7:0] segment1 = 8'h0xAA, segment2 = 8'h0xBB, segment3 = 8'h0xCC, segment4 = 8'h0xDD;
//     reg [1:0] sync_count = 0;
//     wire [7:0] segmentout;
//     DisplayMUX UTT(segment1, segment2, segment3, segment4, sync_count,segmentout); 
//     //Wavetable
//     initial begin
//         $dumpfile("waveform.vcd");
//         $dumpvars(0, testbench);
//         #5;
//         sync_count=1; #5;
//         sync_count=2; #5;
//         sync_count=3; #5;
//         sync_count=0; #5;
//         sync_count=1; #5;
//         sync_count=2; #5;
//         $finish;     
//     end
// endmodule