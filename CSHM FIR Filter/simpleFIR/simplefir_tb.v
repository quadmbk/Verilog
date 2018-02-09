module simplefir_tb();
	wire signed[15:0] y;
	reg  clk;
	reg  signed[7 :0]Xin;

	fir f0(y,Xin,clk);

initial begin
	clk = 0; forever #5 clk <= ~clk;
end

initial begin
	#20
	 Xin = -3; #10;
          Xin = 1;  #10;
          Xin = 0;  #10;
          Xin = -2; #10;
          Xin = -1; #10;
          Xin = 4;  #10;
          Xin = -5; #10;
          Xin = 6;  #10;
          Xin = 0;  #10;
end
endmodule
