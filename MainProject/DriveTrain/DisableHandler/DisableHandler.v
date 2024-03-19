

module DisableHandler(input [1:0] Disable, input clk, output [1:0] Enable, output reg Pause=1'b0);
    reg [26:0] Timer=27'b000000000000000000000000000;                               //27'b000000000000000000000000000;
    reg HalfPause=1'b0;
    always@(posedge clk) begin
        if(Disable[1]|Disable[0]) {Pause,HalfPause} <= 2'b11;
        if(Pause) Timer <= Timer + 1'b1;
        if(Timer>=27'b000000000000001110101001100) begin                            //27'b100011110000110100011000000 //75 million //temp 7500
            Timer <= 27'b000000000000000000000000000;                               //27'b000000000000000000000000000 
            Pause <= 1'b0;
        end
        if(Timer>=27'b000000000000000111010100110) HalfPause <=1'b0;                //37,500,000  //temp 3750
    end
    assign Enable[1] = ~HalfPause;
    assign Enable[0] = ~HalfPause;
endmodule