module tb;
	parameter N=4;
	reg [N-1 :0] a,b;
	wire [N-1:0] sum;
	sign_mag_adder a0(sum,a,b);

	reg [N-2 :0] mag_a, mag_b, mag_sum;
	reg sign_a, sign_b,sign_sum;
	reg str_a, str_b, str_sum;	
	initial begin
		a = 4'h0; //b = 4'h0;
		repeat(16) begin
			b = 4'h0;
			repeat(16)
			#1	b = b+1;
			
			a = a+1;
		end
		
	end		

	/*always @(a,b,sum) begin
		if
	
	end
*/
	initial begin
		$monitor($time,,, "%b, %d + %b,%d = %b, %d",a[N-1],a[N-2:0],b[N-1],b[N-2:0],sum[N-1],sum[N-2:0]);
		#100 $stop;
end


endmodule
