module assertions (
    input bit hclk,
    input logic [2:0] hburst,
    input logic hwrite,
    input logic [2:0] hsize,
    input logic [1:0] htrans,
    input logic [31:0] hwdata,
    input logic [31:0] hrdata,
    input logic hready,
    input logic [31:0] haddr);

    // Property to check that hwdata is non-zero when a valid transfer occurs
    property data;
        @(posedge hclk)
        (htrans == 2'b10 || htrans == 2'b11) |=> (hwdata != 0);
    endproperty

    // Property to ensure hready eventually becomes high after a valid transfer
    property sign;
        @(posedge hclk)
        (htrans == 2'b10 || htrans == 2'b11) |-> ##[1:$] hready;
    endproperty

    property read_signal;
	@(posedge hclk) (hwrite==0) |-> (haddr !=0);
    endproperty

 property seqs;
	@(posedge hclk) (htrans==2'b10) |=> (htrans==2'b11);
	endproperty

    // Assertions
    assertion1: assert property (data);
    assertion2: assert property (sign);
 assertion3: assert property (read_signal);
assertion4:assert property (seqs);

   

    // Covers (for simulation observability)
    cover1: cover property (data);
    cover2: cover property (sign);

endmodule
