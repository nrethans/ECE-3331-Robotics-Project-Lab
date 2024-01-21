/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Nicholas Rethans
    Module Name: Input Counter
    Submodule of:
    Dependances: OneSecondTimer
    Description:

    Inputs: 

    Outputs:

    Notes:

*/
module OneSecondTimer(input clk,output reg OneSecond=1);
    reg [27:0] count=0;
    always@(posedge(clk)) begin
        if(count==50)begin
            count=0;
            OneSecond=~OneSecond;
            count = count + 1;
        end 
        else begin
            count <= count + 1;
        end
    end
endmodule
`timescale 1s/1s
module InputCounter(input clk,JA1,output reg [10:0] Hz=0);
    wire OneSecond;
    reg [10:0] count;
    OneSecondTimer U0(clk,OneSecond);
    always@(JA1) count<=count+1;

    always@(OneSecond)begin
        Hz=count;
        count=0;
    end
    //assign Hz = (Onesecond)?(count):();
endmodule

module testbench;
    reg JA1=0;
    wire [10:0] Hz;
    InputCounter UUT(clk,JA1,Hz); 
    //Wavetable
    reg clk=0;
    always begin
        clk = ~clk; #1;
    end
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        #100;
        #10;
        JA1=1;
        #10;
        JA1=0;
        #10;
        JA1=1;
        #10;
        JA1=0;
        #10;
        JA1=1;
        #10;
        JA1=0;
        #10;
        JA1=1;
        #40;
        $finish;     
    end
endmodule