/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Nicholas Rethans
    Module Name: slowclk
    Submodule of: DisplayTop
    Dependances: None
    Description: A counter timer used to slow down the internal clk frequency to ~240hz rate for display

    Inputs: 
        clk_fast
    Outputs:
        clk_slow
    Notes:
        Basys3 board internal clk = 100Mhz
        2^18 = 262,144
        100Mhz/262,144hz = 381.47hz
        4 digits
        381.47hz/4 digits = 95.37hz rate per digit
        
*/
module SlowClk(
    input clk_fast,
    output clk_slow);
    reg [18:0] count = 0;
    always @ (posedge(clk_fast))count <= count+1;
    assign clk_slow = count[18];
endmodule