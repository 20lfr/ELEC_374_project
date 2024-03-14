module CON_FF (
    input wire [31:0] IR, // Fixed declaration
    input wire [31:0] BusMuxOut, // Fixed declaration
    input wire enable,
    output reg toControl // Output to control signals
);

initial begin toControl <= 0; end 
//this always block only triggers when enable changes
always @(enable) begin
    if(enable) begin
        case(IR[20:19])
            2'b00:
                // Branch if Zero
                begin
                    if (BusMuxOut == 32'h0000_0000) toControl <= 1'b1;
                    else toControl <= 1'b0;
                end
            2'b01:
                // Branch if Nonzero
                begin
                    if (BusMuxOut != 32'h0000_0000) toControl <= 1'b1;
                    else toControl <= 1'b0;
                end
            2'b10:
                // Branch if Positive
                begin
                    if (BusMuxOut[31] == 0) toControl <= 1'b1;
                    else toControl <= 1'b0;
                end
            2'b11:
                // Branch if Negative
                begin
                    if (BusMuxOut[31] == 1) toControl <= 1'b1;
                    else toControl <= 1'b0;
                end
        endcase


    end 
end
    
endmodule
