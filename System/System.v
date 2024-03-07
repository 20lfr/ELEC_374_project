module System #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 9)(
    input wire Clock, clear,


    /*in and outport information*/
    input wire inport_data,
    output wire outport_data

);


    /*Control unit signals*/

        /*Bus Encoder Signals*/
        wire    HIout, LOout, Zhi_out, Zlo_out, PCout, MDRout, Inport_out, Cout;
        
        /*Register Enable Signals*/
        wire    MARin, Zin, PCin, MDRin, IRin, Yin, HIin, LOin;
        wire    outport_in, inport_in;

        /*ALU control*/
        wire    [4:0] opcode; 
        wire    IncPC;

        /*Decoding Control*/
        wire    Gra, Grb, Grc, Rin, Rout, BAout; /*Datapath Inputs*/
        wire    con_ff_bit; /*Datapath Outputs*/

        /*Memory Control*/
        wire    Mem_Read, Mem_Write, Mem_enable512x32;

    

    /*Memory unit signals*/
        wire    [DATA_WIDTH-1:0] Mem_to_datapath, Mem_data_to_chip;
        wire    [ADDR_WIDTH-1:0] MAR_address; 
        


    Control control(

    );



    DataPath datapath(
        /*Sequence*/
        .clock(Clock), .clear(clear),

        /*Register enable signals*/
        .IRin(IRin), .PCin(PCin), .RYin(Yin), .RZin(Zin), .MARin(MARin), 
        .MDRin(MDRin), .HIin(HIin), .LOin(LOin), .Outport_in(outport_in), .Inport_in(inport_in),

        
        /*Bus encoder signals*/
        .HIout(HIout), .LOout(LOout), .Zhi_out(Zhi_out), .Zlo_out(Zlo_out), 
        .PCout(PCout), .MDRout(MDRout), .Inport_out(Inport_out), .Cout(Cout),
        

        /*Memory Signals*/
        .MAR_to_chip(MAR_address), .Mem_read(Mem_Read), .Mem_datain(Mem_to_datapath), .Mem_dataout(Mem_data_to_chip),

        /*I/O Interfacing*/
        .Inport_data_in(inport_data), .Outport_data_out(outport_data),

        /*Control Signals*/
        .opcode(opcode), .IncPC(IncPC)
        .Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), .BAout(BAout),
        .con_ff_bit(con_ff_bit)
        
    );


    RAM512x32 memory512x32(
        .clk(Clock),
        .read(Mem_Read), .write(Mem_Write), .enable(Mem_enable512x32),
        .address(MAR_address),
        .data_in(Mem_data_to_chip), .data_out(Mem_to_datapath)

    );






endmodule