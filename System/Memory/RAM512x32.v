module RAM512x32  #(parameter   DATA_WIDTH = 32,  // # of bits in word
                                ADDR_WIDTH = 9  /* # of address bits*/)
(
    input wire clk,
    input wire read, write, enable,
    input wire [(ADDR_WIDTH-1):0] address,
    input wire [(DATA_WIDTH-1):0] data_in,
    output reg [(DATA_WIDTH-1):0] data_out // Changed to reg since it's driven by always block
);

// Memory array
reg [DATA_WIDTH-1:0] FullMemorySpace [(2**ADDR_WIDTH)-1:0]; 

always @(posedge clk) begin
    if (enable) begin
        if (write) begin
            FullMemorySpace[address] <= data_in;
        end
        else if (read) begin
            data_out <= FullMemorySpace[address];
        end
    end
end

endmodule
