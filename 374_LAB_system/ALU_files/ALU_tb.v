`timescale 1ns/10ps
module ALU_tb;

	reg[31:0] input_a, input_b;
	reg[4:0] opcode;
	reg unsigned_flag;//0 if unsignedm 1 if signed
	wire[63:0] ALU_result;
	
	ALU ALU_instance(input_a, input_b, opcode, unsigned_flag, ALU_result[63:0]);
	
	initial
		begin
			input_a <= 2;
			input_b <= 3;
			opcode <= 2;
			unsigned_flag <= 0;
			
		#200 //wait 200ns
			input_a <= 2;
			input_b <= 3;
			opcode <= 2;
			unsigned_flag <= 1;
		end
	
endmodule
