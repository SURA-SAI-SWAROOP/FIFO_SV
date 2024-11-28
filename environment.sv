`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
  generator gen;
  driver drv;
  monitor mon;
  scoreboard sco;
  
  mailbox #(transaction) gen2drv;
  mailbox #(transaction) mon2scb;
  
  event sconxt;
  
  virtual fifo_if vif;
  
  function new (virtual fifo_if vif);
    gen2drv=new();
    mon2scb=new();
    
    gen=new(gen2drv);
    drv=new(gen2drv);
    mon=new(mon2scb);
    sco=new(mon2scb);
    
    this.vif=vif;
    
    drv.vif=this.vif;
    mon.vif=this.vif;
    
    gen.sconxt=sconxt;
    sco.sconxt=sconxt;
  endfunction
    
  task pre_test();
    drv.reset();
  endtask
    
  task test();
    fork
      gen.main();
      drv.main();
      mon.main();
      sco.main();
    join_any
  endtask
    
  task post_test();
    wait(gen.gen_ended.triggered);
    $display("ALL TRANSACTIONS ARE COMPLETED");
    $finish;
  endtask
    
  task run();
    pre_test();
    test();
    post_test();
  endtask
endclass
