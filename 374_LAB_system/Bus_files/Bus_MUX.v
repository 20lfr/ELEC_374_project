module Bus_MUX (
	//Mux
	input wire [31:0] 	R0_BusMuxIn, R1_BusMuxIn, R2_BusMuxIn, R3_BusMuxIn, 
						R4_BusMuxIn, R5_BusMuxIn, R6_BusMuxIn, R7_BusMuxIn, 
						R8_BusMuxIn, R9_BusMuxIn, R10_BusMuxIn, R11_BusMuxIn, 
						R12_BusMuxIn, R13_BusMuxIn, R14_BusMuxIn, R15_BusMuxIn,	

						HI_BusMuxIn, LO_BusMuxIn, RZ_HI_BusMuxIn, RZ_LO_BusMuxIn, 
						PC_BusMuxIn, MDR_Bus_lines, Inport_BusIn, C_sign_extended,

	output wire [31:0] BusMuxOut,

	//Encoder
	input wire HIout, LOout, Zhi_out, Zlo_out, PCout, MDRout, Inport_out, Cout, 
	 			R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out
);


wire [4:0] Encoder_select_signals;
Bus_Encoder encoder_32_to_5(HIout, LOout, Zhi_out, Zlo_out, PCout, MDRout, Inport_out, Cout, 
	 			            R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out, 
                
                            Encoder_select_signals);


reg [31:0]q;

always @(*) begin
        case (Encoder_select_signals)
            5'd0: q = R0_BusMuxIn;
            5'd1: q = R1_BusMuxIn;
            5'd2: q = R2_BusMuxIn;
			5'd3: q = R3_BusMuxIn;
            5'd4: q = R4_BusMuxIn;
            5'd5: q = R5_BusMuxIn;
			5'd6: q = R6_BusMuxIn;
            5'd7: q = R7_BusMuxIn;
            5'd8: q = R8_BusMuxIn;
			5'd9: q = R9_BusMuxIn;
            5'd10: q = R10_BusMuxIn;
            5'd11: q = R11_BusMuxIn;
			5'd12: q = R12_BusMuxIn;
            5'd13: q = R13_BusMuxIn;
            5'd14: q = R14_BusMuxIn;
			5'd15: q = R15_BusMuxIn;

            5'd16: q = HI_BusMuxIn;
            5'd17: q = LO_BusMuxIn;
			5'd18: q = RZ_HI_BusMuxIn;
            5'd19: q = RZ_LO_BusMuxIn;
			5'd20: q = PC_BusMuxIn;
            5'd21: q = MDR_Bus_lines;
			5'd22: q = Inport_BusIn;
            5'd23: q = C_sign_extended;


            default: q = 1'bx; // Undefined state
        endcase
    end
assign BusMuxOut = q;
endmodule
