`define assert(actual, expected, description) \
    if(description) $display(description); \
    $write("Time: "); $display($realtime); \
    if(actual == expected) \
        $display("-- Test Passed --"); \
    else \
        $display("-- Test Failed --"); \
