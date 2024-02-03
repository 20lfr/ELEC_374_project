`timescale 1ns / 1ps

module booth_mul_combinational_tb;

parameter DATA_WIDTH = 32;
reg [DATA_WIDTH-1:0] multiplicand, multiplier;
wire [2*DATA_WIDTH-1:0] product;

// Instantiate the Unit Under Test (UUT)
booth_mul_combinational #(.DATA_WIDTH(DATA_WIDTH)) uut (
    .multiplicand(multiplicand), 
    .multiplier(multiplier), 
    .product(product)
);

initial begin
    // Initialize Inputs
    multiplicand = 0; multiplier = 0;

    // Monitor changes to observe the outputs
    $monitor("Time=%t, multiplicand=%d, multiplier=%d --> product=%d", 
             $time, multiplicand, multiplier, product);

    // Test Case 1: Simple multiplication
    #10 multiplicand = 32'd15; multiplier = 32'd3;

    // Test Case 2: Multiplication with a negative multiplicand
    #10 multiplicand = -32'd15; multiplier = 32'd3;

    // Test Case 3: Multiplication with a negative multiplier
    #10 multiplicand = 32'd15; multiplier = -32'd3;

    // Test Case 4: Multiplication with both operands negative
    #10 multiplicand = -32'd15; multiplier = -32'd3;

    // Test Case 5: Multiplying by zero
    #10 multiplicand = 32'd0; multiplier = 32'd1234;

    // Test Case 6: Zero multiplied by a negative number
    #10 multiplicand = 32'd1234; multiplier = -32'd0;

    // Test Case 7: Large numbers
    #10 multiplicand = 32'h7FFFFFFF; multiplier = 32'd2;

    // Test Case 8: Multiplication resulting in overflow (to see how it is handled)
    #10 multiplicand = 32'hFFFF_FFFF; multiplier = 32'hFFFF_FFFF;

end

endmodule
