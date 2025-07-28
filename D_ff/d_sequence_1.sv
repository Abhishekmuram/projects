class valid_din extends uvm_sequence#(transaction);

transaction t;

`uvm_object_utils(valid_din)


function new(string name="valid_din");
super.new(name);
endfunction


virtual task body();
repeat(10)
begin

t=transaction::type_id::create("t");

start_item(t);
assert(t.randomize());
t.rst = 1'b0;
`uvm_info("SEQ", $sformatf("rst : %0b  din : %0b  dout : %0b", t.rst, t.din, t.dout), UVM_NONE);
finish_item(t);
end
endtask

endclass
