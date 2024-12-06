`include "ThinkandMotor/Defines.v"
`include "ThinkandMotor/ColorController.v"
`include "ThinkandMotor/ColorDecision.v"
`include "ThinkandMotor/Frequencycounter.v"
`include "ThinkandMotor/display.v"
module ColorTop(
    input clk, rst, signal,
    output s2, s3, Done,
    //output LED0,//, LED1, LED2, LED3, LED4, LED5, LED6,
    output [1:0] Color1, Color2, Color3,
    output [3:0] an,
    output [6:0] seg       
    );
    `include "ThinkandMotor/params.v"
    
    wire [`SigWidth-1:0] FqIn, FQRed, FQBlue, FQClear, FQGreen;
    wire [1:0] ColorIn;
    wire Color, Go, FMMdone;
    
//    //assigning Done and color outputs to LEDs 
    //assign LED0 = Done;
//    //LEDs 1&2 are the first color
//    assign LED1 = Color1[0];
//    assign LED2 = Color1[1];
//    //LEDs 3&4 are the 2nd color
//    assign LED3 = Color2[0];
//    assign LED4 = Color2[1];
//    //LEDs 5&6 are the 3rd color
//    assign LED5 = Color3[0];
//    assign LED6 = Color3[1];

    ColorController controller1(
        .clk(clk),
        .isColor(Color),
        .rst(rst),
        .FMMdone(FMMdone),
        .ColorIn(ColorIn),
        .FreqIn(FqIn),
        .s2(s2), .s3(s3),
        .Go(Go), .Done(Done),
        .ColorOut1(Color1),
        .ColorOut2(Color2),
        .ColorOut3(Color3),
        .FreqRed(FQRed),
        .FreqBlue(FQBlue),
        .FreqClear(FQClear),
        .FreqGreen(FQGreen)
    );

    ColorDecision decision1(
        .FQRed(FQRed),
        .FQBlue(FQBlue),
        .FQClear(FQClear),
        .FQGreen(FQGreen),
        .isColor(Color),
        .Color(ColorIn)
    );

    Frequencycounter FMM(
        .clk(clk),
        .rst(rst),
        .signal(signal),
        .Go(Go),
        .Done(FMMdone),
        .frequency(FqIn)
    );


    // Debug Info - Drive Display module with FqIn. Update ever 1 Hz ish
    reg [26:0] timer = 0;
    reg [13:0] number = 0;

    always @(posedge clk) begin
        timer = timer +1;
        if (timer == 100_000_000) begin
            number = FqIn; 
            timer = 0;
        end

    end

    display Display(
        .clk(clk), .rst(rst),
        .number(number),
        .an(an), .seg(seg)
    );

    // _Debug Info
    
    
endmodule
