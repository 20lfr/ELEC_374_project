`timescale 1ns / 1ps

module CLA_tb;

reg [31:0] A, B;
reg Cin;
wire C_out;
wire [31:0] S;

// Instantiate the Unit Under Test (UUT)
CLA_32bit_adder uut (
    .A(A), 
    .B(B), 
    .Cin(Cin), 
    .C_out(C_out), 
    .S(S)
);

initial begin
    // Initialize Inputs
    A = 0; B = 0; Cin = 0;

    // Monitor changes to observe the outputs
    $monitor("Time=%t, A=%h, B=%h, Cin=%b, S=%h, C_out=%b", $time, A, B, Cin, S, C_out);

    // Test Case 1: Simple Addition without Carry-in
    #10 A = 32'h0000_0001; B = 32'h0000_0001; Cin = 0;

    // Test Case 2: Addition with Carry-in
    #10 A = 32'h0000_FFFF; B = 32'h0000_0001; Cin = 1;

    // Test Case 3: Overflow and Carry-out
    #10 A = 32'hFFFF_FFFF; B = 32'h0000_0001; Cin = 0;

    // Test Case 4: Carry propagation through both blocks
    #10 A = 32'h0000_FFFF; B = 32'h0001_0000; Cin = 0;

    // Test Case 5: Large numbers addition
    #10 A = 32'h7FFF_FFFF; B = 32'h7FFF_FFFF; Cin = 0;

    // Test Case 6: Addition with both Carry-in and Carry-out
    #10 A = 32'hFFFF_FFFF; B = 32'h0000_0001; Cin = 1;

    // Test Case 7: Check carry propagation
    #10 A = 32'hFFFF_0000; B = 32'h0001_FFFF; Cin = 0;

end

endmodule
