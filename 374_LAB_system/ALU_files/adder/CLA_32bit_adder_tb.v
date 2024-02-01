`timescale 1ns / 1ps

module CLA_32bit_adder_tb;

    // Inputs
    reg [31:0] A;
    reg [31:0] B;
    reg Cin;

    // Outputs
    wire C_out;
    wire G_prime;
    wire P_prime;
    wire [31:0] S;

    // Instantiate the Unit Under Test (UUT)
    CLA_32bit_adder uut (
        .A(A), 
        .B(B), 
        .Cin(Cin), 
        .C_out(C_out), 
        .G_prime(G_prime), 
        .P_prime(P_prime), 
        .S(S)
    );

    // Test cases
    initial begin
        // Initialize Inputs
        A = 0;
        B = 0;
        Cin = 0;

        // Wait 100 ns for global reset to finish
        #100;

        // Apply test cases
        A = 32'h55555555; B = 32'hAAAAAAAA; Cin = 0; #10;
        A = 32'hFFFFFFFF; B = 32'h00000001; Cin = 0; #10;
        A = 32'h80000000; B = 32'h80000000; Cin = 1; #10;

    end
      
endmodule
