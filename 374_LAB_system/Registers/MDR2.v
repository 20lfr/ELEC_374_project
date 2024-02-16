module MDR2 #(parameter DATA_WIDTH = 32)(
    input wire clear,
    input wire clock,
    input wire enable,
    input wire read, // Control signal for read/write operation

    input wire [DATA_WIDTH-1:0] BusMuxOut, Mdatain, 
    output wire [DATA_WIDTH-1:0] BusMuxIn

);

// Internal signals for data flow control
wire [DATA_WIDTH-1:0] data_to_reg;


// Logic to determine data flow direction
// When reading, data is loaded into the register from memory lines. When writing, data is loaded from bus lines.
assign data_to_reg = read ? Mdatain : BusMuxOut;



// Instantiating the generic register module
register #(DATA_WIDTH) mdr_register (
    .clear(clear),
    .clock(clock),
    .enable(enable),
    .BusMuxOut(data_to_reg),
    .BusMuxIn(BusMuxIn)
);

endmodule
