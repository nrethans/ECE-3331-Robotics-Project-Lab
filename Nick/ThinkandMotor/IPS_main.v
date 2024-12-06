module IPS_Main(
    input clk,
    input signalL,  // Left signal
    input signalM,  // Middle signal
    input signalR,  // Right signal
    output reg LED6,
    output reg LED7,
    output reg LED8
);

    always @(posedge clk) begin
        LED6 = ~signalL;  // LED6 Left signal
        LED7 = ~signalM;  // LED7 Middle signal
        LED8 = ~signalR;  // LED8 Right signal
    end
endmodule