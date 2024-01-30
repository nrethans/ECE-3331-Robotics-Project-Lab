`include "TestModules/MicSignalHandler/MicSignalHandlerTop/MSH_VSCODE.v"

module testbench;
    reg JA1=0;
    wire [3:0] Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data;
    MicSignalHandlerTop UUT(clk,JA1,Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data); 
    //Wavetable
    reg clk=0;
    always begin
        clk = ~clk; #1; 
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        #100;
        for(integer i = 0; i<246; i=i+1) begin //Hz Counter only detects posedge
            JA1 = ~JA1; #1;                 //So the output value should be half the
        end                                 //for loop limit.
        #292;
        $finish;     
    end
endmodule