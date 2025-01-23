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

localparam len = 37;

always_comb begin
    case(addr)
        10'h000:code <= `MOVR;
        10'h001:code <= `MOVR;
        10'h002:code <= `MOVR;
        10'h003:code <= `MOVR;
        10'h004:code <= `INC;
        10'h005:code <= `INC;
        10'h006:code <= `OUT;
        10'h007:code <= `IF;
        10'h008:code <= `MOVL;
        10'h009:code <= `MOVL;
        10'h00a:code <= `MOVL;
        10'h00b:code <= `IN;
        10'h00c:code <= `IF;
        10'h00d:code <= `IN;
        10'h00e:code <= `BACK;
        10'h00f:code <= `MOVR;
        10'h010:code <= `MOVR;
        10'h011:code <= `MOVR;
        10'h012:code <= `MOVR;
        10'h013:code <= `INC;
        10'h014:code <= `OUT;
        10'h015:code <= `MOVL;
        10'h016:code <= `MOVL;
        10'h017:code <= `MOVL;
        10'h018:code <= `MOVL;
        10'h019:code <= `IN;
        10'h01a:code <= `IF;
        10'h01b:code <= `IN;
        10'h01c:code <= `BACK;
        10'h01d:code <= `MOVR;
        10'h01e:code <= `MOVR;
        10'h01f:code <= `MOVR;
        10'h020:code <= `MOVR;
        10'h021:code <= `DEC;
        10'h022:code <= `OUT;
        10'h023:code <= `MOVL;
        10'h024:code <= `BACK;
        default:code <=  `INC;
    endcase
end

assign rom_overrun =  addr < len ? 1'h0 : 1'h1;

endmodule
