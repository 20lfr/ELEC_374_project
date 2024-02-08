module and_or #(parameter DATA_WIDTH = 32)(
    input wire [DATA_WIDTH-1:0] A, B, 
    input wire selection, 
    output wire [(2*DATA_WIDTH)-1:0] result
);

    // Assign lower DATA_WIDTH bits of result based on selection
    assign result[DATA_WIDTH-1:0] = (selection == 1) ? A & B : A | B;
    // Zero out the upper DATA_WIDTH bits of result
    assign result[(2*DATA_WIDTH)-1:DATA_WIDTH] = 0;

endmodule
