module top(input resetn, clk,
	   input [7:0]x,
	   input [8:0]c0,c1,c2,c3,
	   output reg  [15:0]y,
	   output overflow
	  );
wire [15:0]p0,p1,p2,p3;

wire [15:0] x1,x3,x5,x7,x9,x11,x13,x15;

wire [15:0] x_d1,x_d3,x_d5,x_d7,x_d9,x_d11,x_d13,x_d15;
wire [15:0] sa1,sa0,sa2,sa3,sa4;

wire [15:0]add_out4,add_out1,add_out2,add_out3;
wire [15:0]q1,q2,q3;
//overflow bits to check overflow
wire ov0,ov1,ov2,ov3;

//initialize all registers 0
/*initial begin
p0 = 0;
p1 = 0;
p2 = 0;
p3 = 0;
end
*/

precomputer pre0(x, x1, x3, x5, x7, x9, x11, x13, x15);
//regiters at precomputer output
/*dff d0(x_d1,clk,x1);
dff d1(x_d3,clk,x3);
dff d2(x_d5,clk,x5);
dff d3(x_d7,clk,x7);
dff d4(x_d9,clk,x9);
dff d5(x_d11,clk,x11);
dff d6(x_d13,clk,x13);
dff d7(x_d15,clk,x15);
*/

select_and_add s0(resetn,c0,x1,x3,x5,x7,x9,x11,x13,x15,p0);
select_and_add s1(resetn,c1,x1,x3,x5,x7,x9,x11,x13,x15,p1);
select_and_add s2(resetn,c2,x1,x3,x5,x7,x9,x11,x13,x15,p2);
select_and_add s3(resetn,c3,x1,x3,x5,x7,x9,x11,x13,x15,p3);

//registers at select ad add units outputs

/*dff d8(sa0,clk,p0);
dff d9(sa1,clk,p1);
dff d10(sa2,clk,p2);
dff d11(sa3,clk,p3);
*/
//last stage filter adders
rca r0(p3,16'b0,add_out1,ov0);
rca r1(p2,q1,add_out2,ov1);
rca r2(p1,q2,add_out3,ov2);
rca r3(p0,q3,add_out4,ov3);


//inter adder delay elements
dff d12(q1,clk,add_out1);
dff d13(q2,clk,add_out2);
dff d14(q3,clk,add_out3);

always @(posedge clk)
 y = add_out4;

assign overflow = ov0 | ov1 | ov2 | ov3;

endmodule


module dff(q,clk,d);
parameter size = 16;
input [size-1:0]d;
input clk;
output reg [size-1:0]q;
initial q <= 0;
always @(posedge clk)
begin
	q <= d;
end
endmodule

module tb_top;
reg resetn;
reg  [7:0]x;
reg  [8:0]c0,c1,c2,c3;
wire  [15:0]y;
wire overflow;
reg clk;

	top t0(resetn,clk,x,c0,c1,c2,c3,y,overflow);
initial begin
clk = 0;
forever #5 clk = ~clk;
end

initial begin
	x = 0 ;resetn = 1;
	#1 resetn = 0;
	c0 =9'b1_0000_0010 ; c1 =1_0000_0001 ; c2 =9'b0_0000_0011 ; c3 =9'b0_0000_0100 ;
	
        #20
	 x = -3; #10;
         x = 1;  #10;
         x = 0;  #10;
         x = -2; #10;
         x = -1; #10;
         x = 4;  #10;
         x = -5; #10;
         x = 6;  #10;
         x = 0;  #10;

end
endmodule
