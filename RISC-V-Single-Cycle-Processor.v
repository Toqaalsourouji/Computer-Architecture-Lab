module RISC_V (input clk, ssdclk, reset, load, input [1:0] ledSel, input [3:0] ssdSel, output reg [15:0] leds, output  [3:0] Anode , output  [6:0] LED_out );

wire [31:0] ALU_in2;
wire [31:0] memdata_out;
wire [31:0] DMux_out; // output of last mux 
wire [31:0] data_out;
wire [31:0] pc_out;
wire [31:0] gen_out;
wire [1:0] ALUOp ;
wire Branch, MemRead, MemtoReg , MemWrite, ALUSrc, RegWrite, zeroflag;
wire [31:0] RD1, RD2;
wire [3:0] ALUSelection;
wire [31:0] Alu_out;
wire [31:0] shift_out;
wire [31:0] adder1_out, adder2_out;
wire and_out; 
wire [31:0] AMux_out; // and gate mux
reg [12:0] ssd;
wire BranchANDGate; 

 PC #32 pc( clk,  reset, 1, AMux_out,  pc_out);
 
 InstructionMem InstMem (pc_out/4, data_out); 
 
 ImmGen immgen (data_out, gen_out);
 
 CU cu (data_out [6:2],  Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp) ;
 
 RF rf ( clk , reset, RegWrite, data_out[19:15], data_out[24:20], data_out[11:7],  DMux_out ,  RD1,  RD2);
 

 
NBitMux #32 RF_Mux ( RD2,  gen_out, ALUSrc,  ALU_in2);

 
 ALU_CU alcu (ALUOp,  data_out[14:12],  data_out[30],  ALUSelection);
  
 ALU #32 alu ( RD1, ALU_in2,  ALUSelection , Alu_out,  zeroflag);
 
 DataMem datamem ( clk, MemRead ,MemWrite , Alu_out/4, RD2 , memdata_out);
 

 
NBitMux #32 Mem_Mux ( Alu_out, memdata_out  , MemtoReg,  DMux_out);
 
Shift1  #32 shift (gen_out, shift_out);

RCA #32 adder1_target (pc_out, shift_out, 0, adder1_out, target);

RCA #32 adder2_pc (pc_out, 4, 0, adder2_out, pc_4);

Four_Digit_Seven_Segment_Driver sevenseg (ssdclk, ssd, Anode, LED_out);


assign and_out = Branch & zeroflag;



NBitMux #32 Pc_Mux ( adder2_out,  adder1_out, and_out,  AMux_out);

always @ (*) begin 
if ( ledSel == 2'b00 ) begin 
 leds = data_out [15 : 0]; 
 end
else if ( ledSel == 2'b01 ) begin 
 leds = data_out [31 : 16];
 end
else if ( ledSel == 2'b10 ) begin 
  leds = {2'b00 ,Branch , MemRead , MemtoReg , MemWrite , ALUSrc , RegWrite , ALUOp , ALUSelection , zeroflag , and_out };
end 
else begin 
leds = 0;
end
end

always @ (*) begin

case (ssdSel) 

    4'b0000 : ssd = pc_out;
    4'b0001 : ssd = pc_4;
    4'b0010 : ssd = target;
    4'b0011 : ssd = AMux_out;
    4'b0100 : ssd = data_out[19:15];
    4'b0101 : ssd = data_out[24:20];
    4'b0110 : ssd = DMux_out;
    4'b0111 : ssd = gen_out;
    4'b1000 : ssd = shift_out;
    4'b1001 : ssd = Alu_out/4;
    4'b1010 : ssd = Alu_out;
    4'b1011 : ssd = memdata_out;
    default: ssd=0;
endcase
end



endmodule
