module PWM(
    input pwm_clk,
    input [7:0] pwm_period,
    input [7:0] pwm_duty,
    output pwm_out
);

reg[7:0] count = 8'h0;

assign pwm_out = (count >= pwm_duty) ? 1'b0 : 1'b1;

always @(posedge pwm_clk)begin
    count <= (count >= pwm_period) ? 8'h0 : (count + 1);
end

endmodule 