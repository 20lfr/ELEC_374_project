module MDR #(parameter DATA_WIDTH = 32)(
    input wire clear,
    input wire clock,
    input wire enable,
    input wire read, // Control signal for read/write operation
    inout wire [DATA_WIDTH-1:0] bus_data_lines, // Bidirectional bus lines
    inout wire [DATA_WIDTH-1:0] mem_data_lines, // Bidirectional memory lines
);

// Internal signals
wire [DATA_WIDTH-1:0] reg_input;
wire [DATA_WIDTH-1:0] reg_output;

// Multiplexer for input: Choose between bus and memory based on the read signal
assign reg_input = read ? mem_data_lines : bus_data_lines;

// Instantiating the generic register module
register #(.DATA_WIDTH_IN(DATA_WIDTH), .DATA_WIDTH_OUT(DATA_WIDTH)) 
mdr_register (
    .clear(clear),
    .clock(clock),
    .enable(enable), // Assuming always enabled for simplicity
    .BusMuxOut(reg_input),
    .BusMuxIn(reg_output)
);

// Output control logic
// Drive bus when reading, memory when writing
assign bus_data_lines = enable ? reg_output : 'bz;

endmodule
