class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  
  uvm_analysis_imp #(transaction,scoreboard)recv;
  
  transaction tr;
  
  
  function new(string path="scoreboard",uvm_component parent=null);
    super.new(path,parent);
    recv=new("recv",this);
  endfunction 
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tr=transaction::type_id::create("tr");
  endfunction
  
  
  virtual function void write (transaction t);
    tr=t;
    `uvm_info("SB",$sformatf("data received from monitor a:%0d ,b:%0d , y:%0d",tr.a,tr.b,tr.y),UVM_NONE);
    
    
    if(tr.y == tr.a & tr.b)
      `uvm_info("SOC","test pased" ,UVM_NONE)
    else
      `uvm_info("SOC","test not pased" ,UVM_NONE);
  endfunction
  
endclass
