module s_a(input resetn,
	   input [3:0]c,	
	   input [15:0] x1,x3,x5,x7,x9,x11,x13,x15,
	   output [15:0]out		
	  );
wire [15:0]ishifter_out;
wire [2:0]shift,select;
wire [15:0]mux_out;

mux8x1 m0(x1,x3,x5,x7,x9,x11,x13,x15,select,mux_out);
shifter s0(resetn,c,shift,select);
ishifter is0(resetn, mux_out, shift, ishifter_out);

and_gate ag0(ishifter_out,c,out);

endmodule

