module booth_mul_combinational #(parameter DATA_WIDTH = 32)(
    input wire [DATA_WIDTH-1:0] multiplicand,
    input wire [DATA_WIDTH-1:0] multiplier,
    output reg [2*DATA_WIDTH-1:0] product
);

    reg [DATA_WIDTH-1:0] Q; // Corrected to DATA_WIDTH-1:0 for the multiplier
    reg [2*DATA_WIDTH-1:0] M, M_neg; // Fixed width for correct sign extension
    reg [2*DATA_WIDTH-1:0] partial_product[DATA_WIDTH:0]; // Adjusted size for partial products

    always @* begin // Using always @* for comprehensive sensitivity
        M = {multiplicand, {DATA_WIDTH{1'b0}}}; // Corrected to ensure proper sign extension
        M_neg = ~M + 1'b1; // Correctly forming 2's complement
        Q = {{1'b0}, multiplier}; // No need for extra bit in Q

        product = 0; // Initializing product for accumulation

        for(int i = 0; i < DATA_WIDTH; i = i + 1) begin
            partial_product[i] = 0; // Initialize each partial product
            case({Q[i], Q[i-1]})
                2'b01: partial_product[i] = M << i;
                2'b10: partial_product[i] = M_neg << i;
                default: partial_product[i] = 0;
            endcase
        end

        // Accumulate partial products
        for(int i = 0; i < DATA_WIDTH; i = i + 1) begin
            product = product + partial_product[i];
        end
    end
endmodule
