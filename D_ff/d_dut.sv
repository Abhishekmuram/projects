module dff(

input clk,rst,
input din,
output reg dout);


always@(posedge clk)
  begin
    if(rst)
       dout<=0;
    else
       dout<=din;
  end
endmodule

