module Inport_reg #(parameter DATA_WIDTH_IN = 32, DATA_WIDTH_OUT = 32, INIT = 32'h0)(
	input clear, clock, strobe, 
	input [DATA_WIDTH_IN-1:0]External_Input,
	output wire [DATA_WIDTH_OUT-1:0]BusMuxIn
);  

reg [DATA_WIDTH_IN-1:0]q;
reg strobe_prev;

initial begin
    q = INIT;
    strobe_prev = 1'b0;
end

always @ (posedge clock)
		begin 
			if (clear) begin
				q <= {DATA_WIDTH_IN{1'b0}};
                strobe_prev <= 1'b0;
			end
			else begin
                strobe_prev <= strobe;
                if (strobe && !strobe_prev) begin
				    q <= External_Input;
                end
			end
		end
	assign BusMuxIn = q[DATA_WIDTH_OUT-1:0];
endmodule