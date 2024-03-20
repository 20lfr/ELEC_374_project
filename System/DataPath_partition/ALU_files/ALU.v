module ALU #(parameter DATA_WIDTH = 32)(
    // Control signals
    input wire [DATA_WIDTH - 1:0] A, B, 
    input wire [4:0] op, // Represented as bits because we have just less than 16 operations (aka 2^4)

    output reg [(DATA_WIDTH*2)-1:0] result,
    input wire IncPC
);

// Regular operations: AND, OR, XOR, NOT, Shift left, Shift Right, shra, ror, rol, neg
// Register operations: load, store, move, (not needed right now)
// Arithmetic operations: add, sub, multiply, divide
    
    wire [(2*DATA_WIDTH)-1:0] and_result, or_result, neg_result, not_result, rol_result, ror_result, shl_result, shr_result, shra_result,
                              add_result, sub_result, unsigned_add_result, mul_result, div_result;

    parameter   AND = 5'b01011, OR = 5'b01010, NEG = 5'b10001, NOT_MOD = 5'b10010, ROL = 5'b01001, ROR = 5'b01000, SHL = 5'b00111, SHRA = 5'b00110, SHR = 5'b00101,
                ADD = 5'b00011, SUB = 5'b00100, UNS_ADD = 5'b11111, MUL = 5'b01111, DIV = 5'b10000;
    
    // Outputs
    wire C_out;
    wire Cin = 0; // Assuming Cin is a constant input for add/sub operations
    
    // Logical operations
    and_or and_instance(A, B, 1'b1, and_result);
    and_or or_instance(A, B, 1'b0, or_result);
    neg neg_instance(B, neg_result);
    not_module not_instance(B, not_result);
    rol rol_instance(A, B[4:0], rol_result);
    ror ror_instance(A, B[4:0], ror_result);
    shl shl_instance(A, B[4:0], shl_result); 
    shra shra_instance(A, B[4:0], shra_result);
    shr shr_instance(A, B[4:0], shr_result);

    // Arithmetic operations
    add_sub add_instance(A, B, 1'b1, 1'b0, Cin, C_out, add_result);
    add_sub sub_instance(A, B, 1'b1, 1'b1, Cin, C_out, sub_result);
    add_sub add_unsigned_instance(A, B, 1'b0, 1'b0, Cin, C_out, unsigned_add_result);

    // Booth multiplier (assuming mul_enable is managed elsewhere or is part of the module's internal logic)
    booth_2_pair mul_instance(A, B, mul_result);

    // Division
    div_combinational division_instance(A, B, div_result);


    always @(*) begin
        if(IncPC)begin 
            result[DATA_WIDTH-1:0] = B + 1;
            result[(DATA_WIDTH*2)-1:DATA_WIDTH] = 32'd0;
        end
        else begin
            case(op)
                AND:        result = and_result;
                OR:         result = or_result;
                NEG:        result = neg_result;
                NOT_MOD:    result = not_result;
                ROL:        result = rol_result;
                ROR:        result = ror_result;
                SHL:        result = shl_result;
                SHRA:       result = shra_result;
                SHR:        result = shr_result;

                
                ADD:        result = add_result;
                SUB:        result = sub_result;
                UNS_ADD:    result = unsigned_add_result; //MAY NEED TO CHANGE LATER
                MUL:        result = mul_result;
                DIV:        result = div_result;
                default: result = {(2*DATA_WIDTH){1'b0}}; // Default case to clear result
            endcase
        end

        
    end

endmodule
