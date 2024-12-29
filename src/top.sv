module top(
    input clk,

    output [6:0] sevseg_led,
    output sevseg_sel,
    output [7:0] led_array,

    output uart_tx,
    output uart_tx_sub
);

reg nrst = 1'b1;
reg rst_flag = 1'b0;
always @(posedge clk)begin
    if(!rst_flag)begin
        nrst <= 1'b0;
        rst_flag <= 1'b1;
    end 
    else
        nrst <= 1'b1;
end

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
reg [7:0] ram_addr = 8'h0;
wire [7:0] ram_val;

wire [7:0] new_ram_addr;
wire [7:0] new_ram_val;

RAM#(
    .data_width(8),
    .size_width(6)
)ram(
    .clk(~main_clk),
    .nrst(nrst),
    .write_data(new_ram_val),
    .addr(ram_addr),
    .read_data(ram_val)
);

always @(negedge main_clk)begin
    if(~finish)begin
        ram_addr <= new_ram_addr;
    end
end

////////////////////////////////////////////////
//core
////////////////////////////////////////////////
wire cout;

BFCore core(
    .clk(main_clk),
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

SerialOut serial(
    .clk(clk),
    .nrst(nrst),
    .char(new_ram_val),
    .valid(main_clk & cout),
    .uart_tx(uart_tx)
);

assign uart_tx_sub = uart_tx;

endmodule