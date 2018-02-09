module and_gate(input [15:0]in1,
		input [3 :0]in2,
		output reg[15:0]out
			
		);

always @(in1,in2) begin
	if(in2 == 0)
		out <= 0;
	else
		out <= in1;
end
endmodule