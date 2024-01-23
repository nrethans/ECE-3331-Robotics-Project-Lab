`include "TestModules/MicSignalHandler/HzCounter/HzCounter.v"

module testbench;
    reg JA1=0;
    wire [9:0] Hz;
    HzCounter UUT(clk,JA1,Hz); 
    //Wavetable
    reg clk=0;
    always begin
        clk = ~clk; #1;
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        #100;
        #10;
        JA1=1;
        #10;
        JA1=0;
        #10;
        JA1=1;
        #10;
        JA1=0;
        #10;
        JA1=1;
        #10;
        JA1=0;
        #10;
        JA1=1;
        #10;
        JA1=0;
        #10;
        JA1=1;
        #10;
        JA1=0;
        #100;
        $finish;     
    end
endmodule