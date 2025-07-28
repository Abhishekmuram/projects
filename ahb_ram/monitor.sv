`ifndef mon
`define mon
class monitor extends uvm_monitor;
`uvm_component_utils(monitor)
virtual ahb_if ahf;

txn tra;

uvm_analysis_port #(txn) mon_port;

function new(string name="monitor",uvm_component parent=null);
super.new(name,parent);
mon_port=new("mon_port",this);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(virtual ahb_if)::get(this,"","ahf",ahf))
begin
`uvm_fatal(get_full_name(),"interface not getting")
end
endfunction

task collect_data(txn tra);
@(posedge ahf.hclk);
tra.haddr=ahf.haddr;
tra.hwrite=ahf.hwrite;
tra.htrans=ahf.htrans;
tra.hsize=ahf.hsize;
tra.hburst=ahf.hburst;
if(ahf.hwrite==1)
tra.hwdata.push_front(ahf.hwdata);
else
tra.hrdata=ahf.hrdata;
endtask


task run_phase(uvm_phase phase);
forever 
begin
tra=txn::type_id::create("tra");
@(posedge ahf.hclk);
collect_data(tra);
mon_port.write(tra);
end
endtask

endclass
`endif


