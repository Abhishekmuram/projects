`ifndef slave_agent
`define slave_agent 

class slave_agent extends uvm_agent;
`uvm_component_utils(slave_agent)

slave_monitor s_mon;
slave_bfm   s_bfm;

function new(string name="slave_agent",uvm_component parent=null);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
s_mon=slave_monitor::type_id::create("s_mon",this);
s_bfm=slave_bfm::type_id::create("s_bfm",this);
endfunction 

endclass
`endif
