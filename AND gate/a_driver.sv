class driver extends uvm_driver #(transaction);

`uvm_component_utils(driver)

function new(string name ="driver",uvm_component parent=null);
super.new(name,parent);
endfunction

virtual and_if aif;
transaction tc;

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
tc=transaction::type_id::create("tc");

if(!uvm_config_db #(virtual and_if)::get(this,"","aif",aif))
`uvm_error("drv","driver unable to access config_db");
endfunction

virtual task run_phase(uvm_phase phase);
forever begin

seq_item_port.get_next_item(tc);
aif.a <= tc.a;
aif.b <= tc.b;
`uvm_info("DRV",$sformatf("triggered dut a:%0d ,b:%0d",tc.a,tc.b),UVM_NONE);  
seq_item_port.item_done();
 #10;
      
    end
  endtask
endclass

