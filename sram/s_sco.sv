class sco extends uvm_scoreboard;
`uvm_component_utils(sco)

transaction t;
transaction tr;
uvm_analysis_imp#(transaction,sco)recv;

reg [7:0]mem[7:0];

function new(string name="sco",uvm_component parent= null);
super.new(name,parent);
endfunction

 virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    recv = new("recv", this);
    t=transaction::type_id::create("t");
    tr=transaction::type_id::create("tr");
    endfunction

task refer(); 
begin 
if(t.wr_enable) 
mem[t.addr]=t.din; 
else 
t.dout=mem[t.addr]; 
end 
endtask

function void write(transaction tx);
  tr = tx;  // Assign received transaction to t
endfunction


virtual task run_phase(uvm_phase phase);
//forever begin
refer();
if(tr.dout==t.dout)begin
`uvm_info(get_type_name(),"test passed",UVM_NONE);end
else begin
`uvm_info(get_type_name(),"test failed",UVM_NONE);end
//end
endtask

endclass

