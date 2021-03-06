module fir_4tap(Clk,Xin,Yout);
    
    //inputs and outputs
    input Clk;
    input signed [7:0] Xin;
    output signed[15:0] Yout;
    //Internal variables.
    reg signed[15:0] Yout;
    reg   signed[7:0] H0,H1,H2,H3;
    reg    signed[15:0] MCM0,MCM1,MCM2,MCM3,add_out1,add_out2,add_out3;
    wire   signed[15:0] Q1,Q2,Q3;
    
initial begin
MCM0 = 0;
MCM1 = 0;
MCM2 = 0;
MCM3 = 0;
add_out1 = 0;
add_out2 = 0;
add_out3 = 0;

    
end
//filter coefficient initializations.
//H = [-2 -1 3 4].
always @(H0,H1,H2,H3,Xin) begin
     H0 = -2;
     H1 = -1;
     H2 = 3;
     H3 = 4;

//Multiple constant multiplications.
     MCM3 = H3*Xin;
     MCM2 = H2*Xin;
     MCM1 = H1*Xin;
     MCM0 = H0*Xin;
end
//adders
always @(Q1, Q2, Q3, MCM2, MCM1, MCM0) begin
     add_out1 = Q1 + MCM2;
     add_out2 = Q2 + MCM1;
     add_out3 = Q3 + MCM0;    
end

//flipflop instantiations (for introducing a delay).
    DFF dff1 (.Q(Q1),.Clk(Clk),.D(MCM3));
    DFF dff2 (.Q(Q2),.Clk(Clk),.D(add_out1));
    DFF dff3 (.Q(Q3),.Clk(Clk),.D(add_out2));

//Assign the last adder output to final output.
    always@ (posedge Clk)
        Yout <= add_out3;

endmodule

module DFF(Q,Clk,D);

    input Clk;
    input [15:0] D;
    output [15:0] Q;
    reg [15:0] Q;
    initial Q = 0;
    always@ (posedge Clk)
        Q = D;
    
endmodule



module tb;

    // Inputs
    reg Clk;
    reg signed [7:0] Xin;

    // Outputs
    wire signed [15:0] Yout;

    // Instantiate the Unit Under Test (UUT)
    fir_4tap uut (
        .Clk(Clk), 
        .Xin(Xin), 
        .Yout(Yout)
    );
    
    //Generate a clock with 10 ns clock period.
    initial Clk = 0;
    always #5 Clk =~Clk;

//Initialize and apply the inputs.
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
/*  #20;
          Xin = 3; #10;
          Xin = 1;  #10;
         Xin = 0;  #10;
          Xin = 2; #10;
          Xin = 1; #10;
          Xin = 4;  #10;
          Xin = 5; #10;
          Xin = 6;  #10;
          Xin = 0;  #10;
    */end
      
endmodule
