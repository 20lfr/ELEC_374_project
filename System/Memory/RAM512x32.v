module RAM512x32  #(parameter DATA_WIDTH = 32,
                                ADDR_WIDTH = 9,
                                INIT = 32'd0)
(
    input wire read, write, enable,
    input wire [(ADDR_WIDTH-1):0] address,
    input wire [(DATA_WIDTH-1):0] data_in,
    output reg [(DATA_WIDTH-1):0] data_out,
    output reg done
);

    // Memory array with synthesis attribute for initialization
    //(* ram_init_file = "Memory/phase_4.mif" *)
    reg [DATA_WIDTH-1:0] FullMemorySpace[(2**ADDR_WIDTH)-1:0];

    initial begin
        done = 0;

        $readmemh("Memory_lab_phase4.hex", FullMemorySpace, 0, 511);

    end

    always @(posedge enable) begin
        if(enable) begin
            if(read) begin
                data_out <= FullMemorySpace[address];
                done <= 1;
            end else if(write) begin
                FullMemorySpace[address] <= data_in;
                done <= 1;
            end
        end else begin
            data_out <= INIT;
            done <= 0;
        end
    end
endmodule
