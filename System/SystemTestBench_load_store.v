`timescale 1ns/10ps

module SystemTestBench_load_store;

    // Test bench parameters
    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 9;

    /*Inputs*/
    reg Clock, clear;
    reg inport_data;
    
    
    reg HIout, LOout, Zhi_out, Zlo_out, PCout, MDRout, Inport_out, Cout;
    reg MARin, Zin, PCin, MDRin, IRin, Yin, HIin, LOin, CONin;
    reg outport_in, inport_data_ready;
    reg [4:0] opcode;
    reg IncPC;
    reg Gra, Grb, Grc, Rin, Rout, BAout;
    reg Mem_read, Mem_Write, Mem_enable512x32;

    reg mem_overide; reg [ADDR_WIDTH-1:0] overide_address; reg [DATA_WIDTH-1:0] overide_data_in;


    /*Outputs*/
    wire outport_data;

    wire [DATA_WIDTH-1:0] Mem_to_datapath, Mem_data_to_chip;
    wire [ADDR_WIDTH-1:0] MAR_address;
    wire con_ff_bit, memory_done;
    


    // Instantiate the System module
    System #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) UUT (
        .Clock(Clock), .clear(clear),
        .inport_data(inport_data), .outport_data(outport_data),


        .HIout(HIout), .LOout(LOout), .Zhi_out(Zhi_out), .Zlo_out(Zlo_out), .PCout(PCout), .MDRout(MDRout), .Inport_out(Inport_out), .Cout(Cout),
        .MARin(MARin), .Zin(Zin), .PCin(PCin), .MDRin(MDRin), .IRin(IRin), .Yin(Yin), .HIin(HIin), .LOin(LOin), .CONin(CONin),
        .outport_in(outport_in), .inport_data_ready(inport_data_ready),
        .opcode(opcode), .IncPC(IncPC),
        .Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), .BAout(BAout),
        .con_ff_bit(con_ff_bit),
        .Mem_Read(Mem_read), .Mem_Write(Mem_Write), .Mem_enable512x32(Mem_enable512x32),
        .Mem_to_datapath_out(Mem_to_datapath), .Mem_data_to_chip_out(Mem_data_to_chip), .MAR_address_out(MAR_address), .memory_done(memory_done),


        .mem_overide(mem_overide), .overide_address(overide_address), .overide_data_in(overide_data_in)
    );


    parameter Default = 6'd0, Mem_load_instruction1 = 6'd1, Mem_load_instruction2 = 6'd2, Mem_load_instruction3 = 6'd3,
              Mem_load_data1 = 6'd4, Mem_load_data2 = 6'd5, 
              
            
              LD_T0 = 6'd10, LD_T1 = 6'd11, LD_T2 = 6'd12, LD_T3 = 6'd13, LD_T4 = 6'd14, LD_T5 = 6'd15, LD_T6 = 6'd15, LD_T7 = 6'd15,  
              LD1_T0 = 6'd20, LD1_T1 = 6'd21, LD1_T2 = 6'd22, LD1_T3 = 6'd23, LD1_T4 = 6'd24, LD1_T5 = 6'd25, LD1_T6 = 6'd25, LD1_T7 = 6'd25,
              LDI_T0 = 6'd30, LDI_T1 = 6'd31, LDI_T2 = 6'd32, LDI_T3 = 6'd33, LDI_T4 = 6'd34, LDI_T5 = 6'd35,
              LDI1_T0 = 6'd40, LDI1_T1 = 6'd41, LDI1_T2 = 6'd42, LDI1_T3 = 6'd43, LDI1_T4 = 6'd44, LDI1_T5 = 6'd45, 

              ST_T0 = 6'd50, ST_T1 = 6'd51, ST_T2 = 6'd52, ST_T3 = 6'd53, ST_T4 = 6'd54, ST_T5 = 6'd55, ST_T6 = 6'd55, ST_T7 = 6'd55,
              ST1_T0 = 6'd56, ST1_T1 = 6'd57, ST1_T2 = 6'd58, ST1_T3 = 6'd59, ST1_T4 = 6'd60, ST1_T5 = 6'd61;

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
                Mem_load_data2 : Present_state = LD_T0;
                


                LD_T0: Present_state = LD_T1;
                LD_T1: Present_state = LD_T2;
                LD_T2: Present_state = LD_T3;
                LD_T3: Present_state = LD_T4;
                LD_T4: Present_state = LD_T5;
                LD_T5: Present_state = LD1_T0; // transition to next operation


                LD_T0: Present_state = LD_T1;
                LD_T1: Present_state = LD_T2;
                LD_T2: Present_state = LD_T3;
                LD_T3: Present_state = LD_T4;
                LD_T4: Present_state = LD_T5;
                LD_T5: Present_state = LD1_T0;


                


            

          endcase
      end


  always @(Present_state) begin
    case (Present_state) // assert the required signals in each clock cycle
      Default: begin
        
        clear <= 0;
        HIout <=0; LOout<=0; Zhi_out<=0; Zlo_out<=0; PCout<=0; MDRout<=0; Inport_out<=0; Cout<=0;
        MARin<=0; Zin <=0; PCin <=0; MDRin <=0; IRin <=0; Yin <=0; HIin <=0; LOin <=0; 
        opcode <= 5'd0; IncPC <= 0;
        Gra <=0; Grb <=0; Grc <=0; Rin <=0; Rout <=0; BAout <=0;
        Mem_read <=0; Mem_Write <=0;  Mem_enable512x32 <= 0;


        /*INIT inport and outport*/
        inport_data <=32'd0; outport_in <=0; inport_data_ready <=0;    

        mem_overide <=0; overide_address <= 9'd0; overide_data_in <= 32'd0;
      end


      /*INIT STATES: These states are for initializing the desired instruction. #TODO: add states accordingly*/
      

      Mem_load_instruction1 : begin
        overide_address <= 9'd0; //Load Desired Memory Address
        overide_data_in <= 32'b00011_0001_0010_0000000000000000001;//load LD r1, r2, 1
        mem_overide <= 1;
        
        Mem_enable512x32 <= 1;
        #10 Mem_enable512x32 <= 0;


      end
      Mem_load_instruction2 : begin
        overide_address <= 9'd1; //Load Desired Memory Address
        overide_data_in <= 32'b01011_0001_0010_0000000000000000011; //load andi r1, r2, 3
        
        Mem_enable512x32 <= 1;
        #10 Mem_enable512x32 <= 0;
      end 
      Mem_load_instruction3 : begin
        overide_address <= 9'd2; //Load Desired Memory Address
        overide_data_in <= 32'b01010_0001_0010_0000000000000001001; //load ori r1, r2, 9    

        Mem_enable512x32 <= 1;
        #10 Mem_enable512x32 <= 0; 
      end 
      Mem_load_data1 : begin 
        overide_address <= 9'd500; //Load Desired Memory Address
        overide_data_in <= 32'h00000014;

        Mem_enable512x32 <= 1;
        #10 Mem_enable512x32 <= 0;
      end

      Mem_load_data2 : begin
        overide_address <= 9'd501; //Load Desired Memory Address
        overide_data_in <= 32'h00000014;

        Mem_enable512x32 <= 1;
        #10 Mem_enable512x32 <= 0; mem_overide <= 0;
      end

      



      /*ld~~~~~~~~~~~~~~~~~~~~~~~~{ld  ra, C(r0)}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
        LD_T0: begin Zlo_out <= 0; Rin <= 0;  Gra <= 0;               PCout <= 1; IncPC <= 1; MARin <= 1; Zin <= 1;/*Get instruction form mem*/ end
        LD_T1: begin
                      PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
                      Zlo_out <= 1; PCin <= 1;//Capture incremented PC
                      
                      MDRin <= 1; Mem_read <= 1; Mem_enable512x32 <= 1;//recieving instruction from memory
        end
        LD_T2: begin 
                      Zlo_out <= 0; PCin <= 0;  MDRin <= 0; Mem_read <=0;  Mem_enable512x32<=0;          
                      
                      MDRout <= 1; IRin <= 1;                     
        end
        LD_T3: begin 
                      MDRout <= 0; IRin <= 0;                   
                      
                      Grb <= 1; Rout <= 1; Yin <= 1;                       
        end
        LD_T4: begin 
                      Rout <= 0; Yin <= 0; Grb <= 0;                    
                      
                      Cout <= 1; Zin <= 1; opcode <= 5'b00011;//ADD
        end
        LD_T5: begin 
                      Cout <= 0; Zin <= 0;                      
        
                      Zlo_out <= 1; Rin <= 1; Gra <= 1;
        end

    
      




    
      endcase
    end


endmodule
