module QEI#(
    parameter BIT_WIDTH = 8
)
(
    input enc_a,
    input enc_b,
    input nrst,
    input [BIT_WIDTH-1 :0] division_ratio,
    output reg [BIT_WIDTH-1 :0] count
);

function [1:0] signal_conv(input [1:0] in);
    case(in)
        2'b11:   signal_conv = 2'b10;
        2'b10:   signal_conv = 2'b11;
        default: signal_conv = in;
    endcase
endfunction

wire [1:0] enc_state = signal_conv({enc_b,enc_a});
reg [1:0] prev_state = 2'b0;

wire enc_is_moving = enc_state != prev_state;

reg [BIT_WIDTH-1 :0] pre_counter = 0;

always_ff @(posedge enc_is_moving,negedge nrst)begin
    if(~nrst)begin
        pre_counter <= 0;
        count <= 0;
        prev_state <= 2'h0;
    end
    else begin
        if((enc_state - prev_state) == 2'b01)begin //inc
            if(pre_counter == division_ratio)begin
                count <= count +1;
                pre_counter <= 0;
            end
            else begin
                pre_counter <= pre_counter +1;
            end
        end
        else if((enc_state - prev_state) == 2'b11) begin
            if(pre_counter == 0)begin
                count <= count -1;
                pre_counter <= division_ratio;
            end
            else begin
                pre_counter <= pre_counter -1;
            end
        end

        prev_state <= enc_state;
    end
end

endmodule