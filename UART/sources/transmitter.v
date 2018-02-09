module transmitter(serial_out, byte_ready, t_byte,load_XMT_datareg,clock,resetn, input_data );
	parameter SIZE = 8;
	parameter all_ones = 9'b1111_1111_1;
	
	output serial_out;
	input clock,resetn,byte_ready,t_byte,load_XMT_datareg;
	input [SIZE-1:0]input_data;

	//STATES
	parameter idle = 2'b01;//1
	parameter sending =2'b10 ;//2
	parameter waiting =2'b11 ;//3
	
	//PRESENT AND NEXT STATE VARIABLES
	reg [1 :0]next_state,state;

	reg [3 :0] bit_count;
	reg load_XMT_shftreg, start,shift, clear;
	
	
	
	reg [SIZE :0] XMT_shftreg; //shift register of size 9 bits
	reg [SIZE-1:0] XMT_datareg;

	assign serial_out = XMT_shftreg[0];
	//STATE TRANSITIONS
	always @(posedge clock or negedge resetn)
	begin
		if(resetn == 1'b0) state = idle; else state = next_state; 
	end
	
	//CONTROLLER LOGIC
	always @(state, byte_ready,t_byte,bit_count) begin 
		start = 1'b0;
		shift = 1'b0;
		clear = 1'b0;
		load_XMT_shftreg = 1'b0;
		next_state = state;
	
		case(state) 
			idle : begin 
				if(byte_ready == 1'b1) begin 
				  load_XMT_shftreg = 1'b1;
				  next_state = waiting;
				 end
				else next_state = idle;
				end
			
			waiting : begin
				   if(t_byte ==1'b1) begin
					start = 1'b1;
					next_state = sending;

				   end
				   else next_state = waiting;
				  end

			sending : begin
				   if(bit_count != SIZE + 1)
					shift = 1'b1;
				   else begin
					clear = 1'b1;
					next_state = idle;
					end
				  end
			default : next_state = idle;
		endcase

	
	
	end

	//DATA SEGMENT
	always @(posedge clock or negedge resetn) begin
	if(resetn == 0'b0) begin
		XMT_shftreg <= all_ones;
		bit_count <= 3'b0;
	end	
	else begin
		if(load_XMT_datareg==1'b1)
			XMT_datareg <= input_data;
		if(load_XMT_shftreg == 1'b1)
			XMT_shftreg <= {XMT_datareg, 1'b1};
		if(start == 1'b1)
			XMT_shftreg[0] <= 1'b0;
		if(clear == 1'b1)
			bit_count <= 0;
		else if(shift ==1'b1) bit_count <= bit_count + 3'b001;

		if(shift == 1'b1)
			XMT_shftreg <= {1'b1, XMT_shftreg[SIZE : 1]};
	end
	end	

endmodule