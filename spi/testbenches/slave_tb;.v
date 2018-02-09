module slave_tb;
	reg [7 :0] data_2_send;
	wire[7:0]data_rcv;
	
	reg clk, rst, cs, in;
	wire out, done;

	reg[7:0] data_shft_out;
	integer k;
 
	spi_slave s0(clk, rst, cs, in, data_2_send, data_rcv, out, done);

initial begin
	clk = 0; 
	forever #1 clk <= ~clk;

end

initial begin
	data_shft_out = 8'h4d;
	#1 rst =0;
	
	for(k = 7; k>=0;k = k-1)begin #2 rst = 1; cs = 0; in =data_shft_out[k]; end
	#8 cs= 1;
	
	data_2_send = 8'h77;
	 #2    cs = 0;

	
end
endmodule
