module half_adder(
	input wire X, Y,
	output wire C, S
);

    assign C = X & Y;
    assign S = X ^ Y;
	
endmodule
