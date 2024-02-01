module CLA_b_cell (
    input wire A, B, Cin,
    output wire G, P, sum
);

assign G = A & B;      // Generate
assign P = A ^ B;      // Propagate
assign sum = P ^ Cin;  // Carry out




endmodule
