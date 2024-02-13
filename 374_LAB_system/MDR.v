module MDR #(parameter DATA_WIDTH = 32)(
    input wire clear,
    input wire clock,
    input wire enable,
    input wire read, // Control signal for read/write operation
    inout wire [DATA_WIDTH-1:0] bus_data_lines, // Bidirectional bus lines
    inout wire [DATA_WIDTH-1:0] mem_data_lines // Bidirectional memory lines
);

// Internal signals for data flow control
wire [DATA_WIDTH-1:0] data_to_reg;
wire [DATA_WIDTH-1:0] data_from_reg;

// Control signals for driving bidirectional lines
wire bus_drive_enable = enable && !read; // Drive bus when not reading (writing to memory)
wire mem_drive_enable = enable && read;  // Drive memory when reading



// Tristate logic for bus_data_lines
assign bus_data_lines = bus_drive_enable ? data_from_reg : {DATA_WIDTH{1'bz}};

// Tristate logic for mem_data_lines
assign mem_data_lines = mem_drive_enable ? data_from_reg : {DATA_WIDTH{1'bz}};



// Logic to determine data flow direction
assign data_to_reg = read ? mem_data_lines : bus_data_lines;

// Instantiating the generic register module
register #(DATA_WIDTH) mdr_register (
    .clear(clear),
    .clock(clock),
    .enable(enable),
    .BusMuxOut(data_to_reg),
    .BusMuxIn(data_from_reg)
);

endmodule
