module ALU #(parameter DATA_WIDTH = 32)(
	input wire [DATA_WIDTH - 1:0] A, B, 
	input wire [3:0] op, //this is represented as 4 bits becuase we have just less than 16 operations (aka 2^4)
	output reg[(DATA_WIDTH*2)-1:0] result
	
);

//regular operations: AND, OR, XOR, NOT, Shift left, Shift Right, shra, ror, rol, neg
//register operations: load, store, move, 
//arithmatic operations: add, sub, multiply, divide
	
	wire [31:0] and_result, or_result;
	
	and_or and_instance(A, B, 1, and_result);
	and_or or_instance(A, B, 0, or_result);
	
	always @(*) begin
		case(op)
			0	:	result = or_result;
			1	:	result = and_result;
			// ... 
			default: result = and_result;
		endcase
	end
	
endmodule
