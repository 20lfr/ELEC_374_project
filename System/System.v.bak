module System #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 9, CLOCK_CYCLE_DIVISOR = 5)(
        input wire Clock, reset, stop, 


    /*in and outport information*/
        input wire [DATA_WIDTH-1:0] inport_data,
        //output wire[DATA_WIDTH-1:0] outport_data, 

        output wire [6:0] seg_display_upper, seg_display_lower, 
        output wire run
       
);

    /*Control unit signals*/
            wire    clear;
        /*Bus Encoder Signals*/
            wire    HIout, LOout, Zhi_out, Zlo_out, PCout, MDRout, Inport_out, Cout;
        
        /*Register Enable Signals*/
            wire    MARin, Zin, PCin, MDRin, IRin, Yin, HIin, LOin, CONin;
            wire    outport_in;

        /*ALU control*/
            wire    [4:0] ALU_opcode;
            wire    IncPC;

        /*Decoding Control*/
            wire    Gra, Grb, Grc, Rin, Rout, BAout, jump_n_link; /*Datapath Inputs*/
            wire    con_ff_bit; /*Datapath Outputs*/
            wire    [DATA_WIDTH-1:0] IR;

        /*Memory Control*/
            wire    Mem_Read, Mem_Write, Mem_enable512x32;
        /*I/O*/
            wire [DATA_WIDTH-1:0] outport_data;

             
        
        /*Memory Test Signals*/
            wire memory_done;

            wire mem_overide; 
            wire [(ADDR_WIDTH-1):0] overide_address;
            wire [(DATA_WIDTH-1):0] overide_data_in;

    /*Memory unit signals*/
        wire    [DATA_WIDTH-1:0] Mem_to_datapath, Mem_data_to_chip;
        wire    [ADDR_WIDTH-1:0] MAR_address; 

    /*Clock Divisor*/
        wire clk_divided;

        


    Control control(
        /*Outputs*/
        .run(run), .clear(clear),

        .HIout(HIout), .LOout(LOout), .Zhi_out(Zhi_out), .Zlo_out(Zlo_out), .PCout(PCout), .MDRout(MDRout), .Inport_out(Inport_out), .Cout(Cout),
        .MARin(MARin), .Zin(Zin), .PCin(PCin), .MDRin(MDRin), .IRin(IRin), .Yin(Yin), .HIin(HIin), .LOin(LOin), .CONin(CONin), 
        .outport_in(outport_in),

        .ALU_opcode(ALU_opcode),
        .IncPC(IncPC),
        .Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), .BAout(BAout), .jump_n_link(jump_n_link),
        .Mem_Read(Mem_Read), .Mem_Write(Mem_Write), .Mem_enable512x32(Mem_enable512x32),

        /*Inputs*/
        .IR(IR),
        .con_ff_bit(con_ff_bit), 
        .clk(Clock), .reset(reset), .stop(stop)  
    );
    DataPath datapath(
        /*Sequence*/
        .clock(Clock), .clear(clear),

        /*Register enable signals*/
        .IRin(IRin), .PCin(PCin), .RYin(Yin), .RZin(Zin), .MARin(MARin), 
        .MDRin(MDRin), .HIin(HIin), .LOin(LOin), .Outport_in(outport_in), 

        
        /*Bus encoder signals*/
        .HIout(HIout), .LOout(LOout), .Zhi_out(Zhi_out), .Zlo_out(Zlo_out), 
        .PCout(PCout), .MDRout(MDRout), .Inport_out(Inport_out), .Cout(Cout),
        

        /*Memory Signals*/
        .MAR_to_chip(MAR_address), .Mem_read(Mem_Read), .Mem_datain(Mem_to_datapath), .Mem_dataout(Mem_data_to_chip),

        /*I/O Interfacing*/
        .External_In({{24{1'b0}}, inport_data[7:0]}), .External_Out(outport_data),

        /*Control Signals*/
        .opcode(ALU_opcode), .IncPC(IncPC),
        .Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), .BAout(BAout), .jump_n_link(jump_n_link),
        .con_ff_bit(con_ff_bit), .CONin(CONin), .IR_data(IR)
    );
    RAM512x32 memory512x32(
        /*Outputs*/
        .data_out(Mem_to_datapath), 
        .done(memory_done),


        /*Inputs*/
        .read(Mem_Read), .write(Mem_Write), .enable(Mem_enable512x32),
        .address(MAR_address),
        .data_in(Mem_data_to_chip)
    );

    /*Seven Segement Display Decoders*/
        Seven_Seg_Display_Out display_upper(.data(outport_data[7:4]), .clk(Clock), .outport(seg_display_upper));
        Seven_Seg_Display_Out display_lower(.data(outport_data[3:0]), .clk(Clock), .outport(seg_display_lower));
    /*Clock Divider*/
        Clock_div #(.DIVISOR(CLOCK_CYCLE_DIVISOR)) clock_divider_instance(.clk(Clock), .clock(clk_divided), .reset(reset));







endmodule