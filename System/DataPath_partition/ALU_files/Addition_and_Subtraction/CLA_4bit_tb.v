`timescale 1ns / 1ps

module CLA_4bit_tb;

    reg [3:0] A, B;
    reg Cin;
    wire C_out, G_prime, P_prime;
    wire [3:0] S;

    // Instantiate the Unit Under Test (UUT)
    CLA_4bit_adder uut (
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
        $monitor("Time=%t, A=%b, B=%b, Cin=%b --> S=%b, C_out=%b, G_prime=%b, P_prime=%b", 
                 $time, A, B, Cin, S, C_out, G_prime, P_prime);

        // Test Case 1: Simple Addition without Carry
        #10 A = 4'b0101; B = 4'b0011; Cin = 0;

        // Test Case 2: Addition with Carry-in
        #10 A = 4'b1100; B = 4'b0101; Cin = 1;

        // Test Case 3: Full Carry Propagation
        #10 A = 4'b1111; B = 4'b0001; Cin = 0;

        // Test Case 4: No Carry Propagation
        #10 A = 4'b1010; B = 4'b0101; Cin = 0;

        // Test Case 5: Carry-out with no internal carry
        #10 A = 4'b1000; B = 4'b1000; Cin = 0;

        // Test Case 6: Group Propagate and Generate
        #10 A = 4'b0110; B = 4'b0011; Cin = 1;

        // Test Case 7: Edge Case - Overflow
        #10 A = 4'b1111; B = 4'b1111; Cin = 1;

    end

endmodule
