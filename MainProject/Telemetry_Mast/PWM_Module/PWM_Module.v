`timescale 1ns/1ns
/*
    ECE 3331-303 Group 3
    Spring 2024

    Name: Samir Hossain
    Module Name: Sweeper_Control_Module
    Submodule of: Telemetry_Mast_Control
    Dependances: Sweeper_Control_Module
    Description: See Miro Diagram
    Inputs: clk, [3:0] angle
    Outputs: servo

    Notes:  1) Main Code for Vivado, working
            2) Main Code for tb, working
            3) For testing with switches, working
            4) Same code with state machines, almost working
            5) Better for Ratchting Servo, problems controlling speed most likely logic error
*/


/////////////////////////// 1) Main Code for Vivado, working///////////////////////////////////
module Servo_PWM_Generator(input clk, input [3:0] angle, output servo);

    // Constants
    parameter PERIOD = 1000000; // 20 ms period

    // Registers
    reg [19:0] counter = 0;
    reg [19:0] control = 50000;
    reg [1:0] state = 2'b00; // Initial state
    reg [3:0] max_control_selector = 4'b0000;

    // Output
    reg servo_reg = 0;

    always @(posedge clk)
    begin
        counter <= counter + 1;
         // Update control based on angle
          case(angle)
              4'b0000:
                  control <= 50000;
              4'b0001:
                  control <= 62500;
              4'b0010:
                  control <= 75000;
              4'b0011:
                  control <= 87500;
              4'b0100:
                  control <= 100000;
              4'b0101:
                  control <= 112500;
              4'b0110:
                  control <= 125000;
              4'b0111:
                  control <= 137500;
              4'b1000:
                  control <= 150000;
              4'b1001:
                  control <= 162500;
              4'b1010:
                  control <= 175000;
              4'b1011:
                  control <= 187500;
              4'b1100:
                  control <= 200000;
              4'b1101:
                  control <= 212500;
              4'b1110:
                  control <= 225000;
              4'b1111:
                  control <= 237500;
              default:
                  control <= 50000;
          endcase    
        if (counter == 0)
        begin
            servo_reg <= 1;
        end
        else if (counter - control == 0)
        begin
            servo_reg <= 0;
        end
        else if (counter == PERIOD)
        begin   
            counter <= 0; // Transition back to idle state
        end
    end
    assign servo = servo_reg;
endmodule



////////////////////////////////////// 2) Main Code for tb, working ////////////////////////////////////
// module Servo_PWM_Generator(input clk, input [3:0] angle, output servo);

//     // Constants
//     parameter PERIOD = 10000; // 20 ms period -------> 10000 for tb should be 1000000

//     // Registers
//     reg [19:0] counter = 0;
//     reg [19:0] control = 500; // ---------> 500 for tb should be 50000
//     reg [1:0] state = 2'b00; // Initial state
//     reg [3:0] max_control_selector = 4'b0000;

//     // Output
//     reg servo_reg = 0;

//     always @(posedge clk)
//     begin
//         counter <= counter + 1;
//          // Update control based on angle
//           case(angle)
//               4'b0000:
//                   control <= 500; // ---------> 500 for tb should be 50000
//               4'b0001:
//                   control <= 625; // ---------> 625 for tb should be 62500
//               4'b0010:
//                   control <= 750; // ---------> 750 for tb should be 75000
//               4'b0011:
//                   control <= 875; // ---------> 875 for tb should be 87500
//               4'b0100:
//                   control <= 1000; // ---------> 1000 for tb should be 100000
//               4'b0101:
//                   control <= 1125; // ---------> 1125 for tb should be 112500
//               4'b0110:
//                   control <= 1250; // ---------> 1250 for tb should be 125000
//               4'b0111:
//                   control <= 1375; // ---------> 1375 for tb should be 137500
//               4'b1000:
//                   control <= 1500; // ---------> 1500 for tb should be 150000
//               4'b1001:
//                   control <= 1625; // ---------> 1625 for tb should be 162500
//               4'b1010:
//                   control <= 1750; // ---------> 1750 for tb should be 175000
//               4'b1011:
//                   control <= 1875; // ---------> 1875 for tb should be 187500
//               4'b1100:
//                   control <= 2000; // ---------> 2000 for tb should be 200000
//               4'b1101:
//                   control <= 2125; // ---------> 2125 for tb should be 212500
//               4'b1110:
//                   control <= 2250; // ---------> 2250 for tb should be 225000
//               4'b1111:
//                   control <= 2375; // ---------> 2375 for tb should be 237500
//               default: 
//                   control <= 500; // ---------> 500 for tb should be 50000
//           endcase    
//         if (counter == 0)
//         begin
//             servo_reg <= 1;
//         end
//         else if (counter - control == 0)
//         begin
//             servo_reg <= 0;
//         end
//         else if (counter == PERIOD)
//         begin   
//             counter <= 0; // Transition back to idle state
//         end
//     end
//     assign servo = servo_reg;
// endmodule


///////////////////////// 3) For testing with switches, working //////////////////////////////
// module Servo_PWM_Generator(input clk, input [15:0] switch, output servo);

//     // Constants
//     parameter PERIOD = 1000000; // 20 ms period
//     parameter MAX_CONTROL = 30; // Adjust this value for 180 degrees
//     parameter SWEEP_INCREMENT = 10; // Increment value for sweeping

//     // Registers
//     reg [20:0] counter = 0;
//     reg [31:0] control = 50000;
//     reg [1:0] state = 2'b00; // Initial state
//     reg [3:0] max_control_selector = 4'b0000;

//     // Output
//     reg servo_reg = 0;

//     always @(posedge clk)
//     begin
//         counter <= counter + 1;
// /////////////////////////////////////////////////////////            
//          // max_control_selector
//           if(switch[0])
//               max_control_selector <= 4'b0000;
//           else if(switch[1])
//               max_control_selector <= 4'b0001;
//           else if(switch[2])
//               max_control_selector <= 4'b0010;
//           else if(switch[3])
//               max_control_selector <= 4'b0011;
//           else if(switch[4])
//               max_control_selector <= 4'b0100;
//           else if(switch[5])
//               max_control_selector <= 4'b0101;
//           else if(switch[6])
//               max_control_selector <= 4'b0110;
//           else if(switch[7])
//               max_control_selector <= 4'b0111;
//           else if(switch[8])
//               max_control_selector <= 4'b1000;            
//           else if(switch[9])
//               max_control_selector <= 4'b1001;
//           else if(switch[10])
//               max_control_selector <= 4'b1010;
//           else if(switch[11])
//               max_control_selector <= 4'b1011;
//           else if(switch[12])
//               max_control_selector <= 4'b1100;
//           else if(switch[13])
//               max_control_selector <= 4'b1101;
//           else if(switch[14])
//               max_control_selector <= 4'b1110;
//           else if(switch[15])
//               max_control_selector <= 4'b1111;
//           else
//               max_control_selector <= 4'b0000;
// /////////////////////////////////////////////////////////            
//          // Update control based on max_control_selector
//           case(max_control_selector)
//               4'b0000:
//                   control <= 50000;
//               4'b0001:
//                   control <= 62500;
//               4'b0010:
//                   control <= 75000;
//               4'b0011:
//                   control <= 87500;
//               4'b0100:
//                   control <= 100000;
//               4'b0101:
//                   control <= 112500;
//               4'b0110:
//                   control <= 125000;
//               4'b0111:
//                   control <= 137500;
//               4'b1000:
//                   control <= 150000;
//               4'b1001:
//                   control <= 162500;
//               4'b1010:
//                   control <= 175000;
//               4'b1011:
//                   control <= 187500;
//               4'b1100:
//                   control <= 200000;
//               4'b1101:
//                   control <= 212500;
//               4'b1110:
//                   control <= 225000;
//               4'b1111:
//                   control <= 237500;
//               default:
//                   control <= 50000;
//           endcase    
//         if (counter == 0)
//         begin
//             servo_reg <= 1;
//         end
//         else if (counter - control == 0)
//         begin
//             servo_reg <= 0;
//         end
//         else if (counter == PERIOD)
//         begin   
//             counter <= 0; // Transition back to idle state
//         end
//     end
//     assign servo = servo_reg;
// endmodule

//////////////////////////////// 4) Same code with state machines, almost working //////////////////////////////
// module Servo_PWM_Generator(input clk, input [15:0] switch, output servo);

//     // Constants
//     parameter PERIOD = 10000000; // 20 ms period
//     parameter MAX_CONTROL = 30; // Adjust this value for 180 degrees
//     parameter SWEEP_INCREMENT = 10; // Increment value for sweeping

//     // Registers
//     reg [20:0] counter = 0;
//     reg [31:0] control = 250;
//     reg [1:0] state = 2'b00; // Initial state
//     reg [3:0] max_control_selector = 4'b0000;

//     // Output
//     reg servo_reg = 0;

//     always @(posedge clk)
//     begin
//         // Counter logic
//         counter <= counter + 1;
        // if (counter == PERIOD - 1)
        //     counter <= 0;
        // Servo control logic
        // if (counter < control)
        //     servo_reg <= 1;
        // else
        //     servo_reg <= 0;
/////////////////////////////////////////////////////////            
         // max_control_selector
        //  if(switch[0])
        //      max_control_selector <= 4'b0000;
        //  else if(switch[1])
        //      max_control_selector <= 4'b0001;
        //  else if(switch[2])
        //      max_control_selector <= 4'b0010;
        //  else if(switch[3])
        //      max_control_selector <= 4'b0011;
        //  else if(switch[4])
        //      max_control_selector <= 4'b0100;
        //  else if(switch[5])
        //      max_control_selector <= 4'b0101;
        //  else if(switch[6])
        //      max_control_selector <= 4'b0110;
        //  else if(switch[7])
        //      max_control_selector <= 4'b0111;
        //  else if(switch[8])
        //      max_control_selector <= 4'b1000;            
        //  else if(switch[9])
        //      max_control_selector <= 4'b1001;
        //  else if(switch[10])
        //      max_control_selector <= 4'b1010;
        //  else if(switch[11])
        //      max_control_selector <= 4'b1011;
        //  else if(switch[12])
        //      max_control_selector <= 4'b1100;
        //  else if(switch[13])
        //      max_control_selector <= 4'b1101;
        //  else if(switch[14])
        //      max_control_selector <= 4'b1110;
        //  else if(switch[15])
        //      max_control_selector <= 4'b1111;
        //  else
        //      max_control_selector <= 4'b0000;
/////////////////////////////////////////////////////////            
         // Update control based on max_control_selector
        //  case(max_control_selector)
        //      4'b0000:
        //          control <= 500;
        //      4'b0001:
        //          control <= 625;
        //      4'b0010:
        //          control <= 750;
        //      4'b0011:
        //          control <= 875;
        //      4'b0100:
        //          control <= 1000;
        //      4'b0101:
        //          control <= 1125;
        //      4'b0110:
        //          control <= 1250;
        //      4'b0111:
        //          control <= 1375;
        //      4'b1000:
        //          control <= 1500;
        //      4'b1001:
        //          control <= 1625;
        //      4'b1010:
        //          control <= 1750;
        //      4'b1011:
        //          control <= 1875;
        //      4'b1100:
        //          control <= 2000;
        //      4'b1101:
        //          control <= 2125;
        //      4'b1110:
        //          control <= 2250;
        //      4'b1111:
        //          control <= 2375;
        //      default:
        //          control <= 500;
        //  endcase    
        
        // State machine
//         case(state)
//             2'b00: // Idle state
//                 begin
//                     // if (counter == 0)
//                     // begin
//                         servo_reg <= 1; // Reset control to 0
//                         state <= 2'b01; // Transition to sweeping state                        
//                     // end
//                 end
//             2'b01: // Sweeping state
//                 begin
//                     if (counter == 500000)
//                     begin
//                         servo_reg <= 0;
//                     end
//                     else if (counter == PERIOD)
//                     begin   
//                         state <= 2'b00;
//                         counter <= 0; // Transition back to idle state
//                     end
//                 end
//         endcase
//     end
//     assign servo = servo_reg;
// endmodule


///////////////// 5) Better for Ratchting Servo, problems controlling speed most likely logic error /////////////////
// module Servo_PWM_Generator(
//     input clk,
//     output servo);

//     // Constants
//     parameter PERIOD = 2000000; // 20 ms period
//     parameter MAX_CONTROL = 260000; // Adjust this value for 180 degrees
//     parameter SWEEP_INCREMENT = 1000; // Increment value for sweeping

//     // Registers
//     reg [20:0] counter = 0;
//     reg [20:0] control = 0;
//     reg [1:0] state = 2'b00; // Initial state

//     // Output
//     reg servo_reg = 0;

//     always @(posedge clk)
//     begin
//         // Counter logic
//         counter <= counter + 1;
//         if (counter == PERIOD - 1)
//             counter <= 0;

//         // Servo control logic
//         if (counter < control)
//             servo_reg <= 1;
//         else
//             servo_reg <= 0;

//         // State machine
//         case(state)
//             2'b00: // Idle state
//                 begin
//                     if (counter == 0)
//                     begin
//                         control <= 0; // Reset control to 0
//                         state <= 2'b01; // Transition to sweeping state
//                     end
//                 end
//             2'b01: // Sweeping state
//                 begin
//                     if (counter == 0)
//                     begin
//                         if (control + SWEEP_INCREMENT >= MAX_CONTROL)
//                         begin
//                             control <= 0; // Reset control to 0 when reaching or exceeding maximum
//                             state <= 2'b00; // Transition back to idle state
//                         end
//                         else
//                             control <= control + SWEEP_INCREMENT; // Increment control for sweeping
//                     end
//                 end
//         endcase
//     end
//     assign servo = servo_reg;
// endmodule
