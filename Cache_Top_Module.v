module Cache_Top_Module(input clk, rst,
input MemRead,
input MemWrite,
input [9:0] addr,
input [31:0] data_in,
output [31:0] dataout,
output stall
);
wire update, fill, MsRead, MsReady;
wire [2:0] tag;
wire [4:0] index;
wire [1:0] offset; 

assign tag = addr [9:7];
assign index = addr [6:2];
assign offest = addr [1:0];


wire [127:0] data_out;     
    
DataMem datamem (clk,  MsRead,  MemWrite,  addr,  data_in, data_out, MsReady);   
    
Data_Cache_Mem cachmem( clk, update, fill, offset, index, data_in, data_out, dataout);

DataCacheController cachecontrol( clk, rst, MemRead, MemWrite ,index, tag, stall, fill, update, MsRead, MsReady); 


endmodule
