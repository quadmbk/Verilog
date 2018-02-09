//`timescale 1ns/1ps

module clcok_gen_tb;
	wire clock;
	reg enable, reset;
	clock_gen c1(.clk(clock),
		     .en(enable),
		     .rst(reset)
		     );
	defparam c1.DUTY_CYCLE = 75; 

initial begin
	enable = 1; reset = 0;
	#1 reset = 1;
#40	enable = 0;reset =0;
end
endmodule
