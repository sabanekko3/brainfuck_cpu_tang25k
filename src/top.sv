module top(
    input clk,

    output [6:0] sevseg_led,
    output sevseg_sel,
    output [7:0] led_array,

    output uart_tx,
    output uart_tx_sub
);

reg rst = 1'b1;

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
localparam data_width = 8;
localparam ram_size = 64;
reg [data_width-1 : 0] ram [ram_size-1 : 0];
reg [7:0] ram_addr;

integer i;
initial begin
    //ram init
    for(i=0;i<ram_size; i = i+1)begin
        ram[i] = 8'h0;
    end
    ram_addr = 8'h0;
end

wire [7:0] next_ram_addr;
wire [7:0] next_ram_val;

always @(negedge main_clk)begin
    if(~finish)begin
        ram_addr <= next_ram_addr;
        ram[ram_addr] <= next_ram_val;
    end
end

////////////////////////////////////////////////
//core
////////////////////////////////////////////////

wire cout;
BFCore alu(
    .clk(main_clk),
    .opecode(opecode),
    .ram_addr(ram_addr),
    .ram_val(ram[ram_addr]),
    .next_ram_addr(next_ram_addr),
    .next_ram_val(next_ram_val),
    .cout(cout),
    .rom_addr(rom_addr)
);

////////////////////////////////////////////////
//output
////////////////////////////////////////////////

SevSegByte sevseg(
    .clk(clk),
    .byte_data(ram[ram_addr]),
    .sevseg_led(sevseg_led),
    .sevseg_sel(sevseg_sel)
);

assign led_array = ~rom_addr;

reg [7:0] output_char;
reg char_valid;
SerialOut serial(
    .clk(clk),
    .char(next_ram_val),
    .valid(main_clk & cout),
    .uart_tx(uart_tx)
);

assign uart_tx_sub = uart_tx;


endmodule