module Control #(DATA_WIDTH = 32)(

    input wire clk, reset, stop, Interupts,
    output wire run, clear, /*May not need interupts*/
    
    input wire [DATA_WIDTH-1:0] IR,

    /*Bus Encoder Signals*/
    output wire    HIout, LOout, Zhi_out, Zlo_out, PCout, MDRout, Inport_out, Cout,
    
    /*Register Enable Signals*/
    output wire    MARin, Zin, PCin, MDRin, IRin, Yin, HIin, LOin, CONin, 
    output wire    outport_in, inport_data_ready,

    /*ALU control*/
    output wire    [4:0] ALU_opcode,
    output wire    IncPC,

    /*Decoding Control*/
    output wire    Gra, Grb, Grc, Rin, Rout, BAout, /*Datapath Inputs*/
    input wire     con_ff_bit, /*Datapath Outputs*/

    /*Memory Control*/
    output wire     Mem_Read, Mem_Write, Mem_enable512x32 
);


    parameter   reset_state = 4'b0000, S0 = 4'b0001, S1 = 4'b0010, 
                S2 = 4'b0011, S3 = 4'b0100, S4 = 4'b0101, S5 = 4'b0110, 
                S6 = 4'b0111, S7 = 4'b1000;
    reg [3:0]   present_state = reset_state; 
    reg         T0, T1, T2, T3, T4, T5, T6, T7;
    reg         ADD_s, AND_s, OR_s, ADDI_s; /*INCLUDE ALL STATES LATER*/


    always @(posedge clk, posedge reset) begin
        if(reset) present_state <= reset_state;
        else begin
            T0 <= 0; T1 <= 0; T2 <= 0; T3 <= 0; T4 <= 0; T5 <= 0; T6 <= 0; T7 <= 0;
            case(present_state)
                reset_state : begin
                    present_state <= S0;
                    T0 <= 1; T1 <= 0; T2 <= 0; T3 <= 0; T4 <= 0; T5 <= 0; T6 <= 0; T7 <= 0;
                end 
                S0 : begin 
                    present_state <= S1;
                    T0 <= 0; T1 <= 1; T2 <= 0; T3 <= 0; T4 <= 0; T5 <= 0; T6 <= 0; T7 <= 0;
                end 
                S1 : begin 
                    present_state <= S2;
                    T0 <= 0; T1 <= 0; T2 <= 1; T3 <= 0; T4 <= 0; T5 <= 0; T6 <= 0; T7 <= 0;
                end 
                S2 : begin 
                    if(HALT_s) present_state <= S2;
                    present_state <= S3;
                    T0 <= 0; T1 <= 0; T2 <= 0; T3 <= 1; T4 <= 0; T5 <= 0; T6 <= 0; T7 <= 0;
                end 
                S3 : begin 
                    present_state <= S4;
                    T0 <= 0; T1 <= 0; T2 <= 0; T3 <= 0; T4 <= 1; T5 <= 0; T6 <= 0; T7 <= 0;
                end 
                S4 : begin 
                    present_state <= S5;
                    T0 <= 0; T1 <= 0; T2 <= 0; T3 <= 0; T4 <= 0; T5 <= 1; T6 <= 0; T7 <= 0;
                end 
                S5 : begin 
                    present_state <= S6;
                    T0 <= 0; T1 <= 0; T2 <= 0; T3 <= 0; T4 <= 0; T5 <= 0; T6 <= 1; T7 <= 0;
                end
                S6 : begin 
                    present_state <= reset_state;
                    T0 <= 0; T1 <= 0; T2 <= 0; T3 <= 0; T4 <= 0; T5 <= 0; T6 <= 0; T7 <= 1;
                end




            endcase 

        end 

    end 

    always @(IR)begin
        ADDI_s <= 0; ADD_s <= 0;//set everything to zero NEED TO INCLUDE ALL INSTRUCTIONS
        case(IR[DATA_WIDTH-1:27])
            5'b00011 : ADD_s <= 1;
            5'b01010 : AND_s <= 1; //this are opcodes for each instruction (INCLUDE THE REST HERE)
        endcase 

    end 

    always @(clk, T0, T1, T2, T3, T4, T5, T6, T7)begin
        opcode <= ADD_s && T4 ? 5'b00011 : 5'b00000; //do this for every single opcode
        Rout <= T3 | T4(ADD_s | OR_s | SHRA_s ...) | T6(Store_s)


    end 





endmodule