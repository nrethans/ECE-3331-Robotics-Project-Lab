module OneKilohertTimer(input clk, output reg OneKiloHert=0);
    reg [15:0] count=0;         //2^16 =  ~= 50,000
    always@(posedge(clk)) begin
        if(count==50)begin     //!Board count == 50_000! 
            count=0;            //Use half of period (100E6) since using posedge
            OneKiloHert=~OneKiloHert;
            count = count + 1;
        end 
        else begin
            count = count + 1;
        end
    end
endmodule