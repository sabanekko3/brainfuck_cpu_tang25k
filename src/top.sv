module top(
    input clk,
    input rst,

    output [6:0] sevseg_led,
    output sevseg_sel,
    output [7:0] led_array,

    output uart_tx,
    output uart_tx_sub, //G11
    output char_pushing
);

wire nrst = ~rst;


//1.read rom data
//2.decode opecode
//3.read ram data
//4.calc
//5.write ram data/set prg cnt


////////////////////////////////////////////////
//clock generate
////////////////////////////////////////////////
wire main_clk;
ClockDivider #(
    .division_ratio(50_000)
)
main_clk_divider(
    .base_clk(clk),
    .divided_clk(main_clk)
);

reg [1:0] clk_cnt = 2'b00;

always @(posedge main_clk)begin
    clk_cnt <= clk_cnt + 2'b1;
end

//wire clk0 = clk_cnt == 2'b00; //nop
wire clk1 = clk_cnt == 2'b01; //ram_read
wire clk2 = clk_cnt == 2'b10; //decode
wire clk3 = clk_cnt == 2'b11; //ram_write

////////////////////////////////////////////////
//ROM control
////////////////////////////////////////////////
wire [7:0] rom_addr;
wire [2:0] opecode;
wire finish;

ROM rom(
    .addr(rom_addr),
    .code(opecode),
    .rom_overrun(finish)
);

////////////////////////////////////////////////
//RAM control
////////////////////////////////////////////////
reg [7:0] ram_addr = 8'h0;
wire [7:0] ram_val;

wire [7:0] new_ram_addr;
wire [7:0] new_ram_val;

wire ram_write = clk2 | clk3;

always @(posedge clk3)begin
    ram_addr <= new_ram_addr;
end

Gowin_SP ram(
    .dout(ram_val), //output [7:0] dout
    .clk(clk1 | clk3), //input clk
    .oce(1'b1), //input oce
    .ce(1'b1), //input ce
    .reset(1'b0), //input reset
    .wre(ram_write), //input wre
    .ad(ram_addr), //input [7:0] ad
    .din(new_ram_val) //input [7:0] din
);

////////////////////////////////////////////////
//core
////////////////////////////////////////////////
wire cout;

BFCore core(
    .enable(~finish),
    .clk(clk2),
    .opecode(opecode),
    .ram_addr(ram_addr),
    .ram_val(ram_val),
    .next_ram_addr(new_ram_addr),
    .next_ram_val(new_ram_val),
    .cout(cout),
    .rom_addr(rom_addr)
);

////////////////////////////////////////////////
//output
////////////////////////////////////////////////
SevSegByte sevseg(
    .clk(clk),
    .byte_data(ram_val),
    .sevseg_led(sevseg_led),
    .sevseg_sel(sevseg_sel)
);

assign led_array = ~rom_addr;

wire char_data_valid = ~clk2 & cout;
SerialOut serial(
    .clk(clk),
    .nrst(nrst),
    .char(new_ram_val),
    .valid(char_data_valid),
    .uart_tx(uart_tx)
);

assign uart_tx_sub = uart_tx;
assign char_pushing = char_data_valid;


endmodule