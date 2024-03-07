`timescale 1ns / 1ps

module CLA_16bit_adder_tb;

reg [15:0] A, B;
reg Cin;
wire C_out, G_prime, P_prime;
wire [15:0] S;

// Instantiate the Unit Under Test (UUT)
CLA_16bit_adder uut (
    .A(A), 
    .B(B), 
    .Cin(Cin), 
    .C_out(C_out), 
    .G_prime(G_prime), 
    .P_prime(P_prime),
    .S(S)
);

initial begin
    // Initialize Inputs
    A = 0; B = 0; Cin = 0;

    // Monitor changes to observe the outputs
    $monitor("Time=%t, A=%h, B=%h, Cin=%b --> S=%h, C_out=%b, G_prime=%b, P_prime=%b", 
             $time, A, B, Cin, S, C_out, G_prime, P_prime);

    // Test Case 1: Simple Addition without Carry
    #10 A = 16'h1234; B = 16'h4321; Cin = 0;

    // Test Case 2: Addition with Carry-in
    #10 A = 16'hFFFF; B = 16'h0001; Cin = 1;
	 
	 // Test Case 2: Addition with Carry-in
    #10 A = 16'hFFFF; B = 16'h0001; Cin = 0;

    // Test Case 3: Full Carry Propagation
    #10 A = 16'hFFFF; B = 16'hFFFF; Cin = 0;

    // Test Case 4: No Carry Propagation
    #10 A = 16'hA0A0; B = 16'h0505; Cin = 0;

    // Test Case 5: Carry-out with no internal carry
    #10 A = 16'h8000; B = 16'h8000; Cin = 0;

    // Test Case 6: Group Propagate and Generate (Testing G_prime and P_prime)
    #10 A = 16'hF0F0; B = 16'h0F0F; Cin = 1;

    // Test Case 7: Edge Case - Overflow
    #10 A = 16'hFFFF; B = 16'hFFFF; Cin = 1;

end

endmodule
