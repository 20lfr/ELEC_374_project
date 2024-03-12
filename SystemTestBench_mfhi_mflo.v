`timescale 1ns/10ps

module SystemTestBench_mfhi_mflo;

    // Test bench parameters
    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 9;

    /*Inputs*/
    reg Clock, clear;
    reg inport_data;
    
    
    reg HIout, LOout, Zhi_out, Zlo_out, PCout, MDRout, Inport_out, Cout;
    reg MARin, Zin, PCin, MDRin, IRin, Yin, HIin, LOin;
    reg outport_in, inport_data_ready;
    reg [4:0] opcode;
    reg IncPC;
    reg Gra, Grb, Grc, Rin, Rout, BAout;
    reg Mem_Read, Mem_Write, Mem_enable512x32;

    reg mem_overide; reg [ADDR_WIDTH-1:0] overide_address; reg [DATA_WIDTH-1:0] overide_data_in;


    /*Outputs*/
    wire outport_data;

    wire [DATA_WIDTH-1:0] Mem_to_datapath, Mem_data_to_chip, MAR_address;
    wire con_ff_bit;
    wire [DATA_WIDTH-1:0] register[7:0];
    wire [DATA_WIDTH-1:0] registerMDR, BusMuxOut, registerPC, registerHI, registerLO, registerIR;


    // Instantiate the System module
    System #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) UUT (
        .Clock(Clock), .clear(clear),
        .inport_data(inport_data), .outport_data(outport_data),


        .HIout(HIout), .LOout(LOout), .Zhi_out(Zhi_out), .Zlo_out(Zlo_out), .PCout(PCout), .MDRout(MDRout), .Inport_out(Inport_out), .Cout(Cout),
        .MARin(MARin), .Zin(Zin), .PCin(PCin), .MDRin(MDRin), .IRin(IRin), .Yin(Yin), .HIin(HIin), .LOin(LOin),
        .outport_in(outport_in), .inport_data_ready(inport_data_ready),
        .opcode(opcode), .IncPC(IncPC),
        .Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), .BAout(BAout),
        .con_ff_bit(con_ff_bit),
        .Mem_Read(Mem_Read), .Mem_Write(Mem_Write), .Mem_enable512x32(Mem_enable512x32),
        .Mem_to_datapath(Mem_to_datapath), .Mem_data_to_chip(Mem_data_to_chip), .MAR_address(MAR_address), 


        .register(register), .registerMDR(registerMDR), .BusMuxOut(BusMuxOut), .registerPC(registerPC), .registerHI(registerHI), .registerLO(registerLO), .registerIR(registerIR),
        .mem_overide(mem_overide), .overide_address(overide_address), .overide_data_in(overide_data_in)
    );


    parameter Default = 6'd0, Mem_load_instruction1 = 6'd1, Mem_load_instruction2 = 6'd2, Mem_load_instruction3 = 6'd3,
              Mem_load_data1 = 6'd4, Mem_load_data2 = 6'd5, 
              
            
              MFHI_T0 = 6'd10, MFHI_T1 = 6'd11, MFHI_T2 = 6'd12, MFHI_T3 = 6'd13,
              MFLO_T0 = 6'd20, MFLO_T1 = 6'd21, MFLO_T2 = 6'd22, MFLO_T3 = 6'd23;

    reg [5:0] Present_state = Default;



    /*Clock generation*/
      initial begin
          Clock = 0;
          forever #10 Clock = ~Clock; // Toggle clock every 10 ns
      end
      always @(posedge Clock) // finite state machine; if clock rising-edge
        begin
            case (Present_state)
                Default : Present_state = Mem_load_instruction1;
                Mem_load_instruction1 : Present_state = Mem_load_instruction2;
                Mem_load_instruction2 : Present_state = Mem_load_instruction3;
                Mem_load_instruction3 : Present_state = Mem_load_data1;
                Mem_load_data1 : Present_state = Mem_load_data2;
                Mem_load_data2 : Present_state = MFHI_T0;
                


                MFHI_T0: Present_state = MFHI_T1;
                MFHI_T1: Present_state = MFHI_T2;
                MFHI_T2: Present_state = MFHI_T3;
                MFHI_T3: Present_state = MFHI_T4;

                MFLO_T0: Present_state = MFLO_T1;
                MFLO_T1: Present_state = MFLO_T2;
                MFLO_T2: Present_state = MFLO_T3;            

          endcase
      end


  always @(Present_state) begin
    case (Present_state) // assert the required signals in each clock cycle
      Default: begin
        
        clear <= 0;
        HIout <=0;<=0; LOout<=0; Zhi_out<=0; Zlo_out<=0; PCout<=0; MDRout<=0; Inport_out<=0; Cout<=0;
        MARin<=0; Zin <=0; PCin <=0; MDRin <=0; IRin <=0; Yin <=0; HIin <=0; LOin <=0; 
        opcode <= 5'd0; IncPC <= 0;
        Gra <=0; Grb <=0; Grc <=0; Rin <=0; Rout <=0; BAout <=0;
        Mem_Read <=0; Mem_Write <=0;  Mem_enable512x32 <= 0;


        /*INIT inport and outport*/
        inport_data <=32'd0; outport_in <=0; inport_data_ready <=0;    

        mem_overide <=0; overide_address <= 9'd0; overide_data_in <= 32'd0;
      end


      /*INIT STATES: These states are for initializing the desired instruction. #TODO: add states accordingly*/
      

      Mem_load_instruction1 : begin
        overide_address <= 9'd0; //Load Desired Memory Address
        overide_data_in <= 32'b00011_0001_0010_0000000000000000001;//load addi r1, r2, 1
        mem_overide <= 1;
      end
      Mem_load_instruction2 : begin
        overide_address <= 9'd1; //Load Desired Memory Address
        overide_data_in <= 32'b01011_0001_0010_0000000000000000011; //load andi r1, r2, 3
        mem_overide <= 1; 

      end 
      Mem_load_instruction3 : begin
        overide_address <= 9'd1; //Load Desired Memory Address
        overide_data_in <= 32'bb01010_0001_0010_0000000000000001001; //load ori r1, r2, 9
        mem_overide <= 1; 

        #20 mem_overide <= 0;    
      end 
      Mem_load_data1 begin :
        overide_address <= 9'd500; //Load Desired Memory Address
        overide_data_in <= 32'h00000014;
        mem_overide <= 1; 
      end

      Mem_load_data2 begin :
        overide_address <= 9'd501; //Load Desired Memory Address
        overide_data_in <= 32'h00000014;
        mem_overide <= 1; 
      end

      



      /*MFHI~~~~~~~~~~~~~~~~~~~~~~~~{mfhi r6}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
        MFHI_T0: begin Zlo_out <= 0; Rin <= 0;  Gra <= 0;               PCout <= 1; IncPC <= 1; MARin <= 1; Zin <= 1;/*Get instruction form mem*/ end
        MFHI_T1: begin
                      PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
                      Zlo_out <= 1; PCin <= 1;//Capture incremented PC
                      
                      Read <= 1; MDRin <= 1; Mem_read <= 1; Mem_enable512x32 <= 1;//recieving instruction from memory
        end
        MFHI_T2: begin 
                      Zlo_out <= 0; PCin <= 0;  MDRin <= 0; Mem_read <=0;  Mem_enable512x32<=0;          
                      
                      MDRout <= 1; IRin <= 1;                     
        end
        MFHI_T3: begin 
                      MDRout <= 0; IRin <= 0;                   
                      
                      Gra <= 1;  HIout <= 1; Rin <= 1; 
                      #20 Gra <= 0; HIout <= 0; Rin <= 0;                      
        end
        
      /*MFLO~~~~~~~~~~~~~~~~~~~~~~~~{mflo r7}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
        MFLO_T0: begin Zlo_out <= 0; Rin <= 0;  Gra <= 0;               PCout <= 1; IncPC <= 1; MARin <= 1; Zin <= 1;/*Get instruction form mem*/ end
        MFLO_T1: begin
                      PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
                      Zlo_out <= 1; PCin <= 1;//Capture incremented PC
                      
                      Read <= 1; MDRin <= 1; Mem_read <= 1; Mem_enable512x32 <= 1;//recieving instruction from memory
        end
        MFLO_T2: begin 
                      Zlo_out <= 0; PCin <= 0;  MDRin <= 0; Mem_read <=0;  Mem_enable512x32<=0;          
                      
                      MDRout <= 1; IRin <= 1;                     
        end
        MFLO_T3: begin 
                      MDRout <= 0; IRin <= 0;                   
                      
                      Gra <= 1; LOout <= 1; Rin <= 1;    
                      #20  Gra <= 0; LOout <= 0; Rin <= 0;                   
        end

     
      endcase
    end


endmodule
