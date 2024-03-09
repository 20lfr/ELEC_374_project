module System #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 9)(
    input wire Clock, clear,


    /*in and outport information*/
        input wire inport_data,
        output wire outport_data,


    /*Phase 2 testing signals*/
        wire [DATA_WIDTH-1:0] register[7:0],
        wire [DATA_WIDTH-1:0] registerMDR, BusMuxOut, resgisterPC, resgisterHI, resgisterLO, resgisterIR, 

        /*Control unit signals*/

            /*Bus Encoder Signals*/
            input wire    HIout, LOout, Zhi_out, Zlo_out, PCout, MDRout, Inport_out, Cout,
            
            /*Register Enable Signals*/
            input wire    MARin, Zin, PCin, MDRin, IRin, Yin, HIin, LOin,
            input wire    outport_in, inport_data_ready,

            /*ALU control*/
            input wire    [4:0] opcode,
            input wire    IncPC,

            /*Decoding Control*/
            input wire    Gra, Grb, Grc, Rin, Rout, BAout, /*Datapath Inputs*/
            output wire   con_ff_bit, /*Datapath Outputs*/

            /*Memory Control*/
            input wire    Mem_Read, Mem_Write, Mem_enable512x32, 

            input wire      Mem_init_overide, 
            input wire [DATA_WIDTH-1:0] Mem_overide_data,  
            input wire [ADDR_WIDTH-1:0] Mem_overide_addr,   
        
        /*Memory Test Signals*/
            output wire [DATA_WIDTH-1:0] Mem_to_datapath, Mem_data_to_chip, 
            output wire [ADDR_WIDTH-1:0] MAR_address,

            input wire mem_overide, 
            input wire [(ADDR_WIDTH-1):0] overide_address,
            input wire [(DATA_WIDTH-1):0] overide_data_in
);


    


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
        .MDRin(MDRin), .HIin(HIin), .LOin(LOin), .Outport_in(outport_in), .strobe(inport_data_ready),

        
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
        .con_ff_bit(con_ff_bit),



        /*TEST OUTPTUS*/
        .reg1(register[1]), .reg2(register[2]), .reg3(register[3]), .reg4(register[4]), .reg5(register[5]), 
        .reg6(register[6]), .reg7(register[7]), .regMDR(registerMDR), .BusMuxOut_out(BusMuxOut), 
        .PC_VALUE(resgisterPC), .HI_VALUE(resgisterHI), .LO_VALUE(resgisterLO), .IR_VALUE(resgisterIR)
        
    );


    RAM512x32 memory512x32(
        .clk(Clock),
        .read(Mem_Read), .write(Mem_Write), .enable(Mem_enable512x32),
        .address(MAR_address),
        .data_in(Mem_data_to_chip), .data_out(Mem_to_datapath), 

        .overide(mem_overide), 
        .overide_address(overide_address), 
        .overide_data_in(overide_data_in)
    );






endmodule