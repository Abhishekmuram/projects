class random extends uvm_sequence #(transaction);
`uvm_object_utils(random)

transaction tr;

function new(string name="random");
super.new(name);
endfunction


virtual task body();

tr=transaction::type_id::create("tr");

repeat(10) begin
start_item(tr);
assert(tr.randomize());
`uvm_info("SEQ",$sformatf("wr_enable:%0b addr:%0d din:%0d dout:%0d",tr.wr_enable,tr.addr,tr.din,tr.dout),UVM_NONE);
finish_item(tr);
end
endtask
endclass
