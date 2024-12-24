module Shift1TB();
reg [4:0] in;
wire [4:0] out;
Shift1 #(5) sh(.in(in),.out(out));
initial begin
in=4'b0000;
#5
in=4'b0010;
#5 
in=4'b0100;
$finish;
end 
endmodule
