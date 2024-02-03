module CLA_b_cell (
    input wire A, B, Cin,
    output wire G, P, sum
);

assign G = A & B;
assign P = A ^ B;
assign sum = P ^ Cin;




endmodule
