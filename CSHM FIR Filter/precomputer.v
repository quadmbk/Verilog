module precomputer(input[7:0]x,
		   output [15:0]x1,
				   x3,
				   x5,
				   x7,x9,
				   x11,
				   x13,
				   x15		
		  );
wire [15:0]x1t,x3t,x5t,x7t,x9t,x11t,x13t,x15t;

booth_top bt0(x,8'd1,x1);
booth_top bt1(x,8'd3,x3);
booth_top bt2(x,8'd5,x5);
booth_top bt3(x,8'd7,x7);
booth_top bt4(x,8'd9,x9);
booth_top bt5(x,8'd11,x11);
booth_top bt6(x,8'd13,x13);
booth_top bt7(x,8'd15,x15);
	
/*
assign x1 = x1t[11:0];
assign x3 = x3t[11:0];
assign x5 = x5t[11:0];
assign x7 = x7t[11:0];
assign x9 = x9t[11:0];
assign x11 = x11t[11:0];
assign x13 = x13t[11:0];
assign x15 = x15t[11:0];
*/
endmodule


module test;
reg signed[7:0]x;
wire signed[11:0]x1,
				   x3,
				   x5,
				   x7,x9,
				   x11,
				   x13,
				   x15		;

	precomputer p0(x,x1,
				   x3,
				   x5,
				   x7,x9,
				   x11,
				   x13,
				   x15		);


initial
begin
	x = -12;
end	
endmodule