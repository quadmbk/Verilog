module wallace8x8(a,b,product); //8*8 multiplier
	input [7:0]a,b;
	output [15:0]product;

//***PARTIAL PRODUCTS
reg [7:0]part1;
wire [7:0]part2;
wire [7:0]part3;
wire [7:0]part4;
wire [7:0]part5;
wire [7:0]part6;
wire [7:0]part7;
wire [7:0]part8; 

initial 
begin
$display("here %b, %b,, ",a , b);
part1 = { a[7]&b[0], a[6]&b[0], a[5]&b[0], a[4]&b[0], a[3]&b[0], a[2]&b[0], a[1]&b[0], a[0]&b[0]};

end
endmodule

module wallace_tb;
	wire [15:0]product;
	reg [7:0]a,b;

	wallace8x8 a0(a,b,product);

wire [7:0]part11,a11,b11;
assign part11 = a0.part1;
//assign a11 = a0.a;

initial
begin
	a = 8'b11010011; b =8'b11001110;

end
initial $display("%b, %b, %b, ",a , b, part11);

endmodule