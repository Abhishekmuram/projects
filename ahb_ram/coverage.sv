module coverage(input logic [2:0] hburst,input logic hwrite,input logic [2:0]hsize,logic [1:0]htrans,input logic [31:0]hwdata,input logic [31:0]hrdata,input logic hready,input logic [31:0]haddr);
real coverages;

covergroup ahb_cov;
c1:coverpoint hwrite{bins low={0};
	  bins high={1};}
c2:coverpoint haddr{bins address={[32'hFFFFFFFF:32'h00000000]};}
c3:coverpoint hwdata{bins data={[32'hFFFFFFFF:32'h00000000]};}
c4:coverpoint htrans;
c5:coverpoint hburst;
c6:coverpoint hsize;

endgroup 

 ahb_cov ahb_coverage=new();

initial
begin
ahb_coverage.sample();

$display("AHB instance coverage = %0f", ahb_cov.get_coverage());
end
endmodule
