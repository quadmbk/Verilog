module tri_gate_8(in,control,out);
	parameter width = 8;
	input [width-1:0] in;
	input control;
	output [width-1:0] out;

assign out = (control == 1'b0)? 8'bzzzz_zzzz : in; 

endmodule
module tb;
	wire [7:0]out;
	reg [7:0]in1,in;
	reg control,control1;

	tri_gate_8 t(in,control,out);
	tri_gate_8 t1(in1,control1,out);
	
initial begin
	in = 8'h01; control = 1'b1;
	in1 = 8'h11; control1 = 1'b0;
#1	 
	in = 8'hff; control = 1'b0;
	in1 = 8'haa; control1 = 1'b1;
#1	 
	in = 8'h00; control = 1'b0;
	in1 = 8'hcc; control1 = 1'b1;
	 
end

endmodule