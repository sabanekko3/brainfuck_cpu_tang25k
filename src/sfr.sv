module SFR(  
    input clk,
    input nrst,
    input [7:0] write_val,
    input [7:0] addr,
    input write_valid,

    output [7:0] read_val,

    //io
    output pwm1_out,
    output pwm2_out,
    output pwm3_out,
    input enc_a,
    input enc_b,
    output uart_tx
);

enum{
    NOP,
    PWM_PERIOD,
    PWM1_DUTY,
    PWM2_DUTY,
    PWM3_DUTY,
    ENC,
    SOUT
} sfr_addr;

reg [7:0] pwm_period = 8'h0;
reg [7:0] pwm1_duty = 8'h0;
reg [7:0] pwm2_duty = 8'h0;
reg [7:0] pwm3_duty = 8'h0;
wire [7:0] enc_cnt;

wire [7:0] sfr_regs [0:SOUT] = '{8'h0, pwm_period, pwm1_duty, pwm2_duty, pwm3_duty, enc_cnt, 8'h0};

always @(posedge write_valid)begin
    case(addr)
        PWM_PERIOD: pwm_period <= write_val;
        PWM1_DUTY: pwm1_duty <= write_val;
        PWM2_DUTY: pwm2_duty <= write_val;
        PWM3_DUTY: pwm3_duty <= write_val;
    endcase
end

assign read_val = sfr_regs[addr];

////////////////////////////////////////////////
//pwm
////////////////////////////////////////////////
wire pwm_clk;
ClockDivider #(
    .division_ratio(100)
)
pwm_clk_divider(
    .base_clk(clk),
    .divided_clk(pwm_clk)
);


PWMGenerator pwm(
    .pwm_clk(pwm_clk),
    .pwm_period(pwm_period),
    .pwm_duty(pwm1_duty),
    .pwm_out(pwm1_out)
);
PWMGenerator pwm2(
    .pwm_clk(pwm_clk),
    .pwm_period(pwm_period),
    .pwm_duty(pwm2_duty),
    .pwm_out(pwm2_out)
);
PWMGenerator pwm1(
    .pwm_clk(pwm_clk),
    .pwm_period(pwm_period),
    .pwm_duty(pwm3_duty),
    .pwm_out(pwm3_out)
);

////////////////////////////////////////////////
//qei
////////////////////////////////////////////////
QEI qei(
    .enc_a(enc_a),
    .enc_b(enc_b),
    .count(enc_cnt)
);

////////////////////////////////////////////////
//serial
////////////////////////////////////////////////

wire char_data_valid = (addr>=SOUT) & write_valid;
SerialOut serial(
    .clk(clk),
    .nrst(nrst),
    .char(write_val),
    .valid(char_data_valid),
    .uart_tx(uart_tx)
);

endmodule