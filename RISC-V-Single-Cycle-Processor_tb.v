module RISC_V_TB();
reg clk, ssdclk, reset, load, ledSel, ssdSel;
wire leds, ssd;

RISC_V DUT ( clk, ssdclk, reset, load, ledSel,  ssdSel, leds,  ssd);

initial begin 
clk = 0 ;
forever #5 clk = ~ clk;
end 

initial begin 
reset = 1 ; 
load = 0 ;
#10 
reset = 0 ;
load = 1 ;
#130
$finish;
end

endmodule
