module SerialOut#(
    parameter str_len = 16,
    parameter baudrate = 9600
)
(
    input clk,
    input nrst,
    input [7:0] char,
    input valid,
    output uart_tx
);

localparam tx_str_len = str_len + 3;

reg [7:0] str_cnt = 8'h0;
reg [7:0] str[0 : str_len-1];

integer i;
initial begin
    for(i = 0; i < str_len; i = i + 1)begin
        str[i] = 8'h20;
    end
end

wire [7:0] tx_str[tx_str_len-1 : 0] = {{8'h6d},
                                       {8'h3a},
                                        str,
                                        {8'h0a}};

always @(posedge valid)begin
    str[str_cnt] <= char;
    str_cnt <= str_cnt < (str_len-1) ? str_cnt + 8'h1 : 8'h0;
end


//uart 
reg [7:0] tx_cnt = 8'h0;

reg uart_tx_start;
wire uart_tx_ready;
reg [7:0] uart_tx_byte = 8'h00;

uart_tx uart_tx_m
(
	.clk(clk),
	.rst_n(nrst),
	.tx_data(uart_tx_byte),
	.tx_data_valid(uart_tx_start),
	.tx_data_ready(uart_tx_ready),
	.tx_pin(uart_tx)
);

always @(posedge clk)begin
    if(uart_tx_ready && ~uart_tx_start)begin 
        uart_tx_byte <= tx_str[tx_cnt];
        
        if(tx_cnt == 8'h0)begin
            tx_cnt <= tx_str_len-1;
        end
        else begin
            tx_cnt <= tx_cnt - 8'h1;
        end

        uart_tx_start <= 1'b1;

    end
    else if(~uart_tx_ready)begin
        uart_tx_start <= 1'b0;
    end
end

endmodule