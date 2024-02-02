`include "/Users/nicholasrethans/Documents/GitHub/ECE-3331-Robotics-Project-Lab/TestModules/MicSignalHandler/MicSignalHandlerTop"

module testbench;
    reg JA1=0;
    wire [3:0] Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data;
    MicSignalHandler UUT(clk,JA1,Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data); 
    //Wavetable
    reg clk=0;
    always begin
        clk = ~clk; #1; 
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        #10;
        for(integer i = 0; i<246; i=i+1) begin //Hz Counter only detects posedge
            JA1 = ~JA1; #4;                 //So the output value should be half the
        end                                 //for loop limit.
        #100;
        $finish;     
    end
endmodule