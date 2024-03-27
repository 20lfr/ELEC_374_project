`timescale 1ns/10ps

module SystemTestBench;

    // Test bench parameters
    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 9;

    // Inputs
    reg Clock;
    reg clear;
    reg reset;
    reg stop;
    reg [DATA_WIDTH-1:0] inport_data;

    // Outputs
    wire [DATA_WIDTH-1:0] outport_data;

    // Instantiate the Unit Under Test (UUT)
    System #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) uut (
        .Clock(Clock), 
        .clear(clear), 
        .reset(reset), 
        .stop(stop),
        .inport_data(inport_data), 
        .outport_data(outport_data)
    );


    parameter Default = 6'd0, Mem_load_instruction1 = 6'd1, Mem_load_instruction2 = 6'd2, 
              Mem_load_data1 = 6'd3, Mem_load_data2 = 6'd4;

    reg [5:0] Present_state = Default;



    /*Clock generation*/
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

          endcase
      end


  always @(Present_state) begin
    case (Present_state) // assert the required signals in each clock cycle
      Default: begin
        
        clear <= 0; stop <= 0; 
        inport_data <=32'd0; outport_in <=0; inport_data_ready <=0; 

        reset <=1;

        #20 reset <= 0;   

      end



    endcase
  end 

endmodule
