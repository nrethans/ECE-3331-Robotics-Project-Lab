`include "TestModules/Display/SyncCounter/SyncCounter.v"

module testbench;
    wire [1:0] sync_count;
    SyncCounter UTT(clk,sync_count); 
    //Wavetable
    reg clk=0;
    parameter PRD = 2;
    always#(PRD/2) begin
        clk = ~clk; 
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        #10;
        $finish;     
    end
    
endmodule