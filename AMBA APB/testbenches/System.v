module apb_system;
	parameter data_size = 8;
	parameter address_size = 5;
	parameter slaves = 2;
	//parameter address = address_size + slaves;
 	wire [7:0] ram0,ram16,ram31,ram10,ram116,ram131;

	wire [1:0]state_s0,next_s0,state_s1,next_s1;

	wire penable,  pwrite, pready,slave1_ready,slave2_ready;  
	wire [data_size-1 :0] pwdata;
	wire [slaves-1:0]pselx;
	wire [data_size-1:0] prdata,slave1,slave2;
	wire [address_size-1:0] paddr;
	
	wire [data_size-1:0] read_data_out;

	reg transfer;
	reg [data_size-1:0] data_2_write;
	reg  [slaves-1:0]select;
	reg [address_size-1:0] address;
	reg rw;
	
	reg clock, resetn;
	
	
	apb_bridge m0(transfer,data_2_write,select,address,rw, pready,clock,resetn,
		  pselx, penable, pwrite, paddr, pwdata,prdata, read_data_out, 
		  );

	slave s0(pselx[0], penable, pwrite, paddr, pwdata, slave1_ready, clock, resetn, slave1 );
	slave s1(pselx[1], penable, pwrite, paddr, pwdata, slave2_ready, clock, resetn, slave2 );
	tri_gate_8 t8_0(slave1,pselx[0],prdata);
	tri_gate_1 t1_0(slave1_ready,pselx[0],pready);
	
	tri_gate_8 t8_1(slave2,pselx[1],prdata);
	tri_gate_1 t1_1(slave2_ready,pselx[1],pready);
	

	assign state_s0 = s0.state;
	assign next_s0  = s0.next_state;
	
	assign state_s1 = s1.state;
	assign next_s1  = s1.next_state;
	 	

	assign ram0 = s0.ram[0];
	assign ram16= s0.ram[16];
	assign ram31= s0.ram[31];
	
	assign ram10 = s1.ram[0];
	assign ram116= s1.ram[16];
	assign ram131= s1.ram[31];

	initial begin clock <= 0; forever #1 clock <= ~clock; end

	initial begin
	$monitor ("%h ", read_data_out);
	transfer = 1; data_2_write = 8'h2a; select = 2'b01; address = 5'b0_0000; rw = 1'b0;resetn = 1'b0;
#15	transfer = 1; data_2_write = 8'h2c; select = 2'b01; address = 5'b1_0000; rw = 1'b1;resetn = 1'b0;
#15	transfer = 1; data_2_write = 8'h2a; select = 2'b01; address = 5'b1_1111; rw = 1'b1;resetn = 1'b0;
#15	transfer = 1; data_2_write = 8'h2a; select = 2'b01; address = 5'b1_0000; rw = 1'b0;resetn = 1'b0;
		
#15	transfer = 1; data_2_write = 8'h2a; select = 2'b10; address = 5'b0_0000; rw = 1'b1;resetn = 1'b0;
#15	transfer = 1; data_2_write = 8'h2c; select = 2'b10; address = 5'b1_0000; rw = 1'b1;resetn = 1'b0;
#15	transfer = 1; data_2_write = 8'h2a; select = 2'b10; address = 5'b1_1111; rw = 1'b1;resetn = 1'b0;
#15	transfer = 1; data_2_write = 8'h2a; select = 2'b10; address = 5'b1_0000; rw = 1'b0;resetn = 1'b0;
		

		
	end
endmodule
