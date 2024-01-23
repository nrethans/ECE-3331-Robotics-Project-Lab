`include "TestModules/Display/DigitDecoder/DigitDecoder.v"

module testbench;
    reg [3:0] data=0;
    wire [7:0] segments;
    reg clk=0;
    Digit_Decoder UUT(data,segments); 
    //Wavetable
    parameter PRD = 2;
    always#(PRD/2) begin
        clk = ~clk; 
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        #PRD;
        for (integer i=0; i<12; i=i+1)begin
            data = i; #PRD;
        end
        $finish;     
    end
endmodule