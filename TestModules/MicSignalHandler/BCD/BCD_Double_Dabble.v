/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Nicholas Rethans
    Module Name: BCD_Double_Dabble.v
    Submodule of: MicSignalHandler
    Dependances: HzCounter
    Description: Binary coded decimal coverter using
    the double dabble algorithm

    Inputs: Hz - 10 bits
            clk (100Mhz, internal clk)

    Outputs: Thousands_Data, Hundreds_Data, Tens_Data, Ones_Data, 4 bits

    Notes:
*/

module BCD_Double_Dabble(input [9:0] Hz, output reg [3:0] Thousands_Data=0, Hundreds_Data=0, Tens_Data=0, Ones_Data=0);
    reg [25:0] bin=0;
    //reg load=0;
    always @(Hz) begin
        bin=0;
        bin[9:0]=Hz; 
        //bin vals = [9:0]
        //BCD1s = [13:10], BCD10s = [17:14], BCD100s = [21:18], BCD1000s = [25:22]
        for(integer i=0; i<10;i=i+1)begin
            if(bin[13:10]>=5) bin[13:10] = bin[13:10] + 3;
            if(bin[17:14]>=5) bin[17:14] = bin[17:14] + 3;
            if(bin[21:18]>=5) bin[21:18] = bin[21:18] + 3;
            if(bin[25:22]>=5) bin[25:22] = bin[25:22] + 3;
            bin = bin<<1;
        end
        Ones_Data <= bin[13:10];
        Tens_Data <= bin[17:14];
        Hundreds_Data <= bin[21:18];
        Thousands_Data <= bin[25:22];
    end
endmodule