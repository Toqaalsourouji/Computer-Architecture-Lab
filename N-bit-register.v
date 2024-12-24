module NBitRegister #(N=12)(input clk, input rst, input load, input [N-1:0] D, output[N-1:0] Q);


wire [N-1:0] out;

genvar i;
generate 

for ( i = 0 ; i < N ; i = i + 1) begin

Mux2X1 MUX ( .in1(D[i]), .in2(Q[i]), .select(load),  .out(out[i]));
DFlipFlop DFF ( .clk(clk),  .rst(rst),  .D(out[i]),  .Q(Q[i]));

end
endgenerate
endmodule
