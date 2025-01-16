module QEI#(
    parameter bit_width = 8
)
(
    input enc_a,
    input enc_b,
    output reg [bit_width-1 :0] count
);

function [1:0] signal_conv(input [1:0] in);
    case(in)
        2'b11:   signal_conv = 2'b10;
        2'b10:   signal_conv = 2'b11;
        default: signal_conv = in;
    endcase
endfunction

wire [1:0] enc_state = signal_conv({enc_b,enc_a});
reg [1:0] prev_state = 0;

wire enc_is_moving = enc_state != prev_state;

always @(posedge enc_is_moving)begin
    count = count + bit_width'(signed'(2'(enc_state - prev_state)));
    prev_state = enc_state;
end

endmodule