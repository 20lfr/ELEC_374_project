// datapath_tb.v file: <This is the filename>
`timescale 1ns/10ps

module datapath_tb;

  reg PCout, Zlowout, MDRout, R2out, R3out; // encoder signals
  wire [23:0] Bus_Encoder_signals;

  assign Bus_Encoder_signals[3:0] = {R3out, R2out, 0, 0};
  assign Bus_Encoder_signals[15:4] = 0;
                                      /*Cout, Inport, MDR, PC, Zlo, Zhi, LO, HI*/
  assign Bus_Encoder_signals[23:16] = {0, 0, MDRout, PCout, Zlowout, 0, 0, 0};


  reg MARin, Zin, PCin, MDRin, IRin, Yin;
  reg IncPC, Read, R1in, R2in, R3in;
  reg [4:0] opcode; /*the opcode for an AND operation is opcode = 00001*/
  reg Clock;
  reg [31:0] Mdatain;

  /*NOTE: we are performing two operations.
    1. load data from memory into general purpose registers: R1, R2, R3
    2. do an AND operation: and r1, r2, r3*/


  parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011,
            Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111,
            T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100;
  reg [3:0] Present_state = Default;




  DataPath DUT(
                .clock(Clock), .clear(0),
                .R1in(R1in), .R2in(R2in), .R3in(R3in), .MARin(MARin), .RZin(Zin), .PCin(PCin), .MDRin(MDRin), .IRin(IRin), .RYin(Yin),
                .Bus_Encoder_signals(Bus_Encoder_signals), .Mem_read(Read), .opcode(opcode), 
                .MDR_Mem_lines(Mdatain)
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
      Reg_load3b : Present_state = T0;
      T0 : Present_state = T1;
      T1 : Present_state = T2;
      T2 : Present_state = T3;
      T3 : Present_state = T4;
      T4 : Present_state = T5;
    endcase
  end

  always @(Present_state) // do the required job in each state
  begin
    case (Present_state) // assert the required signals in each clock cycle
      Default: begin
        PCout <= 0; Zlowout <= 0; MDRout <= 0; // initialize the signals
        R2out <= 0; R3out <= 0; MARin <= 0; Zin <= 0;
        PCin <= 0; MDRin <= 0; IRin <= 0; Yin <= 0;
        IncPC <= 0; Read <= 0; opcode <= 0;
        R1in <= 0; R2in <= 0; R3in <= 0; Mdatain <= 32'h00000000;
      end
      Reg_load1a: begin
        Mdatain <= 32'h00000012;
        Read = 0; MDRin = 0; // the first zero is there for completeness
        #10 Read <= 1; MDRin <= 1;
        #15 Read <= 0; MDRin <= 0;
      end
      Reg_load1b: begin
        #10 MDRout <= 1; R2in <= 1;
        #15 MDRout <= 0; R2in <= 0; // initialize R2 with the value $12
      end
      Reg_load2a: begin
        Mdatain <= 32'h00000014;
        #10 Read <= 1; MDRin <= 1;
        #15 Read <= 0; MDRin <= 0;
      end
      Reg_load2b: begin
        #10 MDRout <= 1; R3in <= 1;
        #15 MDRout <= 0; R3in <= 0; // initialize R3 with the value $14
      end
      Reg_load3a: begin
        Mdatain <= 32'h00000018;
        #10 Read <= 1; MDRin <= 1;
        #15 Read <= 0; MDRin <= 0;
      end
      Reg_load3b: begin
        #10 MDRout <= 1; R1in <= 1;
        #15 MDRout <= 0; R1in <= 0; // initialize R1 with the value $18
      end


      T0: begin // see if you need to de-assert these signals
        PCout <= 1; MARin <= 1; IncPC <= 1; Zin <= 1;
      end
      T1: begin
        Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
        Mdatain <= 32'h28918000; // opcode for “and R1, R2, R3”
      end
      T2: begin
        MDRout <= 1; IRin <= 1; //mov data from MDR to IR
      end
      T3: begin
        R2out <= 1; Yin <= 1;
      end
      T4: begin
        R3out <= 1; opcode <= 4'b00001; Zin <= 1;
      end
      T5: begin
        Zlowout <= 1; R1in <= 1;
      end
    endcase
  end

endmodule
