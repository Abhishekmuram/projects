class generator extends uvm_sequence #(transaction);

`uvm_object_utils(generator)

transaction t;

function new(string name="generator");
super.new(name);
endfunction


virtual task body();


repeat(10) 
    begin
t=transaction::type_id::create("t");

start_item(t);

assert(t.randomize());

`uvm_info("SEQ",$sformatf("a:%0d b:%0d s:%0d y:%0d",t.a,t.b,t.s,t.y),UVM_NONE);

finish_item(t);
end
endtask
endclass
