module Cache_Top_Module_TB();

 reg clk, MemRead, MemWrite; 
 reg [9:0] addr;
 reg [31:0] data_in;
 wire [31:0] data_out;
 wire stall;
 reg rst;
    
    localparam period = 10;
    initial begin
    clk = 0;
    forever #(period / 2) clk = ~clk;
    end

Cache_Top_Module Top (.clk(clk), .rst(rst), .MemRead(MemRead), .MemWrite(MemWrite), .addr(addr), .data_in(data_in), .dataout(data_out), .stall(stall));

initial begin
 MemWrite = 0; 
 MemRead = 0;
 addr = 0;
 data_in = 0;
 rst = 1;
 
 #(4*period);
 rst =0;
 
 #(4*period);
              
  #(4*period);
  
  MemWrite = 0; 
 MemRead = 1;
 addr = 0;
 data_in = 32'd5;
              
 #(4*period);
 #(4.5*period);
 MemWrite = 0; 
 MemRead = 0;
 
  #(4*period);
 
 MemWrite = 1;
 MemRead = 0; 
 addr = 2;
 
 #(4*period);
 MemWrite = 0; 
 MemRead = 0;
 
#(4*period);
 
 MemWrite = 1; 
 MemRead = 0;
 addr = 3;
 data_in = 32'd7;
 
#(4*period);
 MemWrite = 0; 
 MemRead = 0;
 
  #(4*period);
 
 MemWrite = 0;
 MemRead = 1; 
 addr = 4;
 
  #(4*period);
 MemWrite = 0; 
 MemRead = 0;
 
 #(4*period);
 
 MemWrite = 1; 
 MemRead = 0;
 addr = 6;
 data_in = 32'd10;
 
  #(4*period);
 MemWrite = 0; 
 MemRead = 0;
 
#(4*period);
 MemWrite = 0;
 MemRead = 1;
 addr = 8;
 
  #(4*period);
 MemWrite = 0; 
 MemRead = 0;
 
  #(4*period);
 MemRead =1;
 addr = 0;
 
 #(12*period);
 
 $finish;
 end

endmodule
