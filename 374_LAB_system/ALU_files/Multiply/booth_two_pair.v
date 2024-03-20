module booth_two_pair #(parameter DATA_WIDTH = 32)(
    input wire [DATA_WIDTH-1:0] multiplicand,
    input wire [DATA_WIDTH-1:0] multiplier,
    output reg [2*DATA_WIDTH-1:0] product
);

    reg [DATA_WIDTH-1:0] Q; // For the multiplier
    reg [2*DATA_WIDTH-1:0] M, M_neg, M_2, M_2_neg; // For correct sign extension
    reg [2*DATA_WIDTH-1:0] partial_product[DATA_WIDTH:0]; // For partial products

    integer i; 
    reg bit0, bit1, bit2; 

    always @* begin
        M = {{DATA_WIDTH{multiplicand[DATA_WIDTH-1]}}, multiplicand}; // Sign-extend multiplicand
        M_neg = ~M + 1'b1; // Two's complement
        M_2 = M << 1; // Multiplicand times 2
        M_2_neg = ~M_2 + 1'b1; // Negation of M_2
        Q = multiplier; 

        product = 0; // Reset product

        for(i = 0; i < DATA_WIDTH; i = i + 2) begin
            bit0 = (i == 0) ? 1'b0 : Q[i-1]; // For LSB, consider '0' as the bit below
            bit1 = Q[i]; // Current bit
            bit2 = (i == DATA_WIDTH-1) ? Q[i] : Q[i+1]; // For MSB, repeat the sign bit or use the next bit

            case({bit2, bit1, bit0})
                3'b001, 3'b010: partial_product[i] = M << i; // M for 01 and 10
                3'b011: partial_product[i] = M_2 << i; // 2*M for 011
                3'b100: partial_product[i] = M_2_neg << i; // -2*M for 100
                3'b101, 3'b110: partial_product[i] = M_neg << i; // -M for 101 and 110
                default: partial_product[i] = 0; // 0 for 000 and 111
            endcase
        end

        // Accumulate partial products
        for(i = 0; i < DATA_WIDTH; i = i + 2) begin
            product = product + partial_product[i];
        end
    end
endmodule
