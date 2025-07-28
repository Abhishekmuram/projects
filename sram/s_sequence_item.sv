class transaction extends uvm_sequence_item;

rand bit wr_enable;
rand bit[4:0]addr;
rand bit[4:0]din;
 bit[4:0]dout;

`uvm_object_utils_begin(transaction)
`uvm_field_int(wr_enable,UVM_DEFAULT)
`uvm_field_int(addr,UVM_DEFAULT)
`uvm_field_int(din,UVM_DEFAULT)
`uvm_field_int(dout,UVM_DEFAULT)
`uvm_object_utils_end


function new(string name="transaction");
super.new(name);
endfunction

endclass