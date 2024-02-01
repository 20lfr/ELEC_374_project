`timescale 1ns / 1ps

module CLA_32bit_adder_tb;

    // Inputs
    reg [31:0] A;
    reg [31:0] B;
    reg Cin;
	 
	 reg [31:0] result_high;
	 reg [31:0] result_low;
	 reg [4:0]op;

    

    // Instantiate the Unit Under Test (UUT)
//    CLA_32bit_adder uut (
//        .A(A), 
//        .B(B), 
//        .Cin(Cin), 
//        .C_out(C_out), 
//        .G_prime(G_prime), 
//        .P_prime(P_prime), 
//        .S(S)
//    );
	 
	 ALU uut(A, B, op, result_low, result_high);

    // Test cases
    initial 
		begin
			  // Initialize Inputs
			  A = 0;
			  B = 0;
			  Cin = 0;

			  // Wait 100 ns for global reset to finish
			  #100;

			  // Apply test cases
			  op <= 2;
			  A <= 32'hF0000000; B <= 32'h00FF0000; Cin = 0;
			

			 
		end
      
endmodule
