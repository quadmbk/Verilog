`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:29:13 03/25/2017 
// Design Name: 
// Module Name:    counter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module counter(
    input clk,
    
    output reg [6:0] count,
    output reg[3:0] sel
    );
	reg clk1,clk2;
	integer i,j;
	reg [3 : 0] count1,count2,count3;
	
	initial
	begin
		clk1   = 0;
		clk2   = 0;
		i      = 0;
		j      = 0;
		count1 = 0;
	   count3 = 0;
		count2 = 0;
		count  = 7'b1111111;
		sel    = 4'b1101;
	end
	
always @(posedge clk)
	begin
		if(i == 25000000)
		 begin
		 clk1 <= ~clk1;
		 i <= 0;	
		 end
		else
			i <= i+1;
	end

always @(posedge clk)
	begin
		if(j == 50000)
			begin
				clk2 <= ~clk2;
				j <= 0;
			end
		else
			begin
				j <= j+ 1;
			end	
	end

always @(posedge clk1)
	begin
			if(count1 <9)
				begin
						count1 <= count1 + 1;
						end
			else
				begin
							count1 <= 0;
						if(count2 <= 9)
						begin
								count2 <= count2 + 1;
						end
						else
						begin
						count2 <= count2 + 1 ;
					
						end
				
				end
	end

always @(posedge clk2)
begin
	if(sel == 4'b1110)
		sel <= 4'b1101;
	else 
		sel <= sel + 1;

end	

always @(sel or count1 or count2)
begin
	case (sel)
		4'b1101 : count3 <= count2;
		4'b1110 : count3 <= count1;
		
	default : count3 <= 4'b1111; 
	endcase
end		

always @(count3)
begin
	case(count3) 
	   0 : count=7'b0000001;
		1 : count=7'b1001111;
		2 : count=7'b0010010;
		3 : count=7'b0000110;
		4 : count=7'b1001100;
		5 : count=7'b0100100;
		6 : count=7'b0100000;
		7 : count=7'b0001111;
		8 : count=7'b0000000;
		9 : count=7'b0000100;
		default : count=7'b1111110;
	 endcase	
end	

endmodule
