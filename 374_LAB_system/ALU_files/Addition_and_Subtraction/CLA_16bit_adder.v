module CLA_16bit_adder (
    input wire [15:0] A, B, 
    input wire Cin, 
    output wire C_out, 
    output wire G_prime, P_prime,
    output wire [15:0] S
);
    wire [3:0] G, P, Carry_out;
    reg [3:1] carry;  // For internal carry logic

    // Instantiate CLA 4-bit cells directly into parts of S
    CLA_4bit_adder bits0_3(A[3:0], B[3:0], Cin, Carry_out[0], G[0], P[0], S[3:0]);
    CLA_4bit_adder bits4_7(A[7:4], B[7:4], carry[1], Carry_out[1], G[1], P[1], S[7:4]);
    CLA_4bit_adder bits8_11(A[11:8], B[11:8], carry[2], Carry_out[2], G[2], P[2], S[11:8]);
    CLA_4bit_adder bits12_15(A[15:12], B[15:12], carry[3], Carry_out[3], G[3], P[3], S[15:12]);

    always @* begin
        carry[1] = G[0] | (P[0] & Cin);
        carry[2] = G[1] | (P[1] & carry[1]);
        carry[3] = G[2] | (P[2] & carry[2]);
    end

    // Final carry-out and G_prime, P_prime directly assigned
    assign C_out = G[3] | (P[3] & carry[3]);
    assign G_prime = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);
    assign P_prime = (P[3] & P[2] & P[1] & P[0]);
endmodule
