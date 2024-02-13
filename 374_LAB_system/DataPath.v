module DataPath(
	input wire 	clock, clear,


	/*ENABLE REGISTER signals*/
	input wire 	R0in, R1in, R2in, R3in, 
				R4in, R5in, R6in, R7in, 
				R8in, R9in, R10in, R11in, 
				R12in, R13in, R14in, R15in,

	input wire 	IRin, PCin, RYin, RZin, MARin, MDRin, HIin, LOin, Outport_in, Inport_in, 
	/*~~~~~~~~~~~~~~~~~~~~~~~*/



	/*BUS Signals~~~~~~~~~~~~~~~~~~~~~~~*/
	input wire [23:0] Bus_Encoder_signals
	// The below is the bit layout for each bit in the "Bus_Encoder_signals"
	/*
	General Purpose registers: bites 0 -> 15
	HIout (16), LOout (17), Zhi_out (18), Zlo_out (19), PCout (20), MDRout (21), Inport_out (22), Cout (23)
	*/

	/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/



	/*Memory Signals Signals*/
	output 	reg [31:0] MAR_to_chip,
	input 	wire Mem_read,//this is for MDR
	inout 	wire [31:0] MDR_Mem_lines, /*Mdatain*/

	/*I/O Interfacing*/
	input wire [31:0] Inport_data_in,
	output reg [31:0] Outport_data_out


	/*ALU control*/
	input wire [4:0] opcode;



);

//wire [7:0] BusMuxOut, BusMuxInRZ, BusMuxInRA, BusMuxInRB; 
//wire [7:0] Zregin;



/*Internal Connections*/
wire [31:0] BusMuxOut; /*Why is the a wire you ask and not an "input wire"? Becuase the bus outputs this wire and is an input for registers
						connected to the bus. BusMuxOut is not an input from any externel source, meaning it cannot be an input for the DataPath*/
wire [31:0] R0_BusMuxIn, R1_BusMuxIn, R2_BusMuxIn, R3_BusMuxIn, 
			R4_BusMuxIn, R5_BusMuxIn, R6_BusMuxIn, R7_BusMuxIn, 
			R8_BusMuxIn, R9_BusMuxIn, R10_BusMuxIn, R11_BusMuxIn, 
			R12_BusMuxIn, R13_BusMuxIn, R14_BusMuxIn, R15_BusMuxIn,	

			HI_BusMuxIn, LO_BusMuxIn, RZ_HI_BusMuxIn, RZ_LO_BusMuxIn, 
			PC_BusMuxIn, MDR_Bus_lines, Inport_BusIn, C_sign_extended;




/*ALU connections*/
wire [(DATA_WIDTH*2)-1:0] ALU_result;
wire [31:0] ALU_HI, ALU_LO;
assign ALU_HI = ALU_result[(DATA_WIDTH*2)-1:DATA_WIDTH];
assign ALU_LO = ALU_result[DATA_WIDTH-1:0];


wire [DATA_WIDTH-1:0] RY_to_ALU;






//Registers~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

/*Layout: Rn(clear, clock, enable, D input, Q output)*/
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

//control registers
register IR(clear, clock, IRin, BusMuxOut, IR_BusMuxIn);
register PC(clear, clock, PCin, BusMuxOut, PC_BusMuxIn);

//ALU registers
register RY(clear, clock, RYin, BusMuxOut, RY_to_ALU);
register RZ_HI(clear, clock, RZin, ALU_HI, RZ_HI_BusMuxIn);
register RZ_LO(clear, clock, RZin, ALU_LO, RZ_LO_BusMuxIn);


//Memory interfacing registers
register MAR(clear, clock, MARin, BusMuxOut, MAR_to_chip);
MDR #(.DATA_WIDTH(32)) MDR_reg(.clear(clear), .clock(clock), .enable(MDRin), .read(Mem_read), .bus_data_lines(MDR_Bus_lines), .mem_data_lines(MDR_Mem_lines));



//64 bit holding registers
register HI(clear, clock, HIin, BusMuxOut, HI_BusMuxIn);
register LO(clear, clock, LOin, BusMuxOut, LO_BusMuxIn);



//I/O registers
register Inport(clear, clock, Inport_in, Inport_data_in, Inport_BusIn);
register Outport(clear, clock, Outport_in, BusMuxOut, Outport_data_out);
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






//Bus
Bus_MUX Bus(R0_BusMuxIn, R1_BusMuxIn, R2_BusMuxIn, R3_BusMuxIn, 
			R4_BusMuxIn, R5_BusMuxIn, R6_BusMuxIn, R7_BusMuxIn, 
			R8_BusMuxIn, R9_BusMuxIn, R10_BusMuxIn, R11_BusMuxIn, 
			R12_BusMuxIn, R13_BusMuxIn, R14_BusMuxIn, R15_BusMuxIn,	

			HI_BusMuxIn, LO_BusMuxIn, RZ_HI_BusMuxIn, RZ_LO_BusMuxIn, 
			PC_BusMuxIn, MDR_Bus_lines, Inport_BusIn, C_sign_extended,
			
			BusMuxOut, 
			
			Bus_Encoder_signals
			);


// adder
ALU add(.A(RY_to_ALU), .B(BusMuxOut), .op(opcode), .result(ALU_result));


endmodule
