`include "TestModules/MiniProjectTop.v"
`include "Assert.v"
module testbench;
    reg JA1=0;
    wire [3:0] cathodes;
    wire [7:0] anodes;
    reg clk = 0;
    always begin
        clk=~clk; #1;
    end
    MiniProjectTop UUT(clk, JA1, cathodes, anodes);
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        //#400 window for each "second"
        #10;
        for(integer i = 0; i<246; i=i+1) begin 
            JA1 = ~JA1; #1;                 
        end      
        #154; 
        #300;
        $finish;  
    end
endmodule