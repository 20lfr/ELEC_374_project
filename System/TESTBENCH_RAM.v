`timescale 1ns / 1ps

module TESTBENCH_RAM;

    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 9;

    // Inputs
    reg read;
    reg write;
    reg enable;
    reg [ADDR_WIDTH-1:0] address;
    reg [DATA_WIDTH-1:0] data_in;
    reg overide;
    reg [ADDR_WIDTH-1:0] overide_address;
    reg [DATA_WIDTH-1:0] overide_data_in;

    // Outputs
    wire [DATA_WIDTH-1:0] data_out;
    wire done;

    // Instantiate the Unit Under Test (UUT)
    RAM512x32 #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) uut (
        .read(read), 
        .write(write), 
        .enable(enable), 
        .address(address), 
        .data_in(data_in), 
        .data_out(data_out),
        .done(done),
        .overide(overide), 
        .overide_address(overide_address), 
        .overide_data_in(overide_data_in)
    );

    initial begin
        // Initialize Inputs
        read = 0;
        write = 0;
        enable = 0;
        address = 0;
        data_in = 0;
        overide = 0;
        overide_address = 0;
        overide_data_in = 0;

        // Wait 100 ns for global reset to finish
        #100;
        
        // Writing value to address 3
        write = 1;
        enable = 1;
        address = 3;
        data_in = 32'hA5A5A5A5;
        #20; // Wait for the write operation

        enable = 0;
        
    end
      
endmodule
