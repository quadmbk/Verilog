module apb_bridge(transfer,data_2_write,select,address,rw, pready,clock,resetn,
		  pselx, penable, pwrite, paddr, pwdata,prdata, read_data_out, 
		  );
parameter data_size = 8;
parameter address_size = 5;
parameter slaves = 2;

parameter idle = 2'b01, setup = 2'b10, access = 2'b11;
reg [1 : 0]state,next_state;
reg t,pr;
input transfer,rw;
input [address_size-1:0]address;
input [slaves-1:0]select;
//input select;
input pready, clock,resetn;
input [data_size-1:0]data_2_write;

output reg[data_size-1:0] pwdata;
input [data_size-1:0]prdata;

output  reg [data_size-1:0]read_data_out ;

output reg [address_size-1:0]paddr;
output reg[slaves-1:0]pselx;
//output reg pselx;
initial state <= idle;

output reg penable,pwrite;

always @(posedge clock) begin
	t <= transfer; pr <= pready;
	
	state <= next_state;

end

always @(state,t,pready) begin
	case(state)
		idle : begin
			penable = 0;
			pselx = 0;
			next_state <= idle;
			if(t) next_state <= setup;
		       end

		setup : begin
			pselx  <= select;
			paddr  <= address;
			pwdata <= data_2_write;
			penable<= 1'b0;
			pwrite <= rw;
			next_state <= access;
			end
		access : begin
			$display($time," %b",pready);
			 penable <= 1'b1;
			 if(pwrite == 1'b0&& pready == 1'b1) read_data_out <= prdata;
			 if(pready == 1'b0) next_state <= access;
			 else begin
				next_state <= idle;
				if(t)next_state <= setup;
			 end
			end

		default : next_state<=idle;
	endcase
end

endmodule
