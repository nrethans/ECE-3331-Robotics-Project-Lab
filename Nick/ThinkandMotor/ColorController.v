`include "ThinkandMotor/Defines.v"
module ColorController(
    input clk, isColor, rst, FMMdone,
    input [1:0] ColorIn,
    input [`SigWidth-1:0] FreqIn,
    output reg s2,s3, Go, Done,
    output [1:0] ColorOut1, ColorOut2, ColorOut3,
    output  [`SigWidth-1:0] FreqRed, FreqBlue, FreqClear, FreqGreen
);
    `include "ThinkandMotor/params.v"
    //def internal signal
    reg [1:0] ColorNum;
    reg [3:0] State, NextState;
    reg [1:0] ColorOut [2:0];
    reg [`SigWidth-1:0] Freq [3:0];

    //internal reg
    initial begin 
        {s2, s3, Freq[FQ_Red], Freq[FQ_Blue], Freq[FQ_Clear], Freq[FQ_Green], Go, Done, ColorNum, State, NextState} = 0;
        {ColorOut[2], ColorOut[1], ColorOut[0]} = 6'b101010; // init colors to clear
    end
     

    //combinational logic    
   assign ColorOut1 = ColorOut[0];
   assign ColorOut2 = ColorOut[1];
   assign ColorOut3 = ColorOut[2];

   assign FreqRed = Freq[FQ_Red];
   assign FreqBlue = Freq[FQ_Blue];
   assign FreqClear = Freq[FQ_Clear];
   assign FreqGreen = Freq[FQ_Green];

    always @(*) begin
        case(State)
            CONTROL_START: begin 
                Go = 1;
                NextState = CONTROL_CLEAR;
            end

            CONTROL_CLEAR: begin 
                Go = 0;
                NextState = (FMMdone)? CONTROL_CHECK_CLEAR : CONTROL_CLEAR;
            end

            CONTROL_CHECK_CLEAR: begin 
                Go = 1;
                NextState = (isColor)? CONTROL_GREEN : CONTROL_CLEAR;
            end

            CONTROL_GREEN: begin 
                Go = 0;
                NextState = (FMMdone)? CONTROL_CHECK_GREEN : CONTROL_GREEN;
            end

            CONTROL_CHECK_GREEN: begin 
                case(ColorIn)
                    FQ_Green: begin
                        Go = 0;
                        NextState = CONTROL_FOUND;
                    end
                    default: begin
                        Go = 1;
                        NextState = CONTROL_BLUE;
                    end
                endcase
            end

            CONTROL_BLUE: begin 
                Go = 0;
                NextState = (FMMdone)? CONTROL_CHECK_BLUE : CONTROL_BLUE;
            end

            CONTROL_CHECK_BLUE: begin 
                case(ColorIn)
                    FQ_Blue: begin
                        Go = 0;
                        NextState = CONTROL_FOUND;
                    end
                    default: begin
                        Go = 1;
                        NextState = CONTROL_RED;
                    end
                endcase
            end

            CONTROL_RED: begin 
                Go = 0;
                NextState = (FMMdone)? CONTROL_CHECK_RED : CONTROL_RED;
            end

            CONTROL_CHECK_RED: begin 
                Go = 0;
                NextState = (ColorIn == FQ_Red)? CONTROL_FOUND : CONTROL_START;
            end

            CONTROL_FOUND: begin 
                Go = 0;
                NextState = (ColorNum < 3)? CONTROL_START : CONTROL_DONE; 
            end

            CONTROL_DONE: begin 
                Go = 0;
                NextState = CONTROL_DONE;
            end
            default: begin 
                Go = 0;
                NextState = CONTROL_START;
            end
        endcase
    end

    //sequential logic
    always @(posedge clk) begin
        if (rst) begin
            {s2, s3, Freq[FQ_Red], Freq[FQ_Blue], Freq[FQ_Clear], Freq[FQ_Green], Done, ColorNum, State} = 0; 
            {ColorOut[2], ColorOut[1], ColorOut[0]} = 6'b101010; // init colors to clear
        end
        else begin
            State = NextState;

            case(State)
            CONTROL_START: begin 
                {Freq[FQ_Red], Freq[FQ_Blue], Freq[FQ_Clear], Freq[FQ_Green]} = 0;
            end

            CONTROL_CLEAR: begin 
                {s2,s3} = FQ_Clear;
            end

            CONTROL_CHECK_CLEAR: begin 
                Freq[FQ_Clear] = FreqIn;
            end

            CONTROL_RED: begin 
                {s2,s3} = FQ_Red;
            end

            CONTROL_CHECK_RED: begin 
                Freq[FQ_Red] = FreqIn;
            end

            CONTROL_BLUE: begin 
                {s2,s3} = FQ_Blue;
            end

            CONTROL_CHECK_BLUE: begin 
                Freq[FQ_Blue] = FreqIn;
            end

            CONTROL_GREEN: begin 
                {s2,s3} = FQ_Green;
            end

            CONTROL_CHECK_GREEN: begin 
                Freq[FQ_Green] = FreqIn;
            end

            CONTROL_FOUND: begin 
                case(ColorNum)
                    0:begin 
                        ColorOut[0] = ColorIn;
                        ColorNum = ColorNum +1;
                    end
                    1,2 :begin 
                        if (ColorOut[ColorNum-1] != ColorIn) begin
                            ColorOut[ColorNum] = ColorIn;
                            ColorNum = ColorNum + 1;
                        end
                    end                
                endcase
            end

            CONTROL_DONE: begin 
                Done = 1;
            end
            endcase
        end
    end

endmodule