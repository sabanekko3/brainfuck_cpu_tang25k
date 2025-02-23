module top(
    input clk,
    input rst,

    output pwm1h,pwm1l,pwm2h,pwm2l,pwm3h,pwm3l,
    input enc_a,enc_b,

    output [7:0] led_array,

    output uart_tx,
    output uart_tx_sub //G11
);

wire nrst = ~rst;

////////////////////////////////////////////////
//clock generate
////////////////////////////////////////////////
wire main_clk;
ClockDivider main_clk_divider(
    .base_clk(clk),
    .division_ratio(100),
    .divided_clk(main_clk)
);

reg [2:0] clk_array = 3'b001;

always @(posedge main_clk)begin
    clk_array <= {clk_array[1:0],clk_array[2]};
end

wire clk1 = clk_array[0]&~main_clk; //ram_read
wire clk2 = clk_array[1]&~main_clk; //decode
wire clk3 = clk_array[2]&~main_clk; //ram_write

////////////////////////////////////////////////
//wires
////////////////////////////////////////////////

wire [9:0] rom_addr;
wire [2:0] opecode;
wire finish;

reg [7:0] ram_addr = 8'h0;
wire [7:0] ram_val;

wire [7:0] new_ram_addr;
wire [7:0] new_ram_val;

wire [7:0] sfr_read_val;

reg  ram_write = 1'b0;
wire dout;
wire din;

////////////////////////////////////////////////
//ROM control
////////////////////////////////////////////////

ROM rom(
    .addr(rom_addr),
    .code(opecode),
    .rom_overrun(finish)
);

////////////////////////////////////////////////
//RAM control
////////////////////////////////////////////////
always @(posedge clk2, negedge clk3)begin
    if(clk2)
        ram_write <= 1'b1;
    else
        ram_write <= 1'b0;
end

always @(posedge clk3)begin
    ram_addr <= new_ram_addr;
end

wire ram_clk = clk1 | clk3;
Gowin_SP ram(
    .dout(ram_val), //output [7:0] dout
    .clk(ram_clk), //input clk
    .oce(1'b1), //input oce
    .ce(1'b1), //input ce
    .reset(1'b0), //input reset
    .wre(ram_write), //input wre
    .ad(ram_addr), //input [7:0] ad
    .din(din ? sfr_read_val : new_ram_val) //input [7:0] din
);

////////////////////////////////////////////////
//core
////////////////////////////////////////////////
BFCore core(
    .enable(~finish),
    .clk(clk2),
    .opecode(opecode),
    .ram_addr(ram_addr),
    .ram_val(ram_val),
    .next_ram_addr(new_ram_addr),
    .next_ram_val(new_ram_val),
    .dout(dout),
    .din(din),
    .rom_addr(rom_addr)
);

////////////////////////////////////////////////
//output
////////////////////////////////////////////////
wire [7:0] sfr_monitor;
assign led_array = ~sfr_monitor;

wire sfr_write = clk3 & dout;
SFR sfr(
    .clk(clk),
    .nrst(nrst),
    .write_val(new_ram_val),
    .addr(ram_addr),
    .write_valid(sfr_write),
    .read_val(sfr_read_val),

    .monitor_byte(sfr_monitor),

    //io
    .*
);

assign uart_tx_sub = uart_tx;
assign char_pushing = 0;//sfr_write;


endmodule