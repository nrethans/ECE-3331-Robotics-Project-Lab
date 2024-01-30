`include "TestModules/MicSignalHandler/HzCounter/HzCounter.v"

module testbench;
    reg JA1=0,OneSecond=0;
    wire [9:0] Hz;
    HzCounter UUT(JA1,OneSecond,clk,Hz); 
    //Wavetable
    reg clk=0;
    always begin
        clk = ~clk; #1;
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        #10;
        for(integer i=0;i<30;i=i+1)begin
            JA1=~JA1; #4;
        end
        #10;
        OneSecond=1;
        #10;
        $finish;     
    end
endmodule