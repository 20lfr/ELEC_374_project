// Nah I'd Win
module div(
    input wire clk,
    input wire start,
    input wire [31:0] A,                    // Dividend
    input wire [31:0] B,                    // Divisor
    output wire [63:0] div_result           // Bottom 32-bits will be Quotient, Top 32-bits will be remainder 
);

reg [31:0] quotient, remainder, tempA, tempB, tempC;
reg [4:0] counter;
reg [1:0] neg_flag;
reg [0:0] active;
reg [0:0] check;

always @(posedge clk) begin

    if (start && !active) begin
        quotient <= 0;
        remainder <= 0;
        neg_flag <= 0;
        active <= 1;
        counter <= 0;
        tempA <= A; // Q
        tempB <= B; // M
        tempC <= ~B + 1; // -M
        div_result <= 64'd0; // clear div_result
        check <= 0;
    end
    
    if (active) begin
        if (B != 0) begin
            if (!check) begin
                // Check A for negative
                if (tempA[31] == 1) begin 
                    tempA <= ~A + 1;
                    neg_flag <= neg_flag + 1;
                end

                //Check B for negative
                if (tempB[31] == 1) begin
                    tempB <= ~B + 1;
                    tempC <= B;
                    neg_flag <= neg_flag + 1;
                end 
                check <= 1;
            end

            if (counter < 32) begin
                // Shift A into remainder
                remainder <= {remainder[30:0], tempA[31]};
                tempA <= tempA << 1;

                // Subtract (add the 2's complement)
                tempA <= tempA + tempC;

                if (remainder[31] == 1) begin
                    // Set q0 to 0
                    tempA[0] <= 0;
                    // Restore
                    remainder <= remainder + tempB;
                end
                else begin
                    // Set q0 to 1
                    tempA[0] <= 1;
                end
                
                // Set Quotient
                quotient <= tempA;
                
                // Increment Counter
                counter <= counter + 1;
            end

            if (counter == 32) begin
                // Check neg_flag after division
                if (neg_flag == 1) begin
                    quotient <= ~quotient + 1;
                end
                // Concatinate quotient and remainder into one 64-bit output
                div_result <= {quotient, remainder};
            end 
        end 
        else begin
            // Handle division by sending error
            div_result <= 64'h0000000000000000;
        end
    end
end

initial begin
    active = 0;
end

endmodule