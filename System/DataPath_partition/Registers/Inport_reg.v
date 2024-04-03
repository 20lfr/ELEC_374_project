module Inport_reg #(parameter DATA_WIDTH_IN = 32, DATA_WIDTH_OUT = 32, INIT = 32'h0)(
	input clear, clock, //strobe, 
	input [DATA_WIDTH_IN-1:0]External_Input,
	output wire [DATA_WIDTH_OUT-1:0]External_output
);  

	reg [DATA_WIDTH_IN-1:0]q;
	initial q = INIT;
	always @ (External_Input) begin 
		if (clear) begin
			q <= {DATA_WIDTH_IN{1'b0}};
		end
		else q <= External_Input;
		
	end

		
	assign External_output = q[DATA_WIDTH_OUT-1:0];
endmodule