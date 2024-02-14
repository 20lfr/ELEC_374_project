`timescale 1ns / 1ps

module MDR_tb;

// Parameters
parameter DATA_WIDTH = 32;

// Testbench Signals
reg tb_clear;
reg tb_clock;
reg tb_enable;
reg tb_read;
wire [DATA_WIDTH-1:0] tb_bus_data_lines;
wire [DATA_WIDTH-1:0] tb_mem_data_lines;
wire [DATA_WIDTH-1:0] tb_BusMuxIn;

// Bidirectional bus and memory lines require internal variables to model the inout ports
reg [DATA_WIDTH-1:0] bus_internal;
reg [DATA_WIDTH-1:0] mem_internal;

// Connect internal variables to the inout ports through continuous assignments
assign tb_bus_data_lines = bus_internal;
assign tb_mem_data_lines = mem_internal;

// MDR Module instantiation
MDR2 #(.DATA_WIDTH(DATA_WIDTH)) uut (
    .clear(tb_clear),
    .clock(tb_clock),
    .enable(tb_enable),
    .read(tb_read),
    .BusMuxOut(tb_bus_data_lines),
    .Mdatain(tb_mem_data_lines), 
    .BusMuxIn(tb_BusMuxIn)
);

// Clock generation
initial begin
    tb_clock = 0;
    forever #5 tb_clock = ~tb_clock; // Generate a clock with a period of 10 ns
end

// Test sequence
initial begin
    // Initialize signals
    tb_clear = 0;
    tb_enable = 0;
    tb_read = 0;
   // bus_internal = {DATA_WIDTH{1'bz}};
    //mem_internal = {DATA_WIDTH{1'bz}};

    // Reset the system
    #10;
    tb_clear = 1;
    #10;
    tb_clear = 0;

    // Write data to memory (bus -> MDR)
    tb_enable = 1;
    tb_read = 0; // Indicate write operation
    bus_internal = 32'hA5A5A5A5; // sExample data to write to memory
    mem_internal = {DATA_WIDTH{1'bz}}; // High impedance for read operation

    #20;

    // Read data from memory (memory -> MDR)
    tb_read = 1; // Indicate read operation
    bus_internal = {DATA_WIDTH{1'bz}}; // High impedance for read operation
    mem_internal = 32'h5B5B5B5B; // Example data in memory to read
end

endmodule
