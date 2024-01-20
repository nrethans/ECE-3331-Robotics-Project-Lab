/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Nicholas Rethans
    Module Name: CathodeDecoder
    Submodule of: Display Top
    Description: Cathode Decoder selects which cathode (digit) to display

    Inputs: sync_count - 2 bits

    Outputs: cathode - 4 bits

    Notes:
*/

module CathodeDecoder(input [1:0] sync_count, output reg [3:0] cathode=2'b00);
    always@(sync_count)begin
        case (sync_count)
            0: cathode <= 4'b0001;
            1: cathode <= 4'b0010;
            2: cathode <= 4'b0100;
            3: cathode <= 4'b1000; 
        endcase
    end
endmodule

// module testbench;
//     reg [1:0] sync_count=0;
//     wire [3:0] cathode;
//     CathodeDecoder UTT(sync_count,cathode); 
//     initial begin
//         $dumpfile("waveform.vcd");
//         $dumpvars(0, testbench);
//         #4;
//         sync_count=1; #4;
//         sync_count=2; #4;
//         sync_count=3; #4;
//         sync_count=0; #4;
//         sync_count=1; #4;
//         $finish;     
//     end
// endmodule