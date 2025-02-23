module BFCore#(
    parameter ram_addr_width = 8,
    parameter data_bit_width = 8,
    parameter rom_addr_width = 10
)
(
    input enable,
    input clk,
    input [2:0] opecode,
    input [ram_addr_width-1 : 0] ram_addr,
    input [data_bit_width-1 : 0] ram_val,
    output reg [ram_addr_width-1 : 0] next_ram_addr,
    output reg [data_bit_width-1 : 0] next_ram_val,
    output reg dout,
    output reg din,
    output [rom_addr_width-1 : 0] rom_addr
);

`define INC  3'b111 //+
`define DEC  3'b110 //-
`define MOVR 3'b101 //>
`define MOVL 3'b100 //<
`define IF   3'b011 //[
`define BACK 3'b010 //]
`define OUT  3'b001 //.
`define IN   3'b000 //,

localparam prg_cnt_depth = 8;
reg [7:0] prg_cnt_sel;
reg [rom_addr_width-1 : 0] prg_cnt [prg_cnt_depth-1 : 0];

integer i;
initial begin
    prg_cnt_sel = 8'h0;
    for(i = 0; i < prg_cnt_depth; i = i+1)
        prg_cnt[i] = 0;
end

assign rom_addr = prg_cnt[prg_cnt_sel];

reg jumping = 1'h0;
reg [7:0] nest_count = 8'h0;
always@(posedge clk) begin
    if(enable)begin
        if(jumping)begin
            if(opecode == `IF)begin
                nest_count = nest_count + 8'h1;
            end
            else if(opecode == `BACK)begin
                nest_count = nest_count - 8'h1;
            end
            
            if(nest_count == 8'hFF)begin
                jumping = 1'b0;
                nest_count = 8'h0;
            end

            prg_cnt[prg_cnt_sel] <= prg_cnt[prg_cnt_sel] + 10'h1;
        end else begin
            case(opecode)
                `INC : begin
                    next_ram_addr <= ram_addr;
                    next_ram_val <= ram_val + 1;
                    dout <= 1'b0;
                    din <= 1'b0;
                    prg_cnt[prg_cnt_sel] <= prg_cnt[prg_cnt_sel] + 1;
                end

                `DEC : begin
                    next_ram_addr <= ram_addr;
                    next_ram_val <= ram_val - 1;
                    dout <= 1'b0;
                    din <= 1'b0;
                    prg_cnt[prg_cnt_sel] <= prg_cnt[prg_cnt_sel] + 1;
                end

                `MOVR : begin
                    next_ram_addr <= ram_addr + 1;
                    next_ram_val <= ram_val;
                    dout <= 1'b0;
                    din <= 1'b0;
                    prg_cnt[prg_cnt_sel] <= prg_cnt[prg_cnt_sel] + 1;
                end
                
                `MOVL : begin
                    next_ram_addr <= ram_addr - 1;
                    next_ram_val <= ram_val;
                    dout <= 1'b0;
                    din <= 1'b0;
                    prg_cnt[prg_cnt_sel] <= prg_cnt[prg_cnt_sel] + 10'h1;
                end

                `IF : begin
                    if(ram_val == 8'h0)begin
                        jumping = 1'h1;
                        prg_cnt[prg_cnt_sel] <= prg_cnt[prg_cnt_sel] + 1;
                    end else begin
                        prg_cnt_sel <= prg_cnt_sel + 8'h1;
                        prg_cnt[prg_cnt_sel + 8'h1] <= prg_cnt[prg_cnt_sel] + 1;
                    end

                    next_ram_addr <= ram_addr;
                    next_ram_val <= ram_val;
                    dout <= 1'b0;
                    din <= 1'b0;
                end

                `BACK : begin
                    if(ram_val == 8'h0)begin
                        prg_cnt[prg_cnt_sel - 8'h1] <= prg_cnt[prg_cnt_sel] + 1;
                    end

                    prg_cnt_sel <= prg_cnt_sel - 8'h1;

                    next_ram_addr <= ram_addr;
                    next_ram_val <= ram_val;
                    dout <= 1'b0;
                    din <= 1'b0;
                end

                `OUT : begin
                    next_ram_addr <= ram_addr;
                    next_ram_val <= ram_val;
                    dout <= 1'b1;
                    din <= 1'b0;
                    prg_cnt[prg_cnt_sel] <= prg_cnt[prg_cnt_sel] + 1;
                end
                
                `IN : begin
                    next_ram_addr <= ram_addr;
                    next_ram_val <= ram_val;
                    dout <= 1'b0;
                    din <= 1'b1;
                    prg_cnt[prg_cnt_sel] <= prg_cnt[prg_cnt_sel] + 1;
                end
            endcase
        end
    end else begin
        next_ram_addr <= ram_addr;
        next_ram_val <= ram_val;
        dout <= 1'b0;
        din <= 1'b0;
    end
end

endmodule