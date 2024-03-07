module System #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 9)(
    input wire Clock, clear,


    /*in and outport information*/
    input wire inport_data,
    output wire outport_data

);


    /*Control unit signals*/

        /*bus encoder signals*/
        wire    HIout, LOout, Zhi_out, Zlo_out, PCout, MDRout, Inport_out, 
                Cout, R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, 
                R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out; 
        
        wire    IncPC, Mem_Read, Mem_Write, Mem_enable512x32;

        /*register enable signals*/
        wire    R0in, R1in, R2in, R3in, 
                R4in, R5in, R6in, R7in, 
                R8in, R9in, R10in, R11in, 
                R12in, R13in, R14in, R15in;
        wire    MARin, Zin, PCin, MDRin, IRin, Yin, HIin, LOin;
        wire    outport_in, inport_in;

        /*ALU control*/
        wire [4:0] opcode; 
    

    /*Memory unit signals*/
        wire [DATA_WIDTH-1:0] Mem_to_datapath, Mem_data_to_chip;
        wire [ADDR_WIDTH-1:0] MAR_address; 


    Control control(

    );



    DataPath datapath(
        /*Sequence*/
        .clock(Clock), .clear(clear),

        /*Register enable signals*/
        .R0in(R0in), .R4in(R4in), .R5in(R5in), .R6in(R6in), 
        .R7in(R7in), .R8in(R8in), .R9in(R9in), .R10in(R10in), 
        .R11in(R11in), .R12in(R12in), .R13in(R13in), .R14in(R14in), 
        .R15in(R15in),
        .R1in(R1in), .R2in(R2in), .R3in(R3in), 
        .IRin(IRin), .PCin(PCin), .RYin(Yin), .RZin(Zin), .MARin(MARin), 
        .MDRin(MDRin), .HIin(HIin), .LOin(LOin), .Outport_in(outport_in), .Inport_in(inport_in),

        
        /*Bus encoder signals*/
        .HIout(HIout), .LOout(LOout), .Zhi_out(Zhi_out), .Zlo_out(Zlo_out), 
        .PCout(PCout), .MDRout(MDRout), .Inport_out(Inport_out), .Cout(Cout),
        .R0out(R0out),.R1out(R1out),.R2out(R2out),.R3out(R3out),.R4out(R4out),
        .R5out(R5out),.R6out(R6out),.R7out(R7out),.R8out(R8out),.R9out(R9out),
        .R10out(R10out),.R11out(R11out),.R12out(R12out),.R13out(R13out),
        .R14out(R14out),.R15out(R15out),


        /*Memory usage*/
        .MAR_to_chip(MAR_address), .Mem_read(Mem_Read), .Mem_datain(Mem_to_datapath), .Mem_dataout(Mem_data_to_chip),

        /*In and Out porting*/
        .Inport_data_in(inport_data), .Outport_data_out(outport_data),

        /*ALU control signal*/
        .opcode(opcode), .IncPC(IncPC)
        
    );


    RAM512x32 memory512x32(
        .clk(Clock),
        .read(Mem_Read), .write(Mem_Write), .enable(Mem_enable512x32),
        .address(MAR_address),
        .data_in(Mem_data_to_chip), .data_out(Mem_to_datapath)

    );






endmodule