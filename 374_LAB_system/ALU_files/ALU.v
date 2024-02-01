module ALU #(parameter DATA_WIDTH = 32)(
	input wire [DATA_WIDTH - 1:0] A, B, 
	input wire [4:0] op, //this is represented as  bits becuase we have just less than 16 operations (aka 2^4)
	output reg[(DATA_WIDTH*2)-1:0] result
	
);

//regular operations: AND, OR, XOR, NOT, Shift left, Shift Right, shra, ror, rol, neg
//register operations: load, store, move, (not needed rn)
//arithmatic operations: add, sub, multiply, divide
	
	wire [31:0] and_result, or_result, add_result, sub_result, mul_result, div_result;
	
	and_or and_instance(A, B, 1, and_result);
	and_or or_instance(A, B, 0, or_result);
	
	CLA_add add_instance(A, B, add_result);
	sub sub_instance(A, B, sub_result);
	mul mul_instance(A, B, mul_result);
	div div_instance(A, B, div_result);
	

	always @(*) begin
		case(op)
			5'd0	:	result = or_result;
			5'd1	:	result = and_result;
			5'd2	: 	result = add_result;
			5'd3	:	result = sub_result;
			5'd4	:	result = mul_result;
			5'd5	: 	result = div_result;

			default: result = 32'bx; //undefined operation, so output unknown variables
		endcase
	end
	
endmodule
