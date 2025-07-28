
class mon extends uvm_monitor;
`uvm_component_utils(mon)
 
uvm_analysis_port#(transaction) send;
transaction tr;
virtual mux_if mif;
 
    function new(input string inst = "mon", uvm_component parent = null);
    super.new(inst,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tr = transaction::type_id::create("tr");
    send = new("send", this);
      if(!uvm_config_db#(virtual mux_if)::get(this,"","mif",mif))//uvm_test_top.env.agent.drv.aif
      `uvm_error("drv","Unable to access Interface");
    endfunction
    
    
    virtual task run_phase(uvm_phase phase);
    forever begin
     #10;
   tr.a = mif.a;
   tr.b = mif.b;
   tr.s = mif.s;
   tr.y = mif.y;

      `uvm_info("mon",$sformatf("a:%0d b:%0d s:%0d y:%0d",tr.a,tr.b,tr.s,tr.y),UVM_NONE);
        send.write(tr);
    end
   endtask 
 
endclass