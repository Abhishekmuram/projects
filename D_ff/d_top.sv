`include "uvm_macros.svh"
import uvm_pkg::*;
`include "d_sequence_item.sv"
`include "d_sequence_1.sv"
`include "d_sequence_2.sv"
`include "d_sequence_3.sv"
`include "d_driver.sv"
`include "d_monitor.sv"
`include "d_scoreboard.sv"
`include "d_agent.sv"
`include "d_env.sv"
`include "d_test.sv"
`include "d_dut.sv"
`include "d_interface.sv"


module top;


 
  dff_if dif();
  
  dff dut (.clk(dif.clk), .rst(dif.rst), .din(dif.din), .dout(dif.dout));
 
  initial 
  begin
    uvm_config_db #(virtual dff_if)::set(null, "*", "dif", dif);
    run_test("test"); 
  end
  
  initial begin
    dif.clk = 0;
  end
  
  always #10 dif.clk = ~dif.clk;
  
endmodule
 
 
