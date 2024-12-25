module DataMemory(input clk, input MemRead, input MemWrite, input [5:0] addr, input [31:0] data_in, output reg [31:0] data_out);
reg [31:0] mem [0:63];


always @ (*) begin 
if (MemRead == 1'b1 ) 
data_out = mem[addr];

end 
always @(posedge clk) begin
    if (MemWrite) 
       mem[addr] = data_in;

end 

endmodule
