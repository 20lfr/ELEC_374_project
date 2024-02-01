module not (
    input wire [31:0] A,
    output wire [63:0] result
);

assign result = ~A;
    
endmodule