module ALU #(parameter DATA_WIDTH = 32)(
    // Control signals
    input wire [DATA_WIDTH - 1:0] A, B, 
    input wire [4:0] op, // Represented as bits because we have just less than 16 operations (aka 2^4)

    output reg [(DATA_WIDTH*2)-1:0] result 
);

// Regular operations: AND, OR, XOR, NOT, Shift left, Shift Right, shra, ror, rol, neg
// Register operations: load, store, move, (not needed right now)
// Arithmetic operations: add, sub, multiply, divide
    
    wire [(2*DATA_WIDTH)-1:0] and_result, or_result, neg_result, not_result, rol_result, ror_result, shl_result, shr_result, shra_result,
                              add_result, sub_result, unsigned_add_result, mul_result, div_result;
    
    // Outputs
    wire C_out;
    wire Cin = 0; // Assuming Cin is a constant input for add/sub operations
    
    // Logical operations
    and_or and_instance(A, B, 1'b1, and_result);
    and_or or_instance(A, B, 1'b0, or_result);
    neg neg_instance(A, neg_result);
    not_module not_instance(A, not_result);
    rol rol_instance(A, B[4:0], rol_result);
    ror ror_instance(A, B[4:0], ror_result);
    shl shl_instance(A, B[4:0], shl_result); // Fixed typo here
    shra shra_instance(A, B[4:0], shra_result);
    shr shr_instance(A, B[4:0], shr_result);

    // Arithmetic operations
    add_sub add_instance(A, B, 1'b1, 1'b0, Cin, C_out, add_result);
    add_sub sub_instance(A, B, 1'b1, 1'b1, Cin, C_out, sub_result);
    add_sub add_unsigned_instance(A, B, 1'b0, 1'b0, Cin, C_out, unsigned_add_result);

    // Booth multiplier (assuming mul_enable is managed elsewhere or is part of the module's internal logic)
    booth_mul_combinational mul_instance(A, B, mul_result);

    // Division
    div_combinational division_instance(A, B, div_result);

    always @(*) begin
        case(op)
            5'd0:    result = or_result;
            5'd1:    result = and_result;
            5'd2:    result = neg_result;
            5'd3:    result = not_result;
            5'd4:    result = rol_result;
            5'd5:    result = ror_result;
            5'd6:    result = shl_result;
            5'd7:    result = shra_result;
            5'd8:    result = shr_result;

			
            5'd9:    result = add_result;
            5'd10:   result = sub_result;
            5'd11:   result = unsigned_add_result;
            5'd12:   result = mul_result;
            5'd13:   result = div_result;
            default: result = {(2*DATA_WIDTH){1'b0}}; // Default case to clear result
        endcase
    end

endmodule
