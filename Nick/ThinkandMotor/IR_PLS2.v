module IR_PLS2(
    input ir_signal,          
    input clk,                
    output reg [13:0] LED,  
    output reg [1:0] color_detected,
    output reg [6:0] seg,          // SSGD
    output reg [3:0] an            // SSGD anodes (?)
);
    reg [15:0] pulse_count = 0;        
    reg prev_ir;
    reg prev_prev_ir;
    reg [31:0] timer;       
    reg [15:0] frequency; 
    parameter TIME_INTERVAL = 100_000_000; // 1 second for timerr

    // thresholdsssss
    parameter RED_MIN_THRESHOLD = 900;    
    parameter RED_MAX_THRESHOLD = 1100;
    parameter GREEN_MIN_THRESHOLD = 1900;
    parameter GREEN_MAX_THRESHOLD = 2100;
    parameter BLUE_MIN_THRESHOLD = 2900;
    parameter BLUE_MAX_THRESHOLD = 3100;
    
   
    initial begin
        frequency = 0;              
        pulse_count = 0;            
        timer = 0;                  
        color_detected = 2'b10;    
        an = 4'b1110;               //enable the display;p
    end
   
    always @(posedge clk) begin
        prev_prev_ir = prev_ir;  // Store previous two IR states
        prev_ir = ir_signal;

        // Count rising edges only when the IR signal has a positive transition
        if (prev_ir && ~prev_prev_ir) begin
            pulse_count = pulse_count + 1;
        end
    // Timer and frequency calculation AND color detection
        if (timer < TIME_INTERVAL) begin
            timer <= timer + 1;
        end else begin
            frequency = pulse_count; // REMEMBER: Frequency is the count of pulses within the time interval
            //LED = frequency;
            pulse_count = 0;        
            timer = 0;              

            // Color detection based on frequency range
            if (frequency >= RED_MIN_THRESHOLD && frequency <= RED_MAX_THRESHOLD) begin
                color_detected <= 2'b00; // Red
            end else if (frequency >= GREEN_MIN_THRESHOLD && frequency <= GREEN_MAX_THRESHOLD) begin
                color_detected <= 2'b11; // Green
            end else if (frequency >= BLUE_MIN_THRESHOLD && frequency <= BLUE_MAX_THRESHOLD) begin
                color_detected <= 2'b01; // Blue
            end else begin
                color_detected <= 2'b10; // No color detected (idk if this part is really necessary please lmk)
            end
        end
    end

    // SSG display logic depending on the color detected with the brevious block FYI it doesnt really display the letters, it looks weird but it does change with each frequency
    always @(*) begin
        case (color_detected)
            2'b00: seg = 7'b0000110; // Display 'R' for red
            2'b11: seg = 7'b0110000; // Display 'G' for green
            2'b10: seg = 7'b1011011; // Display 'B' for blue
            default: seg = 7'b1111111; // Turn off everything if no color is detected boooo
        endcase
    end
endmodule