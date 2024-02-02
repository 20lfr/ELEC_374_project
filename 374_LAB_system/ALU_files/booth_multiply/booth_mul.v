module booth_multiplier #(parameter DATA_WIDTH 32)(
    input wire clk,             //we need this for the sequential nature of booths alg
    input wire reset,           //used to start idle states, and reset done register
    input wire start,           //signal for the start of an operation, once triggered, state will be in calculating, meaning the calculation must complete before any new requests 
    input wire [DATA_WIDTH-1:0] multiplicand,
    input wire [DATA_WIDTH-1:0] multiplier,
    output reg done,            //this done register signals the ALU that this current multiplication is done
    output reg [2*DATA_WIDTH-1:0] product
);

// Define states as parameters (these are local parameters)
parameter IDLE = 2'b00, CALCULATE = 2'b01, DONE = 2'b10;
/*The reason they are not with the "DATA_WIDTH" param at the start is becuase we want these to stay as constants. Where as DATA_WIDTH can be changed*/

// Use a register to hold the current state
reg [1:0] state;




reg [DATA_WIDTH:0] A, M;//remeber this is a register with N+1 size
reg [DATA_WIDTH:0] Q; // Including Q-1 as LSB
//reg Q_minus1;
reg [5:0] count;//counts for 32 iterations


//NOTE: what does this mean? --> this block will execute when either clk or reset changes from 0 to 1 (positive clock edge)
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        done <= 0;
    end
    else begin
        case (state)

            //starting case
            IDLE: begin
                if (start) begin
                    A <= 33'b0;
                        /*  Sign bit of multiplicand, multiplicand itself*/
                    M <= {multiplicand[DATA_WIDTH-1], multiplicand}; // Sign extension
                    Q <= {multiplier, 1'b0}; // LSB set to 0
                    //Q_minus1 <= 0;
                    count <= DATA_WIDTH;
                    state <= CALCULATE;
                end
            end

            //calculating case
            CALCULATE: begin
                if (count > 0) begin
                    // Booth's algorithm step
                    case ({Q[1], Q[0]})
                        2'b01: A = A + M;
                        2'b10: A = A - M;
                        default: /*do nothing (add zero)*/;
                    endcase
                    Q = Q >> 1; //shift Q first
                    Q[DATA_WIDTH] = A[0]; //shifting LSB of A to MSB of Q
                    A = A >>> 1; //this "">>>"" means arithmatic shift (sign extending)
                    count = count - 1;//decrease counter for next iteration
                end
                else begin
                    //when count is 0, calculation is finished
                    state <= DONE;
                end
            end

            //finishing and return case
            DONE: begin
                product <= {A, Q[DATA_WIDTH:1]}; // Discard Q-1
                done <= 1;
                state <= IDLE;
            end
        endcase
    end
end

endmodule
