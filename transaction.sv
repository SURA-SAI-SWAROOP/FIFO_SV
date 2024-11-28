class transaction;
rand bit [7:0]data_in;
rand bit we;
rand bit re;
bit [7:0] data_out;
bit full;
bit empty;
int count;
//constraint we_re{we == ~re;}
constraint we_re{
if (count<16) (we==1; re==0; }
else {we==0; re==1;}
}
function void post_randomize();
if (count==32) begin
count=0;
end
else begin
count++;
end
endfunction
function transaction copy();
copy=new();
.data_in=this.data_in;
copy.we=this.we;
copy.re=this.
copy.data_out=this.data_out;
copy.full=this.full;
copy.empty=this.empty;
endfunction
               function void display (input string tag);
$display("[%s]:: Data_in=%0d\t we=%0d\t re=%0d\t Data_out=%0d", tag, data_in, we, re, data_out);
endfunction
endclass
