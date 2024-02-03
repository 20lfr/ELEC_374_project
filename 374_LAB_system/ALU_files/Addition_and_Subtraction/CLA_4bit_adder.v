module CLA_4bit_adder (
    input wire [3:0] A, B,
    input wire Cin,
    output wire C_out,
    output wire G_prime, P_prime, 
    output wire [3:0] S
);
wire [3:0] G, P;
reg [4:1] carry;  // Internal carries for each bit, changed to reg for always block

// Instantiate CLA cells
CLA_b_cell bit0(A[0], B[0], Cin,    G[0], P[0], S[0]);
CLA_b_cell bit1(A[1], B[1], carry[1], G[1], P[1], S[1]);
CLA_b_cell bit2(A[2], B[2], carry[2], G[2], P[2], S[2]);
CLA_b_cell bit3(A[3], B[3], carry[3], G[3], P[3], S[3]);

// Combinational logic for carry calculations
always @* begin
    carry[1] = G[0] | (P[0] & Cin);
    carry[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & Cin);
    // Fixed missing '&' operator below
    carry[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & Cin);
    // Fixed missing '&' operators below
    carry[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & Cin);
end

// Final carry-out
assign C_out = carry[4];

// No need to move these to an always block since they directly map to outputs
assign G_prime = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);
assign P_prime = (P[3] & P[2] & P[1] & P[0]);

endmodule
