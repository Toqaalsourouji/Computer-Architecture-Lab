module REGTB();
reg clk,rst,write_en;
reg [4:0] R1,R2,WR;
reg[3:0] WD;
wire [3:0] RD1,RD2;
Rf #4 DUT (  clk ,rst,write_en,  R1, R2, WR, WD , RD1, RD2);
initial begin 
clk=0; 
forever #5 clk=~clk  ;
end 
initial begin 
rst=1'b1;
#10
rst = 0;
R1=5'b01101;
R2=5'b00011 ;
write_en=1'b0; 
WR=5'b00110; 
WD=4'b1101;
#10
rst=1'b0;
write_en=1'b1; 
#10
$finish;
end 
endmodule
