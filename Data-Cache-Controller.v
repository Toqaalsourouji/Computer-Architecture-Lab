module DataCacheController (
input clk, input rst,
input MemRead,
input MemWrite,
input [4:0] index,
input [2:0] tag,
output reg stall,
output reg fill,
output reg update,
output reg MsRead,
input MsReady
);

reg [2:0] tags [0:31];
reg valid_bits [0:31];
reg [2:0] state;
reg [2:0] next_state;


wire write_miss; 

assign write_miss = ((valid_bits[index]!=1)||(tag!=tags[index]));

parameter idle = 0, read = 1, write = 2;

integer i;

always@(posedge clk, posedge rst)begin

    if(rst)begin
    next_state <=idle;
    for(i=0; i<32; i=i+1)begin
    valid_bits[i]=0;
    tags[i]=3'd0;
    end
    
    end
    else
    state <= next_state; 
    end

always@(posedge clk) begin 
case(state)

idle: begin 
// stall=0;
 if(MemRead)begin
    if((write_miss))begin
    stall=1;
    MsRead=1;
    next_state = read;
    fill=0;
    update=0;
    end
  else begin
  next_state = idle;
    stall=0;
    update=0;
    MsRead = 0;
    fill=0;
  end
 end
 
 else if(MemWrite)
  if((write_miss==1))begin
    stall=1;
    next_state = write;
    fill=0;
    update=0;
    end
   else if(!write_miss)begin
   update=1;
   stall=1;
   next_state=write;
    fill=0;
   end 
    else begin
    next_state = idle;
    stall=0;
    update=0;
    fill=0;
    end
    end 
    
write: begin 
    if(!MsReady) begin
    next_state= write;
    stall=1;
    fill=0;
    update=0;
   end
  else begin
  next_state= idle;
   stall=0;
   fill=0;
   update=0;
   end
   end 
   
read: begin
   if(!MsReady) begin
   next_state= read;
    fill=0;
    update=0;
    stall=1;
    end
    else begin
    fill=1;
    stall=0;
    valid_bits[index]=1;
    tags[index]=tag;
    next_state = idle; 
    update=0;
  end
 end
 
default: next_state = idle;
 
endcase

end
    

endmodule
