`include "PWM_Module.v"
`timescale 1ns/1ns

module testbench;
    reg [3:0] angle = 0; //initialize inputs as registers
    wire servo; //intialize outputs as wires

    Servo_PWM_Generator UUT(
        .clk(clk),
        .angle(angle),
        .servo(servo)
    ); 

    // Clock generation
    reg clk=0;
    always begin
        clk = ~clk; #1;
    end

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
        #20000;
        angle = 4'b0100;
        #20000;
        angle = 4'b1011;
        #20000;
        angle = 4'b1111;
        #20000;
    end
endmodule
