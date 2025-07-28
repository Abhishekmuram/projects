

class transaction extends uvm_sequence_item;

 bit a=1'b1;
 bit b=1'b1;
bit y;

`uvm_object_utils_begin(transaction)
`uvm_field_int(a,UVM_DEFAULT)
`uvm_field_int(b,UVM_DEFAULT)
`uvm_field_int(y,UVM_DEFAULT)
`uvm_object_utils_end

function new(string name = "transaction");
super.new(name);
endfunction 
endclass
