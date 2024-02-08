module not_module (
    input wire [31:0] A,
    output wire [63:0] result
);

assign result[31:0] = ~A;
assign result[63:32] = 0;
    
endmodule