module RISCV_Pipeline (input clk, ssdclk, reset, load, input [1:0] ledSel, input [3:0] ssdSel, output reg [15:0] leds, output  [3:0] Anode , output  [6:0] LED_out );

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
wire [31:0] IF_ID_PC, IF_ID_Inst;
wire [31:0] ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm;
wire [31:0] ID_EX_Rs1, ID_EX_Rs2; // to handle forwarding later 
wire [3:0] ID_EX_Func;
wire [4:0] ID_EX_Rd;
wire ID_Branch, ID_MemRead, ID_MemtoReg, ID_MemWrite, ID_ALUsrc, ID_RegWrite;
wire [1:0] ID_ALUop;
wire EX_Branch, EX_MemRead, EX_MemtoReg, EX_MemWrite, EX_RegWrite;
wire EX_zeroflag; 
wire EX_MEM_BranchAddOut;
wire [31:0] EX_MEM_ALU_out, EX_MEM_RegR2; 
wire [4:0] EX_MEM_Rd;
wire [31:0] EX_MEM_Target;  
wire [31:0] MEM_WB_Mem_out, MEM_WB_ALU_out;
wire [4:0] MEM_WB_Rd;
wire MEM_WB_MemtoReg, MEM_WB_RegWrite;


 PC #32 pc( clk,  reset, 1, AMux_out,  pc_out);
 
 InstructionMem InstMem (pc_out/4, data_out); 
 
 
 PC #64 IF_ID_REG ( clk, reset, 1, {pc_out,data_out},{IF_ID_PC,IF_ID_Inst});
 

 ImmGen immgen (IF_ID_Inst, gen_out);
 
 CU cu (IF_ID_Inst [6:2],  Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp) ;
 
 RF rf ( clk , reset, MEM_WB_RegWrite, IF_ID_Inst[19:15], IF_ID_Inst[24:20], MEM_WB_Rd ,  DMux_out ,  RD1,  RD2);
 
 PC #145 ID_EX_REG ( clk, reset, 1, {IF_ID_PC, RD1, RD2, gen_out, IF_ID_Inst[11:7], {IF_ID_Inst[30], IF_ID_Inst[14:12]},
    Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp}, // this reg must be executed at the negdge of clk
    {ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2 , ID_EX_Imm, ID_EX_Rd, ID_EX_Func, ID_Branch, ID_MemRead, ID_MemtoReg, 
    ID_MemWrite, ID_ALUsrc, ID_RegWrite, ID_ALUop  }); // add rs1 and rs2 ID/EX for forwarding 
 
 
NBitMux #32 RF_Mux ( ID_EX_RegR2, ID_EX_Imm, ID_ALUsrc,  ALU_in2);

ALU_CU alcu (ID_ALUop, ID_EX_Func[2:0], ID_EX_Func[3], ALUSelection);
  
ALU #32 alu ( ID_EX_RegR1, ALU_in2, ALUSelection , Alu_out,  zeroflag);
 
Shift1  #32 shift (ID_EX_Imm, shift_out);

RCA #32 adder1_target (ID_EX_PC, shift_out, 0, adder1_out, target);


PC #107  EX_MEM_REG (clk,  reset,  1, {adder1_out, Alu_out, ID_EX_RegR2, ID_EX_Rd, zeroflag, ID_Branch, ID_MemRead, ID_MemtoReg, 
ID_MemWrite, ID_RegWrite}, 
{EX_MEM_Target, EX_MEM_ALU_out, EX_MEM_RegR2, EX_MEM_Rd, EX_zeroflag, EX_Branch, EX_MemRead, EX_MemtoReg, EX_MemWrite, EX_RegWrite});

assign EX_MEM_BranchAddOut = EX_Branch & EX_zeroflag; //the selection line for the pc_mux 
 
DataMem datamem ( clk, EX_MemRead ,EX_MemWrite , EX_MEM_ALU_out/4, EX_MEM_RegR2, memdata_out);


PC #71 MEM_WB_REG ( clk,  reset,  1, {memdata_out, EX_MEM_ALU_out, EX_MemtoReg, EX_RegWrite, EX_MEM_Rd}, 
{MEM_WB_Mem_out, MEM_WB_ALU_out, MEM_WB_MemtoReg, MEM_WB_RegWrite, MEM_WB_Rd});


NBitMux #32 Mem_Mux (MEM_WB_ALU_out, MEM_WB_Mem_out  ,MEM_WB_MemtoReg,  DMux_out);

RCA #32 adder2_pc (pc_out, 4, 0, adder2_out, pc_4);

Four_Digit_Seven_Segment_Driver sevenseg (ssdclk, ssd, Anode, LED_out);


NBitMux #32 Pc_Mux ( adder2_out, EX_MEM_Target, EX_MEM_BranchAddOut,  AMux_out);


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
