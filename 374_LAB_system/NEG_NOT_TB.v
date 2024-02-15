// datapath_tb.v file: <This is the filename>
`timescale 1ns/10ps

module NEG_NOT_TB;

  reg HIout, LOout, Zhi_out, Zlo_out, PCout, MDRout, Inport_out, 
    Cout, R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, 
    R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out; 
 


                                      /*Cout, Inport, MDR, PC, Zlo, Zhi, LO, HI*/
  //assign Bus_Encoder_signals[23:16] = {0, 0, MDRout, PCout, Zlowout, 0, 0, 0};


  reg MARin, Zin, PCin, MDRin, IRin, Yin, HIin, LOin;
  reg IncPC, Read;

  reg R0in, R1in, R2in, R3in, 
				R4in, R5in, R6in, R7in, 
				R8in, R9in, R10in, R11in, 
				R12in, R13in, R14in, R15in;
  reg [4:0] opcode; /*the opcode for an AND operation is opcode = 00001*/
  reg Clock;


  reg [31:0] Mdatain;
  

  /*NOTE: we are performing two operations.
    1. load data from memory into general purpose registers: R1, R2, R3
    2. do an AND operation: and r1, r2, r3*/


  parameter Default = 6'd0, Reg_load1a = 6'd1, Reg_load1b = 6'd2, Reg_load2a = 6'd3,
            Reg_load2b = 6'd4, Reg_load3a = 6'd5, Reg_load3b = 6'd6, 
            
        
            NEG_T0 = 6'd75, NEG_T1 = 6'd76, NEG_T2 = 6'd77, NEG_T3 = 6'd78, NEG_T4 = 6'd79, 
            NOT_T0 = 6'd81, NOT_T1 = 6'd82, NOT_T2 = 6'd83, NOT_T3 = 6'd84, NOT_T4 = 6'd85;
  reg [5:0] Present_state = Default;




  wire [31:0] dummy_outputs, Mem_address_lines; // For capturing any unused output ports if needed
  wire unused; // Connect unused inputs to this wire if a default state is needed

  wire [31:0] register1, register2, register3, registerMDR, BusMuxOut, resgisterPC, 
              resgisterHI, resgisterLO, resgisterIR;


  DataPath DUT(
      .clock(Clock), .clear(1'b0),
      /*enable signals*/
      .R0in(R0in), .R4in(R4in), .R5in(R5in), .R6in(R6in), 
      .R7in(R7in), .R8in(R8in), .R9in(R9in), .R10in(R10in), 
      .R11in(R11in), .R12in(R12in), .R13in(R13in), .R14in(R14in), 
      .R15in(R15in),
      .R1in(R1in), .R2in(R2in), .R3in(R3in), 
      .IRin(IRin), .PCin(PCin), .RYin(Yin), .RZin(Zin), .MARin(MARin), 
      .MDRin(MDRin), .HIin(HIin), .LOin(LOin), .Outport_in(1'b0), .Inport_in(1'b0),

      .IncPC(IncPC),



      .HIout(HIout), .LOout(LOout), .Zhi_out(Zhi_out), .Zlo_out(Zlo_out), 
      .PCout(PCout), .MDRout(MDRout), .Inport_out(Inport_out), .Cout(Cout),
      .R0out(R0out),.R1out(R1out),.R2out(R2out),.R3out(R3out),.R4out(R4out),
      .R5out(R5out),.R6out(R6out),.R7out(R7out),.R8out(R8out),.R9out(R9out),
      .R10out(R10out),.R11out(R11out),.R12out(R12out),.R13out(R13out),
      .R14out(R14out),.R15out(R15out),

      .MAR_to_chip(Mem_address_lines), .Mem_read(Read), .MDR_Mem_lines(Mdatain), 
      .Inport_data_in(32'h00000000), .Outport_data_out(dummy_outputs),
      .opcode(opcode),
      /*TEST OUTPTUS*/
      .reg1(register1), .reg2(register2), .reg3(register3), .regMDR(registerMDR), .BusMuxOut_out(BusMuxOut), 
      .PC_VALUE(resgisterPC), .HI_VALUE(resgisterHI), .LO_VALUE(resgisterLO), .IR_VALUE(resgisterIR)
  );



               

  // add test logic here
  initial begin
    Clock = 0;
    forever #10 Clock = ~Clock;
  end

  always @(posedge Clock) // finite state machine; if clock rising-edge
  begin
    case (Present_state)
      Default : Present_state = Reg_load1a;
      Reg_load1a : Present_state = Reg_load1b;
      Reg_load1b : Present_state = Reg_load2a;
      Reg_load2a : Present_state = Reg_load2b;
      Reg_load2b : Present_state = Reg_load3a;
      Reg_load3a : Present_state = Reg_load3b;
      Reg_load3b : Present_state = NEG_T0;



      NEG_T0: Present_state = NEG_T1;
      NEG_T1: Present_state = NEG_T2;
      NEG_T2: Present_state = NEG_T3;
      NEG_T3: Present_state = NEG_T4;
      NEG_T4: Present_state = NOT_T0;

      NOT_T0: Present_state = NOT_T1;
      NOT_T1: Present_state = NOT_T2;
      NOT_T2: Present_state = NOT_T3;
      NOT_T3: Present_state = NOT_T4;
      

    endcase
  end


  always @(Present_state) // do the required job in each state
  begin
    case (Present_state) // assert the required signals in each clock cycle
      Default: begin
        PCout <= 0; Zlo_out <= 0; MDRout <= 0; // initialize the signals

        R2out <= 0; R3out <= 0; 
        MARin <= 0; Zin <= 0;
        PCin <= 0; MDRin <= 0; IRin <= 0; Yin <= 0; LOin <= 0; HIin <=0;
        IncPC <= 0; Read <= 0; opcode <= 0;

        R0in <= 0; R1in <= 0; R2in <= 0; R3in <= 0; R4in <= 0; R5in <= 0; 
        R6in <= 0; R7in <= 0; R8in <= 0; R9in <= 0; R10in <= 0; R11in <= 0; 
        R12in <= 0; R13in <= 0; R14in <= 0; R15in <= 0;

        
        
        Mdatain <= 32'h00000000; 



      end
      Reg_load1a: begin
        Mdatain <= 32'h00000010;
        Read = 0; MDRin = 0; // the first zero is there for completeness
        #10 Read <= 1; MDRin <= 1;  
        #10 Read <= 0; MDRin <= 0;  
      end
      Reg_load1b: begin
        Mdatain <= 32'h00000011;
        #10 MDRout <= 1; R2in <= 1; PCin <= 1;
        #10 MDRout <= 0; R2in <= 0; PCin <= 0;// initialize R2 with the value $12
      end
      Reg_load2a: begin
        Mdatain <= 32'h00000014;
        #10 Read <= 1; MDRin <= 1;
        #10 Read <= 0; MDRin <= 0;
      end
      Reg_load2b: begin
        #10 MDRout <= 1; R3in <= 1;
        #10 MDRout <= 0; R3in <= 0; // initialize R3 with the value $14
      end
      Reg_load3a: begin
        Mdatain <= 32'h00000018;
        #10 Read <= 1; MDRin <= 1;
        #10 Read <= 0; MDRin <= 0;
      end
      Reg_load3b: begin
        #10 MDRout <= 1; R1in <= 1;
        #10 MDRout <= 0; R1in <= 0; // initialize R1 with the value $18
      end

      

      /*NEG~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
      NEG_T0: begin Zlo_out <= 0; R1in <= 0;                 PCout <= 1; IncPC <= 1; MARin <= 1; Zin <= 1; end
      NEG_T1: begin
        PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
        Zlo_out <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
        Mdatain <= 32'h28918000; 
      end
      NEG_T2: begin Zlo_out <= 0; PCin <= 0;  MDRin <= 0;     MDRout <= 1; IRin <= 1;                     end
      NEG_T3: begin MDRout <= 0; IRin <= 0;                   R7out <= 1; opcode <= 5'b10001; Zin <= 1;   end
      NEG_T4: begin R7out <= 0; Zin <= 0;                     Zlo_out <= 1;  R6in <= 1;   end

      /*NOT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
      NOT_T0: begin Zlo_out <= 0; R6in <= 0;                 PCout <= 1; IncPC <= 1; MARin <= 1; Zin <= 1; end
      NOT_T1: begin
        PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
        Zlo_out <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
        Mdatain <= 32'h28918000; 
      end
      NOT_T2: begin Zlo_out <= 0; PCin <= 0;  MDRin <= 0;     MDRout <= 1; IRin <= 1;                     end
      NOT_T3: begin MDRout <= 0; IRin <= 0;                   R7out <= 1; opcode <= 5'b10010; Zin <= 1;   end
      NOT_T4: begin R7out <= 0; Zin <= 0;                     Zlo_out <= 1;  R6in <= 1;   end
    
    endcase
  end

endmodule
