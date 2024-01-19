module testbench;
    reg ;
    wire ;
    <module> UTT(); 
    //Wavetable
    parameter PRD = ;
    always#(PRD/2) begin
        clk = ~clk; 
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);

        $finish;     
    end
    //Print truthtable
    initial begin
        $display(" ");
        $display("-"); 
        $monitor(" ",);
        for (integer i=0; i< ; i=i+1) begin
            {}=i[:0]; #1;
        end
    end
endmodule