// Nah I'd Win

module div(

    input wire [31:0] A,                    // Dividend
    input wire [31:0] B,                    // Divisor
    output wire [63:0] div_result           // Bottom 32-bits will be Quotient, Top 32-bits will be remainder 

);

always @(A) begin

    Quotient = 0;
    Remainder = 0;
    temp = 0;

    if (B != 0) begin 

        // Division Algorithm

        

    end 

    else begin
        
        // Handle dividing by 0
    
    end
end

endmodule