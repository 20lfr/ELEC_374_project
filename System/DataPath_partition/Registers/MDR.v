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

// Corrected control signals for driving bidirectional lines
wire bus_drive_enable = !enable && read; // Drive bus when reading from memory
wire mem_drive_enable = !enable && !read; // Drive memory when writing to it



// Tristate logic for bus_data_lines
// When reading, data_from_reg is driven onto the bus. Otherwise, bus lines are high-impedance.
assign bus_data_lines = bus_drive_enable ? data_from_reg : {DATA_WIDTH{1'bz}};

// Tristate logic for mem_data_lines
// When writing, data_from_reg is driven onto the memory lines. Otherwise, memory lines are high-impedance.
assign mem_data_lines = mem_drive_enable ? data_from_reg : {DATA_WIDTH{1'bz}};



// Logic to determine data flow direction
// When reading, data is loaded into the register from memory lines. When writing, data is loaded from bus lines.
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
