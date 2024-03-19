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
        $dumpfile("wavefor.vcd");
        $dumpvars(0, testbench);
        #10;
        for(integer i=0;i<30;i=i+1)begin
            JA1=~JA1; #5;
        end
        #10;
        OneSecond=1;
        #10;
        JA1=1; #8;
        JA1=0; #4;
        JA1=1; #4;
        JA1=0; #2;
        #20;
        OneSecond=0;
        #20;
        $finish;     
    end
endmodule