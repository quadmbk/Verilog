module slave(pselx, penable, pwrite, paddr, pwdata, pready, clock, resetn, prdata );
	/*** THIS SLAVES INTRODUCES TWO WAIT STATES ***/
	parameter WAIT_CYCLES = 2;
	parameter data_size = 8;
	parameter address_size = 5;
	parameter idle = 2'b01,setup = 2'b10, access = 2'b11;

	parameter wait_nowait = 1'b1;
	
	input pselx, penable, pwrite, clock, resetn;
	input [data_size-1:0] pwdata;
	input [address_size-1:0] paddr;
	
	output reg pready;
	output reg [data_size-1:0] prdata;
	
		//state variables
	reg[1:0] state, next_state;

	reg [1:0]wait_on;// to introduce wait states.

	//the slave component
	reg [data_size-1:0]ram[0:31];
	
	reg [data_size-1:0] write_data;
	reg [address_size-1:0] addr;

	reg rw,select;

	integer k;

	initial begin //initialising memeo=ry 
	for(k = 0; k < 32 ;k = k+1) begin
		ram[k] <= 8'h00;
	end
	wait_on <= 2'b00;
	state <= idle;
	end

	
	always @(posedge clock) begin
		
		select <= pselx;
		if(select == 1'b1)
			state <= next_state;
	end
	
	always @(state, select) begin
		case(state)
		idle : begin
			
			next_state <= idle;	
			if(select == 1'b1) begin 
				 pready <=1'b0;
				next_state <= setup;
		        end
			end
		setup : begin
			pready <= 0;
			write_data <= pwdata;
			rw <= pwrite;
			addr <= paddr;
			next_state <= access;
			
			end

		access : begin
			@(posedge clock);
				@(posedge clock);
				
			pready <= 1'b1;
			if(penable && rw) begin : write
					next_state <= idle;
			 		ram[addr] <= pwdata;
				end else if(penable && rw==1'b0) begin : read
					next_state <= idle;
					prdata <= ram[addr];
				end
			 /*
			 if(wait_on == WAIT_CYCLES) begin
				wait_on <= 2'b00;
				pready <= 1'b1;
				if(penable && rw) begin : write
					next_state <= idle;
					ram[addr] <= pwdata;
				end else if(penable && rw==1'b0) begin : read
					next_state <= idle;
					prdata <= ram[addr];
				end
			 end else begin
			 	next_state <= access;
				pready <= 1'b0;
				wait_on <= wait_on +2'b01;*/
			 end

			/*if(penable && rw) begin next_state <= idle;
			pready <= wait_nowait;
			// if(penable && pready) 
			@(negedge penable)ram[addr] <= pwdata
;
			end
			else if(penable && ~rw) begin
			next_state <= idle;
			pready <= wait_nowait;
			#5 pready <= ~pready;
			//if(penable && pready)
			@(negedge penable) prdata <= ram[addr];
			
			end*/
			
			
	

		
		default: next_state <= idle; 
		endcase
	end
endmodule
