module DataMemTB();
reg clk , MemRead, MemWrite;
reg [5:0] addr;
reg [31:0] data_in; 
wire [31:0] data_out; 

DataMemory DUT ( clk,  MemRead,  MemWrite,  addr,  data_in,  data_out);

initial begin
clk = 0;
forever #5 clk =~ clk ;
end

initial begin
addr = 2; 
MemWrite = 1;
MemRead =0;
data_in = 4;

#10 
addr = 2;
MemWrite = 0;
MemRead = 1; 

#10 
addr = 6;
MemWrite = 1; 
MemRead = 0;
data_in = 2;

#10
addr = 6;
MemWrite = 0;
MemRead = 1;  
#10
$finish;
end
endmodule
