// Nah I'd Win
module div(
    input wire [31:0] A,                    // Dividend
    input wire [31:0] B,                    // Divisor
    output wire [63:0] div_result           // Bottom 32-bits will be Quotient, Top 32-bits will be remainder 
);

reg [31:0] quotient, remainder, tempA, tempB, tempC;
integer i, neg_flag;

always @(A or B) begin

    quotient = 0;
    remainder = 0;
    neg_flag = 0;
    tempA = A; // Q
    tempB = B; // M
    tempC = ~B + 1; // -M

    // Overflow Condition: Dividing the most negative numver by -1 will overflow the range of -2^31 to 2^31-1
    //                     ex. -2^32/-1 = 2^31 which is outside of range

    if (A == 32'h80000000 && B == 32'hFFFFFFFF) begin
        // Handle Overflow by sending error
        div_result = 64'h0000000000000000;
    end
    else if (B != 0) begin

        // Check A for negative
        if (tempA[31] == 1) begin 
            tempA = ~A + 1;
            neg_flag = neg_flag + 1;
        end

        //Check B for negative
        if (tempB[31] == 1) begin
            tempB = ~B + 1;
            tempC = B;
            neg_flag = neg_flag + 1;
        end 

        // Do the division A/B
        for (i = 0; i < 32; i = i + 1) begin
            // Shift A into remainder
            remainder = remainder << 1;
            remainder[0] = tempA[31];
            tempA = tempA << 1;

            // Subtract (add the 2's complement)
            tempA = tempA + tempC;

            if (remainder[31] == 1) begin
                // Set q0 to 0
                tempA[0] = 0;
                // Restore
                remainder = remainder + tempB;
            end
            else begin
                // Set q0 to 1
                tempA[0] = 1;
            end
        end

        // Set Quotient
        quotient = tempA;

        // Check neg_flag after division
        if (neg_flag == 1) begin
            quotient = ~quotient + 1;
        end

        // Concatinate quotient and remainder into one 64-bit output
        div_result = {quotient, remainder};

    end 
    else begin
        // Handle division by sending error
        div_result = 64'h0000000000000000;
    end
end
endmodule