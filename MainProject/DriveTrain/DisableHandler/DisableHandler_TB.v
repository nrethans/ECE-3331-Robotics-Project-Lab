`include "/Users/nicholasrethans/Documents/GitHub/ECE-3331-Robotics-Project-Lab/MainProject/DriveTrain/DisableHandler/DisableHandler.v"
module testbench;
    reg DisableA=0, DisableB=0;
    wire EnableA, EnableB;
    DisableHandler UUT(DisableA,DisableB,EnableA, EnableB); 
    //Wavetable
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, testbench);
            #5;
            {DisableA,DisableB} = 2'b01; #5;
            {DisableA,DisableB} = 2'b10; #5;
            {DisableA,DisableB} = 2'b11; #5;
        $finish;     
    end
endmodule