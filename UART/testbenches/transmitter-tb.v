module transmitter_tb;
	wire serial_out;
	reg clock,resetn,byte_ready,t_byte,load_XMT_datareg;
	reg [7 : 0]input_data;

transmitter t1(serial_out, byte_ready, t_byte,load_XMT_datareg,clock,resetn, input_data );

initial begin clock = 0 ; forever #1 clock <= ~clock; end

initial begin
	input_data = 8'b1010_0110; load_XMT_datareg = 1'b1; byte_ready = 0; t_byte = 0;
#2 	input_data = 8'b1100_0110;load_XMT_datareg = 0; byte_ready = 1;t_byte = 1;
end
endmodule
