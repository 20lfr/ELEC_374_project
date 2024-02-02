module booth_mul_combinational #(parameter DATA_WIDTH 32)(
    input wire [DATA_WIDTH-1:0] multiplicand,
    input wire [DATA_WIDTH-1:0] multiplier,
    input wire enable,
    output reg [2*DATA_WIDTH-1:0] product

);

    reg [DATA_WIDTH:0] M, A, Q; //all N+1 registers

    
    always @(multiplicand or multiplier) begin

        M = multiplicand;
        M_neg = ~multiplicand + 1;
        Q = multiplier;
        A = 33'd0;

        for(int i = 0; i < DATA_WIDTH; i = i + 1) begin
            

        end







    end 



endmodule