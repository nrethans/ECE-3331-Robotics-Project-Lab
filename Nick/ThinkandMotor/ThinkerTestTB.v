`include "ThinkandMotor/ThinkerTest.v"

module testbench;

    reg clk = 0;
    reg rst = 0;
    reg ThinkerStart = 0;
    reg ColorSignal = 0;
    reg ir_signal = 0;
    reg BoxDetect = 0;
    reg Button = 0;
    wire s2;
    wire s3;
    reg [2:0] sensor_input = 0;
    wire [15:0] LED;
    wire [3:0] an;
    wire [6:0] seg;
    wire ENAL;
    wire ENAR;
    wire LIN1;
    wire LIN2;
    wire RIN1;
    wire RIN2;

    ThinkerTest dut (
        .clk(clk),
        .rst(rst),
        .ThinkerStart(ThinkerStart),
        .ColorSignal(ColorSignal),
        .ir_signal(ir_signal),
        .BoxDetect(BoxDetect),
        .Button(Button),
        .s2(s2),
        .s3(s3),
        .sensor_input(sensor_input),
        .LED(LED),
        .an(an),
        .seg(seg),
        .ENAL(ENAL),
        .ENAR(ENAR),
        .LIN1(LIN1),
        .LIN2(LIN2),
        .RIN1(RIN1),
        .RIN2(RIN2)
    );

    always begin
        #5 clk = ~clk;
    end

    initial begin
        $dumpfile("testbench.vcd");
        $dumpvars(0, testbench);
        // clk = 0;
        // rst = 0;
        // ThinkerStart = 0;
        // ColorSignal = 0;
        // ir_signal = 0;
        // BoxDetect = 0;
        // Button = 0;
        // sensor_input = 0;
        // #10 rst = 1;
        // #10 rst = 0;
        // #10 ThinkerStart = 1;
        // #10 ThinkerStart = 0;
        // #10 ColorSignal = 1;
        // #10 ColorSignal = 0;
        // #10 ir_signal = 1;
        // #10 ir_signal = 0;
        // #10 BoxDetect = 1;
        // #10 BoxDetect = 0;
        // #10 Button = 1;
        // #10 Button = 0;
        // #10 sensor_input = 1;
        // #10 sensor_input = 0;
        #10;
        $finish;
    end

endmodule