module DisableHandler(input DisableA,DisableB, output EnableA, EnableB);
    wire Enable;
    assign Enable = ~(DisableA|DisableB);
    assign EnableA = Enable;
    assign EnableB = Enable;
endmodule


