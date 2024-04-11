`include "MainProject/KickerSolinoid/Kicker.v"
module testbench;
    reg Enable = 1'b0;
    wire Kick, Done;
    Kicker UUT(clk, Enable, Kick, Done); 
    //Wavetable
    reg clk=0;
    parameter PRD = 2;
    always#(PRD/2) begin
        clk = ~clk; 
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
            #10;
            Enable=1;
            #25;
        $finish;     
    end
endmodule