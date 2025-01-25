module ClockDivider#(
    parameter BIT_WIDTH = 32
)
(
    input base_clk,
    input [BIT_WIDTH-1 :0] division_ratio,
    output reg divided_clk
);

reg [BIT_WIDTH-1 : 0] counter = 0;

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