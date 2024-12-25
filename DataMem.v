module DataMem (input clk, input MemRead, input MemWrite, input [9:0] addr, input [31:0] data_in,
output reg [127:0] data_out, output reg ready);
reg [31:0] mem [0:1023];
wire [9:0] bAddr;
assign bAddr = {addr[9:2],2'b00};

always @(posedge clk) begin
ready <= 0;
if (MemWrite) begin
repeat (3) begin

@(posedge clk);
end
mem[addr] <= data_in;
ready <= 1;
end
else if (MemRead) begin
repeat (3) begin
@ (posedge clk);
end
data_out <={mem[bAddr],mem[bAddr+1],mem[bAddr+2],mem[bAddr+3]};
ready <= 1;
end
end
initial begin
mem[0]=32'd17; mem[1]=32'd9; mem[2]=32'd25; mem[3]=32'd17;
mem[4]=32'd0; mem[5]=32'd0; mem[6]=32'd0; mem[7]=32'd0;
mem[8]=32'd0;
end
endmodule
