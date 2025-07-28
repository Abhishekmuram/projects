
module mux (
input a,b,
input s,

output reg y);


assign y = (~s&a) | (s&b);

endmodule 