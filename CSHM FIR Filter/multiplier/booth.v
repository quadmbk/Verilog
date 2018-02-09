module booth(input [7:0]A_in,
	     input [7:0]M,
	     input [8:0]Q,
	     output [7:0]A_out,
	     output [8:0]Q_out			
	    );

reg [7:0] A_temp;
reg [8:0] Q_temp;

wire [7:0]A_sub;
wire [7:0]A_add;

assign A_sub = A_in + ~M + 1'b1;
assign A_add = A_in + M;

always @(A_in,M,Q,A_temp,Q_temp,A_sub, A_add)begin
	case(Q[1:0])
	2'b10 :begin//sub and shift
		A_temp <= {A_sub[7],A_sub[7:1]};
		Q_temp <= {A_sub[0],Q[8:1]};	
		end
	2'b01  :begin//add and shift
		A_temp <= {A_add[7],A_add[7:1]};
		Q_temp <= {A_add[0],Q[8:1]};
		end
	default : begin
			A_temp <= {A_in[7],A_in[7:1]};
			Q_temp <= {A_in [0],Q[8:1]};
		  end
	endcase
end

assign A_out = A_temp;
assign Q_out = Q_temp;

endmodule
