module NBitMuxTB();
reg sel;
reg [7:0] d1;
reg [7:0] d2;
wire [7:0] q;


NBitMux #(8) MUX( .D0(d1), .D1(d2),  .sel(sel), .Y(q));

initial begin 

d1 = 8'b00000001 ;
d2 = 8'b00000010 ;
sel = 1'b1;
#3
sel = 1'b0;
#3

$finish;
end
endmodule
