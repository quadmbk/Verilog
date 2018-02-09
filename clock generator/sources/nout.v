module bi_directional(bi,sig_out, sig_in, dir);
	inout bi;
	output sig_in;
	input sig_out, dir;	

assign bi = (dir) ? sig_out : 1'bz;
assign sig_in = bi;
endmodule

module tb;
	reg sig_out, dir;
	wire bi, sig_in;
	
	bi_directional bd(bi,sig_out, sig_in, dir);
	
	initial begin
		sig_out = 1; dir = 1;
	#1	sig_out = 0; dir = 0;
	#1	sig_out = 0; dir = 1;
	 
	end
endmodule
