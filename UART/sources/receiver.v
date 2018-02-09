module receiver(RCV_datareg, read_not_ready_out, error1, error2, read_not_ready_in, 
		sample_clock,resetn, serial_in );


parameter SIZE = 8;
parameter HALFSIZE = SIZE/2;

parameter idle = 2'b01;
parameter starting = 2'b10;
parameter receiving = 2'b11;


output reg [SIZE-1 : 0] RCV_datareg;
output read_not_ready_out, error1, error2;

input read_not_ready_in,sample_clock,resetn,serial_in;

reg [SIZE : 0] 	 RCV_shftreg;

reg [3 : 0] sample_counter;
reg [3 : 0] bit_counter;

reg [2 :0] state,next_state;	
	
reg inc_bit_counter, clr_bit_counter;
reg inc_sample_counter, clr_sample_counter;
reg shift,load,read_not_ready_out,error1,error2;

always @(posedge sample_clock) begin
	if(resetn == 1'b0) begin
		state <= idle;
		sample_counter <= 0;
		bit_counter <= 0;
		RCV_datareg <= 0;
		RCV_shftreg <= 0;
	end else begin
		state <= next_state;
		
		if(clr_sample_counter==1'b1)sample_counter <=0;
		else if(inc_sample_counter == 1'b1)sample_counter <= sample_counter +1;
		
		if(clr_bit_counter == 1'b1)bit_counter <= 0;
		else if(inc_bit_counter == 1'b1)bit_counter <= bit_counter+ 1;

		if(shift == 1'b1) RCV_shftreg <= {serial_in, RCV_shftreg[SIZE-1 : 1]};
		if(load == 1'b1) RCV_datareg <= RCV_shftreg;

	end
	end
	always @(serial_in, state, sample_counter, bit_counter, read_not_ready_in) begin
		
		read_not_ready_out = 0;
		next_state = idle;
		clr_bit_counter = 0;
		inc_bit_counter =0;
		clr_sample_counter = 0;
		inc_sample_counter = 0;
		shift = 0;
		load = 0;
		error1 = 0;
		error2 = 0;

		case(state)
		idle : begin
			if(serial_in == 1'b0) next_state = starting;
			else next_state = idle;
			end
		starting : begin
			   if(serial_in == 1) next_state = idle;
			   else if(sample_counter == 3)begin
				next_state = receiving;
				clr_sample_counter = 1;
				end 	
			   else begin
				inc_sample_counter = 1;
				next_state = starting;	
				end
			   end
		receiving : begin
			    if(sample_counter < 7) begin next_state = receiving;inc_sample_counter = 1;end
			    else begin
				clr_sample_counter = 1'b1;
				if(bit_counter!= SIZE)begin
				shift = 1'b1;
				inc_bit_counter = 1'b1;
				next_state = receiving;
				end
				else begin
				next_state = idle;
				read_not_ready_out = 1;
				clr_bit_counter = 1;
				if(read_not_ready_in == 1) error1 = 1;
				else if(serial_in == 0) error2 = 1;
				else load = 1;
							
				end
				end	
			end
		
		default : next_state = idle;
		endcase
	end

endmodule

