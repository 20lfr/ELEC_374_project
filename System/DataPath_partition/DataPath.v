module DataPath #(parameter DATA_WIDTH = 32)(
	input wire 	clock, clear,


	/*ENABLE REGISTER signals*/
	input wire 	IRin, PCin, RYin, RZin, MARin, MDRin, HIin, LOin, Outport_in, strobe, 
	/*~~~~~~~~~~~~~~~~~~~~~~~*/



	/*BUS Signals~~~~~~~~~~~~~~~~~~~~~~~*/
	input wire 	HIout, LOout, Zhi_out, Zlo_out, PCout, MDRout, Inport_out, Cout, 
	/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/



	/*Memory Signals Signals*/
	output 	wire [9:0] MAR_to_chip,
	output 	wire [31:0] Mem_dataout,
	input 	wire Mem_read,//this is for MDR
	input 	wire [31:0] Mem_datain, /*Mdatain*/

	/*I/O Interfacing*/
	input wire [31:0] External_In,
	output wire [31:0] External_Out,


	/*Control Unit*/
	input wire [4:0] opcode,
	input wire 	IncPC,

	input wire Gra, Grb, Grc, Rin, Rout, BAout,

	output wire con_ff_bit /*Branch boolean for Phase 2.4*/



	/*TEST OUTPUTS*/
	output wire [31:0] reg1, reg2, reg3, reg4, reg5, reg6, reg7, regMDR,

	output wire [31:0] BusMuxOut_out, 
	output wire [31:0] PC_VALUE, HI_VALUE, LO_VALUE, IR_VALUE
);

/*Testing Connections*/
	/*General Registers*/
	assign reg1 = R1_BusMuxIn;
	assign reg2 = R2_BusMuxIn;
	assign reg3 = R3_BusMuxIn;
	assign reg4 = R4_BusMuxIn;
	assign reg5 = R5_BusMuxIn;
	assign reg6 = R6_BusMuxIn;
	assign reg7 = R7_BusMuxIn;
	assign regMDR = MDR_BusMuxIn;

	/*DataPath Registers*/
	assign BusMuxOut_out = BusMuxOut;
	assign PC_VALUE = PC_BusMuxIn;
	assign HI_VALUE = HI_BusMuxIn;
	assign LO_VALUE = LO_BusMuxIn;
	assign IR_VALUE = IR_BusMuxIn;







/*Internal Connections*/
	wire [31:0] BusMuxOut; 

	wire [31:0] R0_BusMuxIn, R1_BusMuxIn, R2_BusMuxIn, R3_BusMuxIn, 
				R4_BusMuxIn, R5_BusMuxIn, R6_BusMuxIn, R7_BusMuxIn, 
				R8_BusMuxIn, R9_BusMuxIn, R10_BusMuxIn, R11_BusMuxIn, 
				R12_BusMuxIn, R13_BusMuxIn, R14_BusMuxIn, R15_BusMuxIn,	

				IR_BusMuxIn, HI_BusMuxIn, LO_BusMuxIn, RZ_HI_BusMuxIn, RZ_LO_BusMuxIn, 
				PC_BusMuxIn, MDR_BusMuxIn, Inport_BusMuxIn, C_sign_extended, R0_out;

/*Control Internal Connections*/
	/*Bus Encoder Select Signals*/
	wire 	R0out, R1out, R2out, R3out, 
			R4out, R5out, R6out, R7out, 
			R8out, R9out, R10out, R11out, 
			R12out, R13out, R14out, R15out;

	/*General Purpose Register Enable*/
	wire 	R0in, R1in, R2in, R3in, 
			R4in, R5in, R6in, R7in, 
			R8in, R9in, R10in, R11in, 
			R12in, R13in, R14in, R15in,




