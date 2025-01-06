module PWMGenerator#(
    parameter counter_bit = 32
)
(
    input pwm_clk,
    input [counter_bit -1 :0] pwm_period,
    input [counter_bit -1 :0] pwm_duty,
    output pwm_out
);

reg[counter_bit -1 :0] count = 8'h0;

assign pwm_out = (count >= pwm_duty) ? 1'b0 : 1'b1;

always @(posedge pwm_clk)begin
    count <= (count >= pwm_period) ? 0 : (count + 1);
end

endmodule 