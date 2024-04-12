module DC_Defence(
    input clk,Enable,Pause,Inductance,MicrophoneDirection,
    output reg [1:0] DutyCycleA=2'b00, DutyCycleB=2'b00, 
    output reg FWDA=1'b0,FWDB=1'b0,BWDA=1'b0,BWDB=1'b0,Done=1'b1
);
    parameter IDLE = 3'b000, 
        TURN_RIGHT = 3'b001,
         TURN_LEFT = 3'b010,
       RIGHT_PAUSE = 3'b011,
        LEFT_PAUSE = 3'b100,
        INDUCTANCE = 3'b101,
  INDUCTANCE_PAUSE = 3'b110;
    
    reg [2:0] STATE = 3'b000;
    reg [1:0] Enable_Edge = 2'b00;

    always @(posedge clk) begin
        Enable_Edge[1]=Enable_Edge[0];
        Enable_Edge[0]=Enable;
        case(STATE) //STATE Transitions
            IDLE: STATE = ((~Enable_Edge[1]&Enable_Edge[0]))?(TURN_RIGHT):(IDLE);
            TURN_RIGHT: begin
                    STATE = (Pause)?(RIGHT_PAUSE):(
                        (Inductance)?(INDUCTANCE):(
                            (MicrophoneDirection)?(TURN_RIGHT):(TURN_LEFT)
                        )
                    );
            end
            TURN_LEFT: begin
                    STATE = (Pause)?(LEFT_PAUSE):(
                        (Inductance)?(INDUCTANCE):(
                            (MicrophoneDirection)?(TURN_RIGHT):(TURN_LEFT)
                        )
                    );
            end
            RIGHT_PAUSE: begin
                    STATE = (Pause)?(RIGHT_PAUSE):(
                        (Inductance)?(INDUCTANCE):(TURN_RIGHT)
                    );
            end
            LEFT_PAUSE: begin
                    STATE = (Pause)?(LEFT_PAUSE):(
                        (Inductance)?(INDUCTANCE):(TURN_LEFT)
                    );
            end
            INDUCTANCE: begin
                    STATE = (Pause)?(INDUCTANCE_PAUSE):(
                        (Inductance)?(INDUCTANCE):(IDLE)
                    );
            end
            INDUCTANCE_PAUSE: begin
                    STATE = (Pause)?(INDUCTANCE_PAUSE):(INDUCTANCE);
            end
            default: STATE = IDLE;
        endcase

        case(STATE) //STATE Actions
            IDLE: begin
                {FWDA,FWDB,BWDA,BWDB}=4'b0;
                {DutyCycleA,DutyCycleB}=4'b0;
                Done=1'b1;
            end
            TURN_RIGHT: begin
                {BWDA,BWDB}=2'b00;
                {FWDA,FWDB}=2'b11;
                DutyCycleA=2'b10; //75% duty cycle 
                DutyCycleB=2'b00; //25% duty cycle
                Done=1'b0;
            end
            TURN_LEFT: begin
                {BWDA,BWDB}=2'b00;
                {FWDA,FWDB}=2'b11;
                DutyCycleA=2'b00; //25% duty cycle
                DutyCycleB=2'b10; //75% duty cycle
                Done=1'b0;
            end
            RIGHT_PAUSE: begin
                {FWDA,FWDB,BWDA,BWDB}=4'b0;
                {DutyCycleA,DutyCycleB}=4'b0;
                Done=1'b0;
            end 
            LEFT_PAUSE: begin
                {FWDA,FWDB,BWDA,BWDB}=4'b0;
                {DutyCycleA,DutyCycleB}=4'b0;
                Done=1'b0;
            end
            INDUCTANCE: begin
                {BWDA,BWDB}=2'b11;
                {FWDA,FWDB}=2'b00;
                {DutyCycleA,DutyCycleB}=4'b1111;
                Done=1'b0;
            end
            INDUCTANCE_PAUSE: begin
                {FWDA,FWDB,BWDA,BWDB}=4'b0;
                {DutyCycleA,DutyCycleB}=4'b0;
                Done=1'b0;
            end
        endcase
    end
endmodule