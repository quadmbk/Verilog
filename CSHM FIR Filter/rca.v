module rca(a,b,s,ov);
input  [15:0]a,b;
output [15:0]s;
output ov;
wire   [14:0]c;

full_adder f0(a[0],b[0],1'b0 ,s[0],c[0]);
full_adder f1(a[1],b[1],c[0],s[1],c[1]);
full_adder f2(a[2],b[2],c[1],s[2],c[2]);
full_adder f3(a[3],b[3],c[2],s[3],c[3]);
full_adder f4(a[4],b[4],c[3],s[4],c[4]);
full_adder f5(a[5],b[5],c[4],s[5],c[5]);
full_adder f6(a[6],b[6],c[5],s[6],c[6]);
full_adder f7(a[7],b[7],c[6],s[7],c[7]);
full_adder f8(a[8],b[8],c[7],s[8],c[8]);
full_adder f9(a[9],b[9],c[8],s[9],c[9]);
full_adder f10(a[10],b[10],c[9],s[10],c[10]);
full_adder f11(a[11],b[11],c[10],s[11],c[11]);
full_adder f12(a[12],b[12],c[11],s[12],c[12]);
full_adder f13(a[13],b[13],c[12],s[13],c[13]);
full_adder f14(a[14],b[14],c[13],s[14],c[14]);
full_adder f15(a[15],b[15],c[14],s[15],ov);

endmodule

module full_adder(a,b,cin,s,carr);
input a,b,cin;
output s,carr;

assign s = a^b^cin;
assign carr = (a&b)|(b&cin)|(cin&a);

endmodule

module rca_tb;
reg [15:0]a,b;
wire [15:0]s;
wire ov;

rca rca0(a,b,s,ov);

initial begin
	a = -1; b = -2;
#1
	a = -11; b = 2;
#1
	a = 1; b = 20;
#1
	a = 0; b = -2;
#1
	a = -1; b = -2;
#1
	a = -18; b = -2;
#1
	a = 1; b = -2;

end
endmodule