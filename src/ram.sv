module RAM #(
    parameter data_width = 8,
    parameter size_width = 6
)(
    input clk,
    input nrst,
    input [data_width-1 : 0] write_data,
    input [size_width-1 : 0] addr,
    output [data_width-1 : 0] read_data
);

localparam data_n = 1<<size_width;

reg [data_width-1 : 0] mem_array [data_n-1 : 0];

wire [data_width-1  :0] zero = 0;

integer i;
always @(posedge clk)begin
    if(!nrst)begin
        for(i=0; i<data_n; i = i+1)
            mem_array[i] <= zero;
    end
    else begin
        mem_array[addr] <= write_data;
    end
end

assign read_data = mem_array[addr];

endmodule