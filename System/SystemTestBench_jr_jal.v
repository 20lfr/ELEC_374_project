`timescale 1ns/10ps

module SystemTestBench_ALU;

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
    reg Mem_read, Mem_Write, Mem_enable512x32;

    reg mem_overide; reg [ADDR_WIDTH-1:0] overide_address; reg [DATA_WIDTH-1:0] overide_data_in;


    /*Outputs*/
    wire outport_data;

    wire [DATA_WIDTH-1:0] Mem_to_datapath, Mem_data_to_chip;
    wire [ADDR_WIDTH-1:0] MAR_address;
    wire con_ff_bit;
    


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
        .Mem_to_datapath_out(Mem_to_datapath), .Mem_data_to_chip_out(Mem_data_to_chip), .MAR_address_out(MAR_address), 


        .mem_overide(mem_overide), .overide_address(overide_address), .overide_data_in(overide_data_in)
    );


    parameter Default = 6'd0, Mem_load_instruction1 = 6'd1, Mem_load_instruction2 = 6'd2, Mem_load_instruction3 = 6'd3,
              Mem_load_data1 = 6'd4, Mem_load_data2 = 6'd5, 

              JR_T0 = 6'd10, JR_T1 = 6'd11, JR_T2 = 6'd12, JR_T3 = 6'd13,
              JAL_T0 = 6'd14, JAL_T1 = 6'd15, JAL_T2 = 6'd16, JAL_T3 = 6'd17, JAL_T4 = 6'd18;
              
            

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
                Mem_load_instruction3 : Present_state = load_register;

                load_register : Present_state = load_register1;
                load_register1 : Present_state = load_register2;
                load_register2 : Present_state = load_register3;
                load_register3 : Present_state = load_register4;
                load_register4 : Present_state = load_register5;
                load_register4 : Present_state = JR_T0;

                JR_T0: Present_state = JR_T1;
                JR_T1: Present_state = JR_T2;
                JR_T2: Present_state = JR_T3;
                JR_T3: Present_state = JAL_T0;

                JAL_T0: Present_state = JAL_T1;
                JAL_T1: Present_state = JAL_T2;
                JAL_T2: Present_state = JAL_T3;
                JAL_T3: Present_state = JAL_T4

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
        overide_data_in <= 32'b00001_0110_0000_000_0000_0000_0000_0011; //ldi r6, 3
        mem_overide <= 1;
        
        Mem_enable512x32 <= 1;
        #10 Mem_enable512x32 <= 0;
      end

      Mem_load_instruction2 : begin
        overide_address <= 9'd1; //Load Desired Memory Address
        overide_data_in <= 32'b 10100_0110_0000_0000000000000000000;    //jr r6 instruction
        mem_overide <= 1;
        
        Mem_enable512x32 <= 1;
        #10 Mem_enable512x32 <= 0;
      end

      Mem_load_instruction3 : begin
        overide_address <= 9'd5; //Load Desired Memory Address
        overide_data_in <= 32'b10101_0110_1111_0000000000000000000;     //jal r6, need R[15] for linking 
        
        Mem_enable512x32 <= 1;
        #10 Mem_enable512x32 <= 0;
      end      

/*---------------------------------------ldi------------------------------------------------*/
      load_register: begin
        Zlo_out <= 0; Rin <= 0;  Gra <= 0;               PCout <= 1; IncPC <= 1; MARin <= 1; Zin <= 1;
      end
      load_register1: begin
                        PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
                        Zlo_out <= 1; PCin <= 1;//Capture incremented PC
                      
                        MDRin <= 1; Mem_read <= 1; Mem_enable512x32 <= 1;//recieving instruction from memory
      end
      load_register2: begin
                        Zlo_out <= 0; PCin <= 0;  MDRin <= 0; Mem_read <=0;  Mem_enable512x32<=0;          
                      
                        MDRout <= 1; IRin <= 1;
      end
      load_register3: begin
                        MDRout <= 0; IRin <= 0;

                        Grb <= 1; BAout <= 1; Yin <= 1;
      end
      load_register4: begin
                        Grb <= 0; BAout <= 0; Yin <= 0;

                        Cout <= 1; Zin <= 1; opcode <= 5'b00011;//ADD
      end
      load_register5: begin
                        Cout <= 0; Zin <= 0;

                        Zlo_out <= 1; Gra <= 1; Rin <= 1;
      end


      /*------------------------------------------jr-----------------------------------*/
        JR_T0: begin Zlo_out <= 0; Rin <= 0;  Gra <= 0;               PCout <= 1; IncPC <= 1; MARin <= 1; Zin <= 1;/*Get instruction form mem*/ end
        JR_T1: begin
                      PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
                      Zlo_out <= 1; PCin <= 1;//Capture incremented PC
                      
                      MDRin <= 1; Mem_read <= 1; Mem_enable512x32 <= 1;//recieving instruction from memory
        end
        JR_T2: begin 
                      Zlo_out <= 0; PCin <= 0;  MDRin <= 0; Mem_read <=0;  Mem_enable512x32<=0;          
                      
                      MDRout <= 1; IRin <= 1;                     
        end
        JR_T3: begin 
                      MDRout <= 0; IRin <= 0;                   
                      
                      Gra <= 1; Rout <= 1; PCin <= 1;                       
        end


      /*------------------------------------------jal-----------------------------------*/
        JAL_T0: begin Gra <= 0;  Rout <= 0;  PCin <= 0;              PCout <= 1; IncPC <= 1; MARin <= 1; Zin <= 1;/*Get instruction form mem*/ end
        JAL_T1: begin
                      PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
                      Zlo_out <= 1; PCin <= 1;//Capture incremented PC
                      
                      MDRin <= 1; Mem_read <= 1; Mem_enable512x32 <= 1;//recieving instruction from memory
        end
        JAL_T2: begin 
                      Zlo_out <= 0; PCin <= 0;  MDRin <= 0; Mem_read <=0;  Mem_enable512x32<=0;          
                      
                      MDRout <= 1; IRin <= 1;                     
        end
        JAL_T3: begin 
                      MDRout <= 0; IRin <= 0;                   
                        
                      Grb <= 1; Rin <= 1; PCin <= 1;                                     
        end
        JAL_T4: begin
                      Grb <= 0; Rin <= 0; PCin <= 0; 

                      Gra <= 1; Rout <= 1; PCin <= 1;  
        end
      endcase
    end
endmodule