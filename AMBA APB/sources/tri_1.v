module tri_gate_1(in,control,out);
	parameter width = 1;
	input [width-1:0] in;
	input control;
	output [width-1:0] out;

assign out = (control == 1'b0)? 1'bz : in; 

endmodule