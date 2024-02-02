module ALU #(parameter DATA_WIDTH = 32)(
	//control signals
	input reg [DATA_WIDTH - 1:0] A, B, 
	input wire [4:0] op, //this is represented as  bits becuase we have just less than 16 operations (aka 2^4)
	output reg [(DATA_WIDTH*2)-1:0] result 
	
);




//regular operations: AND, OR, XOR, NOT, Shift left, Shift Right, shra, ror, rol, neg
//register operations: load, store, move, (not needed rn)
//arithmatic operations: add, sub, multiply, divide
	
	wire [2*DATA_WIDTH-1:0] and_result, or_result, add_result, sub_result, mul_result, unsigned_add_result;
	
	// Outputs
    wire C_out, Cin;
	
	//and_or and_instance(A, B, 1, and_result);
	//and_or or_instance(A, B, 0, or_result);
	
	add_sub add_instance(A, B, .signed_flag(1'b1), .subtract_enable(1'b0), Cin, C_out, add_result[63:0]);
	add_sub sub_instance(A, B, .signed_flag(1'b1), .subtract_enable(1'b1), Cin, C_out, sub_result[63:0]);
	add_sub add_unsigned_instance(A, B, .signed_flag(1'b0), .subtract_enable(1'b0), Cin, C_out, unsigned_add_result[63:0]);

    // Instance of Booth multiplier
    booth_mul_combinational mul_instance(A, B, mul_result);

    always @(*)begin 

        case(op)
			5'd0:	result = or_result;		  	  //combinational
			5'd1:	result = and_result;		  //combinational
			5'd2: 	result = add_result;		  //combinational
			5'd3:	result = sub_result;		  //combinational
			5'd4:	result = unsigned_add_result; //combinational
			5'd5:   result = mul_result;
        endcase

    end

	
endmodule
