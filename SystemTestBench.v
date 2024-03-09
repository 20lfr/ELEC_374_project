`timescale 1ns/10ps

module SystemTestBench;

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
        .register(register), .registerMDR(registerMDR), .BusMuxOut(BusMuxOut), .registerPC(registerPC), .registerHI(registerHI), .registerLO(registerLO), .registerIR(registerIR),
        .HIout(HIout), .LOout(LOout), .Zhi_out(Zhi_out), .Zlo_out(Zlo_out), .PCout(PCout), .MDRout(MDRout), .Inport_out(Inport_out), .Cout(Cout),
        .MARin(MARin), .Zin(Zin), .PCin(PCin), .MDRin(MDRin), .IRin(IRin), .Yin(Yin), .HIin(HIin), .LOin(LOin),
        .outport_in(outport_in), .inport_data_ready(inport_data_ready),
        .opcode(opcode), .IncPC(IncPC),
        .Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .Rout(Rout), .BAout(BAout),
        .con_ff_bit(con_ff_bit),
        .Mem_Read(Mem_Read), .Mem_Write(Mem_Write), .Mem_enable512x32(Mem_enable512x32),
        .Mem_to_datapath(Mem_to_datapath), .Mem_data_to_chip(Mem_data_to_chip), .MAR_address(MAR_address)
    );


    parameter Default = 6'd0, Reg_load1a = 6'd1, Reg_load1b = 6'd2, Reg_load2a = 6'd3,
              Reg_load2b = 6'd4, Reg_load3a = 6'd5, Reg_load3b = 6'd6, 

              Mem_load_a = 6'd7, Mem_load_b = 6'd8, 
              
            
              ADD_T0 = 6'd19, ADD_T1 = 6'd20, ADD_T2 = 6'd21, ADD_T3 = 6'd22, ADD_T4 = 6'd23, ADD_T5 = 6'd24,
              SUB_T0 = 6'd25, SUB_T1 = 6'd26, SUB_T2 = 6'd27, SUB_T3 = 6'd28, SUB_T4 = 6'd29, SUB_T5 = 6'd30;
    reg [5:0] Present_state = Default;



    // Clock generation
    initial begin
        Clock = 0;
        forever #10 Clock = ~Clock; // Toggle clock every 10 ns
    end
    always @(posedge Clock) // finite state machine; if clock rising-edge
      begin
          case (Present_state)
              Default : Present_state = Reg_load1a;
              Reg_load1a : Present_state = Reg_load1b;
              Reg_load1b : Present_state = Reg_load2a;
              Reg_load2a : Present_state = Reg_load2b;
              Reg_load2b : Present_state = Reg_load3a;
              Reg_load3a : Present_state = Reg_load3b;
              Reg_load3b : Present_state = ADD_T0;


              ADD_T0: Present_state = ADD_T1;
              ADD_T1: Present_state = ADD_T2;
              ADD_T2: Present_state = ADD_T3;
              ADD_T3: Present_state = ADD_T4;
              ADD_T4: Present_state = ADD_T5;
              ADD_T5: Present_state = SUB_T0; // Example transition to next operation

              SUB_T0: Present_state = SUB_T1;
              SUB_T1: Present_state = SUB_T2;
              SUB_T2: Present_state = SUB_T3;
              SUB_T3: Present_state = SUB_T4;
              SUB_T4: Present_state = SUB_T5;


          

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




        

        
        
        Mdatain <= 32'h00000000; 



      end


      /*INIT STATES: These states are for initializing the desired instruction. #TODO: add states accordingly*/
      Reg_load1a: begin
        Mdatain <= 32'h00000010;
        Read = 0; MDRin = 0; // the first zero is there for completeness
        #10 Read <= 1; MDRin <= 1;  
        #10 Read <= 0; MDRin <= 0;  
      end
      Reg_load1b: begin
        Mdatain <= 32'h00000011;
        #10 MDRout <= 1; R2in <= 1; PCin <= 1;
        #10 MDRout <= 0; R2in <= 0; PCin <= 0;// initialize R2 with the value $12
      end

      Mem_load_a : begin
        Mdatain <= 32'h00000000; //CHANGE for instriction address
        MARin = 1;

      end

      Mem_load_b : begin



      end 



      Reg_load2a: begin
        Mdatain <= 32'h00000014;
        #10 Read <= 1; MDRin <= 1;
        #10 Read <= 0; MDRin <= 0;
      end
      Reg_load2b: begin
        #10 MDRout <= 1; R3in <= 1;
        #10 MDRout <= 0; R3in <= 0; // initialize R3 with the value $14
      end
      Reg_load3a: begin
        Mdatain <= 32'h00000018;
        #10 Read <= 1; MDRin <= 1;
        #10 Read <= 0; MDRin <= 0;
      end
      Reg_load3b: begin
        #10 MDRout <= 1; R1in <= 1;
        #10 MDRout <= 0; R1in <= 0; // initialize R1 with the value $18
      end





      /*ADD~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
      ADD_T0: begin Zlo_out <= 0; R1in <= 0;                 PCout <= 1; IncPC <= 1; MARin <= 1; Zin <= 1; end
      ADD_T1: begin
                    PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
                    Zlo_out <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
                    Mdatain <= 32'h28918000; 
      end
      ADD_T2: begin Zlo_out <= 0; PCin <= 0;  MDRin <= 0;     MDRout <= 1; IRin <= 1;                     end
      ADD_T3: begin MDRout <= 0; IRin <= 0;                   R2out <= 1; Yin <= 1;                       end
      ADD_T4: begin R2out <= 0; Yin <= 0;                     R3out <= 1; opcode <= 5'b00011; Zin <= 1;   end
      ADD_T5: begin R3out <= 0; Zin <= 0;                     Zlo_out <= 1; R1in <= 1;                    end
    
      /*SUB~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
      SUB_T0: begin Zlo_out <= 0; R1in <= 0;                 PCout <= 1; IncPC <= 1; MARin <= 1; Zin <= 1; end
      SUB_T1: begin
        PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
        Zlo_out <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
        Mdatain <= 32'h28918000; 
      end
      SUB_T2: begin Zlo_out <= 0; PCin <= 0;  MDRin <= 0;     MDRout <= 1; IRin <= 1;                     end
      SUB_T3: begin MDRout <= 0; IRin <= 0;                   R2out <= 1; Yin <= 1;                       end
      SUB_T4: begin R2out <= 0; Yin <= 0;                     R3out <= 1; opcode <= 5'b00100; Zin <= 1;   end
      SUB_T5: begin R3out <= 0; Zin <= 0;                     Zlo_out <= 1; R1in <= 1;                    end
    





    
      endcase
    end


endmodule
