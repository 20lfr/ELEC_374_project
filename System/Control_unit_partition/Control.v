module Control #(parameter DATA_WIDTH = 32)(


    /*Trigger reset at start of program (IN TESTBENCH)*/
    input wire clk, reset, stop, Interupts,
    output reg run, clear, /*May not need interupts*/
    
    input wire [DATA_WIDTH-1:0] IR,

    /*Bus Encoder Signals*/
    output reg    HIout, LOout, Zhi_out, Zlo_out, PCout, MDRout, Inport_out, Cout,
    
    /*Register Enable Signals*/
    output reg     MARin, Zin, PCin, MDRin, IRin, Yin, HIin, LOin, CONin, 
    output reg     outport_in,

    /*ALU control*/
    output reg    [4:0] ALU_opcode,
    output reg    IncPC,

    /*Decoding Control*/
    output reg    Gra, Grb, Grc, Rin, Rout, BAout, /*Datapath Inputs*/
    input wire     con_ff_bit, /*Datapath Outputs*/

    /*Memory Control*/
    output reg     Mem_Read, Mem_Write, Mem_enable512x32 
);


    localparam   reset_state = 4'b0000, S0 = 4'b0001, S1 = 4'b0010, 
                S2 = 4'b0011, S3 = 4'b0100, S4 = 4'b0101, S5 = 4'b0110, 
                S6 = 4'b0111, S7 = 4'b1000;
    
    /*ALU opcodes*/
    localparam  AND = 5'b01011, OR = 5'b01010, NEG = 5'b10001, NOT_MOD = 5'b10010, ROL = 5'b01001, 
                ROR = 5'b01000, SHL = 5'b00111, SHRA = 5'b00110, SHR = 5'b00101,
                ADD = 5'b00011, SUB = 5'b00100, UNS_ADD = 5'b11111, MUL = 5'b01111, DIV = 5'b10000;


    reg [3:0]   present_state = reset_state; 
    reg         T0, T1, T2, T3, T4, T5, T6, T7;
    reg         LOAD_s, LOADI_s, STORE_s, 
                ADD_s, SUB_s, SHR_s, SHRA_s, SHL_s, ROR_s, ROL_s, AND_s, OR_s, 
                ADDI_s, ANDI_s, ORI_s, 
                MUL_s, DIV_s, 
                NEG_s, NOT_s, 
                BRANCH_s, JUMP_s, JUMP_LINK_s, 
                IN_s, OUT_s, MFHI_s, MFLO_s, 
                NOP_s, HALT_s;

    /*Special Instruction Signals*/
    reg         LOAD_DIR_s, LOADI_DIR_s, STORE_DIR_s, ALU_s;


    always @(posedge clk, posedge reset, posedge stop) begin
        if(reset)   begin 
            present_state <= reset_state; 
            clear <= 1;
            run <= 1;
        end
        else if(stop) begin
            //present_state <= present_state;
            clear <= 0; run <= 0;
        end 
        else begin
            clear <= 0;
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
                    if(HALT_s) begin 
                        present_state <= S2; run <= 0;
                    end 
                    else if(JUMP_s | MFHI_s | MFLO_s | IN_s | OUT_s | NOP_s) present_state <= reset_state;
                    else present_state <= S3;
                    T0 <= 0; T1 <= 0; T2 <= 0; T3 <= 1; T4 <= 0; T5 <= 0; T6 <= 0; T7 <= 0;
                end 
                S3 : begin 
                    if(NEG_s | NOT_s | JUMP_LINK_s) present_state <= reset_state;
                    else present_state <= S4;
                    T0 <= 0; T1 <= 0; T2 <= 0; T3 <= 0; T4 <= 1; T5 <= 0; T6 <= 0; T7 <= 0;
                end 
                S4 : begin 
                    if(LOADI_s | ALU_s | ADDI_s | ANDI_s | ORI_s) present_state <= reset_state;
                    else present_state <= S5;
                    T0 <= 0; T1 <= 0; T2 <= 0; T3 <= 0; T4 <= 0; T5 <= 1; T6 <= 0; T7 <= 0;
                end 
                S5 : begin 
                    if(MUL_s | DIV_s | BRANCH_s) present_state <= reset_state;
                    else present_state <= S6;
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
        LOAD_s <= 0; LOADI_s<=0; STORE_s<=0;

        LOAD_DIR_s <= 0; LOADI_DIR_s <= 0; STORE_DIR_s <= 0;

        ADD_s<=0; SUB_s<=0; SHR_s<=0; SHRA_s<=0; SHL_s<=0; ROR_s<=0; ROL_s<=0; AND_s<=0; OR_s<=0; 
        MUL_s<=0; DIV_s<=0; 
        NEG_s<=0; NOT_s<=0; 
        ADDI_s<=0; ANDI_s<=0; ORI_s<=0; 
        
        BRANCH_s<=0; JUMP_s<=0; JUMP_LINK_s<=0; 
        IN_s<=0; OUT_s<=0; MFHI_s<=0; MFLO_s<=0; 
        NOP_s<=0; HALT_s<=0;
        case(IR[DATA_WIDTH-1:27])

            5'b00000 :  begin 
                            LOAD_s <= 1; 
                            if(IR[22:19] == 4'd0) LOAD_DIR_s <= 1;
                        end 
            5'b00001 :  begin 
                            LOADI_s <= 1; 
                            if(IR[22:19] == 4'd0) LOADI_DIR_s <= 1;
                        end
            5'b00010 :  begin 
                            STORE_s <= 1; 
                            if(IR[22:19] == 4'd0) STORE_DIR_s <= 1;
                        end

            5'b00011 : ADD_s <= 1;
            5'b00100 : SUB_s <= 1;
            5'b00101 : SHR_s <= 1;
            5'b00110 : SHRA_s <= 1;
            5'b00111 : SHL_s <= 1;
            5'b01000 : ROR_s <= 1;
            5'b01001 : ROL_s <= 1;
            5'b01010 : AND_s <= 1;
            5'b01011 : OR_s <= 1;

            5'b01100 : ADDI_s <= 1;
            5'b01101 : ANDI_s <= 1;
            5'b01110 : ORI_s <= 1;

            5'b01111 : MUL_s <= 1;
            5'b10000 : DIV_s <= 1;
            5'b10001 : NEG_s <= 1;
            5'b10010 : NOT_s <= 1;


            5'b10011 : BRANCH_s <= 1;
            5'b10100 : JUMP_s <= 1;
            5'b10101 : JUMP_LINK_s <= 1;

            5'b10110 : IN_s <= 1;
            5'b10111 : OUT_s <= 1;
            5'b11000 : MFHI_s <= 1;
            5'b11001 : MFLO_s <= 1;

            
            5'b11010 : NOP_s <= 1;
            5'b11011 : HALT_s <= 1;
            default  : NOP_s <= 1;
        endcase 
    end 

    always @(*)begin //used to be (clk, T0, T1, T2, T3, T4, T5, T6, T7), changed to * for combinational logic
        ALU_opcode <=   ((T4 & (ADD_s | ADDI_s | LOAD_s | LOADI_s | STORE_s)) | (T5 & BRANCH_s)) ? ADD :
                        ((T4 & (AND_s | ANDI_s)) ? AND :
                        (T4 & (OR_s | ORI_s)) ? OR :
                        (T4 & SHR_s) ? SHR :
                        (T4 & SHRA_s) ? SHRA :
                        (T4 & SHL_s) ? SHL :
                        (T4 & ROR_s) ? ROR :
                        (T4 & ROL_s) ? ROL : 5'b00000);
                        
                        


        IncPC <= (T0);
        //run <=  ~(HALT_s | stop); /*THIS MAY CUASE ISSUES, consider later*/
        ALU_s <= (ADD_s | SUB_s | SHR_s | SHRA_s | SHL_s | ROR_s | ROL_s | AND_s | OR_s);

        

        /*BUS MUX SIGNALS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
            HIout <= (T3 & MFHI_s);

            LOout <= (T3 & MFLO_s);

            Zhi_out <= (T5 & (MUL_s | DIV_s));

            Zlo_out <=  (T1) | 
                        (T4 & (NEG_s | NOT_s)) | 
                        (T5 & (LOAD_s | LOADI_s | STORE_s | ALU_s | ADDI_s | ANDI_s | ORI_s)) |
                        (T6 & (MUL_s | DIV_s | BRANCH_s));

            PCout <=    (T0) | 
                        (T4 & BRANCH_s) |
                        (T3 & JUMP_LINK_s);

            MDRout <=   (T2) |
                        (T7 & (LOAD_s | STORE_s));

            Inport_out<=(T3 & IN_s);

            Cout <=     (T4 & (LOAD_s | LOADI_s | STORE_s | ADDI_s | ANDI_s | ORI_s)) |
                        (T5 & BRANCH_s);

        /*ENABLE SIGNALS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/     
            MARin <=    (T0) |
                        (T5 & (LOAD_s | STORE_s));

            MDRin <=    (T1) |
                        (T6 & (LOAD_s | STORE_s));

            PCin <=     (T1) |
                        (T3 & JUMP_s) |
                        (T4 & JUMP_LINK_s) | 
                        (T6 & (BRANCH_s & con_ff_bit));

            IRin <=     (T2);

            Zin <=      (T0) |
                        (T4 & (LOAD_s | LOADI_s | STORE_s | ALU_s | ADDI_s | ANDI_s | ORI_s | MUL_s | DIV_s)) |
                        (T3 & (NEG_s | NOT_s)) | 
                        (T5 & BRANCH_s);

            Yin <=      (T3 & (LOAD_s | LOADI_s | STORE_s | ALU_s | ADDI_s | ANDI_s | ORI_s | MUL_s | DIV_s)) |
                        (T4 & BRANCH_s);

            HIin <=     (T5 & (MUL_s | DIV_s));
            LOin <=     (T6 & (MUL_s | DIV_s));
            CONin <=    (T3 & BRANCH_s);


            outport_in<=(T3 & OUT_s);
        /*IR DECODING SIGNALS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/              
            Gra <=      (T3 & (BRANCH_s | JUMP_s | MFHI_s | MFLO_s)) | 
                        (T4 & (MUL_s | DIV_s | JUMP_LINK_s)) |
                        (T5 & (LOADI_s | ALU_s | ADDI_s | ANDI_s | ORI_s)) |
                        (T6 & (STORE_s)) |
                        (T7 & (LOAD_s));

            Grb <=      (T3 & (LOAD_s | LOADI_s | STORE_s | ALU_s | ADDI_s | ANDI_s | ORI_s | MUL_s | DIV_s | NEG_s | NOT_s | JUMP_LINK_s));
            Grc <=      (T4 & (ALU_s));

            Rin <=      (T3 & (JUMP_LINK_s | MFHI_s | MFLO_s | IN_s)) |
                        (T4 & (NEG_s | NOT_s)) |
                        (T5 & (LOADI_s | ALU_s | ADDI_s | ANDI_s | ORI_s)) | 
                        (T7 & (LOAD_s));
                        
            Rout <=     (T3 & (LOAD_s | LOADI_s| STORE_s | ALU_s | ADDI_s | ANDI_s | ORI_s | MUL_s | DIV_s | NEG_s | NOT_s | JUMP_s | OUT_s )) |
                        (T4 & (ALU_s | JUMP_LINK_s)) |
                        (T6 & (STORE_s));

            BAout <=    (T3 & (LOAD_DIR_s | LOADI_DIR_s | STORE_DIR_s)) | 
                        (T6 & (STORE_DIR_s));

        /*MEMORY SIGNALS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/    
            Mem_Read <=         (T1) |
                                (T6 & (LOAD_s));
            Mem_Write <=        (T7 & STORE_s);
            Mem_enable512x32 <= (T1) |
                                (T6 & (LOAD_s)) |
                                (T7 & (STORE_s));
        

    end 





endmodule