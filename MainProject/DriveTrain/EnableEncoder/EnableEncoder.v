/*
    ECE 3331-303 Group 3
    Spring 2024
    
    Name: Nicholas Rethans
    Module Name: EnableEncoder
    Submodule of: DriveTrainControl
    Dependances: none
    Description: Encodes the Enable signals from Drive Train Control with the SNSA and SNSB Input.

    Inputs: SW[1:0] (enable signal from DriveTrainControl)

    Outputs: EnableA, EnableB

    Notes:

*/
module EnableEncoder(input [1:0] sw, input SNSA, SNSB, clk);
    always @(posedge clk) begin
        if(SNSA|SNSB)begin
            {EnableA,EnableB} <= 2'b00; 
        end
        else begin
            case({sw[1],sw[0]})
                2'b00: begin
                    {EnableA,EnableB} <= 2'b00; 
                end
                2'b01: begin
                    {EnableA,EnableB} <= 2'b10; 
                end
                2'b10: begin
                    {EnableA,EnableB} <= 2'b01; 
                end
                2'b11: begin
                    {EnableA,EnableB} <= 2'b11; 
                end
            endcase
        end
    end
endmodule