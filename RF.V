module  Rf #(parameter N = 32) ( input clk ,rst,write_en,input [4:0] R1, R2, WR, input [N-1:0] WD , output [N:0] RD1, output [N-1:0] RD2);

reg [N-1:0] registers [31:0] ; 
integer i;

assign RD1=registers[R1];
assign RD2=registers[R2];

always @( posedge clk or posedge rst) begin
if (rst==1'b1) begin
for ( i=0; i<32 ;i=i+1) begin 
registers[i]=0;
end
end 
else if(write_en==1'b1) begin
registers[{WR[4],WR[3],WR[2],WR[1],WR[0]}]=WD;
end
end

endmodule
