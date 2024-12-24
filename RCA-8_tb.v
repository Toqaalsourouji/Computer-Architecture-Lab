module tb();

reg [7:0] a, b;
reg clk;
wire [6:0] seg;

RCA_8 DUT(a, b, clk, seg);

initial begin
clk = 0;
forever #5 clk = ~clk;
end

initial begin
a = 1;
b = 0;
#10;
a = 2;
b = 0;
#10
$finish;
end
endmodule
