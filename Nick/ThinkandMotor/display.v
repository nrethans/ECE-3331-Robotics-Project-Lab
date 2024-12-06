module display(
    input clk, rst,
    input [13:0] number,
    output reg [3:0] an,
    output reg [6:0] seg
    );
    
    parameter PERIOD = 1_666_666;
    parameter TEST_TICK   = 10_000;
    
    // define internal signals
    reg [20:0] refresh_counter;
    wire [3:0] digits[3:0];
    wire [6:0] segs[3:0];

    // initialize reg values
    initial begin 
        {seg,refresh_counter} <= 0; 
        an <= 4'hF; // active low signals should be brought high on reset/init
        end

    // submodule instantiations
    segmentDriver dig0(digits[0], segs[0]);
    segmentDriver dig1(digits[1], segs[1]);
    segmentDriver dig2(digits[2], segs[2]);
    segmentDriver dig3(digits[3], segs[3]);

    // combinational logic
    assign digits[0] = number          % 10; // Not the optimal method for binary -> decimal coversion
    assign digits[1] = (number / 10)   % 10; // division is an expension silicon operation.
    assign digits[2] = (number / 100)  % 10; // For a more logic-efficient design, look into Binary-Coded Decimal
    assign digits[3] = (number / 1000) % 10; // and BCD verilog design

    always @(*) begin
        if (rst) begin
            an = 4'hF;
            seg = 0;
        end
        case(refresh_counter[20:19])
            2'b00: begin an = 4'b1110; seg = segs[0]; end
            2'b01: begin an = 4'b1101; seg = segs[1]; end
            2'b10: begin an = 4'b1011; seg = segs[2]; end
            2'b11: begin an = 4'b0111; seg = segs[3]; end
        endcase
    end

    // sequential logic
    always @(posedge clk) begin
        if (rst) begin
            
            refresh_counter <= 0;
        end
        else begin
            if (refresh_counter == PERIOD) begin // simulate with TEST, replace with PERIOD
                refresh_counter = 0;
            end
            else begin
                refresh_counter = refresh_counter + 1; // simulate with TEST, replace with 1
            end
        end
    end

endmodule

module segmentDriver(
    input [3:0] digit,
    output reg [6:0] seg
    );
    always @(*) begin
        case(digit)
                             // seg abcdefg
            0:       begin seg = 7'b0000001; end
            1:       begin seg = 7'b1001111; end
            2:       begin seg = 7'b0010010; end
            3:       begin seg = 7'b0000110; end
            4:       begin seg = 7'b1001100; end
            5:       begin seg = 7'b0100100; end
            6:       begin seg = 7'b0100000; end
            7:       begin seg = 7'b0001111; end
            8:       begin seg = 7'b0000000; end
            9:       begin seg = 7'b0000100; end
            default: begin seg = 7'b1111111; end
        endcase
    end
endmodule
