class write extends uvm_sequence #(transaction);
`uvm_object_utils(write)

transaction tr;

function new(string name="write");
super.new(name);
endfunction


virtual task body();

tr=transaction::type_id::create("tr");

repeat(10) begin
start_item(tr);
assert(tr.randomize());
tr.wr_enable=1'b1;
`uvm_info("SEQ",$sformatf("wr_enable:%0b addr:%0d din:%0d dout:%0d",tr.wr_enable,tr.addr,tr.din,tr.dout),UVM_NONE);
finish_item(tr);
end
endtask
endclass
