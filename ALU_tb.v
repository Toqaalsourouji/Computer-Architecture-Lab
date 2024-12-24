module ALUTB();
reg [7:0] A;
reg [7:0] B;
reg [3:0] sel;
wire [7:0] Y;
wire zeroflag;
ALU  #8 DUT ( A, B ,sel ,Y, zeroflag);

initial begin 

sel = 4'b0010 ; 
A = 7; 
B = 4; 
#5

sel = 4'b0000 ; 
#5 
sel = 4'b0110;
#5 
sel =4'b0001;
#5
sel=4'b1111;
#5
sel=4'b0101;
#5
$finish;
end

endmodule
