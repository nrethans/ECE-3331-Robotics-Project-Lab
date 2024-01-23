`define assert(actual, expected) \
    $display("Time: "); write($realtime); \
    if(actual == expected) \
        $display("-- Test Passed --"); \
    else \
        $display("-- Test Failed --"); \
