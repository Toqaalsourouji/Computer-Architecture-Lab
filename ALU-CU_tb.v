module ALUCUTB();

reg [1:0] ALUop;
reg [2:0] Inst1;
reg Inst2;
wire [3:0] ALUSelection;

ALUCU DUT( ALUop,  Inst1,  Inst2, ALUSelection);

initial begin 
ALUop = 2'b00;
Inst1 = 3;
Inst2 = 0;
#5
ALUop = 2'b01;
#5 
ALUop = 2'b10;
Inst1=3'b000;
Inst2=1'b0;
#5 
ALUop = 2'b10;
Inst1=3'b000;
Inst2=1'b1;
#5  
ALUop = 2'b10;
Inst1=3'b111;
Inst2=1'b0;
#5 
ALUop = 2'b10;
Inst1=3'b110;
Inst2=1'b0;
#5 
$finish;
end
endmodule
