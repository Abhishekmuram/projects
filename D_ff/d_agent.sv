class agent extends uvm_agent;
`uvm_component_utils(agent);

function new(string name="agent",uvm_component parent=null);
super.new(name,parent);
endfunction

driver d;
uvm_sequencer#(transaction)seqr;
monitor m;


virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
d=driver::type_id::create("d",this);
seqr=uvm_sequencer#(transaction)::type_id::create("seqr",this);
m=monitor::type_id::create("m",this);

endfunction

virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
d.seq_item_port.connect(seqr.seq_item_export);
endfunction
 
endclass
