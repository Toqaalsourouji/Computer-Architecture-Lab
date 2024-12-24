module CUTB();
reg [4:0] ints;
wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;  
wire [1:0] ALUOp;
CU DUT(ints, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,  ALUOp);
initial begin 
ints=5'b00000;
#5 
ints=5'b01100;
#5 
ints=5'b11000;
#5 
ints=5'b01000;
#5 
$finish;
end 
endmodule
