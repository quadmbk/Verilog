module booth_top(mplier,mcand,product);
input [7:0]mplier,mcand;
output [15:0]product;

wire [7:0]A_out0;wire [8:0]Q_out0;
wire [7:0]A_out1;wire [8:0]Q_out1;
wire [7:0]A_out2;wire [8:0]Q_out2;
wire [7:0]A_out3;wire [8:0]Q_out3;
wire [7:0]A_out4;wire [8:0]Q_out4;
wire [7:0]A_out5;wire [8:0]Q_out5;
wire [7:0]A_out6;wire [8:0]Q_out6;
wire [7:0]A_out7;wire [8:0]Q_out7;



booth b0(8'b0000_0000,
	 mplier,
	 {mcand,1'b0},
	 A_out0,Q_out0			
	    );

booth b1(A_out0,
	 mplier,
	 Q_out0,
	 A_out1,Q_out1			
	    );

booth b2(A_out1,
	 mplier,
	 Q_out1,
	 A_out2,Q_out2			
	    );

booth b3(A_out2,
	 mplier,
	 Q_out2,
	 A_out3,Q_out3			
	    );

booth b4(A_out3,
	 mplier,
	 Q_out3,
	 A_out4,Q_out4			
	    );

booth b5(A_out4,
	 mplier,
	 Q_out4,
	 A_out5,Q_out5			
	    );

booth b6(A_out5,
	 mplier,
	 Q_out5,
	 A_out6,Q_out6			
	    );

booth b7(A_out6,
	 mplier,
	 Q_out6,
	 A_out7,Q_out7			
	    );

assign product = {A_out7,Q_out7[8:1]};
endmodule

module booth_tb;
reg[7:0]mplier,mcand;
wire[15:0]product;

booth_top bt0(mplier,mcand,product);

initial begin
	mplier = 5; mcand = 6;
#1	
	mplier = -5; mcand = 6;
#1	
	mplier = -5; mcand = -6;
#1	
	mplier = 5; mcand = -6;
#1	
	mplier = 5; mcand = 6;
	
end
endmodule