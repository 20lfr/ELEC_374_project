module rol #(parameter DATA_WIDTH = 32)(
    input wire [31:0] A, 
    input wire [4:0] amount,
    output wire[63:0] result
);

assign result[DATA_WIDTH-1:0] = (A << amount) | (A >> ((DATA_WIDTH) - amount));
assign result[DATA_WIDTH*2 -1: DATA_WIDTH] = 32'd0;
endmodule