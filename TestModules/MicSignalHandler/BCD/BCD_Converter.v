/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Nicholas Rethans
    Module Name: Binary Coded Decimal Converter
    Submodule of: MicSignalHandler
    Dependances: none
    Description: Converts the HzCounter output from binary to
    binary coded decimal to be displayed on the 4x7 display.

    Inputs: Hz (Hz in binary, cycles per second)

    Outputs: Thousands, Hundreds, Tens, and Ones data in BCD.

    Notes: https://www.google.com/search?q=binary+to+decimal+converter+verilog&sca_esv=600400644&sxsrf=ACQVn0_4vdqOz1QYMdQHevSmU4ke8zkEOQ%3A1705950598098&ei=hr2uZYnHBdumqtsP7aCPyAc&oq=Binary+to+decimal+convert&gs_lp=Egxnd3Mtd2l6LXNlcnAiGUJpbmFyeSB0byBkZWNpbWFsIGNvbnZlcnQqAggAMgoQIxiABBiKBRgnMgsQABiABBiKBRiRAjILEAAYgAQYigUYkQIyCxAAGIAEGIoFGJECMgUQABiABDIFEAAYgAQyBRAAGIAEMgUQABiABDIFEAAYgAQyBRAAGIAESMlHULEhWJhAcAZ4AZABAJgBhQGgAdcNqgEEMjMuMrgBA8gBAPgBAcICChAAGEcY1gQYsAPCAg0QABiABBiKBRhDGLADwgIKEAAYgAQYigUYQ8ICDhAAGIAEGIoFGLEDGIMBwgILEC4YgAQYsQMYgwHCAgsQABiABBixAxiDAcICDRAAGIAEGIoFGEMYsQPCAggQABiABBixA8ICERAAGIAEGIoFGJECGLEDGIMBwgIQEAAYgAQYigUYQxixAxiDAeIDBBgAIEGIBgGQBgo&sclient=gws-wiz-serp&csuir=2&csui=3&mq=How%20to%20convert%20binary%20to%20BCD%20in%20Verilog&mstk=AUtExfDfij5Zr1R-O4r8KRTNP6iyHOUGHhc0RU7sfBDYtHkdsMruXgfLUROd_z8bAJ48je3wHDF_ubJG5aFVrkCarkKDdTDhhCjjeDPU-F2KRfTQZVjvz3aHbaanC3sTn6Pt9XxsbBv-y2zZE6ZWZmIkjQtyPw6mLNiA7xIooWD9LCtxHO6SYbySUpXPLfFmnlc1UEuhFfr1tPR_R5TVzp03GeJsjWLTffTYe20jDiQfaqOfu6p4ZrTPrAvVBOIcao97#vhid=hDyJeiqcyevvMM&vssid=videos-8185bc40

*/

module BCD_Converter(input [9:0] Hz, output reg [3:0] Thousands_Data, 
                    Hundreds_Data, Tens_Data, Ones_Data);
    reg [9:0] temp;
    always@(*)begin //Might have to use always@(clk)
        Thousands_Data = Hz/1000; //Div truncates remainder
        temp = Hz % 1000;         //modulus gives remainder of div
        Hundreds_Data = temp/100; 
        temp = Hz % 100;
        Tens_Data = temp/10;
        Ones_Data = Hz % 10;
    end
endmodule