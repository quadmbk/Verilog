module select_and_add(resetn,c,x1,x3,x5,x7,x9,x11,x13,x15,product);
input resetn;
input [8:0]c;
input [15:0] x1,x3,x5,x7,x9,x11,x13,x15;
output [15:0]product;

wire [15:0] product1, product2;
wire [15:0]shifted_output;


s_a sa0(resetn,c[3:0],x1,x3,x5,x7,x9,x11,x13,x15,product1);
s_a sa1(resetn,c[7:4],x1,x3,x5,x7,x9,x11,x13,x15,product2);
shiftby4 sh0(product2,shifted_output);


assign product = (c[8])?~(shifted_output + product1)+1'b1:shifted_output + product1;

endmodule
