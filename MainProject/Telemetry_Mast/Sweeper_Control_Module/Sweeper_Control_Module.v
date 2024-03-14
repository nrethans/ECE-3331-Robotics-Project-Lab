`timescale 1ns/1ns
/*
    ECE 3331-303 Group 3
    Spring 2024

    Name: Samir Hossain
    Module Name: Sweeper_Control_Module
    Submodule of: Telemetry_Mast_Control
    Dependances:
    Description: See Miro Diagram
    Inputs: clk, enable, reset
    Outputs: mast_ready, [3:0] angle

    Notes:  1) Enable needs to be on always, working
            2) Enable needs to be on always, For TB, Working
            3) Enable doesn't need to be on always, not fully fixed
*/

////////////////////////////// 1) Enable needs to be on always, working ////////////////////////////////////////////
 module Sweeper_Control_Module(
     input clk, enable, reset, output reg mast_ready = 0, output reg [3:0] angle = 0);

     reg [3:0] angle_counter = 4'b0000; // Angle counter
     reg [1:0] state = 2'b00; // State machine state
     reg [27:0] cycle_counter = 0; // Cycle counter
    
     // State machine to control angle selection and delay
     always @(posedge clk or posedge reset)
     begin
         if (reset | !enable)
         begin
             angle_counter <= 4'b0000; // Reset angle counter
             angle <= 4'b0000;
             state <= 2'b00; // Reset state machine state
             cycle_counter <= 0; // Reset cycle counter
             mast_ready <= 0; // Reset mast_ready
         end
         else if (enable)
         begin
             cycle_counter <= cycle_counter + 1; // Increment cycle counter
             case (state)
                 2'b00: // Idle state
                     begin
                         if (cycle_counter == 50000000)
                         begin
                             state <= 2'b01; // Transition to selecting angle state
                             cycle_counter <= 0; // Reset cycle counter
                             mast_ready <= 1;
                         end
                     end
                 2'b01: // Selecting angle state
                     begin
                         if (cycle_counter == 25000000)
                             if (angle_counter == 4'b1111)
                             begin
                                 angle_counter <= 4'b0000; // Reset angle counter
                                 angle <= angle_counter;
                                 state <= 2'b00; // Transition to selecting mast state
                                 cycle_counter <= 0; // Reset cycle counter
                                 mast_ready = 0;
                             end
                             else
                             begin
                                 mast_ready <= 0;
                                 angle_counter <= angle_counter + 1; // Increment angle counter
                                 angle <= angle_counter;
                                 state <= 2'b00; // Transition to idles state
                                 cycle_counter <= 0; // Reset cycle counter
                             end
                     end
             endcase
         end
         else
         begin
             angle <= 4'b0000;
             mast_ready <= 0;
         end
     end
 endmodule


//////////////////////////// 2) Enable needs to be on always, For TB, Working ///////////////////////////////////////
// module Sweeper_Control_Module(input clk, enable, reset, output reg mast_ready = 0, output reg [3:0] angle = 0);

//      reg [3:0] angle_counter = 4'b0000; // Angle counter
//      reg [1:0] state = 2'b00; // State machine state
//      reg [27:0] cycle_counter = 27'b00000000000000000000000000000000; // Cycle counter
    
//      // State machine to control angle selection and delay
//      always @(posedge clk or posedge reset)
//      begin
//          if (reset | !enable)
//          begin
//              angle_counter <= 4'b0000; // Reset angle counter
//              angle <= 4'b0000;
//              state <= 2'b00; // Reset state machine state
//              cycle_counter <= 0; // Reset cycle counter
//              mast_ready <= 0; // Reset mast_ready
//          end
//          else if (enable)
//          begin
//              cycle_counter <= cycle_counter + 1; // Increment cycle counter
//              case (state)
//                  2'b00: // Idle state
//                      begin
//                          if (cycle_counter == 200) ///////----------> 200 for tb should be 50000000
//                          begin
//                              state <= 2'b01; // Transition to selecting angle state
//                              cycle_counter <= 32'b00000000000000000000000000000000;; // Reset cycle counter
//                              mast_ready <= 1;
//                          end
//                      end
//                  2'b01: // Selecting angle state
//                      begin
//                          if (cycle_counter == 100) /////////----------> 100 for tb should be 25000000
//                              if (angle_counter == 4'b1111)
//                              begin
//                                  angle_counter <= 4'b0000; // Reset angle counter
//                                  angle <= angle_counter;
//                                  state <= 2'b00; // Transition to selecting mast state
//                                  cycle_counter <= 32'b00000000000000000000000000000000;; // Reset cycle counter
//                                  mast_ready = 0;
//                              end
//                              else
//                              begin
//                                  mast_ready <= 0;
//                                  angle_counter <= angle_counter + 1; // Increment angle counter
//                                  angle <= angle_counter;
//                                  state <= 2'b00; // Transition to idles state
//                                  cycle_counter <= 32'b00000000000000000000000000000000;; // Reset cycle counter
//                              end
//                      end
//              endcase
//          end
//          else
//          begin
//              angle <= 4'b0000;
//              mast_ready <= 0;
//          end
//      end
// endmodule


/////////////////// 3) Enable doesn't need to be on always, not fully fixed //////////////////////////
//module Sweeper_Control_Module(input clk, enable, reset, output reg mast_ready, output reg [3:0] angle);

//    reg [3:0] angle_counter = 4'b0000; // Angle counter
//    reg [1:0] state = 2'b00; // State machine state
//    reg [31:0] cycle_counter = 32'b00000000000000000000000000000000; // Cycle counter
//    reg prev_enable = 0; // Previous value of enable
//    reg sweep_status = 0;

//    // State machine to control angle selection and delay
//    always @(posedge clk or posedge reset)
//    begin
//        if (reset)
//        begin
//            angle_counter <= 4'b0000; // Reset angle counter
//            angle <= 4'b0000;
//            state <= 2'b00; // Reset state machine state
//            cycle_counter <= 32'b00000000000000000000000000000000; // Reset cycle counter
//            mast_ready <= 0; // Reset mast_ready
//            prev_enable <= 0; // Reset prev_enable
//            sweep_status <= 0;
//        end
//        else
//        begin
//            // Detect rising edge of enable
//            if (!sweep_status && enable && !prev_enable)
//            begin
//                // Start the cycle only if enable is turned on
//                state <= 2'b01;
//                sweep_status <= 1;
//            end
            
//            prev_enable <= enable;

//            begin
//                cycle_counter <= cycle_counter + 1; // Increment cycle counter

//                case (state)
//                    2'b00: // Idle state
//                        begin
//                            // Stay in idle until enable is turned on
//                            mast_ready <= 0;
//                            if (enable && cycle_counter == 25000000)
//                            begin
//                                state <= 2'b01; // Transition to selecting angle state
//                                cycle_counter <= 0; // Reset cycle counter
//                                mast_ready <= 1;
//                            end
//                            if (!enable && cycle_counter == 50000000)
//                            begin
//                                angle = 0;
//                                cycle_counter <= 0;
//                            end
//                        end
//                    2'b01: // Selecting angle state
//                        begin
//                            if (cycle_counter == 25000000)
//                            begin
//                                if (angle_counter >= 4'b1111)
//                                begin
//                                    angle <= angle_counter;
//                                    angle_counter <= 4'b0000; // Reset angle counter
//                                    state <= 2'b00; // Transition to idle state
//                                    cycle_counter <= 0; // Reset cycle counter
//                                    mast_ready <= 0;
//                                    sweep_status <= 0;
//                                end
//                                else
//                                begin
//                                    mast_ready <= 0;
//                                    angle_counter <= angle_counter + 1; // Increment angle counter
//                                    angle <= angle_counter;
//                                    state <= 2'b10; // Transition to selecting mast state
//                                    cycle_counter <= 0; // Reset cycle counter
//                                end
//                            end
//                        end
//                    2'b10: // Selecting Mast State
//                        begin
//                            if (cycle_counter == 25000000)
//                            begin
//                                state <= 2'b01; // Transition back to selecting angle state
//                                cycle_counter <= 0; // Reset cycle counter
//                                mast_ready <= 1;
//                            end
//                        end
//                endcase
//            end
//        end
//    end
//endmodule