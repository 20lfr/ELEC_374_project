module booth_mul_combinational #(parameter DATA_WIDTH = 32)(
    input wire [DATA_WIDTH-1:0] multiplicand,
    input wire [DATA_WIDTH-1:0] multiplier,
    output reg [2*DATA_WIDTH-1:0] product
);

    reg [DATA_WIDTH-1:0] Q; // For the multiplier
    reg [2*DATA_WIDTH-1:0] M, M_neg; // For correct sign extension
    reg [2*DATA_WIDTH-1:0] partial_product[DATA_WIDTH:0]; // For partial products

    // Loop to initialize each partial product
    integer i; // Ensure 'i' is declared somewhere appropriate
    reg bit0, bit1; // Declare as reg if reuse in procedural logic is intended

    always @* begin
        M = {{DATA_WIDTH{multiplicand[DATA_WIDTH-1]}}, multiplicand}; // Sign-extend multiplicand
        M_neg = ~M + 1'b1; // Two's complement
        Q = multiplier; // Prepending a 0 for Booth's algorithm

        product = 0; // Reset product

        for(i = 0; i < DATA_WIDTH; i = i + 1) begin
            if(i == 0) bit0 = 1'b0; // For the LSB, the bit below is considered 0
            else bit0 = Q[i-1]; // Use the actual bit for other cases
            bit1 = Q[i]; // Current bit being examined

            case({bit1, bit0})
                2'b01: partial_product[i] = M << i;
                2'b10: partial_product[i] = M_neg << i;
                default: partial_product[i] = 0;
            endcase
        end

        // Accumulate partial products
        for(i = 0; i < DATA_WIDTH; i = i + 1) begin
            product = product + partial_product[i];
        end
    end

endmodule
