
module DisableHandler(input [1:0] SnsDisable, input clk, output reg Enable = 1'b1, output reg Pause = 1'b0);
    reg [27:0] Timer=28'b0;
    reg [1:0] STATE=2'b00;                              
    parameter Idle = 2'b00, 
              Disable = 2'b01,
              Debounce = 2'b10;
    parameter HalfCount=28'd75_000_000, FullCount=28'd150_000_000;
    
    always@(posedge clk)begin
        case(STATE)
            Idle: STATE=(SnsDisable[0]|SnsDisable[1])?(Disable):(Idle);
            Disable: STATE=(Timer>=HalfCount)?(Debounce):(Disable);
            Debounce: STATE=(Timer>=FullCount)?(Idle):(Debounce);
        endcase
        case(STATE)
            Idle: begin
                Enable = 1'b1;
                Pause = 1'b0;
                Timer = 28'b0;
            end
            Disable: begin
                Timer = Timer + 1'b1;
                Enable = 1'b0;
                Pause = 1'b1;  
            end   
            Debounce: begin
                Timer = Timer + 1'b1;
                Enable = 1'b1;
                Pause = 1'b0;
            end
        endcase
    end
endmodule