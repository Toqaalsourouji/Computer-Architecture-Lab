module PC ( input wire clk, input wire reset,             
    input wire branch, // pc+4 or target
    input Zflag,
    input wire [31:0] branch_offset, // branch imm
    input wire [31:0] branch_target, //  pc + branch offset
    input wire [31:0] pc_4, // pc + 4
    output reg [31:0] pc_out  // output of pc 
);
    reg [31:0] pc_current;     // value of pc 
    reg And_out;
    assign And_out = Zflag & branch;
    always @(posedge clk or posedge reset) begin
        if ( reset == 1'b1 ) begin
            pc_out <= 32'b0;      
        end 
        else begin
            pc_out <= pc_current;    
        end
    end
    
    always @(*) begin
        // First adder
        pc_4 = pc_out + 4;
        
        // Second adder
        branch_target = pc_out + branch_offset;
        
        // Mux 
        if ( And_out == 1'b1) begin
            pc_current = branch_target;  
        end 
        else begin
            pc_current = pc_4;      
        end
    end
endmodule
