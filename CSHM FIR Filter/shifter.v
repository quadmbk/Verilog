module shifter( input resetn,
		input [3:0]c,
	        output reg[2:0]shift,select
	 
		);
reg choose_select;
reg [3:0]temp;
	/*initial begin
			temp <= 0;
			shift <= 0;
	end
*/
	always @(c, negedge resetn) begin
		if(!resetn) begin 
		
		if(c != 0)temp = c;
		else temp=4'b1111;

		shift =  3'b000;
		while(temp[0]!= 1'b1)
		begin
			$display("Here");		
			temp = temp >> 1;
			shift = shift + 1; 
		end
		
		choose_select = 1;
		end//if
		else begin	
			temp <= 0;
			shift <= 0;
			choose_select <= 1'b0;
		end//else
	end

	always@(choose_select)
		if(choose_select == 1)begin 
		case(temp)
		1  : select <= 0;
		2  : select <= 0;
		3  : select <= 1;
		4  : select <= 0;
		5  : select <= 2;
		6  : select <= 1;
		7  : select <= 3;
		8  : select <= 0;
		9  : select <= 4;
		10 : select <= 2;
		11 : select <= 5;
		13 : select <= 6;
		14 : select <= 3;
		15 : select <= 7;

		default : select = 0;
		endcase
		end//if
		else select = 0;
endmodule

module tb;
reg resetn;	
reg [3:0]c;
wire[3:0]temp;
wire [2:0]select,shift;
	
	shifter s1(resetn, c, shift, select);
	
assign temp = s1.temp;
initial
begin
	resetn = 1'b1;
	#1 resetn = 1'b0;
	
	
	c = 0100;
	#3 c = 1000;
 
end
endmodule