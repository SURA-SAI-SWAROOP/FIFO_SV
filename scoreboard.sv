class scoreboard;
  mailbox #(transaction) mon2scb;
  
  transaction tr;
  
  event sconxt:
  
  bit [7:0]din[$];
  
  bit [7:0]temp;
  
  function new (mailbox #(transaction) mon2scb);
    this.mon2scb=mon2scb;
  endfunction
    
  task main();
    forever begin
      mon2scb.get(tr);
      $display("[SCO]::data_in=%0d\t we=%0d\t re=%0d\t data_out=%0d\t full=%0d\t empty=%0d", tr.data_in, tr.we,tr.re,tr.data_out, tr.full,tr.empty);
      if (tr.we==1'bl)begin
        if(tr.full==1'b0)begin
          din.push_front(tr.data in);
          $display("[SCO):: DATA STORED IN QUEUE: %0d", tr.data_in);
        end
          
        else begin
          $display("[SCO]:: FIFO IS FULL");
        end
        $display("---------------");
      end
        
      if (tr.re==1'b1) begin
        if(tr.empty=1'b0) begin
          temp=din.pop_back();
          if (tr.data_out==temp) begin
            $display("[SCO]:: DATA MATCHED");
          end
            
          else begin
            $display("[SCO]:: DATA MISMATCHED");
          end
          
        end
          
        else begin
          $display("[SCO]:: FIFO IS EMPTY");
        end
          
        $display("--------------------");
      end
      ->sconxt;
    end
      
  endtask
    
endclass
