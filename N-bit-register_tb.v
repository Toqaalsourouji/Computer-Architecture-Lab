module NBitRegisterTB ();
reg clock;
reg reset ;
reg [3:0] d;
wire [3:0] q;
reg l;

NBitRegister #(4) DUT (.clk(clock) , .rst(reset),.load(l), .D(d), .Q(q));

localparam period = 10;


initial begin 

clock = 1'b0;
forever #(period / 2) clock  = ~ clock ;
end

initial begin 
l=1'b0;
d=4'b1111;
reset = 1'b1;

#( period * 4 )

reset = 1'b0;
l=1'b1;
d=4'b1111;
#( period * 4 )


if ( d == q ) begin

$display ("YAY");
end 

else  begin
