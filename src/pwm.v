module PWMComplement#(
    parameter counter_bit_width = 8
)
(
    input clk,
    input pwm_h_enable,
    input pwm_l_enable,
    input [counter_bit_width -1 :0] period,
    input [counter_bit_width -1 :0] duty,
    input [counter_bit_width -1 :0] dead_time,
    input nrst,

    output reg pwm_h,
    output reg pwm_l
);

//counter control
reg[counter_bit_width -1 :0] count = 0;
reg count_direction = 1'b0;

always @(posedge clk)begin
    if(nrst)begin
        if(~count_direction)begin //count up
            if(count >= period)begin
                count_direction = 1'b1;
                count <= count -1;
            end else begin
                count <= count +1;
            end
        end else begin //count down
            if(count == 0)begin
                count_direction = 1'b0;
                count <= count + 1;
            end else begin 
                count <= count -1;
            end
        end
    end else begin
        count <= 0;
        count_direction <= 1'b0;
    end
end

//pwm generation
wire pwm_h_f = ((count >= duty) ? 1'b0 : 1'b1) & pwm_h_enable;
wire pwm_l_f = ((count < duty) ? 1'b0 : 1'b1) & pwm_l_enable;

//dead time generation by ON delay
reg [counter_bit_width-1 :0] dead_time_count_h = 0;
reg [counter_bit_width-1 :0] dead_time_count_l = 0;
always @(posedge clk)begin
    if(nrst)begin
        if(pwm_h_f)begin
            if(dead_time_count_h == dead_time)begin
                pwm_h <= 1'h1;
            end else begin
                dead_time_count_h <= dead_time_count_h + 1;
                pwm_h <= 1'h0;
            end
        end else begin
            dead_time_count_h <= 0;
            pwm_h <= 1'h0;
        end

        if(pwm_l_f)begin
            if(dead_time_count_l == dead_time)begin
                pwm_l <= 1'h1;
            end else begin
                dead_time_count_l <= dead_time_count_l + 1;
                pwm_h <= 1'h0;
            end
        end else begin
            dead_time_count_l <= 0;
            pwm_l <= 1'h0;
        end
    end else begin
        dead_time_count_h <= 0;
        dead_time_count_l <= 0;
    end
end

endmodule 