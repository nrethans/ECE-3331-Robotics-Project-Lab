`include "ThinkandMotor/Defines.v"
module ColorDecision(
    input [`SigWidth-1:0] FQRed, FQBlue, FQClear, FQGreen,
    output reg isColor,
    output reg [1:0] Color
    );
    `include "ThinkandMotor/params.v"
    initial begin {isColor , Color} = 0; end


    always @(*) begin 
        if (FQClear >= CLEAR_THRESHOLD && FQClear < CLEAR_UPPER_THRESHOLD) begin
            isColor = 1;
            Color = (FQGreen >= GREEN_THRESHOLD)? FQ_Green :
                    (FQBlue >= BLUE_THRESHOLD)? FQ_Blue :
                    (FQRed >= RED_THRESHOLD && FQGreen < GREEN_NOTRED_THRESHOLD)? FQ_Red :
                    FQ_Clear;
            
        end else begin    
            isColor = 0;
            Color = FQ_Clear;    
        end

    end
endmodule
