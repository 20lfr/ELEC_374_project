module Bus_Encoder (
    input wire HIout, LOout, Zhi_out, Zlo_out, PCout, MDRout, Inport_out, Cout, 
	 			R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
    output wire [4:0] Encoder_signals_out 
	//Why are we using a register instead of wires? -- this is becuase Enocoder_signals_out is modified in real-time in the always block
);

reg [4:0] enable_signals;


//NOTE: none of these inputs should be high at the same time. Only one can be driven
always @(*) begin
    case (1'b1) // Check which input line is high
        R0out: enable_signals = 5'd0;
        R1out: enable_signals = 5'd1;
        R2out: enable_signals = 5'd2;
        R3out: enable_signals = 5'd3;
        R4out: enable_signals = 5'd4;
        R5out: enable_signals = 5'd5;
        R6out: enable_signals = 5'd6;
        R7out: enable_signals = 5'd7;
        R8out: enable_signals = 5'd8;
        R9out: enable_signals = 5'd9;
        R10out: enable_signals = 5'd10;
        R11out: enable_signals = 5'd11;
        R12out: enable_signals = 5'd12;
        R13out: enable_signals = 5'd13;
        R14out: enable_signals = 5'd14;
        R15out: enable_signals = 5'd15;

        HIout: enable_signals = 5'd16;
        LOout: enable_signals = 5'd17;
        Zhi_out: enable_signals = 5'd18;
        Zlo_out: enable_signals = 5'd19;
        PCout: enable_signals = 5'd20;
        MDRout: enable_signals = 5'd21;
        Inport_out: enable_signals = 5'd22;
        Cout: enable_signals = 5'd23;
        default: enable_signals = 5'b00000; // Zero if no signal is active
    endcase
end

assign Encoder_signals_out = enable_signals;

endmodule
