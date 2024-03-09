module RAM512x32  #(parameter   DATA_WIDTH = 32,  // # of bits in word
                                ADDR_WIDTH = 9  /* # of address bits*/)
(
    input wire clk,
    input wire read, write, enable,
    input wire [(ADDR_WIDTH-1):0] address,
    input wire [(DATA_WIDTH-1):0] data_in,
    output reg [(DATA_WIDTH-1):0] data_out // Changed to reg since it's driven by always block

    input wire overide, 
    input wire [(ADDR_WIDTH-1):0] overide_address,
    input wire [(DATA_WIDTH-1):0] overide_data_in,
);

// Memory array
reg [DATA_WIDTH-1:0] FullMemorySpace [(2**ADDR_WIDTH)-1:0]; 
integer i;
initial begin
    for(i = 0; i < 2**ADDR_WIDTH; i = i + 1) begin
        FullMemorySpace[i] <= 32'd0;
    end
end 

always @(posedge clk) begin
    if (overide) begin
        FullMemorySpace[overide_address] <= overide_data_in;
    end 
    else if (enable) begin
        if (write) begin
            FullMemorySpace[address] <= data_in;
        end
        else if (read) begin
            data_out <= FullMemorySpace[address];
        end
    end
end

endmodule
