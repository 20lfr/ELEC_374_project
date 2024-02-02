module CLA_4bit_adder (
    input wire [3:0] A, B,
    input wire Cin,
    output wire C_out,
    output wire G_prime, P_prime, 
    output wire [3:0] S
);
wire [3:0] G, P;
wire [3:1] carry;  // Internal carries for each bit

// Instantiate CLA cells
CLA_b_cell bit0(A[0], B[0], Cin,    G[0], P[0], S[0]);
assign carry[1] = G[0] | (P[0] & Cin);

CLA_b_cell bit1(A[1], B[1], carry[1], G[1], P[1], S[1]);
assign carry[2] = G[1] | (P[1] & carry[1]);

CLA_b_cell bit2(A[2], B[2], carry[2], G[2], P[2], S[2]);
assign carry[3] = G[2] | (P[2] & carry[2]);

CLA_b_cell bit3(A[3], B[3], carry[3], G[3], P[3], S[3]);



// Final carry-out
assign C_out = G[3] | (P[3] & carry[3]);

assign G_prime = G[3];
assign P_prime = P[3];

endmodule
