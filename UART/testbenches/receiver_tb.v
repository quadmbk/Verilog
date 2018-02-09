module receiver_tb;
	parameter SIZE = 8;
	wire [SIZE-1:0]RCV_datareg;
	wire read_not_ready_out, error1, error2;
	reg read_not_ready_in,sample_clock,resetn,serial_in;

	receiver r1(RCV_datareg, read_not_ready_out, error1, error2, read_not_ready_in, 
		sample_clock,resetn, serial_in );

initial begin sample_clock = 0; forever #1 sample_clock <= ~sample_clock; end

initial begin
	read_not_ready_in = 1'b0; resetn = 1'b1 ; serial_in =1'b0 ;
	#1 read_not_ready_in =1'b1 ; resetn = 1'b0 ; serial_in =1'b0 ;
	#2 read_not_ready_in =1'b1 ; resetn = 1'b1 ; serial_in =1'b0 ;
	#12 read_not_ready_in =1'b1 ; resetn = 1'b1 ; serial_in =1'b1 ;
	#12 read_not_ready_in =1'b1 ; resetn = 1'b1; serial_in =1'b1 ;
	#12 read_not_ready_in =1'b1 ; resetn = 1'b1 ; serial_in =1'b0 ;
	#12 read_not_ready_in =1'b0 ; resetn = 1'b1 ; serial_in =1'b1 ;
	
	

end

initial $monitor($time,,"read_not_ready_out = %b, error1 = %b, error2 = %b, RCV_datareg =%b, serial_in = %b",read_not_ready_out,error1,
		error2,RCV_datareg,serial_in);

endmodule
