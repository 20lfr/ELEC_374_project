module CLA_16bit_adder (
    input wire [15:0] A, B, 
    input wire Cin, 
    output wire C_out, 
    output wire G_prime, P_prime,
    output wire [15:0] S
);
    wire [3:0] G, P, Carry_out;
    wire [3:1] carry;  // Internal carries for each 4-bit block

    // Instantiate CLA 4-bit cells
    CLA_4bit_adder bits0_3(A[3:0], B[3:0], Cin, Carry_out[0], G[0], P[0], S[3:0]);
    assign carry[1] = G[0] | (P[0] & Cin);

    CLA_4bit_adder bits4_7(A[7:4], B[7:4], carry[1], Carry_out[1], G[1], P[1], S[7:4]);
    assign carry[2] = G[1] | (P[1] & carry[1]);

    CLA_4bit_adder bits8_11(A[11:8], B[11:8], carry[2], Carry_out[2], G[2], P[2], S[11:8]);
    assign carry[3] = G[2] | (P[2] & carry[2]);

    CLA_4bit_adder bits12_15(A[15:12], B[15:12], carry[3], Carry_out[3], G[3], P[3], S[15:12]);
    // Final carry-out
    assign C_out = G[3] | (P[3] & carry[3]);

    assign G_prime = G[3];
    assign P_prime = P[3];
endmodule
