module DataPath(
	input wire 	clock, clear,
	input wire 	[31:0] BusMuxOut,

	input wire 	R0in, R1in, R2in, R3in, 
				R4in, R5in, R6in, R7in, 
				R8in, R9in, R10in, R11in, 
				R12in, R13in, R14in, R15in,

	input wire 	IRin, PCin, RYin, RZin, MARin, HIin, LOin,

	input wire 	R0out, R1out, R2out, R3out, 
				R4out, R5out, R6out, R7out, 
				R8out, R9out, R10out, R11out, 
				R12out, R13out, R14out, R15out,
	
	input wire 	IRout, PCout, RYout, RZout, MARout, HIout, LOout,

	output wire [31:0] R0_BusMuxIn, R1_BusMuxIn, R2_BusMuxIn, R3_BusMuxIn, 
				R4_BusMuxIn, R5_BusMuxIn, R6_BusMuxIn, R7_BusMuxIn, 
				R8_BusMuxIn, R9_BusMuxIn, R10_BusMuxIn, R11_BusMuxIn, 
				R12_BusMuxIn, R13_BusMuxIn, R14_BusMuxIn, R15_BusMuxIn,

	
	output wire IR_BusMuxIn, PC_BusMuxIn, RY_BusMuxIn, RZ_BusMuxIn, MAR_BusMuxIn, HI_BusMuxIn, LO_BusMuxIn



);

//wire [7:0] BusMuxOut, BusMuxInRZ, BusMuxInRA, BusMuxInRB; 
//wire [7:0] Zregin;

//Devices
register R0(clear, clock, R0in, BusMuxOut, R0_BusMuxIn);
register R1(clear, clock, R1in, BusMuxOut, R1_BusMuxIn);
register R2(clear, clock, R2in, BusMuxOut, R2_BusMuxIn);
register R3(clear, clock, R3in, BusMuxOut, R3_BusMuxIn);
register R4(clear, clock, R4in, BusMuxOut, R4_BusMuxIn);
register R5(clear, clock, R5in, BusMuxOut, R5_BusMuxIn);
register R6(clear, clock, R6in, BusMuxOut, R6_BusMuxIn);
register R7(clear, clock, R7in, BusMuxOut, R7_BusMuxIn);
register R8(clear, clock, R8in, BusMuxOut, R8_BusMuxIn);
register R9(clear, clock, R9in, BusMuxOut, R9_BusMuxIn);
register R10(clear, clock, R10in, BusMuxOut, R10_BusMuxIn);
register R11(clear, clock, R11in, BusMuxOut, R11_BusMuxIn);
register R12(clear, clock, R12in, BusMuxOut, R12_BusMuxIn);
register R13(clear, clock, R13in, BusMuxOut, R13_BusMuxIn);
register R14(clear, clock, R14in, BusMuxOut, R14_BusMuxIn);
register R15(clear, clock, R15in, BusMuxOut, R15_BusMuxIn);

register IR(clear, clock, IRin, BusMuxOut, IR_BusMuxIn);
register PC(clear, clock, PCin, BusMuxOut, PC_BusMuxIn);
register RY(clear, clock, RYin, BusMuxOut, RY_BusMuxIn);
register RZ(clear, clock, RZin, BusMuxOut, RZ_BusMuxIn);
register MAR(clear, clock, MARin, BusMuxOut, MAR_BusMuxIn);
register HI(clear, clock, HIin, BusMuxOut, HI_BusMuxIn);
register LO(clear, clock, LOin, BusMuxOut, LO_BusMuxIn);


//Bus
Bus bus(BusMuxInRZ, BusMuxInRA, BusMuxInRB, RZout, RAout, RBout, BusMuxOut);


// adder
ALU add(A, BusMuxOut, Zregin);


endmodule
