
module adder_subtractor(mode,a,b,s,cout);
input [15:0]a,b;
input mode; //add= 0; sub = 1;
output [15:0]s;
output  cout;

wire [15:0] opr_2;

assign opr_2 = (mode)?~b:b;
wire [14:0]c;

fa f0(a[0],opr_2[0],mode,s[0],c[0]);
fa f1(a[1],opr_2[1],c[0],s[1],c[1]);
fa f2(a[2],opr_2[2],c[1],s[2],c[2]);
fa f3(a[3],opr_2[3],c[2],s[3],c[3]);
fa f4(a[4],opr_2[4],c[3],s[4],c[4]);
fa f5(a[5],opr_2[5],c[4],s[5],c[5]);
fa f6(a[6],opr_2[6],c[5],s[6],c[6]);
fa f7(a[7],opr_2[7],c[6],s[7],c[7]);
fa f8(a[8],opr_2[8],c[7],s[8],c[8]);
fa f9(a[9],opr_2[9],c[8],s[9],c[9]);
fa f10(a[10],opr_2[10],c[9],s[10],c[10]);
fa f11(a[11],opr_2[11],c[10],s[11],c[11]);
fa f12(a[12],opr_2[12],c[11],s[12],c[12]);
fa f13(a[13],opr_2[13],c[12],s[13],c[13]);
fa f14(a[14],opr_2[14],c[13],s[14],c[14]);
fa f15(a[15],opr_2[15],c[14],s[15],cout);
	
endmodule

module fa(a,b,cin,s,cout);
input a,b,cin;
output s,cout;

assign s = a^b^cin;
assign cout = a&b | b&cin | cin&a;
endmodule
module tb;
	wire cout;
	wire [15:0]s;
	reg [15:0]a,b;
	reg mode;
	
adder_subtractor a0(mode,a,b,s,cout);

initial begin
	a = -3;b = -2; mode = 0;
#1	
	a = -3;b = 2; mode = 1;
#1	
	a = 3;b = -2; mode = 1;
#1	
	a = 3;b = 2; mode = 0;
#1	
	a = 3;b = 2; mode = 1;
#1	
	a = -3;b = -2; mode = 0;
#1	
	a = -3;b = -2; mode = 0;
#1	
	a = -3;b = -2; mode = 0;
end
endmodule
