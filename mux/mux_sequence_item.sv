class transaction extends uvm_sequence_item;

rand bit a,b;
rand bit s;

bit y;

`uvm_object_utils_begin(transaction)
`uvm_field_int(a,UVM_DEFAULT)
`uvm_field_int(b,UVM_DEFAULT)
`uvm_field_int(s,UVM_DEFAULT)
`uvm_field_int(y,UVM_DEFAULT)
`uvm_object_utils_end


function new(string name="transaction");
super.new(name);
endfunction

endclass
