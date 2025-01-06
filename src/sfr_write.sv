module SFR(  
    input clk,
    input nrst,
    input [7:0] val,
    input [7:0] addr,
    input valid,

    output pwm1_out,
    output uart_tx
);


enum{
    PWM1_PERIOD,
    PWM1_DUTY,
    SOUT
} sfr_addr;


reg [2:0] reg_select = 3'h0;

always_comb begin
    if(addr < SOUT)
        reg_select <= 3'b1 << addr;
    else
        reg_select <= 3'b1 << 2;
end

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

reg [7:0] pwm1_period;
always @(posedge reg_select[PWM1_PERIOD] & valid)
    pwm1_period <= val;

reg [7:0] pwm1_duty;
always @(posedge reg_select[PWM1_DUTY] & valid)
    pwm1_duty <= val;

PWMGenerator pwm1(
    .pwm_clk(pwm_clk),
    .pwm_period(pwm1_period),
    .pwm_duty(pwm1_duty),
    .pwm_out(pwm1_out)
);


////////////////////////////////////////////////
//serial
////////////////////////////////////////////////

wire char_data_valid = reg_select[SOUT] & valid;
SerialOut serial(
    .clk(clk),
    .nrst(nrst),
    .char(val),
    .valid(char_data_valid),
    .uart_tx(uart_tx)
);

endmodule