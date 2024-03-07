`timescale 1ns/10ps

module ALU_tb;

parameter DATA_WIDTH = 32;

reg [DATA_WIDTH-1:0] A, B;
reg [4:0] op;
wire [(DATA_WIDTH*2)-1:0] result;
wire [DATA_WIDTH-1:0] Z_high, Z_low;
assign Z_high = result[(DATA_WIDTH*2) -1: DATA_WIDTH];

assign Z_low = result[DATA_WIDTH - 1: 0];

// Instantiate the Unit Under Test (UUT)
ALU #(.DATA_WIDTH(DATA_WIDTH)) uut (
    .A(A), 
    .B(B), 
    .op(op), 
    .result(result)
);

initial begin
    // Initialize Inputs
    A = 0;
    B = 0;
    op = 0;

    $monitor("Time=%t, A=%d, B=%d, op=%d, result=%d, Z_high=%d, Z_low=%d", 
             $time, $signed(A), $signed(B), $signed(op), $signed(result), $signed(Z_high), $signed(Z_low));

    // Wait for global reset
    #100;

    // Logical Operations
    // Test AND operation
    // A = 32'hFFFF0000; B = 32'h0000FFFF; op = 5'd1; #100;
    // // Test OR operation
    // A = 32'hFFFF0000; B = 32'h0000FFFF; op = 5'd0; #100;
    // // Test NEG operation (note: might require special handling in ALU or test)
    // A = 32'h1; B = 32'h0; op = 5'd2; #100;
    // // Test NOT operation
    // A = 32'hFFFFFFFF; B = 32'h0; op = 5'd3; #100;
    // // Test ROL operation
    // A = 32'h1; B = 32'h1; op = 5'd4; #100;
    // // Test ROR operation
    // A = 32'h2; B = 32'h1; op = 5'd5; #100;
    // // Test SHL operation
    // A = 32'h1; B = 32'h2; op = 5'd6; #100;
    // // Test SHRA operation
    // A = 32'hFFFFFFFF; B = 32'h1; op = 5'd7; #100;
    // // Test SHR operation
    // A = 32'h80000000; B = 32'h1; op = 5'd8; #100;

    // Arithmetic Operations
    // Test ADD operation
    A = 32'hFFFF0001; B = 32'h00000001; op = 5'd9; #100;
    // Test SUB operation
    A = 32'h00050005; B = 32'h00050006; op = 5'd10; #100;
    // Test Unsigned ADD operation
    A = 32'hFFFF0000; B = 32'h00000001; op = 5'd11; #100;


    // Test MUL operation
    A = 32'hFFFF0000; B = 32'h00000004; op = 5'd12; #100;


    // Test DIV operation
    A = 32'h80000000; B = 32'h00000000; op = 5'd13; #100;

end
endmodule
