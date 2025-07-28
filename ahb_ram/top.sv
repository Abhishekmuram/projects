`timescale 1ns/1ns
import uvm_pkg::*;

`include "uvm_macros.svh"
`include "seq_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "slave_monitor.sv"
`include "slave_bfm.sv"
`include "scoreboard.sv"
`include "master_agent.sv"
`include "slave_agent.sv"
`include "env.sv"
`include "interface.sv"
//`include "coverage.sv"
//`include "assertion.sv"
`include "test.sv"
//`include "interface.sv"

module top;
ahb_if ahf();
//coverage co ( .hburst(ahf.hburst), .hwrite(ahf.hwrite),.hsize(ahf.hsize),.htrans(ahf.htrans),.hwdata(ahf.hwdata),.hrdata(ahf.hrdata), .hready(ahf.hreadyout),.haddr(ahf.haddr));

//assertions as ( .hclk(ahf.clk),.hburst(ahf.hburst), .hwrite(ahf.hwrite),.hsize(ahf.hsize),.htrans(ahf.htrans),.hwdata(ahf.hwdata),.hrdata(ahf.hrdata), .hready(ahf.hreadyout),.haddr(ahf.haddr));
test t_h;
initial 
begin 
ahf.hclk=0;
forever #5 ahf.hclk=~ahf.hclk;
end

initial begin 
ahf.hresetn=0;
#5;
ahf.hresetn=1;
end

initial begin 
uvm_config_db#(virtual ahb_if )::set(null,"","ahf",ahf);
//run_test("test");
//test t_h;
//t_h=new;
run_test("increament_sequence_test");
end

initial begin
#1000;
$finish();
end
endmodule 
