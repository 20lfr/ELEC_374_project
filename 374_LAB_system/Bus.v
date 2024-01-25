module Bus (
	//Mux
	input wire [31:0]	R0_BusMuxIn, R1_BusMuxIn, R2_BusMuxIn, R3_BusMuxIn, 
					R4_BusMuxIn, R5_BusMuxIn, R6_BusMuxIn, R7_BusMuxIn, 
					R8_BusMuxIn, R9_BusMuxIn, R10_BusMuxIn, R11_BusMuxIn, 
					R12_BusMuxIn, R13_BusMuxIn, R14_BusMuxIn, R15_BusMuxIn,
	input wire [31:0] 	IR_BusMuxIn, PC_BusMuxIn, RY_BusMuxIn, RZ_BusMuxIn, 
						MAR_BusMuxIn, HI_BusMuxIn, LO_BusMuxIn,

	output wire [31:0] BusMuxOut,

	//Encoder
	input wire 	R0out, R1out, R2out, R3out, 
				R4out, R5out, R6out, R7out, 
				R8out, R9out, R10out, R11out, 
				R12out, R13out, R14out, R15out,

	input wire 	IRout, PCout, RYout, RZout, MARout, HIout, LOout,

);

wire[5:0] S
reg [31:0]q;

always @ (*) begin
	if(R0out) q = R0_BusMuxIn;
	if(R1out) q = R0_BusMuxIn;
	if(R2out) q = R0_BusMuxIn;
	if(R3out) q = R0_BusMuxIn;
	if(R4out) q = R0_BusMuxIn;
	if(R5out) q = R0_BusMuxIn;
	if(R6out) q = R0_BusMuxIn;
	if(R7out) q = R0_BusMuxIn;
	if(R8out) q = R0_BusMuxIn;
	if(R9out) q = R0_BusMuxIn;
	if(R10out) q = R0_BusMuxIn;
	if(R11out) q = R0_BusMuxIn;
	if(R12out) q = R0_BusMuxIn;
	if(R13out) q = R0_BusMuxIn;
	if(R14out) q = R0_BusMuxIn;
	if(R15out) q = R0_BusMuxIn;

	if(R0out) q = R0_BusMuxIn;
	if(R0out) q = R0_BusMuxIn;
	if(R0out) q = R0_BusMuxIn;
	if(R0out) q = R0_BusMuxIn;



end
assign BusMuxOut = q;
endmodule
