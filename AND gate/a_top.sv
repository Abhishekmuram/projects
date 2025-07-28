import uvm_pkg::*; 
`include "uvm_macros.svh"
`include "a_sequence_item.sv"
`include "a_sequence.sv"
`include "a_driver.sv"
`include "a_monitor.sv"
`include "a_scoreboard.sv"
`include "a_agent.sv"
`include "a_env.sv"
`include "a_test.sv"
`include "a_dut.sv"
`include "a_interface.sv"




module top();
  and_if aif();
  
  and_gate dut(.a(aif.a),.b(aif.b),.y(aif.y));
  
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
  initial begin 
    uvm_config_db #(virtual and_if)::set(null,"uvm_test_top.e.a*","aif",aif);
    run_test("test");
  end
endmodule
