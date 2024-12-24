module tb();
reg clk;
reg [7:0] num;
wire  [3:0] Anode;
wire  [6:0] LED_out;
    
    Segments DUT(clk, num, Anode, LED_out);
initial begin clk = 1; forever #5 clk = ~clk; end

initial begin
    num = 7'b0000010;
    

end

endmodule
