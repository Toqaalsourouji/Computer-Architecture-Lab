module DataMemTB();
reg clk, MemRead, MemWrite;
reg [9:0] addr;
reg [31:0] data_in;
wire [127:0] data_out;
wire ready;

DataMem DUT (clk,  MemRead,  MemWrite,  addr,  data_in, data_out, ready);


initial begin
 clk = 0;
 forever #5 clk = ~clk;  
 end

    
initial begin

MemRead = 0;
MemWrite = 0;
addr = 0;
data_in = 0;
#40;
       
MemWrite = 1;
addr = 10'd5;
data_in = 32'd8;
#40;

MemWrite = 0; 
#40;
    
MemRead = 1;
addr = 10'd3;
#40;

MemRead = 0;
#40;
        
MemRead = 1;
addr = 10'd5;
#40;

MemRead = 0; 
#40;
$stop;

end
endmodule
