interface fifo_if;
logic clk;
logic reset;
logic [7:0] data_in;
logic we;
logic re;
logic [7:0] data_out;
logic full;
logic empty;
endinterface
