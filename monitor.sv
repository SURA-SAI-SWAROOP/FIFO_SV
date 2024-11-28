class monitor;
transaction tr;
mailbox #(transaction) mon2scb;
virtual fifo_if vif;
function new (mailbox #(transaction) mon2scb);
this.mon2scb=mon2scb;
endfunction
task main();
tr=new();
forever begin
repeat (2) @(posedge vif.clk);
tr.we vif.we;
tr.re=vif.re;
tr.data_in=vif.data_in;
tr.full=vif.full;
tr.empty=vif.empty;
@(posedge vif.clk);
tr.data_out=vif.data_out;
mon2scb.put(tr);
$display("[MON]::data_in=\\0d\t we=0d\t re=%0d\t data_out=%0d\t full=%0d\t empty=%0d", tr.data_in, tr.we, tr.re, tr.data_out, tr.full,tr.empty);
end
endtask
endclass
