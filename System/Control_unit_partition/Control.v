module Control #(DATA_WIDTH = 32)(

    input wire clk, reset, stop, 
    output wire run, clear, Interupts, /*May not need interupts*/
    
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
                S2 = 4'b0010, S3 = 4'b0010, S4 = 4'b0010, S5 = 4'b0010, 
                S6 = 4'b0010, S7 = 4'b0010;
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



            endcase 

        end 

    end 





endmodule