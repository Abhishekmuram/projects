class drv extends uvm_driver #(transaction);
`uvm_component_utils(drv)

transaction tr;

virtual apb_if aif ;

function new(string name="drv",uvm_component parent=null);
super.new(name,parent);
endfunction


virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);

tr=transaction::type_id::create("tr");

if(!uvm_config_db#(virtual apb_if)::get(this,"","aif",aif))
`uvm_error("drv",$sformatf("enable access interface"));

endfunction



task reset_dut();

repeat(5)
begin
    aif.presetn   <= 1'b0;
    aif.paddr     <= 'h0;
    aif.pwdata    <= 'h0;
    aif.pwrite    <= 'b0;
    aif.psel      <= 'b0;
    aif.penable   <= 'b0; 
`uvm_info("DRV", "System Reset : Start of Simulation", UVM_MEDIUM);
@(posedge aif.pclk);
end
endtask

task driver();
reset_dut();


forever begin 

seq_item_port.get_next_item(tr);

if(tr.op==transaction::oper_mode'(0))
begin
aif.presetn<=0;
aif.paddr<=0;
aif.pwdata<=0;
aif.pwrite<=0;
aif.penable<=0;
aif.psel<=0;
@(posedge aif.pclk);
end

else if(tr.op==transaction::oper_mode'(1))
begin
aif.psel<=1;
aif.paddr<=tr.paddr;
aif.pwdata<=tr.pwdata;
aif.presetn<=1'b1;
aif.pwrite<=1'b1;
@(posedge aif.pclk);
aif.penable<=1'b1;
`uvm_info("DRV", $sformatf("mode:%0s, addr:%0d, wdata:%0d, rdata:%0d, slverr:%0d",tr.op.name(),tr.paddr,tr.pwdata,tr.prdata,tr.pslverr), UVM_NONE);
 @(negedge aif.pready);
aif.penable <= 1'b0;
//tr.PSLVERR   = vif.pslverr;
end

else if (tr.op==transaction::oper_mode'(2))
begin
aif.psel<=1;
aif.paddr<=tr.paddr;
//aif.pwdata<=tr.pwdata;
aif.presetn<=1'b1;
aif.pwrite<=1'b0;
@(posedge aif.pclk);
aif.penable<=1'b1;
`uvm_info("DRV", $sformatf("mode:%0s, addr:%0d, wdata:%0d, rdata:%0d, slverr:%0d",tr.op.name(),tr.paddr,tr.pwdata,tr.prdata,tr.pslverr), UVM_NONE);
 @(negedge aif.pready);
aif.penable <= 1'b0;
tr.prdata    = aif.prdata;
tr.pslverr   = aif.pslverr;
end

seq_item_port.item_done();

end
endtask

virtual task run_phase(uvm_phase phase);
driver();
@(posedge aif.pclk);
endtask

endclass




