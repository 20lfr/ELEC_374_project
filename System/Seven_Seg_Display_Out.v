module Seven_Seg_Display_Out(
    output reg [6:0] outport, 
    input clk, 
    input wire [3:0] data
);
    always @(negedge clk) begin
        case(data[3:0])
            4'b0000 : outport <= 7'b0111111;
            4'b0001 : outport <= 7'b0000110;
            4'b0010 : outport <= 7'b1011011;
            4'b0011 : outport <= 7'b1001111;
            4'b0100 : outport <= 7'b1100110;
            4'b0101 : outport <= 7'b1101001;
            4'b0110 : outport <= 7'b1111101;
            4'b0111 : outport <= 7'b0000111;
            4'b1000 : outport <= 7'b1111111;
            4'b1001 : outport <= 7'b1100111;
            4'b1010 : outport <= 7'b1110111;
            4'b1011 : outport <= 7'b1111100;
            4'b1100 : outport <= 7'b1101001;
            4'b1101 : outport <= 7'b1011110;
            4'b1110 : outport <= 7'b1111001;
            4'b1111 : outport <= 7'b1110001;
            default : outport <= 7'b0000000;
        endcase

    end 

endmodule