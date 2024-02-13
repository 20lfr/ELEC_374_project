module add_sub(
    input wire [31:0] A, B, 
    input wire signed_flag, subtract_enable,
    input wire Cin,  // Ensure this is correctly used or potentially remove if not needed
    output wire C_out, 
    output wire [63:0] S
);

    //NOTE: we need to figure out whether we are incorperating signed and unsigned addition
    wire [31:0] input_b;
    wire [31:0] add_sub_result;

    // Compute two's complement of B if subtraction is enabled, else pass B directly
    assign input_b = subtract_enable ? (~B + 1'b1) : B;

    // Use the CLA_32bit_adder for addition/subtraction
    CLA_32bit_adder adder(A, input_b, Cin, C_out, add_sub_result[31:0]);

    // Assign the result to the lower 32 bits of S
    assign S[31:0] = add_sub_result;

    //if not unsigned and the last bit of the sum is a 1, then sign extend. Otherwise set upper to zero
    assign S[63:32] = (signed_flag && S[31] == 1) ? 32'hFFFFFFFF : 32'h00000000;
endmodule
