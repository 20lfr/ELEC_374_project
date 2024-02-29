`timescale 1ns / 10ps

module Bus_MUX_and_Encoder_tb;

// Inputs to the Bus_MUX
reg [31:0] R0_BusMuxIn, R1_BusMuxIn, R2_BusMuxIn, R3_BusMuxIn, 
           R4_BusMuxIn, R5_BusMuxIn, R6_BusMuxIn, R7_BusMuxIn, 
           R8_BusMuxIn, R9_BusMuxIn, R10_BusMuxIn, R11_BusMuxIn, 
           R12_BusMuxIn, R13_BusMuxIn, R14_BusMuxIn, R15_BusMuxIn, 
           HI_BusMuxIn, LO_BusMuxIn, RZ_HI_BusMuxIn, RZ_LO_BusMuxIn, 
           PC_BusMuxIn, MDR_Bus_lines, Inport_BusIn, C_sign_extended;

reg [23:0] Encoder_signals;
wire [4:0] Encoder_select_signals_check;

// Output from the Bus_MUX
wire [31:0] BusMuxOut;

// Instantiate the Unit Under Test (UUT)
Bus_MUX uut (
    .R0_BusMuxIn(R0_BusMuxIn), .R1_BusMuxIn(R1_BusMuxIn), .R2_BusMuxIn(R2_BusMuxIn), .R3_BusMuxIn(R3_BusMuxIn),
    .R4_BusMuxIn(R4_BusMuxIn), .R5_BusMuxIn(R5_BusMuxIn), .R6_BusMuxIn(R6_BusMuxIn), .R7_BusMuxIn(R7_BusMuxIn),
    .R8_BusMuxIn(R8_BusMuxIn), .R9_BusMuxIn(R9_BusMuxIn), .R10_BusMuxIn(R10_BusMuxIn), .R11_BusMuxIn(R11_BusMuxIn),
    .R12_BusMuxIn(R12_BusMuxIn), .R13_BusMuxIn(R13_BusMuxIn), .R14_BusMuxIn(R14_BusMuxIn), .R15_BusMuxIn(R15_BusMuxIn),
    .HI_BusMuxIn(HI_BusMuxIn), .LO_BusMuxIn(LO_BusMuxIn), .RZ_HI_BusMuxIn(RZ_HI_BusMuxIn), .RZ_LO_BusMuxIn(RZ_LO_BusMuxIn),
    .PC_BusMuxIn(PC_BusMuxIn), .MDR_Bus_lines(MDR_Bus_lines), .Inport_BusIn(Inport_BusIn), .C_sign_extended(C_sign_extended),
    .BusMuxOut(BusMuxOut),
    .Encoder_signals(Encoder_signals), .Encoder_select_signals_check(Encoder_select_signals_check)
);

initial begin
    // Initialize Inputs
    
    
    // Initialize the rest of the inputs similarly
    Encoder_signals = 24'b0; // No signal selected

    // Wait for global reset
    #20;
    
    // Test Case 1: Select R0_BusMuxIn
    R0_BusMuxIn <= 32'hAAAA_AAAA;
    R1_BusMuxIn <= 32'd0;
    C_sign_extended <= 32'd0;
    Encoder_signals = 24'h1;
    #10; // Wait for the signal to propagate
    // Add checks to verify BusMuxOut is R0_BusMuxIn
    
    // Test Case 2: Select R1_BusMuxIn
    R0_BusMuxIn <= 32'd0;
    R1_BusMuxIn <= 32'hBBBB_BBBB;
    C_sign_extended <= 32'd0;
    Encoder_signals = 24'h2;
    #10; // Wait for the signal to propagate
    // Add checks to verify BusMuxOut is R1_BusMuxIn
    
    // Continue with other test cases for each input...
    
    // Test Case N: Select C_sign_extended
    R0_BusMuxIn <= 32'd0;
    R1_BusMuxIn <= 32'd0;
    C_sign_extended <= 32'hCCCC_CCCC;
    Encoder_signals = 24'b100000_000000_000000_000000;
    #10; // Wait for the signal to propagate
    // Add checks to verify BusMuxOut is C_sign_extended
    
    // Complete the simulation
end

endmodule
