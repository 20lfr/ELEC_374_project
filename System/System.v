module System #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 9)(
        input wire Clock, clear, reset, stop, 


    /*in and outport information*/
        input wire [DATA_WIDTH-1:0] inport_data,
        output wire[DATA_WIDTH-1:0] outport_data
       
);

    /*Control unit signals*/
        /*Bus Encoder Signals*/
            wire    HIout, LOout, Zhi_out, Zlo_out, PCout, MDRout, Inport_out, Cout;
        
        /*Register Enable Signals*/
            wire    MARin, Zin, PCin, MDRin, IRin, Yin, HIin, LOin, CONin;
            wire    outport_in, inport_data_ready;

        /*ALU control*/
            wire    [4:0] ALU_opcode;
            wire    IncPC;

        /*Decoding Control*/
            wire    Gra, Grb, Grc, Rin, Rout, BAout; /*Datapath Inputs*/
            wire    con_ff_bit; /*Datapath Outputs*/

        /*Memory Control*/
            wire    Mem_Read, Mem_Write, Mem_enable512x32;

             
        
        /*Memory Test Signals*/
            wire [DATA_WIDTH-1:0] Mem_to_datapath_out, Mem_data_to_chip_out;
            wire [ADDR_WIDTH-1:0] MAR_address_out;
            wire memory_done;

            wire mem_overide; 
            wire [(ADDR_WIDTH-1):0] overide_address;
            wire [(DATA_WIDTH-1):0] overide_data_in;

    /*Memory unit signals*/
        wire    [DATA_WIDTH-1:0] Mem_to_datapath, Mem_data_to_chip;
        wire    [ADDR_WIDTH-1:0] MAR_address; 


        


    Control control(
        /*Outputs*/
        .run(run), .clear(clear),

        .IR(IR),
        .HIout(HIout), .LOout(LOout), .Zhi_out(Zhi_out), .Zlo_out(Zlo_out), .PCout(PCout), .MDRout(MDRout), .Inport_out(Inport_out), .Cout(Cout),
        .MARin(MARin), .Zin(Zin), .PCin(PCin), .MDRin(MDRin), .IRin(IRin), .Yin(Yin), .HIin(HIin), .LOin(LOin), .CONin(CONin), 
        .outport_in(outport_in),

        .ALU_opcode(ALU_opcode),
        .IncPC(IncPC),
        .Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), .BAout(BAout), 
        .Mem_Read(Mem_Read), .Mem_Write(Mem_Write), .Mem_enable512x32(Mem_enable512x32),

        /*Inputs*/
        .IR(IR),
        .con_ff_bit(con_ff_bit), 
        .clk(Clock), .reset(reset), .stop(stop), .Interupts(Interupts),   
    );
    DataPath datapath(
        /*Sequence*/
        .clock(Clock), .clear(clear),

        /*Register enable signals*/
        .IRin(IRin), .PCin(PCin), .RYin(Yin), .RZin(Zin), .MARin(MARin), 
        .MDRin(MDRin), .HIin(HIin), .LOin(LOin), .Outport_in(outport_in), .strobe(inport_data_ready),

        
        /*Bus encoder signals*/
        .HIout(HIout), .LOout(LOout), .Zhi_out(Zhi_out), .Zlo_out(Zlo_out), 
        .PCout(PCout), .MDRout(MDRout), .Inport_out(Inport_out), .Cout(Cout),
        

        /*Memory Signals*/
        .MAR_to_chip(MAR_address), .Mem_read(Mem_Read), .Mem_datain(Mem_to_datapath), .Mem_dataout(Mem_data_to_chip),

        /*I/O Interfacing*/
        .External_In(inport_data), .External_Out(outport_data),

        /*Control Signals*/
        .opcode(ALU_opcode), .IncPC(IncPC),
        .Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), .BAout(BAout),
        .con_ff_bit(con_ff_bit), .CONin(CONin)   
    );
    RAM512x32 memory512x32(
        .read(Mem_Read), .write(Mem_Write), .enable(Mem_enable512x32),
        .address(MAR_address),
        .data_in(Mem_data_to_chip), .data_out(Mem_to_datapath), .done(memory_done),

        .overide(mem_overide), 
        .overide_address(overide_address), 
        .overide_data_in(overide_data_in)
    );






endmodule