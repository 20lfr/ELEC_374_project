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
/*
TEST BENCH RESULTS
# Time=                   0, dividend=          0, divisor=          1 --> result={remainder=          0, quotient=          0}
# Time=               10000, dividend=         15, divisor=          3 --> result={remainder=          0, quotient=          5}
# Time=               20000, dividend=        -15, divisor=          3 --> result={remainder=          0, quotient=         -5}
# Time=               30000, dividend=         15, divisor=         -3 --> result={remainder=          0, quotient=         -5}
# Time=               40000, dividend=        -15, divisor=         -3 --> result={remainder=          0, quotient=          5}
# Time=               50000, dividend=       1234, divisor=          0 --> result={remainder=         -1, quotient=         -1}
# Time=               60000, dividend=          0, divisor=      -1234 --> result={remainder=          0, quotient=          0}
# Time=               70000, dividend= 2147483647, divisor=          2 --> result={remainder=          1, quotient= 1073741823}
# Time=               80000, dividend=         10, divisor=          3 --> result={remainder=          1, quotient=          3}
*/