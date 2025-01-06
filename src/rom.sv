module ROM (
    input [7:0] addr,
    output reg [2:0] code,
    output rom_overrun
);
`define INC  3'b111 //+
`define DEC  3'b110 //-
`define MOVR 3'b101 //>
`define MOVL 3'b100 //<
`define IF   3'b011 //[
`define BACK 3'b010 //]
`define OUT  3'b001 //.
`define NOP  3'b000 //,

localparam len = 18;

always_comb begin
    case(addr)
        8'h00:code <= `INC;
        8'h01:code <= `INC;
        8'h02:code <= `IF;
        8'h03:code <= `MOVR;
        8'h04:code <= `INC;
        8'h05:code <= `INC;
        8'h06:code <= `IF;
        8'h07:code <= `MOVR;
        8'h08:code <= `INC;
        8'h09:code <= `INC;
        8'h0a:code <= `MOVL;
        8'h0b:code <= `DEC;
        8'h0c:code <= `BACK;
        8'h0d:code <= `MOVL;
        8'h0e:code <= `DEC;
        8'h0f:code <= `BACK;
        8'h10:code <= `MOVR;
        8'h11:code <= `MOVR;
        default:code <=  `INC;
    endcase
end

assign rom_overrun =  addr < len ? 1'h0 : 1'h1;

endmodule
