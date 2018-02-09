module spi_slave(clk, rst, cs, in, load,  data_2_send, data_rcv, out, done);
	parameter word_size= 8;
	input load;
	input clk, cs, in, rst;
	input [word_size-1:0] data_2_send;
	output reg [word_size-1:0] data_rcv;
	output reg out , done;

reg [word_size-1:0] data_shft_in, data_shft_out; //shift registers;
reg shift , clr; //control signals;
reg [3:0]count;


always @(posedge clk) //sample input
begin
if(!cs) begin
		if(count != 8) begin 
		data_shft_in <={data_shft_in[6:0],in};
		count = count + 1;
		done= 0;
		end
		else begin
		done = 1'b1;
		data_rcv = data_shft_in;
		count = 0;
		end
	end
	else
		count = 0;
	
end

always @(negedge clk , posedge load )
begin
	if(!cs) begin
		out <= data_shft_out[7];
		data_shft_out <= {data_shft_out[6:0],1'b1};
	end
	if( load == 1) data_shft_out <= data_2_send;
	
end
always @(negedge rst)
count = 0;

endmodule
