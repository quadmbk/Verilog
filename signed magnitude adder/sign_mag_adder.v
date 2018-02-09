module sign_mag_adder #(parameter N = 4)
	( output reg [N-1 :0]sum,
	  input  [N-1:0] a, b);

	reg [N-2:0] mag_a, mag_b, mag_sum, max, min;
	reg sign_a, sign_b, sign_sum;

	
always @* begin
	mag_a = a[N-2:0];
	mag_b = b[N-2:0];
	sign_a = a[N-1];
	sign_b = b[N-1];
	
	if(mag_a >= mag_b) begin
		max = mag_a;
		min = mag_b;
		sign_sum = sign_a;

	end //if
	else begin
		max = mag_b;
		min = mag_a;
		sign_sum = sign_b;
	end//else

	if(sign_a == sign_b)
		mag_sum = max + min;
	else 
		mag_sum = max - min; 

	sum = {sign_sum, mag_sum};
	
end//always
endmodule


