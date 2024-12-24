module ShiftTB();

reg [31:0] inst;
wire [31:0] gen_out;

ImmGen GEN (.inst(inst), .gen_out(gen_out));


initial begin 

inst = 32'b00000000010100011010000100000011;
#5 
inst= 32'b00000000010000101010001000100011;
#5 
inst = 32'b00000000010000010000100001100011;
#5
$finish;
end
endmodule
