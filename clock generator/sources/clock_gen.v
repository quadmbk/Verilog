//`timescale 1ns/1ps
module clock_gen(clk, en, rst);
	parameter PERIOD = 4;
	parameter DUTY_CYCLE = 50 ;
	input en, rst;
	output reg clk;

always @(en, rst) begin
	if(rst == 1'b0) clk <= 1'b0;
	else
	begin
		//if (en == 1) begin
		while(en) begin		
		//clk <= 1'b0;
		#(PERIOD - (PERIOD*DUTY_CYCLE)/100) clk <= 1'b1;
		#(PERIOD*DUTY_CYCLE/100) clk <= 1'b0;
		end	
		//end//if en
	end//else
end//always
endmodule
