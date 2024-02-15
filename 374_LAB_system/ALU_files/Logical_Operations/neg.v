module neg (
    input wire [31:0] B,
    output wire [63:0] result
);

    assign result = -B;
    
endmodule