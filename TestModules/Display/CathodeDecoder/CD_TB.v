`include "TestModules/Display/CathodeDecoder/CathodeDecoder.v"

module testbench;
    reg [1:0] sync_count=0;
    wire [3:0] cathode;
    CathodeDecoder UTT(sync_count,cathode); 
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        #4;
        sync_count=1; #4;
        sync_count=2; #4;
        sync_count=3; #4;
        sync_count=0; #4;
        sync_count=1; #4;
        $finish;     
    end
endmodule