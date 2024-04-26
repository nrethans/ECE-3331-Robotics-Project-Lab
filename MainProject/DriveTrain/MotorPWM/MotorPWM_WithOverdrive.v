module MotorPWM(input clk, input [1:0] DutyCycle, output reg PulseSignal=1'b0);
    reg [13:0] count = 14'b0;
    reg [25:0] OneSecond = 25'b0;

    parameter FortyDuty = 14'd5000,
               HalfDuty = 14'd6250,
             EightyDuty = 14'd10000,
             FivePercent = 14'd625; 

    parameter StaticForty = 2'b00,
             DynamicForty = 2'b01,
            DynamicEighty = 2'b10,
               StaticFull = 2'b11;

    reg [1:0] STATE = 2'b00, Overdrive_Level = 2'b00;

    always @(posedge clk) begin //25K timer
        if(count >= 14'd12500)begin                                    
            count = 14'b0;
            count = count + 1'b1;
        end
        else begin
            count = count + 1'b1;
        end 
    end
    always @(posedge clk) begin //1s timer
        if(OneSecond >= 26'd50_000_000)begin
            if(Overdrive_Level != 2'b11) Overdrive_Level = Overdrive_Level+1;                                
            OneSecond = 25'b0;
            OneSecond = OneSecond + 1'b1;
        end
        else begin
            OneSecond = OneSecond + 1'b1;
        end 
    end

    always @(posedge clk or DutyCycle) begin
        case(STATE)
            StaticForty: begin
                if(DutyCycle==DynamicForty) begin
                    OneSecond<=25'b0;
                    Overdrive_Level <= 2'b00;
                    STATE<=DynamicForty;
                end
                else if(DutyCycle==DynamicEighty) begin
                    OneSecond<=25'b0;
                    Overdrive_Level <= 2'b00;
                    STATE<=DynamicEighty;
                end
                else if(DutyCycle==StaticFull) STATE = StaticFull;
            end
            DynamicForty: begin
                if(DutyCycle==StaticForty) begin
                    STATE<=StaticForty;
                end
                else if(DutyCycle==DynamicEighty) begin
                    OneSecond<=25'b0;
                    Overdrive_Level <= 2'b00;
                    STATE<=DynamicEighty;
                end
                else if(DutyCycle==StaticFull) STATE = StaticFull;
            end
            DynamicEighty: begin
                if(DutyCycle==StaticForty) begin
                    STATE<=StaticForty;
                end
                else if(DutyCycle==DynamicForty) begin
                    OneSecond<=25'b0;
                    Overdrive_Level <= 2'b00;
                    STATE<=DynamicForty;
                end
                else if(DutyCycle==StaticFull) STATE = StaticFull;
            end
            StaticFull: begin 
                if(DutyCycle==StaticForty) begin
                    STATE<=StaticForty;
                end
                else if(DutyCycle==DynamicForty) begin
                    OneSecond<=25'b0;
                    Overdrive_Level <= 2'b00;
                    STATE<=DynamicForty;
                end
                else if(DutyCycle==DynamicEighty) begin
                    OneSecond<=25'b0;
                    Overdrive_Level <= 2'b00;
                    STATE<=DynamicEighty;
                end
            end
        endcase
        case(STATE)
            StaticForty: begin
                if(count<=FortyDuty) PulseSignal = 1'b1;
                else PulseSignal = 1'b0;
            end
            DynamicForty: begin
                case(Overdrive_Level)
                    2'b00: begin
                        if(count<=FortyDuty) PulseSignal = 1'b1;
                        else PulseSignal = 1'b0;
                    end
                    2'b01: begin
                        if(count<=(FortyDuty-FivePercent)) PulseSignal = 1'b1;
                        else PulseSignal = 1'b0;
                    end
                    2'b10: begin
                        if(count<=(FortyDuty-(FivePercent*2))) PulseSignal = 1'b1;
                        else PulseSignal = 1'b0;
                    end
                    2'b11: begin
                        if(count<=(FortyDuty-(FivePercent*3))) PulseSignal = 1'b1;
                        else PulseSignal = 1'b0;
                    end
                endcase
            end
            DynamicEighty: begin
                case(Overdrive_Level)
                    2'b00: begin
                        if(count<=EightyDuty) PulseSignal = 1'b1;
                        else PulseSignal = 1'b0;
                    end
                    2'b01: begin
                        if(count<=(EightyDuty+FivePercent)) PulseSignal = 1'b1;
                        else PulseSignal = 1'b0;
                    end
                    2'b10: begin
                        if(count<=(EightyDuty+(FivePercent*2))) PulseSignal = 1'b1;
                        else PulseSignal = 1'b0;
                    end
                    2'b11: begin
                        if(count<=(EightyDuty+(FivePercent*3))) PulseSignal = 1'b1;
                        else PulseSignal = 1'b0;
                    end
                endcase
            end
            StaticFull: PulseSignal = 1'b1;
            default: PulseSignal = 1'b0;
        endcase
    end
endmodule 