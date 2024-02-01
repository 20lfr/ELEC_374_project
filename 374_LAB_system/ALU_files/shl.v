module shl (
    input wire [31:0] A, amount,
    output wire [63:0] result
);

assign result = A << 1;
    
endmodule