module and_or(
	input wire [7:0] A, B, 
	input wire selection, 
	output wire [7:0] result
);

	assign result = (selection == 1) ? A & B : A | B;
	
endmodule
