

class sco extends uvm_scoreboard;
`uvm_component_utils(sco)
 
  uvm_analysis_imp#(transaction,sco) recv;
 transaction tr;
 
 
    function new(input string inst = "sco", uvm_component parent = null);
    super.new(inst,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    recv = new("recv", this);
    endfunction
    
    
  virtual function void write(transaction tr);
   tr=transaction::type_id::create("tr");
    `uvm_info("sco",$sformatf("a:%0d b:%0d s:%0d y:%0d",tr.a,tr.b,tr.s,tr.y),UVM_NONE);
    if(tr.y == ((~tr.s&tr.a) | (tr.s&tr.b)))
     `uvm_info("SCO", "TEST PASSED", UVM_NONE)
    else
      `uvm_info("SCO", "TEST FAILED", UVM_NONE)
          
    $display("----------------------------------------------------------------");
    endfunction
 
endclass