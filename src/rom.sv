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

localparam len = 65;

always_comb begin
    case(addr)
        8'h00:code <= `INC;
        8'h01:code <= `INC;
        8'h02:code <= `INC;
        8'h03:code <= `INC;
        8'h04:code <= `INC;
        8'h05:code <= `INC;
        8'h06:code <= `INC;
        8'h07:code <= `INC;
        8'h08:code <= `INC;
        8'h09:code <= `INC;
        8'h0a:code <= `INC;
        8'h0b:code <= `INC;
        8'h0c:code <= `INC;
        8'h0d:code <= `INC;
        8'h0e:code <= `INC;
        8'h0f:code <= `INC;
        8'h10:code <= `INC;
        8'h11:code <= `INC;
        8'h12:code <= `INC;
        8'h13:code <= `INC;
        8'h14:code <= `INC;
        8'h15:code <= `OUT;
        8'h16:code <= `MOVR;
        8'h17:code <= `MOVR;
        8'h18:code <= `INC;
        8'h19:code <= `IF;
        8'h1a:code <= `MOVR;
        8'h1b:code <= `INC;
        8'h1c:code <= `INC;
        8'h1d:code <= `INC;
        8'h1e:code <= `INC;
        8'h1f:code <= `INC;
        8'h20:code <= `INC;
        8'h21:code <= `INC;
        8'h22:code <= `INC;
        8'h23:code <= `INC;
        8'h24:code <= `INC;
        8'h25:code <= `INC;
        8'h26:code <= `INC;
        8'h27:code <= `INC;
        8'h28:code <= `INC;
        8'h29:code <= `INC;
        8'h2a:code <= `INC;
        8'h2b:code <= `INC;
        8'h2c:code <= `INC;
        8'h2d:code <= `INC;
        8'h2e:code <= `INC;
        8'h2f:code <= `INC;
        8'h30:code <= `IF;
        8'h31:code <= `MOVL;
        8'h32:code <= `MOVL;
        8'h33:code <= `INC;
        8'h34:code <= `OUT;
        8'h35:code <= `MOVR;
        8'h36:code <= `MOVR;
        8'h37:code <= `DEC;
        8'h38:code <= `BACK;
        8'h39:code <= `MOVL;
        8'h3a:code <= `MOVL;
        8'h3b:code <= `IF;
        8'h3c:code <= `DEC;
        8'h3d:code <= `OUT;
        8'h3e:code <= `BACK;
        8'h3f:code <= `MOVR;
        8'h40:code <= `BACK;
        default:code <=  `INC;
    endcase
end

assign rom_overrun =  addr < len ? 1'h0 : 1'h1;

endmodule
