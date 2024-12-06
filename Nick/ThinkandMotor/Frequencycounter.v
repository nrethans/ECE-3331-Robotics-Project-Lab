`include "ThinkandMotor/Defines.v"

module Frequencycounter(
    input clk, rst, signal, Go,
    output reg Done,
    output reg[`SigWidth-1:0] frequency
    );
    
    `include "ThinkandMotor/params.v"
    //define any internal signals
    reg State = 0;
    reg[1:0] shiftReg = 0;
    reg[20:0] counter = 0; //count to 1,562,500 cycles then resets
    reg[`SigWidth-1:0] frequency_internal = 0;
    //initialize our registers
    initial begin {frequency, shiftReg, counter, frequency_internal,Done,State} = 0; end
    
    always@(posedge clk) begin
        if(rst)begin
        {frequency, shiftReg, counter, frequency_internal,Done,State} = 0;
           
        end
        case(State)
            FMM_IDLE: begin
                if (Go) begin
                    Done = 0;
                    State = FMM_GO;
                    counter = 0;
                    frequency_internal = 0;
                end
                end
            FMM_GO: begin 
                counter = counter + 1;
            
                if (counter == FMM_PERIOD) begin
                    frequency = frequency_internal;
                    Done = 1;
                    State = FMM_IDLE;
                end
                else begin
                    shiftReg = {shiftReg[0], signal}; 
                    if(shiftReg == 2'b01 &&frequency_internal < FMM_SAT)begin
                        frequency_internal = frequency_internal + 1;
                    end                                 
                end

            end
        endcase
     end
endmodule
