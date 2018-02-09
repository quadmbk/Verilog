module select(resetn,coeff,x1,x3,x5,x7,x9,x11,x13,x15,product);
input resetn;
input signed[7:0]coeff;
input signed[11:0] x1,x3,x5,x7,x9,x11,x13,x15;
output signed[15:0]product;

wire signed[11:0] product1, product2;
wire signed[15:0]shifted_output;
wire [7:0]c;
assign c = ~coeff + 1'b1;
s_a sa0(resetn,c[3:0],x1,x3,x5,x7,x9,x11,x13,x15,product1);
s_a sa1(resetn,c[7:4],x1,x3,x5,x7,x9,x11,x13,x15,product2);
shiftby4 sh0(product2,shifted_output);

assign product = shifted_output + product1;

endmodule
