
module booth(mplier,mcand,prod);
	parameter size_a = 8,size_b = 8;

	input signed[size_a-1 : 0]mplier;
	input signed[size_b-1 : 0]mcand;
	output  signed [size_a + size_b -1 : 0]prod;

/*integer i;
reg [1:0]temp;
reg [size_b-1:0]k;
always @(mplier,mcand) begin
	prod = mplier;
	$display("initial values : prod = %b, mcand = %b, mplier = %b",prod,mcand,mplier);
	for(i = 0;i<size_b;i = i+1)
	begin
		if(i == 0) temp = {mcand[i],1'b0};
		else temp = {mcand[i],mcand[i-1]};
		$display("temp:%b",temp);
		case(temp)
			2'b00 : begin $display("prod in 00:%b",prod);prod = prod>>>1;$display("prod out 00:%b",prod);end //nop
			2'b01 : begin 
				
				prod = prod + mcand;
				prod = prod>>>1;$display("prod in 01:%b, mcand = %b",prod, mcand);
				end//end of 1's prod = prod+Mcand
			2'b11 : begin prod = prod>>>1;$display("prod in 11:%b",prod);end//nop
			2'b10 :	begin
				$display("mcand before in 10 : %b",mcand);
				k = mcand  ;
				prod = prod - mcand;
				prod = prod>>>1;
				$display("prod in 10:%b, mcand = %b",prod, ~mcand+1'b1);
				end//beg of 1's prod = prod -mcand
		endcase

	end//for	

end*/
assign prod = mcand * mplier;
endmodule
module tb_mult;
wire [15:0]prod;
reg [7:0]mplier,mcand;

	booth b0(mplier,mcand,prod);
initial begin
	#1 mplier = -3; mcand = 2;
	#1 mplier = -3; mcand = -2;
	#1 mplier = 3; mcand = -2;
	#1 mplier = 3; mcand = 2;
	#1 mplier = -3; mcand = 2;
	
end
endmodule
