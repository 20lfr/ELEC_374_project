module CLA_b_cell (
    input wire A, B, Cin,
    output reg G, P, sum
);

always @(*)begin
    G <= A & B;
    P = A ^ B;
    sum = P ^ Cin;
end



endmodule
