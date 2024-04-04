/*
    ECE 3331-303 Group 3
    Spring 2024

    Name: Nicholas Rethans
    Module Name: Direction Control
    Submodule of: 
    Dependances: DisableHandler, Motor Encoder, MotorPWM
    Description:
        See Miro Diagram
    Inputs: 

    Outputs: 

    Notes:

*/
`timescale 1 ns / 1 ns
module moore_sf
          (clk,
           reset,
           Enable,
           Direction,
           CountA,
           CountB,
           PAUSE,
           INDUCTANCE,
           FWD_EN_A,
           FWD_EN_B,
           BWD_EN_B,
           Duty_Sel,
           EncoderA_RST,
           EncoderB_RST,
           BWD_EN_A);

  input   clk,reset,Enable,PAUSE,INDUCTANCE;
  input   [3:0] Direction;
  input   [15:0] CountA;
  input   [15:0] CountB;
  output  FWD_EN_A,FWD_EN_B,BWD_EN_A,BWD_EN_B,EncoderA_RST,EncoderB_RST;
  output  [1:0] Duty_Sel;
  wire MotorEncoderA_RST,MotorEncoderB_RST;

  Simple_Moore_Chart u_Simple_Moore_Chart (.clk(clk),
                                           .reset(reset),
                                           .Enable(Enable),
                                           .Direction(Direction),
                                           .MotorEncoderCountA(CountA),
                                           .MotorEncoderCountB(CountB),
                                           .PAUSE(PAUSE),
                                           .INDUCTANCE(INDUCTANCE),
                                           .FWD_EN_A(FWD_EN_A),
                                           .FWD_EN_B(FWD_EN_B),
                                           .BWD_EN_A(BWD_EN_A),
                                           .BWD_EN_B(BWD_EN_B),
                                           .Duty_Sel(Duty_Sel),
                                           .MotorEncoderA_RST(MotorEncoderA_RST),
                                           .MotorEncoderB_RST(MotorEncoderB_RST));
  assign EncoderA_RST = MotorEncoderA_RST;
  assign EncoderB_RST = MotorEncoderB_RST;
endmodule

module Simple_Moore_Chart
          (clk,
           reset,
           Enable,
           Direction,
           MotorEncoderCountA,
           MotorEncoderCountB,
           PAUSE,
           INDUCTANCE,
           FWD_EN_A,
           FWD_EN_B,
           BWD_EN_A,
           BWD_EN_B,
           Duty_Sel,
           MotorEncoderA_RST,
           MotorEncoderB_RST);

  parameter state_type_is_Simple_Moore_Chart_IN_DONE = 6'd0, 
  state_type_is_Simple_Moore_Chart_IN_Forward_Stage1 = 6'd1, 
  state_type_is_Simple_Moore_Chart_IN_Forward_Stage2 = 6'd2, 
  state_type_is_Simple_Moore_Chart_IN_INDUCTANCE = 6'd3, 
  state_type_is_Simple_Moore_Chart_IN_Idle = 6'd4, 
  state_type_is_Simple_Moore_Chart_IN_PAUSE = 6'd5, 
  state_type_is_Simple_Moore_Chart_IN_PAUSE1 = 6'd6, 
  state_type_is_Simple_Moore_Chart_IN_PAUSE10 = 6'd7, 
  state_type_is_Simple_Moore_Chart_IN_PAUSE11 = 6'd8, 
  state_type_is_Simple_Moore_Chart_IN_PAUSE12 = 6'd9, 
  state_type_is_Simple_Moore_Chart_IN_PAUSE13 = 6'd10, 
  state_type_is_Simple_Moore_Chart_IN_PAUSE14 = 6'd11, 
  state_type_is_Simple_Moore_Chart_IN_PAUSE15 = 6'd12, 
  state_type_is_Simple_Moore_Chart_IN_PAUSE2 = 6'd13, 
  state_type_is_Simple_Moore_Chart_IN_PAUSE3 = 6'd14, 
  state_type_is_Simple_Moore_Chart_IN_PAUSE4 = 6'd15, 
  state_type_is_Simple_Moore_Chart_IN_PAUSE5 = 6'd16, 
  state_type_is_Simple_Moore_Chart_IN_PAUSE6 = 6'd17, 
  state_type_is_Simple_Moore_Chart_IN_PAUSE7 = 6'd18, 
  state_type_is_Simple_Moore_Chart_IN_PAUSE8 = 6'd19, 
  state_type_is_Simple_Moore_Chart_IN_PAUSE9 = 6'd20, 
  state_type_is_Simple_Moore_Chart_IN_Turn1125Left = 6'd21, 
  state_type_is_Simple_Moore_Chart_IN_Turn1125Right = 6'd22, 
  state_type_is_Simple_Moore_Chart_IN_Turn225Left = 6'd23, 
  state_type_is_Simple_Moore_Chart_IN_Turn225Right = 6'd24, 
  state_type_is_Simple_Moore_Chart_IN_Turn3375Left = 6'd25, 
  state_type_is_Simple_Moore_Chart_IN_Turn3375Right = 6'd26, 
  state_type_is_Simple_Moore_Chart_IN_Turn45Left = 6'd27, 
  state_type_is_Simple_Moore_Chart_IN_Turn45Right = 6'd28, 
  state_type_is_Simple_Moore_Chart_IN_Turn5625Left = 6'd29, 
  state_type_is_Simple_Moore_Chart_IN_Turn5625Right = 6'd30, 
  state_type_is_Simple_Moore_Chart_IN_Turn675Left = 6'd31, 
  state_type_is_Simple_Moore_Chart_IN_Turn675Right = 6'd32, 
  state_type_is_Simple_Moore_Chart_IN_Turn7875Left = 6'd33, 
  state_type_is_Simple_Moore_Chart_IN_Turn7875Right = 6'd34, 
  state_type_is_Simple_Moore_Chart_IN_Turn90Left = 6'd35, 
  state_type_is_Simple_Moore_Chart_IN_WAIT = 6'd36;

  input   clk,reset,Enable,PAUSE,INDUCTANCE;
  input   [3:0] Direction;
  input   [15:0] MotorEncoderCountA;
  input   [15:0] MotorEncoderCountB; 
  output  MotorEncoderA_RST,MotorEncoderB_RST,FWD_EN_A,FWD_EN_B,BWD_EN_A,BWD_EN_B;
  output  [1:0] Duty_Sel;

  reg FWD_EN_A_1=0,FWD_EN_B_1=0,BWD_EN_A_1=0,BWD_EN_B_1=0;
  reg [1:0] Duty_Sel_1=0;
  reg  MotorEncoderA_RST_1=0,MotorEncoderB_RST_1=0;
  reg [5:0] is_Simple_Moore_Chart=4;
  reg [5:0] is_Simple_Moore_Chart_next;

  always @(posedge clk or posedge reset)
    begin : Simple_Moore_Chart_1_process
      if (reset == 1'b1) begin
        is_Simple_Moore_Chart <= state_type_is_Simple_Moore_Chart_IN_Idle;
      end
      else begin
        is_Simple_Moore_Chart <= is_Simple_Moore_Chart_next;
      end
    end
  always @(Direction, Enable, INDUCTANCE, MotorEncoderCountA, MotorEncoderCountB, PAUSE, is_Simple_Moore_Chart) begin
    is_Simple_Moore_Chart_next = is_Simple_Moore_Chart;
    case ( is_Simple_Moore_Chart)
      state_type_is_Simple_Moore_Chart_IN_DONE : is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Idle;
      state_type_is_Simple_Moore_Chart_IN_Forward_Stage1 :
        begin
          if (PAUSE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_PAUSE8;
          end
          else if ((MotorEncoderCountA >= 16'b0000000000010100) && (MotorEncoderCountB >= 16'b0000000000010100)) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Forward_Stage2;
          end
          else if (INDUCTANCE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_INDUCTANCE;
          end
        end
      state_type_is_Simple_Moore_Chart_IN_Forward_Stage2 : if ((MotorEncoderCountA >= 16'b0000000000010100) && (MotorEncoderCountB >= 16'b0000000000010100)) is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_DONE;
      state_type_is_Simple_Moore_Chart_IN_INDUCTANCE : if ((MotorEncoderCountA >= 16'b0000000000001111) && (MotorEncoderCountB >= 16'b0000000000001111)) is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_DONE;
      default : if ((Enable == 1'b1)) is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_WAIT;
      state_type_is_Simple_Moore_Chart_IN_PAUSE : if (PAUSE == 1'b0) is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn90Left;
      state_type_is_Simple_Moore_Chart_IN_PAUSE1 : if (PAUSE == 1'b0) is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn7875Left;
      state_type_is_Simple_Moore_Chart_IN_PAUSE2 : if (PAUSE == 1'b0) is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn675Left;
      state_type_is_Simple_Moore_Chart_IN_PAUSE3 : if (PAUSE == 1'b0) is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn5625Left;
      state_type_is_Simple_Moore_Chart_IN_PAUSE4 : if (PAUSE == 1'b0) is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn45Left;
      state_type_is_Simple_Moore_Chart_IN_PAUSE5 : if (PAUSE == 1'b0) is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn3375Left;
      state_type_is_Simple_Moore_Chart_IN_PAUSE6 : if (PAUSE == 1'b0) is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn225Left;
      state_type_is_Simple_Moore_Chart_IN_PAUSE7 : if (PAUSE == 1'b0) is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn1125Left;
      state_type_is_Simple_Moore_Chart_IN_PAUSE8 : if (PAUSE == 1'b0) is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Forward_Stage1;
      state_type_is_Simple_Moore_Chart_IN_PAUSE9 : if (PAUSE == 1'b0) is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn1125Right;
      state_type_is_Simple_Moore_Chart_IN_PAUSE10 : if (PAUSE == 1'b0) is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn225Right;
      state_type_is_Simple_Moore_Chart_IN_PAUSE11 : if (PAUSE == 1'b0) is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn3375Right;
      state_type_is_Simple_Moore_Chart_IN_PAUSE12 : if (PAUSE == 1'b0) is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn45Right;
      state_type_is_Simple_Moore_Chart_IN_PAUSE13 : if (PAUSE == 1'b0) is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn5625Right;
      state_type_is_Simple_Moore_Chart_IN_PAUSE14 : if (PAUSE == 1'b0) is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn675Right;
      state_type_is_Simple_Moore_Chart_IN_PAUSE15 : if (PAUSE == 1'b0) is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn7875Right;
      state_type_is_Simple_Moore_Chart_IN_Turn1125Left :
        begin
          if (PAUSE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_PAUSE7;
          end
          else if (MotorEncoderCountA >= 16'b0000000000000010) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Forward_Stage2;
          end
          else if (INDUCTANCE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_INDUCTANCE;
          end
        end
      state_type_is_Simple_Moore_Chart_IN_Turn1125Right :
        begin
          if (PAUSE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_PAUSE9;
          end
          else if (MotorEncoderCountB >= 16'b0000000000000010) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Forward_Stage2;
          end
          else if (INDUCTANCE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_INDUCTANCE;
          end
        end
      state_type_is_Simple_Moore_Chart_IN_Turn225Left :
        begin
          if (PAUSE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_PAUSE6;
          end
          else if (MotorEncoderCountA >= 16'b0000000000000100) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Forward_Stage2;
          end
          else if (INDUCTANCE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_INDUCTANCE;
          end
        end
      state_type_is_Simple_Moore_Chart_IN_Turn225Right :
        begin
          if (PAUSE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_PAUSE10;
          end
          else if (MotorEncoderCountB >= 16'b0000000000000100) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Forward_Stage2;
          end
          else if (INDUCTANCE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_INDUCTANCE;
          end
        end
      state_type_is_Simple_Moore_Chart_IN_Turn3375Left :
        begin
          if (PAUSE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_PAUSE5;
          end
          else if (MotorEncoderCountA >= 16'b0000000000000110) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Forward_Stage2;
          end
          else if (INDUCTANCE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_INDUCTANCE;
          end
        end
      state_type_is_Simple_Moore_Chart_IN_Turn3375Right :
        begin
          if (PAUSE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_PAUSE11;
          end
          else if (MotorEncoderCountB >= 16'b0000000000000110) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Forward_Stage2;
          end
          else if (INDUCTANCE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_INDUCTANCE;
          end
        end
      state_type_is_Simple_Moore_Chart_IN_Turn45Left :
        begin
          if (PAUSE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_PAUSE4;
          end
          else if (MotorEncoderCountA >= 16'b0000000000001000) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Forward_Stage2;
          end
          else if (INDUCTANCE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_INDUCTANCE;
          end
        end
      state_type_is_Simple_Moore_Chart_IN_Turn45Right :
        begin
          if (PAUSE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_PAUSE12;
          end
          else if (MotorEncoderCountB >= 16'b0000000000001000) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Forward_Stage2;
          end
          else if (INDUCTANCE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_INDUCTANCE;
          end
        end
      state_type_is_Simple_Moore_Chart_IN_Turn5625Left :
        begin
          if (PAUSE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_PAUSE3;
          end
          else if (MotorEncoderCountA >= 16'b0000000000001010) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Forward_Stage2;
          end
          else if (INDUCTANCE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_INDUCTANCE;
          end
        end
      state_type_is_Simple_Moore_Chart_IN_Turn5625Right :
        begin
          if (PAUSE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_PAUSE13;
          end
          else if (MotorEncoderCountB >= 16'b0000000000001010) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Forward_Stage2;
          end
          else if (INDUCTANCE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_INDUCTANCE;
          end
        end
      state_type_is_Simple_Moore_Chart_IN_Turn675Left :
        begin
          if (PAUSE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_PAUSE2;
          end
          else if (MotorEncoderCountA >= 16'b0000000000001100) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Forward_Stage2;
          end
          else if (INDUCTANCE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_INDUCTANCE;
          end
        end
      state_type_is_Simple_Moore_Chart_IN_Turn675Right :
        begin
          if (PAUSE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_PAUSE14;
          end
          else if (MotorEncoderCountB >= 16'b0000000000001100) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Forward_Stage2;
          end
          else if (INDUCTANCE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_INDUCTANCE;
          end
        end
      state_type_is_Simple_Moore_Chart_IN_Turn7875Left :
        begin
          if (PAUSE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_PAUSE1;
          end
          else if (MotorEncoderCountA >= 16'b0000000000001110) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Forward_Stage2;
          end
          else if (INDUCTANCE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_INDUCTANCE;
          end
        end
      state_type_is_Simple_Moore_Chart_IN_Turn7875Right :
        begin
          if (PAUSE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_PAUSE15;
          end
          else if (MotorEncoderCountB >= 16'b0000000000001110) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Forward_Stage2;
          end
          else if (INDUCTANCE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_INDUCTANCE;
          end
        end
      state_type_is_Simple_Moore_Chart_IN_Turn90Left :
        begin
          if (PAUSE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_PAUSE;
          end
          else if (MotorEncoderCountA >= 16'b0000000000010000) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Forward_Stage2;
          end
          else if (INDUCTANCE == 1'b1) begin
            is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_INDUCTANCE;
          end
        end
      state_type_is_Simple_Moore_Chart_IN_WAIT :
        begin
          case (Direction)
            4'b0000: is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn90Left;
            4'b0001: is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn7875Left;
            4'b0010: is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn675Left;
            4'b0011: is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn5625Left;
            4'b0100: is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn45Left;
            4'b0101: is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn3375Left;
            4'b0110: is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn225Left;
            4'b0111: is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn1125Left;
            4'b1000: is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Forward_Stage1;
            4'b1001: is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn1125Right;
            4'b1010: is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn225Right;
            4'b1011: is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn3375Right;
            4'b1100: is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn45Right;
            4'b1101: is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn5625Right;
            4'b1110: is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn675Right;
            4'b1111: is_Simple_Moore_Chart_next = state_type_is_Simple_Moore_Chart_IN_Turn7875Right;
          endcase
        end
    endcase
  end
  always @(is_Simple_Moore_Chart) begin
    FWD_EN_A_1 = 1'b0;
    FWD_EN_B_1 = 1'b0;
    BWD_EN_A_1 = 1'b0;
    BWD_EN_B_1 = 1'b0;
    Duty_Sel_1 = 2'b00;
    MotorEncoderA_RST_1 = 1'b0;
    MotorEncoderB_RST_1 = 1'b0;
    case ( is_Simple_Moore_Chart)
      state_type_is_Simple_Moore_Chart_IN_DONE : begin
        end
      state_type_is_Simple_Moore_Chart_IN_Forward_Stage1 :
        begin
          FWD_EN_A_1 = 1'b1;
          FWD_EN_B_1 = 1'b1;
        end
      state_type_is_Simple_Moore_Chart_IN_Forward_Stage2 :
        begin
          Duty_Sel_1 = 2'b11;
          FWD_EN_A_1 = 1'b1;
          FWD_EN_B_1 = 1'b1;
          MotorEncoderA_RST_1 = 1'b1;
          MotorEncoderB_RST_1 = 1'b1;
        end
      state_type_is_Simple_Moore_Chart_IN_INDUCTANCE :
        begin
          MotorEncoderA_RST_1 = 1'b1;
          MotorEncoderB_RST_1 = 1'b1;
          FWD_EN_A_1 = 1'b0;
          FWD_EN_B_1 = 1'b0;
          BWD_EN_A_1 = 1'b1;
          BWD_EN_B_1 = 1'b1;
        end
      state_type_is_Simple_Moore_Chart_IN_Turn1125Left :
        begin
          FWD_EN_A_1 = 1'b1;
        end
      state_type_is_Simple_Moore_Chart_IN_Turn1125Right :
        begin
          FWD_EN_B_1 = 1'b1;
        end
      state_type_is_Simple_Moore_Chart_IN_Turn225Left :
        begin
          FWD_EN_A_1 = 1'b1;
        end
      state_type_is_Simple_Moore_Chart_IN_Turn225Right :
        begin
          FWD_EN_B_1 = 1'b1;
        end
      state_type_is_Simple_Moore_Chart_IN_Turn3375Left :
        begin
          FWD_EN_A_1 = 1'b1;
        end
      state_type_is_Simple_Moore_Chart_IN_Turn3375Right :
        begin
          FWD_EN_B_1 = 1'b1;
        end
      state_type_is_Simple_Moore_Chart_IN_Turn45Left :
        begin
          FWD_EN_A_1 = 1'b1;
        end
      state_type_is_Simple_Moore_Chart_IN_Turn45Right :
        begin
          FWD_EN_B_1 = 1'b1;
        end
      state_type_is_Simple_Moore_Chart_IN_Turn5625Left :
        begin
          FWD_EN_A_1 = 1'b1;
        end
      state_type_is_Simple_Moore_Chart_IN_Turn5625Right :
        begin
          FWD_EN_B_1 = 1'b1;
        end
      state_type_is_Simple_Moore_Chart_IN_Turn675Left :
        begin
          FWD_EN_A_1 = 1'b1;
        end
      state_type_is_Simple_Moore_Chart_IN_Turn675Right :
        begin
          FWD_EN_B_1 = 1'b1;
        end
      state_type_is_Simple_Moore_Chart_IN_Turn7875Left :
        begin
          FWD_EN_A_1 = 1'b1;
        end
      state_type_is_Simple_Moore_Chart_IN_Turn7875Right :
        begin
          FWD_EN_B_1 = 1'b1;
        end
      state_type_is_Simple_Moore_Chart_IN_Turn90Left :
        begin
          FWD_EN_A_1 = 1'b1;
        end
      default :
        begin
          MotorEncoderA_RST_1 = 1'b1;
          MotorEncoderB_RST_1 = 1'b1;
          FWD_EN_A_1 = 1'b0;
          FWD_EN_B_1 = 1'b0;
        end
    endcase
  end
  assign FWD_EN_A = FWD_EN_A_1;
  assign FWD_EN_B = FWD_EN_B_1;
  assign BWD_EN_A = BWD_EN_A_1;
  assign BWD_EN_B = BWD_EN_B_1;
  assign Duty_Sel = Duty_Sel_1;
  assign MotorEncoderA_RST = MotorEncoderA_RST_1;
  assign MotorEncoderB_RST = MotorEncoderB_RST_1;
endmodule