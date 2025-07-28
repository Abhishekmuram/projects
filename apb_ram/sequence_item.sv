class transaction extends uvm_sequence_item;

typedef enum bit [1:0]   {rst = 0, writed = 1,readd= 2} oper_mode;

rand oper_mode op;
rand bit pwrite;
rand bit [31:0] paddr;
rand bit [31:0] pwdata;

bit pslverr;
bit pready;
bit [31:0] prdata;

`uvm_object_utils_begin(transaction)
`uvm_field_int(pwrite,UVM_ALL_ON)
`uvm_field_int(paddr,UVM_ALL_ON)
`uvm_field_int(pwdata,UVM_ALL_ON)
`uvm_field_int(pslverr,UVM_ALL_ON)
`uvm_field_int(pready,UVM_ALL_ON)
`uvm_field_int(prdata,UVM_ALL_ON)
`uvm_field_enum(oper_mode,op,UVM_DEFAULT)
`uvm_object_utils_end

constraint addr_c { paddr < 31; }
constraint addr_c_err { paddr > 31; }

function new(string name="transaction");
super.new(name);
endfunction
endclass
