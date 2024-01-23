`include "TestModules/Display/DisplayMUX/DisplayMux.v"

module testbench;
    reg [7:0] segment1 = 8'h0xAA, segment2 = 8'h0xBB, segment3 = 8'h0xCC, segment4 = 8'h0xDD;
    reg [1:0] sync_count = 0;
    wire [7:0] segmentout;
    DisplayMUX UTT(segment1, segment2, segment3, segment4, sync_count,segmentout); 
    //Wavetable
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        #5;
        sync_count=1; #5;
        sync_count=2; #5;
        sync_count=3; #5;
        sync_count=0; #5;
        sync_count=1; #5;
        sync_count=2; #5;
        $finish;     
    end
endmodule