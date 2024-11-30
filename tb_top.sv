`include "interface.sv"
`include "environment.sv"
`include "fifo.v"

module tb top();
  logic clk, reset;
  logic [7:0] data_in;
  logic we, re;
  logic [7:0] data out;
  logic full, empty;
  logic [3:0] wr_ptr, rd_ptr;
  
  fifo if vif();
  
  fifo dut(.clk(vif.clk),.reset(vif.reset)..data_in(vif.data_in)..we (vif.we),.re(vif.re), data_out(vif.data_out), full (vif.full)..empty(vif.empty));
  
  initial begin
    vif.clk<=0;
  end
    
  always #10 vif.clk-vif.clk;
  
  environment env:
  
  initial begin
    env=new(vif);
    env.gen.trans_count=32;
    env.run();
  end
    
endmodule
