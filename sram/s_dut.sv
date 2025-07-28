module sram (

input clk,rst,
input wr_enable,
input [4:0] addr,
input [4:0] din,
output reg [4:0] dout);

reg [7:0] mem [7:0];

always@(posedge clk)
begin
if(rst)
dout<=0;
else 
begin 
if(wr_enable) 
mem[addr]<=din; 
else 
dout<=mem[addr]; 
end 
end 
endmodule 
