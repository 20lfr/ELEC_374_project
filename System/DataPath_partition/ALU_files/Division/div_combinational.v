// Combinational divison using array divider and non-restoring algorithm
module div_combinational #(parameter DATA_WIDTH = 32)(
    input wire [DATA_WIDTH-1:0] dividend,
    input wire [DATA_WIDTH-1:0] divisor,
    output reg [2*DATA_WIDTH-1:0] result
);

// Initalize registers
reg [DATA_WIDTH:0] temp_remainder;
reg [DATA_WIDTH-1:0] temp_quotient;
integer i;
reg [DATA_WIDTH-1:0] abs_dividend;
reg [DATA_WIDTH-1:0] abs_divisor;

always @* begin

    if (divisor == 0) begin     // Check if dividing by 0
        result = {2*DATA_WIDTH{1'b1}};

    end else if (dividend == 0) begin       // Check is dividend is 0
        result = 0;

    end else begin

        // Initialize Variables
        temp_quotient = 0;
        temp_remainder = 0;

        // If signed bit it 1 then get absolute value of dividend and divisor if signed bit is 0 then change nothing
        abs_dividend = dividend[DATA_WIDTH-1] ? -dividend : dividend;
        abs_divisor = divisor[DATA_WIDTH-1] ? -divisor : divisor;

        // Non Restoring division algorithm 
        for (i = DATA_WIDTH-1; i >= 0; i = i -1) begin

            temp_remainder = temp_remainder << 1;
            temp_remainder[0] = abs_dividend[i];

            temp_remainder = temp_remainder - abs_divisor;

            if (temp_remainder[DATA_WIDTH]) begin

                temp_quotient[i] = 0;
                temp_remainder = temp_remainder + abs_divisor;

            end else begin
                
                temp_quotient[i] = 1;

            end
        end

        // If the signed bits are not equal then 1 of them has to be a negative. Update quotient.
        if (dividend[DATA_WIDTH-1] != divisor[DATA_WIDTH-1]) begin
            temp_quotient = -temp_quotient;
        end

        // Concatinate remainder and quotient into 64-bit result
        result = {temp_remainder[DATA_WIDTH-1:0], temp_quotient};
    end
end
endmodule