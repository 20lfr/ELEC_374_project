`timescale 1ns/10ps

module SystemTestBench;

    // Test bench parameters
    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 9;

    // Inputs
    reg Clock;
    reg reset;
    reg stop;
    reg [DATA_WIDTH-1:0] inport_data;

    // Outputs
    //wire [DATA_WIDTH-1:0] outport_data;
    wire [6:0] seg_display_upper, seg_display_lower;
    wire run;


    // Instantiate the Unit Under Test (UUT)
    System #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) uut (
        .Clock(Clock), 
        .reset(reset), 
        .stop(stop),
        .run(run),
        .inport_data(inport_data), 
        .seg_display_upper(seg_display_upper), 
        .seg_display_lower(seg_display_lower)
    );
    parameter   reset_state = 1'd0, INS1_T0 = 1'd1;
    reg         Present_state = reset_state;

  /*Clock generation*/
    initial begin
        Clock = 0;
        forever #10 Clock = ~Clock; // Toggle clock every 10 ns
    end
     always @(posedge Clock) // finite state machine; if clock rising-edge
        begin
            case (Present_state)
                reset_state : Present_state = INS1_T0;//INIT STATE
                
                //INS1
                INS1_T0: Present_state = INS1_T0;
              
            endcase

        end
    always @(Present_state) begin

      case(Present_state)
          reset_state : begin
            stop <= 0; inport_data <=32'd11;
            reset <= 1;

            #20 reset <= 0; //now we read from memory starting at PC <= 0;

            #40 inport_data <= 32'h80;

          end 
          INS1_T0 : begin end
      endcase 
      
    end 

endmodule
