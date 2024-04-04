module Clock_div #(parameter DIVISOR = 5)(
    input wire clk,
    input wire reset,
    output reg clock = 0
);

    reg [3:0] counter = 0; 
    always @(posedge clk) begin
        if (counter == DIVISOR) begin // -1 because counter starts from 0
            clock <= ~clock;
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end
endmodule
