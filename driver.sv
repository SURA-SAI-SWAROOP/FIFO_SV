class driver;
mailbox #(transaction) gen2drv;
virtual fifo_if vif;
transaction tr;
function new (mailbox #(transaction) gen2drv);
this.gen2drv=gen2drv;
endfunction
task reset();
vif.reset<=1'b1;
vif.re<=1'b0;
vif.we<=1'b0;
vif.data_in<=0;
repeat (5) @(posedge vif.clk);
vif.reset<=1'b0;
$display("[DRV]:: RESET IS DONE");
$display("--. ----");
endtask
task write();
@(posedge vif.clk);
vif.reset<=1'b0;
vif.we<=1'b1;
vif.re<=1'b0;
vif.data_in<=tr.data_in;
@(posedge vif.clk);
vif.we<=1'b0;
$display("[DRV]:: WRITE DATA=%0d", vif.data_in);
@(posedge vif.clk);
endtask

  task read();
@(posedge vif.clk);
vif.reset<=1'b0;
vif.we<=1'b0;
vif.re<=1'b1;
@(posedge vif.clk);
vif.re<=1'b0;
$display("[DRV]:: DATA READ");
@(posedge vif.clk);
endtask
task main();
forever begin
gen2drv.get(tr);
if(tr.we==1'b1 && tr.re==1'b0)
write();
else if (tr.we==1'b0 && tr.re==1'b1)
read();
end
endtask
endclass