//Registers~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	/*Layout: Rn(clear, clock, enable, D input, Q output)*/
		
		register R0(clear, clock, R0in, BusMuxOut, R0_out);
		assign R0_BusMuxIn = R0_out & (~BAout); /*this is for isolating R0 for load or store (Phase 2: 2.3)*/
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
		//MDR #(.DATA_WIDTH(32)) MDR_reg(.clear(clear), .clock(clock), .enable(MDRin), .read(Mem_read), .bus_data_lines(MDR_BusMuxIn), .mem_data_lines(MDR_Mem_lines));
		MDR2 #(.DATA_WIDTH(32)) MDR_reg(.clear(clear), .clock(clock), .enable(MDRin), .read(Mem_read), .BusMuxOut(BusMuxOut), .Mdatain(Mem_datain), .BusMuxIn(MDR_BusMuxIn));
		assign Mem_dataout = MDR_BusMuxIn; /*this is for data_in for RAM*/


	//64 bit holding registers
		register HI(clear, clock, HIin, BusMuxOut, HI_BusMuxIn);
		register LO(clear, clock, LOin, BusMuxOut, LO_BusMuxIn);



	//I/O registers
		//register Inport(clear, clock, Inport_in, Inport_data_in, Inport_BusMuxIn);
		//register Outport(clear, clock, Outport_in, BusMuxOut, Outport_data_out);

		Input_reg Inport(clear, clock, strobe, External_In, BusMuxIn);
		Output_reg Outport(clear, clock, Outport_in, BusMuxOut, External_Out);

//Bus~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	Bus_MUX Bus(R0_BusMuxIn, R1_BusMuxIn, R2_BusMuxIn, R3_BusMuxIn, 
			R4_BusMuxIn, R5_BusMuxIn, R6_BusMuxIn, R7_BusMuxIn, 
			R8_BusMuxIn, R9_BusMuxIn, R10_BusMuxIn, R11_BusMuxIn, 
			R12_BusMuxIn, R13_BusMuxIn, R14_BusMuxIn, R15_BusMuxIn,	

			HI_BusMuxIn, LO_BusMuxIn, RZ_HI_BusMuxIn, RZ_LO_BusMuxIn, 
			PC_BusMuxIn, MDR_BusMuxIn, Inport_BusMuxIn, C_sign_extended,
			
			BusMuxOut, 
			
			HIout, LOout, Zhi_out, Zlo_out, PCout, MDRout, Inport_out, Cout, 
	 		R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out
			);

//ALU~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	/*ALU connections~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
	wire [(DATA_WIDTH*2)-1:0] ALU_result;
	wire [31:0] ALU_HI, ALU_LO;
	assign ALU_HI = ALU_result[(DATA_WIDTH*2)-1:DATA_WIDTH];
	assign ALU_LO = ALU_result[DATA_WIDTH-1:0];
	wire [DATA_WIDTH-1:0] RY_to_ALU;

	ALU alu(.A(RY_to_ALU), .B(BusMuxOut), .op(opcode), .result(ALU_result), .IncPC(IncPC));

/*Phase 2 and Control Signal*/

	/*2.2: Sign Extend Constant within IR*/
		assign C_sign_extended = {{12{IR_BusMuxIn[18]}}, IR_BusMuxIn[18:0]}; //12{IR_BusMuxIn[18]} is notation for "create 12 bits repeating of {a}. Phase 2: 2.2"

	/*2.2: Select_and_Encoder*/
		Select_and_Decode_IR IR_register_decoder(
			.IR_data(IR_BusMuxIn), /*may need to be changed*/
			.Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), .BAout(BAout),
			.R0out(R0out), .R1out(R1out), .R2out(R2out), .R3out(R3out), .R4out(R4out), .R5out(R5out), .R6out(R6out), .R7out(R7out), .R8out(R8out), .R9out(R9out), R10out(R10out), .R11out(R11out), .R12out(R12out), .R13out(R13out), .R14out(R14out), .R15out(R15out),
			.R0in(R0in), .R1in(R1in),. R2in(R2in), .R3in(R3in), .R4in(R4in), .R5in(R5in), .R6in(R6in), .R7in(R7in), .R8in(R8in), .R9in(R9in), .R10in(R10in), .R11in(R11in), .R12in(R12in), .R13in(R13in), .R14in(R14in), .R15in(R15in)
		); 
	/*2.4: CON_FF*/
		CON_FF con_ff(
			.IR(IR_BusMuxIn), .BusMuxOut(BusMuxOut), 
			.toControl(con_ff_bit)
		);



endmodule
