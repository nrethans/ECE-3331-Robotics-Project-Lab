`include "TestModules/MicSignalHandler/OneKhzTimer/OneKhzTimer.v"
module testbench;
    wire OneKiloHert;
    OneKilohertTimer UUT(clk,OneKiloHert); 
    //Wavetable
    reg clk=0;
    parameter PRD = 100_100;
    always begin
        clk = ~clk; #1;
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        #PRD;
        $finish;     
    end
endmodule