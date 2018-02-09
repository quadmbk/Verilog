module shiftby4(input [15:0] data,
		output reg [15:0]out);

	always @(data) begin
		out<= data<<4;
	end

endmodule
