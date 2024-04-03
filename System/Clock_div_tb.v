`timescale 1ns / 1ps

module Clock_div_tb;

// Testbench parameters
parameter CLOCK_CYCLE = 5;
parameter CLK_PERIOD = 20; // Clock period in nanoseconds for a 100MHz clock

// Testbench signals
reg clk_tb, reset;
wire clock_tb;

// Instantiate the Clock_dv module
Clock_div #(.DIVISOR(CLOCK_CYCLE)) clock_divider_instance (
    .clk(clk_tb),
    .clock(clock_tb), 
    .reset(1'b0)
);

// Clock generation
initial begin
    clk_tb = 0;
    forever #(CLK_PERIOD/2) clk_tb = ~clk_tb;
end



endmodule
