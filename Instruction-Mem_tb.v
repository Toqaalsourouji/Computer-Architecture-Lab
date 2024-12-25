module InstructionMemTB();

reg [5:0] addr;
wire [31:0] data_out;

InstructionMem DUT(addr, data_out);

initial begin
addr=6'b000000; 
#5
addr=6'b000001; 
#5
addr=6'b000010; 
#5 
addr=6'b000011; 
#5 
addr=6'b000100; 
#5 
$finish;

end 
endmodule
