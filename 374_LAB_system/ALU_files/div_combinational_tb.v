// Combinational division test bench
`timescale 1ns / 1ps

module div_combinational_tb;

parameter DATA_WIDTH = 32;
reg [DATA_WIDTH-1:0] dividend, divisor;
wire [2*DATA_WIDTH-1:0] result;

// Instantiate the Unit Under Test (UUT)
div_combinational #(.DATA_WIDTH(DATA_WIDTH)) uut (
    .dividend(dividend), 
    .divisor(divisor), 
    .result(result)
);

initial begin
    // Initialize Inputs
    dividend = 0; divisor = 1; // Initialize divisor to 1 to avoid division by zero at start

    // Monitor changes to observe the outputs
    $monitor("Time=%t, dividend=%d, divisor=%d --> result={remainder=%d, quotient=%d}", 
             $time, $signed(dividend), $signed(divisor), $signed(result[63:32]), $signed(result[31:0]));

    // Test Case 1: Simple division
    #10 dividend = 32'd15; divisor = 32'd3;

    // Test Case 2: Division with a negative dividend
    #10 dividend = -32'd15; divisor = 32'd3;

    // Test Case 3: Division with a negative divisor
    #10 dividend = 32'd15; divisor = -32'd3;

    // Test Case 4: Division with both operands negative
    #10 dividend = -32'd15; divisor = -32'd3;

    // Test Case 5: Dividing by zero
    #10 dividend = 32'd1234; divisor = 32'd0;

    // Test Case 6: Zero divided by a negative number
    #10 dividend = 0; divisor = -32'd1234;

    // Test Case 7: Large numbers
    #10 dividend = 32'h7FFFFFFF; divisor = 32'd2;

    // Test Case 8: Division resulting in a remainder
    #10 dividend = 32'd10; divisor = 32'd3;

end
endmodule
