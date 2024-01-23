`include "TestModules/MicSignalHandler/BCD/BCD.v"
module testbench;
    reg [9:0] Hz;
    wire [3:0] Thousands_Data, Hundreds_Data, Tens_Data, Ones_Data;
    BCD_Converter UUT(Hz, Thousands_Data, Hundreds_Data, Tens_Data, Ones_Data); 

    initial begin
        $display("Hz    Thousands   Hundreds    Tens    Ones");
        $display("------------------------------------------"); 
        $monitor("%b %d | %d | %d | %d | %d |",Hz, Hz, Thousands_Data,Hundreds_Data,Tens_Data,Ones_Data);
        for (integer i=0; i<1024; i=i+1) begin
            {Hz}=i[9:0]; #1;
        end
    end
endmodule