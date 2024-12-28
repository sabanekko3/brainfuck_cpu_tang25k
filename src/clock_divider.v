module ClockDivider#(
    parameter division_ratio = 1,
    parameter ratio_bit = 32
)
(
    input base_clk,
    output reg divided_clk
);

reg [ratio_bit-1 : 0] counter = 0;

always@(posedge base_clk)begin
    if(counter == 0)begin
        counter <= division_ratio;
        divided_clk <= ~divided_clk;
    end

    else begin
        counter <= counter - 1;
    end
end

endmodule