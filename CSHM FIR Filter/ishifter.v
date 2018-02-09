module ishifter(input resetn,
		input [15:0]product,
		input [2:0]shift,
	        output reg[15:0]shifted_product);
	
	always @(negedge resetn, product, shift) begin
		if(!resetn) begin
			shifted_product <= product<<shift;
		end//if
		
	end
	
endmodule
