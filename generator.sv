class generator;
  transaction tr;
  mailbox #(transaction) gen2drv;
  
  event sconxt;
  event gen_ended;
  
  int trans_count;
  
  function new (mailbox #(transaction) gen2drv);
    this.gen2drv=gen2drv;
    tr=new();
  endfunction
    
  task main();
    repeat (trans_count) begin
      assert(tr.randomize()) else $error("[GEN]:: RANDOMIZATION FAILED");
      gen2drv.put(tr.copy());
      tr.display("GEN");
      @(sconxt);
    end
    ->gen_ended;
  endtask
    
endclass
