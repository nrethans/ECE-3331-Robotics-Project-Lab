
module DisableHandler(input [1:0] SnsDisable, input clk, output Enable, output reg Pause=1'b0);
    reg [27:0] Timer=28'b0;                               
    reg HalfPause=1'b0;
    always@(posedge clk) begin
        if(SnsDisable[1]|SnsDisable[0]) {Pause,HalfPause} <= 2'b11;
        if(Pause) Timer <= Timer + 1'b1;
        if(Timer>=28'd150_000_000) begin //1.5 seconds                        
            Timer <= 27'b0;                               
            Pause <= 1'b0;
        end
        if(Timer>=28'd75_000_000) HalfPause <=1'b0; //0.75 seconds
    end
    assign Enable = ~HalfPause;
endmodule