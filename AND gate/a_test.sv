class test extends uvm_test;
  `uvm_component_utils(test)
  
  function new(string path="test",uvm_component parent=null);
    super.new(path,parent);
  endfunction
  
  generator gen;
  env e;
  
   virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     e=env::type_id::create("e",this);
     gen=generator::type_id::create("g",this);
  endfunction 
    
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    gen.start(e.a.seqr);
    phase.drop_objection(this);
  endtask
endclass

