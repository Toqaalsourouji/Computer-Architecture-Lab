module DataCacheController_tb();

reg clk;
reg rst;
reg MemRead;
reg MemWrite;
reg [4:0] index;
reg [2:0] tag;
wire stall;
wire fill;
wire update;

reg MsReady;

wire MsRead;


DataCacheController cont (clk,rst,MemRead,MemWrite,index,tag, stall,fill,update,MsRead,MsReady);

initial begin
    clk<=0;
    forever begin
    #(5) 
    clk=~clk;
    end
end 

initial begin

rst=1;
#40 

rst=0;  
MsReady=0;
MemRead=0;
MemWrite=1;
index=5'd0;
tag=2'd3;
#40 
MemWrite=0;
MsReady=1;
#40 
MsReady=0;
MemRead=1;
MemWrite=0;
index=5'd0;
tag=2'd3;
#10

MemRead=0;
MsReady=1;

#40
MemRead=1;
index=5'd0;
tag=2'd3;

#10

MemRead=0;
MsReady=1;

#40 
MsReady=0;
MemRead=0;
MemWrite=1;
index=5'd0;
tag=2'd3;
#10 
MemRead=0;
MemWrite=0;

end
endmodule
