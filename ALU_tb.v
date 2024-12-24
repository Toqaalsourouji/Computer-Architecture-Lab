module ALUCU( input [1:0] ALUop, input [2:0] Inst1, input Inst2, output reg [3:0] ALUSelection);

always @(*) begin 
case(ALUop)

2'b00:begin 
ALUSelection = 4'b0010;
end 

2'b01:begin 
ALUSelection = 4'b0110;
end 

2'b10:begin 
if(Inst1 == 3'b000) begin
    if(Inst2==1'b0)
ALUSelection = 4'b0010;
    else ALUSelection = 4'b0110;
end 
else if(Inst1 == 3'b111)
    ALUSelection = 4'b0000;
else if(Inst1 == 3'b110)
ALUSelection = 4'b0001;

end 
endcase 
end 
endmodule

