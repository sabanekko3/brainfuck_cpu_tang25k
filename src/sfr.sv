module SFR(  
    input clk,
    input nrst,
    input [7:0] write_val,
    input [7:0] addr,
    input write_valid,

    output [7:0] read_val,

    output [7:0] monitor_byte,

    //io
    output pwm1h,pwm1l,pwm2h,pwm2l,pwm3h,pwm3l,

    input enc_a,
    input enc_b,
    output uart_tx
);

enum{
    NOP,
    TMR0_DIVR,
    TMR0L,
    TMR0H,
    PWM_DT,
    PWM_PERIOD,
    PWM1_DUTY,
    PWM2_DUTY,
    PWM3_DUTY,
    ENC_DIVR,
    ENC,
    SOUT
} sfr_addr;

reg [7:0] tmr0_div_ratio = 8'h0;
reg [15:0] tmr0_cnt = 16'h0;

reg [7:0] pwm_dead_time = 8'h0;
reg [7:0] pwm_period = 8'h0;
reg [7:0] pwm1_duty = 8'h0;
reg [7:0] pwm2_duty = 8'h0;
reg [7:0] pwm3_duty = 8'h0;

reg [7:0] enc_pos_bias = 8'h0;
reg [7:0] enc_division_ratio = 8'h0;
wire [7:0] enc_cnt;

wire [7:0] sfr_regs [0:SOUT] = '{8'h0,
                                tmr0_div_ratio,
                                tmr0_cnt[7:0],
                                tmr0_cnt[15:8],
                                pwm_dead_time,
                                pwm_period,
                                pwm1_duty,
                                pwm2_duty,
                                pwm3_duty,
                                enc_division_ratio,
                                enc_cnt - enc_pos_bias,
                                8'h0};

always @(posedge write_valid)begin
    case(addr)
        TMR0_DIVR:  tmr0_div_ratio     <= write_val;
        PWM_DT:     pwm_dead_time      <= write_val;
        PWM_PERIOD: pwm_period         <= write_val;
        PWM1_DUTY:  pwm1_duty          <= write_val;
        PWM2_DUTY:  pwm2_duty          <= write_val;
        PWM3_DUTY:  pwm3_duty          <= write_val;
        ENC_DIVR:   enc_division_ratio <= write_val;
        ENC:        enc_pos_bias       <= enc_cnt - write_val;
    endcase
end

assign read_val = sfr_regs[addr];

assign monitor_byte = pwm2_duty;

////////////////////////////////////////////////
//timer clock
////////////////////////////////////////////////
wire timer_clk;
ClockDivider timer_clk_divider(
    .base_clk(clk),
    .division_ratio(50),
    .divided_clk(timer_clk)
);

////////////////////////////////////////////////
//timer0
////////////////////////////////////////////////

reg [7:0] tmr0_pre_cnt = 8'h0;

always @(posedge timer_clk)begin
    if(tmr0_pre_cnt == 8'h0)begin
        tmr0_pre_cnt <= tmr0_div_ratio;
        tmr0_cnt <= tmr0_cnt +8'h1;
    end
    else begin
        tmr0_pre_cnt <= tmr0_pre_cnt -8'h1;
    end
end

////////////////////////////////////////////////
//pwm
////////////////////////////////////////////////

PWMComplement pwm1m(
    .clk(timer_clk),
    .pwm_h_enable(1'b1),
    .pwm_l_enable(1'b1),
    .period(pwm_period),
    .duty(pwm1_duty),
    .dead_time(pwm_dead_time),
    .nrst(nrst),

    .pwm_h(pwm1h),
    .pwm_l(pwm1l)
);

PWMComplement pwm2m(
    .clk(timer_clk),
    .pwm_h_enable(1'b1),
    .pwm_l_enable(1'b1),
    .period(pwm_period),
    .duty(pwm2_duty),
    .dead_time(pwm_dead_time),
    .nrst(nrst),

    .pwm_h(pwm2h),
    .pwm_l(pwm2l)
);

PWMComplement pwm3m(
    .clk(timer_clk),
    .pwm_h_enable(1'b1),
    .pwm_l_enable(1'b1),
    .period(pwm_period),
    .duty(pwm3_duty),
    .dead_time(pwm_dead_time),
    .nrst(nrst),

    .pwm_h(pwm3h),
    .pwm_l(pwm3l)
);

////////////////////////////////////////////////
//qei
////////////////////////////////////////////////

QEI qei(
    .enc_a(enc_a),
    .enc_b(enc_b),
    .division_ratio(enc_division_ratio),

    .nrst(nrst),
    
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