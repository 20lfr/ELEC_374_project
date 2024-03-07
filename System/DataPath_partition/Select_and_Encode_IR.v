module Select_and_Encode_IR #(parameter DATA_WIDTH = 32)(
    input wire[DATA_WIDTH-1:0] IR_data,
    input wire Gra, Grb, Grc, Rin, Rout, BAout, 
    output wire R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
    output wire R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in
);  
    wire [3:0] Ra, Rb, Rc, Ra_and, Rb_and, Rc_and, Selected_register;
    wire [15:0] register_decoded;
    assign Ra_and = Ra & Gra; 
    assign Rb_and = Rb & Grb; 
    assign Rc_and = Rc & Grc; 

    assign Selected_register = Ra_and | Rb_and | Rc_and;


    decoder4to16 decoder(Selected_register, register_decoded);

    assign R0out = ((BAout|Rout)&register_decoded[0]);
    assign R1out = ((BAout|Rout)&register_decoded[1]);
    assign R2out = ((BAout|Rout)&register_decoded[2]);
    assign R3out = ((BAout|Rout)&register_decoded[3]);
    assign R4out = ((BAout|Rout)&register_decoded[4]);
    assign R5out = ((BAout|Rout)&register_decoded[5]);
    assign R6out = ((BAout|Rout)&register_decoded[6]);
    assign R7out = ((BAout|Rout)&register_decoded[7]);
    assign R8out = ((BAout|Rout)&register_decoded[8]);
    assign R9out = ((BAout|Rout)&register_decoded[9]);
    assign R10out = ((BAout|Rout)&register_decoded[10]);
    assign R11out = ((BAout|Rout)&register_decoded[11]);
    assign R12out = ((BAout|Rout)&register_decoded[12]);
    assign R13out = ((BAout|Rout)&register_decoded[13]);
    assign R14out = ((BAout|Rout)&register_decoded[14]);
    assign R15out = ((BAout|Rout)&register_decoded[15]);
    
    assign R0in = (Rin&register_decoded[0]);
    assign R1in = (Rin&register_decoded[1]);
    assign R2in = (Rin&register_decoded[2]);
    assign R3in = (Rin&register_decoded[3]);
    assign R4in = (Rin&register_decoded[4]);
    assign R5in = (Rin&register_decoded[5]);
    assign R6in = (Rin&register_decoded[6]);
    assign R7in = (Rin&register_decoded[7]);
    assign R8in = (Rin&register_decoded[8]);
    assign R9in = (Rin&register_decoded[9]);
    assign R10in = (Rin&register_decoded[10]);
    assign R11in = (Rin&register_decoded[11]);
    assign R12in = (Rin&register_decoded[12]);
    assign R13in = (Rin&register_decoded[13]);
    assign R14in = (Rin&register_decoded[14]);
    assign R15in = (Rin&register_decoded[15]);






endmodule