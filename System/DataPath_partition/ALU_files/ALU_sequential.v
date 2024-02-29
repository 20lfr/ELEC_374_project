module ALU #(parameter DATA_WIDTH = 32)(
    input wire [DATA_WIDTH - 1:0] A, B,
    input wire [4:0] op,
    input wire clk, reset,
    output reg [(DATA_WIDTH*2)-1:0] result
);

    // Define states for the state machine
    localparam IDLE = 1'b0, DIV_BUSY = 1'b1;
    reg state;

    initial begin
        state = IDLE;
    end

    // Division module signals (example interface)
    wire div_busy, div_done;
    wire [2*DATA_WIDTH-1:0] and_result, or_result, add_result, sub_result, mul_result, unsigned_add_result, div_result;
    reg div_start = 0; // Signal to start the division

    // Outputs
    wire C_out, Cin;

    // Instantiate your division module here
    // Assume it has div_start, div_busy, div_done, and div_result signals
    div division_instance(
        .clk(clk),
        .reset(reset),
        .start(div_start),
        .dividend(A),
        .divisor(B),
        .result(div_result),
        .busy(div_busy),
        .done(div_done)
    );
	

	
	and_or and_instance(A, B, 1, and_result);
	and_or or_instance(A, B, 0, or_result);
	
	add_sub add_instance(A, B, .signed_flag(1'b1), .subtract_enable(1'b0), Cin, C_out, add_result[63:0]);
	add_sub sub_instance(A, B, .signed_flag(1'b1), .subtract_enable(1'b1), Cin, C_out, sub_result[63:0]);
	add_sub add_unsigned_instance(A, B, .signed_flag(1'b0), .subtract_enable(1'b0), Cin, C_out, unsigned_add_result[63:0]);

    // Instance of Booth multiplier
    booth_mul_combinational mul_instance(A, B, mul_result);


    // ALU operation handling
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            result <= 0;
            div_start <= 0;
        end else if (op <= 5)begin
            case(op)
                // Handle combinational ops
                5'd0:	result = or_result;		  	  	//combinational
                5'd1:	result = and_result;		  	//combinational
                5'd2: 	result = add_result;		  	//combinational
                5'd3:	result = sub_result;		  	//combinational
                5'd4:	result = unsigned_add_result; 	//combinational
                5'd5:   result = mul_result; 		 	//combinational
            endcase
        end else if (op == 6) begin
            case (state)
                IDLE: begin
                    div_start <= 1; // Start division
                    state <= DIV_BUSY;
                end
                DIV_BUSY: begin
                    div_start <= 0; // Clear start signal after one cycle
                    if (div_done) begin
                        result <= div_result; // Capture division result
                        state <= IDLE; // Return to idle state
                    end
                end
            endcase
        end 
    end
endmodule
