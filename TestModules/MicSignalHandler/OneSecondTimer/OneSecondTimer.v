/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name:Nicholas Rethans
    Module Name: OneSecondTimer
    Submodule of: HzCalculator
    Dependances: none
    Description: One Second Timer

    Inputs: CLK

    Outputs: OneSecond

    Notes:condition ? value_if_true : value_if_false

*/

module OneSecondTimer(input clk,output reg OneSecond=0);
    reg [25:0] count=0;         //2^26 = 67,108,864 ~= 50,000,000
    always@(posedge(clk)) begin
        if(count==200)begin     //!Board count == 50_000_000! 
            count=0;            //Use half of period (100E6) since using posedge
            OneSecond=~OneSecond;
            count = count + 1;
        end 
        else begin
            count = count + 1;
        end
    end
endmodule
