module mux8x1(input [15:0]         x1,
				   x3,
				   x5,
				   x7,x9,
				   x11,
				   x13,
				   x15,
		input [2:0]        select,
		output reg[15:0]   mux_out
		 );


always @(select, x1, x3, x5, x7, x9, x11, x13, x15) begin
	case(select)
		0 : mux_out <= x1;
		1 : mux_out <= x3;
		2 : mux_out <= x5;
		3 : mux_out <= x7;
		4 : mux_out <= x9;
		5 : mux_out <= x11;
		6 : mux_out <= x13;
		7 : mux_out <= x15;
		
	default: mux_out <= 0;
	endcase
end
endmodule
