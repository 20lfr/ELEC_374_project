`timescale 1ns / 1ps

module add_sub_tb;

    reg [31:0] A, B;
    reg signed_flag, subtract_enable, Cin;
    wire C_out;
    wire [63:0] S;

    // Instantiate the Unit Under Test (UUT)
    add_sub uut (
        .A(A), 
        .B(B), 
        .signed_flag(signed_flag), 
        .subtract_enable(subtract_enable),
        .Cin(Cin), 
        .C_out(C_out), 
        .S(S)
    );

    initial begin
        // Initialize Inputs
        A = 0; B = 0; signed_flag = 0; subtract_enable = 0; Cin = 0;

        // Monitor changes to observe the outputs
        $monitor("Time=%t, A=%d, B=%d, signed_flag=%b, subtract_enable=%b, Cin=%b, C_out=%b, S=%h", 
                 $time, A, B, signed_flag, subtract_enable, Cin, C_out, S);

        // Test Case 1: Unsigned Addition
        #10 A = 32'd10; B = 32'd5; signed_flag = 0; subtract_enable = 0; Cin = 0;

        // Test Case 2: Unsigned Subtraction (10 - 5)
        #10 A = 32'd10; B = 32'd5; signed_flag = 0; subtract_enable = 1; Cin = 0;

        // Test Case 3: Signed Addition (-10 + 5)
        #10 A = 32'hFFFFFFF6; B = 32'd5; signed_flag = 1; subtract_enable = 0; Cin = 0;

        // Test Case 4: Signed Subtraction (-10 - 5)
        #10 A = 32'hFFFFFFF6; B = 32'd5; signed_flag = 1; subtract_enable = 1; Cin = 0;

        // Test Case 5: Signed Subtraction with Sign Extension (-1 - 1)
        #10 A = 32'hFFFFFFFF; B = 32'd1; signed_flag = 1; subtract_enable = 1; Cin = 0;

        // Test Case 6: Overflow Condition (Max Positive + 1 for Unsigned)
        #10 A = 32'h7FFFFFFF; B = 32'd1; signed_flag = 0; subtract_enable = 0; Cin = 0;

        // Test Case 7: Underflow Condition (Min Negative - 1 for Signed)
        #10 A = 32'h80000000; B = 32'd1; signed_flag = 1; subtract_enable = 1; Cin = 0;

    end

endmodule
