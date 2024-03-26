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

        
    parameter   reset_state = 6'd0,
                ADDi_T0 = 6'd10, ADDi_T1 = 6'd11, ADDi_T2 = 6'd12, ADDi_T3 = 6'd13, ADDi_T4 = 6'd14, ADDi_T5 = 6'd15,
                LOAD_T0 = 6'd20, LOAD_T1 = 6'd21, LOAD_T2 = 6'd22, LOAD_T3 = 6'd23, LOAD_T4 = 6'd24, LOAD_T5 = 6'd25, LOAD_T6 = 6'd26, LOAD_T7 = 6'd27;
    reg [5:0] Present_state = reset_state;



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
                reset_state : Present_state = ADDi_T0;//INIT STATE

                ADDi_T0: Present_state = ADDi_T1;
                ADDi_T1: Present_state = ADDi_T2;
                ADDi_T2: Present_state = ADDi_T3;
                ADDi_T3: Present_state = ADDi_T4;
                ADDi_T4: Present_state = ADDi_T5;
                ADDi_T5: Present_state = LOAD_T0; // Example transition to next operation

                LOAD_T0: Present_state = LOAD_T1;
                LOAD_T1: Present_state = LOAD_T2;
                LOAD_T2: Present_state = LOAD_T3;
                LOAD_T3: Present_state = LOAD_T4;
                LOAD_T4: Present_state = LOAD_T5;
                LOAD_T5: Present_state = LOAD_T6;
                LOAD_T6: Present_state = LOAD_T7;
                
          endcase
      end
    always @(Present_state) begin
        case(Present_state)
            reset_state : begin 
                reset <= 1; con_ff_bit <= 0; stop <= 0; Interupts <= 0;

                #20 reset <= 0;
            end
            /*ADDi*/
                ADDi_T0 : begin end
                ADDi_T1 : begin end
                ADDi_T2 : begin 
                    IR <= 32'b01100_0011_0100_0000000000000000011; //ANDi instruction from mem == andi r3, r4, 3
                end
                ADDi_T3 : begin end
                ADDi_T4 : begin end
                ADDi_T5 : begin end
    

            /*LOAD*/
                LOAD_T0 : begin end
                LOAD_T1 : begin end
                LOAD_T2 : begin 
                    IR <= 32'b00000_0010_0000_00000000000_10010101;//load  r2, 0x95(r0);  
                end
                LOAD_T3 : begin end
                LOAD_T4 : begin end
                LOAD_T5 : begin end
                LOAD_T6 : begin end
                LOAD_T7 : begin 
                    #20 reset <= 1;
                end
        

        endcase

    
    end
    

endmodule
