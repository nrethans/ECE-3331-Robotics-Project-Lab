module IR_Motor_Encoder(input clk, reset, IR_Sense, output reg [5:0] Track_Count=6'b0);
    reg [1:0] EdgeTest=2'b0;
    parameter LOAD = 2'b00, EDGE_CHECK = 2'b01, INCREMENT = 2'b10, SHIFT = 2'b11;
    reg [1:0] STATE=2'b00;
    always @(posedge clk)begin
        if(reset)begin
            Track_Count=6'b0;
            STATE=LOAD;
            EdgeTest=2'b00;
        end
        else begin
            case(STATE)
                LOAD: STATE = EDGE_CHECK;
                EDGE_CHECK: begin
                    if((~EdgeTest[0]&EdgeTest[1])|(EdgeTest[0]&~EdgeTest[1])) STATE=INCREMENT;
                    else STATE = SHIFT;
                end
                INCREMENT: STATE = SHIFT;
                SHIFT: STATE = LOAD;
                default: STATE = EDGE_CHECK;
            endcase
        end
        case(STATE)
            LOAD: EdgeTest[0] = IR_Sense;
            INCREMENT: Track_Count = Track_Count+1;
            SHIFT: EdgeTest[1] = EdgeTest[0];
        endcase
    end
endmodule