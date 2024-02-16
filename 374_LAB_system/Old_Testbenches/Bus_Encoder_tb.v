`timescale 1ns / 1ps

module Bus_Encoder_tb;

    // Inputs to the module
    reg [23:0] Encoder_signals_in;
    // Outputs from the module
    wire [4:0] Encoder_signals_out;

    // Instantiate the Unit Under Test (UUT)
    Bus_Encoder uut (
        .Encoder_signals_in(Encoder_signals_in),
        .Encoder_signals_out(Encoder_signals_out)
    );

    initial begin
        // Initialize Inputs
        Encoder_signals_in = 0;

        // Wait for global reset
        #100;

        // Apply test vectors
        // Test case 1: Signal 1 active
        Encoder_signals_in = 24'b000000000000000000000010; // Only the 2nd bit is high
        #10; // Wait for 10ns

        // Test case 2: Signal 16 active
        Encoder_signals_in = 24'b000000000001000000000000; // Only the 16th bit is high
        #10; // Wait for 10ns

        // Test case 3: Signal 23 active
        Encoder_signals_in = 24'b100000000000000000000000; // Only the 23rd bit is high
        #10; // Wait for 10ns

        // Continue with more test cases as needed...

    end

    // Monitor changes to signals
    initial begin
        $monitor("At time %t, Input: %b, Output: %d", $time, Encoder_signals_in, Encoder_signals_out);
    end

endmodule
