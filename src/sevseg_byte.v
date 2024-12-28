module SevSegByte(
    input clk,
    input [7:0] byte_data,
    output reg [6:0] sevseg_led,
    output reg sevseg_sel
);

wire disp_clk;

ClockDivider #(
    .division_ratio(5000)
)
clk_divider(
    .base_clk(clk),
    .divided_clk(disp_clk)
);

wire [6:0] sevseg_h;
wire [6:0] sevseg_l;

SevSeg sevseg_decode_h(
    .data(byte_data[7:4]),
    .display(sevseg_h)
);

SevSeg sevseg_decode_l(
    .data(byte_data[3:0]),
    .display(sevseg_l)
);

always @(posedge disp_clk)begin
    //sevseg
    sevseg_sel <= ~sevseg_sel;
    sevseg_led <= sevseg_sel ? ~sevseg_h : ~sevseg_l;
end

endmodule