module master_tb;
	reg [7:0] data_2_send;
	reg clk, rst, start, in;

	wire cs, sck,done;
	wire [7:0]data_rcv;

	spi_master m0(clk,rst, start, data_2_send, in, data_rcv, done, out, sck,cs);
	
initial begin
	clk = 0; forever #1 clk <= ~clk;
end//initial

initial 
begin
	#1 start = 1'b0; data_2_send = 8'h4c; rst = 1'b0; in = 1'bz;
	#2 start = 1'b1; data_2_send = 8'h4d; rst = 1'b1; in = 1'b1;
	#1 start = 0;
	#13 in = 0;
	#1 in = 1;
	
	
end
endmodule
