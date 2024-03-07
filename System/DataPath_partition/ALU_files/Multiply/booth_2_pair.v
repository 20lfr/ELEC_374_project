module booth_2_pair #(parameter DATA_WIDTH = 32)(
    input wire [DATA_WIDTH-1:0] multiplicand,
    input wire [DATA_WIDTH-1:0] multiplier,
    output reg [2*DATA_WIDTH-1:0] product
);

    reg [DATA_WIDTH-1:0] Q; // For the multiplier
    reg [2*DATA_WIDTH-1:0] M, M_neg, M_2, M_2_neg; // For correct sign extension
    reg [2*DATA_WIDTH-1:0] partial_product[DATA_WIDTH:0]; // For partial products

    // Loop to initialize each partial product
    integer i; 
    reg bit0, bit1, bit2; 

    always @* begin
        M = {{DATA_WIDTH{multiplicand[DATA_WIDTH-1]}}, multiplicand}; // Sign-extend multiplicand
        M_neg = ~M + 1'b1; // Two's complement
        M_2 = M << 1;
        M_2_neg = ~M_2 + 1'b1;
        Q = multiplier; 

        product = 0; // Reset product

        for(i = 0; i < DATA_WIDTH; i = i + 2) begin
            if(i == 0) bit0 = 1'b0; // For the LSB, the bit below is considered 0
            else bit0 = Q[i-1]; // Use the actual bit for other cases
            bit1 = Q[i]; 
            if(i==DATA_WIDTH-1) bit2 = Q[i]; //sign extend. NOTE this is only needed if the DATA_WIDTH is an odd number. Since 32 is even, this is usually not needed unless DATA_WIDTH is overwritten
            bit2 = Q[i+1];

            case({bit2, bit1, bit0})
                3'b001: partial_product[i] = M << i;
                3'b010: partial_product[i] = M << i;
                3'b011: partial_product[i] = M_2 << i;
                3'b100: partial_product[i] = M_2_neg << i;
                3'b101: partial_product[i] = M_neg << i;
                3'b110: partial_product[i] = M_neg << i;
                default: partial_product[i] = 0;//any other case must be zero
            endcase
        end
 
        // Accumulate partial products. This changes to (i + 2) aswell becuase of where each parial product is calculated in the partial product array
        for(i = 0; i < DATA_WIDTH; i = i + 2) begin
            product = product + partial_product[i];
        end
    end

endmodule
