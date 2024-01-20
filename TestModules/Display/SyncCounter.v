/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Nicholas Rethans
    Module Name: SyncCounter
    Submodule of: Display Top
    Description: A counter to sync the muxing of digit decoders
    and the cathode decoder.

    Inputs: 
        clk
    Outputs:
        sync_count - 2 bits
    Notes:

*/
module SyncCounter(input clk, output reg [1:0] sync_count= 2'b11); //2'b11
    always@(posedge clk)begin
        sync_count=sync_count+1;
    end
endmodule

// module testbench;
//     wire [1:0] sync_count;
//     SyncCounter UTT(clk,sync_count); 
//     //Wavetable
//     reg clk=0;
//     parameter PRD = 2;
//     always#(PRD/2) begin
//         clk = ~clk; 
//     end
//     initial begin
//         $dumpfile("waveform.vcd");
//         $dumpvars(0, testbench);
//         #10;
//         $finish;     
//     end
    
// endmodule