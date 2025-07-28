class agent extends uvm_agent;
`uvm_component_utils(agent)

function new(string name="agent",uvm_component parent=null);
super.new(name,parent);
endfunction

drv d;
sequencer seqr;
mon m;

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
d=drv::type_id::create("d",this);
seqr=sequencer::type_id::create("seqr");
m=mon::type_id::create("m",this);
endfunction


virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
d.seq_item_port.connect(seqr.seq_item_export);
endfunction

endclass
