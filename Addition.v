module Addition(
input [7:0] A , B,
input clk, 
output [3:0] Anode,
output [6:0] LED_out
);

wire cout;
wire [7:0] out;
RCA  #8 DUT  ( A, B, 0, out, cout );
Segments DUT2 ( clk, out , Anode, LED_out );

endmodule
