class driver extends uvm_driver #(txn);
`uvm_component_utils(driver)
virtual ahb_if ahf;
int addr, addr1,i;
txn tr;
bit trans_indicate;

function new(string name="driver",uvm_component parent=null);
super.new(name,parent);
tr=txn::type_id::create("tr");
endfunction

function void build_phase (uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db #(virtual ahb_if )::get(this,"","ahf",ahf))
begin
`uvm_fatal(get_full_name,"interface not getting")
end
endfunction

//address phase  

task address_phase(txn tr,bit trans_indicate);
wait(ahf.hresetn);
if(trans_indicate==0)
tr.htrans=2'b10;
else if(trans_indicate==1)
tr.htrans=2'b11;
@(posedge ahf.hclk);
$display("driver address=%0d",ahf.hrdata);
ahf.htrans<=tr.htrans;
ahf.hburst<=tr.hburst;
ahf.hsize<=tr.hsize;
ahf.hwrite<=tr.hwrite;
//for(int i=0;i<tr.burst_len;i++)begin
//ahf.hwdata<=tr.hwdata.pop_front(); //end
wait(ahf.hreadyout==1);
addr=tr.haddr;
//addr1=tr.haddr;


if(tr.hburst inside{3'b010,3'b100,3'b110}) 
begin
if(addr+(2**tr.hsize) >= tr.upper_boundary)
begin
ahf.haddr=addr;
tr.haddr=tr.lower_boundary;
end
else 
begin
ahf.haddr=addr;
tr.haddr=tr.haddr +(2**tr.hsize);
end
end
else if(tr.hburst inside{3'b001,3'b011,3'b101})
begin
tr.haddr=tr.haddr +(2**tr.hsize);
ahf.haddr=tr.haddr;
end
else
begin
ahf.haddr=tr.haddr;
end
endtask

//data phase

task data_phase(txn tr);
@(posedge ahf.hclk);
if(ahf.hwrite==1)
begin
ahf.hwdata<=tr.hwdata.pop_front();
$display($time,"xtn data=%p,interface data=%0h",tr.hwdata,ahf.hwdata);
end
wait(ahf.hreadyout==1);
$display($time," master driver hwdata=%0h haddr=%0h",ahf.hwdata,ahf.haddr);
endtask



//pipelined 

task pipeline_op (txn tr);
address_phase(tr,0);
fork
for(int i=1; i<tr.burst_len; i=i+1)
begin
address_phase(tr,1);
end
for(int i=1; i<=tr.burst_len; i=i+1)
begin
data_phase(tr);
end
join
endtask


task run_phase(uvm_phase phase);
forever begin 
seq_item_port.get_next_item(tr);
pipeline_op(tr);
seq_item_port.item_done;
end
endtask
endclass 