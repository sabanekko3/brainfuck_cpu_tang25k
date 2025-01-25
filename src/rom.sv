//decoded from timer0_test.bf

module ROM (
    input [9:0] addr,
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
`define IN  3'b000 //,

localparam len = 35;

always_comb begin
    case(addr)
        10'h000:code <= `MOVR;
        10'h001:code <= `OUT;
        10'h002:code <= `MOVR;
        10'h003:code <= `MOVR;
        10'h004:code <= `MOVR;
        10'h005:code <= `MOVR;
        10'h006:code <= `INC;
        10'h007:code <= `INC;
        10'h008:code <= `OUT;
        10'h009:code <= `IF;
        10'h00a:code <= `MOVL;
        10'h00b:code <= `MOVL;
        10'h00c:code <= `IN;
        10'h00d:code <= `IF;
        10'h00e:code <= `IN;
        10'h00f:code <= `BACK;
        10'h010:code <= `MOVR;
        10'h011:code <= `MOVR;
        10'h012:code <= `MOVR;
        10'h013:code <= `INC;
        10'h014:code <= `OUT;
        10'h015:code <= `MOVL;
        10'h016:code <= `MOVL;
        10'h017:code <= `MOVL;
        10'h018:code <= `IN;
        10'h019:code <= `IF;
        10'h01a:code <= `IN;
        10'h01b:code <= `BACK;
        10'h01c:code <= `MOVR;
        10'h01d:code <= `MOVR;
        10'h01e:code <= `MOVR;
        10'h01f:code <= `DEC;
        10'h020:code <= `OUT;
        10'h021:code <= `MOVL;
        10'h022:code <= `BACK;
        default:code <=  `INC;
    endcase
end

assign rom_overrun =  addr < len ? 1'h0 : 1'h1;

endmodule
