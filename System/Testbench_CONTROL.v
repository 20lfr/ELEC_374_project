`timescale 1ns / 1ps

module Testbench_CONTROL;

    // Parameters of the Control module
    parameter DATA_WIDTH = 32;
    
    // Inputs
    reg clk;
    reg reset;
    reg stop;
    reg Interupts;
    reg [DATA_WIDTH-1:0] IR;
    reg con_ff_bit; // Simulate condition flag bit for branching
    
    // Outputs
    wire run;
    wire clear;
    wire [4:0] ALU_opcode;
    wire IncPC;
    wire HIout, LOout, Zhi_out, Zlo_out, PCout, MDRout, Inport_out, Cout;
    wire MARin, Zin, PCin, MDRin, IRin, Yin, HIin, LOin, CONin, outport_in;
    wire Mem_Read, Mem_Write, Mem_enable512x32;
    wire Gra, Grb, Grc, Rin, Rout, BAout;

        
    parameter   reset_state = 7'd0,
                INS1_T0 = 7'd10, INS1_T1 = 7'd11, INS1_T2 = 7'd12, INS1_T3 = 7'd13, INS1_T4 = 7'd14, INS1_T5 = 7'd15,
                INS2_T0 = 7'd20, INS2_T1 = 7'd21, INS2_T2 = 7'd22, INS2_T3 = 7'd23, INS2_T4 = 7'd24, INS2_T5 = 7'd25, 
                INS3_T0 = 7'd30, INS3_T1 = 7'd31, INS3_T2 = 7'd32, INS3_T3 = 7'd33, INS3_T4 = 7'd34, INS3_T5 = 7'd35, 
                INS4_T0 = 7'd40, INS4_T1 = 7'd41, INS4_T2 = 7'd42, INS4_T3 = 7'd43, INS4_T4 = 7'd44, INS4_T5 = 7'd45,
                INS5_T0 = 7'd50, INS5_T1 = 7'd51, INS5_T2 = 7'd52, INS5_T3 = 7'd53, INS5_T4 = 7'd54, INS5_T5 = 7'd55,
                INS6_T0 = 7'd60, INS6_T1 = 7'd61, INS6_T2 = 7'd62, INS6_T3 = 7'd63, INS6_T4 = 7'd64, INS6_T5 = 7'd65;
    reg [6:0] Present_state = reset_state;



    // Instantiate the Unit Under Test (UUT)
    Control #(.DATA_WIDTH(DATA_WIDTH)) uut (
        .clk(clk), 
        .reset(reset), 
        .stop(stop), 
        .Interupts(Interupts), 
        .IR(IR),
        .con_ff_bit(con_ff_bit),
        .run(run), 
        .clear(clear),
        .ALU_opcode(ALU_opcode),
        .IncPC(IncPC),
        .HIout(HIout), .LOout(LOout), .Zhi_out(Zhi_out), .Zlo_out(Zlo_out), 
        .PCout(PCout), .MDRout(MDRout), .Inport_out(Inport_out), .Cout(Cout),
        .MARin(MARin), .Zin(Zin), .PCin(PCin), .MDRin(MDRin), .IRin(IRin), 
        .Yin(Yin), .HIin(HIin), .LOin(LOin), .CONin(CONin), 
        .outport_in(outport_in),
        .Mem_Read(Mem_Read), .Mem_Write(Mem_Write), .Mem_enable512x32(Mem_enable512x32),
        .Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), .BAout(BAout)
    );

    initial begin
          clk = 0;
          forever #10 clk = ~clk; // Toggle clock every 10 ns
    end
    always @(posedge clk) // finite state machine; if clock rising-edge
        begin
            case (Present_state)
                reset_state : Present_state = INS1_T0;//INIT STATE
                
                //INS1
                INS1_T0: Present_state = INS1_T1;
                INS1_T1: Present_state = INS1_T2;
                INS1_T2: Present_state = INS1_T3;
                INS1_T3: Present_state = INS1_T4;
                INS1_T4: Present_state = INS1_T5;
                INS1_T5: Present_state = INS2_T0;

                //INS2
                INS2_T0: Present_state = INS2_T1;
                INS2_T1: Present_state = INS2_T2;
                INS2_T2: Present_state = INS2_T3;
                INS2_T3: Present_state = INS2_T4;
                INS2_T4: Present_state = INS2_T5;
                INS2_T5: Present_state = INS3_T0;

                //INS3
                INS3_T0: Present_state = INS3_T1;
                INS3_T1: Present_state = INS3_T2;
                INS3_T2: Present_state = INS3_T3;
                INS3_T3: Present_state = INS3_T4;
                INS3_T4: Present_state = INS3_T5;
                INS3_T5: Present_state = INS4_T0;
                
                //INS4
                INS4_T0: Present_state = INS4_T1;
                INS4_T1: Present_state = INS4_T2;
                INS4_T2: Present_state = INS4_T3;
                INS4_T3: Present_state = INS4_T4;
                INS4_T4: Present_state = INS4_T5;
                INS4_T5: Present_state = INS5_T0;

                //INS5
                INS5_T0: Present_state = INS5_T1;
                INS5_T1: Present_state = INS5_T2;
                INS5_T2: Present_state = INS5_T3;
                INS5_T3: Present_state = INS5_T4;
                INS5_T4: Present_state = INS5_T5;
                INS5_T5: Present_state = INS6_T0;


                //INS6
                INS6_T0: Present_state = INS6_T1;
                INS6_T1: Present_state = INS6_T2;
                INS6_T2: Present_state = INS6_T3;
                INS6_T3: Present_state = INS6_T4;
                INS6_T4: Present_state = INS6_T5;
            
                
          endcase
      end
    always @(Present_state) begin
        case(Present_state)
            reset_state : begin 
                reset <= 1; con_ff_bit <= 0; stop <= 0; Interupts <= 0;

                #20 reset <= 0;
            end
            /*INS1*/
                INS1_T0 : begin end
                INS1_T1 : begin end
                INS1_T2 : begin 
                    IR <= 32'b01000_0011_0010_0000000000000000011; //ror
                end
                INS1_T3 : begin end
                INS1_T4 : begin end
                INS1_T5 : begin end
            /*INS2*/
                INS2_T0 : begin end
                INS2_T1 : begin end
                INS2_T2 : begin 
                    IR <= 32'b01001_0011_0010_0000000000000000011; //rol
                end
                INS2_T3 : begin end
                INS2_T4 : begin end
                INS2_T5 : begin end
            /*INS3*/
                INS3_T0 : begin end
                INS3_T1 : begin end
                INS3_T2 : begin 
                    IR <= 32'b01010_0011_0010_0000000000000000011; //and
                end
                INS3_T3 : begin end
                INS3_T4 : begin end
                INS3_T5 : begin end
            /*INS4*/
                INS4_T0 : begin end
                INS4_T1 : begin end
                INS4_T2 : begin 
                    IR <= 32'b01011_0011_0010_0000000000000000011; //or
                end
                INS4_T3 : begin end
                INS4_T4 : begin end
                INS4_T5 : begin end
            /*INS5*/
                INS5_T0 : begin end
                INS5_T1 : begin end
                INS5_T2 : begin 
                    IR <= 32'b00111_0011_0010_0000000000000000011; //shl
                end
                INS5_T3 : begin end
                INS5_T4 : begin end
                INS5_T5 : begin end
            /*INS6*/
                INS6_T0 : begin end
                INS6_T1 : begin end
                INS6_T2 : begin 
                    IR <= 32'b01000_0011_0010_0000000000000000011; //ror
                end
                INS6_T3 : begin end
                INS6_T4 : begin end
                INS6_T5 : begin 
                     #20 reset <= 1;
                    
                end
            /*ending phase*/
        

        endcase

    
    end
    

endmodule
