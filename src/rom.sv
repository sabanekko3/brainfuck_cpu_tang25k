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

localparam len = 124;

always_comb begin
    case(addr)
        8'h00:code <= `DEC;
        8'h01:code <= `DEC;
        8'h02:code <= `IF;
        8'h03:code <= `DEC;
        8'h04:code <= `DEC;
        8'h05:code <= `DEC;
        8'h06:code <= `DEC;
        8'h07:code <= `DEC;
        8'h08:code <= `MOVR;
        8'h09:code <= `INC;
        8'h0a:code <= `MOVL;
        8'h0b:code <= `BACK;
        8'h0c:code <= `MOVR;
        8'h0d:code <= `DEC;
        8'h0e:code <= `DEC;
        8'h0f:code <= `DEC;
        8'h10:code <= `DEC;
        8'h11:code <= `OUT;
        8'h12:code <= `IF;
        8'h13:code <= `DEC;
        8'h14:code <= `DEC;
        8'h15:code <= `DEC;
        8'h16:code <= `MOVR;
        8'h17:code <= `INC;
        8'h18:code <= `MOVL;
        8'h19:code <= `BACK;
        8'h1a:code <= `MOVR;
        8'h1b:code <= `DEC;
        8'h1c:code <= `DEC;
        8'h1d:code <= `DEC;
        8'h1e:code <= `DEC;
        8'h1f:code <= `OUT;
        8'h20:code <= `INC;
        8'h21:code <= `INC;
        8'h22:code <= `INC;
        8'h23:code <= `IF;
        8'h24:code <= `DEC;
        8'h25:code <= `MOVR;
        8'h26:code <= `INC;
        8'h27:code <= `INC;
        8'h28:code <= `INC;
        8'h29:code <= `MOVL;
        8'h2a:code <= `BACK;
        8'h2b:code <= `MOVR;
        8'h2c:code <= `INC;
        8'h2d:code <= `INC;
        8'h2e:code <= `OUT;
        8'h2f:code <= `INC;
        8'h30:code <= `INC;
        8'h31:code <= `INC;
        8'h32:code <= `INC;
        8'h33:code <= `INC;
        8'h34:code <= `INC;
        8'h35:code <= `INC;
        8'h36:code <= `INC;
        8'h37:code <= `OUT;
        8'h38:code <= `INC;
        8'h39:code <= `INC;
        8'h3a:code <= `INC;
        8'h3b:code <= `INC;
        8'h3c:code <= `INC;
        8'h3d:code <= `OUT;
        8'h3e:code <= `DEC;
        8'h3f:code <= `IF;
        8'h40:code <= `DEC;
        8'h41:code <= `MOVR;
        8'h42:code <= `INC;
        8'h43:code <= `INC;
        8'h44:code <= `INC;
        8'h45:code <= `MOVL;
        8'h46:code <= `BACK;
        8'h47:code <= `MOVR;
        8'h48:code <= `DEC;
        8'h49:code <= `OUT;
        8'h4a:code <= `MOVR;
        8'h4b:code <= `DEC;
        8'h4c:code <= `IF;
        8'h4d:code <= `DEC;
        8'h4e:code <= `DEC;
        8'h4f:code <= `DEC;
        8'h50:code <= `MOVR;
        8'h51:code <= `INC;
        8'h52:code <= `MOVL;
        8'h53:code <= `BACK;
        8'h54:code <= `MOVR;
        8'h55:code <= `OUT;
        8'h56:code <= `DEC;
        8'h57:code <= `IF;
        8'h58:code <= `DEC;
        8'h59:code <= `DEC;
        8'h5a:code <= `DEC;
        8'h5b:code <= `DEC;
        8'h5c:code <= `DEC;
        8'h5d:code <= `MOVR;
        8'h5e:code <= `INC;
        8'h5f:code <= `MOVL;
        8'h60:code <= `BACK;
        8'h61:code <= `MOVR;
        8'h62:code <= `DEC;
        8'h63:code <= `OUT;
        8'h64:code <= `INC;
        8'h65:code <= `INC;
        8'h66:code <= `INC;
        8'h67:code <= `INC;
        8'h68:code <= `INC;
        8'h69:code <= `INC;
        8'h6a:code <= `INC;
        8'h6b:code <= `INC;
        8'h6c:code <= `OUT;
        8'h6d:code <= `DEC;
        8'h6e:code <= `IF;
        8'h6f:code <= `DEC;
        8'h70:code <= `DEC;
        8'h71:code <= `MOVR;
        8'h72:code <= `INC;
        8'h73:code <= `MOVL;
        8'h74:code <= `BACK;
        8'h75:code <= `MOVR;
        8'h76:code <= `DEC;
        8'h77:code <= `DEC;
        8'h78:code <= `DEC;
        8'h79:code <= `DEC;
        8'h7a:code <= `OUT;
        8'h7b:code <= `OUT;
        default:code <=  `INC;
    endcase
end

assign rom_overrun =  addr < len ? 1'h0 : 1'h1;

endmodule
