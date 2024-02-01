module CLA_32bit_adder (
    input wire [31:0] A, B, 
    input wire Cin, 
    output wire C_out, 
    output wire G_prime, P_prime,
    output wire [63:0] S
);
    wire [1:0] G, P, Carry_out;
    wire carry;  // Internal carry for the 16-bit block

    // Instantiate CLA 16-bit cells
    CLA_16bit_adder bits0_15(A[15:0], B[15:0], Cin, Carry_out[0], G[0], P[0], S[15:0]);
    assign carry = G[0] | (P[0] & Cin);

    CLA_16bit_adder bits16_31(A[31:16], B[31:16], carry, Carry_out[1], G[1], P[1], S[31:16]);
    
    // Final carry-out
    assign C_out = G[1] | (P[1] & carry);

    assign G_prime = G[1];
    assign P_prime = P[1];
endmodule
