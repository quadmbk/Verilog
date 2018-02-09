module spi_master(clk,rst, start, data_2_send, in, data_rcv, done, out, sck,cs);
	parameter word_size = 8;
	parameter idle = 2'b01, send = 2'b10, finish = 2'b11;

	input clk, rst, start, in;
	input [word_size-1:0] data_2_send;
	output reg[word_size-1:0] data_rcv;
	output reg done, out, sck, cs;

	reg [1 :0] state , next_state;

	reg [word_size-1:0] data_shft_out, data_shft_in; // shift registers
	reg [3:0] count;
	reg shift ,clr; //control signals

	always @(posedge clk) begin
		if(rst == 0) begin
			state = finish; count = 0;end
		else 
			state <= next_state;
	end//always(posedge clk)

	always  @(state,count,start ) begin
	
		case(state) 
			idle : begin
				
				next_state = idle;
				if(start == 1'b1) begin 
				 count = 0;
				 next_state =  send; 
				 data_shft_out = data_2_send;
				 done = 1'b0;
				end//if(start == 1)
			       end//idle

			send : begin
				if(count != 8) begin
				  next_state = send; 
				  //sck = ~sck;
				  cs = 0;
				  shift = 1'b1;
				end//if(count != 8
				else
				begin 
				 done = 1'b1;
				 data_rcv = data_shft_in;
				 next_state=finish;
				end//else
			       end // send

			finish : begin
			
				 shift = 0;
				 sck = 1;
				 cs = 1;
				 next_state = idle;
				 end
		endcase
	end//always@(state)

always @(posedge clk ) // sample input
begin
	if(!cs) begin
		sck = ~sck;
		count = count + 1;
		if(shift == 1)data_shft_in = {data_shft_in[6:0],in};
	end//if(!cs)
	
			
end //always @(posedge clk)

always @(negedge clk) begin

	if(!cs) begin
		sck <= ~sck;
		out <= data_shft_out[7];
		if(shift==1)data_shft_out<= {data_shft_out[6:0],1'b1};
	end//if(!cs)
	else out <=1'bz;
end//always-negedgeclk
endmodule
