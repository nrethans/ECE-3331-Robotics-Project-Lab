//ColorController
parameter CONTROL_START       = 0,
          CONTROL_CLEAR       = 1,
          CONTROL_CHECK_CLEAR = 2,
          CONTROL_RED         = 3,
          CONTROL_CHECK_RED   = 4,
          CONTROL_BLUE        = 5,
          CONTROL_CHECK_BLUE  = 6,
          CONTROL_GREEN       = 7,
          CONTROL_CHECK_GREEN = 8,
          CONTROL_FOUND       = 9,
          CONTROL_DONE        = 10;
//ColorController
parameter FQ_Red   = 0,
          FQ_Blue  = 1,
          FQ_Clear = 2,
          FQ_Green = 3;
//Frequency Counter
parameter FMM_PERIOD = 1_562_500,
          FMM_TEST   = 15_625,
          FMM_SAT    = 6_250;
//Frequency Counter
parameter FMM_IDLE = 0,
          FMM_GO   = 1;
//ColorDecision
parameter [12:0]RED_THRESHOLD =  55000/ 64, //BELOW GREATEST RED, ABOVE GREATEST RED OF OTHER PAPERS.
          BLUE_THRESHOLD = 80000 / 64,
          CLEAR_THRESHOLD = 85000 / 64, //LOWEST OF ALL
          CLEAR_UPPER_THRESHOLD = 250000 /64, //HIGHEST OF ALL
          GREEN_THRESHOLD = 60000 / 64,
          GREEN_NOTRED_THRESHOLD = 25000/64;

parameter   DRIVE_Straight      = 0, //Wiggle
            DRIVE_InterStraight = 1, //Continue wiggle
            DRIVE_InterRight    = 2, //Sharp Right @ intersection
            DRIVE_InterLeft     = 3, //Sharp Left @ intersection
            DRIVE_Reverse       = 4, //Reverse for 1s
            DRIVE_180           = 5, //Rover rotates 180
            DRIVE_STOP          = 6, //Motors no go
            CLAW_Neutral        = 7, //Stays at position
            CLAW_RAISE          = 8, //Elevator raise
            CLAW_DROP           = 9, //Elevator lower
            CLAW_OPEN           = 10, //Claw open
            CLAW_CLOSE          = 11; //Claw close
            



