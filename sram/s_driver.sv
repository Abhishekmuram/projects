class drv extends uvm_driver #(transaction);
`uvm_component_utils(drv)

transaction tr;

virtual sram_if sif;

function new(string name="drv",uvm_component parent=null);
super.new(name,parent);
endfunction


virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
tr=transaction::type_id::create("tr");
if(!uvm_config_db #(virtual sram_if)::get(this,"","sif",sif))
`uvm_error(get_type_name(),"unable to access interface");
endfunction

virtual task run_phase(uvm_phase phase);
forever begin
seq_item_port.get_next_item(tr);
sif.wr_enable<=tr.wr_enable;
sif.addr<=tr.addr;
sif.din<=tr.din;
`uvm_info("drv",$sformatf("wr_enable:%0b addr:%0d din:%0d dout:%0d",tr.wr_enable,tr.addr,tr.din,tr.dout),UVM_NONE);
seq_item_port.item_done;
repeat(2)@(posedge sif.clk);

end
endtask
endclass





