module spi_tb;
 parameter word_size = 8;

 reg clk, rst;
 wire sck, cs;
 reg start;
 reg[word_size-1:0] data_2_send, slave_data_2_send;
 wire in,out;
 wire[word_size-1:0]m_data_rcv,s_data_rcv;
 wire m_done,s_done;
 reg load;
spi_master m0(clk,rst, start, data_2_send, out, m_data_rcv, m_done, in, sck,cs);
spi_slave s0(sck, rst, cs, in,load, slave_data_2_send, s_data_rcv, out, s_done);

initial
begin
	clk = 0;
	forever #1 clk= ~clk;
end 

initial begin
	#1 rst = 0; start =0 ; data_2_send = 0; slave_data_2_send =0 ;
	#2 rst = 1; start =1 ; data_2_send = 8'h4c; slave_data_2_send =8'haa; load = 1; 
	#2 rst = 1; start =0 ; data_2_send = 0; slave_data_2_send =0 ;load = 0;
	#22 rst = 1; start =1 ; data_2_send = 8'h42; slave_data_2_send =8'hca; load = 1; 
	#2 rst = 1; start =0 ; data_2_send = 0; slave_data_2_send =0 ;load = 0;
	#22 rst = 1; start =1 ; data_2_send = 8'h22; slave_data_2_send =8'hdd; load = 1; 
	#2 rst = 1; start =0 ; data_2_send = 0; slave_data_2_send =0 ;load = 0;
	#22 rst = 1; start =1 ; data_2_send = 8'h11; slave_data_2_send =8'hee; load = 1; 
	#2 rst = 1; start =0 ; data_2_send = 0; slave_data_2_send =0 ;load = 0;
	
	
end
endmodule