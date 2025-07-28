class seq extends uvm_sequence#(txn);

`uvm_object_utils(seq)

int queue[$];

function new(string name ="seq");
super.new(name);
endfunction

endclass


class single_transfer extends seq;
`uvm_object_utils(single_transfer)

txn tr;

function new(string name ="single_transfer");
super.new(name);
endfunction

task body();
tr=txn::type_id::create("tr");
begin
start_item(tr);
tr.hsize=3'b001;
tr.hburst=3'b000;
tr.hwrite=1'b1;
tr.randomize();
finish_item(tr);
end

begin
start_item(tr);
tr.hsize=3'b001;
tr.hburst=3'b000;
tr.hwrite=1'b0;
//tr.randomize();
finish_item(tr);
end

endtask
endclass


class increament_sequence extends seq;
`uvm_object_utils(increament_sequence)

txn tr;

function new(string name ="increament_sequence");
super.new(name);
endfunction

task body();
tr=txn::type_id::create("tr");
begin
start_item(tr);
tr.hsize=3'b001;
tr.hburst=3'b101;      //inc8
tr.hwrite=1'b1;
tr.randomize();
queue.push_front(tr.haddr);
finish_item(tr);
end

begin
start_item(tr);
tr.hsize=3'b001;
tr.hburst=3'b101;
tr.hwrite=1'b0;
//tr.randomize();
tr.haddr=queue.pop_back();
finish_item(tr);
end

endtask
endclass

class wrapping_sequence extends seq;
`uvm_object_utils(wrapping_sequence)

txn tr;

function new(string name ="wrapping_sequence");
super.new(name);
endfunction

task body();
tr=txn::type_id::create("tr");
begin
start_item(tr);
tr.hsize=3'b001;
tr.hburst=3'b100;       //wrap8
tr.hwrite=1'b1;
tr.htrans=2'b10;
tr.randomize();
queue.push_front(tr.haddr);
finish_item(tr);
end

begin
start_item(tr);
tr.hsize=3'b001;
tr.hburst=3'b100;
tr.hwrite=1'b0;
//tr.randomize();
tr.haddr=queue.pop_back();
finish_item(tr);
end

endtask
endclass