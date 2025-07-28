class random extends uvm_sequence#(transaction);

transaction t;

`uvm_object_utils(random)


function new(string name="random");
super.new(name);
endfunction


virtual task body();
repeat(10)
begin

t=transaction::type_id::create("t");

start_item(t);
assert(t.randomize());
t.rst = 1'b1;
`uvm_info("SEQ", $sformatf("rst : %0b  din : %0b  dout : %0b", t.rst, t.din, t.dout), UVM_NONE);
finish_item(t);
end
endtask

endclass
