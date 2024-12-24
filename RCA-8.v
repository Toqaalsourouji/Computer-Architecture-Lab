module RCA_8(
input [7:0] a , b, 
input  clk ,
output [6:0] led, output [3:0] anode );

wire [7:0] sum;
wire cout;

RCA #8 Dut  (a, b, 0, sum, cout);
sevensegment D ( clk, {4'b0000, cout, sum} ,anode, led);

endmodule
