class transaction extends uvm_sequence_item;

rand bit rst;
rand bit din;
bit dout;


`uvm_object_utils_begin(transaction)
`uvm_field_int(rst,UVM_DEFAULT)
`uvm_field_int(din,UVM_DEFAULT)
`uvm_field_int(dout,UVM_DEFAULT)
`uvm_object_utils_end


function new(string name="transaction");
super.new(name);
endfunction

endclass