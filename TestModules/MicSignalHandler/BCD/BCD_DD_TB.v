`include "TestModules/MicSignalHandler/BCD/BCD_Double_Dabble.v"

module testbench;
    reg [9:0] Hz = 0;
    wire [3:0] Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data;
    BCD_Double_Dabble UUT(Hz,Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data);
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        #10;
        Hz = 1;
        #10;
        Hz = 52;
        #10;
        Hz = 517;
        #10;
        Hz = 1023;
        #10;
        $finish;     
    end
endmodule  
