module inverter_tb;
reg signal; 
wire inverted;

inverter DUT (. signal (signal), . inverted(inverted));
initial begin 
    signal=1'b1;
    #10 
    signal=1'b0;
    #10
    $finish;
end
endmodule

