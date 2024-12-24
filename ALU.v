module ALU #(parameter N=4) ( input [N-1:0] A, B, input [3:0] sel ,output reg [N-1:0] Y, output zeroflag);

wire [N-1:0] W; 
wire[N-1:0] RCA_out;

assign W =  sel[2] ? ~B : B;   

RCA #N DUT ( A , W ,sel[2] ,RCA_out);

assign zeroflag =  Y ? 1'b0 : 1'b1;
  
always @(*) begin
if ( sel == 4'b0010 || sel == 4'b0110) begin
Y= RCA_out;
end
else if ( sel == 4'b0000) begin
Y= A&B;
end
else if ( sel == 4'b0001) begin
Y= A|B;
end
else begin 
Y=0;
end
end
endmodule
